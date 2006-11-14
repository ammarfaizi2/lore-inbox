Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWKNDyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWKNDyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933333AbWKNDyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:54:12 -0500
Received: from elvis.mu.org ([192.203.228.196]:8156 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S933278AbWKNDyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:54:10 -0500
Message-ID: <45593DD8.80301@FreeBSD.org>
Date: Mon, 13 Nov 2006 19:54:00 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
References: <455916A5.2030402@FreeBSD.org> <200611140305.00383.ak@suse.de> <45592929.2000606@FreeBSD.org> <200611140344.00407.ak@suse.de>
In-Reply-To: <200611140344.00407.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Because CPUID returns the APIC ID, and I was under the impression that 
>>the cpu numbers
>>smp_processor_id() were dynamically allocated and didn't necessarily 
>>match the
>>APIC ID.
> 
> 
> Correct, but one can use a mapping table.
> 
>>Yes, it's only needed on HLT and cpufreq change.
>>The code here is to force a "resynch" with the HPET if we've done a HLT. 
>>  It has to be done before we switch to any userland thread that might 
>>use the per-cpu vxtime. switch_to() seemed like the most natural place 
>>to put this.
> 
> 
> I don't think so. The natural place after HLT is in the idle loop or 
> better in idle notifiers[1] and after  cpufreq is in the appropiate cpufreq 
> notifiers.
>  
> 
> [1] unfortunately they are still subtly broken in .19, but will be fixed
> in .20

I initially had it after the HLT in the idle loop, but realized there 
would be a small race: We could get switched away from the idle thread 
after the HLT but before doing the resynch.

It seems like idle notifiers would do the trick, except that they don't 
appear to include the id of the CPU that went/exited from idle.

Do you want me to also send a patch that addresses this?

>>A cow-orker suggested that we use SIDT and encode the CPU number in the 
>>limit of the IDT, which should be even faster than LSL.
> 
> 
> Possible yes. Did you time it?
 >
> But then we would make the IDT variable length in memory? While
> the CPUs probably won't care some Hypervisors seem to be picky
> about these limits. LSL still seems somewhat safer.

Does the LSL from the magic GDT entry return the APIC ID or the 
smp_processor_id? If it's the latter, I can avoid using the 
smp_processor_id->apic id table completely.

> 
>>I couldn't figure out how to tell if a context switch has happened from 
>>userland. I tried putting a per-cpu context switch count, but I couldn't 
>>figure out how to get it atomically along with the CPU number..
> 
> 
> It's tricky. That is why we asked for RDTSCP.

Another way I could fix this would be to just touch the seqlock, in 
switch_to(), if we happen to be in vgettimeofday. Would this be acceptable?

-- Suleiman
