Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUE2Bjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUE2Bjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 21:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUE2Bjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 21:39:44 -0400
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:21187 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S262194AbUE2Bjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 21:39:42 -0400
Message-ID: <40B7E9D7.9030607@bigpond.net.au>
Date: Sat, 29 May 2004 11:39:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Ingo Molnar wrote:
 >> Peter Williams <peterw@xxxxxxxxxx> wrote:
 >> >just try it - run a task that runs 95% of the time and sleeps 5% of the
 >> >time, and run a (same prio) task that runs 100% of the time. With the
 >> >current scheduler the slightly-sleeping task gets 45% of the CPU, the
 >> >looping one gets 55% of the CPU. With your patch the slightly-sleeping
 >> >process can easily monopolize 90% of the CPU!
 >>
 >> If these two tasks have the same nice value they should around robin
 >> with each other in the same priority slot and this means that the one
 >> doing the smaller bites of CPU each time will in fact get less CPU
 >> than the other i.e. the outcome will be the opposite of what you
 >> claim.
 >
 > just try what i described with and without your patch and look at the
 > 'top' output. You can do a simple loop plus short 10-20msec sleeps
 > (via nanosleep) to simulate a 95% busy task.

OK.  I've tried this experiment and an effect similar to what you 
described (but not as severe) was observed.  However, as I opined, this 
was due to the interactive bonus mechanism being too generous to the 
sleeper - sometimes giving at as many as 9 bonus points out of a 
possible maximum of 10.  The severity of the effect was variable and 
proportional to the size of the bonus awarded at any given time.  So the 
problem is due to the bonus point scheme and not the absence of the 
active and expired arrays.

Further investigation of this problem has revealed that the reason that 
the interactive bonus scheme is so generous to this type of task is due 
the code in schedule() that allows tasks with "activated" greater than 1 
to count time spent on the run queue as sleep time.  If this code is 
removed the effect disappears.

Interestingly enough, removing that code has no effect (that I could 
discern) on the interactive response even under heavy loads.  This had 
been observed previously and consideration was given to removing this 
code as part of this patch but it was decided to make no significant 
changes to the interactive bonus scheme for this patch.  I.e. 
modifying/improving the interactive bonus mechanism was considered to be 
another issue.

Peter
PS Sorry about the change in e-mail address but my ISP changed my IP 
address and this has caused me to lose my SSH connection with my 
aurema.com account and as it's now Saturday here in Sydney I'm unlikely 
to get it back until Monday.
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

