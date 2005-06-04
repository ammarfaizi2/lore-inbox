Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFDAMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFDAMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFDALT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:11:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43712 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261180AbVFDAIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:08:53 -0400
Message-ID: <42A0F10D.8020308@pobox.com>
Date: Fri, 03 Jun 2005 20:08:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <gregkh@suse.de>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com>  <42A0E4B4.3050309@pobox.com> <1117843264.31082.204.camel@gaston>
In-Reply-To: <1117843264.31082.204.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>	pci_enable(info on what to enable)
>>
>>so that drivers can specify ahead of time "don't enable PIO, only MMIO", 
>>"don't enable MMIO, only PIO", "don't use MSI", etc.  and add a 
>>pci_disable() to undo all of that.
>>
>>The more we add singleton functions like pci_enable_msi(), 
>>pci_set_master(), etc. the more I wish for a single function that 
>>handled all those details at one atomic point.  There is a lot of 
>>standard patterns that are hand-coded into every PCI driver's probe 
>>functions.
> 
> 
> Agreed, with the proper arch hook to deal with arch brokenness of
> course.
> 
> That could be a bitmap. What I'm not 100% confident at this point is
> wether we want a bit per BAR or an "IO" bit and an "MMIO" bit. I think
> I'd rather go for the first one.

A bitmap is what I would start with.  But I would implement it as

	struct pci_enable_info {
		unsigned long flags;
	};

because I guarantee we'll want more flexibility as time goes on.

Honestly I can think of situations where one driver would want a bit per 
BAR, and many others would just need a single MMIO bit.  Don't forget 
legacy decoding too:  with -only- a bit per BAR, the driver cannot tell 
the PCI layer that disabling IO means disabling a legacy ISA region 
that's not listed in the PCI BARs.

	Jeff



