Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWI1Vv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWI1Vv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWI1Vv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:51:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161009AbWI1VvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:51:25 -0400
Date: Thu, 28 Sep 2006 14:51:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] -git8,9:  NULL pointer dereference in
 mptspi_dv_renegotiate_work
Message-Id: <20060928145121.561f077d.akpm@osdl.org>
In-Reply-To: <20060928202548.GO12968@osdl.org>
References: <20060928202548.GO12968@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc's added)

On Thu, 28 Sep 2006 13:25:48 -0700
Bryce Harrington <bryce@osdl.org> wrote:

> Apologies if this has already been reported;

It has not.

>  I didn't spot it on the
> list.  We've noticed an Oops on AMD64 when running linux-2.6.18-git8 and
> -git9, but not -git7:
> 
>  mptbase: Initiating ioc0 recovery
>  Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP: 
>   [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
>  PGD 0 
>  Oops: 0000 [1] PREEMPT SMP 
>  CPU 0 
>  Modules linked in:
>  Pid: 8, comm: events/0 Not tainted 2.6.18-git8 #1
>  RIP: 0010:[<ffffffff80489aa2>]  [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
>  RSP: 0000:ffff81003ec65e40  EFLAGS: 00010282
>  RAX: 0000000000000002 RBX: ffff81003e86f640 RCX: 000000000000001e
>  RDX: 0000000000000001 RSI: 0000000000000213 RDI: 000000000003e86f
>  RBP: 0000000000000500 R08: ffff81003ec64000 R09: ffff81003ed0cf40
>  R10: ffff81003e86f640 R11: ffff81003ed0cf40 R12: ffff81003ed0cf40
>  R13: 0000000000000213 R14: ffff81003e86f640 R15: ffffffff80489a96
>  FS:  0000000000000000(0000) GS:ffffffff80779000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>  CR2: 0000000000000500 CR3: 0000000000201000 CR4: 00000000000006e0
>  Process events/0 (pid: 8, threadinfo ffff81003ec64000, task ffff81007f180740)
>  Stack:  ffff81003ec65ef8 ffff81003e86f640 ffff81003e86f648 ffffffff8023f1bd
>   ffff81003ed0cf40 ffff81003ed0cf40 ffffffff8023f204 ffff8100016dfd70
>   00000000fffffffc ffffffff80593ffd 0000000000000000 ffffffff8023f300
>  Call Trace:
>   [<ffffffff8023f1bd>] run_workqueue+0x9a/0xe1
>   [<ffffffff8023f204>] worker_thread+0x0/0x12e
>   [<ffffffff8023f300>] worker_thread+0xfc/0x12e
>   [<ffffffff80229f62>] default_wake_function+0x0/0xe
>   [<ffffffff80229f62>] default_wake_function+0x0/0xe
>   [<ffffffff80242433>] kthread+0xc8/0xf1
>   [<ffffffff8020a3f8>] child_rip+0xa/0x12
>   [<ffffffff8024236b>] kthread+0x0/0xf1
>   [<ffffffff8020a3ee>] child_rip+0x0/0x12
>  
>  
>  Code: 48 8b 45 00 31 f6 48 8b b8 50 01 00 00 e8 5c 4d fe ff 48 85 
>  RIP  [<ffffffff80489aa2>] mptspi_dv_renegotiate_work+0xc/0x45
>   RSP <ffff81003ec65e40>
>  CR2: 0000000000000500
>   <6>mptbase: Initiating ioc0 recovery

That's very clever.  With gcc-4.0.2 and your .config I get

(gdb) x/20i mptspi_dv_renegotiate_work
0xffffffff8048475e <mptspi_dv_renegotiate_work>:        push   %rbp
0xffffffff8048475f <mptspi_dv_renegotiate_work+1>:      push   %rbx
0xffffffff80484760 <mptspi_dv_renegotiate_work+2>:      push   %rbp
0xffffffff80484761 <mptspi_dv_renegotiate_work+3>:      mov    0x60(%rdi),%rbp
0xffffffff80484765 <mptspi_dv_renegotiate_work+7>:      callq  0xffffffff8026df58 <kfree>
0xffffffff8048476a <mptspi_dv_renegotiate_work+12>:     mov    0x0(%rbp),%rax
0xffffffff8048476e <mptspi_dv_renegotiate_work+16>:     xor    %esi,%esi
0xffffffff80484770 <mptspi_dv_renegotiate_work+18>:     mov    0x150(%rax),%rdi

So on entry to this function, wqw->hd is 0x500.

Or kfree() somehow scrogged your %rbp register.


> Full console logs showing the above oops are here:
> -git7:   ok   http://crucible.osdl.org/runs/2223/sysinfo/amd01.console
> -git8:  Oops  http://crucible.osdl.org/runs/2233/sysinfo/amd01.console
> -git9:  Oops  http://crucible.osdl.org/runs/2241/sysinfo/amd01.console
> 
> Reference information about the machine this is run on:
>     http://crucible.osdl.org/runs/2223/sysinfo/amd01.1/
> 
> Config files:
> -git7:  http://crucible.osdl.org/runs/2223/sysinfo/amd01.config
> -git8:  http://crucible.osdl.org/runs/2233/sysinfo/amd01.config

> ...

> Just checked against latest -git10, same oops:
> 
>    http://crucible.osdl.org/runs/2256/sysinfo/amd01.console
> 
> However, it is not occurring on our ita64, x86, or x86_64 systems
> running the same kernels.
> 

I'd be suspecting a miscompile, or something horrid in kfree().

Does it change anything if you move that kfree() down a bit?

--- a/drivers/message/fusion/mptspi.c~a
+++ a/drivers/message/fusion/mptspi.c
@@ -790,10 +790,9 @@ mptspi_dv_renegotiate_work(void *data)
 	struct _MPT_SCSI_HOST *hd = wqw->hd;
 	struct scsi_device *sdev;
 
-	kfree(wqw);
-
 	shost_for_each_device(sdev, hd->ioc->sh)
 		mptspi_dv_device(hd, sdev);
+	kfree(wqw);
 }
 
 static void
_

