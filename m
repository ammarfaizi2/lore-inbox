Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275076AbTHGFhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275078AbTHGFhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:37:12 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:63157
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275076AbTHGFgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:36:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
Date: Thu, 7 Aug 2003 15:41:06 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308061910.h76JAYw16323@mail.osdl.org> <200308071240.54863.kernel@kolivas.org> <3F31DF98.6020908@cyberone.com.au>
In-Reply-To: <3F31DF98.6020908@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071541.06091.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 15:11, Nick Piggin wrote:
> What is the need for this round robining? Don't processes get a calculated
> timeslice anyway?

Nice to see you taking an unhealthy interest in the scheduler tweaks Nick. 
This issue has been discussed before but it never hurts to review things. 
I've uncc'ed the rest of the people in case we get carried away again. First 
let me show you Ingo's comment in the relevant code section:

		 * Prevent a too long timeslice allowing a task to monopolize
		 * the CPU. We do this by splitting up the timeslice into
		 * smaller pieces.
		 *
		 * Note: this does not mean the task's timeslices expire or
		 * get lost in any way, they just might be preempted by
		 * another task of equal priority. (one with higher
		 * priority would have preempted this task already.) We
		 * requeue this task to the end of the list on this priority
		 * level, which is in essence a round-robin of tasks with
		 * equal priority.

I was gonna say second blah blah but I think the first paragraph explains the 
issue. 

Must we do this? No. 

Should we? Probably. 

How frequently should we do it? Once again I'll quote Ingo who said it's a 
difficult question to answer. 

The more frequently you round robin the lower the scheduler latency between 
SCHED_OTHER tasks of the same priority. However, the longer the timeslice the 
more benefit you get from cpu cache. Where is the sweet spot? Depends on the 
hardware and your usage requirements of course, but Ingo has empirically 
chosen 25ms after 50ms seemed too long. Basically cache trashing becomes a 
real problem with timeslices below ~7ms on modern hardware in my limited 
testing. A minor quirk in Ingo's original code means _occasionally_ a task 
will be requeued with <3ms to go. It will be interesting to see if fixing 
this (which O12.2+ does) makes a big difference or whether we need to 
reconsider how frequently (if at all) we round robin tasks.  

Con

