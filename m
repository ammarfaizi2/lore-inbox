Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWIBTcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWIBTcn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWIBTcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:32:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751432AbWIBTcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:32:42 -0400
Date: Sat, 2 Sep 2006 12:32:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060902123229.f514c344.akpm@osdl.org>
In-Reply-To: <1157222493.29250.383.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
	<20060831204612.73ed7f33.akpm@osdl.org>
	<1157100979.29250.319.camel@localhost.localdomain>
	<20060901020404.c8038837.akpm@osdl.org>
	<1157103042.29250.337.camel@localhost.localdomain>
	<20060901201305.f01ec7d2.akpm@osdl.org>
	<1157222493.29250.383.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 20:41:33 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2006-09-01 at 20:13 -0700, Andrew Morton wrote:
> > > Fun, here is a version with a bigabyte blocker.
> > 
> > Your patch triggers waaaaaaay early.
> > 
> > netconsole: remote IP 192.168.2.33
> > netconsole: remote ethernet address 00:0d:56:c6:c6:cc
> > Initializing CPU#0
> > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
> > time.c: Detected 3400.238 MHz processor.
> > ktime_set: -1157140842 : 0
> 
> -------------^   !!!!!!!
> 
> > BUG: warning at include/linux/ktime.h:84/ktime_set()
> > 
> > Call Trace:
> >  <IRQ> [<ffffffff80247021>] hrtimer_run_queues+0x10e/0x211
> 
> This seems to happen inside hrtimer_get_softirq_time().
> wall_to_monotonic is negative.
> 
> Why does the check trigger ? We compare a "long", which contains a
> negative value against some positive constant. 
> 
> ktime_t ktime_set(const long secs, const unsigned long nsecs)
> {
> 	if (unlikely(secs >= KTIME_SEC_MAX)) {
> 
> where KTIME_SEC_MAX is 0x7FFFFFFFFFFFFFFF / 1000 000 000 = 
> 
> 9223372036 == 0x225C17D04,
> 
> which is compared against 
> 
> -1157140842 == 0xFFFFFFFFBB076E96
> 
> This smells like gcc magic. Can you please disassemble the code in
> question ?
> 

ktime_set:
.LFB522:
	.file 1 "kernel/hrtimer.c"
	.loc 1 884 0
.LVL0:
	pushq	%rbp	#
.LCFI0:
	movq	%rsp, %rbp	#,
.LCFI1:
.LBB2:
.LBB3:
.LBB4:
	.file 2 "include/asm/current.h"
	.loc 2 11 0
#APP
	movq %gs:0,%rax	#, t
.LVL1:
#NO_APP
.LBE4:
.LBE3:
.LBE2:
	.loc 1 888 0
	cmpq	$0, 208(%rax)	#, <variable>.mm
	je	.L2	#,
	movabsq	$9223372035, %rax	#, tmp66
.LVL2:
	cmpq	%rax, %rdi	# tmp66, secs
	jbe	.L2	#,
	.loc 1 889 0
	cmpl	$0, no88bigabytes.11819(%rip)	#, no88bigabytes
	jne	.L5	#,
	.loc 1 890 0
	movl	$1, no88bigabytes.11819(%rip)	#, no88bigabytes
	.loc 1 891 0
	movq	%rsi, %rdx	# nsecs, nsecs
	movq	%rdi, %rsi	# secs, secs


-- 
VGER BF report: H 0.000301227
