Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWBUXaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWBUXaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWBUXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:30:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751212AbWBUXaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:30:00 -0500
Date: Tue, 21 Feb 2006 15:28:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
Message-Id: <20060221152811.1b065752.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602211045490.5374-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0602211045490.5374-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Some atomic notifier chains require registrations to take place in atomic
>  context.  An example is the die_notifier, which on some architectures may
>  be accessed very early during the boot-up procedure, before task-switching
>  is legal.  To accomodate these chains, this patch (as655) replaces the
>  mutex in the atomic_notifier_head structure with a spinlock.

I think that's a good change, however x86_64 still crashes.

At great personal expense (ie: using winxp hyperterminal (I now understand
why some of the traces we get are so crappy)) I have a trace.  It's still
bugging out in the BUG_ON(!irqs_disabled());


Initializing CPU#0                  
Kernel command line: root=/dev/sda3 profile=1 ro rhgb earlyprintk=serial,ttyS0,9600 console=ttyS0                 
kernel profiling enabled (shift: 1)                                   
PID hash table entries: 4096 (order: 12, 131072 bytes)                                                      
time.c: Using 14.318180 MHz HPET timer.                                       
time.c: Detected 3400.160 MHz processor.                                        
----------- [cut here ] --------- [please bite here ] ---------                                                               
Kernel BUG at kernel/posix-cpu-timers.c:1279                                            
invalid opcode: 0000 [1] PREEMPT SMP
last sysfs file:                
CPU 0     
Modules linked in:                  
Pid: 0, comm: swapper Not tainted 2.6.16-rc4-mm1 #147
RIP: 0010:[<ffffffff801401a2>] <ffffffff801401a2>{run_posix_cpu_timers+42}
RSP: 0018:ffffffff805a3dd8  EFLAGS: 00010202
RAX: ffffffff805a3e18 RBX: ffffffff804d6300 RCX: 0000000000000000
RDX: ffffffff80617000 RSI: 0000000000000000 RDI: ffffffff804d6300
RBP: ffffffff805a3e58 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff804d6300 R14: 0000000000000000 R15: ffffffff8062be88
FS:  0000000000000000(0000) GS:ffffffff80617000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff8062a000, task ffffffff804d6300)
Stack: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
       ffff810007042840 0000000000000000 0000000000000000 0000000000000296
       ffffffff805a3e18 ffffffff805a3e18
Call Trace: <IRQ> <ffffffff80134211>{update_process_times+110}
       <ffffffff80114f3c>{smp_local_timer_interrupt+40} <ffffffff8010d39e>{main_timer_handler+527}
       <ffffffff8010d554>{timer_interrupt+21} <ffffffff8014c44f>{handle_IRQ_event+48}
       <ffffffff8014c528>{__do_IRQ+163} <ffffffff8010c073>{do_IRQ+50}
       <ffffffff80109e36>{ret_from_intr+0} <EOI> <ffffffff803cb47a>{_spin_unlock_irqrestore+17}
       <ffffffff8014c85a>{setup_irq+226} <ffffffff80630b5a>{time_init+698}
       <ffffffff8062d6f9>{start_kernel+218} <ffffffff8062d286>{_sinittext+646}
Code: 0f 0b 68 42 34 3f 80 c2 ff 04 49 8b 95 50 02 00 00 48 85 d2
RIP <ffffffff801401a2>{run_posix_cpu_timer
RIP <ffffffff801401a2>{run_posix_cpu_timer
 BUG: warning at kernel/panic.c:138/panic()
Call Trace: <IRQ> <ffffffff8012ab9d>{panic+557} <ffffffff803cb484>{_spin_unlock_irqrestore+27}
       <ffffffff80231aaa>{__up_read+193} <ffffffff8013827d>{blocking_notifier_call_chain+71}
       <ffffffff8012d565>{do_exit+158} <ffffffff803cb484>{_spin_unlock_irqrestore+27}
       <ffffffff8010b34f>{do_divide_error+0} <ffffffff803cbff1>{do_trap+235}
       <ffffffff8010b596>{do_invalid_op+172} <ffffffff801401a2>{run_posix_cpu_timers+42}
       <ffffffff8010a821>{error_exit+0} <ffffffff801401a2>{run_posix_cpu_timers+42}
       <ffffffff80134211>{update_process_times+110} <ffffffff80114f3c>{smp_local_timer_interrupt+40}
       <ffffffff8010d39e>{main_timer_handler+527} <ffffffff8010d554>{timer_interrupt+21}
       <ffffffff8014c44f>{handle_IRQ_event+48} <ffffffff8014c528>{__do_IRQ+163}
       <ffffffff8010c073>{do_IRQ+50} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff803cb47a>{_spin_unlock_irqrestore+17} <ffffffff8014c85a>{setup_irq+226}
       <ffffffff80630b5a>{time_init+698} <ffffffff8062d6f9>{start_kernel+218}
       <ffffffff8062d286>{_sinittext+646}

