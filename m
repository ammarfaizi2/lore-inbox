Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSG0KdF>; Sat, 27 Jul 2002 06:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318731AbSG0KdF>; Sat, 27 Jul 2002 06:33:05 -0400
Received: from [196.26.86.1] ([196.26.86.1]:32682 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318730AbSG0KdE>; Sat, 27 Jul 2002 06:33:04 -0400
Date: Sat, 27 Jul 2002 12:54:02 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.28] opti621 irq fallout
Message-ID: <Pine.LNX.4.44.0207271251410.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.28/drivers/ide/opti621.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.28/drivers/ide/opti621.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opti621.c
--- linux-2.5.28/drivers/ide/opti621.c	26 Jul 2002 18:11:11 -0000	1.1.1.1
+++ linux-2.5.28/drivers/ide/opti621.c	26 Jul 2002 19:18:00 -0000
@@ -131,6 +131,7 @@
 #define MISC_REG 6	/* index of Miscellaneous register */
 
 int reg_base;
+static spinlock_t opti621_lock = SPIN_LOCK_UNLOCKED;
 
 #define PIO_NOT_EXIST 254
 #define PIO_DONT_KNOW 255
@@ -281,8 +282,7 @@
 		hwif->name, ax, second.data_time, second.recovery_time, drdy);
 #endif
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&opti621_lock, flags);
 
 	reg_base = hwif->io_ports[IDE_DATA_OFFSET];
 	outb(0xc0, reg_base+CNTRL_REG);	/* allow Register-B */
@@ -307,7 +307,7 @@
 	write_reg(misc, MISC_REG);	/* set address setup, DRDY timings,   */
 					/*  and read prefetch for both drives */
 
-	restore_flags(flags);	/* all CPUs */
+	spin_unlock_irqrestore(&opti621_lock, flags);
 }
 
 /*

-- 
function.linuxpower.ca


