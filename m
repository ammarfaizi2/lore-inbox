Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267993AbSIRRmc>; Wed, 18 Sep 2002 13:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbSIRRmc>; Wed, 18 Sep 2002 13:42:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:494 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267993AbSIRRmb>;
	Wed, 18 Sep 2002 13:42:31 -0400
Date: Wed, 18 Sep 2002 19:54:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209181026550.1230-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181939150.24891-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> ... the worst-case-behaviour is basically impossible to trigger with any 
> real load. 
> 
> The worst case does not happen for "100k threads" like you've made it 
> sound like.
> 
> The worst case happens for "100k threads consecutive in the pid space".

i always said consecutive PID range, in perhaps every previous mail.

consecutive PID allocation is actually something applications do pretty
often.

or Apache threads with the 'max requests handled per thread' config value
set to infinite, and a couple of thousand threads started up during init.

or a phone line server that handles 100 thousand phone lines starts up
100K threads, one per line. No need to restart any of those threads, and
in fact it will never happen. They do use helper threads to do less timing
critical stuff. Now the whole phone system locks up for 1.5 minutes every
2 weeks or 2 months when the PID range overflows, how great. Now make that
400 thousand phonelines, the lockup will will last 24 minutes.

well, by this argument, Windows XP only crashes every couple of weeks, it
happens rarely, who cares. Windows probably reboots faster than Linux will
allocate the next PID, so it has better RT latencies. Phone server
applications are inherently restartable anyway, even across hw crashes.

and of course any quasy-RT behavior of the Linux kernel (which we *do*
have in specific well-controlled scenarios) can be thrown out the window
if processes or threads are allocated/destroyed.

and even assuming that concecutive PIDs are a non-problem. Is fast PID
allocation really that bad? Is a more compressed PID range necesserily
bad? Is the avoidance of for_each_process and for_each_thread loops that
bad? Even the current untuned patch, which admittedly duplicates some
functionality (such as the pidhash), performs on par with the unpatched
kernel, in thread creation benchmarks. (which is pretty much the only
place that can show any increase in PID allocation/management overhead.)

	Ingo


