Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbUKQXaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUKQXaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUKQX2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:28:38 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:38660 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262577AbUKQX1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:27:17 -0500
Message-ID: <419BDE53.1030003@tebibyte.org>
Date: Thu, 18 Nov 2004 00:27:15 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net>
In-Reply-To: <20041117195417.A3289@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Werner Almesberger escreveu:
> A process could declare itself as usual suspect. This would then be
> recorded as a per-task flag, to be inherited by children.

I don't think this "I know I'm buggy, please kill me" flag is the right 
approach even if it can be made to work. The operating system has an 
overview of all the memory and can see when a particular process is 
basically making the machine unusable. It's quite likely that the 
process causing the trouble doesn't know (or hasn't admitted) that it's 
buggy and hasn't volunteered for early termination. As this means the 
kernel must be able to deal with a problematic process completely 
irrespective of whether it has set "kill me" flag or not the flag 
doesn't really buy you anything.

It is also specific to runaway processes that are clearly at fault. 
There is the related case where no particular process is faulty as such 
but the system as a whole can't cope with the demands being made.

On a related note, I would prefer to see victim processes who are not 
determined to be the cause of the trouble swapped out (i.e. *all* their 
pages pushed out to swap) and suspended (not allowed to run) as a first 
resort. The example I have in mind is on my machine when the daily cron 
run over commits causing standard daemons such as ntpd to be killed to 
make room. It would be preferable if the daemon was swapped out and just 
didn't run for minutes, or even hours if need be, but was allowed to run 
again once the system had settled down.

Of course, from recent discussion the system should not actually be 
killing off these daemons at all but that does seem to be resolved now. 
There are circumstances when there simply isn't enough RAM and swapping 
something out is preferable to killing it off. Of course, if there isn't 
sufficient swap space killing it should be the second resort. The last 
resort being panic.

So, the problem breaks down into three parts:

	  i) When should the oom killer be invoked.
	 ii) How do we pick a victim process
	iii) How can we deal with the process in the most useful manner

Regards,
Chris R.

