Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318307AbSGXXmx>; Wed, 24 Jul 2002 19:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSGXXmx>; Wed, 24 Jul 2002 19:42:53 -0400
Received: from smtp3.9tel.net ([213.203.124.146]:28359 "HELO smtp3.9tel.net")
	by vger.kernel.org with SMTP id <S318307AbSGXXmv>;
	Wed, 24 Jul 2002 19:42:51 -0400
Date: Thu, 25 Jul 2002 01:45:00 +0200 (CEST)
From: Samuel Thibault <samuel.thibault@fnac.net>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: andre@linux-ide.org, martin@dalecki.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <Pine.LNX.4.44.0205260248160.17222-400000@youpi.residence.ens-lyon.fr>
Message-ID: <Pine.LNX.4.10.10207250128110.4868-100000@bureau.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are patches for 2.4.19-pre3 & 2.5.28 which free them from using
cli/sti in qd65xx stuff. (also using ide's OUT_BYTE / IN_BYTE btw)

IMHO, it may use its own spinlock, instead of using io_request_lock as
suggested in pre3-ac, since what we have to protect is this card from
parallel selectprocing 2 channels at a time which may upset the board (I
don't know, and don't have a vlb smp system to test)

2 qd6500 boards may be ok to parallelize it, I don't know (I don't have 
any)...

for 2.4.19rc3:

--- linux-2.4.19rc3/drivers/ide/qd65xx.c	Thu Jul 25 01:03:28 2002
+++ linux-2.4.19rc3/drivers/ide/qd65xx.c	Thu Jul 25 01:26:33 2002
@@ -88,14 +88,15 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
+static spinlock_t qd_lock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
+
 static void qd_write_reg (byte content, byte reg)
 {
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	OUT_BYTE(content,reg);
+	spin_unlock_irqrestore(&qd_lock, flags);
 }
 
 byte __init qd_read_reg (byte reg)
@@ -103,10 +104,9 @@
 	unsigned long flags;
 	byte read;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	read = IN_BYTE(reg);
+	spin_unlock_irqrestore(&qd_lock, flags);
 	return read;
 }
 
@@ -311,13 +311,12 @@
 	byte readreg;
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	savereg = inb_p(port);
-	outb_p(QD_TESTVAL,port);	/* safe value */
-	readreg = inb_p(port);
-	outb(savereg,port);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	savereg = IN_BYTE(port);
+	OUT_BYTE(QD_TESTVAL,port);	/* safe value */
+	readreg = IN_BYTE(port);
+	OUT_BYTE(savereg,port);
+	spin_unlock_irqrestore(&qd_lock, flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
@@ -336,7 +335,7 @@
  * return 1 if another qd may be probed
  */
 
-int __init probe (int base)
+static int __init qd_probe(int base)
 {
 	byte config;
 	byte index;
@@ -449,5 +448,5 @@
 
 void __init init_qd65xx (void)
 {
-	if (probe(0x30)) probe(0xb0);
+	if (qd_probe(0x30)) qd_probe(0xb0);
 }

(also corrected silly non-static probe function !)

for 2.5.28:

--- linux-2.5.28/drivers/ide/qd65xx.c	Thu Jul 25 01:10:26 2002
+++ linux-2.5.28/drivers/ide/qd65xx.c	Thu Jul 25 01:09:09 2002
@@ -85,14 +85,15 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
+static spinlock_t qd_lock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
+
 static void qd_write_reg(byte content, byte reg)
 {
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	outb(content,reg);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	OUT_BYTE(content,reg);
+	spin_unlock_irqrestore(&qd_lock, flags);
 }
 
 byte __init qd_read_reg(byte reg)
@@ -100,10 +101,9 @@
 	unsigned long flags;
 	byte read;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	read = inb(reg);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	read = IN_BYTE(reg);
+	spin_unlock_irqrestore(&qd_lock, flags);
 	return read;
 }
 
@@ -309,13 +309,12 @@
 	byte readreg;
 	unsigned long flags;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
-	savereg = inb_p(port);
-	outb_p(QD_TESTVAL, port);	/* safe value */
-	readreg = inb_p(port);
-	outb(savereg, port);
-	restore_flags(flags);	/* all CPUs */
+	spin_lock_irqsave(&qd_lock, flags);
+	savereg = IN_BYTE(port);
+	OUT_BYTE(QD_TESTVAL,port);	/* safe value */
+	readreg = IN_BYTE(port);
+	OUT_BYTE(savereg,port);
+	spin_unlock_irqrestore(&qd_lock, flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");


Regards,

Samuel Thibault

