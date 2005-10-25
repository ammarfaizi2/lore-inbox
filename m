Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVJYWMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVJYWMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVJYWLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:11:21 -0400
Received: from [151.97.230.9] ([151.97.230.9]:44728 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932443AbVJYWLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:11:18 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/6] x86_64: enable xchg optimization for x86_64
Date: Wed, 26 Oct 2005 00:13:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025221351.21106.57194.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

i386 enables the xchg based implementation of r/w semaphores for any processor
as good as 486. So it was quite interesting to see x86_64 never using it! And it
was even more interesting to see, in rwsem.h:

/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for x86_64+
 *
 * Written by David Howells (dhowells@redhat.com).
 * Ported by Andi Kleen <ak@suse.de> to x86-64.

I.e. the implementation was written, is present in the tree, but due to this:

#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
#include <linux/rwsem-spinlock.h> /* use a generic implementation */
#else
#include <asm/rwsem.h> /* use an arch-specific implementation */
#endif

it was probably _NEVER_ compiled!!!

So, handle with care this one-liner, and test it properly.

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -39,11 +39,10 @@ config SBUS
 	bool
 
 config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
+	def_bool n
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	bool

