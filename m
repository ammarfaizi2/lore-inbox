Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWDYUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWDYUYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWDYUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:24:15 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:59146 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751445AbWDYUYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:24:14 -0400
Message-ID: <444E8562.1040000@argo.co.il>
Date: Tue, 25 Apr 2006 23:24:02 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <4C4500F3-3A8E-4992-82FD-6E16257676CC@mac.com>
In-Reply-To: <4C4500F3-3A8E-4992-82FD-6E16257676CC@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 20:24:07.0025 (UTC) FILETIME=[33D75E10:01C668A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
>>
>> My experience with exceptions in kernel-like code (a distributed 
>> filesystem) was excellent.
>
> Well from all of the discussions about it that occurred on this list, 
> the biggest problem with exceptions in the kernel was the overhead to 
> keep track of the exception state and the try/catch stack.  
There is zero runtime overhead. In fact, code using exceptions is faster 
than the equivalent code using error returns.
> The other problem was handling exceptions in atomic contexts,
Can you elaborate? I don't see any special handling needed.
> in the guts of the scheduler,
That may or may not be tricky. The filesystem I worked on had it's own 
scheduler (in C++ :) but it was orders of magnitude simpler than the 
Linux scheduler.

I suspect thread creation and context switching need special handling, 
but I don't think the computational code needs anything.
> and in a host of other hot-paths.
The hotter the merrier!
>
>>> Which of the following shows the flow of code better?
>>
>> Once you accept the idea that an exception can occur (almost) anywhere
>
> Except they can't.  Lots and lots of bits of kernel code explicitly 
> depend on the fact that certain operations _cannot_ fail, and they 
> make that obvious through the fact that those functions don't have any 
> way of returning error conditions.
You can do that in C++ by indicating a function doesn't throw:

    void f() throw();
>
>> the C++ code shows you what the code does in the normal case without 
>> obfuscating it with error handling. Pretend that after every 
>> semicolon there is a comment of the form:
>>    /* possible exceptional return */
>
> As I pointed out before and seem doomed to point out again, this is an 
> _implicit_ piece of code, and in kernels implicit code is very very 
> bad.  Because of the varying contexts and close hardware dependence, 
> you want to explicitly state everything that happens.
This is possibly the core of our disagreement. I find that explicitly 
repeating the same code over and over again detracts from understanding.

And I disagree that proximity to hardware affects anything. I've written 
complete bringup code (from CPU reset to GUI) in C++ (in another 
life...). There is no problem programming memory controller registers 
and taking interrupts in C++.
>
>>> First of all, that extra TakeLock object chews up stack, at least 4 
>>> or 8 bytes of it, depending on your word size.
>>
>> No, it's optimized out. gcc notices that &lock doesn't change and 
>> that 'l' never escapes the function.
>
> GCC does not notice that when you use out-of-line functions.  Let me 
> remind you that many of the kernel's spinlocks and other functions are 
> out-of-line, inlining them has significant performance penalties.
Keep spin_lock() out of line and let spinlock_guard's constructor and 
destructor remain inline. Zero code size or performance hit.
>
>>> Secondly with standard integer error returns you have one or two 
>>> easily-predictable assembly instructions at each step of the way, 
>>> whereas with exceptions you trade the absence of error handling in 
>>> the rest of the code for a lot of extra instructions at the 
>>> exception throw and catch points.
>>
>> The extra code is out of line (not even an if (unlikely())). So yes, 
>> total code grows, but the exceptional paths can be in a 
>> .text.exception section and not consume cache or TLB space.
>
> Total bull.  Let me give you an example.  The following C++ code:
> {
>     Foo my_foo;
>     function_that_throws_exception();
> }
>
> Is turned by the compiler into a slight variant on this C code:
> {
>     Foo my_foo = Foo();
>     jmp_buf exception;
>     if (setjmp(exception))
>         goto out;
>     
>     function_that_throws_exception();
>     
> out:
>     ~Foo(&my_foo);
> }
>
> There is nothing about the above that the compiler can trivially 
> "out-of-line", not to mention the fact that you just royally screwed 
> the CPUs chances of getting branch prediction right.  There's the fact 
> that setjmp and longjmp are kind of hard in kernelspace.  Finally, the 
> stack usage is significantly increased, I think even in userspace, 
> jmp_buf occupies 8 longs (32 bytes) just for critical registers and 
> instruction pointer of the exception handler.  Also, the simplest case 
> of throwing an exception has turned from the three instructions "cmp 
> bnz ret" (compare result or pointer, branch to exception code, return) 
> to this mess:
> {
>     longjmp((int)pointer);
> }
>
> The longjmp function is simple, but not _that_ simple, and it still 
> breaks branch prediction in a bad way.
setjmp()/longjmp() (or equivalents) are not used for exception handling 
on Linux.

what _actually_ happens is that when an exception is thrown, the 
exeption handling mechanism rolls back the stack and figures out the 
program counter where we're due to return, and consults an out-of-line 
table which tells it which destructors to execute. Something like this:

{
    Foo my_foo = Foo();
e1:
   function_that_throws_exception();
e2:
   my_foo.~Foo();
}

/* begin out-of-line code */
exception_table[] = {
    [e1] : h1
    [e2]: h2
}

{
h2:
    my_foo.~Foo();
h1:
}
>>
>> In C++ you just have to treat declarations as executable statements. 
>> Just as you can't compile the code with a C compiler, you can't read 
>> it with a C mindset. Once you get used to it, it isn't surprising at 
>> all.
>
> That's all well and good, until you assume that "some_type foo = 3;" 
> is just declaring an integer through a typedef instead of declaring an 
> object with side effects.  The thing about the linux kernel is that 
> basically _nobody_ understands all of it, and as a result each and 
> every bit of code must stand on its own and be fairly obvious as to 
> side effects and such.  In C++, most of the language features are 
> designed to _hide_ those side effects and as a result it's a terrible 
> fit for the kernel.
>
So don't assume it, or forbid (through CodingStyle) constructors with 
single integer parameters.
>>> Let me point out _again_ how unobvious and fragile the flow of code 
>>> there is.  Not to mention the fact that the C++ compiler can easily 
>>> notice that item1 and item2 are never used and optimize them out 
>>> entirely.
>>
>> Excellent! If there are no side effects, I want it out. If there are 
>> side effects, it won't optimize them out.
>
> How can it tell?  You aren't writing all your member functions inline, 
> are you?
When they're empty, sure. Or when they're one liners. Or when I know 
they have no side effects.

This isn't any different from C or existing kernel practice.
>
>>>   You also totally missed the "int flags" argument you're supposed 
>>> to pass to object specifying allocation parameters,
>>
>> There is no allocation here (both the C and the C++ code allocate on 
>> the stack.
>
> Let's look in the kernel.  How often do you find non-trivial 
> constructor functions that _don't_ allocate memory, hm?
So it was a bad example. The point is it was much simpler compared to 
the equivalent C. And the more complex it gets, the more pronounced the 
difference is.
>
>> Should you want to allocate from the heap, try this:
>>
>> {
>>    spinlock_t::guard g(some_lock);
>>    auto_ptr<Foo> item(new (gfp_mask) Foo);   /* or pass a 
>> kmem_cache_t */
>>    item->do_something();
>>    item->do_something_else();
>>    return item.release();
>> }
>
> I think this code speaks for itself about its lack of readability.
Maybe for a C reader. For a C++ reader it's quite clear.

>
>>    if ((r = foo_do_something(item))) {
>
> Your kernel-idiomatic C is terrible.  Please don't go around writing 
> much kernel code in this style, that's disgusting.  Your 
> multiply-duplicated return statements were also bad form, see my 
> example for a much clearer way of doing it.
You can tweak the style however you like. The C code wil end up longer 
and with more paths to examine, just doing boilerplate stuff.

We should concentrate on the problem, not boilerplate.
>
>>> Yeah, sure, yours is 3 lines when you omit the following:
>>> (1)  Handling allocation flags like GFP_KERNEL
>> done
>
> And unreadable afterwards
>
>>> (4)  Reference counting, garbage collection, or another way to 
>>> selectively free the allocated objects based on success or failure 
>>> of other code.
>> Reference counting is ridiculously to do in C++. I'll spare you the 
>> details.
>
> I'll assume you mean "ridiculously easy" there.  The problem is that 
> with the exception handling system you add refcounts to a lot of 
> objects that don't need them.  Here's an example that doesn't need a 
> refcount.  I'm registering the "item" with a subsystem, and if that 
> fails the object is immediately freed.
You seem to assyme that C++ is forcing you into a stranglehold. It 
isn't. It gives you tools, you choose how and when to use them. You can 
even write straight C with all the paths spelled out in glorious detail.
>
> {
>     int result;
>     struct foo *item = kmalloc(sizeof(*item), GFP_KERNEL);
>     if (unlikely(!item))
>         return ERR_PTR(-ENOMEM);
>     
>     spin_lock(&item_lock);
>     
>     result = item_init(item, GFP_KERNEL);
>     if (unlikely(result))
>         goto free;
>     
>     result = item_register(subsystem, item);
>     if (unlikely(result))
>         goto destroy;
>     
> out:
>     spin_unlock(&item_lock);
>     return result;
>
>     /* Error handling */
> destroy:
>     item_destroy(item);
> free:
>     kfree(item);
>     goto out;
> }
>
Here's the C++ code:

(I'm assuming you want item_init() out of the spinlock since you pass it 
GFP_KERNEL, presumably for its internal allocations. I'm also assuming 
the function returns 0 or error)

{
    auto_ptr<foo> item = new (GFP_KERNEL) foo(GFP_KERNEL);
    spinlock_t::guard guard(item_lock);
    item->register(subsystem);
    item.release();
}

(and no, auto_ptr<> does not reference count)

This is a translation of what you wrote. 19 lines vs 4.
   
   
> Please note that the assembly into which this optimizes is quite 
> efficient, the compiler can trivially order the fast-path and place 
> all of the exception code after the function or could theoretically 
> even put it in a different section.  The side-effects are quite 
> obvious, and it's also simple to identify exactly how many 
> instructions this function costs; there's a memory allocation, a lock, 
> and two function calls.  Interspersed in there are exactly 3 
> conditional jumps to exception-handling code.  Direct stack usage for 
> this function is around 8 or 12 bytes, depending on word size.
The assembly into which the C++ code is even more optimal (at the 
expense of the exceptional case). Direct stack usage is 4 or 8 bytes, 
depending on word size, unless foo::register is inlined, in which case 
usage drops to zero.
>
> The biggest advantage to this method is that we can tell C exactly 
> what exceptions we expect from the various functions.  Not only that, 
> but we already know what type they are, how likely they are to occur, 
> and exactly how to handle each kind of exception path.  It's even 
> fairly easy to read through the fast-path based on how it's laid out.
>
That's also the biggest disadvantage. You have to wade through 19 lines 
of code, 15 of which should have been generated by the compiler. You're 
following a template; that's a job for machines, not humans.

Modifying those 19 lines won't be fun, either, say you add a 
mutex_lock() at the beginning, now you have to mutex_unlock() in two 
separate places or rework the error paths. That's the stuff 2.6.18.9s 
are made of.

On my example, you add one line to the beginning.
>
> Let me point out a few problems with the C++ ways you've described of 
> doing the same things:
>
> (1)  You can't easily allocate and initialize an object in 2 different 
> steps.
You can. Again, C++ doesn't force you to do anything:

    auto_ptr<foo> item = new (GFP_KERNEL) foo();
    spinlock_t::guard guard(item_lock);
    item->init(...);
>   In the kernel you want to be able to sleep in kmalloc to increase 
> chances of getting the memory you need, but you may need to take a 
> spinlock before actually initializing the data structure (say it's on 
> a linked list).  If you split up the actual initialization into 
> another function then you lose all of the advantages of C++ constructors.
>
Tradeoffs, tradeoffs. but you still get the destructor to clean up, and 
auto_ptr to free memory on exception.
> (2)  Your code either adds a refcount for "item" or unconditionally 
> releases it at the end of the function.  Yes that's fixable, but not 
> in a way that preserves the exception-handling properties you're 
> espousing so much.  When you get an exception, how does the code tell 
> which objects to free and which ones not to?  (Answer: it can't, 
> that's a semantic decision made by the programmer with "if" statements).
Sorry, that's based on a wrong understanding of what auto_ptr<> is. It 
has nothing to do with refcounts.

The code is just a translation of what you wrote.
>
> (3)  You still haven't explained how adding all sorts of implicit side 
> effects is a good thing in an operating system kernel.
Reducing code size, improving performance, and reducing bug count. All 
of which, I believe, are important to Linux.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

