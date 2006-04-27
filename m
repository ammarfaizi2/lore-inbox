Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWD0IH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWD0IH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWD0IH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:07:28 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:10244 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964887AbWD0IH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:07:26 -0400
Message-ID: <44507BB9.7070603@argo.co.il>
Date: Thu, 27 Apr 2006 11:07:21 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org> <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com> <445026EB.8010407@yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com>
In-Reply-To: <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 08:07:24.0347 (UTC) FILETIME=[9DD178B0:01C669D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
>>>
>>> And that breaks a _massive_ amount of kernel code, including such 
>>> core functionality like SPIN_LOCK_UNLOCKED and a host of others.  
>>> There are all sorts of macros that use member initialization of that 
>>> form.
>>
>> This does not break the code at run time, this breaks the code at 
>> compile time, and should be less painful.
>
> So breaking 90% of the source code at compile time is ok?  I think 
> not.  The kernel relies really _really_ heavily on such structure 
> initializers, and breaking them would effectively break the world as 
> far as the kernel is concerned.
>

Since we're now discussing how to effectively port the kernel to C++, 
I'd suggest getting g++ to accept these structure initializers, and move 
them incrementally to standard C++ code.

Should be similar to the conversion to C99 initializers.

>>
>> I agree, it would be a bad idea to compile the existing C code by 
>> g++.  The good idea is to be able to produce new C++ modules etc.
>
> No, this is a reason why C++ modules are _not_ a good idea.  If you 
> could write the module in C or C++, but in C++ it compiled 100-200% 
> slower, then you would write it in C.  Why?  A simple matter of numbers:
>
> Say it takes you 100 hours to write and debug the module in C++, and 
> 140 to write and debug it in C.  I estimate that at least 200,000 
> people would download and compile a single version of the kernel with 
> your module (not an unreasonable estimate).  Note that I'm not even 
> including the people who do repeated regression testing of versions, 
> or people who download and compile multiple versions of the kernel.   
> If the source file takes an average of 1.0 seconds to compile in C and 
> 2.0 seconds to compile in C++, then:
>
> (2.0 sec - 1.0 sec) * 200,000 = 200,000 seconds = 55.6 hours
> 140 hours - 100 hours = 40 hours
> 40 hours < 55.6 hours
>
> So for a single version of the kernel your module, you've already 
> wasted 15.6 hours of time across people using it.  Over time that 
> number is just going to grow, _especially_ if people start writing 
> more and more modules in C++ because they can.  If you want to build 
> C++ in the kernel, write a compiler that does not include all the 
> problematic C++ features that add so much parsing time (overloaded 
> operators, etc).
>
>

It looks like you don't value your time much. You're comparing human 
time (yours!) to machine time.

If we accept your 1.4 C++ vs C factor, then these 200,000 people would 
be compiling 2.6.24 instead of 2.6.16.12.

(Of course, not all code benefits equally from C++. I'd guess the VM 
internals wouldn't benefit as much, filesystems and drivers benefiting a 
lot).

C++ compilation isn't slower because the compiler has to recognize more 
keywords. It's slower because it is doing more for you: checking types 
(C++ code is usually free of void *'s except for raw data) and expanding 
those 4-line function to their 14-line goto-heavy equivalents.


>>
>> You mentioned a bad example. The struct list_head has [almost?] all 
>> "members" inlined. If they were not, one could simply make a base 
>> class having [some] members outlined, and which class does not 
>> enforce type safety and is for inheritance only.  The template class 
>> would then inherit the base one enforcing type safety by having 
>> inline members. This technique is well known, trust me. If you need 
>> real life examples, tell me.
>
> Ok, help me understand here:  Instead of helping using one sensible 
> data structure and generating optimized code for that, the language 
> actively _encourages_ you to duplicate classes and interfaces, 
> providing even _more_ work for the compiler, making the code harder to 
> debug, and probably introducing inefficiencies as well.  If C++ 
> doesn't work properly for a simple and clean example like struct 
> list_head, why should we assume that it's going to work any better for 
> more complicated examples in the rest of the kernel?  Whether or not 
> some arbitrary function is inlined should be totally orthogonal to 
> adding type-checking.

C++ works excellently for things like list_head. The generated code is 
as efficient or better that the C equivalent, and the API is *much* 
cleaner. You can iterate over a list without knowing the name of the 
field which contains your list_head (and possibly getting it wrong if 
there is more than one).


>>
>> For #defines core_initcall() ... late_initcall() I would type 
>> something like this:
>>     class foo_t { foo_t(); ~foo_t(); }
>>     static char foo_storage[sizeof(foo_t)];
>>     static foo_t& foo=*reinterpret_cast<foo_t*>(foo_storage);
>>     static void __init foo_init() { new(foo_storage) foo_t; }
>>     core_initcall(foo_init);
>>
>> This ugly-looking code can be nicely wrapped into a template, which, 
>> depending on the type (foo_t in this case), at compile time, picks 
>> the proper stage for initialization.
>
> You proved my point.  Static constructors can't work.  You can add 
> silly wrapper initcall functions which create objects in static memory 
> at various times, but the language-defined static constructors are yet 
> another C++ feature that doesn't work by default and has to be hacked 
> around.  C++ gives us no advantage over C here either.  Plus this 
> would break things like static spinlock initialization.  How would you 
> make this work sanely for this static declaration:
>
> spinlock_t foo_lock = SPIN_LOCK_UNLOCKED;
>
> Under C that turns into (depending on config options):
>
> spinlock_t foo_lock = { .value = 0, .owner = NULL, (...) };
>
> How could that possibly work in C++ given what you've said?  Anything 
> that breaks code that simple is an automatic nonstarter for the 
> kernel.  Also remember that spinlocks are defined preinitialized at 
> the very earliest stages of init.  Of course I probably don't have to 
> say that anything that tries to run a function to iterate over all 
> statically-allocated spinlocks during init would be rejected out of hand.
>

Why would it be rejected?

A static constructor is just like a module init function. Why are 
modules not rejected out of hand?


-- 
error compiling committee.c: too many arguments to function

