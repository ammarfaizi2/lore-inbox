Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWIBShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWIBShj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWIBShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:37:39 -0400
Received: from www.osadl.org ([213.239.205.134]:15334 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751266AbWIBShi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:37:38 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
In-Reply-To: <20060901201305.f01ec7d2.akpm@osdl.org>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060831204612.73ed7f33.akpm@osdl.org>
	 <1157100979.29250.319.camel@localhost.localdomain>
	 <20060901020404.c8038837.akpm@osdl.org>
	 <1157103042.29250.337.camel@localhost.localdomain>
	 <20060901201305.f01ec7d2.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 20:41:33 +0200
Message-Id: <1157222493.29250.383.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 20:13 -0700, Andrew Morton wrote:
> > Fun, here is a version with a bigabyte blocker.
> 
> Your patch triggers waaaaaaay early.
> 
> netconsole: remote IP 192.168.2.33
> netconsole: remote ethernet address 00:0d:56:c6:c6:cc
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
> time.c: Detected 3400.238 MHz processor.
> ktime_set: -1157140842 : 0

-------------^   !!!!!!!

> BUG: warning at include/linux/ktime.h:84/ktime_set()
> 
> Call Trace:
>  <IRQ> [<ffffffff80247021>] hrtimer_run_queues+0x10e/0x211

This seems to happen inside hrtimer_get_softirq_time().
wall_to_monotonic is negative.

Why does the check trigger ? We compare a "long", which contains a
negative value against some positive constant. 

ktime_t ktime_set(const long secs, const unsigned long nsecs)
{
	if (unlikely(secs >= KTIME_SEC_MAX)) {

where KTIME_SEC_MAX is 0x7FFFFFFFFFFFFFFF / 1000 000 000 = 

9223372036 == 0x225C17D04,

which is compared against 

-1157140842 == 0xFFFFFFFFBB076E96

This smells like gcc magic. Can you please disassemble the code in
question ?

> I wonder if this is related to the occasional hrtimr_run_queues() lockup
> which Andi is encountering.

Hmm, not sure.

	tglx



-- 
VGER BF report: H 1.60283e-12
