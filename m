Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVG2PTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVG2PTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVG2PTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:19:06 -0400
Received: from science.horizon.com ([192.35.100.1]:13368 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262618AbVG2PSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:18:04 -0400
Date: 29 Jul 2005 11:18:04 -0400
Message-ID: <20050729151804.28355.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Cc: mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  include/asm-alpha/mmu_context.h     |    6 ++++++
>  include/asm-arm/mmu_context.h       |    6 ++++++
>  include/asm-arm26/mmu_context.h     |    6 ++++++
>  include/asm-cris/mmu_context.h      |    6 ++++++
>  include/asm-frv/mmu_context.h       |    6 ++++++
>  include/asm-h8300/mmu_context.h     |    6 ++++++
>  include/asm-i386/mmu_context.h      |    6 ++++++
>  include/asm-ia64/mmu_context.h      |    6 ++++++
>  include/asm-m32r/mmu_context.h      |    6 ++++++
>  include/asm-m68k/mmu_context.h      |    6 ++++++
>  include/asm-m68knommu/mmu_context.h |    6 ++++++
>  include/asm-mips/mmu_context.h      |    6 ++++++
>  include/asm-parisc/mmu_context.h    |    6 ++++++
>  include/asm-ppc/mmu_context.h       |    6 ++++++
>  include/asm-ppc64/mmu_context.h     |    6 ++++++
>  include/asm-s390/mmu_context.h      |    6 ++++++
>  include/asm-sh/mmu_context.h        |    6 ++++++
>  include/asm-sh64/mmu_context.h      |    6 ++++++
>  include/asm-sparc/mmu_context.h     |    6 ++++++
>  include/asm-sparc64/mmu_context.h   |    6 ++++++
>  include/asm-um/mmu_context.h        |    6 ++++++
>  include/asm-v850/mmu_context.h      |    6 ++++++
>  include/asm-x86_64/mmu_context.h    |    5 +++++
>  include/asm-xtensa/mmu_context.h    |    6 ++++++
>  kernel/sched.c                      |    9 ++++++++-
>  25 files changed, 151 insertions(+), 1 deletion(-)

I think this pretty clearly points out the need for some arch-generic
infrastructure in Linux.  An awful lot of arch hooks are for one
or two architectures with some peculiarities, and the other 90% of
the implementations are identical.

For example, this is 22 repetitions of
#define MIN_KERNEL_STACK_FOOTPRINT L1_CACHE_BYTES

with one different case.

It would be awfully nice if there was a standard way to provide a default
implementation that was automatically picked up by any architecture that
didn't explicitly override it.

One possibility is to use #ifndef:

/* asm-$PLATFORM/foo.h */
#define MIN_KERNEL_STACK_FOOTPRINT IA64_SWITCH_STACK_SIZE
inline void
prefetch_task(struct task_struct const *task)
{
	...
}
#define prefetch_task prefetch_task


/* asm-generic/foo.h */
#include <asm/foo.h>

#ifndef MIN_KERNEL_STACK_FOOTPRINT
#define MIN_KERNEL_STACK_FOOTPRINT L1_CACHE_BYTES
#endif

#ifndef prefetch_task
inline void prefetch_task(struct task_struct const *task) { }
/* The #define is OPTIONAL... */
#define prefetch_task prefetch_task
#endif


But both understanding and maintaining the arch code could be
much easier if the shared parts were collapsed.  A comment in the
generic versions can explain what the assumptions are.


If there are cases where there is more than one implementation with
multiple users, it can be stuffed into a third category of headers.
E.g. <asm-generic/noiommu/foo.h> and <asm-generic/iommu/foo.h> or some
such, using the same duplicate-suppression technique and #included at
the end of <asm-$PLATFORM/foo.h>
