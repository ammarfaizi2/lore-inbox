Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWD0DhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWD0DhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWD0DhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:37:10 -0400
Received: from smtpout.mac.com ([17.250.248.185]:38128 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932412AbWD0DhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:37:08 -0400
In-Reply-To: <445026EB.8010407@yahoo.com>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org> <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com> <445026EB.8010407@yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: C++ pushback
Date: Wed, 26 Apr 2006 23:37:05 -0400
To: Roman Kononov <kononov195-far@yahoo.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2006, at 22:05:31, Roman Kononov wrote:
> Kyle Moffett wrote:
>> On Apr 26, 2006, at 19:00:52, Roman Kononov wrote:
>>> Linus Torvalds wrote:
>>>>  - some of the C features we use may or may not be usable from C+ 
>>>> +    (statement expressions?)
>>>
>>> Statement expressions are working fine in g++. The main  
>>> difficulties are:
>>>    - GCC's structure member initialization extensions are syntax
>>>      errors in G++: struct foo_t foo={.member=0};
>>
>> And that breaks a _massive_ amount of kernel code, including such  
>> core functionality like SPIN_LOCK_UNLOCKED and a host of others.   
>> There are all sorts of macros that use member initialization of  
>> that form.
>
> This does not break the code at run time, this breaks the code at  
> compile time, and should be less painful.

So breaking 90% of the source code at compile time is ok?  I think  
not.  The kernel relies really _really_ heavily on such structure  
initializers, and breaking them would effectively break the world as  
far as the kernel is concerned.


>>> G++ compiling heavy C++ is a bit slower than gcc. The g++ front  
>>> end is reliable enough. Do you have a particular bug in mind?
>>
>> A lot of people would consider the "significantly slower" to be a  
>> major bug.  Many people moaned when the kernel stopped supporting  
>> GCC 2.x because that compiler was much faster than modern C  
>> compilers.  I've seen up to a 3x slowdown when compiling the same  
>> files with g++ instead of gcc, and such would be unacceptable to a  
>> _lot_ of people on this list.
>
> I agree, it would be a bad idea to compile the existing C code by g+ 
> +.  The good idea is to be able to produce new C++ modules etc.

No, this is a reason why C++ modules are _not_ a good idea.  If you  
could write the module in C or C++, but in C++ it compiled 100-200%  
slower, then you would write it in C.  Why?  A simple matter of numbers:

Say it takes you 100 hours to write and debug the module in C++, and  
140 to write and debug it in C.  I estimate that at least 200,000  
people would download and compile a single version of the kernel with  
your module (not an unreasonable estimate).  Note that I'm not even  
including the people who do repeated regression testing of versions,  
or people who download and compile multiple versions of the kernel.    
If the source file takes an average of 1.0 seconds to compile in C  
and 2.0 seconds to compile in C++, then:

(2.0 sec - 1.0 sec) * 200,000 = 200,000 seconds = 55.6 hours
140 hours - 100 hours = 40 hours
40 hours < 55.6 hours

So for a single version of the kernel your module, you've already  
wasted 15.6 hours of time across people using it.  Over time that  
number is just going to grow, _especially_ if people start writing  
more and more modules in C++ because they can.  If you want to build C 
++ in the kernel, write a compiler that does not include all the  
problematic C++ features that add so much parsing time (overloaded  
operators, etc).


>>> A lot of C++ features are already supported sanely. You simply  
>>> need to understand them. Especially templates and type checking.
>>
>> First of all, the only way to sanely use templated classes is to  
>> write them completely inline, which causes massive bloat.  Look at  
>> the kernel "struct list_head" and show me the "type-safe C++" way  
>> to do that.  It uses a templated inline class, right?  That  
>> templated inline class gets duplicated for each different type of  
>> object put in a linked list, no?  Think about how many linked  
>> lists we have in the kernel and tell me why that would be a good  
>> thing.
>
> You mentioned a bad example. The struct list_head has [almost?] all  
> "members" inlined. If they were not, one could simply make a base  
> class having [some] members outlined, and which class does not  
> enforce type safety and is for inheritance only.  The template  
> class would then inherit the base one enforcing type safety by  
> having inline members. This technique is well known, trust me. If  
> you need real life examples, tell me.

Ok, help me understand here:  Instead of helping using one sensible  
data structure and generating optimized code for that, the language  
actively _encourages_ you to duplicate classes and interfaces,  
providing even _more_ work for the compiler, making the code harder  
to debug, and probably introducing inefficiencies as well.  If C++  
doesn't work properly for a simple and clean example like struct  
list_head, why should we assume that it's going to work any better  
for more complicated examples in the rest of the kernel?  Whether or  
not some arbitrary function is inlined should be totally orthogonal  
to adding type-checking.

>>> Static constructor issue is trivial.
>>
>> How so?  When do you want the static constructors to be run?   
>> There are many different major stages of kernel-level  
>> initialization; picking one is likely to make them useless for  
>> other code.
>
> For #defines core_initcall() ... late_initcall() I would type  
> something like this:
> 	class foo_t { foo_t(); ~foo_t(); }
> 	static char foo_storage[sizeof(foo_t)];
> 	static foo_t& foo=*reinterpret_cast<foo_t*>(foo_storage);
> 	static void __init foo_init() { new(foo_storage) foo_t; }
> 	core_initcall(foo_init);
>
> This ugly-looking code can be nicely wrapped into a template,  
> which, depending on the type (foo_t in this case), at compile time,  
> picks the proper stage for initialization.

You proved my point.  Static constructors can't work.  You can add  
silly wrapper initcall functions which create objects in static  
memory at various times, but the language-defined static constructors  
are yet another C++ feature that doesn't work by default and has to  
be hacked around.  C++ gives us no advantage over C here either.   
Plus this would break things like static spinlock initialization.   
How would you make this work sanely for this static declaration:

spinlock_t foo_lock = SPIN_LOCK_UNLOCKED;

Under C that turns into (depending on config options):

spinlock_t foo_lock = { .value = 0, .owner = NULL, (...) };

How could that possibly work in C++ given what you've said?  Anything  
that breaks code that simple is an automatic nonstarter for the  
kernel.  Also remember that spinlocks are defined preinitialized at  
the very earliest stages of init.  Of course I probably don't have to  
say that anything that tries to run a function to iterate over all  
statically-allocated spinlocks during init would be rejected out of  
hand.

Cheers,
Kyle Moffett

