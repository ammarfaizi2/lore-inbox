Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423046AbWBBBgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423046AbWBBBgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423044AbWBBBgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:36:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:42171 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422694AbWBBBf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:35:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Wed, 1 Feb 2006 20:35:36 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Thread-Index: AcYnXyTz5y8oF1x3SpOT9Cqo4CZ8UwAGKAPw
From: "Brown, Len" <len.brown@intel.com>
To: "Tony Lindgren" <tony@atomide.com>, "Erik Slagter" <erik@slagter.name>
Cc: "Andrew Morton" <akpm@osdl.org>, "Joerg Sommrey" <jo@sommrey.de>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <arjan@infradead.org>
X-OriginalArrivalTime: 02 Feb 2006 01:35:39.0924 (UTC) FILETIME=[F9642540:01C62798]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> > Linux/ACPI has had generic supported SMP deep (> C1) C-states
>> > for a few months now and AFAIK it is working fine.
>> > Why is a platform specific driver needed for these boards?
>> 
>> Boards with this chipset tend to have some timing in the DSDT wrong
>> which prevents ACPI te actually use the C2/C3 states. It seems that
>> C2/C3 can only be used on amd76x boards with some extra setup code.
>> Maybe it would be an idea to merge both pieces of code as much as
>> possible?
>
>Yes, in amd76x case it's just to enable the C states. Then at least
>Fujitsu Lifebook p2120 needs patching of a register to stay in C2 
>and C3 sleep, otherwise it just wakes up right away. These are just
>some random machines I've been using, so there's probably quite a
>few machines that could use some fixups.
>
>What would be nice would be some hooks in ACPI to scan the north and
>south bridges based on some fixup list during init, and then do the
>necessary fixups would be nice. And then ACPI C states would just
>work!

Maybe they'll just work, or maybe they'll appear to work,
but will silently corrupt user data...

This endeavor is full of risk, and I would be extremely careful
about enabling features that the BIOS explicitly disabled --
unless the hardware manufacturer publicly publishes
support for the feature, or the errata that you're working around.

Re: bad timing
If the BIOS advertises C2 latency > 100usec, then the BIOS
and the system do not support C2.
If the BIOS advertises C3 latency > 1000usec, then the BIOS
and the system do not support C3.
This isn't just a suggestion, it is the standard method
that the spec provides the BIOS to tell the OS to NOT USE these states.

Why would a BIOS do this when it appears that the registers
to enter C2 and C3 are present?  There are lots of possibilities,
but the most scary is that the feature may appear to work
but silently corrupts data.  This risk is particularly acute
for multi-core/SMP systems and C3.  For this state, the CPU
cache snooping is DISABLED.  So if the hardware has any issues
at all with DMA traffic or the memory traffic of another CPU
passing over the bus w/o first re-enabling snooping, then
the data is exposed to corruption.

I don't have religion against model-specific workarounds,
they have their place.  But they can be extremely risky, and this
risk is magnified when the vendor that produced the model is silent.

-Len
