Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVDAS0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVDAS0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVDAS0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:26:19 -0500
Received: from colo.lackof.org ([198.49.126.79]:29117 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262838AbVDASYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:24:24 -0500
Date: Fri, 1 Apr 2005 11:26:09 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jim Gifford <maillist@jg555.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
Message-ID: <20050401182609.GB8178@colo.lackof.org>
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org> <424CC566.3080007@jg555.com> <20050401065120.GD29734@colo.lackof.org> <424D7AE9.5050100@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424D7AE9.5050100@jg555.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 08:46:33AM -0800, Jim Gifford wrote:
> >Code paths exist in tulip_select_media() where the last thing the
> >driver does to the NIC is io_write(). This could easily be a posted
> >write flush problem. Does replacing flush_cache_all() with 
> >"ioread32(ioaddr + CSR12)" also work?
> >
> >The code immediately before this calls tulip_select_media().
> 
> Didn't work,

Can you try replacing flush_cache_all() with the following?
	ioread32(ioaddr + CSR12);
	udelay(500);	/* random delay until someone looks up what is spec'd */

>  I'm going to revert back and try your code and see if it 
> fixes the issue.

Erm...the code in parisc-linux tree won't have the COBALT hacks.
You might try adding selective bits from the parisc-linux tulip.


That fact the flush_cache_all() changes the behavior made me
wonder if IORESOURCE_CACHEABLE is set in the pci resource.
But that doesn't seem to matter for ppc (32 or 64).
Notes on what I learned below.

arch/ppc64/kernel/iomap.c doesn't look at that flag.
arch/ppc/kernel/io.c:pci_ioremap() has the nice comment:
	        if (flags & IORESOURCE_MEM)
                /* Not checking IORESOURCE_CACHEABLE because PPC does
                 * not currently distinguish between ioremap and
                 * ioremap_nocache. 
                 */
                return ioremap(start, len);

ioremap resolves to:
void __iomem *
ioremap64(unsigned long long addr, unsigned long size)
{
        return __ioremap(addr, size, _PAGE_NO_CACHE);
}

I *think* (too many ifdefs) ppc64 does the same in arch/ppc64/mm/init.c.
Cacheing is clear not an issue for accessing MMIO space via pci_iomap().

grant
