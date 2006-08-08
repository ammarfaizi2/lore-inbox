Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWHHSqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWHHSqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWHHSqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:46:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43561 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965031AbWHHSqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:46:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJU6+dMiwjl6W3uNkqv41E5bQUcN4luPpQN1OhOnLTUxrv2IKYQk6TGZpm8RxK35f0hYVr6x1FInHZjXj8ZIKs6Z7K8/C86MnYtxMp9yx8dRDrhtcuJrHW9YnDmd8g/SvRmoJyMqxdPi/w7iM/iFokQbd+z/JVE56Bh7MVdddus=
Message-ID: <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
Date: Tue, 8 Aug 2006 11:46:40 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "Steven Rostedt" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Darren Hart" <dvhltc@us.ibm.com>
In-Reply-To: <20060808030524.GA20530@gnuppy.monkey.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> > I tested it with a "make -j4" which triggers the warning and it they all
> > go away now.
> >
> > Reverse patch attached:

Unfortunately, this makes no difference on my setup.  Patch applied,
made the obvious little change:

-#include <linux/dobject.h>
+#include <linux/kobject.h>

But:


kjournald/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff804875c3>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc37>{__WARN_ON+105}
       <ffffffff8022cbf2>{__WARN_ON+36}
       <ffffffff80248933>{debug_rt_mutex_unlock+204}
       <ffffffff8048678f>{rt_lock_slowunlock+30}
       <ffffffff80487306>{__lock_text_start+14}
       <ffffffff8027942d>{kmem_cache_alloc+207}
       <ffffffff8025b4d0>{mempool_alloc_slab+22}
       <ffffffff8025b8bf>{mempool_alloc+80}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff802832fe>{bio_alloc_bioset+40}
       <ffffffff802833e6>{bio_clone+34}
       <ffffffff803eb841>{make_request+1360}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff802fbbe8>{generic_make_request+380}
       <ffffffff802fd301>{submit_bio+197}
       <ffffffff8027fa71>{submit_bh+267}
       <ffffffff80280c9f>{ll_rw_block+166}
       <ffffffff802d19d7>{journal_commit_transaction+1016}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80248f5d>{constant_test_bit+9}
       <ffffffff80487ad0>{_raw_spin_unlock+51}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80487306>{__lock_text_start+14}
       <ffffffff80235870>{try_to_del_timer_sync+90}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff802d5fba>{kjournald+207}
       <ffffffff80240047>{autoremove_wake_function+0}
       <ffffffff802d5eeb>{kjournald+0}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff8023ff09>{kthread+224}
       <ffffffff802273de>{schedule_tail+210}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff8023fe29>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874df>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486787>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff804875c3>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbf2>] ..   ( <= __WARN_ON+0x24/0x8a)

kjournald/1119[CPU#1]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff804875c3>{_raw_spin_lock_irqsave+34}
       <ffffffff8022cc37>{__WARN_ON+105}
       <ffffffff8022cbf2>{__WARN_ON+36}
       <ffffffff802489d5>{debug_rt_mutex_unlock+366}
       <ffffffff8048678f>{rt_lock_slowunlock+30}
       <ffffffff80487306>{__lock_text_start+14}
       <ffffffff8027942d>{kmem_cache_alloc+207}
       <ffffffff8025b4d0>{mempool_alloc_slab+22}
       <ffffffff8025b8bf>{mempool_alloc+80}
       <ffffffff80209a6d>{mcount+45}
       <ffffffff802832fe>{bio_alloc_bioset+40}
       <ffffffff802833e6>{bio_clone+34}
       <ffffffff803eb841>{make_request+1360}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff802fbbe8>{generic_make_request+380}
       <ffffffff802fd301>{submit_bio+197}
       <ffffffff8027fa71>{submit_bh+267}
       <ffffffff80280c9f>{ll_rw_block+166}
       <ffffffff802d19d7>{journal_commit_transaction+1016}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80248f5d>{constant_test_bit+9}
       <ffffffff80487ad0>{_raw_spin_unlock+51}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80487306>{__lock_text_start+14}
       <ffffffff80235870>{try_to_del_timer_sync+90}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff802d5fba>{kjournald+207}
       <ffffffff80240047>{autoremove_wake_function+0}
       <ffffffff802d5eeb>{kjournald+0}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff8023ff09>{kthread+224}
       <ffffffff802273de>{schedule_tail+210}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff8023fe29>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874df>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486787>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff804875c3>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022cbf2>] ..   ( <= __WARN_ON+0x24/0x8a)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in: nfsd exportfs lockd sunrpc ohci1394 ieee1394 tg3
Pid: 1119, comm: kjournald Not tainted 2.6.17-rt8_local_02 #8
RIP: 0010:[<ffffffff80486908>] <ffffffff80486908>{rt_lock_slowlock+186}
RSP: 0018:ffff8105ea93b9e8  EFLAGS: 00010246
RAX: ffff810200220db0 RBX: 0000000000000010 RCX: 00000000000c0080
RDX: ffff810200220db0 RSI: ffffffff802793b2 RDI: ffff810200115ca0
RBP: ffff8105ea93baa8 R08: ffff8100011e5650 R09: ffff8105ea93b9e8
R10: ffff8100011e5650 R11: 0000000000000023 R12: ffff810200115ca0
R13: ffff810200031c40 R14: ffffffff802793b2 R15: 0000000000000010
FS:  00002b055e056480(0000) GS:ffff8102001e3340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005b755c CR3: 00000005e6e0b000 CR4: 00000000000006e0
Process kjournald (pid: 1119, threadinfo ffff8105ea93a000, task
ffff810200220db0)
Stack: 111111110000008c ffff8105ea93b9f0 ffff8105ea93b9f0 ffff8105ea93ba00
       ffff8105ea93ba00 0000000000000000 111111110000008c ffff8105ea93ba20
       ffff8105ea93ba20 ffff8105ea93ba30
Call Trace:
       <ffffffff8048731a>{rt_lock+18}
       <ffffffff802793b2>{kmem_cache_alloc+84}
       <ffffffff8025b4d0>{mempool_alloc_slab+22}
       <ffffffff8025b8bf>{mempool_alloc+80}
       <ffffffff8028336d>{bio_alloc_bioset+151}
       <ffffffff802833e6>{bio_clone+34}
       <ffffffff803eb841>{make_request+1360}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff802fbbe8>{generic_make_request+380}
       <ffffffff802fd301>{submit_bio+197}
       <ffffffff8027fa71>{submit_bh+267}
       <ffffffff80280c9f>{ll_rw_block+166}
       <ffffffff802d19d7>{journal_commit_transaction+1016}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80248f5d>{constant_test_bit+9}
       <ffffffff80487ad0>{_raw_spin_unlock+51}
       <ffffffff804867b7>{rt_lock_slowunlock+70}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff80487306>{__lock_text_start+14}
       <ffffffff80235870>{try_to_del_timer_sync+90}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff802d5fba>{kjournald+207}
       <ffffffff80240047>{autoremove_wake_function+0}
       <ffffffff802d5eeb>{kjournald+0}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff8023ff09>{kthread+224}
       <ffffffff802273de>{schedule_tail+210}
       <ffffffff8020ae12>{child_rip+8}
       <ffffffff8023fc04>{keventd_create_kthread+0}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff804856c8>{thread_return+230}
       <ffffffff8023fe29>{kthread+0}
       <ffffffff8020ae0a>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff804874df>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff80486889>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff80487898>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff80488346>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 70 44 4c 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff80486908>{rt_lock_slowlock+186} RSP <ffff8105ea93b9e8>

Triggered by building a kernel.

-- 
Robert Crocombe
rcrocomb@gmail.com
