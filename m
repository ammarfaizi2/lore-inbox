Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUCRQG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUCRQG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:06:29 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:1704 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S262730AbUCRQGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:06:25 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403181606.i2IG6Mu05640@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318133108.GS22234@suse.de> from Jens Axboe at "Mar 18, 2004
 02:31:08 pm"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 17:06:22 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Jens Axboe:"
> On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > Hmm .. I though SPECIAL was "just" to ensure ordering of requests and
> > I went to some lengths to ensure that if I receive a request then we
> > start diverting incoming requests to an alternate queue until we have
> > treated all the requests already on the device queue! Then we ack the
> > special and pass the requests back from the alternate queue. You are
> > telling me that I needn't have bothered since I'm the only one who
> > could generate a special? Owww.
> 
> No, ->special is for the driver receiving the request,

I mean that I thought that if ->flags & REQ_SPECIAL were set, then
we were obliged to flush the driver request queue before treating 
this request, and I also thought that the driver was liable to receive
such things from somewhere else.

What I now suppose from your words above is that 

  a) ->flags & REQ_SPECIAL is something I can set all on my own.
  b) if I do (or even if I don't?), the ->special field is mine to use?
     (I am surprised since I dimly recall spotting it used for
     something).

:).

> I don't know what
> kind of bastard driver you are trying to create :-). If you pass it on,
> you cannot use it.
> 
> But your code just using the after-last bit is still severly broken, you
> must not play tricks like that.

It gets even worse, since I was using the very highest bits of ->flag
for a sequence counter.  Very successfully, I may add.  Is there any
other place I can simply add to the request a counter for the number of
(write) requests having gone through the driver?  The idea is that the
driver is the only one who knows the real time order in which requests
are received, so it must be the one to stamp them, and if somebody else
wants to receive these and preserve order, this sequence number must be
observed. But I didn't see anywhere to put them.

Are you going to say, set REQ_SPECIAL on everything and add all the
real request info and a bit more to ->special? I suspect you are!
 
> Actually, sounds like you are attempting to create an io stack at the
> wrong level. Why aren't you just hooking into ->make_request_fn()

I don't quite understand. Using a different make_request_fn for these
"special" requests is useful and indeed I do use one. But an "io
stack"?

> instead? You are in for all sorts of pains doing what you describe
> above.

Well, everything was working fine apart from death after revalidation!
But I am attempting a rewrite now in accordance with what you say,
which is why I am happy for elaboration/confirmation of (a-b) above.

I presume I can't get "special" requests off of anywhere but the READ
and WRITE free lists via blk_get_request?  It would be easier to debug
if there were a separate list.


Peter
