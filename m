Return-Path: <linux-kernel-owner+w=401wt.eu-S1750772AbXAFRdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbXAFRdU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXAFRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:33:20 -0500
Received: from mail.screens.ru ([213.234.233.54]:43652 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbXAFRdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:33:19 -0500
Date: Sat, 6 Jan 2007 20:34:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070106173416.GA3771@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106163851.GA13579@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06, Srivatsa Vaddagiri wrote:
>
> On Sat, Jan 06, 2007 at 07:30:35PM +0300, Oleg Nesterov wrote:
> > Stupid me. Thanks.
> > 
> > I'll try to do something else tomorrow. Do you see a simple soulution?
> 
> Sigh ..I dont see a simple solution, unless we have something like
> lock_cpu_hotplug() ..

I suspect this can't help either.

The problem is that flush_workqueue() may be called while cpu hotplug event
in progress and CPU_DEAD waits for kthread_stop(), so we have the same dead
lock if work->func() does flush_workqueue(). This means that Andrew's change
to use preempt_disable() is good and anyway needed.

I am starting to believe we need some more intrusive changes in workquue.c.

Oleg.

