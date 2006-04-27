Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWD0CGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWD0CGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWD0CGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:06:04 -0400
Received: from main.gmane.org ([80.91.229.2]:47257 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964874AbWD0CGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:06:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Roman Kononov <kononov195-far@yahoo.com>
Subject: Re: C++ pushback
Date: Wed, 26 Apr 2006 21:05:31 -0500
Message-ID: <445026EB.8010407@yahoo.com>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org> <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-255-17-86.dsl.emhril.ameritech.net
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <6B929F57-12EB-4E91-A191-2F0DABB77962@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Apr 26, 2006, at 19:00:52, Roman Kononov wrote:
>> Linus Torvalds wrote:
>>>  - some of the C features we use may or may not be usable from C++    
>>> (statement expressions?)
>>
>> Statement expressions are working fine in g++. The main difficulties are:
>>    - GCC's structure member initialization extensions are syntax
>>      errors in G++: struct foo_t foo={.member=0};
> 
> And that breaks a _massive_ amount of kernel code, including such core 
> functionality like SPIN_LOCK_UNLOCKED and a host of others.  There are 
> all sorts of macros that use member initialization of that form.
This does not break the code at run time, this breaks the code at 
compile time, and should be less painful.

>>    - empty structures are not zero-sized in g++, unless they are like
>>      this one: struct really_empty_t { char dummy[0]; };
> 
> And that provides yet more ways to break binary compatibility.  Not to 
> mention the fact that it appears to change other aspects of the way 
> structs are packed.  Since the kernel uses a lot of data structures to 
> strictly define binary formats for transmission to hardware, across a 
> network, or to userspace, such changes can cause nothing but heartache.
This breaks the code at run time and is the _real_ pain to think 
about. As for packing for network and hardware - not an issue at all. 
The difference between gcc and g++ is _only_ in empty structures.

>>>  - the compilers are slower, and less reliable. This is _less_ of an 
>>> issue    these days than it used to be (at least the reliability 
>>> part), but it's still true.
>>
>> G++ compiling heavy C++ is a bit slower than gcc. The g++ front end is 
>> reliable enough. Do you have a particular bug in mind?
> 
> A lot of people would consider the "significantly slower" to be a major 
> bug.  Many people moaned when the kernel stopped supporting GCC 2.x 
> because that compiler was much faster than modern C compilers.  I've 
> seen up to a 3x slowdown when compiling the same files with g++ instead 
> of gcc, and such would be unacceptable to a _lot_ of people on this list.
I agree, it would be a bad idea to compile the existing C code by g++. 
  The good idea is to be able to produce new C++ modules etc.

>>>  - a lot of the C++ features just won't be supported sanely (ie the 
>>> kernel    infrastructure just doesn't do exceptions for C++, nor will 
>>> it run any    static constructors etc).
>>
>> A lot of C++ features are already supported sanely. You simply need to 
>> understand them. Especially templates and type checking.
> 
> First of all, the only way to sanely use templated classes is to write 
> them completely inline, which causes massive bloat.  Look at the kernel 
> "struct list_head" and show me the "type-safe C++" way to do that.  It 
> uses a templated inline class, right?  That templated inline class gets 
> duplicated for each different type of object put in a linked list, no?  
> Think about how many linked lists we have in the kernel and tell me why 
> that would be a good thing.
You mentioned a bad example. The struct list_head has [almost?] all 
"members" inlined. If they were not, one could simply make a base 
class having [some] members outlined, and which class does not enforce 
type safety and is for inheritance only. The template class would then 
inherit the base one enforcing type safety by having inline members. 
This technique is well known, trust me. If you need real life 
examples, tell me.

>> Static constructor issue is trivial.
> 
> How so?  When do you want the static constructors to be run?  There are 
> many different major stages of kernel-level initialization; picking one 
> is likely to make them useless for other code.
For modules there are #defines module_init() and module_exit(). These 
are the natural places for the constructors and destructors.

For #defines core_initcall() ... late_initcall() I would type 
something like this:
	class foo_t { foo_t(); ~foo_t(); }
	static char foo_storage[sizeof(foo_t)];
	static foo_t& foo=*reinterpret_cast<foo_t*>(foo_storage);
	static void __init foo_init() { new(foo_storage) foo_t; }
	core_initcall(foo_init);
This ugly-looking code can be nicely wrapped into a template, which, 
depending on the type (foo_t in this case), at compile time, picks the 
proper stage for initialization.

Regards,
Roman

