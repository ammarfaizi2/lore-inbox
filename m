Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270869AbTHFSfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270870AbTHFSfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:35:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:43528 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270869AbTHFSfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:35:25 -0400
Message-ID: <3F314D6B.9090302@techsource.com>
Date: Wed, 06 Aug 2003 14:48:11 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Interactivity improvements
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051306.38180.kernel@kolivas.org> <3F2F21DF.1050601@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a kooky idea...

I'm not sure about this detail, but I would guess that the int 
schedulers are trying to determine relatively stable priority values for 
processes.  A process does not instantly come to its correct priority 
level, because it gets there based on accumulation of behavioral patterns.

Well, it occurs to me that we could benefit from situations where 
priority changes are underdamped.  The results would sometimes be an 
oscillation in priority levels.  In the short term, a given process may 
be given different amounts of CPU time when it is run, although in the 
long term, it should average out.

At the same time, certain tasks can only be judged correctly over the 
long term, like X, for example.  Its long-term behavior is interactive, 
but now and then, it will become a CPU hog, and we want to LET it.

The idea I'm proposing, however poorly formed, is that if we allow some 
"excessive" oscillation early on in the life of a process, we may be 
able to more quickly get processes to NEAR its correct priority, OR get 
its CPU time over the course of three times being run for the 
underdamped case to be about the same as it would be if we knew in 
advance what the priority should be.  But in the underdamped case, the 
priority would continue to oscillate up and down around the correct 
level, because we are intentionally overshooting the mark each time we 
adjust priority.

This may not be related, but something that pops into my mind is a 
numerical method called Newton's Method.  It's a way to solve for roots 
of an equation, and it involved derivatives, and I don't quite remember 
how it works.  But in any event, the results are less accurate than, 
say, bisection, but you get to the answer MUCH more quickly.

