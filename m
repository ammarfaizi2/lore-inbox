Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWDTGdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDTGdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWDTGdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:33:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51359 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750896AbWDTGds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:33:48 -0400
Date: Thu, 20 Apr 2006 07:29:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
Message-ID: <20060420052954.GA5524@elte.hu>
References: <20060419094630.GA14800@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419094630.GA14800@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i'm getting weird mutex crashes on 2.6.17-rc2 if CONFIG_HOTPLUG_CPU is 
> enabled. The workaround below solves it - but the question is, what is 
> the real bug? See the attached crashlog.

the crash itself seems to be related to spinlock code sections that were 
modified by the smp-alternatives feature. HOTPLUG_CPU triggers the 
following code:

 SMP alternatives: switching to UP code
 CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
 Mapping cpu 0 to node 0
 SMP alternatives: switching to SMP code
 Booting processor 1/1 eip 3000
 Initializing CPU#1

as under HOTPLUG_CPU, the system first boots up as a single-CPU box, 
then the second CPU gets added dynamically - so we first switch from the 
default SMP instructions to UP instructions - and then we switch back to 
SMP instructions again. It seems something went wrong in that sequence, 
as shortly afterwards we crash on a spinlock op:

 BUG: warning at kernel/mutex-debug.c:405/debug_mutex_add_waiter()
  [<c100643d>] show_trace+0xd/0x10
  [<c1006457>] dump_stack+0x17/0x20
  [<c1042fab>] debug_mutex_add_waiter+0x7b/0x80
  [<c177f5c4>] __mutex_lock_slowpath+0x84/0x340
  [<c177f89f>] mutex_lock+0x1f/0x30
  [<c10739ea>] cpuup_callback+0x6a/0x400
  [<c1782698>] notifier_call_chain+0x28/0x50
  [<c10387ed>] blocking_notifier_call_chain+0x3d/0x70
  [<c1047826>] cpu_up+0x66/0xf0

another detail: this is an Athon64 X2 dual-core box, so there might be 
state (cache) sharing artifacts not visible on other CPUs. Even if there 
are no such artifacts, cacheline invalidation latencies between the 
cores are very low, so it might tickle some race in the SMP-alternatives 
code.

but ... a more fundamental question is, where does the SMP-alternatives 
code flush the icache? I dont think it's generally guaranteed on x86 
CPUs that MESI updates to code get propagated into the icache of other 
CPUs/cores.

At a minimum we should do an smp_function_call() within 
alternatives_smp_switch(), which makes sure that the modification 
sequence has been executed on every CPU. But the most robust method 
would be to first 'gather' _all_ CPUs, which would all disable 
interrupts, and then do the modification on all CPUs, and then 'release' 
all CPUs. This also ensures that we dont switch instructions _under_ a 
running CPU.

this is a v2.6.17 showstopper i think.

	Ingo
