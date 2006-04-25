Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWDYTWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWDYTWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDYTWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:22:31 -0400
Received: from smtpout.mac.com ([17.250.248.182]:43262 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932143AbWDYTWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:22:30 -0400
In-Reply-To: <444E524A.10906@argo.co.il>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4C4500F3-3A8E-4992-82FD-6E16257676CC@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 15:22:02 -0400
To: Avi Kivity <avi@argo.co.il>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 25, 2006, at 12:46:02, Avi Kivity wrote:
> Kyle Moffett wrote:
>> Except making exceptions work in the kernel is exceptionally  
>> nontrivial (sorry about the pun).
>
> My experience with exceptions in kernel-like code (a distributed  
> filesystem) was excellent.

Well from all of the discussions about it that occurred on this list,  
the biggest problem with exceptions in the kernel was the overhead to  
keep track of the exception state and the try/catch stack.  The other  
problem was handling exceptions in atomic contexts, in the guts of  
the scheduler, and in a host of other hot-paths.

>> Which of the following shows the flow of code better?
>
> Once you accept the idea that an exception can occur (almost) anywhere

Except they can't.  Lots and lots of bits of kernel code explicitly  
depend on the fact that certain operations _cannot_ fail, and they  
make that obvious through the fact that those functions don't have  
any way of returning error conditions.

> the C++ code shows you what the code does in the normal case  
> without obfuscating it with error handling. Pretend that after  
> every semicolon there is a comment of the form:
>    /* possible exceptional return */

As I pointed out before and seem doomed to point out again, this is  
an _implicit_ piece of code, and in kernels implicit code is very  
very bad.  Because of the varying contexts and close hardware  
dependence, you want to explicitly state everything that happens.

>> First of all, that extra TakeLock object chews up stack, at least  
>> 4 or 8 bytes of it, depending on your word size.
>
> No, it's optimized out. gcc notices that &lock doesn't change and  
> that 'l' never escapes the function.

GCC does not notice that when you use out-of-line functions.  Let me  
remind you that many of the kernel's spinlocks and other functions  
are out-of-line, inlining them has significant performance penalties.

>> Secondly with standard integer error returns you have one or two  
>> easily-predictable assembly instructions at each step of the way,  
>> whereas with exceptions you trade the absence of error handling in  
>> the rest of the code for a lot of extra instructions at the  
>> exception throw and catch points.
>
> The extra code is out of line (not even an if (unlikely())). So  
> yes, total code grows, but the exceptional paths can be in  
> a .text.exception section and not consume cache or TLB space.

Total bull.  Let me give you an example.  The following C++ code:
{
	Foo my_foo;
	function_that_throws_exception();
}

Is turned by the compiler into a slight variant on this C code:
{
	Foo my_foo = Foo();
	jmp_buf exception;
	if (setjmp(exception))
		goto out;
	
	function_that_throws_exception();
	
out:
	~Foo(&my_foo);
}

There is nothing about the above that the compiler can trivially "out- 
of-line", not to mention the fact that you just royally screwed the  
CPUs chances of getting branch prediction right.  There's the fact  
that setjmp and longjmp are kind of hard in kernelspace.  Finally,  
the stack usage is significantly increased, I think even in  
userspace, jmp_buf occupies 8 longs (32 bytes) just for critical  
registers and instruction pointer of the exception handler.  Also,  
the simplest case of throwing an exception has turned from the three  
instructions "cmp bnz ret" (compare result or pointer, branch to  
exception code, return) to this mess:
{
	longjmp((int)pointer);
}

The longjmp function is simple, but not _that_ simple, and it still  
breaks branch prediction in a bad way.

>> This is a really _really_ bad idea for a kernel.  Having simple  
>> declaration statements have big side effects (like the common  
>> TakeLock object example I gave above) is bound to lead to people  
>> screwing up and forgetting about the side effects.  In C it's  
>> impossible to miss the side effects of a statement; function calls  
>> are obvious, as is global memory modification.
>
> In C++ you just have to treat declarations as executable  
> statements. Just as you can't compile the code with a C compiler,  
> you can't read it with a C mindset. Once you get used to it, it  
> isn't surprising at all.

That's all well and good, until you assume that "some_type foo = 3;"  
is just declaring an integer through a typedef instead of declaring  
an object with side effects.  The thing about the linux kernel is  
that basically _nobody_ understands all of it, and as a result each  
and every bit of code must stand on its own and be fairly obvious as  
to side effects and such.  In C++, most of the language features are  
designed to _hide_ those side effects and as a result it's a terrible  
fit for the kernel.

>> Let me point out _again_ how unobvious and fragile the flow of  
>> code there is.  Not to mention the fact that the C++ compiler can  
>> easily notice that item1 and item2 are never used and optimize  
>> them out entirely.
>
> Excellent! If there are no side effects, I want it out. If there  
> are side effects, it won't optimize them out.

How can it tell?  You aren't writing all your member functions  
inline, are you?

>>   You also totally missed the "int flags" argument you're supposed  
>> to pass to object specifying allocation parameters,
>
> There is no allocation here (both the C and the C++ code allocate  
> on the stack.

Let's look in the kernel.  How often do you find non-trivial  
constructor functions that _don't_ allocate memory, hm?

> Should you want to allocate from the heap, try this:
>
> {
>    spinlock_t::guard g(some_lock);
>    auto_ptr<Foo> item(new (gfp_mask) Foo);   /* or pass a  
> kmem_cache_t */
>    item->do_something();
>    item->do_something_else();
>    return item.release();
> }

I think this code speaks for itself about its lack of readability.

>    if ((r = foo_do_something(item))) {

Your kernel-idiomatic C is terrible.  Please don't go around writing  
much kernel code in this style, that's disgusting.  Your multiply- 
duplicated return statements were also bad form, see my example for a  
much clearer way of doing it.

>> Yeah, sure, yours is 3 lines when you omit the following:
>> (1)  Handling allocation flags like GFP_KERNEL
> done

And unreadable afterwards

>> (4)  Reference counting, garbage collection, or another way to  
>> selectively free the allocated objects based on success or failure  
>> of other code.
> Reference counting is ridiculously to do in C++. I'll spare you the  
> details.

I'll assume you mean "ridiculously easy" there.  The problem is that  
with the exception handling system you add refcounts to a lot of  
objects that don't need them.  Here's an example that doesn't need a  
refcount.  I'm registering the "item" with a subsystem, and if that  
fails the object is immediately freed.

{
	int result;
	struct foo *item = kmalloc(sizeof(*item), GFP_KERNEL);
	if (unlikely(!item))
		return ERR_PTR(-ENOMEM);
	
	spin_lock(&item_lock);
	
	result = item_init(item, GFP_KERNEL);
	if (unlikely(result))
		goto free;
	
	result = item_register(subsystem, item);
	if (unlikely(result))
		goto destroy;
	
out:
	spin_unlock(&item_lock);
	return result;

	/* Error handling */
destroy:
	item_destroy(item);
free:
	kfree(item);
	goto out;
}

Please note that the assembly into which this optimizes is quite  
efficient, the compiler can trivially order the fast-path and place  
all of the exception code after the function or could theoretically  
even put it in a different section.  The side-effects are quite  
obvious, and it's also simple to identify exactly how many  
instructions this function costs; there's a memory allocation, a  
lock, and two function calls.  Interspersed in there are exactly 3  
conditional jumps to exception-handling code.  Direct stack usage for  
this function is around 8 or 12 bytes, depending on word size.

The biggest advantage to this method is that we can tell C exactly  
what exceptions we expect from the various functions.  Not only that,  
but we already know what type they are, how likely they are to occur,  
and exactly how to handle each kind of exception path.  It's even  
fairly easy to read through the fast-path based on how it's laid out.


Let me point out a few problems with the C++ ways you've described of  
doing the same things:

(1)  You can't easily allocate and initialize an object in 2  
different steps.  In the kernel you want to be able to sleep in  
kmalloc to increase chances of getting the memory you need, but you  
may need to take a spinlock before actually initializing the data  
structure (say it's on a linked list).  If you split up the actual  
initialization into another function then you lose all of the  
advantages of C++ constructors.

(2)  Your code either adds a refcount for "item" or unconditionally  
releases it at the end of the function.  Yes that's fixable, but not  
in a way that preserves the exception-handling properties you're  
espousing so much.  When you get an exception, how does the code tell  
which objects to free and which ones not to?  (Answer: it can't,  
that's a semantic decision made by the programmer with "if" statements).

(3)  You still haven't explained how adding all sorts of implicit  
side effects is a good thing in an operating system kernel.

Cheers,
Kyle Moffett

