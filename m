Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSAIOTI>; Wed, 9 Jan 2002 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSAIOS7>; Wed, 9 Jan 2002 09:18:59 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:1011 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S283204AbSAIOSu>; Wed, 9 Jan 2002 09:18:50 -0500
Message-ID: <000a01c19917$0b567ec0$0501a8c0@psuedogod>
From: "Ed Sweetman" <ed.sweetman@wmich.edu>
To: "Andrea Arcangeli" <andrea@suse.de>, "Robert Love" <rml@tech9.net>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>,
        "Anton Blanchard" <anton@samba.org>,
        "Luigi Genoni" <kernel@Expansa.sns.it>,
        "Dieter N?tzel" <Dieter.Nuetzel@hamburg.de>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>,
        "Rik van Riel" <riel@conectiva.com.br>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin> <20020108162930.E1894@inspiron.school.suse.de> <1010523340.3225.87.camel@phantasy> <20020109122418.F1543@inspiron.school.suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 09:07:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Andrea Arcangeli" <andrea@suse.de>
To: "Robert Love" <rml@tech9.net>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>; "Anton Blanchard"
<anton@samba.org>; "Luigi Genoni" <kernel@Expansa.sns.it>; "Dieter N?tzel"
<Dieter.Nuetzel@hamburg.de>; "Marcelo Tosatti" <marcelo@conectiva.com.br>;
"Rik van Riel" <riel@conectiva.com.br>; "Linux Kernel List"
<linux-kernel@vger.kernel.org>; "Andrew Morton" <akpm@zip.com.au>
Sent: Wednesday, January 09, 2002 6:24 AM
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable


> On Tue, Jan 08, 2002 at 03:55:38PM -0500, Robert Love wrote:
> > On Tue, 2002-01-08 at 10:29, Andrea Arcangeli wrote:
> >
> > > "extra schedule points all over the place", that's the -preempt kernel
> > > not the lowlatency kernel! (on yeah, you don't see them in the source
> > > but ask your CPU if it sees them)
> >
> > How so?  The branch on drop of the last lock?  It's not a factor in
>
> exactly, this is the reschedule point I meant. Oh note that it's
> unlikely also in the lowlatecy patch. Please count the number of time
> you add this branch in the -preempt, and how many times we add this
> branch in the lowlat and then tell me who is adding rescheduling points
> in the kernel all over the place.
>
> > This makes me think the end conclusion would be that preemptive
> > multitasking in general is bad.  Why don't we increase the timeslice and
> > and tick period, in that case?
>
> that would increase performance, but we'd lost interactivity.
>
> > One can argue the complexity degrades performance, but tests show
> > otherwise.  In throughput and latency.  Besides, like I always say, its
>
> which benchmarks? you should make sure the CPU spend all its cycles in
> the kernel to benchmark the perfrormance degradation (this is the normal
> case of webserving with a few gigabit ethernet cards using sendfile).
 I haven't seen any interactive tests that showed worse results than the
vanilla kernel with the preempt patch.  The only cases where it gives a
worse performance is in a single tasking environment such as running bonnie
or dbench and apps like that that require to throttle the system.  This is
obviously expected behavior though.  Performance degradation might be seen
on a per app basis, but when looking at the system as a whole, performance
has never degraded with the patch as far as i've seen.  Better overall
performance is what has lead to better "benchmark" performance on the tests
being run by people.


> > ride.  On the other hand, the patch has a _huge_ userbase and you can't
>
> I question this because it is too risky to apply. There is no way any
> distribution or production system could ever consider applying the
> preempt kernel and ship it in its next kernel update 2.4. You never know
> if a driver will deadlock because it is doing a test and set bit busy
> loop by hand instead of using spin_lock and you cannot audit all the
> device drivers out there. It is not like the VM that is self contained
> and that can be replaced without any caller noticing, this instead
> impacts every single driver out there and you'd need to audit all of
> them, which is not feasible I think and that should be done by giving
> everybody the time to test. This is also what makes preempt config
> option risky, if we go preempt we should force everybody to use it, at
> least during 2.5, so we get the useful feedback from testers of all the
> hardware, or nobody could trust -preempt.
 I disagree.   Redhat shipped gcc 2.96 when it was producing incompatible
binaries and was buggy as all hell, why not ship a kernel that is "unstable"
and "risky" if it promises better performance.
If scheduling points are ugly in 2.4, then they'd be ugly in 2.5.  The only
solution to the problem you see with it is making 2.5 fully preemptible from
the ground up instead of having to add fixes.  If nobody wants to do things
the hard way (assuming there is a better way), is it better to leave it
unfixed rather than fix it?  Of course i'm assuming that the idea of a fully
preemptible kernel is better than the current version we have now.


> NOTE: I trust your work with spinlocks, locks around per-cpu data
> structures etc.. is perfect, I trust that part, as said it's the driver
> doing test and set bit that you cannot audit that is the problem here
> and that makes it potentially unstable, not your changes.  And also the
> per-cpu data structures sounds a little risky (but for example for UP
> that's not an issue).
>
> > question that.  You also can't question the benchmarks that show
> > improvements in average _and_ worst case latency _and_ throughput.
>
> I don't question some benchmark is faster with -preempt, the interesting
> thing is to find why because it shouldn't be the case, Andrew for
> example mentioned software raid, there are good reasons for which
> -preempt could be faster there, so we added a single sechdule point and
> we just have that case covered in 18pre2aa1, we don't need reschedule
> points all over the place like in -preempt to cover things like that.
> It is good to find them out so we can fix those bugs, I consider them
> bugs :).

  I think robert love is trying to give the kernel the highest flexibility.
Making it flexible in key areas will improve your worst cases but a lot of
the time during normal use it's the multitude of smaller cases that is
noticeable.

> Again: I'm not completly against preempt, it can reach an mean latency
> much lower than mainline (it can reschedule immediatly in the middle of
> long copy-users for example), so it definitely has a value, it's just
> that I'm not sure if it worth it.
>
> Andrea


Ok so the medicine is worse than the disease.   I take it that you only want
some key points made for rescheduling instead of the full preempt patch by
Robert.   That seems logical enough.   The only issue i see is that for the
most part people dont like the idea of needing to add scheduling points.  So
how would the kernel need to be fixed in order to not need them and still be
fully preemptible like it's getting in Robert's patch.  If it just cant then
is it really best to hang out somewhere on the edge of preemptible
multitasking because some people are in denial that the kernel needs to be
patched so much to work correctly and for the sake of single tasking
performance?

Now in just my own opinion i think of linux as a multitasking kernel and as
thus it should perform that function as best as possible.  If you want to
run a single program as fast as possible then absolutely dont run anything
else and nothing can preempt it to degrade it's performance.   The fact that
you can run multiple apps and run a single program as fast as possible
without degrading it's performance  is a bug if those other apps (at the
same priority) have to wait longer than they should if we want linux to be a
multitasking kernel.  Just to sum things up, if there is a way to be fully
preemptible without scheduling points linux, then perhaps that should be a
major focus for 2.5 instead of picking and choosing (ugly)scheduling points,
but if not then the argument about them not being elegant is mute because
then the kernel, itself, is far from elegant already, so what exactly are
you saving?

- Formerly safemode

