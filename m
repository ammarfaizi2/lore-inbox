Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTIJP0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTIJP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:26:07 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51986 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265015AbTIJPZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:25:56 -0400
Message-ID: <3F5F47A9.3000300@techsource.com>
Date: Wed, 10 Sep 2003 11:47:53 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Larry McVoy <lm@bitmover.com>, phillips@arcor.de, mbligh@aracnet.com,
       piggin@cyberone.com.au, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Lock EVERYTHING (for testing) [was: Re: Scaling noise]
References: <20030903040327.GA10257@work.bitmover.com>	<31190000.1062604245@[10.10.2.4]>	<20030904004943.GB5227@work.bitmover.com>	<200309040421.16939.phillips@arcor.de>	<20030904024608.GH5227@work.bitmover.com> <20030903215850.0827c589.davem@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

> 
> So again, if you're going to argue against huge SMP (at least to me),
> don't use the locking complexity argument.  Not only have we basically
> conquered it, we've along the way found some amazing ways to find
> locking bugs both at runtime and at compile time.  You can even debug
> them on uniprocessor systems.  And this doesn't even count the
> potential things we can do with Linus's sparse tool.


Pardon me for suggesting another idea for which I have no code written, 
but I was just wondering...

Is there a way we could get gcc to wrap EVERY memory access with some 
kind of debug lock?

Actually, I do have code, but for another application.  I designed a 
graphics drawing engine which has a FIFO for commands.  Before sending 
commands, you have to be sure there is enough free space in the FIFO, so 
there is a macro we use which tries to do this in an efficient way. 
Anyhow, there have been instances where we didn't check for enough space 
or didn't check for space at all, etc., and those bugs have been 
sometimes hard to find.

Two macros involved are CHECK_FIFO and WRITE_WORD.  Normally, CHECK_FIFO 
just checks for space, and WRITE_WORD just writes a word (it's more 
complicated than that, but never mind).  However, we have a second set 
of macros which check to make sure we're doing everything right.  The 
"check checker" macros have CHECK_FIFO set a counter and WRITE_WORD 
decrement that.  (Again, a bit more complex than that.)  If the counter 
ever goes below zero, we know we screwed up and exactly where.  Another 
thing we have is a way to indicate that we know we're doing something 
that looks like it may violate the normal way of things but really 
doesn't (for instance, sometimes, we write fewer words than we check 
for, and that is something we still print warnings about, but not in the 
cases where it's intentional).

The analogy for Linux is this:  At a machine level, we add a check to 
EVERY access.  The check is there to ensure that every memory access is 
properly locked.  So, if some access is made where there isn't a proper 
lock applied, then we can print a warning with the line number or drop 
out into kdb or something of that sort.

I'm betting there's another solution to this, otherwise, I wouldn't 
suggest such an idea, because of the relative amount of work versus 
benefit.  But it may require massive modifications to GCC to add this 
code in at the machine level.

Perhaps an even better solution would be to run an emulator.  Anyone 
know of a 686 emulator I can compile for intel?  The emulator could be 
modified to track locks and determine if any accesses are made without 
proper locks.

And another option that I could REALLY sink my teeth into.  If there was 
a 686 implementation in Verilog that I could run on an FPGA, it would be 
an order of magnitude slower than a real CPU, but still faster than an 
emulator.

One idea is to have something which can run 686 ISA that fits in a 
Virtex 1000 and runs at maybe 66mhz.  We put that with some adaptor 
board into an old dual processor PC that expects a Pentium Pro with a 
66mhz FSB.

That's probably overly ambitious, although I do do chip design for a 
living, so it's not entirely beyond the realm of possibility.

One problem is that we need to have metadata about memory accesses so we 
can track the difference between accesses which are to memory private to 
a CPU (no lock required) and accesses which are to shared memory (lock 
required) so we can determine what is a violation.  The FPGA daughter 
board would have to have its own RAM on it to track that.

And that leads me to another idea:  Reprogramming Transmeta processors 
to do all that.  :)


