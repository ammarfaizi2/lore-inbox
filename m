Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVDVH0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVDVH0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVDVH0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:26:32 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:903 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262009AbVDVHYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:24:43 -0400
Date: Fri, 22 Apr 2005 09:24:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] squashfs: remove some more casts
Message-ID: <20050422072446.GF10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de> <20050422072037.GB10459@wohnheim.fh-wedel.de> <20050422072200.GC10459@wohnheim.fh-wedel.de> <20050422072251.GD10459@wohnheim.fh-wedel.de> <20050422072355.GE10459@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050422072355.GE10459@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

--- linux-2.6.12-rc3cow/fs/squashfs/inode.c~squashfs_cu9	2005-04-22 08:53:27.741921536 +0200
+++ linux-2.6.12-rc3cow/fs/squashfs/inode.c	2005-04-22 09:17:39.795175888 +0200
@@ -124,39 +124,35 @@ static struct buffer_head *get_block_len
 	squashfs_sb_info *msBlk = s->s_fs_info;
 	unsigned short temp;
 	struct buffer_head *bh;
+	unsigned char *data;
 
 	if (!(bh = sb_bread(s, *cur_index)))
 		return NULL;
 
 	if (msBlk->devblksize - *offset == 1) {
+		data = bh->b_data;
 		if (msBlk->swap)
-			((unsigned char *) &temp)[1] = *((unsigned char *)
-				(bh->b_data + *offset));
+			((unsigned char *) &temp)[1] = data[*offset];
 		else
-			((unsigned char *) &temp)[0] = *((unsigned char *)
-				(bh->b_data + *offset));
+			((unsigned char *) &temp)[0] = data[*offset];
 		brelse(bh);
 		if (!(bh = sb_bread(s, ++(*cur_index))))
 			return NULL;
+		data = bh->b_data;
 		if (msBlk->swap)
-			((unsigned char *) &temp)[0] = *((unsigned char *)
-				bh->b_data); 
+			((unsigned char *) &temp)[0] = data[0];
 		else
-			((unsigned char *) &temp)[1] = *((unsigned char *)
-				bh->b_data); 
+			((unsigned char *) &temp)[1] = data[0];
 		*c_byte = temp;
 		*offset = 1;
 	} else {
+		data = bh->b_data;
 		if (msBlk->swap) {
-			((unsigned char *) &temp)[1] = *((unsigned char *)
-				(bh->b_data + *offset));
-			((unsigned char *) &temp)[0] = *((unsigned char *)
-				(bh->b_data + *offset + 1)); 
+			((unsigned char *) &temp)[1] = data[*offset];
+			((unsigned char *) &temp)[0] = data[*offset + 1]; 
 		} else {
-			((unsigned char *) &temp)[0] = *((unsigned char *)
-				(bh->b_data + *offset));
-			((unsigned char *) &temp)[1] = *((unsigned char *)
-				(bh->b_data + *offset + 1)); 
+			((unsigned char *) &temp)[0] = data[*offset];
+			((unsigned char *) &temp)[1] = data[*offset + 1]; 
 		}
 		*c_byte = temp;
 		*offset += 2;
@@ -169,8 +165,8 @@ static struct buffer_head *get_block_len
 				return NULL;
 			*offset = 0;
 		}
-		if (*((unsigned char *) (bh->b_data + *offset)) !=
-						SQUASHFS_MARKER_BYTE) {
+		data = bh->b_data;
+		if (data[*offset] != SQUASHFS_MARKER_BYTE) {
 			ERROR("Metadata block marker corrupt @ %x\n",
 						*cur_index);
 			brelse(bh);
