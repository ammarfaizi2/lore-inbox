Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWEaOCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWEaOCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWEaOBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:01:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53435 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965034AbWEaOBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:01:48 -0400
Date: Wed, 31 May 2006 16:02:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531140201.GA11617@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> but these two bugs looks similar (both were previously reported). Both 
> appears while starting avahi daemon.
> 
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/dmesg_1
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/dmesg_2
> 
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/latency_trace_1.bz2
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/latency_trace_2.bz2

thanks - these traces made it really easy to spot the problem! The 
problem seems to be caused by a pagefault:

   <...>-1     0D..1 10648us : check_chain_key (__lockdep_acquire)
   <...>-1     0D..1 10649us+: _raw_spin_lock (_spin_lock_irqsave)
   <...>-1     0D..1 10651us : do_page_fault (error_code)
   <...>-1     0D..1 10652us : trace_hardirqs_off (ret_from_exception)
   <...>-1     0D..1 10653us : trace_hardirqs_on (restore_nocheck)
   <...>-1     0D..1 10654us : mark_held_locks (trace_hardirqs_on)
   <...>-1     0D..1 10654us : mark_lock (mark_held_locks)
   <...>-1     0D..1 10655us : save_trace (mark_lock)
   <...>-1     0D..1 10656us : save_stack_trace (save_trace)
   <...>-1     0D..1 10658us : print_usage_bug (mark_lock)

i think what happened is that the pagefault happened with irqs disabled, 
and the entry.S return-to-exception-site irq-flags tracing code 
mistakenly turned on the irq flag - causing the mismatch and lockdep's 
confusion.

if it's easy to reproduce it once more, could you apply the patch below? 
That will add a trace entry about what address faulted and at what EIP. 
Please also upload vmlinux.bz2 because the EIP will be a raw hex number 
and i'll have to look it up. (or if it's too big then please disassemble 
vmlinux via objdump -d vmlinux and upload a ~100 lines portion that is 
mentioned in the new trace entry next to the do_page_fault trace entry 
near the end of the latency_trace output)

	Ingo

Index: linux/arch/i386/mm/fault.c
===================================================================
--- linux.orig/arch/i386/mm/fault.c
+++ linux/arch/i386/mm/fault.c
@@ -337,6 +338,7 @@ fastcall void __kprobes do_page_fault(st
 
 	/* get the address */
         address = read_cr2();
+	trace_special(regs->eip, address, error_code);
 
 	tsk = current;
 
