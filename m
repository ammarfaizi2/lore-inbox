Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWHORxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWHORxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWHORxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:53:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:24205 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030410AbWHORxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:53:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dyKGilQ9TeFKTJT7Nk/2PShtC9LpF23ggY+mHBJ4MJGTgW+js6MQlafORfWrwSKluMZSU1QyZyNWMTTawpCeHaZXmdVo43RfHV3hqLNl05g2S3ys6+knRce135lp2vbuRAdhIo2vV3hMoTEVjckYnf4mxeh6SMBc59q0KGC3BKo=
Message-ID: <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com>
Date: Tue, 15 Aug 2006 10:53:10 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "Esben Nielsen" <nielsen.esben@gogglemail.com>,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       rostedt@goodmis.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060814234423.GA31230@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154615261.32264.6.camel@localhost.localdomain>
	 <20060808030524.GA20530@gnuppy.monkey.org>
	 <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
	 <20060810021835.GB12769@gnuppy.monkey.org>
	 <20060811010646.GA24434@gnuppy.monkey.org>
	 <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com>
	 <20060811211857.GA32185@gnuppy.monkey.org>
	 <20060811221054.GA32459@gnuppy.monkey.org>
	 <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com>
	 <20060814234423.GA31230@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> You have all sorts of strange things going on in that config like NUMA
> emulation and stuff which I can't imagine why you'd have that on, 1000
> a sec tick, etc... If you can do a bit of work and narrow which option
> is it, then I might be able to reproduce the situation over here. I'm
> bothered by that bug, but it's going to need to be attacked from a couple
> angles, two of which I just mentioned. If I can get a bit of help from
> you where I can isolate the subsystem, it would be helpful while I'll
> examine the tracing here.

NUMA emulation is off in the most recent one (the most recent config
posted), and the high Hz is due to 'man nanosleep':

BUGS
       The current implementation of nanosleep() is based on the normal kernel
       timer  mechanism,  which  has  a  resolution  of  1/HZ s (see time(7)).
       Therefore, nanosleep() pauses always for at least the  specified  time,
       however it can take up to 10 ms longer than specified until the process
       becomes runnable again. For the same reason, the value returned in case
       of  a  delivered  signal  in *rem is usually rounded to the next larger
       multiple of 1/HZ s.

and Other People's Code (tm).

Sadly, I am behind a firewall and cannot offer remote access to the
machine.  If you can point out some other config options that are Not
Good, then I can see about pruning them.

I've turned Hz down to 250 (the only change from the last config), but
got a BUG immediately upon boot: last bit of boot stuff and trace is
appended.  Machine booted on a second attempt, but failed when
compiling a kernel, i.e. at the same point as previously: that trace
is after the fail-on-boot trace.

-- 
Robert Crocombe
rcrocomb@gmail.com

fail on boot:


Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered (default)
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
swapper/1[CPU#3]: BUG in debug_rt_mutex_unlock at kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff803f2b2b>{_raw_spin_lock_irqsave+34}
       <ffffffff8022db21>{__WARN_ON+105}
       <ffffffff8022dadc>{__WARN_ON+36}
       <ffffffff802494f7>{debug_rt_mutex_unlock+204}
       <ffffffff803f1d10>{rt_lock_slowunlock+30}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff80277337>{cache_grow+214}
       <ffffffff80277730>{__cache_alloc_node+272}
       <ffffffff802777cc>{alternate_node_alloc+127}
       <ffffffff80278653>{kmem_cache_alloc+114}
       <ffffffff802b8c09>{sysfs_new_dirent+43}
       <ffffffff802b8f45>{sysfs_make_dirent+33}
       <ffffffff802b9046>{create_dir+160}
       <ffffffff802b97e5>{sysfs_create_dir+95}
       <ffffffff802eb81e>{kobject_add+223}
       <ffffffff8033ad25>{class_device_add+187}
       <ffffffff8033afc3>{class_device_register+30}
       <ffffffff8033b0c5>{class_device_create+253}
       <ffffffff802eec48>{sprintf+109}
       <ffffffff80209c89>{mcount+45}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8031cf81>{tty_register_device+221}
       <ffffffff8031e4c3>{tty_register_driver+512}
       <ffffffff80f3f2a3>{pty_init+464}
       <ffffffff802071cc>{init+343}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80207075>{init+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1d08>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff803f2b2b>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022dadc>] ..   ( <= __WARN_ON+0x24/0x88)

swapper/1[CPU#3]: BUG in debug_rt_mutex_unlock at kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff803f2b2b>{_raw_spin_lock_irqsave+34}
       <ffffffff8022db21>{__WARN_ON+105}
       <ffffffff8022dadc>{__WARN_ON+36}
       <ffffffff80249599>{debug_rt_mutex_unlock+366}
       <ffffffff803f1d10>{rt_lock_slowunlock+30}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff80277337>{cache_grow+214}
       <ffffffff80277730>{__cache_alloc_node+272}
       <ffffffff802777cc>{alternate_node_alloc+127}
       <ffffffff80278653>{kmem_cache_alloc+114}
       <ffffffff802b8c09>{sysfs_new_dirent+43}
       <ffffffff802b8f45>{sysfs_make_dirent+33}
       <ffffffff802b9046>{create_dir+160}
       <ffffffff802b97e5>{sysfs_create_dir+95}
       <ffffffff802eb81e>{kobject_add+223}
       <ffffffff8033ad25>{class_device_add+187}
       <ffffffff8033afc3>{class_device_register+30}
       <ffffffff8033b0c5>{class_device_create+253}
       <ffffffff802eec48>{sprintf+109}
       <ffffffff80209c89>{mcount+45}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8031cf81>{tty_register_device+221}
       <ffffffff8031e4c3>{tty_register_driver+512}
       <ffffffff80f3f2a3>{pty_init+464}
       <ffffffff802071cc>{init+343}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80207075>{init+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1d08>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff803f2b2b>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022dadc>] ..   ( <= __WARN_ON+0x24/0x88)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.17-rt8_t2_01 #2
RIP: 0010:[<ffffffff803f1e89>] <ffffffff803f1e89>{rt_lock_slowlock+186}
RSP: 0000:ffff8101eac49978  EFLAGS: 00010246
RAX: ffff81060018a000 RBX: 0000000000000030 RCX: 00000000000c0080
RDX: ffff81060018a000 RSI: ffffffff80277592 RDI: ffff810200115b00
RBP: ffff8101eac49a38 R08: 0000000000000000 R09: ffff8101eac49978
R10: 0000000000000000 R11: 0000000000000000 R12: ffff810200115b00
R13: ffff8102003b50f0 R14: ffffffff80277592 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffff8102001d4340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff8101eac48000, task ffff81060018a000)
Stack: 111111110000008c ffff8101eac49980 ffff8101eac49980 ffff8101eac49990
       ffff8101eac49990 0000000000000000 111111110000008c ffff8101eac499b0
       ffff8101eac499b0 ffff8101eac499c0
Call Trace:
       <ffffffff803f2882>{rt_lock+18}
       <ffffffff80277592>{cache_grow+817}
       <ffffffff80277730>{__cache_alloc_node+272}
       <ffffffff802777cc>{alternate_node_alloc+127}
       <ffffffff80278653>{kmem_cache_alloc+114}
       <ffffffff802b8c09>{sysfs_new_dirent+43}
       <ffffffff802b8f45>{sysfs_make_dirent+33}
       <ffffffff802b9046>{create_dir+160}
       <ffffffff802b97e5>{sysfs_create_dir+95}
       <ffffffff802eb81e>{kobject_add+223}
       <ffffffff8033ad25>{class_device_add+187}
       <ffffffff8033afc3>{class_device_register+30}
       <ffffffff8033b0c5>{class_device_create+253}
       <ffffffff802eec48>{sprintf+109}
       <ffffffff80209c89>{mcount+45}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8031cf81>{tty_register_device+221}
       <ffffffff8031e4c3>{tty_register_driver+512}
       <ffffffff80f3f2a3>{pty_init+464}
       <ffffffff802071cc>{init+343}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80207075>{init+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1e0a>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff803f2d61>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff8020b474>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 1b 3d 41 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff803f1e89>{rt_lock_slowlock+186} RSP <ffff8101eac49978>
 <0>Kernel panic - not syncing: Attempted to kill init!

Call Trace:
       <ffffffff8022ca20>{panic+175}
       <ffffffff80251c92>{__trace+148}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8022fadc>{do_exit+156}
       <ffffffff803f3077>{_raw_spin_unlock_irqrestore+89}
       <ffffffff8020bb1c>{kernel_math_error+0}
       <ffffffff8020bc9b>{do_trap+228}
       <ffffffff80277592>{cache_grow+817}
       <ffffffff8020c382>{do_invalid_op+177}
       <ffffffff803f1e89>{rt_lock_slowlock+186}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8020ae75>{error_exit+0}
       <ffffffff80277592>{cache_grow+817}
       <ffffffff80277592>{cache_grow+817}
       <ffffffff803f1e89>{rt_lock_slowlock+186}
       <ffffffff803f1e61>{rt_lock_slowlock+146}
       <ffffffff803f2882>{rt_lock+18}
       <ffffffff80277592>{cache_grow+817}
       <ffffffff80277730>{__cache_alloc_node+272}
       <ffffffff802777cc>{alternate_node_alloc+127}
       <ffffffff80278653>{kmem_cache_alloc+114}
       <ffffffff802b8c09>{sysfs_new_dirent+43}
       <ffffffff802b8f45>{sysfs_make_dirent+33}
       <ffffffff802b9046>{create_dir+160}
       <ffffffff802b97e5>{sysfs_create_dir+95}
       <ffffffff802eb81e>{kobject_add+223}
       <ffffffff8033ad25>{class_device_add+187}
       <ffffffff8033afc3>{class_device_register+30}
       <ffffffff8033b0c5>{class_device_create+253}
       <ffffffff802eec48>{sprintf+109}
       <ffffffff80209c89>{mcount+45}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff80209c89>{mcount+45}
       <ffffffff8031cf81>{tty_register_device+221}
       <ffffffff8031e4c3>{tty_register_driver+512}
       <ffffffff80f3f2a3>{pty_init+464}
       <ffffffff802071cc>{init+343}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80207075>{init+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1e0a>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff8022c9b4>] .... panic+0x43/0x16f
.....[<ffffffff8022fadc>] ..   ( <= do_exit+0x9c/0x9a2)



2nd trace (fail on compile)



kjournald/1061[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:471

Call Trace:
       <ffffffff803f2b2b>{_raw_spin_lock_irqsave+34}
       <ffffffff8022db21>{__WARN_ON+105}
       <ffffffff8022dadc>{__WARN_ON+36}
       <ffffffff802494f7>{debug_rt_mutex_unlock+204}
       <ffffffff803f1d10>{rt_lock_slowunlock+30}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff802786b0>{kmem_cache_alloc+207}
       <ffffffff80259d18>{mempool_alloc_slab+22}
       <ffffffff8025a107>{mempool_alloc+80}
       <ffffffff80209c89>{mcount+45}
       <ffffffff80281832>{bio_alloc_bioset+40}
       <ffffffff80281952>{bio_alloc+21}
       <ffffffff8027df28>{submit_bh+142}
       <ffffffff8027f1d3>{ll_rw_block+166}
       <ffffffff802cefe6>{journal_commit_transaction+995}
       <ffffffff803f2f99>{_raw_spin_unlock+51}
       <ffffffff803f1d38>{rt_lock_slowunlock+70}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff802365dd>{try_to_del_timer_sync+90}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff802d3555>{kjournald+204}
       <ffffffff80240caf>{autoremove_wake_function+0}
       <ffffffff802d3489>{kjournald+0}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240b6f>{kthread+224}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240a8f>{kthread+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1d08>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff803f2b2b>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022dadc>] ..   ( <= __WARN_ON+0x24/0x88)

kjournald/1061[CPU#3]: BUG in debug_rt_mutex_unlock at
kernel/rtmutex-debug.c:472

Call Trace:
       <ffffffff803f2b2b>{_raw_spin_lock_irqsave+34}
       <ffffffff8022db21>{__WARN_ON+105}
       <ffffffff8022dadc>{__WARN_ON+36}
       <ffffffff80249599>{debug_rt_mutex_unlock+366}
       <ffffffff803f1d10>{rt_lock_slowunlock+30}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff802786b0>{kmem_cache_alloc+207}
       <ffffffff80259d18>{mempool_alloc_slab+22}
       <ffffffff8025a107>{mempool_alloc+80}
       <ffffffff80209c89>{mcount+45}
       <ffffffff80281832>{bio_alloc_bioset+40}
       <ffffffff80281952>{bio_alloc+21}
       <ffffffff8027df28>{submit_bh+142}
       <ffffffff8027f1d3>{ll_rw_block+166}
       <ffffffff802cefe6>{journal_commit_transaction+995}
       <ffffffff803f2f99>{_raw_spin_unlock+51}
       <ffffffff803f1d38>{rt_lock_slowunlock+70}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff802365dd>{try_to_del_timer_sync+90}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff802d3555>{kjournald+204}
       <ffffffff80240caf>{autoremove_wake_function+0}
       <ffffffff802d3489>{kjournald+0}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240b6f>{kthread+224}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240a8f>{kthread+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1d08>] ..   ( <= rt_lock_slowunlock+0x16/0x70)
.. [<ffffffff803f2b2b>] .... _raw_spin_lock_irqsave+0x22/0x33
.....[<ffffffff8022dadc>] ..   ( <= __WARN_ON+0x24/0x88)

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT SMP
CPU 3
Modules linked in: tg3
Pid: 1061, comm: kjournald Not tainted 2.6.17-rt8_t2_01 #2
RIP: 0010:[<ffffffff803f1e89>] <ffffffff803f1e89>{rt_lock_slowlock+186}
RSP: 0000:ffff8104003bdb98  EFLAGS: 00010246
RAX: ffff8102001c7540 RBX: 0000000000000010 RCX: 0000000000240180
RDX: ffff8102001c7540 RSI: ffffffff80278635 RDI: ffff810600115b00
RBP: ffff8104003bdc58 R08: ffffffff803f0c50 R09: ffff8104003bdb98
R10: ffffffff803f0c50 R11: 0000000000000023 R12: ffff810600115b00
R13: ffff8101eafa7b80 R14: ffffffff80278635 R15: 0000000000000010
FS:  00002ad25bb03200(0000) GS:ffff8106001eb340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002ad25f085000 CR3: 00000001e68bf000 CR4: 00000000000006e0
Process kjournald (pid: 1061, threadinfo ffff8104003bc000, task
ffff8102001c7540)
Stack: 111111110000008c ffff8104003bdba0 ffff8104003bdba0 ffff8104003bdbb0
       ffff8104003bdbb0 0000000000000000 111111110000008c ffff8104003bdbd0
       ffff8104003bdbd0 ffff8104003bdbe0
Call Trace:
       <ffffffff803f2882>{rt_lock+18}
       <ffffffff80278635>{kmem_cache_alloc+84}
       <ffffffff80259d18>{mempool_alloc_slab+22}
       <ffffffff8025a107>{mempool_alloc+80}
       <ffffffff802818a1>{bio_alloc_bioset+151}
       <ffffffff80281952>{bio_alloc+21}
       <ffffffff8027df28>{submit_bh+142}
       <ffffffff8027f1d3>{ll_rw_block+166}
       <ffffffff802cefe6>{journal_commit_transaction+995}
       <ffffffff803f2f99>{_raw_spin_unlock+51}
       <ffffffff803f1d38>{rt_lock_slowunlock+70}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff803f286e>{__lock_text_start+14}
       <ffffffff802365dd>{try_to_del_timer_sync+90}
       <ffffffff803f0cb5>{thread_return+230}
       <ffffffff802d3555>{kjournald+204}
       <ffffffff80240caf>{autoremove_wake_function+0}
       <ffffffff802d3489>{kjournald+0}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240b6f>{kthread+224}
       <ffffffff80228e7c>{schedule_tail+190}
       <ffffffff8020b02e>{child_rip+8}
       <ffffffff80240881>{keventd_create_kthread+0}
       <ffffffff80240a8f>{kthread+0}
       <ffffffff8020b026>{child_rip+0}
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f2a47>] .... _raw_spin_lock+0x1b/0x28
.....[<ffffffff803f1e0a>] ..   ( <= rt_lock_slowlock+0x3b/0x213)
.. [<ffffffff803f2d61>] .... _raw_spin_trylock+0x1b/0x5f
.....[<ffffffff8020b474>] ..   ( <= oops_begin+0x28/0x77)


Code: 0f 0b 68 1b 3d 41 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff803f1e89>{rt_lock_slowlock+186} RSP <ffff8104003bdb98>
 <6>note: kjournald[1061] exited with preempt_count 1
