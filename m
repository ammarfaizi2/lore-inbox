Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVAHSl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVAHSl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVAHSl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:41:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:29609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbVAHSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:41:52 -0500
Date: Sat, 8 Jan 2005 10:41:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
In-Reply-To: <20050108082535.24141.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jan 2005 linux@horizon.com wrote:
> 
> H'm... the version that seemed natural to me was an asymmetrical one-way
> tee, such as "tee(in, out, len, flags)" might be better, where the next
> <len> bytes are *both* readable on fd "in" *and* copied to fd "out".

Yes, the implementation may end up being something like that, I haven't
decided. That would be more of a "peek()" kind of thing, not a "tee()",
but it has the advantage of getting rid of one unnecessary complexity of
"tee()" - dependence on three different fd's (in particular, if one of the
output fd's isn't writable, we can't do anything at all).

However, "peek()" has the problem that while it allows you to just run "n" 
peek() calls for the "n" outputs, you now need to keep track of how much 
each output has consumed (since they can be filled at different rates), 
and then appropriately "eat" the proper amount of input when it has been 
consumed by everybody. That's a very error-prone interface.

In contrast, with a plain "tee()", you'd just create a tree "log(n)" 
deep of "tee()" actors, and you'd have "n" outputs from one input, and 
each individual point would be very simple.

NOTE! I don't think either "tee()" or "peek()" really works for very high
fan-out. I don't believe that you'd ever really have a "balanced" enough
output across many things, and since they all end up being synchronized to
the same input (you can make the buffers deeper, which will help a bit,
but..) I don't think it ends up being _that_ useful.

Where I foresee "tee()" is when there is some rate-limited input that you 
can easily handle in two or three streams. That's what the example of a 
digital TV input signal was kind of meant to be - the input is 
rate-limited, which means that the fact that the outputs are 
likely consumed at different paces (saving to disk might be fast, showing 
it on the screen would be real-time) doesn't matter. But such a use ends 
up breaking down when the load is too high - you're likely going to be 
constrained in the number of streams by pure load issues.

(And if you are _not_ constrained by load issues, then you don't need 
tee() at all - you could just have copied the things by hand ;)

> But then I realized that I might be thinking about a completely different
> implementation than you... I was thinking asynchronous, while perhaps
> you were thinking synchronous.

I _am_ thinking entirely synchronous. It would copy exactly what was in 
the pipe, and nothing more. It would sleep if either end was full/empty 
(modulo N_DELAY, of course), but it would in no way be a long-term "set up 
this copy mechanism.

None of the pipes would do anything on their own - they aren't "actors".  
They'd be purely buffers. So if you want to have an asynchronous 
long-running "tee()/copy()/peek()", you'd have a thread that does that for 
you.

> With the synchronous model, the two-output tee() call makes more sense, too.
> Still, it would be nice to be able to produce n identical output streams
> without needing n-1 processes to do it  Any ideas? 

I agree, although I don't know how common it would be for "n" to be very
big. And you don't need n-1 processes (or threads), you can certainly do
it with the normal select-loop approach too.

> As for the issue of coalescing:
> > This is the main reason why I want to avoid coalescing if possible: if you
> > never coalesce, then each "pipe_buffer" is complete in itself, and that
> > simplifies locking enormously.
> >
> > (The other reason to potentially avoid coalescing is that I think it might
> > be useful to allow the "sendmsg()/recvmsg()" interfaces that honour packet
> > boundaries. The new pipe code _is_ internally "packetized" after all).
> 
> It is somewhat offensive that the minimum overhead for a 1-byte write
> is a struct pipe_buffer plus a full page.

Note that there is no reason why we couldn't use just "kmalloc()" too.

For the different input cases we'll need per-pipe_buffer operation
functions (very much including a "release()" function) _anyway_, which
means that while the current implementation always just does "alloc_page()
+ __free_page()" for it's buffer allocation, there is absolutely zero that 
says that you couldn't allocate small buffers with "kmalloc()" and free 
them with "kfree()".

And since we need to support per-buffer ops anyway (for people mixing
"write()" and "splice()" to set up the pipe contents), it works very
naturally for mixed size writes too (ie you can have a small write that is
buffered in a small kmalloc'ed buffer, followed by a big write that uses
the page allocator, and nobody will care - you just decide at buffer fill
time which one you need).

So yes, the current setup is wasteful, but coalescing isn't the only way 
to fight that - you can just use smaller allocations too.

So in my mind, the only reason for doign coalescing is if some silly
program deadlocks if it writes many small writes, and nobody is reading
it. Some people use pipes as buffers _within_ a program, ie use them to
send signals etc (common for signal-safe select handling - you make the
signal handler do a write() to a pipe, and the select loop has the pipe in
its FD-set).

For all of those that are valid (certainly the signal case), you need to
put the pipe into nonblocking mode anyway, so I don't think coalescing is
really needed. SuS certainly does _not_ seem guarantee that you can do
many nonblocking writes (small _or_ big). Let's see if somebody reports 
any trouble with the new world order.

			Linus
