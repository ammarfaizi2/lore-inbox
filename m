Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWDYQqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWDYQqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWDYQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:46:13 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:5125 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751618AbWDYQqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:46:12 -0400
Message-ID: <444E524A.10906@argo.co.il>
Date: Tue, 25 Apr 2006 19:46:02 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
In-Reply-To: <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 16:46:08.0123 (UTC) FILETIME=[C0354CB0:01C66887]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Apr 25, 2006, at 03:08:02, Avi Kivity wrote:
>> Kyle Moffett wrote:
>>> The "advantages" of the former over the latter:
>>>
>>> (1)  Without exceptions (which are fragile in a kernel), the former 
>>> can't return an error instead of initializing the Foo.
>> Don't discount exceptions so fast. They're exactly what makes the 
>> code clearer and more robust.
>
> Except making exceptions work in the kernel is exceptionally 
> nontrivial (sorry about the pun).
My experience with exceptions in kernel-like code (a distributed 
filesystem) was excellent.
>
>> A very large proportion of error handling consists of:
>> - detect the error
>> - undo local changes (freeing memory and unlocking spinlocks)
>> - propagate the error/
>>
>> Exceptions make that fully automatic. The kernel uses a mix of gotos 
>> and alternate returns which bloat the code and are incredibly error 
>> prone. See the recent 2.6.16.x for examples.
>
> You talk about code bloat here.  Which of the following fits better 
> into a 4k stack?  
The C++ code. See below.
> Which of the following shows the flow of code better?
Once you accept the idea that an exception can occur (almost) anywhere, 
the C++ code shows you what the code does in the normal case without 
obfuscating it with error handling. Pretend that after every semicolon 
there is a comment of the form:

    /* possible exceptional return */

once you think like that, you can see what the code actually does rather 
than how it handles errors. A 15-line function can do something 
meaningful, not just call two functions.
>
> C version:
>     int result;
>     spin_lock(&lock);
>     
>     result = do_something();
>     if (result)
>         goto out;
>     
>     result = do_something_else();
>     if (result)
>         goto out;
>     
>     out:
>     spin_unlock(&lock);
>     return result;
>
> C++ version:
>     int result;
not needed unless you actually return something.
>     TakeLock l(&lock);
>     
>     do_something();
>     do_something_else();
>
> First of all, that extra TakeLock object chews up stack, at least 4 or 
> 8 bytes of it, depending on your word size.
No, it's optimized out. gcc notices that &lock doesn't change and that 
'l' never escapes the function.
>   Secondly with standard integer error returns you have one or two 
> easily-predictable assembly instructions at each step of the way, 
> whereas with exceptions you trade the absence of error handling in the 
> rest of the code for a lot of extra instructions at the exception 
> throw and catch points.
The extra code is out of line (not even an if (unlikely())). So yes, 
total code grows, but the exceptional paths can be in a .text.exception 
section and not consume cache or TLB space.
>   Secondly, while the former is much longer it shows _explicitly_ 
> exactly where the flow of code can go.  In an OS kernel, that is 
> critical;  your debugability is directly dependent on how easy it is 
> to see where the flow of code is going.
>
I can only say that I had very positive experience with code that used 
exceptions. Having less code to view actually improves visibility.
>>> (2)  You can't control when you initialize the Foo.  For example in 
>>> this code, the "Foo item;" declarations seem to be trivially 
>>> relocatable, even if they're not.
>>>     spin_lock(&foo_lock);
>>>     Foo item1;
>>>     Foo item2;
>>>     spin_unlock(&foo_lock);
>>
>> They only seem relocatable with your C glasses on. Put on your C++ 
>> glasses (much thicker), and initialization no longer seems trivially 
>> movable.
>
> This is a really _really_ bad idea for a kernel.  Having simple 
> declaration statements have big side effects (like the common TakeLock 
> object example I gave above) is bound to lead to people screwing up 
> and forgetting about the side effects.  In C it's impossible to miss 
> the side effects of a statement; function calls are obvious, as is 
> global memory modification.
>
In C++ you just have to treat declarations as executable statements. 
Just as you can't compile the code with a C compiler, you can't read it 
with a C mindset. Once you get used to it, it isn't surprising at all.
>> On the other hand, you can replace the C code
>>
>> {
>>    Foo item1, item2;
>>    int r;
>>
>>    spin_lock(&foo_lock);
>>    if ((r = foo_init(&item1)) < 0) {
>>        spin_unlock(&foo_lock);
>>        return r;
>>    }
>>    if ((r = foo_init(&item2)) < 0) {
>>        foo_destroy(&item1);
>>        spin_unlock(&foo_lock);
>>        return r;
>>    }
>>    foo_destroy(&item2);
>>    foo_destroy(&item1);
>>    spin_unlock(&foo_lock);
>>    return 0;
>> }
>>
>> with
>>
>> {
>>    spinlock_t::guard foo_guard(foo_lock);
>>    Foo item1;
>>    Foo item2;
>> }
>
> Let me point out _again_ how unobvious and fragile the flow of code 
> there is.  Not to mention the fact that the C++ compiler can easily 
> notice that item1 and item2 are never used and optimize them out entirely.
Excellent! If there are no side effects, I want it out. If there are 
side effects, it won't optimize them out.
>   You also totally missed the "int flags" argument you're supposed to 
> pass to object specifying allocation parameters,
There is no allocation here (both the C and the C++ code allocate on the 
stack.

Should you want to allocate from the heap, try this:

{
    spinlock_t::guard g(some_lock);
    auto_ptr<Foo> item(new (gfp_mask) Foo);   /* or pass a kmem_cache_t */
    item->do_something();
    item->do_something_else();
    return item.release();
}
 
contrast with

{
    Foo *item = 0;
    int r;

    spin_lock(&some_lock);
    item = kmalloc(sizeof(Foo), gfp_flags);
    if (!item) {
         item = PTR_ERR(ENOMEM);  
         goto out;
    }
    if ((r = foo_do_something(item))) {
        foo_destroy(item);
        kfree(item);
        item = PTR_ERR(-r);
        goto out;
    }
    if ((r = foo_do_something_else(item))) {
        foo_destroy(item);
        kfree(item);
        item = PTR_ERR(-r);
    }
out:
    spin_unlock(&some_lock);
    return item;
}

(oops, you wrote another version further on...)
> not to mention the fact that you just allocated 2 objects of unknown 
> size on the stack (which is limited to 4k).
So did the C code. I was just side-by-side comparisons of *equivalent* code.
>   AND there's the fact that the order of destruction of foo_guard, 
> item1, and item2 is implementation-defined and can't easily be relied 
> upon without adding massive amounts of excess braces:
It is well defined. guard ctor, item1 ctor, item2 ctor, item2 dtor, 
item1 dtor, guard dtor.

It is also well defined that if a constructor is executed for an 
automatic variable, so will its destructor. That makes the "guard" work 
so well with exceptions.
>
> {
>     spinlock_t::guard foo_guard(&foo_lock);
>     {
>         Foo item1;
>         {
>             Foo item2;
>         }
>     }
> }
>
Absolutely unneeded braces there.
> Also, your spinlock_t::guard chews up stack space that otherwise 
> wouldn't be used.  It would be much better to rewrite your above C 
> function like this:
>
> {
>     struct foo *item1, *item2;
>     int result;
>     spin_lock(&foo_lock);
>     
>     item1 = kmalloc(sizeof(*item1), GFP_KERNEL);
>     item2 = kmalloc(sizeof(*item2), GFP_KERNEL);
>     if (!item1 || !item2)
>         goto out;
>     
>     result = foo_init(item1, GFP_KERNEL);
>     if (result)
>         goto out;
>     
>     result = foo_init(item2, GFP_KERNEL);
>     if (result)
>         goto out;
>     
> out:
>     /* If alloc and init went ok, register them */
>     if (item1 && item2 && !result) {
>         result = register_foo_pair(item1, item2);
>     }
>     
>     /* If anything failed, free resources */
>     if (!item1 || !item2 || result) {
>         kfree(item1);
>         kfree(item2);
>     }
>     
>     spin_unlock(&foo_lock);
>     return result;
> }
>
>> 14 lines vs 3, one variable eliminated. How many potential security 
>> vulnerabilities? How much time freed to work on the algorithm/data 
>> structure, not on error handling?
>
> Yeah, sure, yours is 3 lines when you omit the following:
> (1)  Handling allocation flags like GFP_KERNEL
done
> (2)  Not allocating things on the stack
done
> (3)  Proper cleanup ordering
done, without lifting a finger
> (4)  Reference counting, garbage collection, or another way to 
> selectively free the allocated objects based on success or failure of 
> other code.
Reference counting is ridiculously to do in C++. I'll spare you the details.
>
> Those are all critical things that we want to force people to think 
> about; in many cases the exact ordering of operations _is_ important 
> and that needs to be specified _and_ commented on.  How often do you 
> think people write comments talking about things that don't even 
> appear in the source code?
C++ preserves the order (unless it can prove the order doesn't matter, 
same as C)
>
> Also, since when is error handling _not_ a critical part of the 
> algorithm?  You can see in my more complicated example that you only 
> want to free the items if the registration was unsuccessful.  How do 
> you handle that without adding a refcount to everything (bloat) or 
> implementing garbage collection (worse bloat).
Use auto_ptr<>.

Yes, error handling is critical. That's why I want language help. Just 
like I don't want to:
- calculate the carry for 64 bit addition on a 32 bit machine
- calculate structure offsets for structs (even though struct layout is 
important)

I faced exactly these problems (fibre channel and ethernet cables pulled 
out during I/O) and C++ made error handling easier, not more difficult.

>
>>> Does that actually make it any easier to understand the code?  How 
>>> does it make it more obvious to be able to write a "+" operator that 
>>> allocates memory?
>>
>> Not all C++ features need to be used in the kernel. In fact, not all 
>> C++ features need to be used, period. Ever tried to understand code 
>> which uses overloaded operator,() (the comma operator)?
>
> The very fact that the language provides such features mean that 
> people would try to get code using them into the kernel.  Have you 
> ever looked at all the ugly debugging macros that various people use?  
> The C preprocessor provides few features at all, and yet people still 
> abuse those, I don't see why C++ would be any different.
Probably not. I agree C++ is much more abusable.

BTW, under C++ preprocessor abuse drops significantly as it can be 
replaced by safer and cleaner constructs.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

