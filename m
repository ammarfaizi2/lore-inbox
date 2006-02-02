Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWBBAGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWBBAGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBBAGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:06:24 -0500
Received: from amdext3.amd.com ([139.95.251.6]:28614 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1751089AbWBBAGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:06:24 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: powernow-k8: out of sync on Athlon64 x2 3800+
Date: Wed, 1 Feb 2006 18:05:00 -0600
Message-ID: <B3870AD84389624BAF87A3C7B83149930293551F@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: powernow-k8: out of sync on Athlon64 x2 3800+
Thread-Index: AcYme8mpLUYdJdAhQPWJxEEu/vsN4gAAZWAQAEKPSEA=
From: "shin, jacob" <jacob.shin@amd.com>
To: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       "Niklas Edmundsson" <Niklas.Edmundsson@hpc2n.umu.se>,
       Andreas.Burghart@fujitsu-siemens.com, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 02 Feb 2006 00:05:01.0527 (UTC)
 FILETIME=[4FDA9E70:01C6278C]
X-WSS-ID: 6FFF93271HW4366461-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't think this is a BIOS issue, but a kernel bug in the i386 tree.  I believe this was recently discussed and hopefully fixed by Andi Kleen in the kernel mailing list:

http://lkml.org/lkml/2006/1/9/442

This is a critical bug especially for systems running AMD Dual-Core Processors on i386 kernel configuration w/ powernow-k8.

The reason for "powernow-k8 - out of sync" errors is because the cpufreq driver is not aware [or has the wrong idea] about which CPUs are tied together, because cpu_core_id and phy_proc_id data is wrong.

Now this is fairly harmless as Mark mentioned, but only on single socket Dual Core systems.

On a multi-socket multi-core system, it will result in something like: (2 dual-core Opterons)

cpu0:
drwxr-xr-x  2 root root    0 Nov  3 09:51 cpufreq

cpu1:
drwxr-xr-x  2 root root    0 Nov  3 09:51 cpufreq

cpu2:
lrwxrwxrwx  1 root root    0 Nov  3 09:51 cpufreq -> ../../../../devices/system/cpu/cpu1/cpufreq

cpu3:
lrwxrwxrwx  1 root root    0 Nov  3 09:51 cpufreq -> ../../../../devices/system/cpu/cpu1/cpufreq

In this configuration, the second processors will never be able to be managed by a governor.

I was wondering if anyone has already tested Andi's patch, if it successfully solves this problem, and if the patch has made it into the git yet.

Thanks,

-Jacob Shin
AMD, Inc.

On  cpufreq-bounces@lists.linux.org.uk wrote:
>>> You'll get that message on an Athlon X2 if you're using an
>>> old version of the driver that doesn't fully support
>>> dual core or if your part is being reported to Linux as 2 single core parts.
>>> 
>>> Neither of those should be happening with the 2.6.15.1 kernel.
>> 
>> OK, seems we've really found a bug then.
> 
> Yes, but it's a BIOS bug.
> 
>>> Could you send me the results of `dmesg | grep powern` immediately
>>> after boot?
>> 
>> Sure:
>> # dmesg|grep powern
>> powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
>> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
>> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
>> powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
>> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
>> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
>> powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
> 
> You're using a driver that supports dual-core, but the BIOS
> is reporting the two cores as two separate processors.
> They've probably got the APICIDs misconfigured.
> 
> I've reported it to FSC and I advise you to do the same.
> 
>> powernow-k8: error - out of sync, fix 0xc 0x2, vid 0x8 0x12
>> powernow-k8: error - out of sync, fix 0x2 0xa, vid 0x12 0xa
>> powernow-k8: error - out of sync, fix 0xa 0xc, vid 0xa 0x8
>> powernow-k8: error - out of sync, fix 0xc 0x2, vid 0x8 0x12
>> powernow-k8: error - out of sync, fix 0x2 0xc, vid 0x12 0x8
>> powernow-k8: error - out of sync, fix 0xc 0x2, vid 0x8 0x12
> 
> These messages are mostly harmless, by the way, but some
> people have seen system instability.  I would enable
> pmtimer support as your clock source, but that's advisable
> when running a single dual-core anyway.
> 
> -Mark Langsdorf
> AMD, Inc.
> 
> 
> _______________________________________________
> Cpufreq mailing list
> Cpufreq@lists.linux.org.uk
> http://lists.linux.org.uk/mailman/listinfo/cpufreq

