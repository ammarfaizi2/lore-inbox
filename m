Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLPWbQ>; Mon, 16 Dec 2002 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLPWbQ>; Mon, 16 Dec 2002 17:31:16 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:22981 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S261861AbSLPWbP>;
	Mon, 16 Dec 2002 17:31:15 -0500
Date: Mon, 16 Dec 2002 23:38:48 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Message-ID: <20021216223848.GA2994@werewolf.able.es>
References: <FKEAJLBKJCGBDJJIPJLJKEMCDLAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJKEMCDLAA.scott@coyotegulch.com>; from scott@coyotegulch.com on Mon, Dec 16, 2002 at 16:44:34 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.16 Scott Robert Ladd wrote:
>Måns Rullgård wrote:
>> It's easy to write a program that displays any number of graphs
>> vaguely related to the system load.  How do we know that the
>> performance meter isn't lying?
>
>We don't.
>
>All I can say is that the performance meter seems (note the weasel-word)
>proper when running Win2K SMP on a dual PIII-933 box at one of my client
>sites. However, such experience does *not* guarantee that WinXP is reporting
>valid numbers for a P4 with HT.
>
>Here's a little test I ran this morning, now that my new system is
>operational. My benchmark is a full "make bootstrap" compile of gcc-3.2.1,
>with and without the - j 2 make switch that enables two threads of
>compilation. Using the 2.5.51 SMP kernel, I see the following compile times:
>
>  SMP     w/o  -j 2: 28m11s
>  "nosmp" with -j 2: 27m32s
>  SMP     with -j 2: 24m21s
>
>HT appears to give a very tiny benefit even without an SMP kernel -- and
>*with* an SMP kernel, I get a 16% improvement in my compile time. That
>pretty much matches my expectation (i.e., a HT processor is *not* equal to
>dual processor, but it *is* better than a non-HT processor).
>

HT can give no benefit in UP case, nobody knows that the sibling exists
and the P4 does not paralelize itself. The gain you see is due to 
computation-io overlap.

This my render code, implemented with posix threads, running on a dual
P4-Xeon@1.8GHz. Work is just dynamic strctures walk-through and floating
point calculation, no IO. In this example the database is tiny, so there
is no swap, and the box is 'all mine', any other process eating CPU.

Processes do not bounce between cpus and ht-aware scheduler
prefers a processor in different physical package when two cpu intensive
threads are running, so in the 2-threads case they run on different
packages:

Number of threads	Elapsed time   User Time   System Time
1                   53:216           53:220    00:000
2                   29:272           58:180    00:320
3                   27:162         1:21:450    00:540
4                   25:094         1:41:080    01:250

Elapsed is measured by the parent thread, that is not doing anything
but wait on a pthread_join. User and system times are the sum of
times for all the children threads, that do real work.

The jump from 1->2 threads is fine, the one from 2->4 is ridiculous...
I have my cpus doubled but each one has half the pipelining for floating
point...see the user cpu time increased due to 'worst' processors and
cache pollution on each package.

So, IMHO and for my apps, HyperThreading is just a bad joke.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
