Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWGGMKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWGGMKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWGGMKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:10:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:14825 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932140AbWGGMKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:10:16 -0400
To: "Mark Langsdorf" <mark.langsdorf@amd.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
Subject: Re: [PATCH] Allow all Opteron processors to change pstate at same time
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
From: Andi Kleen <ak@suse.de>
Date: 07 Jul 2006 14:10:14 +0200
In-Reply-To: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
Message-ID: <p73fyhdpqe1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark Langsdorf" <mark.langsdorf@amd.com> writes:

[cc'ing back to discuss and cpufreq]

> The current generation of Opteron processors do not provide a frequency 
> independent TSC.  This causes wild gettimeofday skew on systems that 
> enable cpufreq while using TSC as a gtod source.
> 
> This patch provides a workaround by changing all processors to the same 
> frequency at the same time, so that the TSC on each processor never 
> increments at a different rate than the TSC on another processor.
> 
> the "powernow-k8.tscsync=1" options enables simeltameous transitions.  
> Other options are necessary to force the use of TSC as a gtod source.
> 
> This patch should apply cleanly to the 2.6.18-rc1 kernel.

Your patch seems to be ^M damaged.

I'm still dubious if the result is really correct if the hardware
wasn't designed to guarantee synchronous TSC operation.

Can you do the following test please? 

- Set this option
- Let the system run for let's say a day or two with some freq transitions
and varying loads
[Better would be to let two systems run in this way to compare]
- Then hotunplug all the CPUs >0 with
for i in /sys/devices/system/cpu/cpu*/online ; do echo 0 > $i ; done
- Wait a bit 
- Restart them again with 
for i in /sys/devices/system/cpu/cpu*/online ; do echo 1 > $i ; done

The kernel should now print the results of the TSC resync for the
replugged CPUs with output like this

CPU N: Syncing TSC to CPU 0.
CPU N: synchronized TSC with CPU 0 (last diff XXX cycles, maxerr YYY cycles)

How do these numbers look like, also compared to the original boot
output?

If the cycles diverge more between the different CPUs it would be a bad sign. 
It would mean that the error would add up over longer runtime
and timing would get more and more unstable.

-Andi

