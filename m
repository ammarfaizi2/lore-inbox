Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265654AbSJSSqc>; Sat, 19 Oct 2002 14:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbSJSSqc>; Sat, 19 Oct 2002 14:46:32 -0400
Received: from cse.ogi.edu ([129.95.20.2]:22965 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265654AbSJSSqb>;
	Sat, 19 Oct 2002 14:46:31 -0400
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>
	<3DB0AD79.30401@netscape.com> <20021019065916.GB17553@mark.mielke.cc>
	<3DB19AE6.6020703@kegel.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 19 Oct 2002 11:52:28 -0700
In-Reply-To: <3DB19AE6.6020703@kegel.com>
Message-ID: <xu4u1jitg5v.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Kegel <dank@kegel.com> writes:

> The choice I see is between:
> 1. re-arming the one-shot notification when the user gets EAGAIN
> 2. re-arming the one-shot notification when the user reads all the data
>     that was waiting (such that the very next read would return EGAIN).

> #1 is what Davide wants; I think John and Mark are arguing for #2.

I thought the debate was over how the initial arming of the one-shot
was done.  

The choice above is a different issue.

Neither of 1 or 2 above accurately reflects what the code in the
kernel actually does.

Hitting EAGAIN does not "re-arm" the one-shot notification.  

Consider TCP.

The tcp write code issues a POLLOUT edge when the socket-buffer fill
level drops below a hi-water mark (tcp_min_write_space()). 

For reads, AFAIK, tcp issues POLLIN for every new TCP segment that
arrives, which get coalesced automatically by virtue of the getevents
barrier.

A short count means the appliation has hit an extreme end of the
buffer (completely full or empty).  EAGAIN means the buffer was
already at the extreme.  Either way you know just as well that new
activity will trigger a new edge event.

In summary, a short count is every bit as reliable as EAGAIN to know
that it is safe to wait on epoll_getevents.

Davide?

-- Buck

> I suspect that Davide would be happy with #2, but advises
> programmers to read until EGAIN anyway just to make things clear.

It's a minor point, but based on the logic above, I think this advise
is overkill.

-- Buck

> If the programmer is smart enough to figure out how to do that without
> hitting EAGAIN, that's fine.  Essentially, if he tries to get away
> without getting an EAGAIN, and his program stalls because he didn't
> read all the data that's available and thereby doesn't reset the
> one-shot readiness event, it's his own damn fault, and he should
> go back to using level-triggered techniques like classical poll()
> or blocking i/o.

> - Dan
