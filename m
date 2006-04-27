Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWD0O2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWD0O2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWD0O17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:27:59 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:29966 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S965028AbWD0O17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:27:59 -0400
Message-ID: <4450D4E9.4050606@argo.co.il>
Date: Thu, 27 Apr 2006 17:27:53 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua>
In-Reply-To: <200604271655.48757.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 14:27:56.0581 (UTC) FILETIME=[C6E3E550:01C66A06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 27 April 2006 11:07, Avi Kivity wrote:
>   
>> C++ compilation isn't slower because the compiler has to recognize more 
>> keywords. It's slower because it is doing more for you: checking types 
>> (C++ code is usually free of void *'s except for raw data) and expanding 
>>     
> Today's C is much better at typechecking than ancient K&R C.
>   

It still can't typecheck void pointers. With C++ they're very rare.

Look at the contortions needed to get the min() macro to be typesafe.

>> those 4-line function to their 14-line goto-heavy equivalents.
>>     
>
> Where do you see goto-heavy code in kernel?
>
>   

[avi@cleopatra linux]$ grep -rw goto . | wc -l
37448

Repeat without 'wc' to get a detailed listing.

>> C++ works excellently for things like list_head. The generated code is 
>> as efficient or better that the C equivalent,
>>     
>
> "or better" part is pure BS, because there is no magic C++ compiler
> can possibly do which is not implementable in C.
>
>   

For list_head, no. But coding more complex data structures as type-safe 
macros is not practicable.

As an example, you can easily get C++ to inline the hash function in a 
generic hashtable or the compare in a sort. I dare you to do it in C.

> "as efficient", hmmm, let me see... gcc 3.4.3, presumably an contemporary
> C++ compiler, i.e. which is "rather good".
>   

4.1.0 is the latest.

> Random example. gcc-3.4.3/include/g++-v3/bitset:
>   

You're looking at a library while we were talking about the language and 
compiler. But anyway.

>   template<size_t _Nw>
>     struct _Base_bitset
>     {
>       typedef unsigned long _WordT;
>
>       /// 0 is the least significant word.
>       _WordT            _M_w[_Nw];
>
>       _Base_bitset() { _M_do_reset(); }
> ...
>       void
>       _M_do_set()
>       {
>         for (size_t __i = 0; __i < _Nw; __i++)
>           _M_w[__i] = ~static_cast<_WordT>(0);
>       }
>       void
>       _M_do_reset() { memset(_M_w, 0, _Nw * sizeof(_WordT)); }
> ...
>
> A global or static variable of _Base_bitset or derived type
> would need an init function?! Why not just preset sequence of
> zeroes in data section?
>   

I wouldn't count startup time as efficiency, unless you have several 
million global bitset objects.

> [this disproves that C++ is very efficient]
>   

Add a constructor which does not touch the data members, and the data 
will (probably) end up in .bss.

> Why _M_do_set() doesn't use memset()?
>   

Patches accepted :)

It's just a library, you're free to optimize it. I'd guess that 
_M_do_set() is very rarely called, and that the performance difference 
is small anyway.

> Why _M_do_reset() is not inlined?
>   

It is inlined. Why do you think it is not?

> [this disproves that today's C++ libs are well-written]?
>
>   

Certainly, one can't claim that all C++ libraries are will written. But 
gcc library mostly is.

Again, if you don't like some library, don't use it. The kernel would 
use its own version anyway since it has to be freestanding.

>> and the API is *much*  
>> cleaner. You can iterate over a list without knowing the name of the 
>> field which contains your list_head (and possibly getting it wrong if 
>> there is more than one).
>>     
>
> But kernel folks tend to *want to know* everything, including
> names of the fields.
>   

The names of the fields are not hidden. You just don't have to 
mindlessly repeat them.

The 'know everything' argument seems to apply equally well to ordinary 
functions: "I *must know* about calls to schedule() and those expensive 
atomic operations, don't hide them behind mutex_lock()!"

>>> How could that possibly work in C++ given what you've said?  Anything 
>>> that breaks code that simple is an automatic nonstarter for the 
>>> kernel.  Also remember that spinlocks are defined preinitialized at 
>>> the very earliest stages of init.  Of course I probably don't have to 
>>> say that anything that tries to run a function to iterate over all 
>>> statically-allocated spinlocks during init would be rejected out of hand.
>>>       
>> Why would it be rejected?
>>
>> A static constructor is just like a module init function. Why are 
>> modules not rejected out of hand?
>>     
>
> Because we do not like init functions which can be eliminated.
> That's bloat.

I'm sure you can eliminate them if you want, but working to remove some 
microseconds of boot time is a complete waste of effort IMO.

-- 
error compiling committee.c: too many arguments to function

