Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUKJVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUKJVqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUKJVp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:45:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:16311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262122AbUKJVnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:43:53 -0500
Date: Wed, 10 Nov 2004 13:47:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: marcelo.tosatti@cyclades.com, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041110134753.4fc07d70.akpm@osdl.org>
In-Reply-To: <20041110212447.GB25410@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net>
	<20041104121722.GB8537@logos.cnet>
	<20041104181856.GE28163@zaphods.net>
	<20041109164113.GD7632@logos.cnet>
	<20041109223558.GR1309@mail.muni.cz>
	<20041109144607.2950a41a.akpm@osdl.org>
	<20041109224423.GC18366@mail.muni.cz>
	<20041109203348.GD8414@logos.cnet>
	<20041110203547.GA25410@mail.muni.cz>
	<20041110130943.32918c69.akpm@osdl.org>
	<20041110212447.GB25410@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> > I don't think there's really a bug here.  It's a tiny bit racy, but that
> > will merely cause a small inaccuracy in the stats.
> > 
> > I think I'll just drop the debug patch.  You can disable
> > CONFIG_DEBUG_PREEMPT to shut things up.
> 
> It did not help :( I had to disable CONFIG_PREEMPT to shut it up.
> 
> I had:
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_DEBUG_PREEMPT=y
> 
> It did what I wrote.
> Then I had:
> CONFIG_PREEMPT=y
> #CONFIG_PREEMPT_BKL=y
> #CONFIG_DEBUG_PREEMPT=y
> 
> and I had the same (or similar messages)

Confused.  Disabling CONFIG_DEBUG_PREEMPT should make those messages go
away.  lib/kernel_lock.c has:


#if defined(CONFIG_PREEMPT) && defined(__smp_processor_id) && \
		defined(CONFIG_DEBUG_PREEMPT)

/*
 * Debugging check.
 */
unsigned int smp_processor_id(void)
{
	...

	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
	dump_stack();

