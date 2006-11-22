Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752280AbWKVLiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbWKVLiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbWKVLiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:38:00 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:37768 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1752280AbWKVLiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:38:00 -0500
Date: Wed, 22 Nov 2006 12:37:49 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061122113749.GY18636@pengutronix.de>
References: <20061120220230.GA30835@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061120220230.GA30835@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 11:02:30PM +0100, Ingo Molnar wrote:
> i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the 
> usual place:

[...]

> as usual, bugreports, fixes and suggestions are welcome,

I have problems runinng cyclictest on the more recent -rt kernels. A
similar problem I reported recently on a Pentium M / ICH6 Dell box is
solved by using the acpi_pm timer. 

The problematic box is a 700 MHz Celeron (Coppermine) which doesn't have
ACPI.

The last kernel that run with sane cyclictest results was 2.6.18-rt6:

- root@krachkiste:~/cyclictest-v0.11 ./cyclictest -n -t 4 -p 90 -l 10000
  0.13 0.10 0.13 1/52 2721          
  
  T: 0 ( 2718) P:90 I:    1000 C:   10000 Min:      14 Act:      47 Avg:      52 Max:     170
  T: 1 ( 2719) P:89 I:    1500 C:    6667 Min:      16 Act:      22 Avg:      45 Max:     138
  T: 2 ( 2720) P:88 I:    2000 C:    5001 Min:      16 Act:      35 Avg:      44 Max:     101
  T: 3 ( 2721) P:87 I:    2500 C:    4001 Min:      14 Act:      28 Avg:      38 Max:     114

The following numbers have been taken on 2.6.19-rc6-rt5, the effect is there
since 2.6.18-rt7.

- "cyclictest -n -p 90 -t 4" is just "running upwards". 

  root@krachkiste:~/cyclictest-v0.11 ./cyclictest -n -p 90 -t 4 -l 1000
  0.00 0.00 0.00 1/54 2843          
  
  T: 0 ( 2840) P:90 I:    1000 C:    1000 Min:    7294 Act: 3008486 Avg: 1508852 Max: 3008486
  T: 1 ( 2841) P:89 I:    1500 C:    1000 Min:    7195 Act: 2508885 Avg: 1258994 Max: 2508885
  T: 2 ( 2842) P:88 I:    2000 C:    1000 Min:    7188 Act: 2009375 Avg: 1009235 Max: 2009375
  T: 3 ( 2843) P:87 I:    2500 C:    1000 Min:    7184 Act: 1509868 Avg:  759479 Max: 1509868

- Using a relative timer (-r), I get huge latencies:

  root@krachkiste:~/cyclictest-v0.11 ./cyclictest -n -p 90 -t 4 -r -l 1000
  0.00 0.00 0.00 1/56 2838          
  
  T: 0 ( 2835) P:90 I:    1000 C:    1000 Min:     742 Act:    6937 Avg:    6952 Max:    9214
  T: 1 ( 2836) P:89 I:    1500 C:    1000 Min:     244 Act:    6424 Avg:    6454 Max:    8718
  T: 2 ( 2837) P:88 I:    2000 C:     999 Min:    1288 Act:    5910 Avg:    5962 Max:    8216
  T: 3 ( 2838) P:87 I:    2500 C:     999 Min:     778 Act:    5409 Avg:    5462 Max:    7713

This is with "lapic lapictimer" on the kernel commandline. 

The system has chosen "pit" as it's clocksource, switching to tsc or jiffies
doesn't change anything. 

With 2.6.18-rt6 I've seen these lines in the dmesg output:

Nov 22 12:05:24 krachkiste kernel: Time: tsc clocksource has been installed.
Nov 22 12:05:24 krachkiste kernel: Event source pit disabled
Nov 22 12:05:24 krachkiste kernel: Event source lapic configured with caps set: 08
Nov 22 12:05:24 krachkiste kernel: hrtimers: Switched to high resolution mode CPU 0

Especially the "Switched to high resolution mode" isn't there with the later
kernels (high resolution timers is on in the config, dyntick is off).

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

