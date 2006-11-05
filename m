Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965832AbWKEENr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965832AbWKEENr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965833AbWKEENr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:13:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965832AbWKEENr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:13:47 -0500
Date: Sat, 4 Nov 2006 20:13:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Zachary Amsden <zach@vmware.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <20061105035556.GQ9057@kvack.org>
Message-ID: <Pine.LNX.4.64.0611041959260.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <454CE576.3000709@vmware.com>
 <20061105035556.GQ9057@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2006, Benjamin LaHaise wrote:

> On Sat, Nov 04, 2006 at 11:09:42AM -0800, Zachary Amsden wrote:
> > Every processor I've ever measured it on, popf is slower.  On P4, for 
> > example, pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 12.  
> > On Xeon, it is 7 / 91.
> 
> pushf has to wait until all flag dependancies can be resolved.  On the 
> P4 with >100 instructions in flight, that can take a long time.

That's like saying that "addc has to wait until all flag dependencies can 
be resolved". Not so. It just needs to execute _after_, but it pipelines 
perfectly fine. There's no need for any pipeline flush, nothing like that. 
Yes, an "addc" needs the flags from previous instructions, but that 
doesn't really make an addc any slower - it just adds a data dependency.

Same goes for pushf. Sure - it has a data dependency on the flags. The 
flags are usually there one cycle (ONE CYCLE!) after the actual value has 
been computed, so you should expect it to be fast.

> Popf on the other hand has no dependancies on outstanding instructions 
> as it resets the machine state.

Right. Popf generally has to flush the pipeline, _exactly_ because it 
actually changes machine state that normally isn't carried along, and that 
may even be part of the trace-cache state on P4 for all I know.

So you got the logic totally wrong. pushf is fast, popf is slow. pushf can 
pipeline, popf would quite commonly _flush_ the pipeline. 

Dependencies are _cheap_. What's expensive is state changes.

Anyway, I'm right, you're wrong. Why even bother arguing about it? Why are 
people arguing against REAL HARD NUMBERS that were posted by Zach?

Btw, for the P4 people out there who can't admit that they are wrong, just 
run this small program.

	#define pushfl(value) \
		asm volatile("pushfl ; popl %0":"=r" (value));
	#define popfl(value) \
		asm volatile("push %0 ; popfl": :"r" (value));
	#define rdtsc(value) \
		asm volatile("rdtsc":"=A" (value))
	
	int main(int argc, char ** argv)
	{
		unsigned long long a,b;
		unsigned long tmp;
	
		rdtsc(a);
		rdtsc(b);
		printf("%lld\n", b-a);
		rdtsc(a);
		pushfl(tmp);
		rdtsc(b);
		printf("%lld\n", b-a);
		rdtsc(a);
		popfl(tmp);
		rdtsc(b);
		printf("%lld\n", b-a);
		return 0;
	}

For me, when compiled with -O2, it results in

	84
	88
	132

which basically says: a "rdtsc->rdtsc" is 84 cycles, putting a "pushfl" in 
between is another _4_ cycles, and putting a "popfl" in between is about 
another 48 cycles. 

Now, those numbers aren't scientific, but they tell you something.

Now, tell me how popfl is faster again.

But dammit, back it up with real numbers and real logic this time. 

		Linus
