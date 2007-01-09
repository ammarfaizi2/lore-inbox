Return-Path: <linux-kernel-owner+w=401wt.eu-S1751235AbXAIJdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbXAIJdW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXAIJdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:33:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:57941 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbXAIJdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:33:21 -0500
Date: Tue, 9 Jan 2007 15:03:02 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109093302.GE589@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108212656.ca77a3ba.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 09:26:56PM -0800, Andrew Morton wrote:
> That's not correct.  freeze_processes() will freeze *all* processes.

I am not arguing whether all processes will be frozen. However my question was 
on the freeze point. Let me ask the question with an example:

rtasd thread (arch/powerpc/platforms/pseries/rtasd.c) executes this simple
loop:


static int rtasd(void *unused)
{

	i = first_cpu(cpu_online_map);

	while (1) {

		set_cpus_allowed(current, cpumask_of_cpu(i));	/* can block */

		/* we should now be running on cpu i */

		do_something_on_a_cpu(i);
		
		/* sleep for some time */

		i = next_cpu(cpu, cpu_online_map);
	}

}

This thread makes absolutely -no- calls to try_to_freeze() in its lifetime.

1. Does this mean that the thread can't be frozen? (lets say that the
   thread's PF_NOFREEZE is not set)

   AFAICS it can still be frozen by sending it a signal and have the signal 
   delivery code call try_to_freeze() ..

2. If the thread can be frozen at any arbitrary point of its execution, then I 
   dont see what prevents cpu_online_map from changing under the feet of rtasd 
   thread, 
 
    In other words, we would have failed to provide the ability to *block* 
    hotplug operations from happening concurrently.

>  All of them are forced to enter refrigerator(). 
	           ^^^^^^

*forced*, yes ..that's the point of concern ..


Warm regards,
vatsa
