Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRCZJqw>; Mon, 26 Mar 2001 04:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRCZJqm>; Mon, 26 Mar 2001 04:46:42 -0500
Received: from [212.115.175.146] ([212.115.175.146]:38390 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S131806AbRCZJq1>; Mon, 26 Mar 2001 04:46:27 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F10A1@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] kernel/exit.c - 2.4.2 - small optimalisation (very small)
	 to do_exit()
Date: Mon, 26 Mar 2001 11:45:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This very small patches re-orders 2 if-statements so that in the
most common case 1 less if-statement is executed, in the worst
case the same number of if-statements is executed (doesn't matter
though: it's would be the fault-situation anyway).

diff -ur --minimal linux-vanilla/kernel/exit.c linux-2.4.2/kernel/exit.c
--- linux-vanilla/kernel/exit.c	Mon Mar 26 09:28:13 2001
+++ linux-2.4.2/kernel/exit.c	Mon Mar 26 10:50:30 2001
@@ -425,10 +425,12 @@
 
 	if (in_interrupt())
 		panic("Aiee, killing interrupt handler!");
-	if (!tsk->pid)
-		panic("Attempted to kill the idle task!");
-	if (tsk->pid == 1)
-		panic("Attempted to kill init!");
+	if (tsk->pid <= 1) {
+		if (tsk->pid)
+			panic("Attempted to kill init!");
+		else
+			panic("Attempted to kill the idle task!");
+	}
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);


Greetings,

Folkert van Heusden (folkert@vanheusden.com)
[ www.vanheusden.com ]

