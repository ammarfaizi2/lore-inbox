Return-Path: <linux-kernel-owner+w=401wt.eu-S1751057AbXAIFaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbXAIFaL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbXAIFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:30:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42471 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbXAIFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:30:09 -0500
Date: Mon, 8 Jan 2007 21:26:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-Id: <20070108212656.ca77a3ba.akpm@osdl.org>
In-Reply-To: <20070109050417.GC589@in.ibm.com>
References: <20070104091850.c1feee76.akpm@osdl.org>
	<20070106151036.GA951@tv-sign.ru>
	<20070106154506.GC24274@in.ibm.com>
	<20070106163035.GA2948@tv-sign.ru>
	<20070106163851.GA13579@in.ibm.com>
	<20070106111117.54bb2307.akpm@osdl.org>
	<20070107110013.GD13579@in.ibm.com>
	<20070107115957.6080aa08.akpm@osdl.org>
	<20070107210139.GA2332@tv-sign.ru>
	<20070108155428.d76f3b73.akpm@osdl.org>
	<20070109050417.GC589@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 10:34:17 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Mon, Jan 08, 2007 at 03:54:28PM -0800, Andrew Morton wrote:
> > Furthermore I don't know which of these need to be tossed overboard if/when
> > we get around to using the task freezer for CPU hotplug synchronisation.
> > Hopefully, a lot of them.  I don't really understand why we're continuing
> > to struggle with the existing approach before that question is settled.
> 
> Good point!
> 
> Fundamentally, I think we need to answer this question:
> 
> "Do we provide *some* mechanism to block concurrent hotplug operations
> from happening? By hotplug operations I mean both changes to the bitmap
> and execution of all baclbacks in CPU_DEAD/ONLINE etc"
> 
> If NO, then IMHO we will be forever fixing races
> 
> If YES, then what is that mechanism? freeze_processes()? or a magical
> lock?
> 
> freeze_processes() cant be that mechanism, if my understanding of it is
> correct - see http://lkml.org/lkml/2007/1/8/149

That's not correct.  freeze_processes() will freeze *all* processes.  All
of them are forced to enter refrigerator().  With the mysterious exception
of some I/O-related kernel threads, which might need some thought.

> and 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116817460726058.

Am not sure how that's related.

> I would be happy to be corrected if the above impression of
> freeze_processes() is corrected ..

It could be that the freezer needs a bit of work for this application. 
Obviously we're not interested in the handling of disk I/O, so we'd really
like to do a simple
try_to_freeze_tasks(FREEZER_USER_SPACE|FREEZER_KERNEL_THREADS), but the
code isn't set up to do that (it should be).  The other non-swsusp callers
probably want this change as well.  But that's all a minor matter.

