Return-Path: <linux-kernel-owner+w=401wt.eu-S1751249AbXAIJxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXAIJxR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXAIJxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:53:17 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54394 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbXAIJxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:53:16 -0500
Date: Tue, 9 Jan 2007 01:51:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-Id: <20070109015152.d5021254.akpm@osdl.org>
In-Reply-To: <20070109093302.GE589@in.ibm.com>
References: <20070106154506.GC24274@in.ibm.com>
	<20070106163035.GA2948@tv-sign.ru>
	<20070106163851.GA13579@in.ibm.com>
	<20070106111117.54bb2307.akpm@osdl.org>
	<20070107110013.GD13579@in.ibm.com>
	<20070107115957.6080aa08.akpm@osdl.org>
	<20070107210139.GA2332@tv-sign.ru>
	<20070108155428.d76f3b73.akpm@osdl.org>
	<20070109050417.GC589@in.ibm.com>
	<20070108212656.ca77a3ba.akpm@osdl.org>
	<20070109093302.GE589@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 15:03:02 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Mon, Jan 08, 2007 at 09:26:56PM -0800, Andrew Morton wrote:
> > That's not correct.  freeze_processes() will freeze *all* processes.
> 
> I am not arguing whether all processes will be frozen. However my question was 
> on the freeze point. Let me ask the question with an example:
> 
> rtasd thread (arch/powerpc/platforms/pseries/rtasd.c) executes this simple
> loop:
> 
> 
> static int rtasd(void *unused)
> {
> 
> 	i = first_cpu(cpu_online_map);
> 
> 	while (1) {
> 
> 		set_cpus_allowed(current, cpumask_of_cpu(i));	/* can block */
> 
> 		/* we should now be running on cpu i */
> 
> 		do_something_on_a_cpu(i);
> 		
> 		/* sleep for some time */
> 
> 		i = next_cpu(cpu, cpu_online_map);
> 	}
> 
> }
> 
> This thread makes absolutely -no- calls to try_to_freeze() in its lifetime.

Looks like a bug to me.  powerpc does appear to try to support the freezer.

> 1. Does this mean that the thread can't be frozen? (lets say that the
>    thread's PF_NOFREEZE is not set)

yup.  I'd expect the freeze_processes() call would fail if this thread is
running.

>    AFAICS it can still be frozen by sending it a signal and have the signal 
>    delivery code call try_to_freeze() ..

kernel threads don't take signals in the same manner as userspace.  A
kernel thread needs to explicitly poll, via

	if (signal_pending(current))
		do_something()

rtasd doesn't do that, and using signals in-kernel is considered lame.

> 2. If the thread can be frozen at any arbitrary point of its execution, then I 
>    dont see what prevents cpu_online_map from changing under the feet of rtasd 
>    thread, 

It cannot.
