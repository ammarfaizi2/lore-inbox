Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311875AbSCXJ2s>; Sun, 24 Mar 2002 04:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311877AbSCXJ2j>; Sun, 24 Mar 2002 04:28:39 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:9699 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311875AbSCXJ23>; Sun, 24 Mar 2002 04:28:29 -0500
Date: Sun, 24 Mar 2002 01:28:19 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: tytso@thunk.org, linux-mips@oss.sgi.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020324012819.A13155@lucon.org>
In-Reply-To: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 11:03:30PM -0800, Andrew Morton wrote:
> "H . J . Lu" wrote:
> > 
> > ...
> > RLIM_INFINITY is not ((unsigned long)(~0UL)). Also you can't assume
> > the type of rlim.rlim_cur.
> > 
> > Here is a patch.
> > 
> 
> I suspect it's not right.
> 
> I don't pretend to understand the details, but they're
> messy.   See Ted's recent words at
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.2/0846.html
> 

I look at the glibc code. It uses a constant RLIM_INFINITY for a given
arch. The user always passes (~0UL) to glibc on x86. glibc will check
if the kernel supports the new getrlimit at the run time. If it
doesn't, glibc will adjust the RLIM_INFINITY for setrlimit. I don't see
how glibc 2.2.5 compiled under kernel 2.2 will fail under 2.4 due to
this unless glibc is misconfigureed or miscompiled.

> (Sorry - I should have dug that message out earlier).

The problem is not all arches use (~0UL) for RLIM_INFINITY.

# cd linux/include
# grep RLIM_INFINITY asm-*/resource.h | grep define
asm-alpha/resource.h:#define RLIM_INFINITY      0x7ffffffffffffffful
asm-arm/resource.h:#define RLIM_INFINITY        (~0UL)
asm-cris/resource.h:#define RLIM_INFINITY       (~0UL)
asm-i386/resource.h:#define RLIM_INFINITY       (~0UL)
asm-ia64/resource.h:#define RLIM_INFINITY  (~0UL)
asm-m68k/resource.h:#define RLIM_INFINITY       (~0UL)
asm-mips64/resource.h:#define RLIM_INFINITY  (~0UL)
asm-mips/resource.h:#define RLIM_INFINITY       0x7fffffffUL
asm-parisc/resource.h:#define RLIM_INFINITY   (~0UL)
asm-ppc/resource.h:#define RLIM_INFINITY        (~0UL)
asm-s390/resource.h:#define RLIM_INFINITY   (~0UL)
asm-s390x/resource.h:#define RLIM_INFINITY   (~0UL)
asm-sh/resource.h:#define RLIM_INFINITY (~0UL)
asm-sparc64/resource.h:#define RLIM_INFINITY    (~0UL)
asm-sparc/resource.h:#define RLIM_INFINITY      0x7fffffff

What should we do about it? I know e2fsprogs-1.26 doesn't work on mips
nor alpha because of this. I don't think it works on sparc.

BTW, mips has

/*
 * SuS says limits have to be unsigned.
 * Which makes a ton more sense anyway.
 */
#define RLIM_INFINITY   0x7fffffffUL

It doesn't make any senes.


H.J.
