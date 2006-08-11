Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWHKPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWHKPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWHKPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:00:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40996 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750950AbWHKPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uu5bAd1KMlRUhoo3CdVXBxUb1r7EpEM4Bjxw7qVZ34qKrh7F7O6Bs0N0BKMRC/LTaIZ0mdlcrCshhFkj/GAEzfiwre76stb9ukxqrH4U+M0hbeD/UuseX0pygvpsTJDZirCFfw/p76eY7DSJHNPFLCxJ/D7C0J5ZlXOuMMS4G/I=
Message-ID: <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com>
Date: Fri, 11 Aug 2006 08:00:50 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "Esben Nielsen" <nielsen.esben@gogglemail.com>,
       "Steven Rostedt" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Darren Hart" <dvhltc@us.ibm.com>
In-Reply-To: <20060811010646.GA24434@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <20060808025615.GA20364@gnuppy.monkey.org>
	 <20060808030524.GA20530@gnuppy.monkey.org>
	 <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
	 <20060810021835.GB12769@gnuppy.monkey.org>
	 <20060811010646.GA24434@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> This is the second round of getting rid of the locking problems with free_task()
>
> This extends the mmdrop logic with desched_thread() to also handle free_task()
> requests as well. I believe this address your concerns and I'm open to review
> of this patch.
>
> Patch included:

Just tried it.

-- 
Robert Crocombe
rcrocomb@gmail.com

kjournald/1119[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff80487593>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cd9f>{__WARN_ON+105}
       <ffffffff8022cd5a>{__WARN_ON+36}
       <ffffffff8024897b>{debug_rt_mutex_unlock+204}
       <ffffffff80486761>{rt_lock_slowunlock+30}
       <ffffffff804872d6>{__lock_text_start+14}
       <ffffffff80279461>{kmem_cache_alloc+207}
       <ffffffff8025b504>{mempool_alloc_slab+22}
       <ffffffff8025b8f3>{mempool_alloc+80}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80283332>{bio_alloc_bioset+40}
       <ffffffff80283452>{bio_alloc+21}
       <ffffffff8027fa28>{submit_bh+142}
       <ffffffff80280cd3>{ll_rw_block+166}
       <ffffffff802d19cf>{journal_commit_transaction+1016}
       <ffffffff80248fa5>{constant_test_bit+9}
       <ffffffff80487aa0>{_raw_spin_unlock+51}
       <ffffffff80486789>{rt_lock_slowunlock+70}
       <ffffffff804872d6>{__lock_text_start+14}
       <ffffffff80235974>{try_to_del_timer_sync+90}
       <ffffffff802d5fb2>{kjournald+207}
       <ffffffff80240107>{autoremove_wake_function+0}
       <ffffffff802d5ee3>{kjournald+0}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023ffca>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023feea>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874af>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486759>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487593>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cd5a>] ..   ( <= __WARN_ON+0x24/0x8a)

kjournald/1119[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff80487593>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cd9f>{__WARN_ON+105}
       <ffffffff8022cd5a>{__WARN_ON+36}
       <ffffffff80248a1d>{debug_rt_mutex_unlock+366}
       <ffffffff80486761>{rt_lock_slowunlock+30}
       <ffffffff804872d6>{__lock_text_start+14}
       <ffffffff80279461>{kmem_cache_alloc+207}
       <ffffffff8025b504>{mempool_alloc_slab+22}
       <ffffffff8025b8f3>{mempool_alloc+80}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff80283332>{bio_alloc_bioset+40}
       <ffffffff80283452>{bio_alloc+21}
       <ffffffff8027fa28>{submit_bh+142}
       <ffffffff80280cd3>{ll_rw_block+166}
       <ffffffff802d19cf>{journal_commit_transaction+1016}
       <ffffffff80248fa5>{constant_test_bit+9}
       <ffffffff80487aa0>{_raw_spin_unlock+51}
       <ffffffff80486789>{rt_lock_slowunlock+70}
       <ffffffff804872d6>{__lock_text_start+14}
       <ffffffff80235974>{try_to_del_timer_sync+90}
       <ffffffff802d5fb2>{kjournald+207}
       <ffffffff80240107>{autoremove_wake_function+0}
       <ffffffff802d5ee3>{kjournald+0}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023ffca>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023feea>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874af>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486759>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff80487593>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cd5a>] ..   ( <= __WARN_ON+0x24/0x8a)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 3
Modules linked in: ohci1394 ieee1394 tg3
Pid: 1119, comm: kjournald Not tainted 2.6.17-rt8_t2_00 #2
RIP: 0010:[<ffffffff804868da>] <ffffffff804868da>{rt_lock_slowlock+186}
RSP: 0000:ffff8107eacbdb38  EFLAGS: 00010246
RAX: ffff8105eade7100 RBX: 0000000000000010 RCX: 0000000000240180
RDX: ffff8105eade7100 RSI: ffffffff802793e6 RDI: ffff810600115ca0
RBP: ffff8107eacbdbf8 R08: ffff8102000d7f38 R09: ffff8107eacbdb38
R10: ffff8102000d7f38 R11: 0000000000000023 R12: ffff810600115ca0
R13: ffff8101eae158c0 R14: ffffffff802793e6 R15: 0000000000000010
FS:  00002ab5934811e0(0000) GS:ffff810600211340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002ab5969c1000 CR3: 00000005e69e4000 CR4: 00000000000006e0
Process kjournald (pid: 1119, threadinfo ffff8107eacbc000, task
ffff8105eade7100)
Stack: 111111110000008c ffff8107eacbdb40 ffff8107eacbdb40 ffff8107eacbdb50
       ffff8107eacbdb50 0000000000000000 111111110000008c ffff8107eacbdb70
       ffff8107eacbdb70 ffff8107eacbdb80
Call Trace:
       <ffffffff804872ea>{rt_lock+18}
       <ffffffff802793e6>{kmem_cache_alloc+84}
       <ffffffff8025b504>{mempool_alloc_slab+22}
       <ffffffff8025b8f3>{mempool_alloc+80}
       <ffffffff802833a1>{bio_alloc_bioset+151}
       <ffffffff80283452>{bio_alloc+21}
       <ffffffff8027fa28>{submit_bh+142}
       <ffffffff80280cd3>{ll_rw_block+166}
       <ffffffff802d19cf>{journal_commit_transaction+1016}
       <ffffffff80248fa5>{constant_test_bit+9}
       <ffffffff80487aa0>{_raw_spin_unlock+51}
       <ffffffff80486789>{rt_lock_slowunlock+70}
       <ffffffff804872d6>{__lock_text_start+14}
       <ffffffff80235974>{try_to_del_timer_sync+90}
       <ffffffff802d5fb2>{kjournald+207}
       <ffffffff80240107>{autoremove_wake_function+0}
       <ffffffff802d5ee3>{kjournald+0}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023ffca>{kthread+224}
       <ffffffff802273bf>{schedule_tail+198}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fcc5>{keventd_create_kthread+0}
       <ffffffff8023feea>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874af>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff8048685b>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff80487868>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff80488316>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 70 44 4c 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff804868da>{rt_lock_slowlock+186} RSP <ffff8107eacbdb38>
