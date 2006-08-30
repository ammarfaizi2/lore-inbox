Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWH3WQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWH3WQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWH3WQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:16:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:14021 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932170AbWH3WQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:06 -0400
Subject: [RFC][PATCH 0/9] generic PAGE_SIZE infrastructure (v4)
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:04 -0700
Message-Id: <20060830221604.E7320C0F@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:
- fixed spurious delete of PTE_MASK in sh arch
- replaced ALIGN() macro with one which only evaluates the
  address a single time.  (Thanks Nikita)
- replaced ppc _ALIGN* definitions with include of align.h

Changes from v2:
- included get_order() code to make it safe to include
  generic/page.h everywhere (using ARCH_HAS_GET_ORDER)
- updated mm/Kconfig text to make it more fitting for ia64
- added patch to consolidate _ALIGN with kernel.h's ALIGN()
  The assembly one has been left alone, but I guess we could
  put it here.  However, the meaning of the two is quite different.

---

All architectures currently explicitly define their page size.  In some
cases (ppc, parisc, ia64, sparc64, mips) this size is somewhat
configurable.

There several reimplementations of ways to make sure that PAGE_SIZE
is usable in assembly code, yet still somewhat type safe for use in
C code (as a UL type).  These are all very similar.  There are also a
number of macros based off of PAGE_SIZE/SHIFT which are duplicated
across architectures.

This patch unifies all of those definitions.  It defines PAGE_SIZE in
a single header which gets its definitions from Kconfig.  The new
Kconfig options mirror what used to be done with #ifdefs and
arch-specific Kconfig options.  The new Kconfig menu eliminates
the need for parisc, ia64, and sparc64 to have their own "choice"
menus for selecting page size.  The help text has been adapted from
these three architectures, but is now more generic.

Why am I doing this?  The OpenVZ beancounter patch hooks into the
alloc_thread_info() path, but only in two architectures.  It is silly
to patch each and every architecture when they all just do the same
thing.  This is the first step to have a single place in which to
do alloc_thread_info().  Oh, and this series removes about 300 lines
of code.

  59 files changed, 217 insertions(+), 502 deletions(-)
