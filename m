Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUE1XiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUE1XiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUE1XiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:38:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:48266 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265181AbUE1Xhu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:37:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_IRQBALANCE for AMD64?
Date: Fri, 28 May 2004 16:37:11 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182BC94@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_IRQBALANCE for AMD64?
thread-index: AcRFBr/RUCX8HpMuRj6z5JUL5l05EgAArZiw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andi Kleen" <ak@muc.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2004 23:37:12.0836 (UTC) FILETIME=[B39A1440:01C4450C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Andi Kleen [mailto:ak@muc.de]
>Sent: Friday, May 28, 2004 3:54 PM
>To: Nakajima, Jun
>Cc: Andi Kleen; Martin J. Bligh; linux-kernel@vger.kernel.org
>Subject: Re: CONFIG_IRQBALANCE for AMD64?
>
>On Fri, May 28, 2004 at 03:05:48PM -0700, Nakajima, Jun wrote:
>> >At least the AMD chipsets found in most Opteron boxes need software
>> >balancing too.
>>
>> Actually lowest priority delivery works on P4 and AMD (I did not
tested
>> it on AMD, though), if we _update_ TPR. But I don't recommend that,
>
>True. I remember there was even a patch for that from James C. long
ago.
>I considered at one point to add it to x86-64, but ended up
>not doing anything and just recommending irqbalanced.
>
>[I didn't test it neither, so no guarantee TPR really works on AMD]
>
>> instead we should implement the similar or optimized behavior in
>> software because "soft TPR" can be more efficient and scalable. And I
>> think this is something in my mind, and I think the kernel should do
it.
>
>I'm not convinced of that. At least the current i386 implemention
>is basically a kernel thread that wakes up regularly, reads some
>statistics and then updates the APIC.

That's true, and the kirqd code basically fixed the initial solution
from Ingo, i.e. round-robin. However, during the development, we found
such simple things (e.g. round-robin) worked better in _some cases_ than
the statistics-based irq balancing. I think SuSE has some improved
round-robin for x86. 

The problems with the initial round-robin were basically:
1. Too frequent -- it hurts cache, as you know
2. Interrupts throng to idle CPUs -- everybody jumps to idle CPU(s) if
any
3. IRQs move together in sync -- they bomb the same CPU together

Instead of digging those more, we implemented the current code in the
kernel simply because we got that idea. So based on those experiences,
there are a couple things we should explore more, and "soft TPR" will be
one of them. Anyway, we need to show the code and data, to convince
people.

Jun

>
>There is not much reason this cannot be done in user space, and
>user space has the advantage that more advanced heuristics (which
>I'm sure will be there) can be more easily implemented.
>
>And handling all interrupts at CPU #0 during early boot up is
>not really an issue.
>
>An kernel implementation may make sense when you're doing something
>really dynamic: e.g. not just a timer, but dynamically redirecting
>network interrupts to the CPU the process who will read from the
>socket runs on. Obviously it would need kernel support for that, since
>user space could not keep up with such a high sampling rate. But that's
>future research work (if it can be even done generically at all)
>and I don't see it on the radar screen anytime soon. We first need to
solve
>the NUMA scheduling problem, which is already hard enough ;-)
>
>And for the simpler heuristics that don't need real time updates
>user space is probably better.
>
>-Andi
>

