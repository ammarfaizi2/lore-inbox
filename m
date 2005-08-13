Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVHMRhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVHMRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVHMRhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 13:37:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932232AbVHMRhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 13:37:14 -0400
Date: Sat, 13 Aug 2005 10:37:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1123953924.3187.22.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain> 
 <1123809302.17269.139.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>  <1123951810.3187.20.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org> <1123953924.3187.22.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Aug 2005, Arjan van de Ven wrote:
> 
> attached is the same patch but now with Steven's change made as well

Actually, the more I looked at that mmap_kmem() function, the less I liked 
it.  Let's get that sucker fixed better first. It's still not wonderful, 
but at least now it tries to verify the whole _range_ of the mapping.

Steven, does this "alternate mmap_kmem fix" patch work for you?

		Linus
----
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -261,7 +261,11 @@ static int mmap_mem(struct file * file, 
 
 static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
 {
-        unsigned long long val;
+	unsigned long pfn, size;
+
+	/* Turn a kernel-virtual address into a physical page frame */
+	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
+
 	/*
 	 * RED-PEN: on some architectures there is more mapped memory
 	 * than available in mem_map which pfn_valid checks
@@ -269,10 +273,14 @@ static int mmap_kmem(struct file * file,
 	 *
 	 * RED-PEN: vmalloc is not supported right now.
 	 */
-	if (!pfn_valid(vma->vm_pgoff))
+	if (!pfn_valid(pfn))
 		return -EIO;
-	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
-	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
+
+	size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if (!pfn_valid(pfn + size - 1))
+		return -EIO;
+
+	vma->vm_pgoff = pfn;
 	return mmap_mem(file, vma);
 }
 
