Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSGDXub>; Thu, 4 Jul 2002 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSGDXrj>; Thu, 4 Jul 2002 19:47:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39181 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315191AbSGDXqK>;
	Thu, 4 Jul 2002 19:46:10 -0400
Message-ID: <3D24E039.D56C204@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 14/27] check for O_DIRECT capability in open(), not write()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For O_DIRECT opens we're currently checking that the fs supports
O_DIRECT at write(2)-time.

This is a forward-port of Andrea's patch which moves the check to
open() time.  Seems more sensible.


 fs/fcntl.c   |    5 +++++
 fs/open.c    |    8 ++++++++
 mm/filemap.c |    2 --
 3 files changed, 13 insertions(+), 2 deletions(-)

--- 2.5.24/fs/fcntl.c~o_direct-open-check	Thu Jul  4 16:17:24 2002
+++ 2.5.24-akpm/fs/fcntl.c	Thu Jul  4 16:17:24 2002
@@ -245,6 +245,11 @@ static int setfl(int fd, struct file * f
 	}
 
 	if (arg & O_DIRECT) {
+		if (inode->i_mapping && inode->i_mapping->a_ops) {
+			if (!inode->i_mapping->a_ops->direct_IO)
+				return -EINVAL;
+		}
+
 		/*
 		 * alloc_kiovec() can sleep and we are only serialized by
 		 * the big kernel lock here, so abuse the i_sem to serialize
--- 2.5.24/fs/open.c~o_direct-open-check	Thu Jul  4 16:17:24 2002
+++ 2.5.24-akpm/fs/open.c	Thu Jul  4 16:17:24 2002
@@ -665,6 +665,14 @@ struct file *dentry_open(struct dentry *
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
+	/* NB: we're sure to have correct a_ops only after f_op->open */
+	if (f->f_flags & O_DIRECT) {
+		error = -EINVAL;
+		if (inode->i_mapping && inode->i_mapping->a_ops)
+			if (!inode->i_mapping->a_ops->direct_IO)
+				goto cleanup_all;
+	}
+
 	return f;
 
 cleanup_all:
--- 2.5.24/mm/filemap.c~o_direct-open-check	Thu Jul  4 16:17:24 2002
+++ 2.5.24-akpm/mm/filemap.c	Thu Jul  4 16:22:09 2002
@@ -1121,8 +1121,6 @@ static ssize_t generic_file_direct_IO(in
 	retval = -EINVAL;
 	if ((offset & blocksize_mask) || (count & blocksize_mask))
 		goto out_free;
-	if (!mapping->a_ops->direct_IO)
-		goto out_free;
 
 	/*
 	 * Flush to disk exclusively the _data_, metadata must remain

-
