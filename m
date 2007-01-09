Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbXAIPIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbXAIPIq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXAIPIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:08:46 -0500
Received: from mail.screens.ru ([213.234.233.54]:53865 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbXAIPIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:08:45 -0500
Date: Tue, 9 Jan 2007 18:07:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109150755.GB89@tv-sign.ru>
References: <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108212656.ca77a3ba.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Andrew Morton wrote:
>
> That's not correct.  freeze_processes() will freeze *all* processes.  All
> of them are forced to enter refrigerator().  With the mysterious exception
> of some I/O-related kernel threads, which might need some thought.

Yes, and we can remove a dead CPU safely, this part is ok.

> > and 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116817460726058.
> 
> Am not sure how that's related.

but at some point we should thaw processes, including cwq->thread which
should die. So we are doing things like take_over_work() and this is the
source of races, because the dead CPU is not on cpu_online_map.

flush_workqueue() doesn't use any locks now. If we use freezer to implement
cpu-hotplug nothing will change, we still have races.

It looks so obvious to me, so I'm starting to suspect I missed something
very simple :(

Oleg.

