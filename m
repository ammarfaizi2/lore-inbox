Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293751AbSB1UyG>; Thu, 28 Feb 2002 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293735AbSB1Uwd>; Thu, 28 Feb 2002 15:52:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2059 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293740AbSB1Usc>; Thu, 28 Feb 2002 15:48:32 -0500
Date: Thu, 28 Feb 2002 20:48:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Maze of include files, all producing errors...
Message-ID: <20020228204826.C13564@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.5 (Changeset 1.359.2.3), the highmem.h and pgalloc.h includes were
reversed.

Previous kernels had linux/highmem.h including asm/pgalloc.h.  Placing
the architecture cache handling functions worked well in asm/pgalloc.h,
allowing highmem.h to find them; highmem.h uses flush_dcache_page() and
friends in inline functions.

In this changeset, highmem.h no longer includes pgalloc.h, but instead
pgalloc.h includes highmem.h.  This, unfortunately, tends to break things
in a major way since the cache functions are no longer available to
highmem.h.

Looking at x86, the (no-op) cache functions live in pgtable.h.  However,
trying to put the ARM cache handling into pgtable.h doesn't work because
we need things like PG_arch_1 and struct page.  pgtable.h is included by
linux/mm.h before linux/mm.h declares PG_arch_1 and struct page.  So
obviously this can't work.

Has anyone encountered this, and has anyone found a magic working
combination?

For now, I'm going to reverse the include changes in this changeset so
things build again.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

