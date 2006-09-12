Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWILWth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWILWth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWILWth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:49:37 -0400
Received: from brick.kernel.dk ([62.242.22.158]:6216 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932332AbWILWtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:49:35 -0400
Date: Wed, 13 Sep 2006 00:47:10 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/20] nbd: request_fn fixup
Message-ID: <20060912224710.GB23515@kernel.dk>
References: <20060912143049.278065000@chello.nl> <20060912144904.197253000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912144904.197253000@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12 2006, Peter Zijlstra wrote:
> @@ -463,10 +465,13 @@ static void do_nbd_request(request_queue
>  
>  error_out:
>  		req->errors++;
> -		spin_unlock(q->queue_lock);
> -		nbd_end_request(req);
> -		spin_lock(q->queue_lock);
> +		__nbd_end_request(req);
>  	}
> +	/*
> +	 * q->queue_lock has been dropped, this opens up a race
> +	 * plug the device to close it.
> +	 */
> +	blk_plug_device(q);
>  	return;
>  }

This looks wrong, I wonder if this only fixes things for you because it
happens to reinvoke the request handler after the timeout occurs? Your
comment doesn't really describe what you think is going on, please
describe in detail what you think is happening here that the plugging
supposedly solves.

Generally the block device rule is that once you are invoked due to an
unplug (or whatever) event, it is the responsibility of the block device
to run the queue until it's done. So if you bail out of queue handling
for whatever reason (might be resource starvation in hard- or software),
you must make sure to reenter queue handling since the device will not
get replugged while it has requests pending. Unless you run into some
software resource shortage, running of the queue is done
deterministically when you know resources are available (ie an io
completes). The device plugging itself is only ever done when you
encounter a shortage outside of your control (memory shortage, for
instance) _and_ you don't already have pending work where you can invoke
queueing from again.

-- 
Jens Axboe

