Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUHBAqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUHBAqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUHBAqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:46:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27339 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266210AbUHBApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:45:53 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
In-Reply-To: <1091403477.862.4.camel@mindpipe>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe>  <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
	 <1091403477.862.4.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091407585.862.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 20:46:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 19:37, Lee Revell wrote:
> On Sun, 2004-08-01 at 07:28, Ingo Molnar wrote:
> > could you try to repeat the '50 usecs' test with -L2 [that was the one you
> > used?] to make sure it's repeatable?
> 
> Results with L2, soundcard + RTC interrupts 'direct', N=1,000,000:
> 
> Delay   Count
> -----   -----
> 6       24330
> 7       429668
> 8       34474
> 9       26184
> 10      12210
> 11      9060
> 12      9104
> 13      8460
> 14      11011
> 15      13615
> 16      14584
> 17      13371
> 18      12169
> 19      10864
> 20      11936
> 21      7974
> 22      6256
> 23      4888
> 24      2385
> 25      640
> 26      164
> 27      113
> 28      86
> 29      105
> 30      90
> 31      86
> 32      103
> 33      140
> 34      149
> 35      183
> 36      160
> 37      141
> 38      147
> 39      146
> 40      172
> 41      140
> 42      131
> 43      89
> 44      54
> 45      10
> 46      3
> 47      2
> 49      3
> 

The above histogram was generated with normal desktop activity going
on.  Another run under the same conditions produced the same three
"humps".  Here are the results with an idle system:

Delay   Count
-----   -----
6       8460
7       481093
8       66311
9       43167
10      23021
11      5536
12      3883
13      3370
14      3635
15      3923
16      3419
17      2892
18      2615
19      2659
20      5239
21      3607
22      1289
23      662
24      237
25      59
26      28
27      15
28      17
29      24
30      29
31      50
32      65
33      34
34      34
35      23
36      29
37      19
38      25
39      36
40      42
41      22
42      18
43      8
44      5

The second hump centered at 20-21 usecs is still present, but smaller. 
The third hump centered at 31-32 is barely detectable, but present, 
repeating the test showed the same thing.

So the first hump is the fast path, interrupt -> scheduler -> jackd with
the fewest possible context switches, and a hot or warm cache.  The
third would have to be the worst case scenario (relatively speaking),
where we preempt another process in one of the longer common critical
sections.

The second hump seems like either the same situation as the fast path,
except with a cold cache, or where we have to preempt another process
that is not in a critical section at all, or a short one.

If we have any suspects for the code paths involved, couldn't this be
verified by adding a udelay(10) to the path, and verifying that the hump
moves by 10?  This technique could also be used to distinguish different
code paths with similar execution times.  It looks like they are finite
and few in number.

At this point there are no latency problems I can see, all that remains
is to understand the causes of the observed latencies.  Then assuming
any "direct-irq" drivers and anything you run SCHED_FIFO is realtime
safe, what else remains to be done in order to make hard realtime
guarantees?

Lee

Lee

