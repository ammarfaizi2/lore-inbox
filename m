Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSGQFWw>; Wed, 17 Jul 2002 01:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSGQFU2>; Wed, 17 Jul 2002 01:20:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318215AbSGQFS4>;
	Wed, 17 Jul 2002 01:18:56 -0400
Message-ID: <3D3500C8.9627632F@zip.com.au>
Date: Tue, 16 Jul 2002 22:29:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/13] O_DIRECT open check
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Updated forward-port of Aodrea's O_DIRECT open() checks.  If the user
asked for O_DIRECT and the inode has no mapping or no a_ops then fail
the open up-front.



 fcntl.c |    5 ++---
 open.c  |    7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- 2.5.26/fs/fcntl.c~o_direct_open_check	Tue Jul 16 21:46:32 2002
+++ 2.5.26-akpm/fs/fcntl.c	Tue Jul 16 21:59:37 2002
@@ -245,10 +245,9 @@ static int setfl(int fd, struct file * f
 	}
 
 	if (arg & O_DIRECT) {
-		if (inode->i_mapping && inode->i_mapping->a_ops) {
-			if (!inode->i_mapping->a_ops->direct_IO)
+		if (!inode->i_mapping || !inode->i_mapping->a_ops ||
+			!inode->i_mapping->a_ops->direct_IO)
 				return -EINVAL;
-		}
 
 		/*
 		 * alloc_kiovec() can sleep and we are only serialized by
--- 2.5.26/fs/open.c~o_direct_open_check	Tue Jul 16 21:46:32 2002
+++ 2.5.26-akpm/fs/open.c	Tue Jul 16 21:59:37 2002
@@ -665,10 +665,11 @@ struct file *dentry_open(struct dentry *
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
-		error = -EINVAL;
-		if (inode->i_mapping && inode->i_mapping->a_ops)
-			if (!inode->i_mapping->a_ops->direct_IO)
+		if (!inode->i_mapping || !inode->i_mapping->a_ops ||
+			!inode->i_mapping->a_ops->direct_IO) {
+				error = -EINVAL;
 				goto cleanup_all;
+		}
 	}
 
 	return f;

.
