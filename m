Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbTHTIQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTHTIPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:15:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:50865 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261829AbTHTIKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:10:54 -0400
Date: Wed, 20 Aug 2003 10:10:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030820081047.GD17793@ucw.cz>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CE@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CE@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 06:28:40PM -0700, Pallipadi, Venkatesh wrote:
> 
> I experimented with HPET in native APIC routing mode. But, there 
> are couple of issues in that space:
> 
> 1) During boot up kernel expects to receive timer interrupt much
> before the IO-APIC initialization is done. If HPET uses native mode,
> it cannot generate timer interrupts till IOAPICs are initialized. So,
> we need to have some sort of Workarounds in generic kernel to avoid
> dependency on timer interrupt during the early boot.

Yes, that is a problem. We could do some switchover from PIT to HPET (or
from legacy to IOAPIC IRQs) after APICs are initialized, though I don't
like the idea very much. Best would be to remove the dependence on the
timer interrupt ticking so early. Or moving APIC detection earlier.

> 2) More important question is, do we really want to share timer
> interrupt with other PCI devices? This potentially can add some delay
> in the timer interrupt processing, and thus we may end up getting
> inaccurate time (and inaccurate timer interrupts) in the kernel.

Well, the APIC should have quite a number of free pins, which means that
the HPET shouldn't need to share an interrupt. Regarding lost and late
delivered timer interrupts - that happens nevertheless with drivers
disabling interrupts for a long time. The kernel timekeeping code can
cope with that.

> Thanks, -Venkatesh
> > -----Original Message----- From: Vojtech Pavlik
> > [mailto:vojtech@suse.cz] Sent: Tuesday, August 19, 2003 3:41 PM To:
> > Pallipadi, Venkatesh Cc: linux-kernel@vger.kernel.org;
> > torvalds@osdl.org; Nakajima, Jun; Mallick, Asit K Subject: Re:
> > [PATCH][2.6][5/5]Support for HPET based timer
> > 
> > 
> > On Tue, Aug 19, 2003 at 12:20:22PM -0700, Pallipadi, Venkatesh
> > wrote:
> > 
> > > 5/5 - hpet5.patch - This can be a standalone patch. Without this
> > > patch we loose interrupt generation capability of RTC (/dev/rtc),
> > > due to HPET. With this patch we basically try to emulate RTC
> > > interrupt functions in software using HPET counter 1.
> > > 
> > 
> > This is very wrong IMO. We shouldn't try to emulate the RTC
> > interrupt for the kernel, instead the HPET should use native APIC
> > interrupt routing. This way the RTC will keep working and the
> > 'legacy mode' of HPET doesn't need to be used. I must admit I was a
> > bit lazy when I was implementing the x86_64 variant and the native
> > IRQ for HPET is still on my to-do list.
> > 
> > -- Vojtech Pavlik SuSE Labs, SuSE CR
> > 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
