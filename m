Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUCRNbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUCRNbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:31:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9137 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262618AbUCRNbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:31:10 -0500
Date: Thu, 18 Mar 2004 14:31:08 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318133108.GS22234@suse.de>
References: <20040318122831.GO22234@suse.de> <200403181325.i2IDP4N19962@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181325.i2IDP4N19962@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Peter T. Breuer wrote:
> "Also sprach Jens Axboe:"
> > > Good idea. rl is inviolate, but I set at least |=REQ_NOMERGE sometimes
> > > on flags. And I pass ioctl information in fake requests by setting
> > 
> > May I ask on what commands you set that bit?
> 
> I set it on requests I have gotten myself via blk_get_request(..., WRITE,
> GFP_ATOMIC) and which are destined to be passed onto the drivers request
> queue and treated by the request function. The request function will
> know what to do with them. The bit I mention below is also set on them:

Ok, sounds fine.

> > > the bit just beyond the edge of those currently used (__REQ_BITS) to
> > > indicate its an ioctl and treating it specially in end request. Maybe
> > > on error I forgot to remove the extra bit before doing put_blk_request
> > 
> > Ugh, that sounds like very bad practice... The 'standard' way of doing
> > something like that is to flag REQ_SPECIAL and put whatever structure
> > you want in ->special.
> 
> Hmm .. I though SPECIAL was "just" to ensure ordering of requests and
> I went to some lengths to ensure that if I receive a request then we
> start diverting incoming requests to an alternate queue until we have
> treated all the requests already on the device queue! Then we ack the
> special and pass the requests back from the alternate queue. You are
> telling me that I needn't have bothered since I'm the only one who
> could generate a special? Owww.

No, ->special is for the driver receiving the request, I don't know what
kind of bastard driver you are trying to create :-). If you pass it on,
you cannot use it.

But your code just using the after-last bit is still severly broken, you
must not play tricks like that.

Actually, sounds like you are attempting to create an io stack at the
wrong level. Why aren't you just hooking into ->make_request_fn()
instead? You are in for all sorts of pains doing what you describe
above.

-- 
Jens Axboe

