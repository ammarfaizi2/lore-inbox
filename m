Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSGDGoJ>; Thu, 4 Jul 2002 02:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317346AbSGDGoI>; Thu, 4 Jul 2002 02:44:08 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:44267 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S317345AbSGDGoI>;
	Thu, 4 Jul 2002 02:44:08 -0400
Date: Thu, 4 Jul 2002 03:50:12 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020704035012.O2295@almesberger.net>
References: <20020702133658.I2295@almesberger.net> <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com> <20020704032929.N2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704032929.N2295@almesberger.net>; from wa@almesberger.net on Thu, Jul 04, 2002 at 03:29:29AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> This is correct if we can be sure that the use count never reaches
> 0 here, but then the whole inc/dec exercise is probably redundant.
> ("probably" as in "it doesn't have to be, but I'd be surprised if
> it isn't"; I'll give an example in a later posting.)

Okay, here's an almost correct example (except for the usual
return-after-removal, plus an unlikely data race described
below). foo_1 runs first:


foo_1(...)
{
    MOD_INC_USE_COUNT;
    ...
    initiate_asynchronous_execution_of(foo_2);
    rendezvous(foo_a);
        /* wait until foo_2 has incremented the use count */
    ...
    MOD_DEC_USE_COUNT;
    ...
    rendezvous(foo_b); /* release foo_2 */
    /* cool return-after-removal race */
}   

foo_2(...)
{
    MOD_INC_USE_COUNT;
    rendezvous(foo_a);
    rendezvous(foo_b);
    MOD_DEC_USE_COUNT;
}


(The pseudo-primitive redezvous(X) stops execution until all
"threads" have reached that point, then they all continue.)

I think the easiest solution is to simply declare such constructs
illegal.

Note that I'm using "return" loosely - whatever is used to implement
rendezvous() may execute instructions after unblocking, which would
race with removal too. Also note that in this case, we may, at least
theoretically, data race with removal if accessing foo_b after
unblocking foo_2.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
