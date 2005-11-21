Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVKUQ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVKUQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVKUQ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:26:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22286 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932381AbVKUQ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:26:17 -0500
Date: Mon, 21 Nov 2005 16:25:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Lee Revell <rlrevell@joe-job.com>,
       Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in process 'aplay', page c18eef30)
Message-ID: <20051121162558.GD21032@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Hugh Dickins <hugh@veritas.com>, Lee Revell <rlrevell@joe-job.com>,
	Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@lists.sourceforge.net>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com> <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com> <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com> <s5hlkzinrq5.wl%tiwai@suse.de> <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com> <s5h8xvinfg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xvinfg7.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 05:17:12PM +0100, Takashi Iwai wrote:
> Now another question arises:  Which is the recommended method for
> mmapping RAM pages, vma nopage callback or remap_pfn_range()?
> 
> IIRC, in the ealier versions, the former was recommended because
> remap_page_range() with page-reserve was regarded as a hack.
> But, looking through these changes, I feel that remap_pfn_range() is
> better (easier and stabler) than vma nopage...

And this brings up the question of this age old patch:

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/arch/i386/kernel/pci-dma.c linux/arch/i386/kernel/pci-dma.c
--- orig/arch/i386/kernel/pci-dma.c	Mon Apr  4 22:52:57 2005
+++ linux/arch/i386/kernel/pci-dma.c	Mon Apr  4 22:44:45 2005
@@ -50,7 +50,7 @@ void *dma_alloc_coherent(struct device *
 	ret = (void *)__get_free_pages(gfp, order);
 
 	if (ret != NULL) {
-		memset(ret, 0, size);
+		memset(ret, 0, PAGE_ALIGN(size));
 		*dma_handle = virt_to_phys(ret);
 	}
 	return ret;
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/include/asm-i386/dma-mapping.h linux/include/asm-i386/dma-mapping.h
--- orig/include/asm-i386/dma-mapping.h	Mon Apr  4 22:54:41 2005
+++ linux/include/asm-i386/dma-mapping.h	Mon Apr  4 22:48:11 2005
@@ -16,6 +16,23 @@ void *dma_alloc_coherent(struct device *
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle);
 
+static inline int
+dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
+		  void *vaddr, dma_addr_t handle, size_t size)
+{
+	unsigned long offset = vma->vm_pgoff, usize;
+
+	size = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	usize = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	if (offset >= size || usize > (size - offset))
+		return -ENXIO;
+
+	return remap_page_range(vma, vma->vm_start,
+				__pa(vaddr) + (offset << PAGE_SHIFT),
+				usize << PAGE_SHIFT, vma->vm_page_prot);
+}
+
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)

which provides the dma mmap API which presently is ARM-only on to x86.

Note: the first part of this patch should probably be applied anyway
if you're mmaping dma_alloc_coherent pages to userspace to ensure that
information is not leaked from kernel context.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
