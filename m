Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVAKJVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVAKJVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVAKJVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:21:40 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:29563 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262631AbVAKJVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:21:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MOs3WrI+UWwDwcyRU5lcRbIh1SSbAJnnnycWWxfgVJM6RpYUMIuM3QZeN3reJRMRSLXsM4cGIJ+W7FK/cE7Cc/K+seAEHHv6/s9YZZS6pEbeJt/zxL3/PrjIHQ0YNEHe9Kd3gTaf6M+JY64YihGWBqhQg0c4XYh6UBarGEfIZFI=
Message-ID: <4d6522b905011101202918f361@mail.gmail.com>
Date: Tue, 11 Jan 2005 11:20:59 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: tglx@linutronix.de
Subject: Re: User space out of memory approach
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105433093.17853.78.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
> I consider the invocation of out_of_memory in the first place. This is
> the real root of the problems. The ranking is a different playground.
> Your solution does not solve
> - invocation madness
> - reentrancy protection
> - the ugly mess of timers, counters... in out_of_memory, which aren't
> neccecary at all

You're 100% right! It was not the purpose to solve it in the first
place, but rather
to remove the ranking algorithm out of kernel. 

Hmmm, it seems you removed the selection problem from your original list,
that means we made our point. Thankyou!

> This must be solved first in a proper way, before we talk about ranking.
> 
> You are definitely curing the symptom instead of the cause.
> 
> > 1) ranking for the most likely culprits only starts when memory consumption
> >     gets close to the red zone (for example 98% or something like that).
> > 2) killing just gets the first candidate from the list and kills it.
> > No need to calculate
> >     at kernel level.
> 
> What is the default behaviour when no userspace settings are available -
> Nothing ? Are you really expecting that we change every root fs in order
> to be able to upgrade the kernel for solving this _kernel_ problem ?

No, I certainly don't. But, have seen the application we also posted? It is
a test for while, that actually starts a deamon when you boot the kernel
and does rate this application, i.e. an application with root rating priority
so it will never be killed and never lack space for itself. 
So, the answer to your 2nd very good point.

But as I wrote above it is an idea to be tested not to impose any
change in every
root fs.

> Who is setting up those userspace constraints ? Joe User, who is barely
> able to find the power on button on his box ? The sysadmin, who will
> have to adjust the list for each box depending on the apps it runs or
> the user who is logged into the box ?

Well from the discussion below and your reasonable argument it is clear that
we are thinking of it for embeded deveices, in the first place. 

> Memory management _is_ a kernel task and so the shortage of memory has
> to be handled by the kernel on its own in the first place. Adding user
> space support for certain tasks is a good thing, but not a solution to
> the problem itself.

Yes, you're 100% right again. Sorry but, Does this mean that for everything it 
manages the kernel should compute rates for PID? It seems that only tests
can show which way is more appropriate. Perhaps it may end up showing
that both ways reach the same result, but, perhaps, with different algorithm 
ingenuity. We shall work on this test data and it soon. Thank you.

> 
> > The selection problem is very dependent on the ranking algorithm. For PCs it
> > may not be a trouble, but for emdedded devices? yes it is. The ranking at the
> > kernel level uses only int type of integer. If you get the log file
> > for the ranking
> > in any embedded device you will notice that many processes end up with
> > the same ranking point. Thus, there will never be the best choice in this way.
> 
> I know the constrains of embedded boxes well enough to know that there
> is a bit of a difference to a desktop machine.

I didn't mean you don't know. Don't it personal.

> 
> > By moving just the ranking to the user space fix this problem 'cause you may
> > use float to order PIDs with different indexes. The good side effect is that we
> > allow better ways of choosing the culprit by means of diffrent calculations to
> > meet different patterns of memory consumtion.
> 
> I'm running Andrea's and my combined fixes on a couple of embedded and
> desktop boxes and it has proven to be a proper in kernel solution for
> the in kernel problem.
> 
> I don't argue againts the ability to provide a culprit list to the
> kernel, but as I said before it only can be a optional addon to a proper
> in kernel solution.

Back to your list of problems, we tackled just one. The selection problem. For
sure we will investigate on your solution and see a faster way to enhance ours 
with with your approach. Who knows the other way around might work as well?

Thank you again

br

Edjard

> 
> tglx



> 


-- 
"In a world without fences ... who needs Gates?"
