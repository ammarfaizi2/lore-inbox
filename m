Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVCUU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVCUU1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVCUU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:26:47 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.23]:56163 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261860AbVCUUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:25:56 -0500
Date: Mon, 21 Mar 2005 21:25:50 +0100
Message-Id: <200503212025.j2LKPoJX011312@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 542] M68k/stdma: Replace sleep_on() with wait_event()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k/stdma: Use wait_event() instead of the deprecated sleep_on() function.
Since wait_event() expects the condition passed in to be the stopping
condition, negate the current one.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/arch/m68k/atari/stdma.c	2005-01-15 16:55:41.000000000 -0800
+++ linux-m68k-2.6.12-rc1/arch/m68k/atari/stdma.c	2005-01-19 17:25:33.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/wait.h>
 
 #include <asm/atari_stdma.h>
 #include <asm/atariints.h>
@@ -81,11 +82,10 @@ void stdma_lock(irqreturn_t (*handler)(i
 
 	local_irq_save(flags);		/* protect lock */
 
-	while(stdma_locked)
-		/* Since the DMA is used for file system purposes, we
-		 have to sleep uninterruptible (there may be locked
-		 buffers) */
-		sleep_on(&stdma_wait);
+	/* Since the DMA is used for file system purposes, we
+	 have to sleep uninterruptible (there may be locked
+	 buffers) */
+	wait_event(stdma_wait, !stdma_locked);
 
 	stdma_locked   = 1;
 	stdma_isr      = handler;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
