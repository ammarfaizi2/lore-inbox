Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSCONwZ>; Fri, 15 Mar 2002 08:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292373AbSCONwP>; Fri, 15 Mar 2002 08:52:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33929 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292339AbSCONwN>;
	Fri, 15 Mar 2002 08:52:13 -0500
Date: Fri, 15 Mar 2002 08:52:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc_pid_make_inode() fix
Message-ID: <Pine.GSO.4.21.0203150843400.2253-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In case if proc_pid_make_inode() steps on exiting task we do
iput() and return NULL.  Unfortunately, in that case inode->i_ino
doesn't look like inumber of a per-process inode and we take the
wrong path in proc_delete_inode().  I.e. do dput(PDE(inode)).  Which
is left uninitialized...

	We used to get out with that almost by accident - that code
worked only because we had zeroed out one field of union and that
guaranteed that another field would be NULL.  It worked, but broke
at the first occasion.

	Fix:

--- linux/fs/proc/base.c	Tue Feb 19 22:33:04 2002
+++ linux/fs/proc/base.c.fix	Fri Mar 15 08:42:19 2002
@@ -730,6 +730,7 @@
 	return inode;
 
 out_unlock:
+	ei->pde = NULL;
 	iput(inode);
 	return NULL;
 }

