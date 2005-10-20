Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVJTNve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVJTNve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVJTNve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:51:34 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:48025 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751095AbVJTNvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:51:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gSelbYWdN+CLBXpyiRd9hB7pJgogm+1t8JRXssMnQJIHd2VBtm+HMPXX3TPf5XfM9NKkwvAgL8uzSt1Y829o2e1x9HaLouQ0eG/lQkxjeN9wi8TMmJ5uU4VkA3UKDtGsY0FgbDrxfSj9nlBTJ8fO/a0+GU3Gt6xwBOF0wkhV4LA=
Date: Thu, 20 Oct 2005 22:51:24 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 02/05] blk: update ioscheds to use generic dispatch queue
Message-ID: <20051020135124.GB26004@htj.dyndns.org>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.D377069C@htj.dyndns.org> <20051020112109.GC2811@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020112109.GC2811@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 01:21:09PM +0200, Jens Axboe wrote:
> On Wed, Oct 19 2005, Tejun Heo wrote:
> > 02_blk_generic-dispatch-queue-update-for-ioscheds.patch
> > 
> > 	This patch updates all four ioscheds to use generic dispatch
> > 	queue.  There's one behavior change in as-iosched.
> > 
> > 	* In as-iosched, when force dispatching
> > 	  (ELEVATOR_INSERT_BACK), batch_data_dir is reset to REQ_SYNC
> > 	  and changed_batch and new_batch are cleared to zero.  This
> > 	  prevernts AS from doing incorrect update_write_batch after
> > 	  the forced dispatched requests are finished.
> > 
> > 	* In cfq-iosched, cfqd->rq_in_driver currently counts the
> > 	  number of activated (removed) requests to determine
> > 	  whether queue-kicking is needed and cfq_max_depth has been
> > 	  reached.  With generic dispatch queue, I think counting
> > 	  the number of dispatched requests would be more appropriate.
> > 
> > 	* cfq_max_depth can be lowered to 1 again.
> 
> I applied this one as well, with some minor changes. The biggest one is
> a cleanup of the 'force' logic, it seems to be a little mixed up in this
> patch. You use it for forcing dispatch, which is fine. But then it also
> doubles as whether you want to sort insert on the generic queue or just
> add to the tail?

 When forced dispatch occurs, all requests in a elevator get dumped
into the dispatch queue.  Specific elevators are free to dump in any
order and it's likely that specific elevators don't dump in the
optimal order - e.g. for cfq, it will dump each cfqq's in order which
results in unnecessary seeks.  That's why all the current ioscheds
tells elv_dispatch_insert() to perform global dispatch queue sorting
when they dump requests due to force argument.  Maybe add comments to
explain this?

>   
> > -		if (cfq_class_idle(cfqq))
> > -			max_dispatch = 1;
> > +		if (force)
> > +			max_dispatch = INT_MAX;
> > +		else
> > +			max_dispatch =
> > +				cfq_class_idle(cfqq) ? 1 : cfqd->cfq_quantum;
> 
> Also, please don't use these ?: constructs, I absolutely hate them as
> they are weird to read.

 Hehheh, I actually like "?:"s, but I'll stay away from it.

 Thanks.

-- 
tejun
