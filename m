Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKSVCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKSVCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKSVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:02:28 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:12593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261568AbUKSU7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:59:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=WOBu/t5bP2SrFQs+QC8eNwoYlTQqArwnF3NnQRyEmn/JGypW5aRiCY4OhcujsrYFo/CkJyo00L9R/Hrrh2weItvpQIn5Osn7WpC+RLkbYMvD4iQkrsU0nBzpF36BxEZnbIxhSIH9KqpwmhP2KG9OBwl3rbSYxrgxWmCqGuENDTg=
Message-ID: <69304d1104111912591af3fe89@mail.gmail.com>
Date: Fri, 19 Nov 2004 21:59:49 +0100
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Altivec support for RAID-6
In-Reply-To: <69304d1104111904046d02b5bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2853_17760180.1100897989712"
References: <419C46C7.4080206@zytor.com>
	 <69304d1104111812234656a606@mail.gmail.com>
	 <cnjuvi$um8$1@terminus.zytor.com>
	 <69304d1104111904046d02b5bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2853_17760180.1100897989712
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 19 Nov 2004 13:04:11 +0100, Antonio Vargas <windenntw@gmail.com> wrote:
> On Fri, 19 Nov 2004 05:05:54 +0000 (UTC), H. Peter Anvin <hpa@zytor.com> wrote:
> > Followup to:  <69304d1104111812234656a606@mail.gmail.com>
> > By author:    Antonio Vargas <windenntw@gmail.com>
> > In newsgroup: linux.dev.kernel
> > >
> > > hpa, are you aware of any other routines which should benefit from altivec?
> > >
> >
> > Presumably the XOR code used by RAID-5, and quite possibly some of the
> > cryptography stuff.  Unlike most SIMD instruction sets, it should be
> > possible to write AES using Altivec.
> 
> I'll take a crack at the RAID-5 stuff first then.
> 

Here we go... this file is compile-tested on gcc 3.3 from userspace,
it can serve as an starting point for testing.

Signed-off-by: Antonio Vargas <windenntw@gmail.com>

-- 
Greetz, Antonio Vargas aka winden of network

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.

------=_Part_2853_17760180.1100897989712
Content-Type: text/plain; name="xor.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="xor.h"

/*
 * include/asm-ppc/xor.h
 *
 * Altivec optimized RAID-5 checksumming functions.
 * Copyright 2004 Antonio Vargas, windenntw@gmail.com
 *
 * Based on include/asm-generic/xor.h and drivers/md/raid6altivec.uc
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 2.
 *
 * You should have received a copy of the GNU General Public License
 * (for example /usr/src/linux/COPYING); if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#ifdef KERNEL
#include <asm-generic/xor.h>
#endif

#ifdef CONFIG_ALTIVEC

#ifdef KERNEL
#include <altivec.h>
#include <asm/cputable.h>
#include <asm/processor.h>
#include <asm/system.h>
#else
#define prefetch(x)
#define prefetchw(x)
void enable_kernel_altivec(){};
void preempt_enable(){};
void preempt_disable(){};
#endif

typedef vector unsigned char unative_t;

#define BODY\
=09long lines =3D bytes / (4 * sizeof(unative_t)) - 1;\
=09int i;\
=09preempt_disable();\
=09enable_kernel_altivec();\
=09PREF(0)\
=09do {\
=09=09PREF(4);\
=09=09CALC(0);\
=09=09CALC(1);\
=09=09CALC(2);\
=09=09CALC(3);\
=09=09INC;\
=09} while (--lines > 0);\
=09for(i =3D 0 ; i < 4 ; i++)\
=09=09CALC(i);\
=09preempt_enable();


#define PREF2(x) prefetchw(p1 + x); prefetch(p2  + x);
#define PREF3(x) PREF2(x) prefetch(p3  + x);
#define PREF4(x) PREF3(x) prefetch(p4  + x);
#define PREF5(x) PREF4(x) prefetch(p5  + x);

#define CALC2(x) p1[x] ^=3D p2[x]
#define CALC3(x) CALC2(x) ^ p3[x]
#define CALC4(x) CALC3(x) ^ p4[x]
#define CALC5(x) CALC4(x) ^ p5[x]

#define INC2 p1 +=3D 4; p2 +=3D 4;
#define INC3 INC2 p3 +=3D 4;
#define INC4 INC3 p4 +=3D 4;
#define INC5 INC4 p5 +=3D 4;

static void
xor_altivec2(unsigned long bytes, unative_t *p1, unative_t *p2)
{
#undef PREF
#undef CALC
#undef INC
#define PREF(x) PREF2(x)
#define CALC(x) CALC2(x)
#define INC     INC2
=09BODY
}

static void
xor_altivec3(unsigned long bytes, unative_t *p1, unative_t *p2, unative_t *=
p3)
{
#undef PREF
#undef CALC
#undef INC
#define PREF(x) PREF3(x)
#define CALC(x) CALC3(x)
#define INC     INC3
=09BODY
}


static void
xor_altivec4(unsigned long bytes, unative_t *p1, unative_t *p2, unative_t *=
p3, unative_t *p4)
{
#undef PREF
#undef CALC
#undef INC
#define PREF(x) PREF4(x)
#define CALC(x) CALC4(x)
#define INC     INC4
=09BODY
}

static void
xor_altivec5(unsigned long bytes, unative_t *p1, unative_t *p2, unative_t *=
p3, unative_t *p4, unative_t *p5)
{
#undef PREF
#undef CALC
#undef INC
#define PREF(x) PREF5(x)
#define CALC(x) CALC5(x)
#define INC     INC5
=09BODY
}

#ifdef KERNEL
static struct xor_block_template xor_block_altivec =3D {
=09.name =3D "altivec",
=09.do_2 =3D xor_altivec2,
=09.do_3 =3D xor_altivec3,
=09.do_4 =3D xor_altivec4,
=09.do_5 =3D xor_altivec5,
};

#undef  XOR_TRY_TEMPLATES
#define XOR_TRY_TEMPLATES                       \
=09do {                                    \
=09=09xor_speed(&xor_block_8regs);    \
=09=09xor_speed(&xor_block_8regs_p);  \
=09=09xor_speed(&xor_block_32regs);   \
=09=09xor_speed(&xor_block_32regs_p); \
=09=09xor_speed(&xor_block_altivec);  \
=09} while (0)
#endif

#endif

------=_Part_2853_17760180.1100897989712--
