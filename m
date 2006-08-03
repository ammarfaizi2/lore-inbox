Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWHCXtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHCXtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWHCXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:49:08 -0400
Received: from gw.goop.org ([64.81.55.164]:16335 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751364AbWHCXtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:49:06 -0400
Message-ID: <44D28B6F.5030701@goop.org>
Date: Thu, 03 Aug 2006 16:49:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix dubious segment register clear in cpu_init()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a very dubious piece of code in
arch/i386/kernel/cpu/common.c:cpu_init().  This clears out %fs and
%gs, but clobbers %eax in the process without telling gcc.  It turns
out that gcc happens to be not using %eax at that point anyway so it
doesn't matter much, but it looks like a bomb waiting to go off.

This does end up saving an instruction, because gcc wants %eax==0 for
the set_debugreg()s below.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r ced3124154dc arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Jul 31 18:52:19 2006 -0700
+++ b/arch/i386/kernel/cpu/common.c	Thu Aug 03 16:23:02 2006 -0700
@@ -675,7 +675,7 @@ old_gdt:
 #endif
 
 	/* Clear %fs and %gs. */
-	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
+	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);


