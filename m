Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWCZMun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWCZMun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWCZMun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:50:43 -0500
Received: from smtpout.mac.com ([17.250.248.71]:41429 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932070AbWCZMun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:50:43 -0500
In-Reply-To: <1143376351.3064.9.camel@laptopd505.fenrus.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Date: Sun, 26 Mar 2006 07:50:28 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 07:32:31, Arjan van de Ven wrote:
> On Sun, 2006-03-26 at 06:54 -0500, Kyle Moffett wrote:
>> Create initial kernel ABI header infrastructure
>
> it's nice that you picked this one;
> for this you want an arch-generic/stddef32.h and stddef64.h
>
> and have arch-foo just only include the proper generic one..

I plan to add a lot of other definitions to this file later on.  For  
example different architectures have different notions of what a  
__kernel_ino_t is (unsigned int versus unsigned long).  I may rename  
this file as types.h, but from looking through the code I figure I'll  
have enough general purpose declarations about "This architecture has  
blah" that a separate stddef.h file will be worth it.

> (and... why do you prefix these with _KABI? that's a mistake imo.  
> Don't bother with that. Really. Either these need exporting to  
> userspace, but then either use __ as prefix or don't use a prefix.  
> But KABI.. No.)

According to the various standards all symbols beginning with __ are  
reserved for "The Implementation", including the compiler, the  
standard library, the kernel, etc.  In order to avoid clashing with  
any/all of those, I picked the __KABI_ and __kabi_ prefixes for  
uniqueness.  In theory I could just use __, but there are problems  
with that too.  For example, note how the current compiler.h files  
redefine __always_inline to mean something kinda different.  The GCC  
manual says we should be able to write this:

inline __attribute__((__always_inline)) int increment(int x)
{
	return x+1;
}

Except when compiling the kernel headers turn that into this (which  
obviously doesn't compile):
inline __attribute__((__attribute__((always_inline)))) int increment 
(int x)
{
	return x+1;
}

As a result, I kinda want to stay away from anything that remotely  
looks like a conflicting namespace.  Using such a unique namespace  
means we can also safely do this if necessary (Since you can't  
"typedef struct foo struct bar"):

kabi/foo.h:
   struct __kabi_foo {
   	int x;
   	int y;
   };

linux/foo.h:
   #define __kabi_foo foo
   #include <kabi/foo.h>

drivers/foo/foo.h:
   #include <linux/foo.h>
   void func()
   {
   	struct foo = { .x = 1, .y = 2 };
   }

Cheers,
Kyle Moffett

