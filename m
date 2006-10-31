Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWJaHI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWJaHI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965551AbWJaHI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:08:59 -0500
Received: from brick.kernel.dk ([62.242.22.158]:16451 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965531AbWJaHI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:08:59 -0500
Date: Tue, 31 Oct 2006 08:10:40 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ravi Krishnamurthy <Ravi_Krishnamurthy@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block driver freezes when using CFQ
Message-ID: <20061031071040.GS14055@kernel.dk>
References: <454313C9.4010602@adaptec.com> <20061030082233.GL4563@kernel.dk> <4546D79E.40507@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546D79E.40507@adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Ravi Krishnamurthy wrote:
> Jens Axboe wrote:
> >On Sat, Oct 28 2006, Ravi Krishnamurthy wrote:
> >>Hi all,
> >>
> >>   I have written a block driver that registers a virtual device and
> >>routes requests to appropriate real devices after some re-mapping of
> >>the requests. I am testing the driver by creating a filesystem on the
> >>virtual device and copying a large number of files on to it. The test
> >>causes the device to become unresponsive after some time. After some
> >>debugging, I noticed that this happens only if the I/O scheduler being
> >>used is CFQ. I have not had any trouble if the scheduler is noop,
> >>anticipatory or deadline. The problem occurs on all the kernels I have
> >>tested - 2.6.18-rc2, 2.6.18-rc4, 2.6.19-rc3.
> >>
> 
> 
> >
> >The io scheduler is not obligated to recall your request handling
> >function, _unless_ you have no pending io at the point where
> >elv_next_request() returns NULL but there are things pending. 
> >IOW, when you complete your requests you want to just recall your request 
> >handling
> >function. Just insert something ala:
> >
> >        if (elv_next_request(q))
> >                q->request_fn(q);
> >
> >when you are done completing requests.
> >
> >Does that fix it?
> 
> I haven't had a chance to test this fix. A workaround I had tried was to
> insert these lines at the end of the request function:
>        if (! elv_queue_empty(q))
>             blk_plug_device(q);
> 
> This worked for me. So I assume the fix you have suggested will surely
> work.

You don't want to do that. It is the duty of the plugger to unplug the
device again, and in your case that is probably deferred to the timer
auto-unplug. So don't involve plugging, it's a seperate thing. Just
leave the request function when elv_next_request(), and always recall it
when you are done completing requests.

> I am curious to know why the problem does not occur when I am using the
> anticipatory scheduler. Also, in the suggested fix, is it guaranteed that
> elv_next_request() will not return NULL as long as the elevator queue is
> not empty?

Perhaps it recalls ->request_fn() more often than it should. If you call

-- 
Jens Axboe

