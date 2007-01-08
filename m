Return-Path: <linux-kernel-owner+w=401wt.eu-S964823AbXAHVpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbXAHVpi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbXAHVpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:45:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46867 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbXAHVph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:45:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
	<86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
	<20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
	<m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d55pikbc.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xgdijmb.fsf_-_@ebiederm.dsl.xmission.com>
	<20070108202105.GB6167@stusta.de>
Date: Mon, 08 Jan 2007 14:45:00 -0700
In-Reply-To: <20070108202105.GB6167@stusta.de> (Adrian Bunk's message of "Mon,
	8 Jan 2007 21:21:05 +0100")
Message-ID: <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Mon, Jan 08, 2007 at 09:11:24AM -0700, Eric W. Biederman wrote:
>> 
>> To a large extent this reverts b026872601976f666bae77b609dc490d1834bf77
>> while still keeping to the spirits of it's goal, the ability to
>> make smart guesses about how the timer irq is routed when the BIOS
>> gets it wrong.
>>...
>
> That's code where every changed line has a great potential of causing a 
> different kind of breakage on someone else's computer.

Why does this piece of code give every one the screaming hebie jebies?
I read it I understand it, it is code.

This code is not a terribly sensitive delicate heuristic, and Andi has
already broken it as much as it can possibly be broken.  It's not like
the code is on a SMP fastpath full of carefully orchestrated races
that are safe because within certain limits even stale values are ok.

This is code is straight forward logic, you tell the computer what to
do and it does it.  Of those things we can do only very few of
them are correct, and we are seeking to enhance our ability to find
correct solutions by adding intelligent guesses.  As long as the first
guess is trust the BIOS the rest of this code is largely a don't
care.  As Andi proved by breaking all the rest of this.  Or why
don't I have more testers just crawling out of the wood work,
screaming for this code to be fixed?

Plus this code can only cause one type of breakage.   A failure to
work around a broken BIOS and make the IRQs work.

> Your comment therefore translates to "rexvert commit 
> b026872601976f666bae77b609dc490d1834bf77 for 2.6.20 and try to find a 
> better solution for 2.6.21".

If that is the practical translation I am fine with it.

Linus said he wanted to try in the 2.6.20 timeframe.  Although things
have probably dragged on much to long.

The heuristics tests in my patch actually do what they try to do. 
Unlike Andi's where only trusting the BIOS supplied default works.
So from where we are it is a clear benefit.  b026872601976f666bae77b609dc490d1834bf77
is broken.  I just found it easier and more evolutionary to starting
with a working code base.  Not that my result is radically different
codewise from what Andi and tried.

Everything that worked in 2.6.19 should also work.  Except for the ATI
case we still have all of the other heurstic work abounds supplied by
quirks instead of supplied manually, and the ATI fix was to not enable
interrupts on the i8259 and then expect the ioapic to work, which we
have sensibly made a global default.

I really don't care how we do it, or in what timeframe.  But what I have
posted is the only way I can see of making it better, than what we had
in 2.6.19.

I would like to see my code take the conversation to talking about
what intelligent guesses we should try when the BIOS get's it wrong
instead of being stuck where we have with Andi's code about how do we
make the heuristic guesses we want to try actually run.

Now if someone wants to see a beautiful history we can revert Andi's commit
Implement the code motion parts of mine into functions.  Implement what it
takes to make those functions safe to call multiple times, and then call
extra times as heuristic guesses to get the hardware correct.  There
might be some sense in that, although it feels like trying to hard to me.

I definitely think in the 2.6.21 timeframe it makes sense to put this code in
on i386 as well.  Otherwise the maintenance will just be crazy.

Eric
