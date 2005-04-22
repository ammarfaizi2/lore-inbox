Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVDVHWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVDVHWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVDVHWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:22:17 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:12678 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262003AbVDVHV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:21:58 -0400
Date: Fri, 22 Apr 2005 09:22:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] squashfs: conserve stack, remove casts
Message-ID: <20050422072200.GC10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de> <20050422072037.GB10459@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050422072037.GB10459@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc3cow/fs/squashfs/inode.c~squashfs_cu6	2005-04-22 07:21:11.523554656 +0200
+++ linux-2.6.12-rc3cow/fs/squashfs/inode.c	2005-04-22 09:17:45.607292312 +0200
@@ -1405,12 +1405,15 @@ static int get_dir_index_using_name(stru
 	squashfs_sb_info *msBlk = s->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	int i, length = 0;
-	char buffer[sizeof(squashfs_dir_index) + SQUASHFS_NAME_LEN + 1];
-	squashfs_dir_index *index = (squashfs_dir_index *) buffer;
+	squashfs_dir_index *index;
 	char str[SQUASHFS_NAME_LEN + 1];
 
 	TRACE("Entered get_dir_index_using_name, i_count %d\n", i_count);
 
+	index = kmalloc(sizeof(*index) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
+	if (!index)
+		return -ENOMEM;
+
 	strncpy(str, name, size);
 	str[size] = '\0';
 
@@ -1442,6 +1445,7 @@ static int get_dir_index_using_name(stru
 	}
 
 	*next_offset = (length + *next_offset) % SQUASHFS_METADATA_SIZE;
+	kfree(index);
 	return length;
 }
 
