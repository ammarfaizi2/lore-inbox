Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPBqr>; Wed, 15 Nov 2000 20:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbQKPBqh>; Wed, 15 Nov 2000 20:46:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36103 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129069AbQKPBqW>; Wed, 15 Nov 2000 20:46:22 -0500
Date: Wed, 15 Nov 2000 17:16:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aeb@veritas.com>
cc: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>, emoenke@gwdg.de,
        eric@andante.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <20001116011138.A27272@veritas.com>
Message-ID: <Pine.LNX.4.10.10011151709380.3216-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Does this patch fix it for you?

Warning: TOTALLY UNTESTED!!! Please test carefully.

Also, I'd be interested to know whether somebody really knows if the zero
length handling is correct. Should we really round up to 2048, or should
we perhaps round up only to the next bufsize?

		Linus

-----
--- v2.4.0-test10/linux/fs/isofs/dir.c	Fri Aug 11 14:29:01 2000
+++ linux/fs/isofs/dir.c	Wed Nov 15 17:14:26 2000
@@ -94,6 +94,14 @@
 	return retnamlen;
 }
 
+static struct buffer_head *isofs_bread(struct inode *inode, unsigned int bufsize, unsigned int block)
+{
+	unsigned int blknr = isofs_bmap(inode, block);
+	if (!blknr)
+		return NULL;
+	return bread(inode->i_dev, blknr, bufsize);
+}
+
 /*
  * This should _really_ be cleaned up some day..
  */
@@ -105,7 +113,7 @@
 	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
 	unsigned int block, offset;
 	int inode_number = 0;	/* Quiet GCC */
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
 	int len;
 	int map;
 	int high_sierra;
@@ -117,46 +125,25 @@
 		return 0;
  
 	offset = filp->f_pos & (bufsize - 1);
-	block = isofs_bmap(inode, filp->f_pos >> bufbits);
+	block = filp->f_pos >> bufbits;
 	high_sierra = inode->i_sb->u.isofs_sb.s_high_sierra;
 
-	if (!block)
-		return 0;
-
-	if (!(bh = breada(inode->i_dev, block, bufsize, filp->f_pos, inode->i_size)))
-		return 0;
-
 	while (filp->f_pos < inode->i_size) {
 		int de_len;
-#ifdef DEBUG
-		printk("Block, offset, f_pos: %x %x %x\n",
-		       block, offset, filp->f_pos);
-	        printk("inode->i_size = %x\n",inode->i_size);
-#endif
-		/* Next directory_record on next CDROM sector */
-		if (offset >= bufsize) {
-#ifdef DEBUG
-			printk("offset >= bufsize\n");
-#endif
-			brelse(bh);
-			offset = 0;
-			block = isofs_bmap(inode, (filp->f_pos) >> bufbits);
-			if (!block)
-				return 0;
-			bh = breada(inode->i_dev, block, bufsize, filp->f_pos, inode->i_size);
+
+		if (!bh) {
+			bh = isofs_bread(inode, bufsize, block);
 			if (!bh)
 				return 0;
-			continue;
 		}
 
 		de = (struct iso_directory_record *) (bh->b_data + offset);
-		if(first_de) inode_number = (block << bufbits) + (offset & (bufsize - 1));
+		if (first_de) inode_number = (block << bufbits) + (offset & (bufsize - 1));
 
 		de_len = *(unsigned char *) de;
 #ifdef DEBUG
 		printk("de_len = %d\n", de_len);
-#endif
-	    
+#endif	    
 
 		/* If the length byte is zero, we should move on to the next
 		   CDROM sector.  If we are at the end of the directory, we
@@ -164,36 +151,36 @@
 
 		if (de_len == 0) {
 			brelse(bh);
-			filp->f_pos = ((filp->f_pos & ~(ISOFS_BLOCK_SIZE - 1))
-				       + ISOFS_BLOCK_SIZE);
+			bh = NULL;
+			filp->f_pos = ((filp->f_pos & ~(ISOFS_BLOCK_SIZE - 1)) + ISOFS_BLOCK_SIZE);
+			block = filp->f_pos >> bufbits;
 			offset = 0;
-
-			if (filp->f_pos >= inode->i_size)
-				return 0;
-
-			block = isofs_bmap(inode, (filp->f_pos) >> bufbits);
-			if (!block)
-				return 0;
-			bh = breada(inode->i_dev, block, bufsize, filp->f_pos, inode->i_size);
-			if (!bh)
-				return 0;
 			continue;
 		}
 
-		offset +=  de_len;
+		offset += de_len;
+		if (offset == bufsize) {
+			offset = 0;
+			block++;
+			brelse(bh);
+			bh = NULL;
+		}
+
+		/* Make sure we have a full directory entry */
 		if (offset > bufsize) {
-			/*
-			 * This would only normally happen if we had
-			 * a buggy cdrom image.  All directory
-			 * entries should terminate with a null size
-			 * or end exactly at the end of the sector.
-			 */
-		        printk("next_offset (%x) > bufsize (%lx)\n",
-			       offset,bufsize);
-			break;
+			int slop = bufsize - offset + de_len;
+			memcpy(tmpde, de, slop);
+			offset &= bufsize - 1;
+			block++;
+			brelse(bh);
+			bh = isofs_bread(inode, bufsize, block);
+			if (!bh)
+				return 0;
+			memcpy((void *) tmpde + slop, bh->b_data, de_len - slop);
+			de = tmpde;
 		}
 
-		if(de->flags[-high_sierra] & 0x80) {
+		if (de->flags[-high_sierra] & 0x80) {
 			first_de = 0;
 			filp->f_pos += de_len;
 			continue;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
