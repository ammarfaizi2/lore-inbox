Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTHUIZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbTHUIZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:25:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36246 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262507AbTHUIZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:25:21 -0400
Date: Thu, 21 Aug 2003 10:25:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030821082512.GG11263@ucw.cz>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1D7@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D1D7@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 10:51:39AM -0700, Pallipadi, Venkatesh wrote:

> The way I got standard mode to work was by removing the dependency on
> the early timer tick.  IIRC, the dependency is basically coming from
> Bogomips calculation and also halt_works_ok check. We can try and
> delay this until IOAPIC initialization.

Indeed. The main problem, however, for me was to decide which IRQ to use
for the HPET. The HPET has a big mask of allowable IRQs, the APIC has
many pins - so how to decide which one to use and if possible not share
it with a PCI device?

> > Well, the APIC should have quite a number of free pins, which means
> > that the HPET shouldn't need to share an interrupt. 
> 
> We interacted with some server folks, and they were of the opinion
> that they may not be able to give a dedicated interrupt for HPET, as
> already they have too many devices sitting on PCI these days. If they
> have to give a dedicated IRQ for HPET, they may have to share some
> other devices, which may result in performance loss. Another reason
> against it was, if they give a dedicated IRQ and the OS decides
> against using HPET (or older version of OS), then an IRQ will be
> needlessly wasted (kind of a chicken and egg problem).

Well, the number of interrupts if you have IO-APICs (or SAPICs) is
almost unlimited ... and usually on the IO-APIC that handles the PC
legacy there are some spare pins. Nevermind, I don't think it'd be a
huge problem to share the timer interrupt pin with some device.

> > Regarding lost and late delivered timer interrupts - that happens
> > nevertheless with drivers disabling interrupts for a long time. The
> > kernel timekeeping code can cope with that.
> 
> I agree that kernel can cope with the timer interrupt inaccuracy. But,
> IMO, delays due to driver disabling the interrupts is more of an
> exception case. With timer in shared interrupt, this will become more
> of a common case.

Well, the driver is supposed to reenable the interrupt as soon as it can
(possibly disabling the card itself from generating further interrupts),
so it's back to bad drivers even in this case.

> Our thinking was to have a two phased approach. Have the legacy mode
> enabled first. Make sure that the code around HPET interrupts is fully
> optimized and is working fine. This mode is any way _required_ for
> systems without IOAPIC and systems running UP kernels / with IOAPIC
> disabled. Later we can add an option to use HPET standard mode.

That'd work probably. I don't believe there will ever be systems with
HPET and without a working IOAPIC. But, well, insane things do happen.

As for the user disabling it, we could disable HPET then, too. Anyway, I
agree with your proposal of first going for legacy mode and doing native
mode later. 

(PS. It's a pretty stupid thing in the HPET spec to only be able to
 gobble up BOTH the PIT and RTC interrupts and not separately.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
