Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbTFRX6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbTFRX6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:58:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49905 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265633AbTFRX6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:58:00 -0400
Date: Thu, 19 Jun 2003 02:11:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] kill TWO_ZERO
Message-ID: <20030619001155.GM29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three drivers under drivers/char/ in 2.5.72 use TWO_ZERO for 
compatibility code with ancient 2.0 kernels. The patch below removes 
this #ifdef'd code.

diffstat output:

 rio/rio_linux.c |   45 ++++-----------------------------------------
 specialix.c     |   37 ++-----------------------------------
 sx.c            |   24 ++----------------------
 3 files changed, 8 insertions(+), 98 deletions(-)


Please apply
Adrian

--- linux-2.5.72/drivers/char/rio/rio_linux.c.old	2003-06-18 21:57:01.000000000 +0200
+++ linux-2.5.72/drivers/char/rio/rio_linux.c	2003-06-19 02:03:07.000000000 +0200
@@ -234,14 +234,12 @@
    support up to 64 bits on 64bit architectures. -- REW 20/06/99 */
 long rio_irqmask = -1;
 
-#ifndef TWO_ZERO
 MODULE_AUTHOR("Rogier Wolff <R.E.Wolff@bitwizard.nl>, Patrick van de Lageweg <patrick@bitwizard.nl>");
 MODULE_DESCRIPTION("RIO driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM(rio_poll, "i");
 MODULE_PARM(rio_debug, "i");
 MODULE_PARM(rio_irqmask, "i");
-#endif
 
 static struct real_driver rio_real_driver = {
   rio_disable_tx_interrupts,
@@ -1033,13 +1031,6 @@
   func_exit();
 }
 
-#ifdef TWO_ZERO
-#define PDEV unsigned char pci_bus, unsigned pci_fun
-#define pdev pci_bus, pci_fun
-#else
-#define PDEV   struct pci_dev *pdev
-#endif
-
 
 #ifdef CONFIG_PCI
  /* This was written for SX, but applies to RIO too...
@@ -1061,7 +1052,7 @@
    EEprom.  As the bit is read/write for the CPU, we can fix it here,
    if we detect that it isn't set correctly. -- REW */
 
-void fix_rio_pci (PDEV)
+void fix_rio_pci (struct pci_dev *pdev)
 {
   unsigned int hwbase;
   unsigned long rebase;
@@ -1094,12 +1085,7 @@
   int okboard;
 
 #ifdef CONFIG_PCI
-#ifndef TWO_ZERO
   struct pci_dev *pdev = NULL;
-#else
-  unsigned char pci_bus, pci_fun;
-  /* in 2.2.x pdev is a pointer defining a PCI device. In 2.0 its the bus/fn */
-#endif
   unsigned int tint;
   unsigned short tshort;
 #endif
@@ -1127,17 +1113,11 @@
 
 #ifdef CONFIG_PCI
     /* First look for the JET devices: */
-#ifndef TWO_ZERO
     while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
                                     PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
                                     pdev))) {
        if (pci_enable_device(pdev)) continue;
-#else
-    for (i=0;i< RIO_NBOARDS;i++) {
-      if (pcibios_find_device (PCI_VENDOR_ID_SPECIALIX, 
-			       PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, i,
-			       &pci_bus, &pci_fun)) break;
-#endif
+
       /* Specialix has a whole bunch of cards with
          0x2000 as the device ID. They say its because
          the standard requires it. Stupid standard. */
@@ -1195,16 +1175,9 @@
       } else {
               iounmap((char*) (p->RIOHosts[p->RIONumHosts].Caddr));
       }
-      
-#ifdef TWO_ZERO
-    }  /* We have two variants with the opening brace, so to prevent */
-#else
-    }  /* Emacs from getting confused we have two closing braces too. */
-#endif
+    }
     
     /* Then look for the older PCI card.... : */
-#ifndef TWO_ZERO
-
 
   /* These older PCI cards have problems (only byte-mode access is
      supported), which makes them a bit awkward to support. 
@@ -1218,12 +1191,6 @@
                                     PCI_DEVICE_ID_SPECIALIX_RIO, 
                                     pdev))) {
        if (pci_enable_device(pdev)) continue;
-#else
-    for (i=0;i< RIO_NBOARDS;i++) {
-      if (pcibios_find_device (PCI_VENDOR_ID_SPECIALIX, 
-			       PCI_DEVICE_ID_SPECIALIX_RIO, i,
-			       &pci_bus, &pci_fun)) break;
-#endif
 
 #ifdef CONFIG_RIO_OLDPCI
       pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &tint);
@@ -1271,11 +1238,7 @@
       printk (KERN_ERR "Found an older RIO PCI card, but the driver is not "
               "compiled to support it.\n");
 #endif
-#ifdef TWO_ZERO
-    }  /* We have two variants with the opening brace, so to prevent */
-#else
-    }  /* Emacs from getting confused we have two closing braces too. */
-#endif
+    }
 #endif /* PCI */
 
   /* Now probe for ISA cards... */
--- linux-2.5.72/drivers/char/sx.c.old	2003-06-19 02:03:39.000000000 +0200
+++ linux-2.5.72/drivers/char/sx.c	2003-06-19 02:04:34.000000000 +0200
@@ -2357,14 +2357,6 @@
 	func_exit();
 }
 
-#ifdef TWO_ZERO
-#define PDEV unsigned char pci_bus, unsigned pci_fun
-#define pdev pci_bus, pci_fun
-#else
-#define PDEV   struct pci_dev *pdev
-#endif
-
-
 #ifdef CONFIG_PCI
  /******************************************************** 
  * Setting bit 17 in the CNTRL register of the PLX 9050  * 
@@ -2377,7 +2369,7 @@
    EEprom.  As the bit is read/write for the CPU, we can fix it here,
    if we detect that it isn't set correctly. -- REW */
 
-static void fix_sx_pci (PDEV, struct sx_board *board)
+static void fix_sx_pci (struct pci_dev *pdev, struct sx_board *board)
 {
 	unsigned int hwbase;
 	unsigned long rebase;
@@ -2407,12 +2399,7 @@
 	struct sx_board *board;
 
 #ifdef CONFIG_PCI
-#ifndef TWO_ZERO
 	struct pci_dev *pdev = NULL;
-#else
-	unsigned char pci_bus, pci_fun;
-	/* in 2.2.x pdev is a pointer defining a PCI device. In 2.0 its the bus/fn */
-#endif
 	unsigned int tint;
 	unsigned short tshort;
 #endif
@@ -2432,19 +2419,12 @@
 	}
 
 #ifdef CONFIG_PCI
-#ifndef TWO_ZERO
 	while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
 					PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
 					      pdev))) {
 		if (pci_enable_device(pdev))
 			continue;
-#else
-	for (i=0;i< SX_NBOARDS;i++) {
-		if (pcibios_find_device (PCI_VENDOR_ID_SPECIALIX, 
-					 PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, i,
-					       &pci_bus, &pci_fun))
-			break;
-#endif
+
 		/* Specialix has a whole bunch of cards with
 		   0x2000 as the device ID. They say its because
 		   the standard requires it. Stupid standard. */
--- linux-2.5.72/drivers/char/specialix.c.old	2003-06-19 02:05:00.000000000 +0200
+++ linux-2.5.72/drivers/char/specialix.c	2003-06-19 02:06:26.000000000 +0200
@@ -92,40 +92,7 @@
 #include <linux/delay.h>
 #include <linux/version.h>
 #include <linux/pci.h>
-
-
-/* ************************************************************** */
-/* * This section can be removed when 2.0 becomes outdated....  * */
-/* ************************************************************** */
-
-#if LINUX_VERSION_CODE < 131328    /* Less than 2.1.0 */
-#define TWO_ZERO
-#else
-#if LINUX_VERSION_CODE < 131371   /* less than 2.1.43 */
-/* This has not been extensively tested yet. Sorry. */
-#warning "You're on your own between 2.1.0 and 2.1.43.... "
-#warning "Please use a recent kernel."
-#endif
-#endif
-
-
-#ifdef TWO_ZERO
-#define Get_user(a,b)         a = get_user(b)
-#define copy_from_user(a,b,c) memcpy_fromfs(a,b,c)
-#define copy_to_user(a,b,c)   memcpy_tofs(a,b,c)
-#define queue_task            queue_task_irq_off
-#else
-#define Get_user(a,b)         get_user(a,b)
-#endif
-
-/* ************************************************************** */
-/* *                End of compatibility section..              * */
-/* ************************************************************** */
-
-
-#ifndef TWO_ZERO
 #include <asm/uaccess.h>
-#endif
 
 #include "specialix_io8.h"
 #include "cd1865.h"
@@ -1745,7 +1712,7 @@
 	if (error) 
 		return error;
 
-	Get_user(arg, (unsigned long *) value);
+	get_user(arg, (unsigned long *) value);
 	switch (cmd) {
 	case TIOCMBIS: 
 	   /*	if (arg & TIOCM_RTS) 
@@ -1937,7 +1904,7 @@
 		         (unsigned long *) arg);
 		return 0;
 	 case TIOCSSOFTCAR:
-		Get_user(arg, (unsigned long *) arg);
+		get_user(arg, (unsigned long *) arg);
 		tty->termios->c_cflag =
 			((tty->termios->c_cflag & ~CLOCAL) |
 			(arg ? CLOCAL : 0));
