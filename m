Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWEBOl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWEBOl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWEBOl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:41:26 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:64526 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964853AbWEBOlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:41:25 -0400
Message-ID: <44576F8B.7000206@argo.co.il>
Date: Tue, 02 May 2006 17:41:15 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502132139.GA16647@w.ods.org>
In-Reply-To: <20060502132139.GA16647@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 14:41:17.0523 (UTC) FILETIME=[785AB230:01C66DF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> It would be the exact same problem I discribed above. If nobody understand
> what it does, or if people need some deep thoughts to guess its behaviour,
> the result will be negative. Currently, everyone can read the kernel code.
> I was a terrible looser in C 11 years ago when I first looked at it, but I
> did not need specific knowledge of implicit things that the kernel does to
> understand what the code did, and to propose patches.
>
>   

11 years ago the kernel was _way_ simpler.

These days, you need to know that you can't call schedule() (or any 
function which may sleep -- why is that not implicit) within spin locks. 
You need to understand per-cpu variables, initcalls, rcu, memory 
barriers, reference counting, and lots of other "infrastructure" details 
that are engraved into your brain but not accessible to a newbie. Most 
of these (except perhaps reference counting) cannot be understood from 
looking at the code.

C++ allows you to add even more infrastructure, by providing support for 
patterns that can't be done in C. So yes, that adds more to the 
vocabulary you have to learn by heart but once you're over that the code 
is _more_ readable, more maintainable.

> Right now, lots of newbies review the code and find bugs. If you write it
> in a language such as above, it will quickly end up like the BSD kernels,
> with a small very competent core team and lots of newbies around them.
>
>   

C++ knowledge is now fairly widespread, I believe.

> I don't know, what I can say is that they were people who regularly discuss
> the kernel semantics on other threads. That's what matters. Those people are
> good at finding kernel bugs and proposing interesting algorithms, it's a shame
> that they had to discuss langage semantics on 5 lines of code !
>   

I'm sorry to have wasted their time. But surely you understand these 
things once and then move on? Like when someone proposes a new function 
to replace repeated code, there's argument about it's name, coding 
style, and hopefully about the content. The people replace the 
open-coded sequence with the new function.

It's the same here at a slightly higher level. You argue what s spinlock 
guard should look like, whether it's optimal or not, and then you can 
use it where applicable and avoid those gotos or code duplications for 
error cases.

 

>
> I seems like pro-C++ people constantly tell the other ones "look, C++ can
> code for you so that you won't have to worry about boring parts. Of coure,
> if you need to know, you're still able to write is the old way". Since we
> always want to know, I guess we'd use the C++ compiler (the slow one), with
> pure-C code borrowing nothing from the C++ language. That would only be a
> pure loss.
>   

It's not "if you need to know", it's "if you want to break the rules".

For example, the spinlock guard thingie allows you to say, "please 
spin_unlock this spinlock for me, whichever way I return from this 
function". There is no knowledge taken away, you know exactly what it 
will do and when; only the code is made clearer.

But if you want the function to lock but not unlock, or do the 
atomic_dec_and_lock() thing, or do lock reordering to avoid ABBA 
deadlocks, or whatever, the primitives are still there.

These constructs allow you to make simple things simple (and automatic) 
but don't take away the complex things.

(example, for context:

{
    spinlock_guard guard(some_lock);
    if (x)
        return -ESOMETHING;
    blah();
    return 0;
}   

there is nothing implicit once you know spinlock_guard)


>> No, they want not to repeat code and code patterns. It's the same 
>> motivation that lead to the invention of functions:
>>
>> - functions allow you to reuse code instead of open-coding common 
>> sequences
>> - constructors/destructors allow you to reuse the do/undo (lock/unlock, 
>> etc.) pattern without writing it in full every time
>> - templates allow you to reuse code even when the data types change 
>> (like the preprocessor but not limited to linked lists)
>> - virtual functions allow you to dispatch a function based on the 
>> object's type, without writing the boilerplate casting
>> - exceptions allow you to do the detect error/undo partial 
>> modifications/propagate error thing without blowing up the code by a 
>> factor of five
>>
>> It's just shorthand: but shorthand allows you to see what the code is 
>> doing instead of how it handles all the standard problems that occur 
>> again and again in programming.
>>     
>
> I'm still not convinced. Every time I came across C++ code, it was an immense
> unreadable crap (indentation, cAmEl case, "funny" operators which you have to
> stop at because you need a few seconds of thought before confusing them with
> others, etc...). Code that cannot be read at 3am. If you want a good example
> of this, download and read p7zip. It does lots of magic^Wimplicit things which
> quickly got me lost. I agree, I'm not a C++ developper. But many language are
> slightly understandable to non-fellows, and this one looks really nasty.
>   

I agree - I've seen it done many times. C++ has the potential for a lot 
of nastiness, and what is more, it seems to bring out the worst in 
people. We would definitely need an Al Viro for C++ if the kernel were 
to be ported.

I've yet to find a language that combines low level access, efficiency, 
cleanliness, and expressive power.

> You told us examples of programs you have written. If this is true, I have
> a lot of respect for this, because it still seems impossible to me. I
> understand they were closed source, but if you come across open source
> kernel code that is readable by newbies, I think many people would be
> interested to get a clue.
>   

I posted an example of do_sendfile() as it might be incrementally converted.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

