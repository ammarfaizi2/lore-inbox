Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUKNI6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUKNI6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUKNI6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:58:40 -0500
Received: from news.suse.de ([195.135.220.2]:34026 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261263AbUKNI6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:58:37 -0500
Date: Sun, 14 Nov 2004 09:58:31 +0100
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Michael Chan <mchan@broadcom.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041114085831.GF16795@wotan.suse.de>
References: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com> <20041113194634.GC3023@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113194634.GC3023@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 12:46:34PM -0700, Grant Grundler wrote:
> On Sat, Nov 13, 2004 at 08:22:50AM -0800, Michael Chan wrote:
> > > If I got the discussion so far correctly then the PCI-SGI spec does not
> > > guarantee that there is no posting, but you know that the chipset
> > > you are using right now doesn't do it.
> > 
> > Yes, that's my understanding of the spec. Grant Grundler does not agree
> >  and thinks that non-posting is the only compliant implementation.
> 
> That's not what I said. I think we do agree. I'll rephrase.
> The code currently in arch/i386 and arch/x86_64 support a chipset that
> is compliant with the part of the spec that requires non-postable
> config writes.
> 
> Other chipsets can implement postable config space. To be compliant
> with the ECN, the architecture must define a method to guarantee
> the posted writes have reached the target device. I think the
> ECN we've been talking about assumes that method will be implemented
> in firmware somehow and NOT as a direct access method in the OS.

Hmm, but there is no way for the chipset to tell us that this 
is needed. 

Perhaps we really need to special case this and add posted pci config
writes to handle Michael's power management issue properly. 

That would be definitely the safer approach.

> 
> > I wish he was right as it would be the easiest to deal with.
> > We contacted Intel about the out-of-spec readl when writing to
> > the PMCSR to change power state as they were the original author
> > of the mmconfig code. Their solution was to remove the readl after
> > confirming that mmconfig was non-posted on their chipsets.
> 
> That means someone has to introduce a new method to access
> mmconfig if they implement postable writes.


Problem is that it adds silently a very subtle bug and there
is no way I know of for ACPI to tell the firmware it shouldn't use
posting. The driver should know when the read is forbidden though.

-Andi
