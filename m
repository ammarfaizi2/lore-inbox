Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTARX0A>; Sat, 18 Jan 2003 18:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTARX0A>; Sat, 18 Jan 2003 18:26:00 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:61141 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S265174AbTARXZ6>;
	Sat, 18 Jan 2003 18:25:58 -0500
Date: Sun, 19 Jan 2003 00:34:59 +0100
From: Eric Lammerts <eric@lammerts.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] allow rename to "--bind"-mounted filesystem 
Message-ID: <20030118233459.GA18011@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I just discovered that rename(2) does not allow you to rename a file within
the same filesystem if there is a "--bind" in the way. For example:

# mkdir mydir
# mount --bind . mydir
# touch myfile
# strace -erename perl -e 'rename "myfile", "mydir/myfile2"'
rename("myfile", "mydir/myfile2") = -1 EXDEV (Invalid cross-device link)

IMHO it should be possible to do a rename in this situation.

I propose to remove the check in do_rename() altogether. It shouldn't be
necessary, since there's also a check for a cross-device rename in
vfs_rename_dir() and vfs_rename_other().

Patch below has been tested.

Eric


--- linux-2.4.21-pre3/fs/namei.c.orig	2003-01-18 23:56:46.000000000 +0100
+++ linux-2.4.21-pre3/fs/namei.c	2003-01-18 23:57:30.000000000 +0100
@@ -1860,10 +1860,6 @@
 	if (error)
 		goto exit1;
 
-	error = -EXDEV;
-	if (oldnd.mnt != newnd.mnt)
-		goto exit2;
-
 	old_dir = oldnd.dentry;
 	error = -EBUSY;
 	if (oldnd.last_type != LAST_NORM)
