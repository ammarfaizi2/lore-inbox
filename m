Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWDYHIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWDYHIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDYHIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:08:06 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:13573 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751340AbWDYHIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:08:04 -0400
Message-ID: <444DCAD2.4050906@argo.co.il>
Date: Tue, 25 Apr 2006 10:08:02 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
In-Reply-To: <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 07:08:03.0248 (UTC) FILETIME=[FE696300:01C66836]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[de-cc'ed original poster, he's far away by now]

Kyle Moffett wrote:
> On Apr 24, 2006, at 17:03:46, Avi Kivity wrote:
>> Alan Cox wrote:
>>> There are a few anti C++ bigots around too, but the kernel choice of 
>>> C was based both on rational choices and experimentation early on 
>>> with the C++ compiler.
>>
>> Times have changed, though. The C++ compiler is much better now, and 
>> the recent slew of error handling bugs shows that C is a very unsafe 
>> language.
>>
>> I think it's easy to show that the equivalent C++ code would be 
>> shorter, faster, and safer.
>
> Really?  What features exactly does C++ have over C that you think 
> make that true?  Implicit memory allocation? Exceptions?  Operator 
> overloading?  Tendency to use StudlyCaps?  What else can C++ do that C 
> can not?
>
> For example, I could write the following:
>
> class Foo {
> public:
>     Foo() { /* ... init code ... */ }
>     ~Foo() { /* ... free code ... */ }
>     int do_thing(int arg) { /* ... code ... */ }
>
> private:
>     int data_member;
> };
>
> Or I could write it like this:
>
> struct foo {
>     int data_member;
> };
>
> int foo_init() { /* ... init code ... */ }
> int foo_destroy() { /* ... free code ... */ }
> int foo_do_thing(int arg) { /* ... code ... */ }
>
>
> The "advantages" of the former over the latter:
>
> (1)  Without exceptions (which are fragile in a kernel), the former 
> can't return an error instead of initializing the Foo.
Don't discount exceptions so fast. They're exactly what makes the code 
clearer and more robust.

A very large proportion of error handling consists of:
- detect the error
- undo local changes (freeing memory and unlocking spinlocks)
- propagate the error

Exceptions make that fully automatic. The kernel uses a mix of gotos and 
alternate returns which bloat the code and are incredibly error prone. 
See the recent 2.6.16.x for examples.
>
> (2)  You can't control when you initialize the Foo.  For example in 
> this code, the "Foo item;" declarations seem to be trivially 
> relocatable, even if they're not.
>     spin_lock(&foo_lock);
>     Foo item1;
>     Foo item2;
>     spin_unlock(&foo_lock);
They only seem relocatable with your C glasses on. Put on your C++ 
glasses (much thicker), and initialization no longer seems trivially 
movable.

On the other hand, you can replace the C code

{
    Foo item1, item2;
    int r;

    spin_lock(&foo_lock);
    if ((r = foo_init(&item1)) < 0) {
        spin_unlock(&foo_lock);
        return r;
    }
    if ((r = foo_init(&item2)) < 0) {
        foo_destroy(&item1);
        spin_unlock(&foo_lock);
        return r;
    }
    foo_destroy(&item2);
    foo_destroy(&item1);
    spin_unlock(&foo_lock);
    return 0;
}

with

{
    spinlock_t::guard foo_guard(foo_lock);
    Foo item1;
    Foo item2;
}

14 lines vs 3, one variable eliminated. How many potential security 
vulnerabilities? How much time freed to work on the algorithm/data 
structure, not on error handling?
>
> (3)  Foo could theoretically implement overloaded operators.  How 
> exactly is it helpful to do math on structs?
It isn't. It's nice for other application domains (matrix algebra, etc.) 
not for kernels.

This mailing list has a full complement of reviewers who can detect 
trailing whitespace in a dark room three miles away. Surely they can 
spot an attempt to sneak in the "operator" keyword.
> Does that actually make it any easier to understand the code?  How 
> does it make it more obvious to be able to write a "+" operator that 
> allocates memory?
>
Not all C++ features need to be used in the kernel. In fact, not all C++ 
features need to be used, period. Ever tried to understand code which 
uses overloaded operator,() (the comma operator)?

-- 
error compiling committee.c: too many arguments to function

