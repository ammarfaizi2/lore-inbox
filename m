Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWBYN22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWBYN22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWBYN22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:28:28 -0500
Received: from isilmar.linta.de ([213.239.214.66]:33003 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1030242AbWBYN21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:28:27 -0500
Date: Sat, 25 Feb 2006 14:28:20 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Johannes Stezenbach <js@linuxtv.org>,
       Dave Jones <davej@redhat.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060225132820.GA13413@isilmar.linta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Johannes Stezenbach <js@linuxtv.org>, Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <200602250527.03493.ak@suse.de> <20060225125326.GJ3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225125326.GJ3674@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 01:53:26PM +0100, Adrian Bunk wrote:
> > > Doesn't less heat imply less power consumption?
> > 
> > Not in this case no.
> >...
> 
> Sorry for the dumb question, but how could this work physically?
> 
> If a computer produces less heat with the same power consumption, what 
> happens with the other energy?

No. Let's do the math (again), and (again) for the actual values of an Intel
Pentium(R) M Processor, 1400 MHz @ 1.484 V, even though the same rules of
physics, logic and mathematics apply to _all_ processors.

Power consumption in idle state C2 (Stop-Grant state)	 7.3 W
Power consumption when "skipping instructions"
	because of throttling (Stop-Grant state)	 7.3 W

Power consumption when doing work			22.0 W


This means that if the processor idle percentage is _larger_ than (1 -
throttling rate), throttling has no effect at all.


Now, let's assume there is some work for the CPU to do which keeps it busy
for one second @ 1.4 GHz. How much energy is needed to get this work done?

0% throttling:		22 Ws	(1s)
25% throttling:		24 Ws	(1.3s)
50% throttling:		29 Ws	(2s)
75% throttling:		44 Ws	(4s)


Now let's also assume there is nothing else to do during a span of four
seconds: then, independent of the throttling setting, the CPU power
consumption is 44 Ws for these four seconds.


However: for the 75% throttling state, the CPU only produces 11 W of heat
_all the time_ -- this means, the fan or air conditioning must only consider
11 W. For 0%, the CPU may produce 44 W of heat in a second -- and to cool
that sufficiently, the fan _may_ need to run faster, which consumes more
energy than is saved by only having to cool 7.3 W (instead of 11W) the other
three seconds.


So: P4-clockmod style throttling only makes sense if either

a) the idle handler does not enter the Stop-Grant state (C2) efficiently, or

b) the load varies significantly over time in a manner which has effect on
   the fan, and where the latency induced by throttling doesn't matter.


	Dominik
