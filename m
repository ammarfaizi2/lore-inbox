Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288384AbSAIJkl>; Wed, 9 Jan 2002 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJkd>; Wed, 9 Jan 2002 04:40:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9394 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288384AbSAIJkY>;
	Wed, 9 Jan 2002 04:40:24 -0500
Date: Wed, 9 Jan 2002 12:37:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jan 2002, Davide Libenzi wrote:

> Mike can you try the patch listed below on custom pre-10 ?
> I've got 30-70% better performances with the chat_s/c test.

i've compared this patch of yours (which changes the way interactivity is
detected and timeslices are distributed), to 2.5.2-pre10-vanilla on a
2-way 466 MHz Celeron box:

davide-patch-2.5.2-pre10 running at default priority:

    # ./chat_s 127.0.0.1
    # ./chat_c 127.0.0.1 10 1000

    Average throughput : 123103 messages per second
    Average throughput : 105122 messages per second
    Average throughput : 112901 messages per second

    [ system is *unusable* interactively, during the whole test. ]

davide-patch-2.5.2-pre10 running at nice level 19:

    # nice -n 19 ./chat_s 127.0.0.1
    # nice -n 19 ./chat_c 127.0.0.1 10 1000

    Average throughput : 109337 messages per second
    Average throughput : 122077 messages per second
    Average throughput : 105296 messages per second

    [ system is *unusable* interactively, despite renicing. ]

2.5.2-pre10-vanilla running the test at the default priority level:

    # ./chat_s 127.0.0.1
    # ./chat_c 127.0.0.1 10 1000

    Average throughput : 124676 messages per second
    Average throughput : 102244 messages per second
    Average throughput : 115841 messages per second

    [ system is unresponsive at the start of the test, but
      once the 2.5.2-pre10 load-estimator establishes which task is
      interactive and which one is not, the system becomes usable.
      Load can be felt and there are frequent delays in commands. ]

2.5.2-pre10-vanilla running at nice level 19:

    # nice -n 19 ./chat_s 127.0.0.1
    # nice -n 19 ./chat_c 127.0.0.1 10 1000

    Average throughput : 214626 messages per second
    Average throughput : 220876 messages per second
    Average throughput : 225529 messages per second

    [ system is usable from the beginning - nice levels are working as
      expected. Load can be felt while executing shell commands, but the
      system is usable. Load cannot be felt in truly interactive
      applications like editors.

Summary of throughput results: 2.5.2-pre10-vanilla is equivalent
throughput-wise in the test with your patched kernel, but the vanilla
kernel is about 100% faster than your patched kernel when running reniced.

but the interactivity observations are the real showstoppers in my
opinion. With your patch applied the system became *unbearably* slow
during the test.

i have three observation about why your patch causes these effects (we had
email discussions about this topic in private already, so you probably
know my position):

 - your patch adds the 'recalculation based priority distribution
   method' that is in 2.5.2-pre9 to the O(1) scheduler. (2.4.2-pre9's
   priority distribution scheme is an improved but conceptually
   equivalent version of the priority distribution scheme of 2.4.17 -
   which scheme was basically unchanged since 1991. )

   originally the O(1) patch was using the priority distribution scheme of
   2.5.2-pre9 (it's very easy to switch between the two methods), but i
   have changed it because:

   there is a flaw in the recalculation-based (array-switch based in O(1)
   scheduler terms) priority distribution scheme: interactive tasks will
   get new timeslices depending on the frequency of recalculations. But
   *exactly under load*, the frequency of recalculations gets very, very
   low - it can be more than 10 seconds. In the above test this property
   causes shell interactivity to degrade so dramatically. Interactive
   tasks might accumulate up to 64 timeslices, but it's easy for them to
   use up this reserve in such high load situations and they'll never get
   back any new timeslices. Mike, do you agree with this analysis? [if
   anyone wants to look at the new estimtaor code then please apply the
   -E1 patch to -pre10, which cleans up the estimator code and comments
   it, without changing functionality.]

 - your patch in essence makes the scheduler ignore things like nice
   level +19. We *used to* ignore nice levels, but with the new load
   estimator this has changed, and personally i dont think i want to go
   back to the old behavior.

 - the system i tested has a more than twice as slow CPU as yours. So i'd
   suggest for you to repeat those exact tests but increase the number of
   'rooms' to something like 40 (i know you tried 20 rooms, i dont think
   it's enough), and increase the number of messages sent, from 1000 to
   5000 or something like that.

your patch indeed decreases the load estimation and interactivity
detection overhead and code complexity - but as the above tests have
shown, at the price of interactivity, and in some cases even at the price
of throughput.

	Ingo

