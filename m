Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSGBELp>; Tue, 2 Jul 2002 00:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSGBELo>; Tue, 2 Jul 2002 00:11:44 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:32141 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S316604AbSGBELi>; Tue, 2 Jul 2002 00:11:38 -0400
Message-ID: <3D212757.5040709@quark.didntduck.org>
Date: Tue, 02 Jul 2002 00:08:55 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
References: <31042.1025576745@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Mon, 1 Jul 2002 22:40:34 -0300, 
> Werner Almesberger <wa@almesberger.net> wrote:
> 
>>If I remember right, the main arguments why module removal can
>>race with references were:
>>....
>>- removal happening immediately after module usage count is
>>  decremented to zero may unload module before module has
>>  executed "return" instruction
>>For the removal-before-return problem, I thought a bit about it
>>on my return flight. It would seem to me that an "atomic"
>>"decrement_module_count_and_return" function would do the trick.
> 
> 
> This is just one symptom of the overall problem, which is module code
> that adjusts its use count by executing code that belongs to the
> module.  The same problem exists on entry to a module function, the
> module can be removed before MOD_INC_USE_COUNT is reached.
> 
> Apart from abandoning module removal, there are only two viable fixes:
> 
> 1) Do the reference counting outside the module, before it is entered.
> 
>    This is why Al Viro added the owner: __THIS_MODULE; line to various
>    structures.  The problem is that it spreads like a cancer.  Every
>    structure that contains function pointers needs an owner field.
>    Every bit of code that dereferences a function pointer must first
>    bump the owner's use count (using atomic ops) and must cope with the
>    owner no longer existing.
> 
>    Not only does this pollute all structures that contain function
>    pointers, it introduces overhead on every function dereference.  All
>    of this just to cope with the relatively low possibility that a
>    module will be removed.

Only "first use" (ie. ->open) functions need gaurding against unloads. 
Any subsequent functions are guaranteed to have a reference to the 
module, and don't need to bother with the refcount.  I have a few ideas 
to optimize the refcounting better than it is now.

> 2) Introduce a delay after unregistering a module's services and before
>    removing the code from memory.
> 
>    This puts all the penalty and complexity where it should be, in the
>    unload path.  However it requires a two stage rmmod process (check
>    use count, unregister, delay, recheck use count, remove if safe)
>    so all module cleanup routines need to be split into unregister and
>    final remove routines.
> 
>    This is relatively easy to do without preemption, it is
>    significantly harder with preempt.  There are also unsolved problems
>    with long running device commands with callbacks (e.g. CD-R fixate)
>    and with kernel threads started from a module (must wait until
>    zombies have been reaped).

The callbacks should hold references that would not allow the module to 
unload.  Other than that, this is the same problem the RCU folks are 
working on.

> Rusty and I agree that option (2) is the only sane way to do module
> unload, assuming that we retain module unloading.  First decide if the
> extra work is justified.

Freeing up the limited vmalloc address space should be justification enough.

--
				Brian Gerst


