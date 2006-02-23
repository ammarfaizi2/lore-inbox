Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBWC4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBWC4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBWC4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:56:53 -0500
Received: from ozlabs.org ([203.10.76.45]:49823 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750712AbWBWC4w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:56:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17405.9318.991684.872546@cargo.ozlabs.ibm.com>
Date: Thu, 23 Feb 2006 13:56:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: klibc@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
In-Reply-To: <43FCDB8A.5060100@zytor.com>
References: <43FCDB8A.5060100@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> I've looked through the code for sys_mmap2 on several architectures, and 
> it looks like some architectures plays by the "shift is always 12" rule, 
>   e.g. SPARC, and some expect userspace to actually obtain the page 
> size, e.g. PowerPC and MIPS.  On some architectures, e.g. x86 and ARM, 
> the point is moot since PAGE_SIZE is always 2^12.
> 
> a. Is this correct, or have I misunderstood the code?

PowerPC always uses 12, even if PAGE_SHIFT is 16 (i.e. for 64k
pages).

> b. If so, is this right, or is this a bug?  Right now both klibc and 
> µClibc consider the latter a bug.

Glibc seems to expect it to always be 12, according to this excerpt
from sysdeps/unix/sysv/linux/mmap64.c:

/* This is always 12, even on architectures where PAGE_SHIFT != 12.  */
# ifndef MMAP2_PAGE_SHIFT
#  define MMAP2_PAGE_SHIFT 12
# endif

I would be very reluctant to change the shift to be PAGE_SHIFT, since
that would be a change in the user/kernel ABI.  Of course, userspace
is still expected to make sure addresses and offsets are multiples of
the page size (and thus the offset argument to mmap2 has to be a
multiple of 16 if the page size is 64k).

Regards,
Paul.
