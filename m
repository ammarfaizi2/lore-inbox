Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKQXAH>; Fri, 17 Nov 2000 18:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQKQW75>; Fri, 17 Nov 2000 17:59:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56841 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129308AbQKQW7v>; Fri, 17 Nov 2000 17:59:51 -0500
Date: Fri, 17 Nov 2000 14:29:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <20001117222056.A1187@turtle.tat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.10.10011171426240.2581-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Harald Koenig wrote:
> 
> this seems to make things much worse:  starting with ~90M free memory
> "du" again started leaking (or maybe just using memory?) down to ~80M free
> memory when the system suddently locked up completely, no console switch
> was possible anymore (but Sysrq-B did reboot).

How about this version (full patch against test10 - it includes a
slightly corrected version of my earlier dir.c patch)?

It's entirely untested, but it looks good and compiles. Ship it!

		Linus

-----
diff -u --recursive --new-file v2.4.0-test10/linux/fs/isofs/dir.c linux/fs/isofs/dir.c
--- v2.4.0-test10/linux/fs/isofs/dir.c	Fri Aug 11 14:29:01 2000
+++ linux/fs/isofs/dir.c	Fri Nov 17 13:38:01 2000
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
+		if (first_de) inode_number = (bh->b_blocknr << bufbits) + offset;
 
 		de_len = *(unsigned char *) de;
 #ifdef DEBUG
 		printk("de_len = %d\n", de_len);
-#endif
-	    
+#endif	    
 
 		/* If the length byte is zero, we should move on to the next
 		   CDROM sector.  If we are at the end of the directory, we
@@ -164,36 +151,33 @@
 
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
-		if (offset > bufsize) {
-			/*
-			 * This would only normally happen if we had
-			 * a buggy cdrom image.  All directory
-			 * entries should terminate with a null size
-			 * or end exactly at the end of the sector.
-			 */
-		        printk("next_offset (%x) > bufsize (%lx)\n",
-			       offset,bufsize);
-			break;
+		offset += de_len;
+
+		/* Make sure we have a full directory entry */
+		if (offset >= bufsize) {
+			int slop = bufsize - offset + de_len;
+			memcpy(tmpde, de, slop);
+			offset &= bufsize - 1;
+			block++;
+			brelse(bh);
+			bh = NULL;
+			if (offset == bufsize) {
+				bh = isofs_bread(inode, bufsize, block);
+				if (!bh)
+					return 0;
+				memcpy((void *) tmpde + slop, bh->b_data, de_len - slop);
+			}
+			de = tmpde;				
 		}
 
-		if(de->flags[-high_sierra] & 0x80) {
+		if (de->flags[-high_sierra] & 0x80) {
 			first_de = 0;
 			filp->f_pos += de_len;
 			continue;
@@ -265,7 +249,7 @@
 
 		continue;
 	}
-	brelse(bh);
+	if (bh) brelse(bh);
 	return 0;
 }
 
diff -u --recursive --new-file v2.4.0-test10/linux/fs/isofs/namei.c linux/fs/isofs/namei.c
--- v2.4.0-test10/linux/fs/isofs/namei.c	Mon May 10 14:14:28 1999
+++ linux/fs/isofs/namei.c	Fri Nov 17 14:22:33 2000
@@ -49,6 +49,15 @@
 	return dentry->d_op->d_compare(dentry, &dentry->d_name, &qstr);
 }
 
+static struct buffer_head *isofs_bread(struct inode *inode, unsigned int bufsize, unsigned int block)
+{
+	unsigned int blknr = isofs_bmap(inode, block);
+	if (!blknr)
+		return NULL;
+	return bread(inode->i_dev, blknr, bufsize);
+}
+
+
 /*
  *	isofs_find_entry()
  *
@@ -57,129 +66,82 @@
  * itself (as an inode number). It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
  */
-static struct buffer_head *
-isofs_find_entry(struct inode *dir, struct dentry *dentry, unsigned long *ino)
+static unsigned long
+isofs_find_entry(struct inode *dir, struct dentry *dentry,
+	char * tmpname, struct iso_directory_record * tmpde)
 {
+	unsigned long inode_number;
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
-	unsigned int block, i, f_pos, offset, 
-		inode_number = 0; /* shut gcc up */
-	struct buffer_head * bh , * retval = NULL;
-	unsigned int old_offset;
-	int dlen, match;
-	char * dpnt;
-	unsigned char *page = NULL;
-	struct iso_directory_record * de = NULL; /* shut gcc up */
-	char de_not_in_buf = 0;	  /* true if de is in kmalloc'd memory */
-	char c;
-
-	*ino = 0;
-	
-	if (!(block = dir->u.isofs_i.i_first_extent)) return NULL;
+	unsigned int block, f_pos, offset;
+	struct buffer_head * bh = NULL;
+
+	if (!dir->u.isofs_i.i_first_extent)
+		return 0;
   
 	f_pos = 0;
+	offset = 0;
+	block = 0;
 
-	offset = f_pos & (bufsize - 1);
-	block = isofs_bmap(dir,f_pos >> bufbits);
+	while (f_pos < dir->i_size) {
+		struct iso_directory_record * de;
+		int de_len, match, i, dlen;
+		char *dpnt, c;
 
-	if (!block || !(bh = bread(dir->i_dev,block,bufsize))) return NULL;
+		if (!bh) {
+			bh = isofs_bread(dir, bufsize, block);
+			if (!bh)
+				return 0;
+		}
 
-	while (f_pos < dir->i_size) {
+		de = (struct iso_directory_record *) (bh->b_data + offset);
+		inode_number = (bh->b_blocknr << bufbits) + offset;
 
-		/* if de is in kmalloc'd memory, do not point to the
-                   next de, instead we will move to the next sector */
-		if(!de_not_in_buf) {
-			de = (struct iso_directory_record *) 
-				(bh->b_data + offset);
-		}
-		inode_number = (block << bufbits) + (offset & (bufsize - 1));
-
-		/* If byte is zero, or we had to fetch this de past
-		   the end of the buffer, this is the end of file, or
-		   time to move to the next sector. Usually 2048 byte
-		   boundaries. */
-		
-		if (*((unsigned char *) de) == 0 || de_not_in_buf) {
-			if(de_not_in_buf) {
-				/* james@bpgc.com: Since we slopped
-                                   past the end of the last buffer, we
-                                   must start some way into the new
-                                   one */
-				de_not_in_buf = 0;
-				kfree(de);
-				f_pos += offset;
-			}
-			else { 
-				offset = 0;
-				f_pos = ((f_pos & ~(ISOFS_BLOCK_SIZE - 1))
-					 + ISOFS_BLOCK_SIZE);
-			}
+		de_len = *(unsigned char *) de;
+		if (!de_len) {
 			brelse(bh);
 			bh = NULL;
-
-			if (f_pos >= dir->i_size) 
-				break;
-
-			block = isofs_bmap(dir,f_pos>>bufbits);
-			if (!block || !(bh = bread(dir->i_dev,block,bufsize)))
-				break;
-
-			continue; /* Will kick out if past end of directory */
+			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
+			block = f_pos >> bufbits;
+			offset = 0;
+			continue;
 		}
 
-		old_offset = offset;
-		offset += *((unsigned char *) de);
-		f_pos += *((unsigned char *) de);
+		offset += de_len;
+		f_pos += de_len;
 
-		/* james@bpgc.com: new code to handle case where the
-		   directory entry spans two blocks.  Usually 1024
-		   byte boundaries */
+		/* Make sure we have a full directory entry */
 		if (offset >= bufsize) {
-			struct buffer_head *bh_next;
-
-			/* james@bpgc.com: read the next block, and
-                           copy the split de into a newly kmalloc'd
-                           buffer */
-			block = isofs_bmap(dir,f_pos>>bufbits);
-			if (!block || 
-			    !(bh_next = bread(dir->i_dev,block,bufsize)))
-				break;
-			
-			de = (struct iso_directory_record *)
-				kmalloc(offset - old_offset, GFP_KERNEL);
-			memcpy((char *)de, bh->b_data + old_offset, 
-			       bufsize - old_offset);
-			memcpy((char *)de + bufsize - old_offset,
-			       bh_next->b_data, offset - bufsize);
-			brelse(bh_next);
-			de_not_in_buf = 1;
-			offset -= bufsize;
+			int slop = bufsize - offset + de_len;
+			memcpy(tmpde, de, slop);
+			offset &= bufsize - 1;
+			block++;
+			brelse(bh);
+			bh = NULL;
+			if (offset == bufsize) {
+				bh = isofs_bread(dir, bufsize, block);
+				if (!bh)
+					return 0;
+				memcpy((void *) tmpde + slop, bh->b_data, de_len - slop);
+			}
+			de = tmpde;
 		}
+
 		dlen = de->name_len[0];
 		dpnt = de->name;
 
-		if (dir->i_sb->u.isofs_sb.s_rock ||
-		    dir->i_sb->u.isofs_sb.s_joliet_level || 
-		    dir->i_sb->u.isofs_sb.s_mapping == 'n' ||
-		    dir->i_sb->u.isofs_sb.s_mapping == 'a') {
-			if (! page) {
-				page = (unsigned char *)
-					__get_free_page(GFP_KERNEL);
-				if (!page) break;
-			}
-		}
 		if (dir->i_sb->u.isofs_sb.s_rock &&
-		    ((i = get_rock_ridge_filename(de, page, dir)))) {
+		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
 			dlen = i;
-			dpnt = page;
+			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
 		} else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
-			dlen = get_joliet_filename(de, dir, page);
-			dpnt = page;
+			dlen = get_joliet_filename(de, dir, tmpname);
+			dpnt = tmpname;
 #endif
 		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'a') {
-			dlen = get_acorn_filename(de, page, dir);
-			dpnt = page;
+			dlen = get_acorn_filename(de, tmpname, dir);
+			dpnt = tmpname;
 		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'n') {
 			for (i = 0; i < dlen; i++) {
 				c = dpnt[i];
@@ -190,13 +152,13 @@
 					break;
 				}
 				if (c == ';') c = '.';
-				page[i] = c;
+				tmpname[i] = c;
 			}
 			/* This allows us to match with and without
 			 * a trailing period. */
-			if(page[dlen-1] == '.' && dentry->d_name.len == dlen-1)
+			if(tmpname[dlen-1] == '.' && dentry->d_name.len == dlen-1)
 				dlen--;
-			dpnt = page;
+			dpnt = tmpname;
 		}
 		/*
 		 * Skip hidden or associated files unless unhide is set 
@@ -208,43 +170,32 @@
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
 		if (match) {
-			if(inode_number == -1) {
-				/* Should only happen for the '..' entry */
-				inode_number = 
-					isofs_lookup_grandparent(dir,
-					   find_rock_ridge_relocation(de,dir));
-			}
-			*ino = inode_number;
-			retval = bh;
-			bh = NULL;
-			break;
+			if (bh) brelse(bh);
+			return inode_number;
 		}
 	}
-	if (page) free_page((unsigned long) page);
 	if (bh) brelse(bh);
-	if(de_not_in_buf) 
-		kfree(de);
-	return retval;
+	return 0;
 }
 
 struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry)
 {
 	unsigned long ino;
-	struct buffer_head * bh;
 	struct inode *inode;
+	struct page *page;
 
 #ifdef DEBUG
 	printk("lookup: %x %s\n",dir->i_ino, dentry->d_name.name);
 #endif
 	dentry->d_op = dir->i_sb->s_root->d_op;
 
-	bh = isofs_find_entry(dir, dentry, &ino);
+	page = alloc_page(GFP_USER);
+	ino = isofs_find_entry(dir, dentry, page_address(page), 1024 + page_address(page));
+	__free_page(page);
 
 	inode = NULL;
-	if (bh) {
-		brelse(bh);
-
-		inode = iget(dir->i_sb,ino);
+	if (ino) {
+		inode = iget(dir->i_sb, ino);
 		if (!inode)
 			return ERR_PTR(-EACCES);
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
