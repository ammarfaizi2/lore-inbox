Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129229AbRBUPhE>; Wed, 21 Feb 2001 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129342AbRBUPgy>; Wed, 21 Feb 2001 10:36:54 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:51721 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S129229AbRBUPgh>;
	Wed, 21 Feb 2001 10:36:37 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102211536.f1LFaWZ03985@oboe.it.uc3m.es>
Subject: Re: plugging in 2.4. Does it work? 
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Wed, 21 Feb 2001 16:36:32 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Jens Axboe wrote:"
> It will still cluster, the code above checks if the next bh is
> contigious -- if it isn't, then check if we can grow another segment.
> So you may be lucky that some buffer_heads in the chain are indeed
> contiguous, that's what the segment count is for. This is exactly
> the same in 2.4.

OK .. that fixed it. Turned out that I wasn't walking the request bh's
on read of clustered requests (but I was doing so on write).

Reads now work fine, but writes show signs of having some problem. I'll
beat on that later.

I'm particularly concerned about the error behaviour. How should I set
up the end_request code in the case when the request is to be errored?
Recall that my  end_request code is presently like this:

     io_spin_lock
     while (end_that_request_first(req,!req->errors);
     // one more time for luck
     if (!end_that_request_first(req,!req->errors)
        end_that_request_last(req);
     io_spin_unlock

and I get the impression from other driver code snippets that a single
end_that_request_first is enough, but looking at the implementation it
can't be. It looks from ll_rw_blk that I should walk the bh chain just
the same in the case of error, no?

Peter
