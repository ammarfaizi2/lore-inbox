Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWJ3IU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWJ3IU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWJ3IU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:20:56 -0500
Received: from brick.kernel.dk ([62.242.22.158]:15878 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161191AbWJ3IU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:20:56 -0500
Date: Mon, 30 Oct 2006 09:22:33 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ravi Krishnamurthy <Ravi_Krishnamurthy@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Block driver freezes when using CFQ]
Message-ID: <20061030082233.GL4563@kernel.dk>
References: <454313C9.4010602@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454313C9.4010602@adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2006, Ravi Krishnamurthy wrote:
> Hi all,
> 
>    I have written a block driver that registers a virtual device and
> routes requests to appropriate real devices after some re-mapping of
> the requests. I am testing the driver by creating a filesystem on the
> virtual device and copying a large number of files on to it. The test
> causes the device to become unresponsive after some time. After some
> debugging, I noticed that this happens only if the I/O scheduler being
> used is CFQ. I have not had any trouble if the scheduler is noop,
> anticipatory or deadline. The problem occurs on all the kernels I have
> tested - 2.6.18-rc2, 2.6.18-rc4, 2.6.19-rc3.
> 
> Below are some details about the driver and what I have observed during
> testing:
> 
> The request function registered by my driver is a simple loop -
> 
>   while ((req = elv_next_request(q))) {
>         blkdev_dequeue_request(req);
> 
>         /*
>          Add request to an internal queue for further processing
>          Wake up thread to start processing the queue
>          Update some variables for book-keeping
>          */
>   }
> 
> Completed requests are handled in a different thread -
>   while (work to be done) {
>       /*
>         Dequeue completed requests from internal queue
>         Call end_that_request_first() and end_that_request_last()
>         Update some variables for book-keeping
>       */
>   }

The io scheduler is not obligated to recall your request handling
function, _unless_ you have no pending io at the point where
elv_next_request() returns NULL but there are things pending. IOW, when
you complete your requests you want to just recall your request handling
function. Just insert something ala:

        if (elv_next_request(q))
                q->request_fn(q);

when you are done completing requests.

Does that fix it?

-- 
Jens Axboe

