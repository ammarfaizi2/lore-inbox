Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272281AbTHFVUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHFVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:20:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58127 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272281AbTHFVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:20:31 -0400
Message-ID: <3F31741F.30200@techsource.com>
Date: Wed, 06 Aug 2003 17:33:19 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <1060060568.3f2f3d989683f@kolivas.org> <3F2F4076.1030009@cyberone.com.au> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> If cc1 is doing a lot of waiting on IO, I fail to see how it should be
> called a CPU hog. OK I'll stop being difficult! I understand the problem
> is that its behaviour suddenly changes from IO bound to CPU hog, right?
> Then it seems like the scheduler's problem is that it doesn't adapt
> quickly enough to this change.
> 
> What you are doing is restricting some range so it can adapt more quickly
> right? So you still have the problem in the cases where you are not
> restricting this range.


For this, I reiterate my suggestion to intentionally over-shoot the 
mark.  If you do it right, a process will run an inappropriate length of 
time only every other time slice until the oscillation dies down.


Let me give you an example.  Let's say you have a process which is being 
interactive, and then suddenly becomes a CPU hog.

In the case as it is (assumptions here), what happens is that the 
priority is reduced by some amount until it reaches a level appropriate 
for the new behavior.

I get the impression that lower numbers mean higher priority, so here goes:

- The process starts out with a priority of 10 (this may mean something 
that I don't know about... just follow along).
- It becomes a CPU hog sufficient to make it NEED to be at a priority of 30.
- Over some number of time slices, the priority is changed something 
like this:  10, 20, 25, 27, 28, 29, 30.


Here's my alternative suggestion -- if 10 is pure interactive and 30 is 
CPU hog, and you see some change in behavior, before, you would go half 
way.  Now, instead, go one-and-a-half way.
- Over some number of time slices, the priority is changed like this: 
10, 40, 25, 32, 27, 31, 28, 30



Let's say that you only get one time slice which is CPU hog, but others 
are not, for the first case, you'd get something like this:
10, 20, 15, 12, 11, 10

For the second case, you'd get this:
10, 40, -5, 17, 7, 11, 10


Something like that.  So instead of getting tricked and having to 
return, it over shoots but makes up for it the next time the process is run.


This is a very incomplete thought and may be pure garbage, so please 
forgive me if I'm being an idiot.  :)

