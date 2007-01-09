Return-Path: <linux-kernel-owner+w=401wt.eu-S932433AbXAIWBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXAIWBx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbXAIWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:01:53 -0500
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:5259 "EHLO
	outbound1-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932433AbXAIWBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:01:52 -0500
X-Greylist: delayed 5559 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 17:01:51 EST
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Understanding cpufreq?
Date: Tue, 9 Jan 2007 14:28:59 -0600
Message-ID: <1449F58C868D8D4E9C72945771150BDFD964A1@SAUSEXMB1.amd.com>
In-Reply-To: <45A3D6A5.6080302@moving-picture.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Understanding cpufreq?
Thread-Index: Acc0H2dwPksAh3M0SN+fVbd3vCK5xgADDOXg
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "James Pearson" <james-p@moving-picture.com>, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 09 Jan 2007 20:28:59.0839 (UTC)
 FILETIME=[CB5C7CF0:01C7342C]
X-WSS-ID: 69BD24812MC4635282-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These machines are running a 2.6.9-42 RHEL4 kernel with the 
> powernow-k8 module loaded - which I believe have backported
> cpufreq support from more recent mainline kernels.

To an extent.  The problem is not the powernow-k8 driver,
but the cpufreq infrastructure.  See below.

> In trying to achieve what I want, I've become rather confused 
> as to how cpufreq in a multi-CPU environment works:
> 
> There is a directory under 
> /sys/devices/system/cpu/cpu*/cpufreq for each 
> CPU, which seems to imply that each CPU speed can be controlled 
> separately - can this really be the case? Can separate CPU 
> cores run at different speeds?

No, but prior to 2.6.10, cpufreq discovers each core
independently, and creates a directory independently.
The powernow-k8 knows which cores are on the same processors,
and handles them together.

After 2.6.10, cpufreq understands multicore devices and
creates 1 directory for the entire processor and then
creates symbolic links for all the cores that share the
same pstates.

> e.g. I can echo 4 different governor names to the 
> scaling_governor file in each
> /sys/devices/system/cpu/cpu[0-3]/cpufreq directory on 
> a 4 core machine - and the resulting scaling_cur_freq
> file can contain a different value.
> 
> However, the "cpu MHz" fields in /proc/cpuinfo are all the 
> same for each each CPU - I assume the values in /proc/cpuinfo
> are the 'correct' values ??
> 
> Also, if I set all the governors to userspace, and then set 
> each CPU's speed via scaling_setspeed to a different
> (allowed) value, then it appears quite random as to which
> value is then reflected in /proc/cpuinfo i.e. sometimes
> it will take the value given to CPU 0, 
> other times it will be CPU 1 etc.
 
It's always the highest requested value of all cores on
a processor.  powernow-k8 keeps track of the requested
frequencies, though, so you can have some weird situations.

ie, from boot up:
	core0 800 MHz	core1 800 MHz	CPU 800 MHz
	core0 to 2000 MHz	core1 800 MHz	CPU 2000 MHz
	core0 2000 MHz	core1 to 1800 MHz	CPU 2000 MHz
	core0 to 800 MHz	core1 1800 MHz	CPU 1800 MHz

> If I set all the governors to ondemand, the CPUs will from 
> time to time, clock back their speed in situations where
> one or more CPUs are being heavily used. i.e it appears
> that each CPU is treated separately, and if 
> one CPU is deemed to be idle enough by its given metrics,
> then it can reduce the speed of all CPUs, regardless of
> other CPUs being 'busy' ...

That shouldn't happen, unless ondemand requests a low
frequency to all cores.

> Essentially what I want to achieve is something like:
> if _any_ CPU is 'busy' (usage over some threshold over
> some sampling period), then run at full speed and
> if _all_ CPUs are 'idle' (all below some threshold 
> over some sampling period) then clock back the CPUs.

This should be happening automatically in RHEL4.

Note that the 2.6.10 kernel changed cpufreq behavior
dramatically, and now the most recent frequency request 
wins.

-Mark Langsdorf
powernow-k8 maintainer
AMD, Inc.


