Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVJTMYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJTMYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 08:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVJTMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 08:24:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22357 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751142AbVJTMYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 08:24:18 -0400
Date: Thu, 20 Oct 2005 14:25:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master] blk: reimplement elevator switch
Message-ID: <20051020122505.GG2811@suse.de>
References: <20051019123648.GA31257@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019123648.GA31257@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19 2005, Tejun Heo wrote:
>  Hello, Jens.
> 
>  This patch reimplements elevator switch.  This patch assumes generic
> dispatch queue patchset is applied.
> 
>  * Each request is tagged with REQ_ELVPRIV flag if it has its elevator
>    private data set.
>  * Requests which doesn't have REQ_ELVPRIV flag set never enter
>    iosched.  They are always directly back inserted to dispatch queue.
>    Of course, elevator_put_req_fn is called only for requests which
>    have its REQ_ELVPRIV set.
>  * Request queue maintains the current number of requests which have
>    its elevator data set (elevator_set_req_fn called) in
>    q->rq->elvpriv.
>  * If a request queue has QUEUE_FLAG_BYPASS set, elevator private data
>    is not allocated for new requests.
> 
>  To switch to another iosched, we set QUEUE_FLAG_BYPASS and wait until
> elvpriv goes to zero; then, we attach the new iosched and clears
> QUEUE_FLAG_BYPASS.  New implementation is much simpler and main code
> paths are less cluttered, IMHO.

Wonderful! Applied as-is, I didn't make any changes to this one. I agree
it's much cleaner than the previous approach, both in the code and in
killing the request_queue and request_list members.

I'm going to make a little few tweaks:

- The naming, QUEUE_FLAG_BYPASS isn't really clear. I don't know what
  this means without looking at specific parts of the code. Testing of
  same flag in various locations would also be preferred instead of
  passing priv around and cluttering the function parameters, however we
  should split the queue flags a little for this. Basically into an
  atomic and non-atomic part. So I'll leave that alone for now.

- The msleep(100) seems a little too slow. With the switching being more
  efficient now, in 100msecs we can complete lots of requests.

-- 
Jens Axboe

