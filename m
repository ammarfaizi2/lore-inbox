Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUBJHRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBJHRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:17:09 -0500
Received: from ns.suse.de ([195.135.220.2]:12938 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265678AbUBJHRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:17:00 -0500
Date: Thu, 12 Feb 2004 00:23:38 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-Id: <20040212002338.2a82302d.ak@suse.de>
In-Reply-To: <1076384799.893.5.camel@gaston>
References: <1076384799.893.5.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 14:47:09 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Just reverting the patch fixes it. Though, the patch do make sense in
> some cases, paulus suggested to modify the code so that for a non
> MAP_FIXED map, it still search from the passed-in address, but avoids
> the spare between the current mm->brk and TASK_UNMAPPED_BASE, thus the
> algorithm would still work for things outside of these areas.
> 
> Commment ?

Can you test this patch please?  It essentially implements Paulus' suggestion.

It also fixes another issue (don't use free_area_cache when the user gave an
address hint).

--- linux-2.6.3rc1-amd64/mm/mmap.c-o	2004-01-28 17:12:37.000000000 +0100
+++ linux-2.6.3rc1-amd64/mm/mmap.c	2004-02-12 00:16:35.000000000 +0100
@@ -727,18 +727,20 @@
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 static inline unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
+arch_get_unmapped_area(struct file *filp, unsigned long uaddr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long start_addr;
+	unsigned long unmapped_base;
+	unsigned long addr;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
+	if (uaddr) {
+		addr = PAGE_ALIGN(uaddr);
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
@@ -747,28 +749,40 @@
 		addr = mm->free_area_cache;
 	start_addr = addr;
 
+	unmapped_base = TASK_UNMAPPED_BASE;
 full_search:
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
+	for (vma = find_vma(mm, addr); ; ) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
 		if (TASK_SIZE - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = addr = TASK_UNMAPPED_BASE;
+			if (start_addr > unmapped_base) {
+				start_addr = addr = unmapped_base;
 				goto full_search;
 			}
 			return -ENOMEM;
 		}
+		/* On the first pass always skip the brk gap to not
+		   confuse glibc malloc.  This can happen with user
+		   address hints < TASK_UNMAPPED_BASE. */
+		if (addr >= mm->brk && addr < unmapped_base) { 
+			vma = find_vma(mm, unmapped_base); 
+			addr = unmapped_base;
+			continue;
+		}
 		if (!vma || addr + len <= vma->vm_start) {
 			/*
-			 * Remember the place where we stopped the search:
+			 * Remember the place where we stopped the search,
+			 * but only if the user didn't give hints.
 			 */
-			mm->free_area_cache = addr + len;
+			if (uaddr == 0) 
+				mm->free_area_cache = addr + len;
 			return addr;
 		}
 		addr = vma->vm_end;
+		vma = vma->vm_next;
 	}
 }
 #else
