Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbTFZJjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 05:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbTFZJjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 05:39:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16399 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265514AbTFZJjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 05:39:35 -0400
Message-ID: <3EFAC408.4020106@aitel.hist.no>
Date: Thu, 26 Jun 2003 11:59:36 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <20030623164743.GB1184@hh.idb.hist.no> <5.2.0.9.2.20030624215008.00ce73b8@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 02:12 PM 6/24/2003 -0400, Bill Davidsen wrote:
> 
>> On Mon, 23 Jun 2003, Helge Hafting wrote:
>>
>> > On Mon, Jun 23, 2003 at 12:18:29PM +0200, Felipe Alfaro Solana wrote:
>>
>> > > I don't consider compiling the kernel an interactive process as it's
>> > > done almost automatically without any user intervention. XMMS is 
>> not a
>> > > complete interactive application as it spends most of the time 
>> decoding
>> > > and playing sound.
>> > >
>> > A kernel compile isn't interactive - sure.  It may get some boosts
>> > anyway for io waiting.  This quite correctly puts it above a
>> > pure cpu hog like a mandelbrot calculation.
>>
>> Why? Not why does the scheduler do that, but why *should* a compile be in
>> any way more deserving that a Mandelbrot? It isn't obvious to me that
>> either are interacting with the user, and if they are it would be the
>> Mandelbrot doing realtime display.
> 
> 
> If the compile didn't receive a boost for it's io waits, the mandelbrot 
> would have an unfair advantage.  While the compile is sleeping, the 
> mandelbrot has sole access to the cpu.  Seems to me that this is quite 
> fair...
> 
>         -Mike
> 
> <semi-random thoughts>
> 
> ...until total sleep credit being accrued per unit time approaches unit 
> time?
> 
> At any rate, as soon as your cpu becomes saturated, tasks which 
> participate in the sleep bonus program can take over and starve the 
> sleep deprived _literally_ forever (iff the expired array is empty, 
> otherwise it's limited by STARVATION_TIMEOUT).  I think that hole needs 
> to be closed... at least the scheduler shouldn't default to starve 
> forever.  One way to combat active starvation would be to use lengthy 
> lack of idle calls to trigger periodic array switches.  That would 
> guarantee that everybody gets _some_ cpu.
> 
> ponders obnoxious ($&#!...;) irman process_load...
> 
> Too many random sleeper tasks steadily becoming runnable can DoS lower 
> priority tasks accidentally, but the irman process_load kind of DoS 
> seems to indicate a very heavy favoritism toward cooperating threads.  
> It seems to me that any thread group who's members sleep longer than 
> they run, and always has one member runnable is absolutely guaranteed to 
> cause terminal DoS.  Even if there isn't _always_ a member runnable, 
> waking a friend and waiting for him to do something seems like a very 
> likely thing for threaded process to do, which gives the threaded 
> process a huge advantage because the cumulative sleep_avg pool will 
> become large simply because it's members spend a lot of time jabbering 
> back and forth.
> 

How about _removing_ the io-wait bonus for waiting on pipes then?
If you wait for disk io, someone else gets to use
the cpu for their work.  So you get a boost for
giving up your share of time, waiting
for that slow device.

But if you wait for a pipe, you wait for some other
cpu hog to do the first part of _your_ work.
I.e. nobody else benefitted from your waiting,
so you don't get any boost either.

This solves the problem of someone artifically
dividing up a job, using token passing
to get unfair priority.


This can be fine-tuned a bit: We may want the pipe-waiter
to get a _little_ bonus at times, but that has to be
subtracted from whatever bonus the process at the
other end of the pipe has.  I.e. no new bonus
created, just shift some the existing bonus around.
The "other end" may, after all, have gained legitimate
bonus from waiting on the disk/network/paging/os, and passing
some of that on to "clients" might make sense.

So irman and similar pipe chains wouldn't be able to build
artifical priority, but if it get some priority
in an "acceptable" way then it is passed
along until it expires.

I.e. "bzcat file.bz2 | grep something | sort | less" could
pass priority down the chain when bzcat suffers
a long nfs wait...

Helge Hafting


> Take any two cpu hungry products.  Run one monolithic version, and one 
> chopped into little cooperative pieces at the same time, and the 
> monolithic version can get down to zero cpu.  An application developer 
> can greatly improve a shoddy product's appeal by chopping it up and 
> making the other guy's nice high speed low drag monolithic product look 
> like doggy doo in comparison.  He can show the other guy's product being 
> torn to ribbons by light load while his keeps right on ticking.  (he'll 
> cleverly avoid pointing out the fact that the light load he ripped his 
> competition's head off with gets no cpu while _his_ product is running)



