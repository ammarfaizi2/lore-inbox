Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129760AbRBUR3M>; Wed, 21 Feb 2001 12:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbRBUR2w>; Wed, 21 Feb 2001 12:28:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43016 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129759AbRBUR2l>;
	Wed, 21 Feb 2001 12:28:41 -0500
Date: Wed, 21 Feb 2001 18:27:43 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: plugging in 2.4. Does it work?
Message-ID: <20010221182743.W1447@suse.de>
In-Reply-To: <200102211536.f1LFaWZ03985@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102211536.f1LFaWZ03985@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Feb 21, 2001 at 04:36:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21 2001, Peter T. Breuer wrote:
> I'm particularly concerned about the error behaviour. How should I set
> up the end_request code in the case when the request is to be errored?
> Recall that my  end_request code is presently like this:
> 
>      io_spin_lock
>      while (end_that_request_first(req,!req->errors);
>      // one more time for luck
>      if (!end_that_request_first(req,!req->errors)
>         end_that_request_last(req);
>      io_spin_unlock
> 
> and I get the impression from other driver code snippets that a single
> end_that_request_first is enough, but looking at the implementation it
> can't be. It looks from ll_rw_blk that I should walk the bh chain just
> the same in the case of error, no?

The implementation in ll_rw_blk.c (and other places) assumes that
a failed request just means the first chunk and it then makes sense
to just end i/o on that buffer and resetup the request for the next
buffer. If you want to completely scrap the request on an error, then
you'll just have to do that manually (ie loop end_that_request_first
and end_that_request_last at the end).

void my_end_request(struct request *rq, int uptodate)
{
	while (end_that_request_first(rq, uptodate))
		;

	io_lock
	end_that_request_last(rq);
	io_unlock
}

And why you keep insisting on a duplicate end_that_request_first I don't
know?!

-- 
Jens Axboe

