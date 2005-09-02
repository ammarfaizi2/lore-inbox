Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbVIBWox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbVIBWox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVIBWox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:44:53 -0400
Received: from smtpout.mac.com ([17.250.248.87]:8920 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161093AbVIBWow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:44:52 -0400
In-Reply-To: <dfahpa$an2$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902214231.GA10230@ccure.user-mode-linux.org> <dfahpa$an2$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F74838E-651D-4952-BD7C-63B09D76F743@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 18:44:41 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 17:55:54, H. Peter Anvin wrote:
>> UML really needs something like this, both 1 and 2.  See
>>     http://groups.google.com/group/fa.linux.kernel/browse_thread/ 
>> thread/34d3c02372861a5c/71816a3c7863ea2b?lnk=st&q=%22jeff+dike% 
>> 22&rnum=27&hl=en#71816a3c7863ea2b
>> for my take on system.h and ptrace.h when a change in the host
>> architecture broke the UML build.
>>
>> UML takes most of its headers from the underlying arch.  It  
>> simplifies
>> things since most of the definitions are usable in UML.  I don't have
>> to clone and maintain my versions of all the other arch headers.
>>
>> OTOH, there are things in those headers which UML can't use, and  
>> these
>> are eliminated in various ways (undefining them after the include of
>> the host arch header, redefining them before the include).  But this
>> is a pain.
>>
>> It has long been my opinion that splitting headers into userspace
>> usable and userspace unusable pieces is the right thing for UML.   
>> Less
>> clear for the host arch.
>>
>> Your post seems to indicate that there is a non-UML demand for  
>> exactly
>> this.
>
> There definitely is.  The kernel needs to export its ABI in a way that
> userspace (UML, various libcs, etc) can import in a sane manner.  In
> addition, the Linux kernel contains a fair bit of
> architecture-specific support which go well beyond what one can
> typically find in userspace, and it would be nice to have those.
>
> The current linux-libc-headers aren't it, because they have a fair bit
> of glibc-centric assumptions in those headers.  That's part of why
> klibc doesn't use them.

What I would try to do is package up as much architecture/abi knowledge
in one place as possible, the former in kcore/kern-core/whatever, the
latter in kabi/kern-abi/linux-abi/whatever.  I would also try (as much
as possible), to make everything in those directories use some kind of
prefix guaranteed not to clash with other stuff, so list_add() for
example would become _kcore_list_add().  The linux kernel headers in
such a modified kernel would then just do this to make the kernel code
happy:
#ifdef __KERNEL__
# define list_add(x,y) _kcore_list_add(x,y)
/*....*/
#endif

My far-into-the-future ideal for this is to have a generic vDSO-type
library that is compiled into the kernel that provides a collection of
architecture-optimized routines available in both kernelspace and
userspace by mapping it into each process' address space.  Such a
library could effectively automatically provide correct and optimized
assembly routines for the currently booted CPU/arch/subarch/etc, so
that userspace tools could be compiled once and run on an entire
family of CPUs without modification.  On the other hand, for those
applications that need every last ounce of speed (Including parts of
the kernel), you could pass appropriate options to the compiler to
tell it to inline the assembly routines (alternative) for a single
CPU make/model.

Possibly some of the generic-arch stuff should be pushed back
upstream to GCC, maybe have __builtin_{s,u,i,f}{8,16,32,64,128} types,
etc, provided directly by GCC, so we don't have to mess with that
so much.

> We should probably also consider the licensing of headers that are
> meant to be included into userspace.  Userspace still includes a fair
> bit of GPL headers, which is technically not kosher.

I think that this is mostly a nonissue.  The copyright holders of the
headers/inline assembly/etc should look at perhaps licensing those
as LGPL or providing an exception to allow glibc, klibc, etc to link
with them.  On the other hand, were glibc to use the optimized
routines to provide the Standard C Library, programs using said
Standard C Library would not be infringing, because just like with
the "userspace <=syscall=> kernelspace" boundary, that does not imply
that the code is a derived work.  IANAL, however, so if you know one
who is willing to contribute some time, this might be an interesting
issue.  (Also:  What procedure might be required to get some of the
stuff relicensed as LGPL?  How do we find all significant copyright
holders/contributors from whom we need permission?)

Thanks for the encouraging posts!  It's good to hear that others are
interested in the project, because maybe I won't need to do it _all_
myself :-D.  I'll take a look at the patches mentioned, to get more
of an idea on the various technical issues.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



