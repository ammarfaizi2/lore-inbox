Return-Path: <linux-kernel-owner+w=401wt.eu-S1751957AbXAVQrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbXAVQrW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXAVQrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:47:22 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:8419 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbXAVQrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:47:21 -0500
X-AuditID: d80ac21c-a4510bb00000330a-76-45b4ea989228 
Date: Mon, 22 Jan 2007 16:47:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Andrew Morton <akpm@osdl.org>, Franck Bui-Huu <fbuihuu@gmail.com>,
       Nadia Derbey <Nadia.Derbey@bull.net>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: revert "Fix up" of mmap_kmem
Message-ID: <Pine.LNX.4.64.0701221642320.27059@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jan 2007 16:47:20.0027 (UTC) FILETIME=[FB6CFAB0:01C73E44]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert 2.6.19's 99a10a60ba9bedcf5d70ef81414d3e03816afa3f (shown
below) for 2.6.20.  Nadia Derbey has reported that mmap of /dev/kmem no
longer works with the kernel virtual address as offset, and Franck has
confirmed that his patch came from a misunderstanding of what an offset
means to /dev/kmem - whereas his patch description seems to say that he
was correcting the offset on a few plaforms, there was no such problem
to correct, and his patch was in fact changing its API on all platforms.

Suggested-by: Hugh Dickins <hugh@veritas.com>
---
From: Franck Bui-Huu <fbuihuu@gmail.com>
Date: Thu, 12 Oct 2006 19:06:33 +0000 (+0200)
Subject: [PATCH] Fix up mmap_kmem
X-Git-Tag: v2.6.19-rc2^0~6
X-Git-Url: http://127.0.0.1:1234/?p=.git;a=commitdiff_plain;h=99a10a60ba9bedcf5d70ef81414d3e03816afa3f;hp=a5344a9555fffd045218aced89afd6ca0f884e10

[PATCH] Fix up mmap_kmem

vma->vm_pgoff is an pfn _offset_ relatif to the begining
of the memory start. The previous code was doing at first:

	vma->vm_pgoff << PAGE_SHIFT

which results into a wrong physical address since some
platforms have a physical mem start that can be different
from 0. After that the previous call __pa() on this
wrong physical address, however __pa() is used to convert
a _virtual_ address into a physical one.

This patch rewrites this convertion. It calculates the
pfn of PAGE_OFFSET which is the pfn of the mem start
then it adds the vma->vm_pgoff to it.

It also uses virt_to_phys() instead of __pa() since the
latter shouldn't be used by drivers.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 6511012..a89cb52 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -292,8 +292,8 @@ static int mmap_kmem(struct file * file,
 {
 	unsigned long pfn;
 
-	/* Turn a kernel-virtual address into a physical page frame */
-	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
+	/* Turn a pfn offset into an absolute pfn */
+	pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;
 
 	/*
 	 * RED-PEN: on some architectures there is more mapped memory
