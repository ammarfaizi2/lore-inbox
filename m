Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbSIRRMd>; Wed, 18 Sep 2002 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbSIRRMd>; Wed, 18 Sep 2002 13:12:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22937 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267500AbSIRRMb>;
	Wed, 18 Sep 2002 13:12:31 -0400
Date: Wed, 18 Sep 2002 19:24:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180950010.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181902000.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> And guys, if this is a performance problem for some extreme site, the
> fix is truly trivial:
> 
> 	echo $((0x7fffffff)) > /proc/sys/max_pid
> 
> and you're done.

it is a problem still. We can create/destroy 2 billion threads:

   venus:~> ./p3 -s 2000000 -t 10 -r 0 -T --sync-join
   Runtime: 19.889182138 seconds

in roughly 5 hours, on bog-standard 2-CPU x86 hardware. Or in 1.25 hours
on an 8-way box. And then we are back to step #1: trying to pass over
already allocated PIDs by destroying the contents of the L1 and L2 cache
once for each allocated PID passed. Sure, with 2 billion PIDs space that
averages out, but it's an algorithm with a very nasty worst-case behavior,
which is not so hard to trigger.

Plus the not-so-unlikely case of having to pass a couple of tens of
thousands of allocated PIDs, in a couple of minutes, with all user input
blocked, and interrupts disabled, website silent. Obviously sites will not
create threads at such a high rate as demonstrated above, so it will
'only' happen once every couple of days, or every couple of weeks.

	Ingo

