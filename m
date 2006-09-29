Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161727AbWI2RRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161727AbWI2RRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161831AbWI2RRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:17:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161727AbWI2RRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:17:35 -0400
Date: Fri, 29 Sep 2006 10:17:31 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] -git8,9:  NULL pointer dereference in mptspi_dv_renegotiate_work
Message-ID: <20060929171731.GX12968@osdl.org>
References: <20060928202548.GO12968@osdl.org> <20060928145121.561f077d.akpm@osdl.org> <20060928225426.GR12968@osdl.org> <20060928172652.058c781b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172652.058c781b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 05:26:52PM -0700, Andrew Morton wrote:
> On Thu, 28 Sep 2006 15:54:26 -0700
> Bryce Harrington <bryce@osdl.org> wrote:
> 
> > On Thu, Sep 28, 2006 at 02:51:21PM -0700, Andrew Morton wrote:
> > > On Thu, 28 Sep 2006 13:25:48 -0700
> > > Bryce Harrington <bryce@osdl.org> wrote:
> > > 
> > > > Apologies if this has already been reported;
> > > 
> > > It has not.
> > > 
> > > >  I didn't spot it on the
> > > > list.  We've noticed an Oops on AMD64 when running linux-2.6.18-git8 and
> > > > -git9, but not -git7:
> > > > 
> > > >  mptbase: Initiating ioc0 recovery
> > > >  Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP: 
> > > >   [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
> > > >  PGD 0 
> > > >  Oops: 0000 [1] PREEMPT SMP 
> > > 
> > 
> > > That's very clever.  
> > >
> > > I'd be suspecting a miscompile, or something horrid in kfree().
> > > 
> > > Does it change anything if you move that kfree() down a bit?
> > > 
> > 
> > Got essentially the same oops, although the addresses have changed a
> > little:
> > 
> > mptbase: Initiating ioc0 recovery
> > Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP:
> >  [<ffffffff80489aa3>] mptspi_dv_renegotiate_work+0xd/0x4c
> > PGD 0
> > Oops: 0000 [1] PREEMPT SMP
> > CPU 0
> > Modules linked in:
> > Pid: 8, comm: events/0 Not tainted 2.6.18-git10 #1
> > RIP: 0010:[<ffffffff80489aa3>]  [<ffffffff80489aa3>] mptspi_dv_renegotiate_work+0xd/0x4c
> > RSP: 0000:ffff81003ec65e40  EFLAGS: 00010246
> > RAX: ffff81003ec65ef8 RBX: ffff81003eff6640 RCX: ffff81003ec65ef8
> > RDX: ffff81003ed0cf58 RSI: 0000000000000000 RDI: ffff81003eff6640
> > RBP: 0000000000000500 R08: ffff81003ec64000 R09: 00000000ffffffff
> > R10: 00000000ffffffff R11: ffff81003ed0cf40 R12: ffff81003eff6640
> > R13: 0000000000000213 R14: ffff81003eff6640 R15: ffffffff80489a96
> > FS:  0000000000000000(0000) GS:ffffffff8077a000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > CR2: 0000000000000500 CR3: 0000000000201000 CR4: 00000000000006e0
> > Process events/0 (pid: 8, threadinfo ffff81003ec64000, task ffff81007f180740)
> > Stack:  ffff81003eff6640 ffff81003eff6648 ffff81003ed0cf40 ffffffff8023f1bd
> >  ffff81003ed0cf40 ffff81003ed0cf40 ffffffff8023f204 ffff8100016dfd70
> >  00000000fffffffc ffffffff8059457d 0000000000000000 ffffffff8023f30
> > Call Trace:
> >  [<ffffffff8023f1bd>] run_workqueue+0x9a/0xe1
> >  [<ffffffff8023f204>] worker_thread+0x0/0x12e
> >  [<ffffffff8023f300>] worker_thread+0xfc/0x12e
> >  [<ffffffff80229f62>] default_wake_function+0x0/0xe
> >  [<ffffffff80229f62>] default_wake_function+0x0/0xe
> >  [<ffffffff80242433>] kthread+0xc8/0xf1
> >  [<ffffffff8020a3f8>] child_rip+0xa/0x12
> >  [<ffffffff8024236b>] kthread+0x0/0xf1
> >  [<ffffffff8020a3ee>] child_rip+0x0/0x12
> > 
> > 
> > Code: 48 8b 45 00 48 8b b8 50 01 00 00 e8 5d 4d fe ff 48 85 c0 48
> > RIP  [<ffffffff80489aa3>] mptspi_dv_renegotiate_work+0xd/0x4c
> >  RSP <ffff81003ec65e40>
> > CR2: 0000000000000500
> >  <6>mptbase: Initiating ioc0 recovery
> > mptbase: Initiating ioc0 recovery
> > mptbase: Initiating ioc0 recovery
> > mptbase: Initiating ioc0 recovery
> > mptbase: Initiating ioc0 recovery
> > scsi0 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=185
> >  target0:0:0: dma_alloc_coherent for parameters failed
> > mptscsih: ioc0: attempting task abort! (sc=ffff81003e840c80)
> > scsi 0:0:0:0:
> >         command: cdb[0]=0x12: 12 00 00 00 24 00
> > mptbase: Initiating ioc0 recovery
> > 
> 
> Ah.  Maybe we're simply being passed a junk pointer.  This, please:
> 
> --- a/drivers/message/fusion/mptspi.c~a
> +++ a/drivers/message/fusion/mptspi.c
> @@ -804,6 +804,9 @@ mptspi_dv_renegotiate(struct _MPT_SCSI_H
>  	if (!wqw)
>  		return;
>  
> +	printk("%p\n", hd);
> +	if ((unsigned long)hd < 4000UL)
> +		dump_stack();
>  	INIT_WORK(&wqw->work, mptspi_dv_renegotiate_work, wqw);
>  	wqw->hd = hd;
>  
> _

Here's the stack dump:

mptbase: Initiating ioc0 recovery
0000000000000500

Call Trace:
<IRQ>  [<ffffffff803e0d37>] vgacon_cursor+0x0/0x1a7
[<ffffffff80489b19>] mptspi_dv_renegotiate+0x3e/0x79
[<ffffffff80489b7b>] mptspi_ioc_reset+0x27/0x2e
[<ffffffff804846ea>] mpt_do_ioc_recovery+0x115f/0x11dd
[<ffffffff802387d7>] current_tick_length+0x5/0x26
[<ffffffff80238dd4>] do_timer+0x2f6/0x574
[<ffffffff8023851c>] lock_timer_base+0x1b/0x3c
[<ffffffff8055ebff>] _spin_lock+0xe/0x5e
[<ffffffff8022797a>] task_rq_lock+0x3d/0x6f
[<ffffffff80227d03>] resched_task+0x4e/0x71
[<ffffffff8022847f>] try_to_wake_up+0x3d4/0x3e6
[<ffffffff80461794>] atapi_output_bytes+0x21/0x5c
[<ffffffff802387d7>] current_tick_length+0x5/0x26
[<ffffffff8055ebff>] _spin_lock+0xe/0x5e
[<ffffffff8022797a>] task_rq_lock+0x3d/0x6f
[<ffffffff80227d03>] resched_task+0x4e/0x71
[<ffffffff8022847f>] try_to_wake_up+0x3d4/0x3e6
[<ffffffff8020cf66>] main_timer_handler+0x1e6/0x3a6
[<ffffffff80228f29>] find_busiest_group+0x21f/0x66f
[<ffffffff80484f94>] mpt_HardResetHandler+0xb4/0x12c
[<ffffffff8048500c>] mpt_timer_expired+0x0/0x24
[<ffffffff80485017>] mpt_timer_expired+0xb/0x24
[<ffffffff80238a07>] run_timer_softirq+0x156/0x1b2
[<ffffffff802357a1>] __do_softirq+0x46/0xb1
[<ffffffff8020a76c>] call_softirq+0x1c/0x28
[<ffffffff8020bb5f>] do_softirq+0x2c/0x7d
[<ffffffff80207c37>] default_idle+0x0/0x47
[<ffffffff8023583f>] irq_exit+0x33/0x3e
[<ffffffff8020a216>] apic_timer_interrupt+0x66/0x70
<EOI>  [<ffffffff80207c60>] default_idle+0x29/0x47
[<ffffffff80207e3e>] cpu_idle+0x87/0xbe
[<ffffffff80794704>] start_kernel+0x203/0x205
[<ffffffff80794179>] _sinittext+0x179/0x17d

Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP: 
[<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
PGD 0 
Oops: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in:
Pid: 8, comm: events/0 Not tainted 2.6.18-git10 #1
RIP: 0010:[<ffffffff80489aa2>]  [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
RSP: 0000:ffff81003ec65e40  EFLAGS: 00010282
RAX: 0000000000000004 RBX: ffff81003eff3640 RCX: 000000000000001e
RDX: 0000000000000003 RSI: 0000000000000213 RDI: 000000000003eff3
RBP: 0000000000000500 R08: ffff81003ed0cf88 R09: ffff81003ed0cf40
R10: ffff81003eff3640 R11: ffff81003ed0cf40 R12: ffff81003ed0cf40
R13: 0000000000000213 R14: ffff81003eff3640 R15: ffffffff80489a96
FS:  0000000000knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000500 CR3: 0000000000201000 CR4: 00000000000006e0
Process events/0 (pid: 8, threadinfo ffff81003ec64000, task ffff81007f180740)
Stack:  0000000000000000 ffff81003eff3640 ffff81003eff3648 ffffffff8023f1bd
ffff81003ed0cf40 ffff81003ed0cf40 ffffffff8023f204 ffff8100016dfd70
00000000fffffffc fd 0000000000000000 ffffffff8023f300
Call Trace:
[<ffffffff8023f1bd>] run_workqueue+0x9a/0xe1
[<ffffffff8023f204>] worker_thread+0x0/0x12e
[<ffffffff8023f300>] worker_thread+0xfc/0x12e
[<ffffffff80229f62>] default_wake_function+0x0/0xe
[<ffffffff80229f62>] default_wake_function+0x0/0xe
[<ffffffff80242433>] kthread+0xc8/0xf1
[<ffffffff8020a3f8>] child_rip+0xa/0x12
[<ffffad+0x0/0xf1
[<ffffffff8020a3ee>] child_rip+0x0/0x12


Code: 48 8b 45 00 31 f6 48 8b b8 50 01 00 00 e8 5c 4d fe ff 48 85 
RIP  [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
RSP <ffff81003ec65e40>
CR2: 0000000000000500
<6>mptbase: Initiating ioc0 recovery
0000000000000500

Call Trace:
<IRQ>  [<ffffffff803e0d37>] vgacon_cursor+0x0/0x1a7
[<ffffffff80489b19>] mptspi_dv_renegotiate+0x3e/0x79
[<ffffffff80489b7b>] mptspi_ioc_reset+0x27/0x2e
[<ffffffff804846ea>] mpt_do_ioc_recovery+0x115f/0x11dd
[<ffffffff802387d7>] current_tick_length+0x5/0x26
[<ffffffff80238dd4>] do_timer+0x2f6/0x574
[<ffffffff8023851c>] lock_timer_base+0x1b/0x3c
[<ffffffff8055ebff>] _spin_lock+0xe/0x5e
[<ffffffff8022797a>] task_rq_lock+0x3d/0x6f
[<ffffffff80227d03>] resched_task+0x4e/0x71
[<ffffffff8022847f>] try_to_wake_up+0x3d4/0x3e6
[<ffffffff80461794>] atapi_output_bytes+0x21/0x5c
[<ffffffff802387d7>] current_tick_length+0x5/0x26
[<ffffffff80238dd4>] do_timer+0x2f6/0x574
[<ffffffff8055ebff>] _spin_lock+0xe/0x5e
[<ffffffff8020cf66>] main_timer_hax3a6
[<ffffffff80228f29>] find_busiest_group+0x21f/0x66f
[<ffffffff8055ebff>] _spin_lock+0xe/0x5e
[<ffffffff80484f94>] mpt_HardResetHandler+0xb4/0x12c
[<ffffffff8048500c>] mpt_timer_expired+0x0/0x24
[<ffffffff80485017>] mpt_timer_expired+0xb/0x24
[<ffffffff80238a07>] run_timer_softirq+0x156/0x1b2
[<ffffffff802357a1>] __do_softirq+0x46/0xb1
[<ffffffff8020a76c>] call_softir+0x1c/0x28
[<ffffffff8020bb5f>] do_softirq+0x2c/0x7d
[<ffffffff80207c37>] default_idle+0x0/0x47
[<ffffffff8023583f>] irq_exit+0x33/0x3e
[<ffffffff8020a216>] apic_timer_interrupt+0x66/0x70
<EOI>  [<ffffffff80207c60>] default_idle+0x29/0x47
[<ffffffff80207e3e>] cpu_idle+0x87/0xbe
[<ffffffff80794704>] start_kernel+0x203/0x205
[<ffffffff80794179>] _sinittext+0x179/0x17d


Bryce
