Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWHYGe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWHYGe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWHYGe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:34:58 -0400
Received: from brick.kernel.dk ([62.242.22.158]:16697 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964864AbWHYGe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:34:58 -0400
Date: Fri, 25 Aug 2006 08:37:24 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Neil Brown <neilb@suse.de>
Cc: David Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060825063723.GO24258@kernel.dk>
References: <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com> <17641.24478.496091.79901@cse.unsw.edu.au> <20060821135132.GG4290@suse.de> <17646.32332.572865.919526@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17646.32332.572865.919526@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2006, Neil Brown wrote:
> On Monday August 21, axboe@suse.de wrote:
> > 
> > But these numbers are in no way tied to the hardware. It may be totally
> > reasonable to have 3GiB of dirty data on one system, and it may be
> > totally unreasonable to have 96MiB of dirty data on another. I've always
> > thought that assuming any kind of reliable throttling at the queue level
> > is broken and that the vm should handle this completely.
> 
> I keep changing my mind about this.  Sometimes I see it that way,
> sometimes it seems very sensible for throttling to happen at the
> device queue.
> 
> Can I ask a question:  Why do we have a 'nr_requests' maximum?  Why
> not just allocate request structures whenever a request is made?
> If there some reason relating to making the block layer work more
> efficiently? or is it just because the VM requires it.

It's by and large because the vm requires it. Historically the limit was
there because the requests were statically allocated. Later the limit
help bound runtimes for the io scheduler, since the merge and sort
operations where O(N) each. Right now any of the io schedulers can
handle larger number of requests without breaking a sweat, but the vm
goes pretty nasty if you set (eg) 8192 requests as your limit.

The limit is also handy for avoiding filling memory with requests
structures. At some point here's little benefit to doing larger queues,
depending on the workload and hardware. 128 is usually a pretty fair
number, so...

> I'm beginning to think that the current scheme really works very well
> - except for a few 'bugs'(*).

It works ok, but it makes it hard to experiment with larger queue depths
when the vm falls apart :-). It's not a big deal, though, even if the
design isn't very nice - nr_requests is not a well defined entity. It
can be anywhere from 512b to megabyte(s) in size. So throttling on X
number of requests tends to be pretty vague and depends hugely on the
workload (random vs sequential IO).

-- 
Jens Axboe

