Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSIAWDy>; Sun, 1 Sep 2002 18:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIAWDy>; Sun, 1 Sep 2002 18:03:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:53512
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318132AbSIAWDx>; Sun, 1 Sep 2002 18:03:53 -0400
Subject: Re: question on spinlocks
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, Oliver Neukum <oliver@neukum.name>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 18:08:12 -0400
Message-Id: <1030918094.11553.3121.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 17:53, Thunder from the hill wrote:

> If it was his least problem! He'll run straight into a "schedule w/IRQs 
> disabled" bug.

No, the "schedule with irqs disabled" message is on involuntary
reschedule (e.g. kernel preemption) when interrupts are disabled.

It "safe" (maybe not sane) to call schedule() with interrupts disabled -
some system calls and scheduler code do it since interrupts will be
unconditionally enabled when rescheduled or upon returning to
user-space.  E.g., see sys_sched_yield().

The actual problem with the above is that when schedule() returns,
interrupts will be on and that is probably not the intention of the
author.  What Oliver probably wants to do is:

	spin_lock_irq(&lck);
	...
	spin_unlock(&lck);
	schedule();
	spin_lock_irq(&lck);
	...
	spin_unlock_irq(&lck);

The first unlock not having the irq-enable is an optimization as
described above.  Also note I did not use irqsave... if there is a
chance interrupts were previously disabled and you have who-knows-what
sort of call-chain behind you, it is probably not safe to go calling
schedule() and reenabling interrupts anyhow.

	Robert Love

