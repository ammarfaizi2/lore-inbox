Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTLWQFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLWQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:05:30 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49164 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261411AbTLWQCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:02:45 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: 23 Dec 2003 15:51:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bs9o97$dc3$1@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <3FE79C32.6050104@cyberone.com.au> <200312231342.56724.kernel@kolivas.org> <3FE7AF24.40600@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1072194663 13699 192.168.12.62 (23 Dec 2003 15:51:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FE7AF24.40600@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:
| 
| 
| Con Kolivas wrote:
| 
| >On Tue, 23 Dec 2003 12:36, Nick Piggin wrote:
| >
| >>Con Kolivas wrote:
| >>
| >>>I discussed this with Ingo and that's the sort of thing we thought of.
| >>>Perhaps a relative crossover of 10 dynamic priorities and an absolute
| >>>crossover of 5 static priorities before things got queued together. This
| >>>is really only required for the UP HT case.

There are two goals here. Not having a batch process on one siling makes
sense, and I'm going to try Con's patch after I try Nick's latest.
Actually, if they play nicely I would use both, batch would be very
useful for nightly report generation on servers.

But WRT the whole HT scheduling, it would seem that ideally you want to
schedule the two (or N) processes which have the lowest aggregate cache
thrash, if you had a way to determine that. I suspect that a process
which had a small itterative inner loop with a code+data footprint of
2-3k would coexist well with almost anything else. Minimizing the FPU
contention also would improve performance, no doubt. I don't know that
there are the tools at the moment to get this information, but it seems
as though until it's available any scheduling will be working in the
dark to some extent.

Feel free to tell me I misread this problem.

| >>>
| >>Well I guess it would still be nice for "SMP HT" as well. Hopefully the
| >>code can be generic enough that it would just carry over nicely. 
| >>
| >
| >I disagree. I can't think of a real world scenario where 2+ physical cpus 
| >would benefit from this.
| >
| 
| Well its the same problem. A nice -20 process can still lose 40-55% of its
| performance to a nice 19 process, a figure of 10% is probably too high and
| we'd really want it <= 5% like what happens with a single logical processor.
| 
| >
| >>It does 
| >>have complications though because the load balancer would have to be taught
| >>about it, and those architectures that do hardware priorities probably
| >>don't even want it.
| >>
| >
| >Probably the simple relative/absolute will have to suffice. However it still 
| >doesn't help the fact that running something cpu bound concurrently at nice 0 
| >with something interactive nice 0 is actually slower if you use a UP HT 
| >processor in SMP mode instead of UP.
| >
| 
| It will be based on dynamic priorities, possibly with some feedback from
| nice as well, but it probably still won't be perfect and it will probably
| be very complex *cough* hardware priorities *cough* ;)
| 
| I might try to fit it into a more general priority balancing system because
| we currently have similar sorts of failings on regular SMP as well.

I my experience, on servers it's more important to avoid really bad
behaviour all of the time than to have perfect behaviour most of the
time. All of the recent scheduler work from Nick, Con and Ingo has
avoided "jackpot cases" quite well, for which I thank you and encourage
you to continue. If server response goes from 20ms to 100ms Saturday
night, we discuss it at a status meeting Monday morning and make
suggestions to management. If response goes to 2sec we discuss it with
management at 2am and they make suggestions :-(

So far 2.6.0 has been quite good at "bend but do not break" under load.
Great job!
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
