Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVGHLqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVGHLqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVGHLqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:46:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59012 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262584AbVGHLqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:46:48 -0400
Date: Fri, 8 Jul 2005 13:46:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708114642.GA10379@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071237.42470.s0348365@sms.ed.ac.uk> <20050707114223.GA29825@elte.hu> <200507081047.07643.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081047.07643.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Well, just to let others who have this problem know, it's clear that 
> Ingo's rt-preempt patches increase stack pressure on systems (like 
> mine) where stack is borderline under 4K by default.
> 
> If you disable CONFIG_4KSTACKS the stack overflows seem to disappear.  
> As a result, until we isolate the problem, it'd probably be better if 
> Ingo maintained an 8K stacks option in the rt-preempt patches assuming 
> Adrian Bunk's "kill !4KSTACKS" patch gets into mainline..

Ok. Could you try to debug this some more? In the -51-17 patch i've 
implemented a new stack-overflow debugging feature: 'stack footprint 
maximum searching'. It is automatically active if you have 
CONFIG_LATENCY_TRACE and CONFIG_DEBUG_STACKOVERFLOW enabled. It will 
track and (if it can be done safely) print out maximum stack usage sites 
immediately. Hopefully this results in better stackdumps. It should 
print similar traces:

----------------------------->
| new stack-footprint maximum: smartd/1747, 1768 bytes.
------------|
 [<c013c1b6>] check_raw_flags+0xb/0x55 (8)
 [<c013ebeb>] sub_preempt_count+0x1a/0x1c (8)
 [<c013cb28>] __mcount+0x6a/0x91 (28)
 [<c013c3ff>] irqs_disabled+0x8/0x19 (16)
 [<c013c7b5>] ____trace+0x9e/0x208 (4)
 [<c01142d8>] mcount+0x14/0x18 (24)
 [<c013c3ff>] irqs_disabled+0x8/0x19 (20)
 [<c013c7b5>] ____trace+0x9e/0x208 (8)
 [<c013f145>] trace_stop_sched_switched+0x40/0x17d (8)
 [...]

i've written a separate, hopefully more robust stack-dumper which is 
used for the above traces. Perhaps in your overflow case it results in 
something usable.

	Ingo
