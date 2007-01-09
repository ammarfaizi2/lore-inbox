Return-Path: <linux-kernel-owner+w=401wt.eu-S932220AbXAIQiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbXAIQiz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbXAIQiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:38:55 -0500
Received: from mail.screens.ru ([213.234.233.54]:52375 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932220AbXAIQiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:38:54 -0500
Date: Tue, 9 Jan 2007 19:38:15 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109163815.GA208@tv-sign.ru>
References: <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109155908.GD22080@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09, Srivatsa Vaddagiri wrote:
>
> On Tue, Jan 09, 2007 at 06:07:55PM +0300, Oleg Nesterov wrote:
> > but at some point we should thaw processes, including cwq->thread which
> > should die.
> 
> I am presuming we will thaw processes after all CPU_DEAD handlers have
> run.
> 
> > So we are doing things like take_over_work() and this is the
> > source of races, because the dead CPU is not on cpu_online_map.
> >
> > flush_workqueue() doesn't use any locks now. If we use freezer to implement
> > cpu-hotplug nothing will change, we still have races.
> 
> We have races -if- CPU_DEAD handling can run concurrently with a ongoing
> flush_workqueue. From my recent understanding of process freezer, this
> is not possible. In other words, flush_workqueue() can be its old
> implementation as below w/o any races:
> 
> 	some_thread:
> 
> 	for_each_online_cpu(i)
> 		flush_cpu_workqueue(i);
> 
> As long as this loop is running, cpu_down/up will not proceed. This means, 
> cpu_online_map is stable even if flush_cpu_workqueue blocks ..
> 
> Once this loop is complete and all threads have called try_to_freeze,
> cpu_down will proceed to change the bit map and run CPU_DEAD handlers
> of everyone. I am presuimg we will thaw processes only after all
> CPU_DEAD/ONLINE handlers have run.

We can't do this. We should thaw cwq->thread (which was bound to the
dead CPU) to complete CPU_DEAD event. So we still need some changes.

Oleg.

