Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUEOKvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUEOKvL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 06:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUEOKvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 06:51:10 -0400
Received: from wingding.demon.nl ([82.161.27.36]:34176 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S261851AbUEOKu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 06:50:59 -0400
Date: Sat, 15 May 2004 12:52:01 +0200
From: rutger@nospam.com
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040515105200.GA8095@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20040513173946.GA8238@dominikbrodowski.de> <20040514214751.GA8433@nospam.com> <20040515064434.GB8572@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515064434.GB8572@dominikbrodowski.de>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ah, ok! This makes the measurement next to impossible. Unless we
> > generate instructions of ~900 ticks, which should takes 900 + 5600
> > ticks in case of modulated clock, and 900 ticks in case of
> > non-modulated clock. Something to try...
> 
> As I said, I forgot the actual frequency, so 800 ticks is a guess...

The only thing I could find in Intel's documentation is the max. time
of throttling is 3 microseconds (p.67; 5.2.1 of Prescott
datasheet). So this 3 microseconds should correspond to 5600 ticks or
so...

> 
> > root@localhost /sys/devices/system/cpu/cpu0/cpufreq# cat scaling_available_frequencies 
> > 350000 700000 1050000 1400000 1750000 2100000 2450000 2800000 
> > root@localhost /sys/devices/system/cpu/cpu0/cpufreq# for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat scaling_cur_freq ; done
> > 350000
> > 700000
> > 1050000
> > 1400000
> > 1750000
> > 2100000
> > 2450000
> > 2800000
> > 
> > Seems to work...
> Hm, could you please do 
> 
> # for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat cpuinfo_cur_freq ; cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq ; done
> 
> instead? scaling_cur_freq doesn't give as useful _debug_ results as
> cpuinfo_cur_freq, and it's important to get it for _both_ siblings after
> _each_ change

/sys/devices/system/cpu/cpu0/cpufreq# for f in `cat scaling_available_frequencies `; do echo $f >scaling_setspeed ; cat cpuinfo_cur_freq ; cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq;  done
350000
2800000
700000
2800000
1050000
2800000
1400000
2800000
1750000
2800000
2100000
2800000
2450000
2800000
2800000
2800000

..so it has only effect on the same sibbling, not the other. That's
what I meant with 'repeat scaling for each virtual processor'.

> >  - scaling seems to work reliable now _if_ I repeat the scaling for
> >    each virtual processor and make them the same. It doesn't do
> >    anything useful if I only set cpu0.
> 
> Maybe because much/more work is done by the other sibling then... however,
> without the test above [cpuinfo_cur_freq for both siblings] I can't say
> much, I'm afraid.

That's true. I can set the freq. of each virtual CPU. Probably not
very useful, and even confusing. And if we keep this, the scheduler
should be told about the speed differences of both (virtual)
processors.

> > However, what's the use of p4-clockmod if it doesn't have impact on
> > the temperature and the power consumption of the CPU?
> 
> The use of the p4-clockmod driver is that it puts the CPU into a low-power
> state -- it only has thermal and power consequences, however, if either the
> "idling" does not work, or the processor load is higher than the frequency
> the CPU is put into by p4-clockmod.

I saw several sleep states in which the processor can reside (like
when using the 'hlt' instruction) like S3; would those help?

> 
> > My Asus p4p800 seems to be able to set several voltages and frequences
> > in the BIOS; can those be set runtime?
> 
> No. This is motherboard-specific. The P4 does not support _voltage scaling_,
> i.e. runtime voltage adjustment based on current power needs. It also
> doesn't support _frequency scaling_, just (thermal) throttling.

I know this is not P4 specific, but motherboard specific, but do
you know of modules which use motherboard specific knowledge to scale
the processor? If the BIOS can do it, so should we be able to do it.

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
