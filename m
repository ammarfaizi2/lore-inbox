Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDBFxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDBFxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWDBFxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:53:55 -0500
Received: from smtpout.mac.com ([17.250.248.70]:27596 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751100AbWDBFxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:53:54 -0500
In-Reply-To: <1143946866.3056.4.camel@laptopd505.fenrus.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <20060329222640.GA2755@ucw.cz> <20060401162213.dc68d120.rdunlap@xenotime.net> <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com> <1143946866.3056.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5AC6F01C-8010-4A28-A303-52F7F11B84BF@mac.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Date: Sun, 2 Apr 2006 00:53:15 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2006, at 22:01:06, Arjan van de Ven wrote:
> On Sat, 2006-04-01 at 21:42 -0500, Kyle Moffett wrote:
>
>> (1)  The various C standards state that the implementation should  
>> restrict itself to symbols prefixed with "__", everything else is  
>> reserved for user code (Including symbols prefixed with a single  
>> underscore).
>
> user code in this context includes, in my interpretation, headers  
> for specific ioctl structures and such (eg direct included headers;  
> headers that those headers include are a different matter) that the  
> user wants.
>
> Which is the vast majority of the kernel abi. Exceptions are things  
> like __u64 which are almost always "indirectly" included. Eg the  
> app wants "struct foo_ioctl" and foo_ioctl happens to contain an  
> __u64 which needs types.h

I get the impression that you're confusing my KABI proposal with  
kernel-only code.  The point of KABI is to generalize some of the  
headers so that they work both in userspace and kernelspace, even if  
it means that the headers themselves aren't as clean as they might  
otherwise be.  In the kernel we have only one API where we have to  
deal with compatibility: the kernel/userspace boundary.  I'd like to  
strictly define all of that compatibility within a single set of  
_upstream_ headers in linux/include/linux-kabi or similar.

But returning to your statements above, user code in that (C  
standards) context means anything not standard-specified.  Basically,  
from userspace, a program that includes _any_ standard-specified  
header must bring in *only* those symbols specified by the standard  
as being present in that header, as well as any implementation- 
defined double-underscore symbols.  So unless I "#include  
<stdint.h>", my user program can typedef uint32_t to anything it  
wants, even a struct, if it likes.  I've actually done that before on  
a very strange Cray platform with non-GCC compiler and OS that only  
supported 64-bit integers (a char was a 64-bit integer with ops to  
mask out the upper 56 bits), just to make bzip2 work as expected.   
The same rules apply for _every_ other standard-specified header  
(stdlib.h, stdio.h, sys/types.h, etc).

> the good news is that as kernel we have SOME power ;) people who  
> make compilers like that stay away from symbols the kernel defines.  
> Especially gcc is very careful in its namespace use and tends to be  
> very different from what linux kernel uses.

As I said above, I'm talking about the proposed kernel ABI headers  
here.  The whole point of these is something that both the kernel  
_and_ userspace can include.  This means that the headers must allow  
a libc that includes them to be completely standards-compliant.  It  
also means that these headers must work not only for GCC, but also  
for tcc and icc and the myriad of other compilers I mentioned (the  
ones that I got so many emails about in the "Non-GCC compilers" thread).

>> So my question to the list is this:  Can you come up with any way  
>> other than using a "__kabi_" prefix to   reasonably avoid  
>> namespace collisions with that large list of compilers?
>
> First of all be realistic. Don't do silly things for places where  
> it doesn't matter. Again the ioctl structs come to mind. Second,  
> names the kernel ALREADY claims are of course free to use as well;  
> all those compilers ALREADY stay away from those.

Agreed (to some extent).  I'm still evaluating a lot of the code, I  
plan to submit several non-KABI cleanups first to prepare the way.   
I'll try to get you specific patches so you can give me specific  
rejections, ok? :-D  I have the feeling that we both see things the  
same way but have difficulty communicating due to the lack of examples.

> What is left if you take those two big ones out of the picture?

First of all, there seems to be a lot of little bits of code that the  
KABI headers really want to use but can't right now.  For example,  
the asm-*/bitops.h headers contain inline functions for a variety of  
nonatomic bitops that are _identical_ to the FD_SET code implemented  
in asm-*/posix-types.h.  Likewise it appears there are other standard- 
specified bitmask manipulation functions that KABI wants to implement  
using those.  Unfortunately those bitmask functions are only  
available in kernel space, although a few architectures were having  
extensive fun with header inclusion loops or implicit inclusion just  
to get access to them.  Unfortunately this made it impossible to use  
those headers in userspace.

It would be really nice if some of that architecture-specific  
duplication could be consolidated into a single header file useable  
from the userspace-pertinent KABI headers _and_ directly from kernel  
code.

> there is another dynamic; those other compilers in general try to  
> emulate gcc to a large degree, usually a very large degree. So the  
> "problem" you see is a lot smaller than you think.

Please read in detail the responses to the non-gcc compiler thread  
that I mentioned before.  Apparently a number of the compilers only  
take care to conform to the C89 or C99 specifications, which state  
that such symbols are perfectly ok for them to use, and as a result  
such "Just like GCC" behavior cannot be relied upon for kernel/ 
userspace-ABI headers.

Cheers,
Kyle Moffett

