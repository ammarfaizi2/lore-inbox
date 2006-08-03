Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWHCLss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWHCLss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 07:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHCLsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 07:48:47 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:42114 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932439AbWHCLsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 07:48:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MN6F1eYzIij2Go09kkJHXKUlWOBYB1BgxK4T185uEkPqqNE6FDdRwgpEaSCJuuWItno7OiMHBFBNlRj+yObfaiQezc/ZM0I7qGqVyscMUAaazFIHCxH1S2pmEYTBoAHWN3oGZV8yC80UsTD8EgGYPatKj3HtEOuCwe0Ruy8WbCk=
Message-ID: <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
Date: Thu, 3 Aug 2006 04:48:44 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: Problems with 2.6.17-rt8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154541079.25723.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> You mention problems but I don't see you listing what exactly the
> problems are.  Just saying "the problems exist" doesn't tell us
> anything.
>
> Don't assume that we will go to some web site to figure out what you're
> talking about. Please list the problems you are facing.

The machine dies (no alt-sysrq, no keyboard LEDs of any kind: dead in
the water).  I thought the log would provide more useful information
without potentially erroneous editorialization by myself.  Here are
some highlights:

kjournald/1105[CPU#3]: BUG in debug_rt_mutex_unlock at kernel/rtmutex-debug.c:47
1

Call Trace:
       <ffffffff8047655a>{_raw_spin_lock_irqsave+24}
       <ffffffff8022b272>{__WARN_ON+100}
       <ffffffff802457e4>{debug_rt_mutex_unlock+199}
       <ffffffff804757b7>{rt_lock_slowunlock+25}
       <ffffffff80476301>{__lock_text_start+9}
       <ffffffff80271e93>{kmem_cache_alloc+202}
       <ffffffff8025493b>{mempool_alloc_slab+17}
       <ffffffff80254d07>{mempool_alloc+75}
       <ffffffff802f2f8c>{generic_make_request+375}
       <ffffffff8027b914>{bio_alloc_bioset+35}
       <ffffffff8027ba2a>{bio_alloc+16}
       <ffffffff802781d1>{submit_bh+137}
       <ffffffff80279377>{ll_rw_block+122}
       <ffffffff8027939e>{ll_rw_block+161}
       <ffffffff802c85dc>{journal_commit_transaction+1011}
       <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
       <ffffffff804769ac>{_raw_spin_unlock+46}
       <ffffffff804757df>{rt_lock_slowunlock+65}
       <ffffffff80476301>{__lock_text_start+9}
       <ffffffff802339b0>{try_to_del_timer_sync+85}
       <ffffffff802cca63>{kjournald+202}
       <ffffffff8023db60>{autoremove_wake_function+0}
       <ffffffff802cc999>{kjournald+0}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023da2f>{kthread+219}
       <ffffffff80225a23>{schedule_tail+188}
       <ffffffff8020aaca>{child_rip+8}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023d954>{kthread+0}
       <ffffffff8020aac2>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff804757af>] ..   ( <= rt_lock_slowunlock+0x11/0x6b)
.. [<ffffffff8047655a>] .... _raw_spin_lock_irqsave+0x18/0x29
.....[<ffffffff8022b22d>] ..   ( <= __WARN_ON+0x1f/0x82)


Somewhat later:

Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 3
Modules linked in: nfsd exportfs lockd sunrpc tg3
Pid: 1105, comm: kjournald Not tainted 2.6.17-rt8_local_01 #1
RIP: 0010:[<ffffffff80475926>] <ffffffff80475926>{rt_lock_slowlock+181}
RSP: 0000:ffff810076c6db38  EFLAGS: 00010246
RAX: ffff810275696340 RBX: 0000000000000010 RCX: 0000000000000000
RDX: ffff810275696340 RSI: ffffffff80271e18 RDI: ffff8101800b9a60
RBP: ffff810076c6dbf8 R08: ffff810275696528 R09: ffff810076c6db38
R10: ffff810008003f38 R11: ffff8100cbf4de98 R12: ffff8101800b9a60
R13: ffff8100cbf99c40 R14: ffffffff80271e18 R15: 0000000000000010
FS:  00002b2838961770(0000) GS:ffff81018020b340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000003d574460a0 CR3: 000000026e069000 CR4: 00000000000006e0
Process kjournald (pid: 1105, threadinfo ffff810076c6c000, task ffff810275696340
)
Stack: 111111110000008c ffff810076c6db40 ffff810076c6db40 ffff810076c6db50
       ffff810076c6db50 0000000000000000 111111110000008c ffff810076c6db70
       ffff810076c6db70 ffff810076c6db80
Call Trace:
       <ffffffff80476310>{rt_lock+13}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff8025493b>{mempool_alloc_slab+17}
       <ffffffff80254d07>{mempool_alloc+75}
       <ffffffff802f2f8c>{generic_make_request+375}
       <ffffffff8027b983>{bio_alloc_bioset+146}
       <ffffffff8027ba2a>{bio_alloc+16}
       <ffffffff802781d1>{submit_bh+137}
       <ffffffff80279377>{ll_rw_block+122}
       <ffffffff8027939e>{ll_rw_block+161}
       <ffffffff802c85dc>{journal_commit_transaction+1011}
       <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
       <ffffffff804769ac>{_raw_spin_unlock+46}
       <ffffffff804757df>{rt_lock_slowunlock+65}
       <ffffffff80476301>{__lock_text_start+9}
       <ffffffff802339b0>{try_to_del_timer_sync+85}
       <ffffffff802cca63>{kjournald+202}
       <ffffffff8023db60>{autoremove_wake_function+0}
       <ffffffff802cc999>{kjournald+0}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023da2f>{kthread+219}
       <ffffffff80225a23>{schedule_tail+188}
       <ffffffff8020aaca>{child_rip+8}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023d954>{kthread+0}
       <ffffffff8020aac2>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff804758a7>] ..   ( <= rt_lock_slowlock+0x36/0x20e)
.. [<ffffffff804767b3>] .... _raw_spin_trylock+0x16/0x5a


and somewhat later:

 <3>BUG: sleeping function called from invalid context kjournald(1105) at kernel
/rtmutex.c:1030
in_atomic():1 [00000001], irqs_disabled():0

Call Trace:
       <ffffffff80221cd1>{__might_sleep+271}
       <ffffffff80475d8a>{rt_mutex_lock+29}
       <ffffffff80245a44>{rt_down_read+71}
       <ffffffff802381c5>{blocking_notifier_call_chain+27}
       <ffffffff8022b950>{profile_task_exit+21}
       <ffffffff8022d298>{do_exit+37}
       <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
       <ffffffff8020b3a5>{kernel_math_error+0}
       <ffffffff804773b1>{do_trap+223}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff8020b9bc>{do_invalid_op+167}
       <ffffffff80475926>{rt_lock_slowlock+181}
       <ffffffff8022acee>{printk+103}
       <ffffffff8020a911>{error_exit+0}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff80475926>{rt_lock_slowlock+181}
       <ffffffff804758fe>{rt_lock_slowlock+141}
       <ffffffff80476310>{rt_lock+13}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff8025493b>{mempool_alloc_slab+17}
       <ffffffff80254d07>{mempool_alloc+75}
       <ffffffff802f2f8c>{generic_make_request+375}
       <ffffffff8027b983>{bio_alloc_bioset+146}
       <ffffffff8027ba2a>{bio_alloc+16}
       <ffffffff802781d1>{submit_bh+137}
       <ffffffff80279377>{ll_rw_block+122}
       <ffffffff8027939e>{ll_rw_block+161}
       <ffffffff802c85dc>{journal_commit_transaction+1011}
       <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
       <ffffffff804769ac>{_raw_spin_unlock+46}
       <ffffffff804757df>{rt_lock_slowunlock+65}
       <ffffffff80476301>{__lock_text_start+9}
       <ffffffff802339b0>{try_to_del_timer_sync+85}
       <ffffffff802cca63>{kjournald+202}
       <ffffffff8023db60>{autoremove_wake_function+0}
       <ffffffff802cc999>{kjournald+0}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023da2f>{kthread+219}
       <ffffffff80225a23>{schedule_tail+188}
       <ffffffff8020aaca>{child_rip+8}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023d954>{kthread+0}
       <ffffffff8020aac2>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff804758a7>] ..   ( <= rt_lock_slowlock+0x36/0x20e)

or there's this:

BUG: soft lockup detected on CPU#3!

Call Trace: <IRQ>
       <ffffffff8024e8ec>{softlockup_tick+212}
       <ffffffff80271008>{kmem_cache_free+64}
       <ffffffff80233c95>{run_local_timers+19}
       <ffffffff80233daa>{update_process_times+76}
       <ffffffff8021426f>{smp_local_timer_interrupt+43}
       <ffffffff8021469f>{smp_apic_timer_interrupt+64}
       <ffffffff8020a774>{apic_timer_interrupt+132} <EOI>
       <ffffffff80271008>{kmem_cache_free+64}
       <ffffffff80476af6>{.text.lock.spinlock+12}
       <ffffffff80476499>{_raw_spin_lock+22}
       <ffffffff804758a7>{rt_lock_slowlock+54}
       <ffffffff8024e196>{add_preempt_count+36}
       <ffffffff80476310>{rt_lock+13}
       <ffffffff80271008>{kmem_cache_free+64}
       <ffffffff80226f82>{__cleanup_sighand+32}
       <ffffffff8022c563>{release_task+665}
       <ffffffff8022db04>{do_exit+2193}
       <ffffffff8020b3a5>{kernel_math_error+0}
       <ffffffff804773b1>{do_trap+223}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff8020b9bc>{do_invalid_op+167}
       <ffffffff80475926>{rt_lock_slowlock+181}
       <ffffffff8022acee>{printk+103}
       <ffffffff8020a911>{error_exit+0}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff80475926>{rt_lock_slowlock+181}
       <ffffffff804758fe>{rt_lock_slowlock+141}
       <ffffffff80476310>{rt_lock+13}
       <ffffffff80271e18>{kmem_cache_alloc+79}
       <ffffffff8025493b>{mempool_alloc_slab+17}
       <ffffffff80254d07>{mempool_alloc+75}
       <ffffffff802f2f8c>{generic_make_request+375}
       <ffffffff8027b983>{bio_alloc_bioset+146}
       <ffffffff8027ba2a>{bio_alloc+16}
       <ffffffff802781d1>{submit_bh+137}
       <ffffffff80279377>{ll_rw_block+122}
       <ffffffff8027939e>{ll_rw_block+161}
       <ffffffff802c85dc>{journal_commit_transaction+1011}
       <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
       <ffffffff804769ac>{_raw_spin_unlock+46}
       <ffffffff804757df>{rt_lock_slowunlock+65}
       <ffffffff80476301>{__lock_text_start+9}
       <ffffffff802339b0>{try_to_del_timer_sync+85}
       <ffffffff802cca63>{kjournald+202}
       <ffffffff8023db60>{autoremove_wake_function+0}
       <ffffffff802cc999>{kjournald+0}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023da2f>{kthread+219}
       <ffffffff80225a23>{schedule_tail+188}
       <ffffffff8020aaca>{child_rip+8}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023d954>{kthread+0}
       <ffffffff8020aac2>{child_rip+0}
---------------------------
| preempt count: 00010003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff804758a7>] ..   ( <= rt_lock_slowlock+0x36/0x20e)
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff804758a7>] ..   ( <= rt_lock_slowlock+0x36/0x20e)
.. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
.....[<ffffffff8024e8d6>] ..   ( <= softlockup_tick+0xbe/0xe9)

and finally:

IRQ 1/1085[CPU#0]: BUG in set_palette at drivers/char/vt.c:2924

Call Trace:
       <ffffffff8047655a>{_raw_spin_lock_irqsave+24}
       <ffffffff8022b272>{__WARN_ON+100}
       <ffffffff8033b0dd>{set_palette+54}
       <ffffffff8033b13d>{reset_palette+66}
       <ffffffff80335497>{reset_vc+111}
       <ffffffff8033f0ba>{sysrq_handle_SAK+37}
       <ffffffff8033f210>{__handle_sysrq+149}
       <ffffffff8033f2b7>{handle_sysrq+23}
       <ffffffff80339e9d>{kbd_event+737}
       <ffffffff803d046e>{input_event+1067}
       <ffffffff803d417a>{atkbd_report_key+80}
       <ffffffff803d4ceb>{atkbd_interrupt+1230}
       <ffffffff803cd520>{serio_interrupt+69}
       <ffffffff803ce145>{i8042_interrupt+499}
       <ffffffff8024ec6c>{handle_IRQ_event+92}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8024f720>{do_irqd+350}
       <ffffffff8024f5c2>{do_irqd+0}
       <ffffffff8024f5c2>{do_irqd+0}
       <ffffffff8023da2f>{kthread+219}
       <ffffffff80225a23>{schedule_tail+188}
       <ffffffff8020aaca>{child_rip+8}
       <ffffffff8023d739>{keventd_create_kthread+0}
       <ffffffff8023d954>{kthread+0}
       <ffffffff8020aac2>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8047655a>] .... _raw_spin_lock_irqsave+0x18/0x29
.....[<ffffffff8022b22d>] ..   ( <= __WARN_ON+0x1f/0x82)

-- 
Robert Crocombe
rcrocomb@gmail.com
