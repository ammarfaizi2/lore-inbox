Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVFJTtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFJTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFJTtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:49:25 -0400
Received: from amdext4.amd.com ([163.181.251.6]:60858 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S261193AbVFJTtM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:49:12 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
Date: Fri, 10 Jun 2005 14:48:58 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84301CFC134@SAUSEXMB1.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [OOPS] powernow on smp dual core amd64
Thread-Index: AcVt7P9dWtFZMGMUQZ2KKOOeG1aghgAB1wOQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Tom Duffy" <tduffy@sun.com>, "Andi Kleen" <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
X-WSS-ID: 6EB731212UO7030789-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the crash is caused by an invalid
pointer dereference in 
query_current_values_with_pending_wait(), which
implies that powernowk8_get() was called with an
invalid CPU number.

Andi, what will happen if you do
set_cpus_allowed(current, cpumask_of_cpu(cpu)) when
cpu isn't in the range of online CPUs?  There's
supposed to be a check to prevent an invalid
pointer access from happening but it's failing for 
some reason.

-Mark Langsdorf
AMD, Inc.

> -----Original Message-----
> From: Tom Duffy [mailto:tduffy@sun.com] 
> Sent: Friday, June 10, 2005 1:47 PM
> To: Andi Kleen
> Cc: discuss@x86-64.org; linux-kernel@vger.kernel.org
> Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
> 
> 
> On Fri, 2005-06-10 at 18:53 +0200, Andi Kleen wrote:
> > On Thu, Jun 09, 2005 at 04:46:19PM -0700, Tom Duffy wrote:
> > > Got this panic when I recently upgraded my BIOS so that 
> it supports 
> > > k8 powernow on SMP dual-core.
> > 
> > 2.6.12-rc has a dual core aware powernow k8 driver.
> 
> Despite the name of kernel, it is based off of 2.6.12-rc6.
> 
> Here is the panic on bootup.
> 
> Unable to handle kernel NULL pointer dereference at 
> 0000000000000024 RIP: 
> <ffffffff8011dadc>{query_current_values_with_pending_wait+60}
> PGD 3f255067 PUD 7fe7e067 PMD 0
> Oops: 0002 [1] SMP
> CPU 1
> Modules linked in: mptscsih(U) mptbase(U) sd_mod scsi_mod
> Pid: 33, comm: events/7 Not tainted 2.6.11-1.1381_FC5smp
> RIP: 0010:[<ffffffff8011dadc>]  sdb1 sdb2 
> <ffffffff8011dadc>{query_current_values_with_pending_wait+60}
> RSP: 0018:ffff81007fd9fdc8  EFLAGS: 00010202
> RAX: 000000000000000e RBX: 0000000000000000 RCX: 00000000c0010042
> RDX: 0000000000000008 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff81007fd9e000 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000080
> R13: 0000000000000000 R14: 0000000000000292 R15: ffffffff80112950
> FS:  00000000005a5858(0000) GS:ffffffff8050ec00(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000024 CR3: 000000007fd76000 CR4: 
> 00000000000006e0 Process events/7 (pid: 33, threadinfo 
> ffff81007fd9e000, task ffff81007fd43070)
> Stack: 0000000000000000 ffffffff8011e0b1 0000000000000001 
> ffff81007fa02d10
>        ffff81007fa02d40 ffffffff802e6f23 0000000000000000 
> 0000000000000003
>        0000000000000001 0000000000000020
> Call Trace:<ffffffff8011e0b1>{powernowk8_get+129} 
> <ffffffff802e6f23>{cpufreq_get+115}
>        <ffffffff8011298a>{handle_cpufreq_delayed_get+58} 
> <ffffffff8014b9dc>{worker_thread+476}
>        <ffffffff80134710>{default_wake_function+0} 
> <ffffffff801326a3>{__wake_up_common+67}
>        <ffffffff8014b800>{worker_thread+0} 
> <ffffffff80150469>{kthread+217}
>        <ffffffff80135c90>{schedule_tail+64} 
> <ffffffff8010f76b>{child_rip+8}
>        <ffffffff8011d680>{flat_send_IPI_mask+0} 
> <ffffffff80150390>{kthread+0}
>        <ffffffff8010f763>{child_rip+0}
> 
> Code: 89 47 24 89 57 20 31 c0 48 83 c4 08 c3 66 66 66 90 66 
> 66 90 RIP 
> <ffffffff8011dadc>{query_current_values_with_pending_wait+60} 
> RSP <ffff81007fd9fdc8>
> CR2: 0000000000000024
>  <3>Debug: sleeping function called from invalid context at 
> include/linux/rwsem.h:43 in_atomic():0, irqs_disabled():1
> 
> Call Trace:<ffffffff8013abc5>{profile_task_exit+21} 
> <ffffffff8013bfe2>{do_exit+34}
>        <ffffffff80267378>{do_unblank_screen+40} 
> <ffffffff80124286>{do_page_fault+1926}
>        <ffffffff8035c032>{thread_return+0} 
> <ffffffff8035c084>{thread_return+82}
>        <ffffffff8013433d>{activate_task+141} 
> <ffffffff80112950>{handle_cpufreq_delayed_get+0}
>        <ffffffff8010f5b5>{error_exit+0} 
> <ffffffff80112950>{handle_cpufreq_delayed_get+0}
>        <ffffffff8011dadc>{query_current_values_with_pending_wait+60}
>        <ffffffff8011e0b1>{powernowk8_get+129} 
> <ffffffff802e6f23>{cpufreq_get+115}
>        <ffffffff8011298a>{handle_cpufreq_delayed_get+58} 
> <ffffffff8014b9dc>{worker_thread+476}
>        <ffffffff80134710>{default_wake_function+0} 
> <ffffffff801326a3>{__wake_up_common+67}
>        <ffffffff8014b800>{worker_thread+0} 
> <ffffffff80150469>{kthread+217}
>        <ffffffff80135c90>{schedule_tail+64} 
> <ffffffff8010f76b>{child_rip+8}
>        <ffffffff8011d680>{flat_send_IPI_mask+0} 
> <ffffffff80150390>{kthread+0}
>        <ffffffff8010f763>{child_rip+0}
> 
> -tduffy
> 

