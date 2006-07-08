Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWGHSxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWGHSxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWGHSxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:53:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964960AbWGHSx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:53:29 -0400
Date: Sat, 8 Jul 2006 11:53:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <44AF532B.4050504@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0607081125440.3869@g5.osdl.org>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
 <Pine.LNX.4.64.0607072222540.3869@g5.osdl.org> <44AF532B.4050504@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Nick Piggin wrote:
> 
> The volatile casting in atomic_* and *_bit seems to be a good idea
> (now that I think about it) [1].
> 
> Because if you had a barrier there, you'd have to reload everything
> used after an atomic_read or set_bit, etc.

Yes and no. The problem _there_ is that we use the wrong inline asm 
constraints.

The "+m" constraint is basically undocumented, and while I think it has 
existed _internally_ in gcc for a long time (gcc inline asms are actually 
fairly closely related to the internal gcc code generation templates, but 
the internal templates generally have capabilities that the inline asms 
don't have), I don't think it has been actually supported for inline asms 
all that time.

But "+m" means "I will both read and write from this memory location", 
which is exactly what we want to have for things like atomic_add() and 
friends.

However, because it is badly documented, and because it didn't even exist 
long ago, we have lots of code (and lots of people) that doesn't even 
_know_ about "+m". So we have code that fakes out the "both read and 
write" part by marking things either volatile, or doing 

	...
	:"=m" (*ptr)
	:"m" (*ptr)
	...

in the constraints (or, in many cases, both).

> [1] Even though I still can't tell the exact semantics of these
>     operations eg. why do we need volatile at all? why do we have
>     volatile in the double underscore (non-atomic) versions?

So we tend to have "volatile" for a couple of different reasons:

 - the above kind of "we couldn't tell the inline assembly well enough 
   what the instruction actually _does_, so we just tell gcc to not mess 
   with it".

   This _generally_ should be replaced with using "+m", so that gcc just 
   knows that we both read and write to the location, and that allows gcc 
   to generate the best possible code, while still generating _correct_ 
   code because gcc knows what is going on and doesn't think the write 
   totally clobbers the old value.

 - many functions are used with random data, and if the caller has a 
   "volatile long array[]" (bad - but hey, it happens), then a function 
   that _acts_ on that array, like the bitops functions, need to take a
   an argument like "volatile long *".

   So for example, "test_bit()", which can act both on volatile arrays 
   _and_ on const arrays, will look like

	int test_bit(int nr, const volatile void * addr);

   which some people think is strange ("Both 'const' _and_ 'volatile'? 
   Isn't that a contradiction in terms?"), but the fact is, it reflects 
   the different callers, not necessarily test_bit() itself.

 - some functions actually really want the volatile access. The x86 IO 
   functions are the best actual example of this:

	static inline unsigned int readl(const volatile void __iomem *addr)
	{
		return *(volatile unsigned int __force *) addr;
	}

   which actually has a _combination_ of the above reason (the incoming 
   argument is already marked "volatile" just because the _caller_ may 
   have marked it that way) and the cast to volatile would be there 
   _regardless_ of the calling convention "volatile", because in this case 
   we actually use it as a way to avoid inline assembly (which a number of
   other architectures need to do, and which x86 too needs to do for the 
   PIO accesses, but we can avoid it in this case)

So those are all real reasons to use volatile, although the first one is 
obviously a case where we no longer should (but at least we have 
reasonably good historical reasons for why we did).

The thing to note that is all of the above reasons are basically 
"volatile" markers on the _code_. We haven't really marked any _data_ 
volatile, we're just saying that certain _code_ will want to act on 
the data in a certain way.

And I think that's generally a sign of "good" use of volatile - it's 
making it obvious that certain specific _use_ of a data may have certain 
rules. 

As mentioned, there is _one_ case where it is valid to use "volatile" on 
real data: it's when you have a "I don't care about locking, and I'm not 
accessign IO memory or something else that may need special care" 
situation.

In the kernel, that _one_ special case used to basically be the "jiffies" 
counter. There's nothing to "lock" there - it just keeps ticking. And it's 
still obviously normal memory, so there's no question about any special 
rules for accesses. And there are no SMP memory ordering issues for 
reading it (for the low bits), since the "jiffies" counter is not really 
tied to anything else, so there are no larger "coherency" rules either.

So in that ONE case, "volatile" is actually fine. We really don't care if 
we read the old value or the new value when it changes, and there's no 
reason to try to synchronize with anythign else. 

There _may_ be some other cases where that would be true, but quite 
frankly, I can't think of any. If the CPU were to have a built-in random 
number generator mapped into memory, that would fall under the same kind 
of rules, but that's basically it.

One final word: in user space, because of how signal handlers work, 
"volatile" can still make sense for exactly the same reasons that 
"jiffies" makes sense in the kernel. You may, for example, have a signal 
handler that updates some flag in memory, and that would basically look 
exactly like the "jiffies" case for your program. 

(In fact, because signals are very expensive to block, you may have more 
of a reason to use a "jiffies" like flag in user space than you have in 
kernel. In the kernel, you'd tend to use a spinlock to protect things. In 
user space, with signals, you may have to use some non-locking algorithm, 
where the generation count etc migth well look like "jiffies").

			Linus
