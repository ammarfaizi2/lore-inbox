Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSCYRRn>; Mon, 25 Mar 2002 12:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312468AbSCYRRe>; Mon, 25 Mar 2002 12:17:34 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:55742 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312466AbSCYRR3>; Mon, 25 Mar 2002 12:17:29 -0500
Date: Mon, 25 Mar 2002 09:17:21 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@zip.com.au>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020325091721.B13707@lucon.org>
In-Reply-To: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au> <20020324012819.A13155@lucon.org> <20020325003159.A2340@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:31:59AM -0500, Theodore Tso wrote:
> On Sun, Mar 24, 2002 at 01:28:19AM -0800, H . J . Lu wrote:
> > 
> > The problem is not all arches use (~0UL) for RLIM_INFINITY.
> > 
> > What should we do about it? I know e2fsprogs-1.26 doesn't work on mips
> > nor alpha because of this. I don't think it works on sparc.
> 
> Yeah, I forced the release of e2fsprogs 1.27 because of this, back on
> March 8th.  That was my fault, and I fixed it as soon as I discovered
> it.  (1.26 was released on Feb 3, and I released 1.27 on March 8th).
> 
> In e2fsprogs 1.27, I do the following:
> 
> #ifdef __linux__
> #undef RLIM_INFINITY
> #if (defined(__alpha__) || ((defined(__sparc__) || defined(__mips__)) && (SIZEOF_LONG == 4)))
> #define RLIM_INFINITY	((unsigned long)(~0UL>>1))
> #else
> #define RLIM_INFINITY  (~0UL)
> #endif
> 
> Basically because I can't depend on the RLIM_INFINITY being "right".
> (Remember, I'm trying to make sure that e2fsprogs can compile on any
> arbitrary glibc, and then run on any other-not-necessarily-the-same
> glibc, which gets "challenging".)
> 

The current glibc has no problem. You can just use RLIM_INFINITY
defined in GLIBC, not the kernel. The same static e2fsck binary will
work fine on both new and old kernels. But I don't know if you want
to pull the full setrlimit implemenation from glibc. I am enclosing
the i386 version here.



H.J.
---
/* Copyright (C) 1999, 2000 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#include <errno.h>
#include <sys/param.h>
#include <sys/resource.h>

#include <sysdep.h>
#include <sys/syscall.h>
#include <shlib-compat.h>
#include <bp-checks.h>

#include "kernel-features.h"

extern int __syscall_setrlimit (unsigned int resource,
				const struct rlimit *__unbounded rlimits);
extern int __syscall_ugetrlimit (unsigned int resource,
				 const struct rlimit *__unbounded rlimits);
extern int __new_setrlimit (enum __rlimit_resource resource,
			    const struct rlimit *__unboundedrlimits);

/* Linux 2.3.25 introduced a new system call since the types used for
   the limits are now unsigned.  */
#if defined __NR_ugetrlimit && !defined __ASSUME_NEW_GETRLIMIT_SYSCALL
extern int __have_no_new_getrlimit; /* from getrlimit.c */
#endif

int
__new_setrlimit (enum __rlimit_resource resource, const struct rlimit *rlimits)
{
#ifdef __ASSUME_NEW_GETRLIMIT_SYSCALL
  return INLINE_SYSCALL (setrlimit, 2, resource, CHECK_1 (rlimits));
#else
  struct rlimit rlimits_small;

# ifdef __NR_ugetrlimit
  if (__have_no_new_getrlimit == 0)
    {
      /* Check if the new ugetrlimit syscall exists.  We must do this
	 first because older kernels don't reject negative rlimit
	 values in setrlimit.  */
      int result = INLINE_SYSCALL (ugetrlimit, 2, resource, __ptrvalue (&rlimits_small));
      if (result != -1 || errno != ENOSYS)
	/* The syscall exists.  */
	__have_no_new_getrlimit = -1;
      else
	/* The syscall does not exist.  */
	__have_no_new_getrlimit = 1;
    }
  if (__have_no_new_getrlimit < 0)
    return INLINE_SYSCALL (setrlimit, 2, resource, CHECK_1 (rlimits));
# endif

  /* We might have to correct the limits values.  Since the old values
     were signed the new values might be too large.  */
  rlimits_small.rlim_cur = MIN ((unsigned long int) rlimits->rlim_cur,
				RLIM_INFINITY >> 1);
  rlimits_small.rlim_max = MIN ((unsigned long int) rlimits->rlim_max,
				RLIM_INFINITY >> 1);

  /* Use the adjusted values.  */
  return INLINE_SYSCALL (setrlimit, 2, resource, __ptrvalue (&rlimits_small));
#endif
}

weak_alias (__new_setrlimit, __setrlimit);
versioned_symbol (libc, __new_setrlimit, setrlimit, GLIBC_2_2);
