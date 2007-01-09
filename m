Return-Path: <linux-kernel-owner+w=401wt.eu-S1750726AbXAIOjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXAIOjK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbXAIOjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:39:10 -0500
Received: from mail.screens.ru ([213.234.233.54]:58904 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbXAIOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:39:09 -0500
Date: Tue, 9 Jan 2007 17:38:23 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070109143823.GA89@tv-sign.ru>
References: <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107215103.GA7960@tv-sign.ru> <20070108152211.GA31263@in.ibm.com> <20070108155638.GA156@tv-sign.ru> <20070108163140.GC31263@in.ibm.com> <20070108170635.GA448@tv-sign.ru> <20070109043910.GB589@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109043910.GB589@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09, Srivatsa Vaddagiri wrote:
>
> On Mon, Jan 08, 2007 at 08:06:35PM +0300, Oleg Nesterov wrote:
> > Ah, missed you point, thanks. Yet another old problem which was not introduced
> > by recent changes. And yet another indication we should avoid kthread_stop()
> > on CPU_DEAD event :) I believe this is easy to fix, but need to think more.
> 
> I think the problem is not just with CPU_DEAD. Anyone who calls
> cleanup_workqueue_thread (say destroy_workqueue?) will see this race. 

destroy_workqueue() first does flush_workqueue(), so it should be ok.

Anyway I agree with you, we shouldn't clear cwq->thread until it exits,

> Do you see any problems if cleanup_workqueue_thread is changed as:
> 
> cleanup_workqueue_thread()
> {
> 	kthread_stop(p);
> 	spin_lock(cwq->lock);
> 	cwq->thread = NULL;
> 	spin_unlock(cwq->lock);
> }

I think the same. In fact I suspect we even don't need spin_lock, but didn't
have a time to read the code since our discussion.

Oleg.

