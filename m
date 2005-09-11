Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbVIKAdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbVIKAdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVIKAdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:33:52 -0400
Received: from smtpout.mac.com ([17.250.248.73]:19406 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932734AbVIKAdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:33:51 -0400
In-Reply-To: <20050910150446.116dd261.akpm@osdl.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com> <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Sat, 10 Sep 2005 20:33:18 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 10, 2005, at 18:04:46, Andrew Morton wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> When I started trying to split out the userspace<=>kernelspace ABI
>> headers, I found a number of things (such as __ASSEMBLY__) that
>> would not operate properly in userspace.
>
> Oh, OK.

[questions reordered to fit the answers better :-D]

> What's the status of this userspace ABI project?  How far along is it?

It's just getting started.  This is patch #1 :-D  Unfortunately, this
project will basically touch most or all of the header files, because
anything that userspace wants to use (IOCTLs, structs, etc) needs to
be put into a separate directory tree.  We've kind of tentatively
assigned "kabi" and "kcore" to that, but it's still really preliminary.

> Is it a thing we want to do?

The UML people really want this, because it would mean that UML could
completely ignore libc for most of its code and just use the ABI and
kcore headers.  Since these headers would have a specially defined
private namespace, they would be trivially useable from various libc
implementations as well.  (IE: everything begins with __kabi_ or
__kcore_, except for macros which begin with __KABI_ or __KCORE_).
The target for this is to also provide (in <kcore/*.h>) some optimized
inline routines for user programs to use, some LGPL and others GPL.
One example would be list.h, which I've copied and hacked on several
times for various other GPL projects I've done work on.

> Have we worked out how it is to be done?

Here's what we've got so far:

1)  At some point the arch/driver/etc maintainers (for anything that
interacts with userspace), need to start converting things on their
own (such as moving ioctl and struct declarations to a <kabi/*.h>
header file), because the people working on it certainly don't have
all the varieties of hardware and userspace programs that would be
affected by this change.

2)  The goal is to minimize changes to kernel code.  I'm not out to
rename "struct list_head", that would be silly!  Instead, the header
<linux/list.h>  would be basically reduced to this:

#ifndef  __LINUX_LIST_H
# define __LINUX_LIST_H 1
# ifdef __KERNEL__

#  define __kcore_list_item list_head
#  include <kcore/list.h>
#  define list_add(x,y) __kcore_list_add(x,y)

[...etc...]

# endif /* __KERNEL__ */
#endif /* not __LINUX_LIST_H */

3)  Another side effect of this project will be that we will have
the chance to clean up and merge some of the stuff currently in
the asm-* directories.  For example, the posix_types.h headers on
most of the architectures have the same sizes for each type, only
a few are different.  With this we have a chance to have the few
weird architectures do:
   #define __KABI_ARCH_TYPE_*_T __kabi_[su][0-9]+_t
Then all the rest just use the default.  This would make it much
easier and less error-prone to add a new architecture, because
you would have a really small set of structs, types, definitions,
etc in <kabi/arch-*/*.h> that are _required_ across all
architectures, and most of the stuff in asm-*/*.h would be header
files for code that exists only on a _single_ architecture.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


