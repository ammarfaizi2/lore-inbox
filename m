Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWD0AiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWD0AiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWD0AiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:38:09 -0400
Received: from smtpout.mac.com ([17.250.248.171]:5847 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751029AbWD0AiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:38:08 -0400
In-Reply-To: <e2ou35$u5r$1@sea.gmane.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: C++ pushback
Date: Wed, 26 Apr 2006 20:38:05 -0400
To: Roman Kononov <kononov195-far@yahoo.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2006, at 19:00:52, Roman Kononov wrote:
> Linus Torvalds wrote:
>>  - some of the C features we use may or may not be usable from C+ 
>> +    (statement expressions?)
>
> Statement expressions are working fine in g++. The main  
> difficulties are:
>    - GCC's structure member initialization extensions are syntax
>      errors in G++: struct foo_t foo={.member=0};

And that breaks a _massive_ amount of kernel code, including such  
core functionality like SPIN_LOCK_UNLOCKED and a host of others.   
There are all sorts of macros that use member initialization of that  
form.


>    - empty structures are not zero-sized in g++, unless they are like
>      this one: struct really_empty_t { char dummy[0]; };

And that provides yet more ways to break binary compatibility.  Not  
to mention the fact that it appears to change other aspects of the  
way structs are packed.  Since the kernel uses a lot of data  
structures to strictly define binary formats for transmission to  
hardware, across a network, or to userspace, such changes can cause  
nothing but heartache.


>>  - the compilers are slower, and less reliable. This is _less_ of  
>> an issue    these days than it used to be (at least the  
>> reliability part), but it's still true.
>
> G++ compiling heavy C++ is a bit slower than gcc. The g++ front end  
> is reliable enough. Do you have a particular bug in mind?

A lot of people would consider the "significantly slower" to be a  
major bug.  Many people moaned when the kernel stopped supporting GCC  
2.x because that compiler was much faster than modern C compilers.   
I've seen up to a 3x slowdown when compiling the same files with g++  
instead of gcc, and such would be unacceptable to a _lot_ of people  
on this list.


>>  - a lot of the C++ features just won't be supported sanely (ie  
>> the kernel    infrastructure just doesn't do exceptions for C++,  
>> nor will it run any    static constructors etc).
>
> A lot of C++ features are already supported sanely. You simply need  
> to understand them. Especially templates and type checking.

First of all, the only way to sanely use templated classes is to  
write them completely inline, which causes massive bloat.  Look at  
the kernel "struct list_head" and show me the "type-safe C++" way to  
do that.  It uses a templated inline class, right?  That templated  
inline class gets duplicated for each different type of object put in  
a linked list, no?  Think about how many linked lists we have in the  
kernel and tell me why that would be a good thing.


> Static constructor issue is trivial.

How so?  When do you want the static constructors to be run?  There  
are many different major stages of kernel-level initialization;  
picking one is likely to make them useless for other code.

Cheers,
Kyle Moffett

