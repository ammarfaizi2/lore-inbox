Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272976AbTHFAKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTHFAKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:10:49 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:14071
	"EHLO flat") by vger.kernel.org with ESMTP id S272976AbTHFAKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:10:44 -0400
Date: Wed, 6 Aug 2003 01:12:08 +0100
From: charlie.baylis@fish.zetnet.co.uk
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030806001208.GA16287@fish.zetnet.co.uk>
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F303494.3030406@techsource.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 06:49:56PM -0400, Timothy Miller wrote:
> The interactivity detection algorithm will always be inherently 
> imperfect.  Given that it is not psychic, it cannot tell in advance 
> whether or not a given process is supposed to be interactive, so it must 
> GUESS based on its behavior.
> 
> Furthermore, for any given scheduler algorithm, it is ALWAYS possible to 
> write a program which causes it to misbehave.
>
> This "thud" program is Goedel's theorem for the interactivity scheduler 
> (well, that's not exactly right, but you get the idea).  It breaks the 
> system.  If you redesign the scheduler to make "thud" work, then someone 
> will write "thud2" (which is what you have just done!) which breaks the 
> scheduler.  Ad infinitum.  It will never end.  And in this case, 
> optimizing for "thud" is likely also to make some other much more common 
> situations WORSE.

No, you've got this backwards. The thud program is a short piece of code
written to allow other kernel developers to reliably reproduce a specific
problem with the scheduler - that is, when only a small number of maximally
interactive tasks suddenly become CPU hogs they were able to starve most other
processes for several seconds.  This is an entirely real world case (see my
original posting to explain this), and it causes problems because, as you say,
the scheduler is not psychic.

I say you've got it backwards because thud is a much simpler piece of code than
Konqueror + XFree86, and it is simpler because uses 'reverse-engineered'
knowledge about the scheduler to manipulate it's dynamic priority to the point
where the scheduler problems I reported could be reproduced. As Con's changes
have broken these assumptions, thud needs updating so that it can continue to
behave equivalently on the newer schedulers. (The changes I gave will have no
effect on the old versions of the scheduler)

> So, while it MAY be of value to write a few "thud" programs, don't let 
> it go too far.  The scheduler should optimize for REAL loads -- things 
> that people actually DO.  You will always be able to break it by 
> reverse-engineering it and writing a program which violates its 
> expectations.  

I think you're confused between the thud test and the thud implementation.  The
thud implementation is a hacked up bit of C. The thud test is seeing a
maximally interactive task suddenly become a CPU hog. Once the implementation
no longer performs the test it ceases to be interesting[1], and it must be
updated, otherwise you aren't getting the test coverage you think you are
getting. 

Certainly, thud isn't the only program by which a scheduler should be measured.
If you have a better, more realistic and reproducible test case, or even just a
different one, which can help evaluate the performance of the interactivity
estimator then I'd love to see it :) (Actually, if you/someone can write a
simple program which can replace xmms skips as the standard "scheduler is
good/bad" benchmark that would be great. It wants to do n milliseconds of work
every m milliseconds and report the minimum/maximum/average time it took to do
the sleep and the work. Or something like that)

> Don't worry about it.  You will always be able to break it if you try hard
> enough.

The scheduler DOES have to cope with tasks which behave oddly, because it can
make bad decisions, and it has to be able to recover quickly or these corner
cases may be used to form a denial of service attack.

> As Linus says, "Perfect" is the enemy of "Good".

That doesn't preclude making things better. Otherwise, why ditch the "good" 2.4
scheduler :) 

Charlie

[1] unless the new test it performs is interesting for some other reason.
