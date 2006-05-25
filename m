Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWEYGfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWEYGfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWEYGfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:35:38 -0400
Received: from mx2.mail.ru ([194.67.23.122]:44363 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S965029AbWEYGfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:35:36 -0400
Date: Thu, 25 May 2006 10:39:16 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2]: ufs: not usual amounts of fragments per block
Message-ID: <20060525063916.GA5632@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The writing to UFS file system with block/fragment!=8 may cause
bogus behaviour. The problem in "ufs_bitmap_search" function,
which doesn't work correctly in "block/fragment!=8" case.
The idea is stolen from BSD code.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/balloc.c linux-2.6.17-rc4-mm3.mod/fs/ufs/balloc.c
--- linux-2.6.17-rc4-mm3/fs/ufs/balloc.c	2006-05-25 10:25:32.962540750 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/balloc.c	2006-05-25 10:26:57.807843250 +0400
@@ -726,18 +726,63 @@ gotit:
 	return result;
 }
 
-static unsigned ufs_bitmap_search (struct super_block * sb,
-	struct ufs_cg_private_info * ucpi, unsigned goal, unsigned count)
+static unsigned ubh_scanc(struct ufs_sb_private_info *uspi,
+			  struct ufs_buffer_head *ubh,
+			  unsigned begin, unsigned size,
+			  unsigned char *table, unsigned char mask)
 {
-	struct ufs_sb_private_info * uspi;
-	struct ufs_super_block_first * usb1;
-	struct ufs_cylinder_group * ucg;
-	unsigned start, length, location, result;
-	unsigned possition, fragsize, blockmap, mask;
+	unsigned rest, offset;
+	unsigned char *cp;
 	
-	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count))
 
-	uspi = UFS_SB(sb)->s_uspi;
+	offset = begin & ~uspi->s_fmask;
+	begin >>= uspi->s_fshift;
+	for (;;) {
+		if ((offset + size) < uspi->s_fsize)
+			rest = size;
+		else
+			rest = uspi->s_fsize - offset;
+		size -= rest;
+		cp = ubh->bh[begin]->b_data + offset;
+		while ((table[*cp++] & mask) == 0 && --rest)
+			;
+		if (rest || !size)
+			break;
+		begin++;
+		offset = 0;
+	}
+	return (size + rest);
+}
+
+/*
+ * Find a block of the specified size in the specified cylinder group.
+ * @sp: pointer to super block
+ * @ucpi: pointer to cylinder group info
+ * @goal: near which block we want find new one
+ * @count: specified size
+ */
+static unsigned ufs_bitmap_search(struct super_block *sb,
+				  struct ufs_cg_private_info *ucpi,
+				  unsigned goal, unsigned count)
+{
+	/*
+	 * Bit patterns for identifying fragments in the block map
+	 * used as ((map & mask_arr) == want_arr)
+	 */
+	static const int mask_arr[9] = {
+		0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff, 0x1ff, 0x3ff
+	};
+	static const int want_arr[9] = {
+		0x0, 0x2, 0x6, 0xe, 0x1e, 0x3e, 0x7e, 0xfe, 0x1fe
+	};
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_super_block_first *usb1;
+	struct ufs_cylinder_group *ucg;
+	unsigned start, length, loc, result;
+	unsigned pos, want, blockmap, mask, end;
+
+	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count));
+
 	usb1 = ubh_get_usb_first (uspi);
 	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 
@@ -747,53 +792,50 @@ static unsigned ufs_bitmap_search (struc
 		start = ucpi->c_frotor >> 3;
 		
 	length = ((uspi->s_fpg + 7) >> 3) - start;
-	location = ubh_scanc(UCPI_UBH(ucpi), ucpi->c_freeoff + start, length,
+	loc = ubh_scanc(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff + start, length,
 		(uspi->s_fpb == 8) ? ufs_fragtable_8fpb : ufs_fragtable_other,
 		1 << (count - 1 + (uspi->s_fpb & 7))); 
-	if (location == 0) {
+	if (loc == 0) {
 		length = start + 1;
-		location = ubh_scanc(UCPI_UBH(ucpi), ucpi->c_freeoff, length,
-			(uspi->s_fpb == 8) ? ufs_fragtable_8fpb : ufs_fragtable_other,
-			1 << (count - 1 + (uspi->s_fpb & 7)));
-		if (location == 0) {
-			ufs_error (sb, "ufs_bitmap_search",
-			"bitmap corrupted on cg %u, start %u, length %u, count %u, freeoff %u\n",
-			ucpi->c_cgx, start, length, count, ucpi->c_freeoff);
+		loc = ubh_scanc(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, length,
+				(uspi->s_fpb == 8) ? ufs_fragtable_8fpb :
+				ufs_fragtable_other,
+				1 << (count - 1 + (uspi->s_fpb & 7)));
+		if (loc == 0) {
+			ufs_error(sb, "ufs_bitmap_search",
+				  "bitmap corrupted on cg %u, start %u,"
+				  " length %u, count %u, freeoff %u\n",
+				  ucpi->c_cgx, start, length, count,
+				  ucpi->c_freeoff);
 			return (unsigned)-1;
 		}
 		start = 0;
 	}
-	result = (start + length - location) << 3;
+	result = (start + length - loc) << 3;
 	ucpi->c_frotor = result;
 
 	/*
 	 * found the byte in the map
 	 */
-	blockmap = ubh_blkmap(UCPI_UBH(ucpi), ucpi->c_freeoff, result);
-	fragsize = 0;
-	for (possition = 0, mask = 1; possition < 8; possition++, mask <<= 1) {
-		if (blockmap & mask) {
-			if (!(possition & uspi->s_fpbmask))
-				fragsize = 1;
-			else 
-				fragsize++;
-		}
-		else {
-			if (fragsize == count) {
-				result += possition - count;
-				UFSD(("EXIT, result %u\n", result))
-				return result;
-			}
-			fragsize = 0;
-		}
-	}
-	if (fragsize == count) {
-		result += possition - count;
-		UFSD(("EXIT, result %u\n", result))
-		return result;
-	}
-	ufs_error (sb, "ufs_bitmap_search", "block not in map on cg %u\n", ucpi->c_cgx);
-	UFSD(("EXIT (FAILED)\n"))
+
+	for (end = result + 8; result < end; result += uspi->s_fpb) {
+		blockmap = ubh_blkmap(UCPI_UBH(ucpi), ucpi->c_freeoff, result);
+		blockmap <<= 1;
+		mask = mask_arr[count];
+		want = want_arr[count];
+		for (pos = 0; pos <= uspi->s_fpb - count; pos++) {
+			if ((blockmap & mask) == want) {
+				UFSD(("EXIT, result %u\n", result));
+				return result + pos;
+ 			}
+			mask <<= 1;
+			want <<= 1;
+ 		}
+ 	}
+
+	ufs_error(sb, "ufs_bitmap_search", "block not in map on cg %u\n",
+		  ucpi->c_cgx);
+	UFSD(("EXIT (FAILED)\n"));
 	return (unsigned)-1;
 }
 
diff -upr -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3/fs/ufs/util.h linux-2.6.17-rc4-mm3.mod/fs/ufs/util.h
--- linux-2.6.17-rc4-mm3/fs/ufs/util.h	2006-05-25 10:25:32.970541250 +0400
+++ linux-2.6.17-rc4-mm3.mod/fs/ufs/util.h	2006-05-25 10:26:57.839845250 +0400
@@ -513,29 +513,3 @@ static inline void ufs_fragacct (struct 
 	if (fragsize > 0 && fragsize < uspi->s_fpb)
 		fs32_add(sb, &fraglist[fragsize], cnt);
 }
-
-#define ubh_scanc(ubh,begin,size,table,mask) _ubh_scanc_(uspi,ubh,begin,size,table,mask)
-static inline unsigned _ubh_scanc_(struct ufs_sb_private_info * uspi, struct ufs_buffer_head * ubh, 
-	unsigned begin, unsigned size, unsigned char * table, unsigned char mask)
-{
-	unsigned rest, offset;
-	unsigned char * cp;
-	
-
-	offset = begin & ~uspi->s_fmask;
-	begin >>= uspi->s_fshift;
-	for (;;) {
-		if ((offset + size) < uspi->s_fsize)
-			rest = size;
-		else
-			rest = uspi->s_fsize - offset;
-		size -= rest;
-		cp = ubh->bh[begin]->b_data + offset;
-		while ((table[*cp++] & mask) == 0 && --rest);
-		if (rest || !size)
-			break;
-		begin++;
-		offset = 0;
-	}
-	return (size + rest);
-}

-- 
/Evgeniy

