Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSABP7W>; Wed, 2 Jan 2002 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSABP7N>; Wed, 2 Jan 2002 10:59:13 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:5248 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287859AbSABP7E>; Wed, 2 Jan 2002 10:59:04 -0500
Date: Wed, 2 Jan 2002 08:59:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102155900.GC1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102112821.GA13212@vitelus.com> <87u1u5yoa1.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u1u5yoa1.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 01:40:06PM +0200, Momchil Velikov wrote:
> 
> >>>>> "Aaron" == Aaron Lehmann <aaronl@vitelus.com> writes:
> 
> Aaron> On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
> >> Thus
> >> strcpy (dst, "abcdef" + 2)
> >> gives
> >> memcpy (dst, "abcdef" + 2, 5)
> 
> Aaron> IMHO gcc should not be touching these function calls, as they are not
> Aaron> made to a standard C library, and thus have different behaviors. I'm
> Aaron> suprised that gcc tries to optimize calls to these functions just
> Aaron> based on their names.
> 
> IIRC, these identifiers are reserved by the C standard, thus the
> compiler is right to assume that they have standard behavior. And note
> that they DO have the standard behavior. It even doesn't matter if GCC
> is right to judge by the names in each and every case, it is right
> in _this_ case.

Right.  The problem here is that this happens to be at a very early
point in the code (from arch/ppc/kernel/prom.c):
/*
 * Note that prom_init() and anything called from prom_init() must
 * use the RELOC/PTRRELOC macros to access any static data in
 * memory, since the kernel may be running at an address that is
 * different from the address that it was linked at.
 * (Note that strings count as static variables.)
 */

Which is where the trouble comes in.

> Aaron> The gcc manpage mentions
> 
> Aaron>        -ffreestanding
> Aaron>            Assert that compilation takes place in a freestanding
> Aaron>            environment.  This implies -fno-builtin.  A freestand?
> Aaron>            ing environment is one in which the standard library
> Aaron>            may not exist, and program startup may not necessarily
> Aaron>            be at "main".  The most obvious example is an OS ker?
> Aaron>            nel.  This is equivalent to -fno-hosted.
> 
> Aaron> Why is Linux not using this? It sounds very appropriate. The only
> 
> Because it results in less optimization. I see no point in
> deliberately preventing the compiler from doing optimizations.

Right.  There's only a very small number of files which _might_ be
effected by this optimization.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
