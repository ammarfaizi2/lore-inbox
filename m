Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265146AbUGIVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUGIVMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUGIVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:12:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:41690 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265146AbUGIVMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:12:12 -0400
Date: Fri, 9 Jul 2004 14:11:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040709141103.592c4655.akpm@osdl.org>
In-Reply-To: <20040709203852.GA1997@samarkand.rivenstone.net>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<20040709203852.GA1997@samarkand.rivenstone.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhf@rivenstone.net (Joseph Fannin) wrote:
>
> On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
> > +detect-too-early-schedule-attempts.patch
> > 
> >  Catch attempts to call the scheduler before it is ready to go.
> 
>     With this patch, my Powermac (ppc32) spews 711 (I think)
> warning messages during bootup.

hm, OK.  It could be that the debug patch is a bit too aggressive, or that
ppc got lucky and happens to always be in state TASK_RUNNING when these
calls to schedule() occur.

Maybe this task incorrectly has _TIF_NEED_RESCHED set?

Anyway, ppc guys: please take a look at the results from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken-out/detect-too-early-schedule-attempts.patch
and check that the kernel really should be calling schedule() at this time
and place, let us know?

Thanks.

>  The first one looks like:
> 
> Calibrating delay loop... 1064.96 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Badness in schedule at kernel/sched.c:2153
> Call trace:
>  [c00099e4] dump_stack+0x18/0x28
>  [c0006bac] check_bug_trap+0x84/0xac
>  [c0006d38] ProgramCheckException+0x164/0x1a4
>  [c0006240] ret_from_except_full+0x0/0x4c
>  [c02021bc] schedule+0x24/0x684
>  [c0005e80] syscall_exit_work+0x108/0x10c
>  [c02e0ad0] proc_root_init+0x14c/0x158
>  [00000000] 0x0
>  [c02ce5a0] start_kernel+0x158/0x184
>  [000035fc] 0x35fc
> 
> and this goes on until:
> 
> Badness in schedule at kernel/sched.c:2153
> Call trace:
>  [c00099e4] dump_stack+0x18/0x28
>  [c0006bac] check_bug_trap+0x84/0xac
>  [c0006d38] ProgramCheckException+0x164/0x1a4
>  [c0006240] ret_from_except_full+0x0/0x4c
>  [c02021bc] schedule+0x24/0x684
>  [c00062ec] resume_kernel+0x38/0x58
>  [c020249c] schedule+0x304/0x684
>  [c002c85c] worker_thread+0x258/0x27c
>  [c00317d0] kthread+0xb8/0xc0
>  [c0009128] kernel_thread+0x44/0x60
> adb devices: [2]: 2 2 [3]: 3 1
> ADB keyboard at 2, handler set to 3
> 
>     The full dmesg is 322K, and is up at:
> http://www.rivenstone.net/linux/samarkand.dmesg
> 
>     Most of the traces look something like the bottom one.
> 
> -- 
> Joseph Fannin
> jhf@rivenstone.net
> 
