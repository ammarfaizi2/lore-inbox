Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752128AbWAEKFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbWAEKFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWAEKFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:05:41 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:52416 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751901AbWAEKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:05:39 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <torvalds@osdl.org>, <viro@zeniv.linux.org.uk>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <trond.myklebust@fys.uio.no>
Subject: [PATCH 3/3] Fix problems on multi-TB filesystem and file
Date: Thu, 5 Jan 2006 19:05:31 +0900
Message-ID: <000201c611df$92dca230$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix was proposed by Trond Myklebust.  He says:
 The type "sector_t" is heavily tied in to the block layer interface
 as an offset/handle to a block, and is subject to a supposedly
 block-specific configuration option: CONFIG_LBD. Despite this, it is
 used in struct kstatfs to save a couple of bytes on the stack
 whenever we call the filesystems' ->statfs().

So kstatfs's entries related to blocks are invalid on statfs64 for a
network filesystem which has more than 2^32-1 blocks when CONFIG_LBD
is disabled.

The content of the patch attached to this mail is below.
- struct kstatfs
  Change the type of following entries from sector_t to u64.
  f_blocks
  f_bfree
  f_bavail
  f_files
  f_ffree

Any feedback and comments are welcome.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>

diff -uprN -X linux-2.6.15-lsf/Documentation/dontdiff linux-2.6.15-lsf/include/linux/statfs.h
linux-2.6.15-kstatfs/include/linux/statfs.h
--- linux-2.6.15-lsf/include/linux/statfs.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-kstatfs/include/linux/statfs.h	2006-01-04 15:24:38.000000000 +0900
@@ -8,11 +8,11 @@
 struct kstatfs {
 	long f_type;
 	long f_bsize;
-	sector_t f_blocks;
-	sector_t f_bfree;
-	sector_t f_bavail;
-	sector_t f_files;
-	sector_t f_ffree;
+	u64 f_blocks;
+	u64 f_bfree;
+	u64 f_bavail;
+	u64 f_files;
+	u64 f_ffree;
 	__kernel_fsid_t f_fsid;
 	long f_namelen;
 	long f_frsize;

-- Takashi Sato


