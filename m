Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbUJ2AyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUJ2AyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbUJ2AyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:54:11 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2820 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S263212AbUJ2AsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:48:03 -0400
Message-ID: <4181933A.5000402@vmware.com>
Date: Thu, 28 Oct 2004 17:47:54 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org> <41801DE1.6000007@vmware.com> <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org> <Pine.LNX.4.58.0410271731010.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410271731010.28839@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2004 00:47:55.0364 (UTC) FILETIME=[ED8C3A40:01C4BD50]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.44; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried this.  I found a problem -- ide-cd.c calls a function to compute 
base, which was caught by sparse.  This is easy enough to workaround, 
but my adventures went further than expected..

I tested all powers of two and found gcc doesn't like to perform the 
optimization for 0x80000000 as a divisor.  Ok, worked around that.  Now 
Everything appears to work great, until I started using modules:

  MODPOST
*** Warning: "__udivdi3" [drivers/scsi/ipr.ko] undefined!
*** Warning: "__umoddi3" [drivers/scsi/ipr.ko] undefined!
*** Warning: "__udivdi3" [drivers/scsi/dpt_i2o.ko] undefined!
*** Warning: "__umoddi3" [drivers/scsi/dpt_i2o.ko] undefined!
*** Warning: "__udivdi3" [drivers/base/firmware_class.ko] undefined!
*** Warning: "__umoddi3" [drivers/base/firmware_class.ko] undefined!

That doesn't look good.  Trying to load the modules confirms that 
__uxxxdi3 is missing.  How did this happen?  If you look at do_div, it 
is clear that __udivdi3 should not be needed, since we will always hit 
the optimization path.  Nevertheless, gcc inserts an extraneous ".globl 
__udivdi3" in all output to the assembler from .c files which include 
asm/div64.h, even if the do_div function is never directly referenced 
and no instances of it appear in the assembler output (libcrc32c.c is 
the easiest to verify).  Apparently, this happens somewhere before the 
optimization phase, and the external reference never gets dropped after 
that.  Since div64.h is included from sched.h, that happens to be quite 
a few files.

#define do_div(n,base) ({ \
        unsigned long __mod; \
        if (unlikely(__builtin_constant_p(base) && !((base) & 
((base)-1)) && \
            (long)(base) > 0)) { \
                __mod = ((uint64_t)(n)) % ((unsigned long)(base));      \
                (n) = ((uint64_t)(n)) / ((unsigned long)(base)); \
        } else { \

The kernel proper is ok - since the optimization is done correctly and 
udivdi3 is never actually referenced, it gets dropped during the link 
phase.  Modules are not - the unresolved symbol stays there.

This leaves several options:

1) Forget the optimization altogether
2) Go back to the (base == 1) check
3) In the module post phase, strip extraneous unused external references 
from modules
4) Fixup module loading to work around the problem
5) Do an enumeration case for each possible constant divisor
6) Upgrade my silly old compiler and tools

This seems like a lot of work for a trivial optimization; for i386, 
perhaps #2 is the most appropriate - with a sufficiently new GCC, this 
optimization should be automatic for all architectures not hardcoding 
do_div as inline assembler.

Seems to have come full circle - the trivial extension turns out to have 
non-trivial side effects.  If only GCC were as easily extensible as 
sparse!  A __builtin_highest_one_bit() function would make it possible 
to use inline assembler without degenerating to individual cases for 
each bit.

Zachary Amsden
zach@vmware.com

Linus Torvalds wrote:

>On Wed, 27 Oct 2004, Linus Torvalds wrote:
>  
>
>>I could add a sparse check for "no side effects", if anybody cares (so 
>>that you could do
>>
>>	__builtin_warning(
>>		!__builtin_nosideeffects(base),
>>		"expression has side effects");
>>
>>in macros like these.. Sparse already has the logic internally..
>>    
>>
>
>Done. Except I called it __builtin_safe_p(). 
>
>The kernel sources already know about "__builtin_warning()" (and 
>pre-process it away on gcc), so if you have a new sparse setup (as of two 
>minutes ago ;), you can use this thing to check that arguments to macros 
>do not have side effects.
>
>Useful? You be the judge. But it was just a couple of lines in sparse, and
>doing so also made it obvious how to clean up __builtin_constant_p() a lot
>at the same time by just re-organizing things a bit.
>
>My inliner and statement simplificator isn't perfect, so inline functions
>sadly are not considered constant (or safe) even if they _do_ end up
>returning a constant value (or be safe internally).
>
>		Linus
>  
>

