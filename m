Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSKGUhh>; Thu, 7 Nov 2002 15:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSKGUhh>; Thu, 7 Nov 2002 15:37:37 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:30726 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261574AbSKGUhe>;
	Thu, 7 Nov 2002 15:37:34 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211072042.gA7KglX121245@saturn.cs.uml.edu>
Subject: Re: ps performance sucks
To: davidsen@tmr.com (Bill Davidsen)
Date: Thu, 7 Nov 2002 15:42:46 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, jw@pegasys.ws, wa@almesberger.net,
       andersen@codepoet.org, woofwoof@hathway.com
In-Reply-To: <Pine.LNX.3.96.1021107120208.30525E-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Nov 07, 2002 12:19:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen writes:
> On Tue, 5 Nov 2002, Albert D. Cahalan wrote:

>>> Strace it - IIRC it does 5 opens per PID. Vomit.
>>
>> Nope, it does 2. Perhaps you're not running procps 3 yet?
>> http://procps.sf.net/
>>
>> Of course if you do something like "ps ev" you need all 5.
>
>   Well, since you're doing all this stuff to push your version, how about
> an option to do a fast ps for most processes and only do the hard work for
> processes owned by a given user. Or not owned, so everything not root
> would be shown in detail, as an example. What about showing or not
> threads, or showing minimal detail (fast) for threads.
>
>   There is a lot of room for options if you want to see everything but
> only detail for some.

Would people use it? I risk burying users in options.
The closest things to this that I've considered are:

1. select every process that I can signal (including by TTY)
2. expand the selection with all ancestor processes up to init
3. expand the selection with all descendant processes

As for threads, support will come when the kernel makes it work
sanely. Right now I could make ps crudely guess what is a thread
and what is not, but that is slow and it suffers from both false
positives and false negatives. I'd be in business if the kernel
would do the following:

1. group related (same memory context) tasks in the /proc output
2. supply a "more tasks follow" flag
3. supply a way to identify a task's primary memory context

Note that #3 has to be immune to UML, Wine, and Bochs playing
tricks with segment registers and alternate memory contexts.

>   I wish competing procps could be merged, I feel as though it's something
> not requiring the time of top kernel developers. If you are willing to add
> features suggested by others and they are willing to push a feature list
> to you maybe that could happen.

I have difficulty understanding why somebody would want to start
hacking on code that hasn't been maintained for ages. I'm certainly
not about to throw away years worth of bug fixes. I suspect there was
a failure to realize how much Craig and I had done over the years.
Then Jim Warner (new top author) and I (ps, skill, snice, half of
libproc, and now much of free and vmstat) were blown off for reasons
I can't figure. In spite of this, I would gladly consider patches
from Rik van Riel and Robert M. Love, neither of which had even
touched the procps source code until just recently. I try to keep
this civil while making it clear who has the continuously maintained
source tree with original authors still actively participating.

Oh well.

Are you a vmstat user? Suggestions are needed; it's getting a rewrite.
I may even change the default format, assuming people don't all
have scripts that parse the output. How do you like this?

procs ------------memory----------- ---swap-- ----io--- --system-- ----cpu----
 r  b swpd free buff cache act !act   si   so   bi   bo   in    cs us sy id wa
 0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0   33     4  0  0 90  9
 0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0  114    12  1  0 88 11
 0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0  104     6  0  1 91  8

Let me know if any of that is junk, or if there is something you'd add.
Adding stuff means removing stuff, since blowing past 80 columns ins't
OK for most users. For ideas, see: /proc/vmstat, /proc/meminfo, /proc/stat

In case you happen to know where they are, I'm looking for these:

pages reclaimed
minor faults
COW faults
zero-page faults
anticipated short-term memory shortfall
pages freed
pages scanned by page-replacement algorithm
clock cycles by page replacement algorithm
number of system calls
number of forks (fork, vfork, & clone) and execs

This would be easy if every OS used the same terminology,
had the same stats, and had proper documentation.
