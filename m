Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVAMTUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVAMTUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVAMTTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:19:41 -0500
Received: from mail.joq.us ([67.65.12.105]:45493 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261389AbVAMTQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:16:41 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050113063446.GV2940@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 13 Jan 2005 13:17:27 -0600
In-Reply-To: <20050113063446.GV2940@waste.org> (Matt Mackall's message of
 "Wed, 12 Jan 2005 22:34:46 -0800")
Message-ID: <87is61b0l4.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> If we can get high priority SCHED_OTHER working sufficiently well,
> that will be preferable in the long run as the security implications
> are slightly less dire. It's already been noted that it doesn't solve
> your privilege problem, but it's still interesting to us because it
> has potential to address the deadlock issue.

True.  

But there may be other, better solutions to the deadlock problem.
Several years ago, Roger Larsson wrote a completely user-space
realtime monitor program that works perfectly well for revoking
realtime privileges when it detects CPU starvation.  I still use it
occasionally to help debug problems if the built-in JACK watchdog
timer doesn't catch them.

In my view, Con Kolivas' SCHED_ISO prototype is a good avenue to
explore for mainstream kernel support.  With that approach, it is
relatively easy to build in protection against programs that abuse
their promised cycle reservations.  This appears to be similar to what
Apple is doing.

SCHED_OTHER is so timesharing oriented, that I seriously doubt its
appropriateness for soft realtime.  I say this naively without any
first-hand study of the current Linux implementation.  I do understand
traditional Unix schedulers (at one time in detail).  The general idea
was to punish CPU-bound processes and reward I/O-bound processes.

> Doesn't mean you have to use it (though you'll probably want to give
> your users the option).

We already do.  That's why I was able to experiment with nice --20 so
quickly.  In fact, SCHED_OTHER is the default.  Users have to specify
-R (--realtime) before JACK requests SCHED_FIFO privileges.

> On Wed, Jan 12, 2005 at 11:44:34PM -0600, Jack O'Quin wrote:
>> This whole approach seems like a "dry well" to me.
>
> It may turn out to be. Please continue testing it though - you've got
> a good test case handy.

Sure.

I didn't write that test script, BTW.  (I'd like to know who did.)
IIUC, it is one Lee Revell and Rui Nuno Capela have been using to test
Ingo's RP patches.  I got it from Rui.  I chose it because it was
handy and I figured Ingo would be familiar with its output.

We are considering including it (or some variant) in the JACK sources,
so any interested user can download JACK, configure, compile, and then
run `make test'.

It is a fairly heavy test.  The system takes an interrupt from the
audio card every 1.45 msec, then must schedule 22 realtime threads
belonging to 21 different processes (the JACK server and twenty
clients) before the next interrupt arrives.  An XRUN means the system
was late servicing the interrupt (very bad).  The "DSP load" indicates
that these threads are using a little over 1/3 of the total bandwidth
of my 1.5GHz Athlon XP.

>> Tomorrow, I'll try the test again after making a new kernel with
>> STARVATION_LIMIT set to zero.  
>> 
>> Anything else I should try?
>
> Testing feedback on the bits from Ingo that have gone to -mm will
> probably help speed their acceptance in mainline.

Several people continue working with him on that.  Lee and Rui have
been instrumental in testing with Ingo's kernels and in developing
JACK patches to gather needed information.  Much of their
instrumentation will be included in the next JACK release.

We are all highly motivated to help.  We want Linux to have the best
soft realtime possible, while working within the very real constraints
of what it is practical to do in a general-purpose OS.  

I hate for the OSX folks to do better.
-- 
  joq
