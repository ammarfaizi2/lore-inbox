Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278266AbRJSB53>; Thu, 18 Oct 2001 21:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278270AbRJSB5T>; Thu, 18 Oct 2001 21:57:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48398 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278266AbRJSB5B>; Thu, 18 Oct 2001 21:57:01 -0400
Date: Thu, 18 Oct 2001 18:56:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Cohen <robert.cohen@anu.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Misaligned write performance: was Re: [Bench] Fileserving
 performance problems
In-Reply-To: <3BCF851D.5080607@anu.edu.au>
Message-ID: <Pine.LNX.4.33.0110181850001.1489-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Oct 2001, Robert Cohen wrote:
>
> However, look what happens if I run 5 copies at once.
>
> writing to file of size 60  Megs with buffers of 5000 bytes
> writing to file of size 60  Megs with buffers of 5000 bytes
> writing to file of size 60  Megs with buffers of 5000 bytes
> writing to file of size 60  Megs with buffers of 5000 bytes
> writing to file of size 60  Megs with buffers of 5000 bytes
> write elapsed time=33.96 seconds, write_speed=1.77
> write elapsed time=37.43 seconds, write_speed=1.60
> write elapsed time=37.74 seconds, write_speed=1.59
> write elapsed time=37.93 seconds, write_speed=1.58
> write elapsed time=40.74 seconds, write_speed=1.47
> rewrite elapsed time=512.44 seconds, rewrite_speed=0.12
> rewrite elapsed time=518.59 seconds, rewrite_speed=0.12
> rewrite elapsed time=518.05 seconds, rewrite_speed=0.12
> rewrite elapsed time=518.96 seconds, rewrite_speed=0.12
> rewrite elapsed time=517.08 seconds, rewrite_speed=0.12
>
> Here we see a factor of about 15 between write speed and rewrite speed.
> That seems a little extreme.

The cumulative plain write speed (non-rewrite) doesn't change much,
because plain writes can be re-ordered and running five copies at once
isn't THAT big of a deal (ie still ends up seeking much more than just one
file would, but it's not catastrophic).

> >From the amount of seeking happening, I believe that all the reads are
> being done as single page separate reads. Surely there should be some
> readahead happening.

Well, we _could_ do read-ahead even for the read-modify-write, but the
fact is that it doesn't tend to be worth it for real-life loads.

That's because read-modify-write is _usually_ of the type where you lseek,
and modify a smallish thing in-place: anybody who cares about performance
and does consecutive modifications should have coalesced them anyway, so
only made-up benchmarks actually show the problem.

> I tested the same program under Solaris and I get about a factor of 2
> difference regardless whether its one copy or 5 copies.

I wouldn't be surprised if Solaris just always reads ahead. Most "big
iron" unixes try very very hard to make all IO in big chunks, whether it
is necessary or not.

> I believe that this is an odd situation and sure it only happens for
> badly written program. I can see that it would be stupid to optimise for
> this situation.
> But do we really need to do this badly for this case?

Well, if you find a real application that cares, I might change my mind,
but right now read-ahead looks like a waste of time to me.. Does anybody
really do re-write in practice?

(Yes, I know about databases, but they tend to want to be cached anyway,
and tend to do direct block IO, not sub-block read-modify-write).

		Linus

