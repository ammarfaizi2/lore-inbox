Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRLRCh0>; Mon, 17 Dec 2001 21:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLRChH>; Mon, 17 Dec 2001 21:37:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57095 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283714AbRLRChC>; Mon, 17 Dec 2001 21:37:02 -0500
Date: Mon, 17 Dec 2001 18:35:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33L.0112172353420.15741-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0112171825460.2108-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Rik van Riel wrote:
>
> Try readprofile some day, chances are schedule() is pretty
> near the top of the list.

Ehh.. Of course I do readprofile.

But did you ever compare readprofile output to _total_ cycles spent?

The fact is, it's not even noticeable under any normal loads, and
_definitely_ not on UP except with totally made up benchmarks that just
pass tokens around or yield all the time.

Because we spend 95-99% in user space or idle. Which is as it should be.
There are _very_ few loads that are kernel-intensive, and in fact the best
way to get high system times is to do either lots of fork/exec/wait with
everything cached, or do lots of open/read/write/close with everything
cached.

Of the remaining 1-5% of time, schedule() shows up as one fairly high
thing, but on most profiles I've seen of real work it shows up long after
things like "clear_page()" and "copy_page()".

And look closely at the profile, and you'll notice that it tends to be a
_loong_ tail of stuff.

Quite frankly, I'd be a _lot_ more interested in making the scheduling
slices _shorter_ during 2.5.x, and go to a 1kHz clock on x86 instead of a
100Hz one, _despite_ the fact that it will increase scheduling load even
more. Because it improves interactive feel, and sometimes even performance
(ie being able to sleep for shorter sequences of time allows some things
that want "almost realtime" behaviour to avoid busy-looping for those
short waits - improving performace exactly _because_ they put more load on
the scheduler).

The benchmark that is just about _the_ worst on the scheduler is actually
something like "lmbench", and if you look at profiles for that you'll
notice that system call entry and exit together with the read/write path
ends up being more of a performance issue.

And you know what? From a user standpoint, improving disk latency is again
a _lot_ more noticeable than scheduler overhead.

And even more important than performance is being able to read and write
to CD-RW disks without having to know about things like "ide-scsi" etc,
and do it sanely over different bus architectures etc.

The scheduler simply isn't that important.

			Linus

