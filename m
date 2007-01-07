Return-Path: <linux-kernel-owner+w=401wt.eu-S964781AbXAGRR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbXAGRR3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbXAGRR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:17:29 -0500
Received: from mail.screens.ru ([213.234.233.54]:35673 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932611AbXAGRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:17:28 -0500
Date: Sun, 7 Jan 2007 20:18:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107171826.GB238@tv-sign.ru>
References: <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru> <20070107142246.GA149@tv-sign.ru> <20070107164344.GB6800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107164344.GB6800@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Srivatsa Vaddagiri wrote:
>
> On Sun, Jan 07, 2007 at 05:22:46PM +0300, Oleg Nesterov wrote:
> > On 01/07, Oleg Nesterov wrote:
> > >
> > > Thoughts?
> > 
> > How about:
> > 
> > 	CPU_DEAD does nothing. After __cpu_disable() cwq->thread runs on
> > 	all CPUs and becomes idle when it flushes cwq->worklist: nobody
> 	^^^
> 
> all except dead cpus that is.

yes, of course.

> 
> > 	will add work_struct on that list.
> 
> If CPU_DEAD does nothing, then the dead cpu's workqueue list may be
> non-empty. How will it be flushed, given that no thread can run on the
> dead cpu?

But cwq->thread is not bound to the dead CPU at this point, it was aleady
migrated (like all other threads which had that CPU in ->cpus_allowed).

> Finally, I am concerned about the (un)friendliness of this programming
> model, where programmers are restricted in not having a stable access to
> cpu_online_map at all -and- also requiring them to code in non-obvious
> terms. Granted that writing hotplug-safe code is non-trivial, but the
> absence of "safe access to online_map" will make it more complicated.

I guess you misunderstood me, I meant CPU_DEAD does nothing only in
workqueue.c:workqueue_cpu_callback().

Oleg.

