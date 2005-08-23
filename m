Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVHWVc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVHWVc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHWVc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:32:28 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:23301 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932201AbVHWVc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:32:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LOgN0Qv99jJMrvEGXcmDkMLcDZVEmlUPBNDcejM/L6FIMt7+WVIYIzkK2iJse2zIY20vaTOzHaOuQ2t/E9ZWHzPV4w3kqfjA0BdwkSn2ru82stFERmnMUHwV4VMANtWnWIHuseEfNX4BQfH7BjZXf5jSnj7LQdP8etvW+g41lK8=
Message-ID: <9a8748490508231432750aa75d@mail.gmail.com>
Date: Tue, 23 Aug 2005 23:32:22 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430ACC5C.1060507@aitel.hist.no>
	 <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>If you have preemtion enabled you could
> > disable
> > >>it. Low latency comes
> > >>at the cost of decreased throughput - can't
> > >>have both. Also try using
> > >>a HZ of 100 if you are currently using 1000,
> > >>that should also improve
> > >>throughput a little at the cost of slightly
> > >>higher latencies.
> > >>
> > >>I doubt that it'll do any huge difference,
> > but
> > >>if it does, then that
> > >>would probably be valuable info.
> > >>
> > >>
> > >>
> > >Ok, well you'll have to explain this one:
> > >
> > >"Low latency comes at the cost of decreased
> > >throughput - can't have both"
> > >
> > >
> > Configuring "preempt" gives lower latency,
> > because then
> > almost anything can be interrupted (preempted).
> >  You can then
> > get very quick responses to some things, i.e.
> > interrupts and such.
> 
> I think part of the problem is the continued
> misuse of the word "latency". Latency, in
> language terms, means "unexplained delay". Its
> wrong here because for one, its explainable. But
> it also depends on your perspective. The
> "latency" is increased for kernel tasks, while it
> may be reduced for something that is getting the
> benefit of preempting the kernel. So you really
> can't say "the price of reduced latency is lower
> throughput", because thats simply backwards.
> You've increased the kernel tasks latency by
> allowing it to be pre-empted. Reduced latency
> implies higher efficiency. All you've done here
> is shift the latency from one task to another, so
> there is no reduction overall, in fact there is
> probably a marginal increase due to the overhead
> of pre-emption vs doing nothing.
> 


No.  That's simply not correct.

1. Preempt adds overhead in tracking when it's safe to preempt and
when it is not and overhead for checking if something needs to preempt
something else at various points.
 This means more bookkeeping, which means more work done by the kernel
and less work done on behalf of user processes == lower overall
throughput / bandwith [1].

2. Every time a process is preempted work has to be done to switch to
the new process, caches will be flushed/cold, stuff may have to paged
in/out, etc.
 This means more copying of process related data and more cache misses
== lower overall throughput.

But, generally the overhead associated with preemption is low, which
is also why I said in a previous email that on many systems you won't
even notice it.


But, this whole thing has gotten sidetracked into a discussion about;
is preempt good or bad, what does the word "latency" means exactely
(and I don't agree with your definition) [2].

When I originally suggested to you to try a non-preempt kernel (if
your current one is even using preempt, which you haven't told us) I
was simply trying to gather a datapoint.
Since preemption is a major thing that has changed from 2.4 to 2.6 and
since in some cases it *does* impact performance I thought it would be
a valid thing to eliminate it from the list of things that could be
causing your problem. I also believe I said that I didn't think it
would make a big difference, but that it /might/ and we might as well
see what difference it does make (if any).

So, if instead of arguing the exact meaning of a word, making
statements about you /assuming/ that HZ or PREEMPT won't affect
things, you had instead just *tested* it then we would have saved 2
days of arguing and getting nowhere and could instead have gotten that
little detail out of the way and then moved on to the next thing to
check.

When I made the suggestion I had hoped for a reply along the lines of this : 

I just tried a HZ=1000 + PREEMPT vs a HZ=100 + NO-PREEMPT kernel, and
the NO-PREEMPT kernel achieves x% higher throughput. We seem to have a
problem with PREEMPT.

or

Sorry Jesper, you were wrong, booting a kernel with HZ=100 and no
PREEMPT makes absolutely no difference to my network throughput, so
the bug must lie elsewhere.


If you'd done that (and what would it have taken? all of 30min perhaps
to build two kernels and test them), then everyone would have had a
valid piece of information and could have gone off looking for a
preempt related bug or put preempt out of their minds and gone hunting
for the bug somewhere else.
That was my intention with the original suggestion to test a no
preempt kernel, not to start arguing the merrits of preemption in
general or the exact meaning of the word "latency".

Finally, here's a little article you might like to read :
http://www.linuxdevices.com/articles/AT5152980814.html



[1] http://en.wikipedia.org/wiki/Comparison_of_latency_and_bandwidth
[2] http://en.wikipedia.org/wiki/Latency_%28engineering%29


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
