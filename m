Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267533AbSIRQp3>; Wed, 18 Sep 2002 12:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbSIRQp3>; Wed, 18 Sep 2002 12:45:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30358 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267533AbSIRQp2>;
	Wed, 18 Sep 2002 12:45:28 -0400
Date: Wed, 18 Sep 2002 18:57:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180915350.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181847070.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


current, existing real-life applications are past the 50 thousand kernel
threads requirement, and the only reason why we dont have >100K threads
applications here and now were limitations in the kernel. Right now we can
realistically scale to 500,000 threads even on IA32 systems - and there
are a number of applications for which this is a realistic model.

allocating past 32K consecutively allocated PIDs takes 32 seconds on a 500
MHz PII. Ie. 100K threads take more than 1.5 minutes to 'pass over' - even
if the pid_max got corrected to 10 million or whatever value, via the
duplication code. 1.5 minutes complete utter silence in the system, the
tasklist_lock taken. Any pending write_lock on the tasklist_lock causes
the NMI oopser to trigger. Interrupts are not serviced on that CPU. etc.

it's so bad and it's biting people that others have come up with ugly
solutions in the given PID allocation framework, check out:

	http://old.lwn.net/2002/0328/a/getpid.php3

runtime construction of a temporary PID allocation bitmap to get the PID
allocation latency under control. That patch alone is larger than my PID
allocator. Now wli has come up with a much nicer solution and has found a
way to get all PID-like allocations into a common hash [pending cleanups,
but the concept is sound IMHO], and this enabled a very fast and clean PID
allocator. And as a side-effect about 70% of all for_each_process() and
for_each_thread() loops in the kernel are reduced to a
for_each_list(session_list) type of well-behaving loop.

	Ingo

