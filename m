Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755429AbWKNGY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbWKNGY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbWKNGY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:24:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:27264 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755429AbWKNGYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:24:55 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Date: Tue, 14 Nov 2006 01:27:19 -0500
User-Agent: KMail/1.8.2
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com> <20061107081839.GA26290@rhlx01.hs-esslingen.de>
In-Reply-To: <20061107081839.GA26290@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140127.20231.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > How useful would it be to simply disable C2 operation (but not C1)
> > > > > in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:
> > 
> > If the goal is saving power, then disabling dynticks will likely
> > be more attractive than disabling C2.  Perhaps you can measure it?

> (Conrad EKM 265, to be precise).

> The results are (waited for values to settle down each time):
> 
> -dyntick4, C1, CONFIG_NO_HZ:
>      83.9W KDE idle, 95.2W bash while 1
> -dyntick4, C2 (C1-only hack disabled, kernel rebuilt), CONFIG_NO_HZ off:
>      84.4W KDE idle, 95.4W bash while 1
> -dyntick4, acpi=off (i.e. APM active), -dynticks:
>      85.5W KDE idle, 95.5W bash while 1
> 
> Bet you didn't see this coming...
>
> Again, this is Athlon 1200 *desktop*, with some EPOX VIA motherboard
> ("8K5A3+" ??).

Yes, I assumed you were running on a laptop...

These three measurements tell me that there is no significant
power savings difference between these configurations on this system.

One has to wonder why the hardware vendor supports C2 on this box,
as its sole function seems  to be to break the local APIC timer...

BTW. when I've had to measure small idle power differences, I've found
variance is smaller when I run at init 1.

> > But this is even more true when talking about C3 -- it certainly saves more
> > power than dynticks does.  This is true for the example system here:
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2006-bltk-paper.pdf
> > 
> > So given that C3 on every known system that has shipped to date
> > breaks the LAPIC timer (and apparently this applies to C2 on these AMD boxes),
> > dynticks needs a solid story for co-existing with C3.
> 
> Indeed, we need a good and flexible fallback mechanism.
> However I would slightly slant dynticks towards being active even in cases
> where it actually happens to consume *slightly* more power due to C2 disabled,
> since it *seems* that CPU load is lower with dynticks
> (less timer background load) / desktop timing is slightly more precise.
> And we all want fast desktops that are waaaaay better than XP, right?

1.
I don't expect dynticks to save significant power on the desktop.
(5-10% would be significant, 1% is not significant)
2.
I do expect dynticks to reduce the load on un-modified virtual guest OSs.
3.
I do expect dynticks it to reduce power on highly power managed mobile systems.

I believe that either #2 or #3 by themselves justify deploying dynticks.

cheers,
-Len
