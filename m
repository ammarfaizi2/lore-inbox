Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313096AbSC1Hc2>; Thu, 28 Mar 2002 02:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSC1HcT>; Thu, 28 Mar 2002 02:32:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7433 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313096AbSC1HcE>;
	Thu, 28 Mar 2002 02:32:04 -0500
Message-ID: <3CA2C68E.5B8C4176@zip.com.au>
Date: Wed, 27 Mar 2002 23:30:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] ext2_fill_super breakage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.7 there is a thinko in the allocation and initialisation
of the fs-private superblock for ext2.  It's passing the wrong type
to the sizeof operator (which of course gives the wrong size)
when allocating and clearing the memory. 

Lesson for the day: this is one of the reasons why this idiom:

	some_type *p;

	p = malloc(sizeof(*p));
	...
	memset(p, 0, sizeof(*p));

is preferable to

	some_type *p;

	p = malloc(sizeof(some_type));
	...
	memset(p, 0, sizeof(some_type));

I checked the other filesystems.  They're OK (but idiomatically
impure).  I've added a couple of defensive memsets where
they were missing.


--- 2.5.7/fs/autofs/inode.c~fill-super	Wed Mar 27 23:14:20 2002
+++ 2.5.7-akpm/fs/autofs/inode.c	Wed Mar 27 23:14:54 2002
@@ -119,9 +119,10 @@ int autofs_fill_super(struct super_block
 	struct autofs_sb_info *sbi;
 	int minproto, maxproto;
 
-	sbi = (struct autofs_sb_info *) kmalloc(sizeof(struct autofs_sb_info), GFP_KERNEL);
+	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
+	memset(sbi, 0, sizeof(*sbi));
 	DPRINTK(("autofs: starting up, sbi = %p\n",sbi));
 
 	s->u.generic_sbp = sbi;
--- 2.5.7/fs/devpts/inode.c~fill-super	Wed Mar 27 23:16:05 2002
+++ 2.5.7-akpm/fs/devpts/inode.c	Wed Mar 27 23:16:33 2002
@@ -123,9 +123,10 @@ static int devpts_fill_super(struct supe
 	struct inode * inode;
 	struct devpts_sb_info *sbi;
 
-	sbi = (struct devpts_sb_info *) kmalloc(sizeof(struct devpts_sb_info), GFP_KERNEL);
+	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail;
+	memset(sbi, 0, sizeof(*sbi));
 
 	sbi->magic  = DEVPTS_SBI_MAGIC;
 	sbi->max_ptys = unix98_max_ptys;
--- 2.5.7/fs/ext2/super.c~fill-super	Wed Mar 27 23:16:57 2002
+++ 2.5.7-akpm/fs/ext2/super.c	Wed Mar 27 23:17:25 2002
@@ -465,11 +465,11 @@ static int ext2_fill_super(struct super_
 	int db_count;
 	int i, j;
 
-	sbi = kmalloc(sizeof(struct ext2_super_block), GFP_KERNEL);
+	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->u.generic_sbp = sbi;
-	memset(sbi, 0, sizeof(struct ext2_super_block));
+	memset(sbi, 0, sizeof(*sbi));
 
 	/*
 	 * See what the current blocksize for the device is, and


-
