Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRLRDRK>; Mon, 17 Dec 2001 22:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283720AbRLRDRB>; Mon, 17 Dec 2001 22:17:01 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:36053 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S282918AbRLRDQu>; Mon, 17 Dec 2001 22:16:50 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 17 Dec 2001 18:51:15 -0800 (PST)
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112171825460.2108-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112171846590.18021-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one problem the current scheduler has on SMP machines (even 2 CPU ones) is
that if the system is running one big process it will bounce from CPU to
CPU and actually finish considerably slower then if you are running two
CPU intensive tasks (with less cpu hopping). I saw this a few months ago
as I was doing something as simple as gunzip on a large file, I got a 30%
speed increase by running setiathome at the same time.

I'm not trying to say that it should be the top priority, but there are
definante weaknesses showing in the current implementation.

David Lang


 On Mon, 17 Dec 2001, Linus Torvalds wrote:

> Date: Mon, 17 Dec 2001 18:35:54 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: Rik van Riel <riel@conectiva.com.br>
> Cc: Davide Libenzi <davidel@xmailserver.org>,
>      Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Scheduler ( was: Just a second ) ...
>
>
> On Mon, 17 Dec 2001, Rik van Riel wrote:
> >
> > Try readprofile some day, chances are schedule() is pretty
> > near the top of the list.
>
> Ehh.. Of course I do readprofile.
>
> But did you ever compare readprofile output to _total_ cycles spent?
>
> The fact is, it's not even noticeable under any normal loads, and
> _definitely_ not on UP except with totally made up benchmarks that just
> pass tokens around or yield all the time.
>
> Because we spend 95-99% in user space or idle. Which is as it should be.
> There are _very_ few loads that are kernel-intensive, and in fact the best
> way to get high system times is to do either lots of fork/exec/wait with
> everything cached, or do lots of open/read/write/close with everything
> cached.
>
> Of the remaining 1-5% of time, schedule() shows up as one fairly high
> thing, but on most profiles I've seen of real work it shows up long after
> things like "clear_page()" and "copy_page()".
>
> And look closely at the profile, and you'll notice that it tends to be a
> _loong_ tail of stuff.
>
> Quite frankly, I'd be a _lot_ more interested in making the scheduling
> slices _shorter_ during 2.5.x, and go to a 1kHz clock on x86 instead of a
> 100Hz one, _despite_ the fact that it will increase scheduling load even
> more. Because it improves interactive feel, and sometimes even performance
> (ie being able to sleep for shorter sequences of time allows some things
> that want "almost realtime" behaviour to avoid busy-looping for those
> short waits - improving performace exactly _because_ they put more load on
> the scheduler).
>
> The benchmark that is just about _the_ worst on the scheduler is actually
> something like "lmbench", and if you look at profiles for that you'll
> notice that system call entry and exit together with the read/write path
> ends up being more of a performance issue.
>
> And you know what? From a user standpoint, improving disk latency is again
> a _lot_ more noticeable than scheduler overhead.
>
> And even more important than performance is being able to read and write
> to CD-RW disks without having to know about things like "ide-scsi" etc,
> and do it sanely over different bus architectures etc.
>
> The scheduler simply isn't that important.
>
> 			Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
