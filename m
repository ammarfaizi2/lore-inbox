Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbTCRJpc>; Tue, 18 Mar 2003 04:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbTCRJpc>; Tue, 18 Mar 2003 04:45:32 -0500
Received: from verein.lst.de ([212.34.181.86]:44293 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262385AbTCRJpc>;
	Tue, 18 Mar 2003 04:45:32 -0500
Date: Tue, 18 Mar 2003 10:56:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix waitqueue leak in devfs_d_revalidate_wait
Message-ID: <20030318105625.B4424@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs_d_revalidate_wait adds to a waitqueue but never removes from it
again so we there's one entry full of reused stack space added on
each call (I wonder how this ever worked).

The function has a few more bugs (it effectivly does a sleep_on instead
of checking for the actual even and can't deal with negative dentries
at all), but I just had breakfast and don't want to poke into devfs
internals deeper - I still hope Adam's smalldevfs will get merged
anyway..


--- 1.74/fs/devfs/base.c	Mon Mar 17 01:33:08 2003
+++ edited/fs/devfs/base.c	Tue Mar 18 09:37:29 2003
@@ -2336,6 +2232,8 @@
     wait_queue_head_t wait_queue;
 };
 
+/* XXX: this doesn't handle the case where we got a negative dentry
+        but a devfs entry has been registered in the meanwhile */
 static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
 {
     struct inode *dir = dentry->d_parent->d_inode;
@@ -2380,6 +2278,7 @@
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
 	schedule ();
+	remove_wait_queue (&lookup_info->wait_queue, &wait);
     }
     else read_unlock (&parent->u.dir.lock);
     return 1;
