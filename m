Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUFWMex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUFWMex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFWMex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:34:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13839 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265368AbUFWMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:34:50 -0400
Date: Wed, 23 Jun 2004 13:34:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matt Porter <mporter@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040623133423.B27549@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
	david-b@pacbell.net, joshua@joshuawise.com
References: <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com> <20040618204322.C17516@flint.arm.linux.org.uk> <s5hoendm3td.wl@alsa2.suse.de> <20040622000838.B7802@flint.arm.linux.org.uk> <40D7941F.3020909@pobox.com> <Pine.LNX.4.58.0406212006270.6530@ppc970.osdl.org> <Pine.LNX.4.58.0406212024550.6530@ppc970.osdl.org> <s5hfz8nnadu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s5hfz8nnadu.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Jun 22, 2004 at 12:40:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 12:40:45PM +0200, Takashi Iwai wrote:
> At Mon, 21 Jun 2004 20:26:39 -0700 (PDT),
> Linus Torvalds wrote:
> > 
> > On Mon, 21 Jun 2004, Linus Torvalds wrote:
> > > 
> > > The argument at some point was that some architectures may not even _have_
> > > a "struct page" for DMA memory, since it's not "normal" memory (ie "slow
> > > memory" on m68k). However, I thought we all agreed that such a "struct
> > > page" could be furnished if that architecture wants so support mmap'ing.
> > 
> > .. which is not to say that we shouldn't have a "pci_mmap_pages()" thing
> > _too_. Pretty clearly the easiest interface often is to just map the pages
> > at mmap() time, and then we should just have a helper function to do that. 
> > 
> > I thought we did one already, but hey, maybe not.
> 
> I don't think we have such.
> 
> Russell has once proposed a similar one (but not pci-specific), and I
> believe it makes sense for many drivers.  We can hide the
> architecture-specific cache handling inside the helper function, too.

Ok.  So does anyone have any objections if I push the ARM DMA mmap
interface upstream, which consists of:

/**
 * dma_mmap_coherent - map a coherent DMA allocation into user space
 * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
 * @vma: vm_area_struct describing requested user mapping
 * @cpu_addr: kernel CPU-view address returned from dma_alloc_coherent
 * @handle: device-view address returned from dma_alloc_coherent
 * @size: size of memory originally requested in dma_alloc_coherent
 *
 * Map a coherent DMA buffer previously allocated by dma_alloc_coherent
 * into user space.  The coherent DMA buffer must not be freed by the
 * driver until the user space mapping has been released.
 */
int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
                      void *cpu_addr, dma_addr_t handle, size_t size);

and a similar one for the ARM-specific "write combining" case (for
framebuffers utilising the DMA API)?

This was discussed on linux-arch, and the discussion died while trying
to settle on a suitable interface through apparant lack of interest.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
