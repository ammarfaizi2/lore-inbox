Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIMBjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIMBjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUIMBjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 21:39:51 -0400
Received: from fmr12.intel.com ([134.134.136.15]:12505 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264795AbUIMBjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 21:39:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Yielding processor resources during lock contention
Date: Sun, 12 Sep 2004 18:35:56 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730232E11C@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Yielding processor resources during lock contention
Thread-Index: AcSYnNBZiKUX06jHR9yQddlVB1mbYAAjk4Tg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Zwane Mwaikambo" <zwane@fsmlabs.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Paul Mackerras" <paulus@samba.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Anton Blanchard" <anton@samba.org>,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 13 Sep 2004 01:35:58.0216 (UTC) FILETIME=[04DC0880:01C49932]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>Sent: Sunday, September 12, 2004 12:49 AM
>To: Zwane Mwaikambo
>Cc: Linus Torvalds; Paul Mackerras; Linux Kernel; Andrew Morton; Anton
>Blanchard; Nakajima, Jun; Andi Kleen
>Subject: Re: [PATCH] Yielding processor resources during lock
contention
>
>
>* Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
>
>> > Agreed, Paul we may as well remove the cpu_relax() in
>__preempt_spin_lock
>> > and use something like "cpu_yield" (architectures not supporting it
>would
>> > just call cpu_relax) i'll have something for you later.
>>
>> The following patch introduces cpu_lock_yield which allows
>> architectures to possibly yield processor resources during lock
>> contention. [...]
>
>it is not clear from the Intel documentation how well MONITOR+MWAIT
>works on SMP. It seems to be targeted towards hyperthreaded CPUs -
where
>i suspect it's much easier to monitor the stream of stores done to an
>address.

Ingo, Hi

>
>on SMP MESI caches the question is, does MONITOR+MWAIT detect a
>cacheline invalidate or even a natural cacheline flush? I doubt it
does.
>But without having the monitored cacheline in Modified state in the
>sleeping CPU for sure it's fundamentally racy and it's not possible to
>guarantee latencies: another CPU could have grabbed the cacheline and
>could keep it dirty indefinitely. (it could itself go idle forever
after
>this point!)
>
>the only safe way would be if MONITOR moved the cacheline into
Exclusive
>state and if it would watch that cacheline possibly going away (i.e.
>another CPU unlocking the spinlock) after this point - in addition to
>watching the stores of any HT sibling. But there is no description of
>the SMP behavior in the Intel docs - and i truly suspect it would be
>documented all over the place if it worked correctly on SMP... So i
>think this is an HT-only instruction. (and in that limited context we
>could indeed use it!)

MONITOR+MWAIT works on SMP as well.

>
>one good thing to do would be to test the behavior and count cycles -
it
>is possible to set up the 'wrong' caching case that can potentially
lead
>to indefinite delays in mwait. If it turns out to work the expected way
>then it would be nice to use. (The deep-sleep worries are not a too big
>issue for latency-sensitive users as deep sleep can already occur via
>the idle loop so it has to be turned off / tuned anyway.)

The instruction mwait is just a hint for the processor to enter an
(implementation-specific) optimized state, and in general it cannot
cause indefinite delays because of various break events, including
interrupts. If an interrupt happens, then the processor gets out of the
mwait state. The instruction does not support a restart at the mwait
instruction. In other words the processor needs to redo the mwait
instruction to reenter the state after a break event. Event time-outs
may take the processor out of the state, depending on the
implementation.

>
>but unless the SMP case is guaranteed to work in a time-deterministic
>way i dont think this patch can be added :-( It's not just the question
>of high latencies, it's the question of fundamental correctness: with
>large enough caches there is no guarantee that a CPU will _ever_ flush
a
>dirty cacheline to RAM.

As I noted (and Linus suspected), monitor/mwait is not proper for
spinlocks on Prescott/Nocona because of high latencies.

>
>	Ingo
