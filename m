Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268406AbRGXSBM>; Tue, 24 Jul 2001 14:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268415AbRGXSBC>; Tue, 24 Jul 2001 14:01:02 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:30960 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268406AbRGXSAx>; Tue, 24 Jul 2001 14:00:53 -0400
Date: Tue, 24 Jul 2001 19:02:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: variable length array on stack
Message-ID: <Pine.LNX.4.21.0107241830350.1726-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I was surprised to notice a variable length array on stack
in the 2.4.7 (== 2.4.6-ac5) drivers/media/video/meye.c:

static void *ptable_alloc(int npages, u32 *pt_addr) {
	int i = 0;
	void *vmem;
	u32 ptable[npages+1];
	....

I had no idea you could do that!  gcc extension?  Sincere thanks
for teaching me that.  But maybe the construction is inappropriate
in the kernel?  In practice npages here is always 1024, which means
a deeper stack than we'd like to risk.  Wouldn't the (untested)
patch below be better?  Am I missing something when I substitute
kvirt_to_bus(adr) for virt_to_bus(__va(kvirt_to_pa(adr)))?

Hugh

--- linux-2.4.7/drivers/media/video/meye.c	Wed Jul  4 22:41:33 2001
+++ linux/drivers/media/video/meye.c	Tue Jul 24 18:17:08 2001
@@ -209,28 +209,23 @@
 
 /* return a page table pointing to N pages of locked memory */
 static void *ptable_alloc(int npages, u32 *pt_addr) {
-	int i = 0;
+	int i;
 	void *vmem;
-	u32 ptable[npages+1];
-	signed long size;
+	u32 *ptable;
 	unsigned long adr;
 
-	size = (npages + 1) * PAGE_SIZE;
-	vmem = rvmalloc(size);
+	vmem = rvmalloc((npages + 1) * PAGE_SIZE);
 	if (!vmem)
 		return NULL;
 
-	memset(ptable, 0, sizeof(ptable));
-        adr = (unsigned long)vmem;
-	while (size > 0) {
-		ptable[i++] = virt_to_bus(__va(kvirt_to_pa(adr)));
+	adr = (unsigned long)vmem;
+	ptable = (u32 *)(vmem + npages * PAGE_SIZE);
+	for (i = 0; i < npages; i++) {
+		ptable[i] = (u32) kvirt_to_bus(adr);
 		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
 	}
 
-	memcpy(vmem + npages * PAGE_SIZE, ptable, PAGE_SIZE);
-	*pt_addr = ptable[npages];
-
+	*pt_addr = (u32) kvirt_to_bus(adr);
 	return vmem;
 }
 

