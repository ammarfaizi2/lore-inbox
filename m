Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWEYB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWEYB1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWEYB1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30094 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964818AbWEYB1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:02 -0400
Message-Id: <20060525003423.720837000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:52 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] adjust to changed HARDIRQ_MASK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adjust entry.S to the changed HARDIRQ_MASK, add a check to prevent it
from silently breaking again.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/entry.S |    4 ++--
 arch/m68k/kernel/ints.c  |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6-mm/arch/m68k/kernel/entry.S
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/entry.S
+++ linux-2.6-mm/arch/m68k/kernel/entry.S
@@ -226,7 +226,7 @@ ENTRY(nmi_handler)
 inthandler:
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
-	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+2)
+	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 					|  put exception # in d0
 	bfextu %sp@(PT_VECTOR){#4,#10},%d0
 
@@ -245,7 +245,7 @@ inthandler:
 3:	addql	#8,%sp			|  pop parameters off stack
 
 ret_from_interrupt:
-	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+2)
+	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 	jeq	1f
 2:
 	RESTORE_ALL
Index: linux-2.6-mm/arch/m68k/kernel/ints.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/ints.c
+++ linux-2.6-mm/arch/m68k/kernel/ints.c
@@ -95,6 +95,12 @@ void __init init_IRQ(void)
 {
 	int i;
 
+	/* assembly irq entry code relies on this... */
+	if (HARDIRQ_MASK != 0x00ff0000) {
+		extern void hardirq_mask_is_broken(void);
+		hardirq_mask_is_broken();
+	}
+
 	for (i = 0; i < SYS_IRQS; i++) {
 		if (mach_default_handler)
 			irq_list[i].handler = (*mach_default_handler)[i];

--

