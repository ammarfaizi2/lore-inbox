Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWIGODt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWIGODt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWIGODt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:03:49 -0400
Received: from smtpout.mac.com ([17.250.248.172]:26869 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751803AbWIGODr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:03:47 -0400
In-Reply-To: <20060907114358.GA26551@flint.arm.linux.org.uk>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <20060907063049.GA15029@flint.arm.linux.org.uk> <20060907102740.GH25473@stusta.de> <20060907114358.GA26551@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A93564A8-3F3A-4BA3-9557-F3D75BE59052@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] re-add -ffreestanding
Date: Thu, 7 Sep 2006 10:03:16 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 07, 2006, at 07:43:58, Russell King wrote:
> On Thu, Sep 07, 2006 at 12:27:40PM +0200, Adrian Bunk wrote:
>> And I'm getting bashed for sendind a patch to revert it "only" to  
>> linux-kernel...
>
> As far as your argument that the kernel is not a hosted  
> environment, that's debatable (as you're finding out).
>
> If we decide that we want the compiler to treat our source as if it  
> were a hosted environment, and we provide sufficient implementation  
> of a conforming nature of a hosted environment then that is our  
> perogative to do so.  That is a decision that we are entirely free  
> to make.  By doing so, we take on the responsibility to provide  
> whatever is required for a hosted environment as opposed to the  
> more limited functionality of a freestanding environment.

Ick, can anybody be persuaded to post actual effective code changes?   
IMHO the kernel should use "-ffreestanding", which is defined as  
follows in the GCC manual (which, I admit, has been wrong before, but  
it's a start at least):

"Assert that the compilation takes place in a freestanding  
environment. Implies "-fno-builtin".  A freestanding environment is  
one in which the standard library may not exist, and program startup  
may not necessarily be at "main" (which does not necessarily have a  
return type of "int").  The most obvious example is an OS kernel."

According to the above, there are two effects for turning on "- 
ffreestanding":
   1) "main" doesn't have a special argument list and return value.
   2) "-fno-builtin"

The docs for "-fno-builtin" say:

"Don't recognize built-in functions that do not begin with __builtin_  
as prefix.

GCC normally generates special code to handle certain built-in  
functions more efficiently; for instance, calls to "alloca" may  
become single instructions that adjust the stack directly, and calls  
to "memcpy" may become inline copy loops.  The resulting code is  
often both smaller and faster, but since the function calls no longer  
appear as such, you cannot set a breakpoint on those calls, nor can  
you change the behavior of the functions by linking with a different  
library.  In addition, when a function is recognized as a built-in  
function, GCC may use information about that function to warn about  
problems with calls to that function, or to generate more efficient  
code, even if the resulting code still contains calls to that  
function.  For example, warnings are given with "-Wformat" for bad  
calls to "printf", when "printf" is a builtin, and "strlen" is known  
not to modify global memory.

[...]

If you wish to enable built-in functions selectively when using -fno- 
builtin or -ffreestanding, you may define macros such as:
#define abs(n) __builtin_abs((n))
#define strcpy(d, s) __builtin_strcpy((d),(s))"

SO, the total effects of "-ffreestanding" are:
   1) "main" is not a special function
   2) "foo" does not automatically mean "__builtin_foo"

Why are you arguing so much over this change?  As far as I can tell,  
turning on "-ffreestanding" is a no-brainer; "main" isn't special in  
the kernel and allowing arch maintainers to selectively turn on or  
off "__builtin_*" effects for kernel functions in per-arch headers is  
a good thing.

If your arch absolutely *must* have "strlen" act like  
"__builtin_strlen" for some reason, just do this:
#define strlen(x) __builtin_strlen(x)

But please note that __builtin_ functions are defined by the GCC  
people to be able to decay to _any_ function call.  For example, the  
GCC people replied to
Adrian Bunk's email this way:
   http://lists.debian.org/debian-gcc/2005/03/msg00101.html

"You explicitly requested the __builtin_sprintf implementation, which  
is allowed to decay to strcpy, and overrode the -ffreestanding in  
this case."

So the meaning of __builtin_sprintf is NOT 'have GCC emit sprintf  
code', and it is NOT 'emit assembly where easy and sprintf where  
otherwise', it is 'emit calls to any function(s) in the standard C  
library which implement the requested functionality.'

So it may be OK for sprintf(buf,"%s",str); to decay to strcpy(buf,  
str) in the kernel, but if it's not the ONLY ways to turn it off are - 
fno-builtin-sprintf, -fno-builtin, and -ffreestanding.  Explicitly  
disabling these optimizations is virtually guaranteed that we'll miss  
one, we should turn them all off and selectively enable the ones that  
make sense.

> - according to what I read in the gcc manual, free standing  
> environments are required to provide float support.  We don't, so  
> it could be possible to argue that we provide neither a  
> freestanding nor a hosted environment, and, therefore, we shouldn't  
> be using gcc at all.

Freestanding environments need to provide float support  
_if_they_need_it_.  We don't need it, don't use it, and so don't have  
to provide it.

Cheers,
Kyle Moffett


