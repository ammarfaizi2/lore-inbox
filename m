Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSHEQJV>; Mon, 5 Aug 2002 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSHEQJV>; Mon, 5 Aug 2002 12:09:21 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:62923 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318608AbSHEQJU>; Mon, 5 Aug 2002 12:09:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 12/18 console_unblank bug fix
Date: Mon, 5 Aug 2002 19:47:55 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051947.55433.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:  console_unblank can cause an endless trap loop if the console
          semaphore is already taken and console_unblank is called in
          interrupt context.
Solution: To avoid the trap loop just try to take the console semaphore
          with down_trylock and exit if it fails. It is not perfect
          since c->unblank() is not called in this case but way better
          than an endless trap loop. s390/s390x are the only two
          architectures that still use console_unblank. This patch
          has been accepted to 2.5.

diff -urN linux-2.4.19-rc3/kernel/printk.c linux-2.4.19-s390/kernel/printk.c
--- linux-2.4.19-rc3/kernel/printk.c	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/kernel/printk.c	Tue Jul 30 09:02:57 2002
@@ -556,7 +556,14 @@
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


