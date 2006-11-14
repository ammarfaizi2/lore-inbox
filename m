Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755402AbWKNCoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbWKNCoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbWKNCoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:44:08 -0500
Received: from mail.suse.de ([195.135.220.2]:25779 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1755399AbWKNCoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:44:05 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
Date: Tue, 14 Nov 2006 03:44:00 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455916A5.2030402@FreeBSD.org> <200611140305.00383.ak@suse.de> <45592929.2000606@FreeBSD.org>
In-Reply-To: <45592929.2000606@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140344.00407.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Because CPUID returns the APIC ID, and I was under the impression that 
> the cpu numbers
> smp_processor_id() were dynamically allocated and didn't necessarily 
> match the
> APIC ID.

Correct, but one can use a mapping table.


> Yes, it's only needed on HLT and cpufreq change.
> The code here is to force a "resynch" with the HPET if we've done a HLT. 
>   It has to be done before we switch to any userland thread that might 
> use the per-cpu vxtime. switch_to() seemed like the most natural place 
> to put this.

I don't think so. The natural place after HLT is in the idle loop or 
better in idle notifiers[1] and after  cpufreq is in the appropiate cpufreq 
notifiers.
 

[1] unfortunately they are still subtly broken in .19, but will be fixed
in .20

> A cow-orker suggested that we use SIDT and encode the CPU number in the 
> limit of the IDT, which should be even faster than LSL.

Possible yes. Did you time it?

But then we would make the IDT variable length in memory? While
the CPUs probably won't care some Hypervisors seem to be picky
about these limits. LSL still seems somewhat safer.
 
> I couldn't figure out how to tell if a context switch has happened from 
> userland. I tried putting a per-cpu context switch count, but I couldn't 
> figure out how to get it atomically along with the CPU number..

It's tricky. That is why we asked for RDTSCP.

-Andi
