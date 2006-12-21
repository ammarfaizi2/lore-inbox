Return-Path: <linux-kernel-owner+w=401wt.eu-S1422716AbWLUNFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWLUNFH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWLUNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:05:07 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5684 "EHLO
	amsfep14-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1422728AbWLUNFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:05:04 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>
	 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 14:03:20 +0100
Message-Id: <1166706200.32117.14.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 09:43 -0800, Linus Torvalds wrote:
> 
> Btw,
>  here's a totally new tangent on this: it's possible that user code is 
> simply BUGGY. 

depmod: BADNESS: written outside isize 22183

---
diff --git a/fs/buffer.c b/fs/buffer.c
index d1f1b54..5db9fd9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2393,6 +2393,17 @@ int nobh_commit_write(struct file *file, struct page *page,
 }
 EXPORT_SYMBOL(nobh_commit_write);
 
+static void __check_tail_zero(char *kaddr, unsigned int offset)
+{
+	unsigned int check = 0;
+	do {
+		check += kaddr[offset++];
+	} while (offset < PAGE_CACHE_SIZE);
+	if (check)
+		printk(KERN_ERR "%s: BADNESS: written outside isize %u\n",
+				current->comm, check);
+}
+
 /*
  * nobh_writepage() - based on block_full_write_page() except
  * that it tries to operate without attaching bufferheads to
@@ -2437,6 +2448,7 @@ int nobh_writepage(struct page *page, get_block_t *get_block,
 	 * writes to that region are not written out to the file."
 	 */
 	kaddr = kmap_atomic(page, KM_USER0);
+	__check_tail_zero(kaddr, offset);
 	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
@@ -2604,6 +2616,7 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 	 * writes to that region are not written out to the file."
 	 */
 	kaddr = kmap_atomic(page, KM_USER0);
+	__check_tail_zero(kaddr, offset);
 	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);


