Return-Path: <linux-kernel-owner+w=401wt.eu-S1752081AbXARSE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXARSE2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXARSE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:04:28 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:6450 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbXARSE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:04:27 -0500
X-AuditID: d80ac21c-a187abb00000330a-1c-45afb6aac1ff 
Date: Thu, 18 Jan 2007 18:04:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nadia Derbey <Nadia.Derbey@bull.net>
cc: Franck Bui-Huu <fbuihuu@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <45AFA490.5000508@bull.net>
Message-ID: <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Jan 2007 18:04:26.0200 (UTC) FILETIME=[172FF580:01C73B2B]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Nadia Derbey wrote:
> 
> Trying to mmap /dev/kmem with an offset I take from /boot/System.map,
> I get an EIO error on a 2.6.20-rc4.
> This is something that used to work on older kernels.
> 
> Had a look at mmap_kmem() in drivers/char/mem.c, and I'm wondering whether
> pfn is correctly computed there: shouldn't we have something like
> 
> pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) +
>       __pa(vma->vm_pgoff << PAGE_SHIFT);
> 
> instead of
> 
> pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;
> 
> Or may be should I substract PAGE_OFFSET from the value I get from System.map
> before mmapping /dev/kmem?

Sigh, you're right, 2.6.19 messed that up completely.
No, you never had to subtract PAGE_OFFSET from that address
in the past, and you shouldn't have to do so now.

Please revert the offending patch below, and then maybe Franck
can come up with a patch which preserves the original behaviour
on architectures which used to work (e.g. i386), while fixing
it for those architectures (which are they?) that did not.

I guess it's reassuring to know that not many are actually
using mmap of /dev/kmem, so you're the first to notice: thanks.

Hugh

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
