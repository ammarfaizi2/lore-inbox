Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRDMVHR>; Fri, 13 Apr 2001 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDMVHH>; Fri, 13 Apr 2001 17:07:07 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:38062 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131820AbRDMVG4>; Fri, 13 Apr 2001 17:06:56 -0400
Message-ID: <3AD7696B.FB80F2B6@uow.edu.au>
Date: Fri, 13 Apr 2001 14:02:35 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pdoru@kappa.ro
CC: linux-kernel@vger.kernel.org, Mircea Damian <dmircea@kappa.ro>
Subject: Re: problem with the timers ?!? (was: No one wants to help me)
In-Reply-To: <20010413222334.B3758@linux.kappa.ro> <Pine.LNX.4.21.0104132243060.6025-100000@bigD.kappa.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doru Petrescu wrote:
> 
> also I don't understand how a race condition can occour since all
> functions that play with the lists has a spin_lock() arround them.
> Maybe is not someting wrong in the timers, maybe some other part of the
> kernel is doing the bad thing.

Yes.  All it takes is this:

handler(foo)
{
	stuff();
	mod_timer(&foo->timer, whenever);
}

mainline()
{
	del_timer(&foo->timer);
	kfree(foo);
}

If the handler and mainline run at the same time
we will add a timer which is in freed memory.  Later,
someone reuses that memory and changes it.  The timer
list is corrupted.

Problem is, it seems that your machine is using
IPV4, TCP, IDE, netfilter and nothing else.  Those
parts of the kernel don't have the above bug (well,
they didn't mid last year).

One really, really useful piece of information would
be the value of the `function' member of the corrupted
timer.  Your debug code prints this out.  Do you still
have the logs?

Was it ever non-zero?

If so, what function was it pointing at?

-
