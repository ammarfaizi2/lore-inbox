Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWCVF5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWCVF5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCVF5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:57:19 -0500
Received: from mail.gmx.de ([213.165.64.20]:50641 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750794AbWCVF5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:57:18 -0500
X-Authenticated: #271361
Date: Wed, 22 Mar 2006 06:57:14 +0100
From: Edgar Toernig <froese@gmx.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod not working in 2.6.16
Message-Id: <20060322065714.169ce224.froese@gmx.de>
In-Reply-To: <20060321220115.GA8583@redhat.com>
References: <1142974528.3470.4.camel@localhost>
	<20060321210106.GA25370@redhat.com>
	<1142978230.3470.12.camel@localhost>
	<20060321220115.GA8583@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>
> Fix the code to disable freqs less than 2GHz in N60 errata.
> 
> -		else if (has_N60_errata[policy->cpu] && p4clockmod_table[i].frequency < 2000000)
> +		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)

Doesn't change anything here - I still get _all_ frequencies where I think
I shouldn't:

| processor       : 0
| vendor_id       : GenuineIntel
| cpu family      : 15
| model           : 2
| model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
| stepping        : 9
| cpu MHz         : 3000.000
[same for cpu 1, it's a single P4 with HT]

Looks like the f29 cpu that should have the errata.

| > cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies
| 375000 750000 1125000 1500000 1875000 2250000 2625000 3000000

| > dmesg|fgrep clockmod
| p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available


Further: the directory cpufreq in /sys is there only for cpu1 - not for cpu0:

| > ls /sys/devices/system/cpu/cpu?
| /sys/devices/system/cpu/cpu0:
| topology
|
| /sys/devices/system/cpu/cpu1:
| cpufreq  topology


And at last: reading Intel's errata it should be good enough to not go
below 25% instead limiting all below 2GHz.  I'm not even sure whether
the 2GHz mentioned there is the reduced or the nominal clock.  Running
2GHz on 12.5% would be a really fast CPU.

| N60.         Processor May Hang under Certain Frequencies and 12.5%
|              STPCLK# Duty Cycle
|
| Problem:     If a system de-asserts STPCLK# at a 12.5% duty cycle, the
|              processor is running below 2 GHz, and the processor thermal
|              control circuit (TCC) on-demand clock modulation is active,
|              the processor may hang. This erratum does not occur under
|              the automatic mode of the TCC.
|
| Implication: When this erratum occurs, the processor will hang.
|
| Workaround:  If use of the on-demand mode of the processor's TCC is desired
|              in conjunction with STPCLK# modulation, then assure that STPCLK#
|              is not asserted at a 12.5% duty cycle.

Ciao, ET.
