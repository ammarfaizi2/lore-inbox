Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUCUWTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCUWS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:18:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261422AbUCUWRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:17:54 -0500
Message-ID: <405E1483.5060001@pobox.com>
Date: Sun, 21 Mar 2004 17:17:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320133025.GH9009@dualathlon.random>  <20040320144022.GC2045@holomorphy.com>  <20040320150621.GO9009@dualathlon.random>  <20040320121345.2a80e6a0.akpm@osdl.org>  <20040320205053.GJ2045@holomorphy.com>  <20040320222639.K6726@flint.arm.linux.org.uk>  <20040320224500.GP2045@holomorphy.com>  <1079901914.17681.317.camel@imladris.demon.co.uk>  <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if we could jump back a step...

Years ago, I wanted to avoid remap_page_range() when I was writing 
via82cxxx_audio.c, and so Linus suggested the ->nopage approach (which I 
liked, and which is still present today in the sound/oss dir).

AFAICS device drivers have three needs that keep getting reinvented over 
and over again, WRT mmap(2):
1) letting userspace directly address a region allocated by the kernel 
DMA APIs
2) ditto, for MMIO (ioremap)
3) ditto, for PIO (inl/outl)

Alas, #3 must be faked on x86[-64], but this is done anyway for e.g. 
mmap'd PCI config access.  Many platforms implement in[bwl] essentially 
as read[bwl], so for them mmap'd PIO is easy.

#1-3 above are really what device drivers want to do.  My 
suggestion/request to the VM wizards would be to directly provide mmap 
helpers for dma/mmio/pio, that Does The Right Thing.  And require their 
use in every driver.  Don't give driver writers the opportunity to think 
about this stuff and/or screw it up.

If there are special DMA requirements of a particular bus or platform, 
hide that in there.  If some methods of DMA or MMIO or PIO do not lend 
themselves to directly mapping to a struct page, the MM guys may dicker 
about the interface, but the device driver guys just want #1-3 and don't 
really care :)  Either it's directly addressible [via some page table 
magic] from userland, or it isn't.

So please forgive the tangent, but this thread is IMO talking more about 
implementation than the real problem :)  pci_dma_mmap() helper or 
something like it should be the only thing the driver should care about. 
  I'm tired of the same platform bugs and issues, in mmap handlers, 
reappearing over and over again...  Tired of platform-specific ifdefs in 
mmap-capable drivers, too.

	Jeff



