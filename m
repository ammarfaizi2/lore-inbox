Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263602AbUEMAPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbUEMAPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUEMAPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:15:17 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:26341 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263602AbUEMAPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:15:09 -0400
Subject: Re: Status field in ps output for threaded programs in 2.6 kernel
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: dizzy@roedu.net, yoush@cs.msu.su
Content-Type: text/plain
Organization: 
Message-Id: <1084398747.955.466.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2004 17:52:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai Rusu writes:
> On Wed, 12 May 2004, Nikita V. Youshchenko wrote:

>> Looks like kernel bug: displayed status of threaded process
>> should not be "S" if some threads are active. And CPU usage
>> statistics should correspond to all threads.
>
> Hmm I dont know about that. A "solution" here is to have top also
> display threads (like ps -m or ps -H of a recent procps distro).

First of all, "ps -H" does a process tree display.
You want one of these:

ps m    Tru64 BSD style, with threads after process
ps -m   Tru64 SysV style, with threads after process
ps H    FreeBSD style, with loose threads (independent sorting)
ps -L   Sun style, with grouped threads and LWP column
ps -T   SGI style, with grouped threads and TID column

For process state, maybe have the kernel spit out a '*'
if not all threads are in the same state?

For CPU usage, Linux has been totally broken since day 1.
The SUSv3 and POSIX standard requires that the OS report
some notion of recent CPU usage. Linux doesn't bother.
BSD provides a decaying average, like a per-process
load average. AIX provides a simple average over a few
seconds. SysV provides something similar.

Here is what Solaris does:

You get both per-process and per-thread data. It is
provided as a fixed-point decaying average, with a
15-bit fraction. Thus:

0x8000  100%
0x6000   75%
0x4000   50%
0x2000   25%
0x0000    0%

With Linux, you get only the %CPU over the whole life
of the process. So a process that runs for months using
only 1% of the CPU will still appear to use 1% of the
CPU even after it gets stuck in a CPU-eating loop. You
can get around this by using "top", which is able to
compute a real %CPU from one refresh to the next.


