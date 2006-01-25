Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWAYOue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWAYOue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWAYOue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:50:34 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:59353 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751185AbWAYOue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:50:34 -0500
Date: Wed, 25 Jan 2006 23:50:07 +0900 (JST)
Message-Id: <20060125.235007.126576298.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: tbm@cyrius.com, t.sailer@alumni.ethz.ch, perex@suse.cz,
       ralf@linux-mips.org
Subject: ALSA on MIPS platform
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I'm using PCI Sound cards on MIPS platform which has noncoherent
DMA.  There are some issues in ALSA for these platform.

(This topic comes from linux-mips ML.
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060124030725.GA14063%40deprecation.cyrius.com)


1. virt_to_page vs. dma_alloc_coherent problem.

ALSA uses virt_to_page() to get 'struct page' for DMA area which was
allocated using dma_alloc_coherent().  On MIPS with
CONFIG_DMA_NONCOHERENT, typically physical address range
0x0-0x1fffffff are mapped to 0x8000000-0x9fffffff with cached and
mapped to 0xa0000000-0xbfffffff with uncached.  If we got physical
address 0x01000000 for DMA, the virtual address is 0xa1000000.  On the
other hand, virt_to_page() expects normal(cached) virtual address.  So
we can use virt_to_page() with kmalloc() or dma_alloc_noncoherent(),
but not with dma_alloc_coherent().

Here is some fragments from kernel code.  You can see what I mean exactly.

/* from include/asm-mips/mach-generic/spaces.h */
#define CAC_BASE		0x80000000
#define UNCAC_BASE		0xa0000000
#define PAGE_OFFSET		0x80000000UL
/* from include/asm-mips/page.h */
#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
#define pfn_to_page(pfn)	(mem_map + (pfn))
#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
/* from arch/mips/mm/dma-noncoherent.c */
void *dma_alloc_coherent(struct device *dev, size_t size,
	dma_addr_t * dma_handle, gfp_t gfp)
{
	void *ret;

	ret = dma_alloc_noncoherent(dev, size, dma_handle, gfp);
	if (ret) {
		dma_cache_wback_inv((unsigned long) ret, size);
		ret = UNCAC_ADDR(ret);
	}

	return ret;
}

How do we fix this?

A.  hack sound/core/memalloc.c, pcm_native.c, sgbuf.c

something like:
#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
		mark_pages(virt_to_page(CAC_ADDR(res)), pg); /* should be dma_to_page() */
#else
		mark_pages(virt_to_page(res), pg); /* should be dma_to_page() */
#endif

It's ugly.

B.  fix mips virt_to_page()

#define TO_PHYS_MASK 0x1fffffff
#define virt_to_page(kaddr)	pfn_to_page(((kaddr) & TO_PHYS_MASK) >> PAGE_SHIFT)

a bit slower.  MIPS need one instruction to create 0x80000000
constant, two instruction for 0x1fffffff.  There are many usage of
virt_to_page() in mm/slab.c so its performance might be important.

C.  introduce dma_to_page() which returns struct page * for dma_addr_t.

The comment in ALSA code (/* should be dma_to_page() */) mean this?

For MIPS, it would be:
#define dma_to_page(addr) pfn_to_page((addr) >> PAGE_SHIFT)
But I do not know for other platform.


Which is preferred, or is there other good way?


2. mmapping DMA area.

As described above, DMA area is uncached on those platform.  So mmap
should ensure user programs do not cache these area.
snd_pcm_default_mmap() is used for mmapping the DMA area but its
vm_page_prot is not configured as uncached.  On the other hand,
snd_pcm_lib_mmap_iomem() do it using pgprot_noncached().

snd_pcm_default_mmap() should do same thing for those MIPS platform.

static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
				struct vm_area_struct *area)
{
#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
#endif
	area->vm_ops = &snd_pcm_vm_ops_data;

Is this a right fix?  Are there any platform which have same problem?


---
Atsushi Nemoto
