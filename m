Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWCPQdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWCPQdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbWCPQdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:33:53 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:18583 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750908AbWCPQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:33:52 -0500
Date: Thu, 16 Mar 2006 11:30:43 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, PATCH 12/24] i386 Vmi processor header
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Jan Beulich <JBeulich@novell.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Virtualization Mailing List <virtualization@lists.osdl.org>
Message-ID: <200603161133_MC3-1-BACA-4C6C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200603131808.k2DI8KYs005714@zach-dev.vmware.com>

On Mon, 13 Mar 2006 10:08:20 -0800, Zachary Amsden wrote:

> Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_processor.h
> ===================================================================
> --- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_processor.h  2006-03-10 13:03:35.000000000 -0800
> +++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_processor.h       2006-03-10 13:03:35.000000000 -0800
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright (C) 2005, VMware, Inc.
> + *
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Send feedback to zach@vmware.com
> + *
> + */
> +
> +
> +#ifndef _MACH_PROCESSOR_H
> +#define _MACH_PROCESSOR_H
> +
> +#include <vmi.h>
> +
> +static inline void vmi_cpuid(const int op, int *eax, int *ebx, int *ecx, int *edx)
> +{
> +     vmi_wrap_call(
> +             CPUID, "cpuid",
> +             XCONC("=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)),
> +             1, "a" (op),
> +             VMI_CLOBBER(FOUR_RETURNS));
> +}
> +
> +/*
> + * Generic CPUID function
> + */
> +static inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
> +{
> +     vmi_cpuid(op, eax, ebx, ecx, edx);
> +}
> +
> +
> +/* Some CPUID calls want 'count' to be placed in ecx */
> +static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
> +             int *edx)
> +{
> +     asm volatile(""::"c"(count));
> +     vmi_cpuid(op, eax, ebx, ecx, edx);
> +}

You can't assume those last two statements will stay together.
>From the gcc 4.0.2 info file:

> <...> you can't expect a sequence of volatile `asm' instructions
> to remain perfectly consecutive.  If you want consecutive output, use a
> single `asm'.

Maybe you could make vmi_cpuid always take a 'count' param, then just make cpuid
do:

        vmi_cpuid(op, 0, eax, ebx, ecx, edx);

and cpuid_count do:

        vmi_cpuid(op, count, eax, ebx, ecx, edx);


(And sorry about trimming the cc: but I'm reading from a digest and that list
is too long to enter manually.)

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
