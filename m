Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVAMLGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVAMLGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVAMLFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:05:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16331 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261597AbVAMLB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:01:28 -0500
Date: Thu, 13 Jan 2005 12:01:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] possible rq starvation on oom
Message-ID: <20050113110119.GM2815@suse.de>
References: <20050113092246.GJ2815@suse.de> <41E65133.6060107@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E65133.6060107@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >I stumbled across this the other day. The block layer only uses a single
> >memory pool for request allocation, so it's very possible for eg writes
> >to have allocated them all at any point in time. If that is the case and
> >the machine is low on memory, a reader attempting to allocate a request
> >and failing in blk_alloc_request() can get stuck for a long time since
> >no one is there to wake it up.
> >
> 
> Yeah, this would do it for sure. Nice work Jens.
> 
> Actually, this could block up requests indefinitely couldn't it?

Yes it would, there's no one to wake the reader up. So if you are
unlucky enough that no one else attempts to read from that queue, you
would be stuck forever.

> >The solution is either to add the extra mempool so both reads and writes
> >have one, or attempt to handle the situation. I chose the latter, to
> >save the extra memory required for the additional mempool with
> >BLKDEV_MIN_RQ statically allocated requests per-queue.
> >
> >If a read allocation fails and we have no readers in flight for this
> >queue, mark us rq-starved so that the next write being freed will wake
> >up the sleeping reader(s). Same situation would happen for writes as
> >well of course, it's just a lot more unlikely.
> >
> 
> I wonder... could you put failed, starved readers on the writer's
> waitqueue and vice versa? AFAIKS this would eliminate special casing
> in the fast paths, and also hopefully preserve process ordering.

That would work as well, indeed. You would move the special casing to
get_request_wait() and require an extra queue lock/unlock. Hmm. I think
the starved flag is more obviously correct and the cost is not really big
at all, it's just an unlikely check in the request freeing for the fast
case of not being oom. get_request_wait() is hit a lot more than the
additional __freed_request() would be.

-- 
Jens Axboe

