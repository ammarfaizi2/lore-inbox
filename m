Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVJTNyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVJTNyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVJTNyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:54:51 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:45554 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751165AbVJTNyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:54:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WZn9uWvMhlIUSgwgEoQRcnjOWq79qtTXIEEH2vaXKADXnIHZfH2gavhw5pxzICmavRT+9RRUOv0AzI0H/ZhQE2gxxHtaPAS2SMQnQU822rPh9WhKKUDOpjr/M6B/yepHoALKV389KH8mND7P58AKpG5QXe3xJYWvc7QH+7F2hPk=
Date: Thu, 20 Oct 2005 22:54:43 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master] blk: reimplement elevator switch
Message-ID: <20051020135443.GC26004@htj.dyndns.org>
References: <20051019123648.GA31257@htj.dyndns.org> <20051020122505.GG2811@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020122505.GG2811@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 02:25:05PM +0200, Jens Axboe wrote:
> On Wed, Oct 19 2005, Tejun Heo wrote:
> >  Hello, Jens.
> > 
> >  This patch reimplements elevator switch.  This patch assumes generic
> > dispatch queue patchset is applied.
> > 
> >  * Each request is tagged with REQ_ELVPRIV flag if it has its elevator
> >    private data set.
> >  * Requests which doesn't have REQ_ELVPRIV flag set never enter
> >    iosched.  They are always directly back inserted to dispatch queue.
> >    Of course, elevator_put_req_fn is called only for requests which
> >    have its REQ_ELVPRIV set.
> >  * Request queue maintains the current number of requests which have
> >    its elevator data set (elevator_set_req_fn called) in
> >    q->rq->elvpriv.
> >  * If a request queue has QUEUE_FLAG_BYPASS set, elevator private data
> >    is not allocated for new requests.
> > 
> >  To switch to another iosched, we set QUEUE_FLAG_BYPASS and wait until
> > elvpriv goes to zero; then, we attach the new iosched and clears
> > QUEUE_FLAG_BYPASS.  New implementation is much simpler and main code
> > paths are less cluttered, IMHO.
> 
> Wonderful! Applied as-is, I didn't make any changes to this one. I agree
> it's much cleaner than the previous approach, both in the code and in
> killing the request_queue and request_list members.
> 
> I'm going to make a little few tweaks:
> 
> - The naming, QUEUE_FLAG_BYPASS isn't really clear. I don't know what
>   this means without looking at specific parts of the code. Testing of

 It means to bypass ioscheds and go directly into dispatch queue.

>   same flag in various locations would also be preferred instead of
>   passing priv around and cluttering the function parameters, however we
>   should split the queue flags a little for this. Basically into an
>   atomic and non-atomic part. So I'll leave that alone for now.

 Hmmm...

> - The msleep(100) seems a little too slow. With the switching being more
>   efficient now, in 100msecs we can complete lots of requests.

 Yeap, agreed.

-- 
tejun
