Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRHRV7h>; Sat, 18 Aug 2001 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRHRV72>; Sat, 18 Aug 2001 17:59:28 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:44559 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S268511AbRHRV7X>; Sat, 18 Aug 2001 17:59:23 -0400
Date: Sun, 19 Aug 2001 07:59:07 +1000
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] CramFS and HighMem
Message-ID: <20010819075907.A19307@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch replaces page_address in fs/cramfs with kmap.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff -u -r1.1.1.6 -r1.6
--- fs/cramfs/inode.c	19 Jul 2001 23:14:53 -0000	1.1.1.6
+++ fs/cramfs/inode.c	18 Aug 2001 08:11:14 -0000	1.6
@@ -374,6 +374,7 @@
 {
 	struct inode *inode = page->mapping->host;
 	u32 maxblock, bytes_filled;
+	void *pgdata;
 
 	maxblock = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	bytes_filled = 0;
@@ -387,15 +388,18 @@
 			start_offset = *(u32 *) cramfs_read(sb, blkptr_offset-4, 4);
 		compr_len = (*(u32 *) cramfs_read(sb, blkptr_offset, 4)
 			     - start_offset);
+		pgdata = kmap(page);
 		if (compr_len == 0)
 			; /* hole */
 		else
-			bytes_filled = cramfs_uncompress_block(page_address(page),
+			bytes_filled = cramfs_uncompress_block(pgdata,
 				 PAGE_CACHE_SIZE,
 				 cramfs_read(sb, start_offset, compr_len),
 				 compr_len);
-	}
-	memset(page_address(page) + bytes_filled, 0, PAGE_CACHE_SIZE - bytes_filled);
+	} else
+		pgdata = kmap(page);
+	memset(pgdata + bytes_filled, 0, PAGE_CACHE_SIZE - bytes_filled);
+	kunmap(page);
 	flush_dcache_page(page);
 	SetPageUptodate(page);
 	UnlockPage(page);

--ReaqsoxgOBHFXBhH--
