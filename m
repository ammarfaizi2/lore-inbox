Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWDRLLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWDRLLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWDRLLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:11:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9383 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932178AbWDRLLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:11:24 -0400
Subject: Re: PCI Device Driver / remap_pfn_range()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Brian D. McGrew" <brian@visionpro.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4443DC09.20606@yahoo.com.au>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B2F38@chicken.machinevisionproducts.com>
	 <4443DC09.20606@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 12:21:15 +0100
Message-Id: <1145359275.18736.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 04:18 +1000, Nick Piggin wrote:
> I'm pretty sure you can't remap_pfn_range vmalloced memory because
> it doesn't use contiguous page frames.

To remap vmalloc memory you need something like this. Note that vmalloc
memory may not be DMA accessible, vmalloc_32 memory maybe. Alternatively
you can build your own scatter gather  lists from pages subject to
hardware limits.

The following GPL code from various drivers shows how to do vmalloc
mapping into an application. Having a common helper for this is a
discussion/todo item when that area of the vm gets future adjustments
but for now this code should do the trick:

/* Here we want the physical address of the memory.
 * This is used when initializing the contents of the
 * area and marking the pages as reserved.
 */
static inline unsigned long kvirt_to_pa(unsigned long adr)
{
        unsigned long kva, ret;

        kva = (unsigned long) page_address(vmalloc_to_page((void
*)adr));
        kva |= adr & (PAGE_SIZE-1); /* restore the offset */
        ret = __pa(kva);
        return ret;
}

static void *rvmalloc(unsigned long size)
{
        void *mem;
        unsigned long adr;

        /* Round it off to PAGE_SIZE */
        size = PAGE_ALIGN(size);

        mem = vmalloc_32(size);
        if (!mem)
                return NULL;

        memset(mem, 0, size);   /* Clear the ram out, no junk to the
user */
        adr = (unsigned long) mem;

        while ((long)size > 0) {
                SetPageReserved(vmalloc_to_page((void *)adr));
                adr += PAGE_SIZE;
                size -= PAGE_SIZE;
        }
        return mem;
}

static void rvfree(void *mem, unsigned long size)
{
        unsigned long adr;

        if (!mem)
                return;

        size = PAGE_ALIGN(size);

        adr = (unsigned long) mem;
        while ((long)size > 0) {
                ClearPageReserved(vmalloc_to_page((void *)adr));
                adr += PAGE_SIZE;
                size -= PAGE_SIZE;
        }
        vfree(mem);
}

