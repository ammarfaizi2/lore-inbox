Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTA3XZv>; Thu, 30 Jan 2003 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbTA3XZv>; Thu, 30 Jan 2003 18:25:51 -0500
Received: from [195.208.223.237] ([195.208.223.237]:5504 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267633AbTA3XZu>; Thu, 30 Jan 2003 18:25:50 -0500
Date: Fri, 31 Jan 2003 02:34:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: pci_set_mwi() ... why isn't it used more?
Message-ID: <20030131023419.A652@localhost.park.msu.ru>
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org> <3E2C4FFA.1050603@pacbell.net> <20030130135215.GF6028@krispykreme> <3E3951E3.7060806@pacbell.net> <20030130195944.A4966@jurassic.park.msu.ru> <3E39706D.6080400@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E39706D.6080400@pacbell.net>; from david-b@pacbell.net on Thu, Jan 30, 2003 at 10:35:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 10:35:25AM -0800, David Brownell wrote:
> I think the first answer is better, but it looks like 2.5.59 will
> set the pci cache line size to 16 bytes not 128 bytes in that case.

Yes, and it looks dangerous as the device would transfer incomplete
cache lines with MWI...

> Another option would be to do like SPARC64 and set the cacheline
> sizes as part of DMA enable (which is what I'd first thought of).
> And have the breakage test in the ARCH_PCI_MWI code -- something
> that sparc64 doesn't do, fwiw.

Actually I think there is nothing wrong if we'll try to be a bit
more aggressive with MWI and move all of this into generic
pci_set_master().
To do it safely, we need
- kind of "broken_mwi" field in the struct pci_dev for buggy devices,
  it can be set either by PCI quirks or by driver before pci_set_master()
  call;
- arch-specific pci_cache_line_size() function/macro (instead of
  SMP_CACHE_BYTES) that returns either actual CPU cache line size
  or other safe value (including 0, which means "don't enable MWI");
- check that the device does support desired cache line size, i.e.
  read back the value that we've written into the PCI_CACHE_LINE_SIZE
  register and if it's zero (or dev->broken_mwi == 1) don't enable MWI.

Thoughts?

Ivan.
