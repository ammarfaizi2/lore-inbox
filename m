Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTJaJ4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJaJ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:56:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:34700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263170AbTJaJ4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:56:24 -0500
Date: Fri, 31 Oct 2003 01:58:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: sluskyb@paranoiacs.org, jariruusu@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-Id: <20031031015818.446e4f5a.akpm@osdl.org>
In-Reply-To: <20031031015559.6239a4a4.akpm@osdl.org>
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
	<3FA15506.B9B76A5D@users.sourceforge.net>
	<20031030133000.6a04febf.akpm@osdl.org>
	<20031031005246.GE12147@fukurou.paranoiacs.org>
	<20031031015500.44a94f88.akpm@osdl.org>
	<20031031015559.6239a4a4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Andrew Morton <akpm@osdl.org> wrote:
>  >
>  > Here's the patch;
> 
>  And here's your cleanup patch on top of that.

And here are some fixes against your patch.  kunmap_atomic() takes a kernel
virtual address, not a pageframe pointer.  And there were a couple of stray
kunmap()s left over.


--- 25/drivers/block/loop.c~loop-highmem-fixes	2003-10-31 00:55:17.000000000 -0800
+++ 25-akpm/drivers/block/loop.c	2003-10-31 01:01:32.000000000 -0800
@@ -81,18 +81,16 @@ static int transfer_none(struct loop_dev
 			 struct page *loop_page, unsigned loop_off,
 			 int size, sector_t real_block)
 {
-	char	*raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
-	char	*loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
+	char *raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char *loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
 
-	if (raw_buf != loop_buf) {
-		if (cmd == READ)
-			memcpy(loop_buf, raw_buf, size);
-		else
-			memcpy(raw_buf, loop_buf, size);
-	}
+	if (cmd == READ)
+		memcpy(loop_buf, raw_buf, size);
+	else
+		memcpy(raw_buf, loop_buf, size);
 
-	kunmap_atomic(raw_page, KM_USER0);
-	kunmap_atomic(loop_page, KM_USER1);
+	kunmap_atomic(raw_buf, KM_USER0);
+	kunmap_atomic(loop_buf, KM_USER1);
 	cond_resched();
 	return 0;
 }
@@ -102,10 +100,10 @@ static int transfer_xor(struct loop_devi
 			struct page *loop_page, unsigned loop_off,
 			int size, sector_t real_block)
 {
-	char	*raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
-	char	*loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
-	char	*in, *out, *key;
-	int	i, keysize;
+	char *raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char *loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
+	char *in, *out, *key;
+	int i, keysize;
 
 	if (cmd == READ) {
 		in = raw_buf;
@@ -120,8 +118,8 @@ static int transfer_xor(struct loop_devi
 	for (i = 0; i < size; i++)
 		*out++ = *in++ ^ key[(i & 511) % keysize];
 
-	kunmap_atomic(raw_page, KM_USER0);
-	kunmap_atomic(loop_page, KM_USER1);
+	kunmap_atomic(raw_buf, KM_USER0);
+	kunmap_atomic(loop_buf, KM_USER1);
 	cond_resched();
 	return 0;
 }
@@ -225,17 +223,19 @@ do_lo_send(struct loop_device *lo, struc
 						 bvec->bv_page, bv_offs,
 						 size, IV);
 		if (transfer_result) {
+			char *kaddr;
+
 			/*
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
 			printk(KERN_ERR "loop: transfer error block %llu\n",
 			       (unsigned long long)index);
-			memset(kmap_atomic(page, KM_USER0) + offset, 0, size);
-			kunmap_atomic(page, KM_USER0);
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + offset, 0, size);
+			kunmap_atomic(kaddr, KM_USER0);
 		}
 		flush_dcache_page(page);
-		kunmap(page);
 		if (aops->commit_write(file, page, offset, offset+size))
 			goto unlock;
 		if (transfer_result)
@@ -250,7 +250,6 @@ do_lo_send(struct loop_device *lo, struc
 	}
 	up(&mapping->host->i_sem);
 out:
-	kunmap(bvec->bv_page);
 	return ret;
 
 unlock:

_

