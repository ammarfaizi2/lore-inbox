Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291829AbSBTNBc>; Wed, 20 Feb 2002 08:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291825AbSBTNBM>; Wed, 20 Feb 2002 08:01:12 -0500
Received: from 216-42-72-165.ppp.netsville.net ([216.42.72.165]:50397 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S291829AbSBTNBB>; Wed, 20 Feb 2002 08:01:01 -0500
Date: Wed, 20 Feb 2002 08:00:30 -0500
From: Chris Mason <mason@suse.com>
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sb_read problem in hpfs
Message-ID: <143960000.1014210030@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

hpfs_read_super triggers calls to sb_bread (through hpfs_map_sector) 
before setting s_blocksize.  This leads to a BUG() in grow_buffers.

This patch was tested lightly, hpfs_read_super completes
properly when an hpfs FS is not present.

-chris

--- suse.4/fs/hpfs/super.c Tue, 19 Feb 2002 08:55:47 -0500 
+++ suse.4(w)/fs/hpfs/super.c Tue, 19 Feb 2002 22:28:37 -0500 
@@ -410,6 +410,8 @@
 	/*s->s_hpfs_mounting = 1;*/
 	dev = s->s_dev;
 	set_blocksize(dev, 512);
+	s->s_blocksize = 512;
+	s->s_blocksize_bits = 9;
 	s->s_hpfs_fs_size = -1;
 	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
 	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
@@ -436,8 +438,6 @@
 
 	/* Fill superblock stuff */
 	s->s_magic = HPFS_SUPER_MAGIC;
-	s->s_blocksize = 512;
-	s->s_blocksize_bits = 9;
 	s->s_op = &hpfs_sops;
 
 	s->s_hpfs_root = superblock->root;

