Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSGICbV>; Mon, 8 Jul 2002 22:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317293AbSGICbU>; Mon, 8 Jul 2002 22:31:20 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:36539 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S317287AbSGICbT>;
	Mon, 8 Jul 2002 22:31:19 -0400
Date: Mon, 8 Jul 2002 23:37:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020708233722.R1424@almesberger.net>
References: <20020702133658.I2295@almesberger.net> <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com> <20020704032929.N2295@almesberger.net> <20020708215011.A2592@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020708215011.A2592@arizona.localdomain>; from kevin@koconnor.net on Mon, Jul 08, 2002 at 09:50:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin O'Connor wrote:
> I think the above works, but the locking is a bit hairy.  How about the
> following.  (Taxonomy 3)

Looks like an efficient and almost correct implementation of this,
yes.

One bug: you should use yield() instead of schedule() (2.5) or do
	current->policy |= SCHED_YIELD;
before calling schedule (2.4). Or play it extra-safe and use a
traditional wait queue, even though this has more overhead.

> I get the feeling you already had something like this in mind, but your
> example above was rather complicated.  The latter implementation is just
> standard reference counting.

Yup, my example was simply an approximation of the current module
code, with the obvious races fixed.

> With a standard reference counting implementation I don't see any of these
> issues being a problem..

Amazing, isn't it ? :-)

> Did I miss something?

I see two possible reasons why somebody may not want this solution:

 - those wishing to squeeze the very last bit of performance out of
   this may find holding the spin lock during the call a better
   compromise than the reference counting
 - in some cases, there could be a lock that's being held by the
   caller of foo_deregister and that's also needed by
   bar_whatever_op. In this case, you have to drop the lock while
   waiting (or re-think the locking design).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
