Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275233AbTHGI0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275234AbTHGI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:26:12 -0400
Received: from dyn-ctb-203-221-72-79.webone.com.au ([203.221.72.79]:11539 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275233AbTHGI0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:26:08 -0400
Message-ID: <3F320D15.7020403@cyberone.com.au>
Date: Thu, 07 Aug 2003 18:25:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
References: <200308061910.h76JAYw16323@mail.osdl.org> <200308071240.54863.kernel@kolivas.org> <3F31DF98.6020908@cyberone.com.au> <200308071541.06091.kernel@kolivas.org>
In-Reply-To: <200308071541.06091.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Thu, 7 Aug 2003 15:11, Nick Piggin wrote:
>
>>What is the need for this round robining? Don't processes get a calculated
>>timeslice anyway?
>>
>
>Nice to see you taking an unhealthy interest in the scheduler tweaks Nick. 
>This issue has been discussed before but it never hurts to review things. 
>I've uncc'ed the rest of the people in case we get carried away again. First 
>let me show you Ingo's comment in the relevant code section:
>
>		 * Prevent a too long timeslice allowing a task to monopolize
>		 * the CPU. We do this by splitting up the timeslice into
>		 * smaller pieces.
>		 *
>		 * Note: this does not mean the task's timeslices expire or
>		 * get lost in any way, they just might be preempted by
>		 * another task of equal priority. (one with higher
>		 * priority would have preempted this task already.) We
>		 * requeue this task to the end of the list on this priority
>		 * level, which is in essence a round-robin of tasks with
>		 * equal priority.
>
>I was gonna say second blah blah but I think the first paragraph explains the 
>issue. 
>
>Must we do this? No. 
>
>Should we? Probably. 
>
>How frequently should we do it? Once again I'll quote Ingo who said it's a 
>difficult question to answer. 
>

OK, I was just thinking it should get done automatically by virtue
of the regular timeslice allocation, dynamic priorities, etc.

It just sounds like another workaround due to the scheduler's inability
to properly manage priorities and (the large range of length of) timeslices.

>
>
>The more frequently you round robin the lower the scheduler latency between 
>SCHED_OTHER tasks of the same priority. However, the longer the timeslice the 
>more benefit you get from cpu cache. Where is the sweet spot? Depends on the 
>hardware and your usage requirements of course, but Ingo has empirically 
>chosen 25ms after 50ms seemed too long. Basically cache trashing becomes a 
>real problem with timeslices below ~7ms on modern hardware in my limited 
>testing. A minor quirk in Ingo's original code means _occasionally_ a task 
>will be requeued with <3ms to go. It will be interesting to see if fixing 
>this (which O12.2+ does) makes a big difference or whether we need to 
>reconsider how frequently (if at all) we round robin tasks.  
>

Why not have it dynamic? CPU hogs get longer timeslices (but of course
can be preempted by higher priorities).


