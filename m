Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWBWDgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWBWDgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 22:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBWDgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 22:36:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22460 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750727AbWBWDgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 22:36:15 -0500
Message-ID: <43FD2D96.7030600@zytor.com>
Date: Wed, 22 Feb 2006 19:35:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: klibc@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <17405.9318.991684.872546@cargo.ozlabs.ibm.com>
In-Reply-To: <17405.9318.991684.872546@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
>>I've looked through the code for sys_mmap2 on several architectures, and 
>>it looks like some architectures plays by the "shift is always 12" rule, 
>>  e.g. SPARC, and some expect userspace to actually obtain the page 
>>size, e.g. PowerPC and MIPS.  On some architectures, e.g. x86 and ARM, 
>>the point is moot since PAGE_SIZE is always 2^12.
>>
>>a. Is this correct, or have I misunderstood the code?
> 
> PowerPC always uses 12, even if PAGE_SHIFT is 16 (i.e. for 64k
> pages).
> 

ACK on that.  I was looking at old kernel sources (2.6.14-rc timeframe), 
and I guess that one only supported 4K pages.

>>b. If so, is this right, or is this a bug?  Right now both klibc and 
>>µClibc consider the latter a bug.
> 
> Glibc seems to expect it to always be 12, according to this excerpt
> from sysdeps/unix/sysv/linux/mmap64.c:

That's what I thought, too, but it doesn't seem to match reality.

This is what I've found so far: (64-bit architectures excluded)

	arm		- N/A (PAGE_SHIFT == 12)
	arm26		- MMAP2_PAGE_SHIFT == 12
	cris		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (13)
	frv		- MMAP2_PAGE_SHIFT == 12
	h8300		- N/A (PAGE_SHIFT == 12)
	i386		- N/A (PAGE_SHIFT == 12)
	m32r		- N/A (PAGE_SHIFT == 12)
	m68k		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (variable)
	mips		- MMAP2_PAGE_SHIFT == PAGE_SHIFT (variable)
	parisc		- MMAP2_PAGE_SHIFT == 12
	ppc		- MMAP2_PAGE_SHIFT == 12
	s390		- N/A (PAGE_SHIFT == 12)
	sh		- N/A (PAGE_SHIFT == 12)
	sparc		- MMAP2_PAGE_SHIFT == 12
	v850		- N/A (PAGE_SHIFT == 12)
	xtensa		- N/A (PAGE_SHIFT == 12)

So, excluding 64-bit architectures, we have 3 architectures which expect 
getpagesize() to be used, 5 which expect the constant value 12, and 8 
which get the same result either way.  In effect, we have a system call 
with subtly different semantics across architectures, and there isn't 
any clear distinction each way.

This is something I don't enjoy about Linux :-/
	
> /* This is always 12, even on architectures where PAGE_SHIFT != 12.  */
> # ifndef MMAP2_PAGE_SHIFT
> #  define MMAP2_PAGE_SHIFT 12
> # endif
> 
> I would be very reluctant to change the shift to be PAGE_SHIFT, since
> that would be a change in the user/kernel ABI.  Of course, userspace
> is still expected to make sure addresses and offsets are multiples of
> the page size (and thus the offset argument to mmap2 has to be a
> multiple of 16 if the page size is 64k).

Changing the user-kernel ABI is bad.  I'm just trying to get to the 
bottom with what the API actually *IS*.

	-hpa
