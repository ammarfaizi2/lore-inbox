Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVC0XOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVC0XOo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVC0XOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:14:32 -0500
Received: from alog0049.analogic.com ([208.224.220.64]:9117 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261551AbVC0XOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:14:11 -0500
Date: Sun, 27 Mar 2005 18:13:26 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree()-fs/ext2/
In-Reply-To: <1111913130.6297.24.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503271720040.17365@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <1111913130.6297.24.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Arjan van de Ven wrote:

> On Sat, 2005-03-26 at 18:21 -0500, linux-os wrote:
>> On Sat, 26 Mar 2005, Arjan van de Ven wrote:
>>
>>> On Fri, 2005-03-25 at 17:29 -0500, linux-os wrote:
>>>> Isn't it expensive of CPU time to call kfree() even though the
>>>> pointer may have already been freed?
>>>
>>> nope
>>>
>>> a call instruction is effectively half a cycle or less, the branch
>>
>> Wrong!
>
> oh? a call is "push eip + a new eip" effectively. the new eip is
> entirely free, the push eip takes half a cycle (or 1 full cycle but only
> one of the two/three pipelines).
>
>>
>>> predictor of the cpu can predict perfectly where the next instruction is
>>> from. The extra if() you do in front is a different matter, that can
>>> easily cost 100 cycles+. (And those are redundant cycles because kfree
>>> will do the if again anyway). So what you propose is to spend 100+
>>> cycles to save half a cycle. Not a good tradeoff ;)
>>>
>>
>> Wrong!
>
> Is it wrong that the cpu can predict the target perfectly? No. Unless
> you use function pointers (then it's a  whole different ballgame).
>
>>
>> Pure unmitigated bull-shit. I measure (with hardware devices)
>> the execution time of real code in modern CPUs. I do this for
>> a living so you don't have to stand in line for a couple of
>> hours to have your baggage scanned at the airport.
>
> Ok I used to do this kind of performance work for a living too and
> measuring it to death as well.
>
>> Always, always, a call will be more expensive than a branch
>> on condition.
>
> It is not on modern Out of order cpus.
>
>> It's impossible to be otherwise. A call requires
>> that the return address be written to memory (the stack),
>> using register indirection (the stack-pointer).
>
> and it's a so common pattern that it's optimized to death. Internally a
> call gets transformed to 2 uops or so, one is push eip, the other is the
> jmp (which gets then just absorbed by the "what is the next eip" logic,
> just as a "jmp"s are 0 cycles)
>
>> If somebody said; "I think that the code will look better
>> and the few cycles lost will not be a consequence with modern
>> CPUs...", then there is a point. But coming up with this
>> disingenuous bullshit is something else.
>
> I don't have to take this from you and I don't. You're calling me a liar
> with zero evidence. Lets get some facts straight
> 1) On a modern cpu, a miss of the branch predictor is quite expensive.
>   The entire pipeline needs flushing if this happens, and on a p4 this
>   will be in the order of 50 to 100 cycles at minimum.

No. It depends upon how the branch prediction is done. If there are
two virtual logic-units, one that has already taken the result of
the TRUE condition the other that has already taken the result of
the FALSE condition, then the IP is set to the address of one
or the other, regardless of whatever is taken. Both of these
IPs are already in the cache because the branch logic makes
sure they are before the conditional test occurs. The possible loss
of performance occurs if there is another conditional branch that
must occur before the logic-units pipelines can be refilled.

This can happen if the tests are conducted like:

 	cmpl	$NUMBER, %eax
 	jbe	1f	# First branch	ZF or CF
 	......		# Other code
 	......		# Other code
1:	jc	2f	# Immediate second branch on CF

Most compilers don't produce code like that, but they could.
The loss of performance is only the loss of the branch predictor,
for the second branch.

> 2) absolute "jmp" is free on modern OOO cpus. Instead of taking an
>   actual execution slot, all that happens is that the "what is the next
>   EIP" logic gets a different value. (you can argue what happens if you
>   have a sequence of jmps and that it's not free then, and I'll grant
>   you that, but that corner case is not relevant here)

So? I never even mentioned a jump and, falling through after
a conditional test is not a jump, it's just executing the
next instruction.

> 3) a "call" instruction gets translated into what basically is
>   "push EIP" and "jmp" uops.

No, It can't be on machines that have a "call" instruction.
This is because, in cases where you use the same stack for
access to data, one needs to maintain the coherency of the
stack.  If I call 'kfree', I do:

 	pushl	(pointer)
 	call	kfree
 	addl	$4, %esp	# Sizeof the pointer

... or

 	movl	(pointer), %eax
 	pushl	%eax
 	call	kfree
 	addl	$4, %esp

(pointer) is a memory operand, could be on the stack or in
other data. It is the pointer you want to free.

When kfree() gets called, the value passed __must__ be in its
final place on the stack, which means that the return address
must be there and the stack-pointer value adjusted to its
final resting place. This is necessary so that code will
get the correct values. On ix86, the called function will
find the first passed parameter at 0x04(%esp). The return
address will be at 0x00(%esp).

With the test for NULL, a decent compiler will produce code
like:
 		movl	(pointer), %eax
 		orl	%eax,%eax
 		jz	1f
 		pushl	%eax
 		call	kfree
 		addl	$4, %esp
 	1:

So you add a one-byte instruction and branch on condition.

> 4) modern processors have special logic to optimize push/pop
>   instructions; for example a "push eax ; push ebx" sequence will
>   execute in parallel in the same cycle even though there is a data
>   dependency on esp, the cpu can perfectly predict the esp effect and
>   will do so.

So? BTW, it's not a data-dependency, it's a size of register
dependency. The call-frame optimization can load several
register values onto the stack and adjust the stack-pointer
value only once. That's what the advertising hype is all about.

> 5) modern processors have a call/ret fifo cache they use to do branch
>   prediction for the target of "ret" instructions. Unless you do
>   misbalanced call/ret pairs the prediction will be perfect.
>

The Intel CPUs don't have return-on-condition instructions like
the old Z80 and they don't have call-on-condition. If they did
you wouldn't have to jump around the calls as shown above.

It would be nice to have a call-non-zero instruction.

> Based on this the conclusion "a function call is really cheap versus a
> conditional branch" is justified imo. Now you better come with proof
> about which of the 5 things above I'm totally lying to you or you better
> come with an apology.
>

There is a vast difference between the perception that advertising
hype produces, and the actual hardware designs. At one time, such
hype remained with the definition of megabyte. Now, they have
advertising agencies writing hype about technical buzz-words like
"branch prediction" and some engineers assume that the chip
contains a bunch of wonderful logic that will allow them to write
"pretty" or sloppy code. It just isn't so. There is much logic
that needs to be executed sequentially of else it won't work,
some needs to be coherent only occasionally. Stack operations
aren't in that category. The called procedures really need to
get the correct parameter values.

This whole advertising hype thing is a sore-point with
me because a server-box company went all the way to the
president of this company, trying to get me fired, when
I discovered that their box didn't work. Kill the messenger.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
