Return-Path: <linux-kernel-owner+w=401wt.eu-S932304AbXAOMyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbXAOMyv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXAOMyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:54:50 -0500
Received: from mail.screens.ru ([213.234.233.54]:60724 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbXAOMyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:54:50 -0500
Date: Mon, 15 Jan 2007 15:54:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070115125401.GA134@tv-sign.ru>
References: <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115043304.GA16435@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15, Srivatsa Vaddagiri wrote:
>
> On Mon, Jan 15, 2007 at 02:54:10AM +0300, Oleg Nesterov wrote:
> > How about the pseudo-code below?
> 
> Some quick comments:
> 
> - singlethread_cpu needs to be hotplug safe (broken currently)

Why? Could you explain?

> - Any reason why cpu_populated_map is not modified on CPU_DEAD?

Because CPU_DEAD/CPU_UP_CANCELED doesn't wait for cwq->thread to exit.
cpu_populated_map never shrinks, it only grows on CPU_UP_PREPARE.

We can change this, but it needs some more code, and I am not sure
we need it. Note that a "false" bit in cpu_populated_map only means
that flush_work/flush_workqueue/destroy_workqueu will do lock/unlock
of cwq->lock, nothing more.

> - I feel more comfortable if workqueue_cpu_callback were to take
>   workqueue_mutex in LOCK_ACQ and release it in LOCK_RELEASE
>   notifications.

The whole purpose of this change to avoid this!

	Gautham R Shenoy wrote:
	>
	> Oh! I was refering to the other set of workqueue deadlock woes. The
	> ones caused when subsystems (like cpufreq) try to create/destroy
	> workqueue from the cpuhotplug callback path.
	>
	> Creation/destruction of workqueue requires us to take workqueue_mutex,
	> which would have already been taken during CPU_LOCK_ACQUIRE.

With this change workqueue_mutex is only taken to protect workqueues
list, why should we hold it for (say) CPU_UP_PREPARE->CPU_ONLINE path?

>                   This will provide stable access to cpu_populated_map
>   to functions like __create_workqueue.

I think this is not needed.

> Finally, I wonder if these changes will be unnecessary if we move to
> process freezer based hotplug locking ...

This change ir not strictly necessary but imho make the code better and
shrinks .text by 379 bytes.

But I believe that freezer will change nothing for workqueue. We still
need take_over_work(), and hacks like migrate_sequence. And no, CPU_DEAD
can't just thaw cwq->thread which was bound to the dead CPU to complete
kthread_stop(), we should thaw all processes.

Oleg.

