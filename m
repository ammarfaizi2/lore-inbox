Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSFQGvx>; Mon, 17 Jun 2002 02:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSFQGvO>; Mon, 17 Jun 2002 02:51:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316795AbSFQGsz>;
	Mon, 17 Jun 2002 02:48:55 -0400
Message-ID: <3D0D8747.ECCB8FC@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 12/19] kmap_atomic fix in bio_copy()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bio_copy is doing

	vfrom = kmap_atomic(bv->bv_page, KM_BIO_IRQ);
	vto = kmap_atomic(bbv->bv_page, KM_BIO_IRQ);

which, if I understand atomic kmaps, is incorrect.  Both source and
dest will get the same pte.

The patch creates a separate atomic kmap member for the destination and
source of this copy.



--- 2.5.22/fs/bio.c~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/fs/bio.c	Sun Jun 16 23:22:46 2002
@@ -284,8 +284,8 @@ struct bio *bio_copy(struct bio *bio, in
 			vto = kmap(bbv->bv_page);
 		} else {
 			local_irq_save(flags);
-			vfrom = kmap_atomic(bv->bv_page, KM_BIO_IRQ);
-			vto = kmap_atomic(bbv->bv_page, KM_BIO_IRQ);
+			vfrom = kmap_atomic(bv->bv_page, KM_BIO_SRC_IRQ);
+			vto = kmap_atomic(bbv->bv_page, KM_BIO_DST_IRQ);
 		}
 
 		memcpy(vto + bbv->bv_offset, vfrom + bv->bv_offset, bv->bv_len);
@@ -293,8 +293,8 @@ struct bio *bio_copy(struct bio *bio, in
 			kunmap(bbv->bv_page);
 			kunmap(bv->bv_page);
 		} else {
-			kunmap_atomic(vto, KM_BIO_IRQ);
-			kunmap_atomic(vfrom, KM_BIO_IRQ);
+			kunmap_atomic(vto, KM_BIO_DST_IRQ);
+			kunmap_atomic(vfrom, KM_BIO_SRC_IRQ);
 			local_irq_restore(flags);
 		}
 	}
--- 2.5.22/fs/ntfs/aops.c~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/fs/ntfs/aops.c	Sun Jun 16 22:50:19 2002
@@ -61,10 +61,10 @@ static void end_buffer_read_file_async(s
 
 			if (file_ofs < ni->initialized_size)
 				ofs = ni->initialized_size - file_ofs;
-			addr = kmap_atomic(page, KM_BIO_IRQ);
+			addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
 			memset(addr + bh_offset(bh) + ofs, 0, bh->b_size - ofs);
 			flush_dcache_page(page);
-			kunmap_atomic(addr, KM_BIO_IRQ);
+			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		}
 	} else
 		SetPageError(page);
@@ -370,10 +370,10 @@ static void end_buffer_read_mftbmp_async
 
 			if (file_ofs < vol->mftbmp_initialized_size)
 				ofs = vol->mftbmp_initialized_size - file_ofs;
-			addr = kmap_atomic(page, KM_BIO_IRQ);
+			addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
 			memset(addr + bh_offset(bh) + ofs, 0, bh->b_size - ofs);
 			flush_dcache_page(page);
-			kunmap_atomic(addr, KM_BIO_IRQ);
+			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		}
 	} else
 		SetPageError(page);
@@ -573,10 +573,10 @@ static void end_buffer_read_mst_async(st
 
 			if (file_ofs < ni->initialized_size)
 				ofs = ni->initialized_size - file_ofs;
-			addr = kmap_atomic(page, KM_BIO_IRQ);
+			addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
 			memset(addr + bh_offset(bh) + ofs, 0, bh->b_size - ofs);
 			flush_dcache_page(page);
-			kunmap_atomic(addr, KM_BIO_IRQ);
+			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		}
 	} else
 		SetPageError(page);
@@ -607,7 +607,7 @@ static void end_buffer_read_mst_async(st
 
 		rec_size = ni->_IDM(index_block_size);
 		recs = PAGE_CACHE_SIZE / rec_size;
-		addr = kmap_atomic(page, KM_BIO_IRQ);
+		addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
 		for (i = 0; i < recs; i++) {
 			if (!post_read_mst_fixup((NTFS_RECORD*)(addr +
 					i * rec_size), rec_size))
@@ -621,7 +621,7 @@ static void end_buffer_read_mst_async(st
 					ni->_IDM(index_block_size_bits)) + i));
 		}
 		flush_dcache_page(page);
-		kunmap_atomic(addr, KM_BIO_IRQ);
+		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		if (likely(!nr_err && recs))
 			SetPageUptodate(page);
 		else {
--- 2.5.22/include/asm-i386/kmap_types.h~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/asm-i386/kmap_types.h	Sun Jun 16 22:50:19 2002
@@ -15,10 +15,11 @@ D(1)	KM_SKB_SUNRPC_DATA,
 D(2)	KM_SKB_DATA_SOFTIRQ,
 D(3)	KM_USER0,
 D(4)	KM_USER1,
-D(5)	KM_BIO_IRQ,
-D(6)	KM_PTE0,
-D(7)	KM_PTE1,
-D(8)	KM_TYPE_NR
+D(5)	KM_BIO_SRC_IRQ,
+D(6)	KM_BIO_DST_IRQ,
+D(7)	KM_PTE0,
+D(8)	KM_PTE1,
+D(9)	KM_TYPE_NR
 };
 
 #undef D
--- 2.5.22/include/asm-ppc/kmap_types.h~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/asm-ppc/kmap_types.h	Sun Jun 16 22:50:19 2002
@@ -11,7 +11,8 @@ enum km_type {
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
-	KM_BIO_IRQ,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
 	KM_TYPE_NR
--- 2.5.22/include/asm-sparc/kmap_types.h~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/asm-sparc/kmap_types.h	Sun Jun 16 22:50:19 2002
@@ -7,7 +7,8 @@ enum km_type {
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
-	KM_BIO_IRQ,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
 	KM_TYPE_NR
 };
 
--- 2.5.22/include/asm-x86_64/kmap_types.h~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/asm-x86_64/kmap_types.h	Sun Jun 16 22:50:19 2002
@@ -7,7 +7,8 @@ enum km_type {
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
-	KM_BIO_IRQ,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
 	KM_TYPE_NR
 };
 
--- 2.5.22/include/linux/highmem.h~bio_copy	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/highmem.h	Sun Jun 16 23:22:46 2002
@@ -38,7 +38,7 @@ static inline char *bio_kmap_irq(struct 
 	 * it's a highmem page
 	 */
 	__cli();
-	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_IRQ);
+	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
 
 	if (addr & ~PAGE_MASK)
 		BUG();
@@ -50,7 +50,7 @@ static inline void bio_kunmap_irq(char *
 {
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
-	kunmap_atomic((void *) ptr, KM_BIO_IRQ);
+	kunmap_atomic((void *) ptr, KM_BIO_SRC_IRQ);
 	__restore_flags(*flags);
 }
 

-
