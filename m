Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUEOGqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUEOGqb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUEOGqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:46:31 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:34715 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264655AbUEOGq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:46:28 -0400
Date: Sat, 15 May 2004 08:44:34 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: linux-kernel@tux.tmfweb.nl
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040515064434.GB8572@dominikbrodowski.de>
Mail-Followup-To: linux-kernel@tux.tmfweb.nl,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
	moqua@kurtenba.ch
References: <20040513173946.GA8238@dominikbrodowski.de> <20040514214751.GA8433@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514214751.GA8433@nospam.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:47:51PM +0200, rutger@nospam.com wrote:
> > Not necessarily. It's not really every eigth tick where work is done, but
> > more like 800 ticks where work is done, then 5600 ticks pause, and so on --
> > the frequency is somewhere in the docs, I forgot the exact value... So I'm
> > not 100% convinced the measurements you've done do show something broken.
> 
> Ah, ok! This makes the measurement next to impossible. Unless we
> generate instructions of ~900 ticks, which should takes 900 + 5600
> ticks in case of modulated clock, and 900 ticks in case of
> non-modulated clock. Something to try...

As I said, I forgot the actual frequency, so 800 ticks is a guess...

> root@localhost /sys/devices/system/cpu/cpu0/cpufreq# cat scaling_available_frequencies 
> 350000 700000 1050000 1400000 1750000 2100000 2450000 2800000 
> root@localhost /sys/devices/system/cpu/cpu0/cpufreq# for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat scaling_cur_freq ; done
> 350000
> 700000
> 1050000
> 1400000
> 1750000
> 2100000
> 2450000
> 2800000
> 
> Seems to work...
Hm, could you please do 

# for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat cpuinfo_cur_freq ; cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq ; done

instead? scaling_cur_freq doesn't give as useful _debug_ results as
cpuinfo_cur_freq, and it's important to get it for _both_ siblings after
_each_ change

> Some remarks:
>  - scaling_governor and scaling_setspeed get length 0 after echo-ing to.
>    Other files keep the virtual size of 4096.
That's some sort of sysfs "handling" - don't know about details and
consequences.

>  - scaling seems to work reliable now _if_ I repeat the scaling for
>    each virtual processor and make them the same. It doesn't do
>    anything useful if I only set cpu0.

Maybe because much/more work is done by the other sibling then... however,
without the test above [cpuinfo_cur_freq for both siblings] I can't say
much, I'm afraid.

> However, what's the use of p4-clockmod if it doesn't have impact on
> the temperature and the power consumption of the CPU?

The use of the p4-clockmod driver is that it puts the CPU into a low-power
state -- it only has thermal and power consequences, however, if either the
"idling" does not work, or the processor load is higher than the frequency
the CPU is put into by p4-clockmod.

> My Asus p4p800 seems to be able to set several voltages and frequences
> in the BIOS; can those be set runtime?

No. This is motherboard-specific. The P4 does not support _voltage scaling_,
i.e. runtime voltage adjustment based on current power needs. It also
doesn't support _frequency scaling_, just (thermal) throttling.

> And/or is there any
> documentation on this? This would make for a much more useful driver.

Unfortunately, p4-clockmod isn't really all that useful -- but that's
because the hardware doesn't support voltage and/or frequency scaling.

	Dominik
