Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWHCQEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWHCQEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWHCQEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:04:35 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3486 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964821AbWHCQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:04:34 -0400
Subject: Re: Problems with 2.6.17-rt8
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Bill Huey <billh@gnuppy.monkey.org>
In-Reply-To: <e6babb600608030848p4446cb8emff58519d62deb9d8@mail.gmail.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <e6babb600608030808x632bd5e8y7dcb991fe229467d@mail.gmail.com>
	 <1154618859.32264.19.camel@localhost.localdomain>
	 <e6babb600608030848p4446cb8emff58519d62deb9d8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 12:04:19 -0400
Message-Id: <1154621059.32264.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 08:48 -0700, Robert Crocombe wrote:
> I am sad.

Cheer up... It's OK ;)

> 
> Okay, I couldn't use that same machine, which had to be swapped with
> something else,  but I have a very similar machine (32GB vs 8GB of
> RAM, 1 additional video card and some extra 1394b cards) which hit the
> same problem.  The trace from it is:

Are you also getting any warnings or BUG reports before this.  In your
other dmesg, it should a bug being reported. This could cause problems
later on.

That said, this is starting to look like a NUMA problem. So I would like
to know where that lock is being taken exactly.

> 
> md0_raid1/1118[CPU#3]: BUG in debug_rt_mutex_unlock at
> kernel/rtmutex-debug.c:471
> 
> Call Trace:
>        <ffffffff80487453>{_raw_spin_lock_irqsave+34}
>        <ffffffff8022cc03>{__WARN_ON+105}
>        <ffffffff8022cbbe>{__WARN_ON+36}
>        <ffffffff8024880b>{debug_rt_mutex_unlock+204}
>        <ffffffff80486621>{rt_lock_slowunlock+30}
>        <ffffffff80487196>{__lock_text_start+14}
>        <ffffffff802792f9>{kmem_cache_alloc+207}
>        <ffffffff8025b394>{mempool_alloc_slab+22}
>        <ffffffff8025b783>{mempool_alloc+80}
>        <ffffffff80248e35>{constant_test_bit+9}
>        <ffffffff80487960>{_raw_spin_unlock+51}
>        <ffffffff80486649>{rt_lock_slowunlock+70}
>        <ffffffff802fde74>{get_request+375}
>        <ffffffff80209a6d>{mcount+45}
>        <ffffffff802fe04c>{get_request_wait+45}
>        <ffffffff80209a6d>{mcount+45}
>        <ffffffff803023c5>{as_merge+0}
>        <ffffffff803023db>{as_merge+22}
>        <ffffffff802fe425>{__make_request+750}
>        <ffffffff803fc2b7>{md_thread+0}
>        <ffffffff802fba78>{generic_make_request+380}
>        <ffffffff80248e35>{constant_test_bit+9}
>        <ffffffff80487960>{_raw_spin_unlock+51}
>        <ffffffff803fc2b7>{md_thread+0}
>        <ffffffff803ea43c>{raid1d+246}
>        <ffffffff80209a6d>{mcount+45}
>        <ffffffff80209a6d>{mcount+45}
>        <ffffffff80486649>{rt_lock_slowunlock+70}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff80248e35>{constant_test_bit+9}
>        <ffffffff80487960>{_raw_spin_unlock+51}
>        <ffffffff80486649>{rt_lock_slowunlock+70}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff80487196>{__lock_text_start+14}
>        <ffffffff803fc2b7>{md_thread+0}
>        <ffffffff8023fb55>{keventd_create_kthread+0}
>        <ffffffff803fc3cf>{md_thread+280}
>        <ffffffff8023ff97>{autoremove_wake_function+0}
>        <ffffffff8023fe5a>{kthread+224}
>        <ffffffff802273bf>{schedule_tail+198}
>        <ffffffff8020ae12>{child_rip+8}
>        <ffffffff8023fb55>{keventd_create_kthread+0}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff80485568>{thread_return+230}
>        <ffffffff8023fd7a>{kthread+0}
>        <ffffffff8020ae0a>{child_rip+0}
> ---------------------------
> | preempt count: 00000002 ]
> | 2-level deep critical section nesting:
> ----------------------------------------
> .. [<ffffffff8048736f>] .... _raw_spin_lock+0x1b/0x28
> .....[<ffffffff80486619>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
> .. [<ffffffff80487453>] .... _raw_spin_lock_irqsave+0x22/0x33
> .....[<ffffffff8022cbbe>] ..   ( <= __WARN_ON+0x24/0x8a)
> 
> which makes:
> 
>    <ffffffff802792f9>{kmem_cache_alloc+207}
> 
> the interesting part?

Yeah, I would say that.  I'm sure it's also doing a NUMA alloc in there
too.

> 
> However:
> 
> rcrocomb@spanky:2.6.17-rt8$ grep DEBUG_INFO .config
> CONFIG_DEBUG_INFO=y
> rcrocomb@spanky:2.6.17-rt8$ cd arch/x86_64/boot/compressed/
> rcrocomb@spanky:compressed$ gdb vmlinux
> GNU gdb Red Hat Linux (6.3.0.0-1.122rh)
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "x86_64-redhat-linux-gnu"...
> (no debugging symbols found)
> Using host libthread_db library "/lib64/libthread_db.so.1".
> 
> (gdb) li *0xffffffff802792f9
> No symbol table is loaded.  Use the "file" command.
> 
> Huh.

??

Are you sure that vmlinux is the one created with the given config file?
There's been times when I added some configs and either forgot to
compile, or the compile failed, and I didn't notice, so the old binary
was being used.

-- Steve

> 
> -- 
> Robert Crocombe
> rcrocomb@gmail.com
> 
> In case this might be useful:
> 
> rcrocomb@spanky:2.6.17-rt8$ grep -i debug .config
> .
> .
> .
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_TRACE_IRQFLAGS=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_FS is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_DEBUG_RODATA=y
> CONFIG_IOMMU_DEBUG=y

