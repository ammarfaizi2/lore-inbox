Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754080AbWKGGix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbWKGGix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbWKGGix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:38:53 -0500
Received: from hera.kernel.org ([140.211.167.34]:1167 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1754080AbWKGGiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:38:52 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Date: Tue, 7 Nov 2006 01:41:16 -0500
User-Agent: KMail/1.8.2
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de>
In-Reply-To: <20061106205825.GA26755@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611070141.16593.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 15:58, Andreas Mohr wrote:

> > > How useful would it be to simply disable C2 operation (but not C1)
> > > in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:

If the goal is saving power, then disabling dynticks will likely
be more attractive than disabling C2.  Perhaps you can measure it?
eg. simply run "bltk -I" to measure idle battery life (http://sourceforge.net/projects/bltk)

But this is even more true when talking about C3 -- it certainly saves more
power than dynticks does.  This is true for the example system here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2006-bltk-paper.pdf

So given that C3 on every known system that has shipped to date
breaks the LAPIC timer (and apparently this applies to C2 on these AMD boxes),
dynticks needs a solid story for co-existing with C3.

If  (HPET re-programming latency is not prohibititive)
	If  (there is an HPET/thread)
		then using the HPET/thread instead of the LAPIC timer is the way to go
	else If ( there is an HPET/core, or /package)
		then using the HPET for the timer interrupt to a group of threads
		maybe the way to go.  (interrupt needs to be re-sent to the actual
		destination via IPI)
else if (PIT re-programming latency is not prohibitive)
		then using PIT to cpu0 and IPI to the cpu of interest would work
else
	The HW isn't well suited to dynticks,
	fall back to a static HZ mode at boot-time.
	Though I suppose that "static HZ" could actually be a variable
	set at boot-time rather than the compile-time scheme we use today.
	Eg. if a box has high-latency C-states, it certainly wants hz<=64
	Boxes with just C1 will not care and would go for hz= faster

-Len

