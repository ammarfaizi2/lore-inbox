Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSG1Shy>; Sun, 28 Jul 2002 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSG1Shy>; Sun, 28 Jul 2002 14:37:54 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:13068 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317022AbSG1Shw>;
	Sun, 28 Jul 2002 14:37:52 -0400
Message-ID: <3D443B8C.7C2028B0@tv-sign.ru>
Date: Sun, 28 Jul 2002 22:44:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for Linux, 
 2.5.28
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I thought, that gdt entry consulted only while
loading its index into the segment register.

So load_TLS_desc(next, cpu) must be called before
loading next->fs,next->gs in __switch_to() ?

--- linux-2.5.29/arch/i386/kernel/process.c~	Sun Jul 28 21:44:35 2002
+++ linux-2.5.29/arch/i386/kernel/process.c	Sun Jul 28 21:46:07 2002
@@ -675,6 +675,14 @@
 	tss->esp0 = next->esp0;
 
 	/*
+	 * Load the per-thread Thread-Local Storage descriptor.
+	 *
+	 * NOTE: it's faster to do the two stores unconditionally
+	 * than to branch away.
+	 */
+	load_TLS_desc(next, cpu);
+
+	/*
 	 * Save away %fs and %gs. No need to save %es and %ds, as
 	 * those are always kernel segments while inside the kernel.
 	 */
@@ -688,14 +696,6 @@
 		loadsegment(fs, next->fs);
 		loadsegment(gs, next->gs);
 	}
-
-	/*
-	 * Load the per-thread Thread-Local Storage descriptor.
-	 *
-	 * NOTE: it's faster to do the two stores unconditionally
-	 * than to branch away.
-	 */
-	load_TLS_desc(next, cpu);
 
 	/*
 	 * Now maybe reload the debug registers

Oleg.
