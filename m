Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTIRKc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 06:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbTIRKc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 06:32:29 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:60291 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262106AbTIRKcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 06:32:17 -0400
Date: Thu, 18 Sep 2003 12:32:13 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stevie-O <oliver@klozoff.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aliasing physical memory using virtual memory (from a d
Message-ID: <20030918103212.GA7174@vana.vc.cvut.cz>
References: <80BC15566D@vcnet.vc.cvut.cz> <3F68FEEC.5020809@klozoff.com> <3F6905FE.5030106@klozoff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6905FE.5030106@klozoff.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 09:10:22PM -0400, Stevie-O wrote:
> Stevie-O wrote:
> 
> >
> >I grepped my 2.4 kernel source for 'vmap' and the only results that 
> >seemed meaningful were vmap_pte_range or vmap_pmd_range in 

2.4.22-ac1 has it. In mm/vmalloc.c. You cannot (well, I believe) use
any functions which take page array if pages were not allocated one
by one. Maybe you can try using page and page+1, but I'm under
impression that it will not work as expected, and that you'll hit
some BUG() somewhere.

> >mips/mm/umap.c and mips64/mm/umap.c. Is this documented somewhere? I 
> >suffer from the 'i'm new at this, but this looks possible' syndrome. I 
> >don't actually know how anything is accomplished.
> >
> >Btw, am I right about kmalloc(35000) effectively grabbing 64K?

Yes.  

> I did a freetext search of the LXR for 'remap' and came up with this 
> function:
> 
> 820 /*
> 821  * maps a range of physical memory into the requested pages. the old
> 822  * mappings are removed. any references to nonexistent pages results
> 823  * in null mappings (currently treated as "copy-on-access")
> 824  */
> 825 static inline void remap_pte_range(pte_t * pte, unsigned long address, 
> unsigned long size,
> 826         unsigned long phys_addr, pgprot_t prot)

Unavailable outside of mm. You must use remap_page_range. And this function
can only remap memory which does not have its 'struct page' (i.e. MMIO on
PCI busses) or pages marked as Reserved. So if you want to use it on
regular memory, you must mark pages reserved... And then you have to do
black magic to correctly remove 'PageReserved' bit at correct time - if 
process does fork, and you'll clear this bit too early, you'll get
page_count < 0 and BUG(). If you'll do that too late, you'll leak memory.
vmmon did this in the past, but it was impossible to get it right under all
possible circumstances.

Other problem is that this functions is targeted for remapping userspace
addresses, not kernel space, and I would not trust this function for using
with from in kernel space. Definitely 2.6.x with 4G/4G patch will do bad
things.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
