Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUCRQQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUCRQQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:16:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45290 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262733AbUCRQQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:16:50 -0500
Date: Thu, 18 Mar 2004 17:16:48 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318161647.GT22234@suse.de>
References: <20040318133108.GS22234@suse.de> <200403181606.i2IG6Mu05640@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181606.i2IG6Mu05640@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Peter T. Breuer wrote:
> "Also sprach Jens Axboe:"
> > On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > > Hmm .. I though SPECIAL was "just" to ensure ordering of requests and
> > > I went to some lengths to ensure that if I receive a request then we
> > > start diverting incoming requests to an alternate queue until we have
> > > treated all the requests already on the device queue! Then we ack the
> > > special and pass the requests back from the alternate queue. You are
> > > telling me that I needn't have bothered since I'm the only one who
> > > could generate a special? Owww.
> > 
> > No, ->special is for the driver receiving the request,
> 
> I mean that I thought that if ->flags & REQ_SPECIAL were set, then
> we were obliged to flush the driver request queue before treating 
> this request, and I also thought that the driver was liable to receive
> such things from somewhere else.

I dunno where you get those crazy ideas, REQ_SPECIAL has absolutely
nothing to do with that.

> What I now suppose from your words above is that 
> 
>   a) ->flags & REQ_SPECIAL is something I can set all on my own.
>   b) if I do (or even if I don't?), the ->special field is mine to use?
>      (I am surprised since I dimly recall spotting it used for
>      something).

You may use REQ_SPECIAL bit as you see fit, and ->special as well. You
don't have to use them together, must do though. However, as I said
earlier, if you push these requests on to someone else request queue,
you must not fiddle with REQ_SPECIAL and/or ->special. In that case you
cannot touch/use more than what the block layer already does.

> > I don't know what
> > kind of bastard driver you are trying to create :-). If you pass it on,
> > you cannot use it.
> > 
> > But your code just using the after-last bit is still severly broken, you
> > must not play tricks like that.
> 
> It gets even worse, since I was using the very highest bits of ->flag
> for a sequence counter.  Very successfully, I may add.  Is there any

Oh god that's horrible.

> other place I can simply add to the request a counter for the number of
> (write) requests having gone through the driver?  The idea is that the
> driver is the only one who knows the real time order in which requests
> are received, so it must be the one to stamp them, and if somebody else
> wants to receive these and preserve order, this sequence number must be
> observed. But I didn't see anywhere to put them.
> 
> Are you going to say, set REQ_SPECIAL on everything and add all the
> real request info and a bit more to ->special? I suspect you are!

That's where to put it, indeed. But if you pass it on...

> > Actually, sounds like you are attempting to create an io stack at the
> > wrong level. Why aren't you just hooking into ->make_request_fn()
> 
> I don't quite understand. Using a different make_request_fn for these
> "special" requests is useful and indeed I do use one. But an "io
> stack"?

Sounds like you are acting as a middle man, hence an io stack. And the
place to do the stacking is at make_request_fn time, not at request_fn
time. If you happen to get it working, it'll be fragile at best.

> > instead? You are in for all sorts of pains doing what you describe
> > above.
> 
> Well, everything was working fine apart from death after revalidation!
> But I am attempting a rewrite now in accordance with what you say,
> which is why I am happy for elaboration/confirmation of (a-b) above.
> 
> I presume I can't get "special" requests off of anywhere but the READ
> and WRITE free lists via blk_get_request?  It would be easier to debug
> if there were a separate list.

SPECIAL isn't a request type, it's not anything actually (it's to use
for the driver for whatever he wants it to mean). But typically drivers
us it to indicate that they have attached a driver_rq structure to
->special.

-- 
Jens Axboe

