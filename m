Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbVD3Cnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVD3Cnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVD3Cnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:43:47 -0400
Received: from fmr14.intel.com ([192.55.52.68]:61137 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S263132AbVD3Cnn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:43:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Date: Fri, 29 Apr 2005 19:43:09 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60049EE972@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Thread-Index: AcVNIW1gkpLdCJnXQMa48XEBvjtxFgAC6Rkg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <mingo@elte.hu>, "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "John Stultz" <johnstul@us.ibm.com>, "Andi Kleen" <ak@suse.de>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 30 Apr 2005 02:43:11.0940 (UTC) FILETIME=[59BE3840:01C54D2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk] 
>Sent: Friday, April 29, 2005 6:13 PM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; Linus Torvalds; mingo@elte.hu; 
>linux-kernel; Shah, Rajesh; John Stultz; Andi Kleen; Mallick, Asit K
>Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC 
>timer interrupt
>
>On Fri, 29 Apr 2005, Venkatesh Pallipadi wrote:
>
>> Proposed Fix: 
>> Attached is a prototype patch, that tries to eliminate the 
>dependency on 
>> local APIC timer for update_process_times(). The patch gets 
>rid of Local APIC 
>> timer altogether. We use the timer interrupt (IRQ 0) configured in 
>> broadcast mode in IOAPIC instead (Doesn't work with 8259). 
>> As changing anything related to basic timer interrupt is a 
>little bit risky, 
>> I have a boot parameter currently ("useapictimer") to switch 
>back to original 
>> local APIC timer way of doing things.
>
>I'm rather reluctant to advocate the broadcast scheme as i can see it 
>breaking on a lot of systems, e.g. SMP systems which use i8259 (as you 
>noted), IBM x440 and ES7000. If anything the default mode 
>should be APIC 
>timer and have a parameter to disable it.

The patch as it is should handle 8259 case using the regular APIC timer.
It only adds broadcast when IOAPIC is used for timer interrupt.

And if broadcast doesn't work on IBM x440 and ES7000, it can easily 
be handled by sub-arch, to use local APIC.

> Regarding things like variable 
>timer ticks, reprogramming the PIT is slow, and using it 
>extensively for 
>such sounds like a step in the wrong direction. 

Variable tick should come into picture only when system is totally idle
(for a long time). The algorithm that change ticks should handle the 
trade-off between frequent HZ interrupt when system is idle and overhead
Of reprogramming PIT/HPET. And variable HZ is already changing PIT if I 
Remember correctly. This patch doesn't add any complexity there.

> Is this feature/bug going to proliferate amongst newer processor 
> local APICs?

This APIC timer stopping in C3 will affect all CPUs that have C3 or 
deeper state. 

Although I agree that changing the things like timer interrupt is like 
walking on a landmine, given all different kind of hardware present, 
in general this seems simplify things related to timer interrupts.

Thanks,
Venki
