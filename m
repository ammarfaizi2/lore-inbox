Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWH3EcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWH3EcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWH3EcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:32:12 -0400
Received: from science.horizon.com ([192.35.100.1]:5419 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964851AbWH3EcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:32:11 -0400
Date: 30 Aug 2006 00:32:08 -0400
Message-ID: <20060830043208.14311.qmail@science.horizon.com>
From: linux@horizon.com
To: middle.fengdong@gmail.com
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to answer the question in elementary terms:

This is because:
- On x86, the user and kernel share the available 4G virtual address space,
- User space gets first choice, and so takes the low 3G.
- The kernel thus has to use the high 1G, and if it wants a copy
  of physical memory, that's the only place it can go.

In somewhat more detail:

1) In standard x86 Linux, the user and kernel address spaces share the 4
   GB virtual address space of the x86 processor.  There are other ways
   to do it (see the 4G+4G patch for an example), but they're slower.

   x86 processors only support one set of page tables at a time, and
   changing is a slow operation.  Other processors let you have separate
   user and kernel page tables active simultaneously, but x86 does not.

   So for speed, you don't want to change page tables to make a system
   call.  Also, many system calls are passed pointers to buffers in user
   memory, so need to access user memory.  It's fastest and easiest to do
   this if user memory is in the address space when executing kernel code.

   Fortunately, x86 page tables have a "user" bit in each page table
   entry, that can make pages only accessible from the kernel.  They are
   still in the user's virtual address space, but can't be accessed.
   Thus, it is possible for the user and kernel to share the address space.

   So, given all of this, Linux (as well as most other operating systems)
   on x86 has decided to divide the 4 GB virtual address space into "user"
   and "kernel" parts.  As far as the user is concerned, the kernel part
   is just "missing", so it's made as as small as reasonably possible.

2) The division chosen is that the user gets the low 3G of the address
   space, and the kernel gets the high 1G.  x86 ABI standards require
   that user space gets low addresses, and in any case, the kernel exists
   to make user-space programs happy.

3) The kernel finds it convenient to have a copy of physical memory in its
   address space, so it maps one.  If there's more RAM than will fit in the
   kernel address space, the HIGHMEM patches provide an alternative.
   Since this is an elementary explanation, I won't describe how that works.

Thus, the physical memory map used in the kernel ends up offset by 3G.
