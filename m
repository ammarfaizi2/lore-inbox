Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUE2F1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUE2F1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 01:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUE2F1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 01:27:09 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:36040 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S263740AbUE2F1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 01:27:04 -0400
Message-ID: <40B81F24.9080405@bigpond.net.au>
Date: Sat, 29 May 2004 15:27:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
 > On Fri, 28 May 2004 19:24, Peter Williams wrote:
 > > Ingo Molnar wrote:
 > > > just try it - run a task that runs 95% of the time and sleeps 5%
 > > > of the time, and run a (same prio) task that runs 100% of the
 > > > time. With the current scheduler the slightly-sleeping task gets
 > > > 45% of the CPU, the looping one gets 55% of the CPU. With your
 > > > patch the slightly-sleeping process can easily monopolize 90% of
 > > > the CPU!
 >
 > > This does, of course, not take into account the interactive bonus.
 > > If the task doing the shorter CPU bursts manages to earn a larger
 > > interactivity bonus than the other then it will get more CPU but
 > > isn't that the intention of the interactivity bonus?
 >
 > No. Ideally the interactivity bonus should decide what goes first
 > every time to decrease the latency of interactive tasks, but the cpu
 > percentage should remain close to the same for equal "nice" tasks.

There are at least two possible ways of viewing "nice": one of these is 
that it is an indicator of the tasks entitlement to CPU resource (which 
is more or less the view you describe) and another that it is an 
indicator of the task's priority with respect to access to CPU resources.

If you wish the system to take the first of these views then the 
appropriate solution to the scheduling problem is to use an entitlement 
based scheduler such as EBS (see 
<http://sourceforge.net/projects/ebs-linux/>) which is also much simpler 
than the current O(1) scheduler and has the advantage that it gives 
pretty good interactive responsiveness without treating interactive 
tasks specially (although some modification in this regard may be 
desirable if very high loads are going to be encountered).

If you want the second of these then this proposed modification is a 
simple way of getting it (with the added proviso that starvation be 
avoided).

Of course, there can be other scheduling aims such as maximising 
throughput where different scheduler paradigms need to be used.  As a 
matter of interest these tend to have not very good interactive response.

If the system is an interactive system then all of these models (or at 
least two of them) need to be modified to "break the rules" as far as 
interactive tasks are concerned and give them higher priority in order 
not to try human patience.

 > Interactive tasks need low scheduling latency and short bursts of high
 > cpu usage; not more cpu usage overall. When the cpu percentage 
differs > significantly from this the logic has failed.

The only way this will happen is if the interactive bonus mechanism 
misidentifies a CPU bound task as an interactive task and gives it a 
large bonus.  This seems to be the case as tasks with a 95% CPU demand 
rate are being given a bonus of 9 (out of 10 possible) points.

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

