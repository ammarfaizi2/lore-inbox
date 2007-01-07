Return-Path: <linux-kernel-owner+w=401wt.eu-S932600AbXAGQn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAGQn7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbXAGQn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:43:59 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52081 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXAGQn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:43:58 -0500
Date: Sun, 7 Jan 2007 22:13:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107164344.GB6800@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru> <20070107142246.GA149@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107142246.GA149@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 05:22:46PM +0300, Oleg Nesterov wrote:
> On 01/07, Oleg Nesterov wrote:
> >
> > Thoughts?
> 
> How about:
> 
> 	CPU_DEAD does nothing. After __cpu_disable() cwq->thread runs on
> 	all CPUs and becomes idle when it flushes cwq->worklist: nobody
	^^^

all except dead cpus that is.

> 	will add work_struct on that list.

If CPU_DEAD does nothing, then the dead cpu's workqueue list may be
non-empty. How will it be flushed, given that no thread can run on the
dead cpu?

We could consider CPU_DEAD moving over work atleast (and not killing
worker threads also). In that case, cwq->thread can flush its work,
however it now requires serialization among worker threads, since more
than one worker thread can now be servicing the same CPU's workqueue
list (this will beat the very purpose of maintaining per-cpu threads to
avoid synchronization between them).

Finally, I am concerned about the (un)friendliness of this programming
model, where programmers are restricted in not having a stable access to
cpu_online_map at all -and- also requiring them to code in non-obvious
terms. Granted that writing hotplug-safe code is non-trivial, but the
absence of "safe access to online_map" will make it more complicated.

-- 
Regards,
vatsa
