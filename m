Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWHJTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWHJTsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWHJTrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:47:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11500 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932675AbWHJThX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:23 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [115/145] x86_64: fix dubious segment register clear in cpu_init()
Message-Id: <20060810193714.0590013C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:13 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Jeremy Fitzhardinge <jeremy@goop.org>

Fix a very dubious piece of code in
arch/i386/kernel/cpu/common.c:cpu_init().  This clears out %fs and
%gs, but clobbers %eax in the process without telling gcc.  It turns
out that gcc happens to be not using %eax at that point anyway so it
doesn't matter much, but it looks like a bomb waiting to go off.

This does end up saving an instruction, because gcc wants %eax==0 for
the set_debugreg()s below.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/common.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/i386/kernel/cpu/common.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/common.c
+++ linux/arch/i386/kernel/cpu/common.c
@@ -675,7 +675,7 @@ old_gdt:
 #endif
 
 	/* Clear %fs and %gs. */
-	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
+	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
