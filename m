Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWCXWqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWCXWqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCXWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:46:54 -0500
Received: from smtpout.mac.com ([17.250.248.73]:3021 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932160AbWCXWqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:46:53 -0500
In-Reply-To: <878xqzpl8g.fsf@hades.wkstn.nix>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
Cc: Rob Landley <rob@landley.net>, Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Fri, 24 Mar 2006 17:46:27 -0500
To: Nix <nix@esperi.org.uk>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006, at 16:48:47, Nix wrote:
> On 24 Mar 2006, Rob Landley suggested tentatively:
>> On Friday 24 March 2006 1:51 pm, Kyle Moffett wrote:
>>> 1: Ewww, bad glibc!
>>> 2: The symbols in kabi/*.h should probably all start with __kabi_
>>
>> Any grand new incompatible thing is something I will happily  
>> ignore for as long as I am able to, and I'm not alone here.  Your  
>> uptake will be zero.
>
> I concur. The purpose of this thing is by definition to provide  
> libcs with the kernel/user interface stuff they need in order for  
> userspace programs to be compiled. There's no point defining a new  
> interface because there is a massive quantity of *existing* code  
> out there that we must work with. (Plus, it can be, uh, difficult  
> to get changes of this nature into glibc in particular, and glibc  
> is the 300-pound gorilla in this particular room. If the headers  
> don't have working with it as a goal, they are pointless.)

Hmm, I didn't really explain my idea very well.  Let me start with a  
list of a facts.  If anybody disagrees with any part of this, please  
let me know.

1)  The <linux/*.h> headers include a lot of information essential to  
compiling userspace applications and libraries (libcs in  
particular).  That same information is also required while building  
the kernel (IE: The ABI).
2)  Those headers have a lot of declarations and definitions which  
must *not* be present while compiling userspace applications, and is  
basically kernel-only stuff.
3)  Glibc is extremely large and complex 500-pound gorilla and  
contains an ugly build process and a lot of static definitions in its  
own header files that conflict with the definitions in the kernel  
headers.
4)  UML runs into a lot of problems when glibc's headers and the  
native kernel headers headers conflict.

Here's some of my opinions about this:

1)  Trying to create and maintain 2 separate versions of an ABI as  
large and complex as the kernel<=>userspace ABI across new versions  
and features would be extremely difficult and result in subtle bugs  
and missing features, even over a short period of time.
2)  Ideally there should be three distinct pieces, the kernel, the  
ABI, and userspace.  Compiling either the kernel or userspace  
requires the ABI, but the ABI depends only on the compiler.
3)  Breaking any compatibility is bad
4)  Trying to continue to maintain the glibc custom-header-file  
status-quo as more APIs and architectures get added to the kernel is  
going to become an increasingly difficult and tedious task.

My proposal (which I'm working on sample patches for) would be to  
divide up the kernel headers into 2 parts.  The first part would be  
<kabi/*.h>, and the second would be all the traditional kernel-only  
headers.  The kabi headers would *only* define things that begin with  
the prefix __kabi_.  This would mean that the kabi headers have no  
risk of namespace contamination with anything else existing in the  
kernel or userspace, and since they would depend only on the  
compiler, they would be useable anywhere.

The second step would be to convert the traditional linux header to  
include the corresponding kabi header, then redefine its own  
structures and defines in terms of those in the kabi header.  This  
would provide complete backwards compatibility to all kernel code, as  
well as to anything that currently compiles using the existing kernel  
headers.  The entire rest of the <linux/*.h> header file would be  
wrapped in #ifdef __KERNEL__, as it should not be needed by anything  
in userspace.

In the process of those two steps, we would relocate many of the  
misplaced "#ifdef __KERNEL__" and "#endif /* __KERNEL__ */".  The  
kabi headers should not mention __KERNEL__ at all, and the linux/*  
headers should be almost completely wrapped in __KERNEL__ ifdefs.   
That should be enough to make klibc build correctly, although from  
the description glibc needs significantly more work.

Once a significant portion of the kernel headers have been split that  
way (preserving complete backwards compatibility), external projects  
_may_ be converted to #include <kabi/*.h> instead of #include <linux/ 
*.h>, although this would require other changes to the source to  
handle the __kabi_ prefix.  Most of those should be straightforward,  
however.  Since the kabi/*.h headers would not be kernel-version- 
specific, they could be copied to a system running an older kernel  
and reused there without problems.  Even though some of the syscalls  
and ioctls referenced in the kabi headers might not be present on the  
running kernel, portable programs are expected to be able to sanely  
handle older kernels.

Once the kabi headers are available, it would be possible to begin  
cleaning up many of the glibc headers without worrying about  
differences between architectures.  If all critical constants and  
datatypes are already defined in <kabi/*.h> with __kabi_ or __KABI_  
prefixes, it should be possible to import those definitions into  
klibc and glibc without much effort.

UML has other issues with conflicts between the native kernel headers  
and the GLIBC-provided stubs.  It's been mentioned on the prior  
threads about this topic that this sort of system would ease most of  
the issues that UML runs into.

I'm working on some sample patches now which I'll try to post in a  
few days if I get the time.

Cheers,
Kyle Moffett

