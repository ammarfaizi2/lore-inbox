Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTCEPlP>; Wed, 5 Mar 2003 10:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTCEPlP>; Wed, 5 Mar 2003 10:41:15 -0500
Received: from main.gmane.org ([80.91.224.249]:55223 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267261AbTCEPkp>;
	Wed, 5 Mar 2003 10:40:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@reflexsecurity.com>
Subject: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Date: Wed, 5 Mar 2003 15:46:20 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb6c6vb.rm1.lunz@stoli.localnet>
References: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com> <3E657F33.4000304@pobox.com>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@pobox.com said:
> Further, for NAPI and networking in general, it is recommended to bind
> each NIC to a single interrupt, and never change that binding. 

I assume you mean "bind each NIC interrupt to a single CPU" here. I've
done quite a lot of benchmarking on dual SMP that shows that for
high-load networking, you basically have two cases:

 - the irq load is less than what can be handled by one CPU. This is the
   case, for example, using a NAPI e1000 driver under any load on a
   > 1 GHz SMP machine. even with two e1000 cards under extreme load,
   one CPU can run the interrupt handlers with cycles to spare (thanks
   to NAPI).  This config (all NIC interrupts on CPU0) is optimal as
   long as CPU doesn't become saturated. Trying to distribute the
   interrupt load across multiple CPUs incurs measurable performance
   loss, probably due to cache effects.
 
 - the irq load is enough to livelock one CPU. It's easy for this to
   happen with gigE NICs on a non-NAPI kernel, for example. In this
   case, you're better off binding each heavy interrupt source to a
   different CPU.

2.4's default behavior isn't optimal in either case.

> Delivering a single NIC's interrupts to multiple CPUs leads to a 
> noticeable performance loss.  This is why some people complain that 
> their specific network setups are faster on a uniprocessor kernel than 
> an SMP kernel.

This is what I've seen as well. The good news is that you can pretty
much recapture the uniprocessor performance by binding all heavy
interrupt sources to one CPU, as long as that CPU can handle it. And any
modern machine with a NAPI kernel _can_ handle any realistic gigE load.

I should mention that these results are all measurements of gigabit
bridge performance, where every frame needs to be received on one NIC
and sent on the other. So there are obvious cache benefits to doing it
all on one CPU.

-- 
Jason Lunz			Reflex Security
lunz@reflexsecurity.com		http://www.reflexsecurity.com/

