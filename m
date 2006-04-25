Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWDYP7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWDYP7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWDYP7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:59:17 -0400
Received: from smtpout.mac.com ([17.250.248.182]:42187 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751552AbWDYP7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:59:16 -0400
In-Reply-To: <444DCAD2.4050906@argo.co.il>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 11:59:03 -0400
To: Avi Kivity <avi@argo.co.il>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 25, 2006, at 03:08:02, Avi Kivity wrote:
> Kyle Moffett wrote:
>> The "advantages" of the former over the latter:
>>
>> (1)  Without exceptions (which are fragile in a kernel), the  
>> former can't return an error instead of initializing the Foo.
> Don't discount exceptions so fast. They're exactly what makes the  
> code clearer and more robust.

Except making exceptions work in the kernel is exceptionally  
nontrivial (sorry about the pun).

> A very large proportion of error handling consists of:
> - detect the error
> - undo local changes (freeing memory and unlocking spinlocks)
> - propagate the error/
>
> Exceptions make that fully automatic. The kernel uses a mix of  
> gotos and alternate returns which bloat the code and are incredibly  
> error prone. See the recent 2.6.16.x for examples.

You talk about code bloat here.  Which of the following fits better  
into a 4k stack?  Which of the following shows the flow of code better?

C version:
	int result;
	spin_lock(&lock);
	
	result = do_something();
	if (result)
		goto out;
	
	result = do_something_else();
	if (result)
		goto out;
	
	out:
	spin_unlock(&lock);
	return result;

C++ version:
	int result;
	TakeLock l(&lock);
	
	do_something();
	do_something_else();

First of all, that extra TakeLock object chews up stack, at least 4  
or 8 bytes of it, depending on your word size.  Secondly with  
standard integer error returns you have one or two easily-predictable  
assembly instructions at each step of the way, whereas with  
exceptions you trade the absence of error handling in the rest of the  
code for a lot of extra instructions at the exception throw and catch  
points.  Secondly, while the former is much longer it shows  
_explicitly_ exactly where the flow of code can go.  In an OS kernel,  
that is critical;  your debugability is directly dependent on how  
easy it is to see where the flow of code is going.

>> (2)  You can't control when you initialize the Foo.  For example  
>> in this code, the "Foo item;" declarations seem to be trivially  
>> relocatable, even if they're not.
>>     spin_lock(&foo_lock);
>>     Foo item1;
>>     Foo item2;
>>     spin_unlock(&foo_lock);
>
> They only seem relocatable with your C glasses on. Put on your C++  
> glasses (much thicker), and initialization no longer seems  
> trivially movable.

This is a really _really_ bad idea for a kernel.  Having simple  
declaration statements have big side effects (like the common  
TakeLock object example I gave above) is bound to lead to people  
screwing up and forgetting about the side effects.  In C it's  
impossible to miss the side effects of a statement; function calls  
are obvious, as is global memory modification.

> On the other hand, you can replace the C code
>
> {
>    Foo item1, item2;
>    int r;
>
>    spin_lock(&foo_lock);
>    if ((r = foo_init(&item1)) < 0) {
>        spin_unlock(&foo_lock);
>        return r;
>    }
>    if ((r = foo_init(&item2)) < 0) {
>        foo_destroy(&item1);
>        spin_unlock(&foo_lock);
>        return r;
>    }
>    foo_destroy(&item2);
>    foo_destroy(&item1);
>    spin_unlock(&foo_lock);
>    return 0;
> }
>
> with
>
> {
>    spinlock_t::guard foo_guard(foo_lock);
>    Foo item1;
>    Foo item2;
> }

Let me point out _again_ how unobvious and fragile the flow of code  
there is.  Not to mention the fact that the C++ compiler can easily  
notice that item1 and item2 are never used and optimize them out  
entirely.  You also totally missed the "int flags" argument you're  
supposed to pass to object specifying allocation parameters, not to  
mention the fact that you just allocated 2 objects of unknown size on  
the stack (which is limited to 4k).  AND there's the fact that the  
order of destruction of foo_guard, item1, and item2 is implementation- 
defined and can't easily be relied upon without adding massive  
amounts of excess braces:

{
	spinlock_t::guard foo_guard(&foo_lock);
	{
		Foo item1;
		{
			Foo item2;
		}
	}
}

Also, your spinlock_t::guard chews up stack space that otherwise  
wouldn't be used.  It would be much better to rewrite your above C  
function like this:

{
	struct foo *item1, *item2;
	int result;
	spin_lock(&foo_lock);
	
	item1 = kmalloc(sizeof(*item1), GFP_KERNEL);
	item2 = kmalloc(sizeof(*item2), GFP_KERNEL);
	if (!item1 || !item2)
		goto out;
	
	result = foo_init(item1, GFP_KERNEL);
	if (result)
		goto out;
	
	result = foo_init(item2, GFP_KERNEL);
	if (result)
		goto out;
	
out:
	/* If alloc and init went ok, register them */
	if (item1 && item2 && !result) {
		result = register_foo_pair(item1, item2);
	}
	
	/* If anything failed, free resources */
	if (!item1 || !item2 || result) {
		kfree(item1);
		kfree(item2);
	}
	
	spin_unlock(&foo_lock);
	return result;
}

> 14 lines vs 3, one variable eliminated. How many potential security  
> vulnerabilities? How much time freed to work on the algorithm/data  
> structure, not on error handling?

Yeah, sure, yours is 3 lines when you omit the following:
(1)  Handling allocation flags like GFP_KERNEL
(2)  Not allocating things on the stack
(3)  Proper cleanup ordering
(4)  Reference counting, garbage collection, or another way to  
selectively free the allocated objects based on success or failure of  
other code.

Those are all critical things that we want to force people to think  
about; in many cases the exact ordering of operations _is_ important  
and that needs to be specified _and_ commented on.  How often do you  
think people write comments talking about things that don't even  
appear in the source code?

Also, since when is error handling _not_ a critical part of the  
algorithm?  You can see in my more complicated example that you only  
want to free the items if the registration was unsuccessful.  How do  
you handle that without adding a refcount to everything (bloat) or  
implementing garbage collection (worse bloat).

>> Does that actually make it any easier to understand the code?  How  
>> does it make it more obvious to be able to write a "+" operator  
>> that allocates memory?
>
> Not all C++ features need to be used in the kernel. In fact, not  
> all C++ features need to be used, period. Ever tried to understand  
> code which uses overloaded operator,() (the comma operator)?

The very fact that the language provides such features mean that  
people would try to get code using them into the kernel.  Have you  
ever looked at all the ugly debugging macros that various people  
use?  The C preprocessor provides few features at all, and yet people  
still abuse those, I don't see why C++ would be any different.

Cheers,
Kyle Moffett


