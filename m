Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272510AbTGZOlT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272549AbTGZOkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:51 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:23882 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272530AbTGZOcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:51 -0400
Date: Sat, 26 Jul 2003 16:51:59 +0200
Message-Id: <200307261451.h6QEpxKM002478@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k ret_from_fork
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Revert to 2.4 behavior in ret_from_fork (always call schedule_tail,
regardless of CONFIG_SMP), as suggested by Andreas Schwab.

This removes the warnings from sched.c (from Sam Creasey).

--- linux-2.6.x/arch/m68k/kernel/entry.S	Tue May 27 19:02:32 2003
+++ linux-m68k-2.6.x/arch/m68k/kernel/entry.S	Fri Jul 18 16:23:57 2003
@@ -68,11 +68,13 @@
 	addql	#4,%sp
 	jra	ret_from_exception
 
-	| schedule_tail is only used with CONFIG_SMP
+        | After a fork we jump here directly from resume,
+	| so that %d1 contains the previous task
+	| schedule_tail now used regardless of CONFIG_SMP
 ENTRY(ret_from_fork)
-#ifdef CONFIG_SMP
+	movel	%d1,%sp@-
 	jsr	schedule_tail
-#endif
+	addql	#4,%sp
 	jra	ret_from_exception
 
 badsys:

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
