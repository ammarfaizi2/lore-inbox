Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbTBMNxq>; Thu, 13 Feb 2003 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268045AbTBMNxq>; Thu, 13 Feb 2003 08:53:46 -0500
Received: from snifit.smb.utfors.se ([195.58.112.20]:52966 "EHLO
	snifit.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S268042AbTBMNxp>; Thu, 13 Feb 2003 08:53:45 -0500
Date: Thu, 13 Feb 2003 15:03:35 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: Loosing chars on serial console in 2.4
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Reply-to: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEDPFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List.

If I paste text into my serial console, some chars aren't echoed back. I also
loose some chars when doing reboot and init starts to print messages.

This is due to that almost no user of opost() bothers to check its return
value. The patch below fixes the problem, but it is ugly and possibly buggy. 
I don't know how to fix this properly.

HW: custom 860 board at 115200 baud, using the standard arch/ppc/8xx_io/uart.c driver.

 Jocke

--- drivers/char/n_tty.c	1 Nov 2002 13:43:27 -0000	1.1.1.1
+++ drivers/char/n_tty.c	13 Feb 2003 13:45:33 -0000
@@ -186,8 +186,14 @@
 static int opost(unsigned char c, struct tty_struct *tty)
 {
 	int	space, spaces;
+#if 1
+	unsigned long tmo = jiffies + HZ/10;
 
+	while(!(space = tty->driver.write_room(tty)) && !in_interrupt() && !time_after(jiffies, tmo))
+		cond_resched();
+#else
 	space = tty->driver.write_room(tty);
+#endif
 	if (!space)
 		return -1;
 


