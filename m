Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFJUit>; Mon, 10 Jun 2002 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFJUiR>; Mon, 10 Jun 2002 16:38:17 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:32170 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316199AbSFJUgi>;
	Mon, 10 Jun 2002 16:36:38 -0400
Subject: 2.5.21 - console_unblank.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:32:29 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXi9-0000Zi-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
in my s390 bag of patches I have another one... console_unblank can cause
an endless trap loop if the console semaphore is already taken and
console_unblank is called in interrupt context. To avoid the trap loop
just try to take to semaphore with down_trylock and exit if its fails.
Its not perfect since c->unblank() is not called in this case but way
better than an endlessly looping cpu. s390/s390x are the only two
architectures that still use console_unblank and for us this is acceptable.
The second change in this patch is to increase the log buffer to 128K. We
do print a LOT of message if cio_msg=yes is used.

blue skies,
  Martin.

diff -urN linux-2.5.21/kernel/printk.c linux-2.5.21-s390/kernel/printk.c
--- linux-2.5.21/kernel/printk.c	Sun Jun  9 07:29:53 2002
+++ linux-2.5.21-s390/kernel/printk.c	Tue Apr 30 18:08:43 2002
@@ -31,6 +31,8 @@
 
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
+#elif defined(CONFIG_ARCH_S390)
+#define LOG_BUF_LEN	(131072)
 #elif defined(CONFIG_SMP)
 #define LOG_BUF_LEN	(32768)
 #else	
@@ -553,7 +555,14 @@
 {
 	struct console *c;
 
-	acquire_console_sem();
+	/*
+	 * Try to get the console semaphore. If someone else owns it
+	 * we have to return without unblanking because console_unblank
+	 * may be called in interrupt context.
+	 */
+	if (down_trylock(&console_sem) != 0)
+		return;
+	console_may_schedule = 0;
 	for (c = console_drivers; c != NULL; c = c->next)
 		if ((c->flags & CON_ENABLED) && c->unblank)
 			c->unblank();
