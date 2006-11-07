Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754090AbWKGISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbWKGISm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbWKGISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:18:42 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:20135 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1754090AbWKGISl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:18:41 -0500
Date: Tue, 7 Nov 2006 09:18:39 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Len Brown <lenb@kernel.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061107081839.GA26290@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611070141.16593.len.brown@intel.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 07, 2006 at 01:41:16AM -0500, Len Brown wrote:
> On Monday 06 November 2006 15:58, Andreas Mohr wrote:
> 
> > > > How useful would it be to simply disable C2 operation (but not C1)
> > > > in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:
> 
> If the goal is saving power, then disabling dynticks will likely
> be more attractive than disabling C2.  Perhaps you can measure it?
> eg. simply run "bltk -I" to measure idle battery life (http://sourceforge.net/projects/bltk)

Surely the CMOS battery?? Seriously, no battery here anywhere ;)

Anyway, I was already afraid that I didn't have any of my *two* different
power measurement devices here, but  then I found one in the drawer
(Conrad EKM 265, to be precise).

The results are (waited for values to settle down each time):

-dyntick4, C1, CONFIG_NO_HZ:
     83.9W KDE idle, 95.2W bash while 1
-dyntick4, C2 (C1-only hack disabled, kernel rebuilt), CONFIG_NO_HZ off:
     84.4W KDE idle, 95.4W bash while 1
-dyntick4, acpi=off (i.e. APM active), -dynticks:
     85.5W KDE idle, 95.5W bash while 1

Bet you didn't see this coming...

Again, this is Athlon 1200 *desktop*, with some EPOX VIA motherboard
("8K5A3+" ??).

Note that even with dynticks disabled did I have a pause on boot where I had
to fiddle with the keyboard once to continue booting, IOW our APIC timer
probing disrupts normal interrupt processing due to C2 -> C3 AMD BIOS bug.
We might want to fix probing to not require manual generation of the next
interrupt event due to APIC timer temporarily being "dead".

> But this is even more true when talking about C3 -- it certainly saves more
> power than dynticks does.  This is true for the example system here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2006-bltk-paper.pdf
> 
> So given that C3 on every known system that has shipped to date
> breaks the LAPIC timer (and apparently this applies to C2 on these AMD boxes),
> dynticks needs a solid story for co-existing with C3.

Indeed, we need a good and flexible fallback mechanism.
However I would slightly slant dynticks towards being active even in cases
where it actually happens to consume *slightly* more power due to C2 disabled,
since it *seems* that CPU load is lower with dynticks
(less timer background load) / desktop timing is slightly more precise.
And we all want fast desktops that are waaaaay better than XP, right?

Andreas Mohr
