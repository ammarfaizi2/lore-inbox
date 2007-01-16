Return-Path: <linux-kernel-owner+w=401wt.eu-S1751281AbXAPT2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXAPT2F (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbXAPT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:28:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3886 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbXAPT2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:28:04 -0500
Date: Tue, 16 Jan 2007 20:28:00 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] update MMConfig patches w/915 support
Message-ID: <20070116192800.GB4192@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org> <200701071144.16045.jbarnes@virtuousgeek.org> <20070108204520.GB15481@dspnet.fr.eu.org> <200701081327.16019.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701081327.16019.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 01:27:15PM -0800, Jesse Barnes wrote:
> On Monday, January 8, 2007 12:45 pm, Olivier Galibert wrote:
> > On Sun, Jan 07, 2007 at 11:44:16AM -0800, Jesse Barnes wrote:
> > > For reference, here's the probe routine I tried for 965, probably
> > > something dumb wrong with it that I'm not seeing atm.
> >
> > It shouldn't have mattered in your case, but base_address is limited
> > to 32bits.  There is a 32 bits reserved zone after it so hope is not
> > to be lost, but in any case the current code can't handle over-4G
> > base addresses at that point.
> >
> > Does the bios or your '965 give a correct acpi mmconfig entry?
> 
> I should have captured the debug printk I put in while testing.  I think 
> the base address specified in the register was 0xf0000000, with a size 
> of 256M marked enabled.  Arjan points out that this likely conflicts 
> with other BIOS mappings, which is probably why I saw my machine hang 
> when I tried to use it.
> 
> As for ACPI, I assume you mean the MCFG table?  I haven't looked at it, 
> but the stock kernel complains about a lack of the MCFG range in the 
> e820 table and subsequently disables mmconfig.
> 
> But won't the bridge register value control what actually gets decoded?  
> If so, it sounds like this BIOS is buggy wrt mmconfig mapping in 
> general; good thing I'm not using any PCIe devices I guess...

Yeah.  I've checked the docs, I think I know what's going on.  On one
hand, if the chipset is configured to have the range somewhere, it is
decoded before anything external to the chipset, be it ram or mmaped
i/o.  So the information you get from the chipset should not be able
to conflict with anything by definition, it's the anything that
wouldn't be visible.

But in your case of a f0000000-ffffffff mapping, something else
interesting is going on: it's conflicting with other internal
registers of the chipset, which, being fixed address, probably have
priority.  So you probably have to either reduce the range so that the
chipset registers aren't touched, or drop mmconfig if the address is
f0000000.

Technically, we can have the exact same problem with the other
chipsets.  BIOSen suck.

  OG.

