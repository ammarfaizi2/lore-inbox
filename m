Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWCCQz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWCCQz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWCCQz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:55:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932326AbWCCQz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:55:57 -0500
Date: Fri, 3 Mar 2006 08:55:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <32518.1141401780@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, David Howells wrote:
> 
> We've just had an interesting discussion on IRC and this has come up with two
> unanswered questions:
> 
> (1) Is spin_unlock() is entirely safe on Pentium3+ and x86_64 where ?FENCE
>     instructions are available?
> 
>     Consider the following case, where you want to do two reads effectively
>     atomically, and so wrap them in a spinlock:
> 
> 	spin_lock(&mtx);
> 	a = *A;
> 	b = *B;
> 	spin_unlock(&mtx);
> 
>     On x86 Pentium3+ and x86_64, what's to stop you from getting the reads
>     done after the unlock since there's no LFENCE instruction there to stop
>     you?

The rules are, afaik, that reads can pass buffered writes, BUT WRITES 
CANNOT PASS READS (aka "writes to memory are always carried out in program 
order").

IOW, reads can bubble up, but writes cannot. 

So the way I read the Intel rules is that "passing" is always about being 
done earlier than otherwise allowed, not about being done later.

(You only "pass" somebody in traffic when you go ahead of them. If you 
fall behind them, you don't "pass" them, _they_ pass you).

Now, this is not so much meant to be a semantic argument (the meaning of 
the word "pass") as to an explanation of what I believe Intel meant, since 
we know from Intel designers that the simple non-atomic write is 
supposedly a perfectly fine unlock instruction.

So when Intel says "reads can be carried out speculatively and in any 
order", that just says that reads are not ordered wrt other _reads_. They 
_are_ ordered wrt other writes, but only one way: they can pass an earlier 
write, but they can't fall back behind a later one.

This is consistent with
 (a) optimization (you want to do reads _early_, not late)
 (b) behaviour (we've been told that a single write is sufficient, with 
     the exception of an early P6 core revision)
 (c) at least one way of reading the documentation.

And I claim that (a) and (b) are the important parts, and that (c) is just 
the rationale.

> (2) What is the minimum functionality that can be expected of a memory
>     barriers? I was of the opinion that all we could expect is for the CPU
>     executing one them to force the instructions it is executing to be
>     complete up to a point - depending on the type of barrier - before
>     continuing past it.

Well, no. You should expect even _less_.

The core can continue doing things past a barrier. For example, a write 
barrier may not actually serialize anything at all: the sane way of doing 
write barriers is to just put a note in the write-queue, and that note 
just disallows write queue entries from being moved around it. So you 
might have a write barrier with two writes on either side, and the writes 
might _both_ be outstanding wrt the core despite the barrier.

So there's not necessarily any synchronization at all on a execution core 
level, just a partial ordering between the resulting actions of the core. 

>     However, on ppc/ppc64, it seems to be more thorough than that, and there
>     seems to be some special interaction between the CPU processing the
>     instruction and the other CPUs in the system. It's not entirely obvious
>     from the manual just what this does.

PPC has an absolutely _horrible_ memory ordering implementation, as far as 
I can tell. The thing is broken. I think it's just implementation 
breakage, not anything really fundamental, but the fact that their write 
barriers are expensive is a big sign that they are doing something bad. 

For example, their write buffers may not have a way to serialize in the 
buffers, and at that point from an _implementation_ standpoint, you just 
have to serialize the whole core to make sure that writes don't pass each 
other. 

>     As I understand it, Andrew Morton is of the opinion that issuing a read
>     barrier on one CPU will cause the other CPUs in the system to sync up, but
>     that doesn't look likely on all archs.

No. Issuing a read barrier on one CPU will do absolutely _nothing_ on the 
other CPU. All barriers are purely local to one CPU, and do not generate 
any bus traffic what-so-ever. They only potentially affect the order of 
bus traffic due to the instructions around them (obviously).

So a read barrier on one CPU _has_ to be paired with a write barrier on 
the other side in order to make sense (although the write barrier can 
obviously be of the implied kind, ie a lock/unlock event, or just 
architecture-specific knowledge of write behaviour, ie for example knowing 
that writes are always seen in-order on x86).

		Linus
