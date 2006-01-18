Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWARKn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWARKn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWARKn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:43:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1773 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932460AbWARKn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:43:27 -0500
Date: Wed, 18 Jan 2006 11:43:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: Re: [patch] turn on might_sleep() in early bootup code too
Message-ID: <20060118104319.GB7885@elte.hu>
References: <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org> <20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118023509.50fe2701.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> >  enable might_sleep() checks even in early bootup code (when system_state 
> >  != SYSTEM_RUNNING). There's also a new config option to turn this off:
> >  CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
> >  while most other architectures.
> 
> I get just the one on ppc64:
> 
> 
> Debug: sleeping function called from invalid context at include/asm/semaphore.h:62
> in_atomic():1, irqs_disabled():1
> Call Trace:
> [C0000000004EFD20] [C00000000000F660] .show_stack+0x5c/0x1cc (unreliable)
> [C0000000004EFDD0] [C000000000053214] .__might_sleep+0xbc/0xe0
> [C0000000004EFE60] [C000000000413D1C] .lock_kernel+0x50/0xb0
> [C0000000004EFEF0] [C0000000004AC574] .start_kernel+0x1c/0x278
> [C0000000004EFF90] [C0000000000085D4] .hmt_init+0x0/0x2c
> 
> 
> Your fault ;)

yes :-) I have a really ugly workaround in my tree that is definitely 
not worth posting. I think to do this cleanly i'll add trylock_kernel(), 
and do this in main.c:

   BUG_ON(!trylock_kernel());

but there's another one that is much nastier in terms of scope:

BUG: sleeping function called from invalid context at kernel/mutex.c:256
in_atomic():0, irqs_disabled():1
 [<c0103db6>] show_trace+0xd/0xf
 [<c0103dcd>] dump_stack+0x15/0x17
 [<c011ff4b>] __might_sleep+0x64/0x6c
 [<c105b470>] mutex_lock_interruptible+0x15/0x22
 [<c013d81f>] __lock_cpu_hotplug+0x26/0x52
 [<c013d858>] lock_cpu_hotplug_interruptible+0xd/0xf
 [<c013d922>] register_cpu_notifier+0xc/0x2b
 [<c1dac88f>] page_alloc_init+0xd/0xf
 [<c1d992ee>] start_kernel+0x125/0x376
 [<c0100210>] 0xc0100210

this is what is causing the ppc64 problems too i think.

lock_cpu_hotplug() has design problems i think: hotplug-locked sections 
are slowly spreading in the kernel, encompassing more and more code :-) 
Shouldnt the CPU hotplug lock be a spinlock to begin with?

	Ingo
