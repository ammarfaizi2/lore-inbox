Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSKYTyK>; Mon, 25 Nov 2002 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKYTyK>; Mon, 25 Nov 2002 14:54:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25861 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265612AbSKYTyE>; Mon, 25 Nov 2002 14:54:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Date: Mon, 25 Nov 2002 20:00:30 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <artvgu$bgr$1@penguin.transmeta.com>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au> <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com> <20021123051628.GA3658@krispykreme>
X-Trace: palladium.transmeta.com 1038254469 26330 127.0.0.1 (25 Nov 2002 20:01:09 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Nov 2002 20:01:09 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021123051628.GA3658@krispykreme>,
Anton Blanchard  <anton@samba.org> wrote:
>
>_t32 == 32 bit version, its not the size. eg

Oh, I realize that. What I do not see is the point of the typedefs AT
ALL. They must go. They are crap. They have no reason for their
existence.

>asm-ia64/ia32.h:		typedef unsigned short	__kernel_ipc_pid_t32;
>asm-mips64/posix_types.h:	typedef int		__kernel_ipc_pid_t32;
>asm-parisc/posix_types.h:	typedef unsigned short	__kernel_ipc_pid_t32;
>asm-ppc64/ppc32.h:		typedef unsigned short	__kernel_ipc_pid_t32;
>asm-sparc64/posix_types.h:	typedef unsigned short	__kernel_ipc_pid_t32;
>asm-x86_64/ia32.h:		typedef unsigned short	__kernel_ipc_pid_t32;
>
>Or do you mean we should use typedef u16 __kernel_ipc_pid_t32? Yeah,
>I can understand that.

That helps, by removing half of the reason why they are crap - the using
of types that are not architecture-safe in a generic ABI file. But the
other half of the reason is still there:

It doesn't remove the rest of the reason: that "__kernel_" prefix is
meaningless (since the type shouldn't be visible in a non-kernel
namespace ANYWAY, and that is the only reason for the prefix in the
first place). 

Basically, you have two cases:

 - you have types that are _truly_ generic 32-bit compatibility stuff,
   and are the same on all architectures that use this compatibility
   layer. 

   But if they are truly generic, they shouldn't need a new typedef AT
   ALL.  You should just realize that "loff_t" is always a "s64", and
   then just use s64 in the compatibility functions/structures. No need
   to make up some new typedef.

 - You have types (like the above) where the compatibility layer
   actually has _different_ types for different architectures. In which
   case they should be in an architecture-specific file, not in some
   generic file. And the name should not be "__kernel_xxxx_t32", but
   "compat32_xxxx_t" or something.

In _neither_ case is it valid to have a generic architecture-independent
file that makes up new types.  See? And THAT is why I thin kthe patch is
crud. 

		Linus
