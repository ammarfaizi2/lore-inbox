Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131863AbQLRP61>; Mon, 18 Dec 2000 10:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbQLRP6R>; Mon, 18 Dec 2000 10:58:17 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:60663 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131863AbQLRP6C>; Mon, 18 Dec 2000 10:58:02 -0500
Message-ID: <3A3E2E0D.648B04E0@uow.edu.au>
Date: Tue, 19 Dec 2000 02:32:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "shuu@wondernetworkresources.com" <shuu@wondernetworkresources.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 8139too.c
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Clear current->blocked in the kernel thread.  We shouldn't
  be inheriting this from the process which opens the interface.

- Fixed a few printk warnings which are coming out
  when RTL8139_DEBUG is defined.

- Killed the undefined and unused module parm `debug' (finally!)

- Fixed a potential buffer overrun when setting current->comm[].

  Currently, if the user renames "eth0" to "my-nifty-realtek-nic"
  with SIOCSIFNAME and then tries to open it, the kernel thread
  will scrog its own task_struct.

  The kernel thread is now simply called "[eth0]".


I think it would be better to use boring old waitqueues for this
stuff, rather than signals....




--- linux-2.4.0-test13-pre3/drivers/net/8139too.c	Tue Dec 12 19:24:18 2000
+++ linux-akpm/drivers/net/8139too.c	Tue Dec 19 02:15:23 2000
@@ -74,6 +74,9 @@
 		
 		Tobias Ringström - Rx interrupt status checking suggestion
 
+		Andrew Morton - (v0.9.13): clear blocked signals, avoid
+		buffer overrun setting current->comm.
+
 	Submitting bug reports:
 
 		"rtl8139-diag -mmmaaavvveefN" output
@@ -147,7 +150,7 @@
 #include <asm/io.h>
 
 
-#define RTL8139_VERSION "0.9.12"
+#define RTL8139_VERSION "0.9.13"
 #define MODNAME "8139too"
 #define RTL8139_DRIVER_NAME   MODNAME " Fast Ethernet driver " RTL8139_VERSION
 #define PFX MODNAME ": "
@@ -536,7 +539,6 @@
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
-MODULE_PARM (debug, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(8) "i");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
@@ -1461,7 +1463,7 @@
 	DPRINTK ("%s: Media selection tick, Link partner %4.4x.\n",
 		 dev->name, RTL_R16 (NWayLPAR));
 	DPRINTK ("%s:  Other registers are IntMask %4.4x IntStatus %4.4x"
-		 " RxStatus %4.4x.\n", dev->name,
+		 " RxStatus %4.4lx.\n", dev->name,
 		 RTL_R16 (IntrMask),
 		 RTL_R16 (IntrStatus),
 		 RTL_R32 (RxEarlyStatus));
@@ -1478,7 +1480,13 @@
 	unsigned long timeout;
 
 	daemonize ();
-	sprintf (current->comm, "k8139d-%s", dev->name);
+	spin_lock_irq(&current->sigmask_lock);
+	sigemptyset(&current->blocked);
+	recalc_sigpending(current);
+	spin_unlock_irq(&current->sigmask_lock);
+
+	strncpy (current->comm, dev->name, sizeof(current->comm) - 1);
+	current->comm[sizeof(current->comm) - 1] = '\0';
 
 	while (1) {
 		timeout = next_tick;
@@ -2136,7 +2144,7 @@
 
 	DPRINTK ("ENTER\n");
 
-	DPRINTK ("%s:   rtl8139_set_rx_mode(%4.4x) done -- Rx config %8.8x.\n",
+	DPRINTK ("%s:   rtl8139_set_rx_mode(%4.4x) done -- Rx config %8.8lx.\n",
 			dev->name, dev->flags, RTL_R32 (RxConfig));
 
 	/* Note: do not reorder, GCC is clever about common statements. */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
