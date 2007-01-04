Return-Path: <linux-kernel-owner+w=401wt.eu-S965068AbXADScE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbXADScE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbXADScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:32:04 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:42351 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965068AbXADScC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:32:02 -0500
Date: Thu, 4 Jan 2007 10:31:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-Id: <20070104103107.e33768d7.akpm@osdl.org>
In-Reply-To: <20070104180901.GA344@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru>
	<20061218162701.a3b5bfda.akpm@osdl.org>
	<20061219004319.GA821@tv-sign.ru>
	<20070104113214.GA30377@in.ibm.com>
	<20070104142936.GA179@tv-sign.ru>
	<20070104091850.c1feee76.akpm@osdl.org>
	<20070104180901.GA344@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 21:09:01 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > --- a/kernel/workqueue.c~flush_workqueue-use-preempt_disable-to-hold-off-cpu-hotplug
> > +++ a/kernel/workqueue.c
> > @@ -419,18 +419,22 @@ static void flush_cpu_workqueue(struct c
> >  		 * Probably keventd trying to flush its own queue. So simply run
> >  		 * it by hand rather than deadlocking.
> >  		 */
> > -		mutex_unlock(&workqueue_mutex);
> > +		preempt_enable();
> 
> Ah, (looking at _cpu_down()->stop_machine()), so preempt_disable() not only "pins"
> the current CPU, it blocks cpu_down(), yes ???

yep.

But before we do much more of this we should have a wrapper.  Umm

static inline void block_cpu_hotplug(void)
{
	preempt_disable();
}

and use that, so people can see why it's being used.

I spose I'll do that and convert this patch to use it.
