Return-Path: <linux-kernel-owner+w=401wt.eu-S1751115AbXAIHBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXAIHBP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXAIHBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:01:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43958 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbXAIHBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:01:13 -0500
Date: Tue, 9 Jan 2007 07:56:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109065633.GB8115@elte.hu>
References: <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108212656.ca77a3ba.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > I would be happy to be corrected if the above impression of 
> > freeze_processes() is corrected ..
> 
> It could be that the freezer needs a bit of work for this application. 
> Obviously we're not interested in the handling of disk I/O, so we'd 
> really like to do a simple 
> try_to_freeze_tasks(FREEZER_USER_SPACE|FREEZER_KERNEL_THREADS), but 
> the code isn't set up to do that (it should be).  The other non-swsusp 
> callers probably want this change as well.  But that's all a minor 
> matter.

yes. The freezer does the fundamentally right thing: it stops all tasks 
in user-space or waits for them to return back to user-space to stop 
them there, or if it's a pure kernel-space task it waits until that 
kernel-space task voluntarily stop.

Once the system is in such a state, and all processing has been stopped, 
all of the kernel's data structures are completely 'unused', and we can:

- patch the kernel freely (kprobes)

- save+stop the kernel (sw-suspend) 

- remove a CPU (CPU hotplug and suspend)

- (We could also use this mechanism to live-migrate the kernel to 
   another system btw., possibly useful for containers)

- (We could also use this mechanism to create a live snapshot of a 
   running kernel, together with an LVM snapshot of filesystem state, 
   for possible restore point later on.)

It is a very powerful mechanism that has really nice properties - we 
should work on this one shared infrastructure instead of adding zillions 
of per-subsystem CPU hotplug locks.

	Ingo
