Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSAISUS>; Wed, 9 Jan 2002 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSAISUE>; Wed, 9 Jan 2002 13:20:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:48397 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288958AbSAISS7>; Wed, 9 Jan 2002 13:18:59 -0500
Date: Wed, 9 Jan 2002 10:24:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201090940490.1595-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Ingo Molnar wrote:

>
> On Tue, 8 Jan 2002, Davide Libenzi wrote:
>
> > Mike can you try the patch listed below on custom pre-10 ?
> > I've got 30-70% better performances with the chat_s/c test.
>
> i've compared this patch of yours (which changes the way interactivity is
> detected and timeslices are distributed), to 2.5.2-pre10-vanilla on a
> 2-way 466 MHz Celeron box:
>
> davide-patch-2.5.2-pre10 running at default priority:
>
>     # ./chat_s 127.0.0.1
>     # ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 123103 messages per second
>     Average throughput : 105122 messages per second
>     Average throughput : 112901 messages per second
>
>     [ system is *unusable* interactively, during the whole test. ]
>
> davide-patch-2.5.2-pre10 running at nice level 19:
>
>     # nice -n 19 ./chat_s 127.0.0.1
>     # nice -n 19 ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 109337 messages per second
>     Average throughput : 122077 messages per second
>     Average throughput : 105296 messages per second
>
>     [ system is *unusable* interactively, despite renicing. ]
>
> 2.5.2-pre10-vanilla running the test at the default priority level:
>
>     # ./chat_s 127.0.0.1
>     # ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 124676 messages per second
>     Average throughput : 102244 messages per second
>     Average throughput : 115841 messages per second
>
>     [ system is unresponsive at the start of the test, but
>       once the 2.5.2-pre10 load-estimator establishes which task is
>       interactive and which one is not, the system becomes usable.
>       Load can be felt and there are frequent delays in commands. ]
>
> 2.5.2-pre10-vanilla running at nice level 19:
>
>     # nice -n 19 ./chat_s 127.0.0.1
>     # nice -n 19 ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 214626 messages per second
>     Average throughput : 220876 messages per second
>     Average throughput : 225529 messages per second
>
>     [ system is usable from the beginning - nice levels are working as
>       expected. Load can be felt while executing shell commands, but the
>       system is usable. Load cannot be felt in truly interactive
>       applications like editors.
>
> Summary of throughput results: 2.5.2-pre10-vanilla is equivalent
> throughput-wise in the test with your patched kernel, but the vanilla
> kernel is about 100% faster than your patched kernel when running reniced.
>
> but the interactivity observations are the real showstoppers in my
> opinion. With your patch applied the system became *unbearably* slow
> during the test.

Ingo, this is not the picture that i've got from my machine.
-------------------------------------------------------------------
AMD Athlon 1GHz 256 Mb RAM, swap_cnt patch :

# nice -n 19 chat_s 127.0.0.1 &
# nice -n 19 chat_c 127.0.0.1 20 1000

125236
123988
128048

with :

r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
198  0  0   1476  28996   8024  89408   0   0     0   108  812 19424  12  87   1
216  0  1   1476  32388   8024  89412   0   0     0     0  523 56344   9  91   0
134  0  1   1476  32812   8024  89412   0   0     0     0  578 32374   9  91   0
96  1  1   1476  33540   8024  89412   0   0     0     0  114  7910  13  87   0
81  0  0   1476  35412   8024  89420   0   0     0    12  657 54034  12  88   0


pre-10 :

135684
127456
132420

the niced -20 vmstat has not been run for the whole test time and the
system seemed quite bad ( personal feeling, not for the whole test time
but for 1-2 sec spots ) compared with the previous test. The whole point
Ingo is that during the test we've had 200 tasks on the run queue with a
cs 8000..50000 !!?

AMD Athlon 1GHz, swap_cnt patch :

# chat_s 127.0.0.1 &
# chat_c 127.0.0.1 20 1000

118386
114464
117972


pre-10 :

90066
88234
92612

I was not able to identify any interactive feel difference here.
----------------------------------------------------------------------

Today i'll try the same on both my dual cpu system ( PIII 733 and PIII 1GHz )
I really fail to understand why you're asking everyone to run your test reniced ?!?



>  - your patch in essence makes the scheduler ignore things like nice
>    level +19. We *used to* ignore nice levels, but with the new load
>    estimator this has changed, and personally i dont think i want to go
>    back to the old behavior.

Ingo for the duration of the test the `nice -n 20 vmstat -n 1` never run
for about the 20 seconds.
With the swap_cnt correction it ran for 5-6 times.



>  - the system i tested has a more than twice as slow CPU as yours. So i'd
>    suggest for you to repeat those exact tests but increase the number of
>    'rooms' to something like 40 (i know you tried 20 rooms, i dont think
>    it's enough), and increase the number of messages sent, from 1000 to
>    5000 or something like that.

Ingo, with 20 rooms my system was loaded with more than 200 tasks on the
run queue and was switching at 50000 times/sec.
Don't you think that it's enough for a single cpu system ??!!



> your patch indeed decreases the load estimation and interactivity
> detection overhead and code complexity - but as the above tests have
> shown, at the price of interactivity, and in some cases even at the price
> of throughput.

Ingo i tried to be the more impartial as possible and during the test i
was not able to identify any difference in system usability.
As i wrote you in private, the only spot i've had of system unusability
was running with stock pre10 ( but this could be happened occasionally ).




- Davide





