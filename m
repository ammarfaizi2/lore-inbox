Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTEFPNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEFPNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:13:45 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:62957 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263800AbTEFPNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:13:14 -0400
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: bame@debian.org
Subject: [PATCH] HP Remote Management Console serial driver
Date: Tue, 06 May 2003 09:25:41 -0600
Message-Id: <20030506152541.7F80514924@paul.bame>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HP has this remote management console thingy (Diva) containing a few
serial ports which has shown up in different forms on both PA-RISC
and IA64 boxes.  Some of the diva code is already in 2.4.20.  This
patch applies cleanly to 2.4.20, 2.4.21-rc1, and 2.4.20+Bjorn's IA64 patch.

A similar but uglier patch shipped with the RH IA64 release, has been in
Debian IA64 for a while, is in the IA64 kernel patch, and has worked ok
in the PA-RISC linux kernel for some time.

This patch

    1. Adds CONFIG_HP_DIVA which disables all the diva code.  This
       config option only applies to CONFIG_PARISC and CONFIG_IA64
       so doesn't directly affect other platforms (it reduces their
       serial.o size a tiny bit).

    2. Has a workaround for a hardware bug where TX empty interrupts are
       essentially lost, causing output to freeze forever in some cases.
       The workaround is to poll the diva hardware once per second and
       simulate the TX empty IIR bit based on whether it "should" be
       asserted, and then continue through the normal driver path.

I'm not on l-k or l-s so please remember me in your replies.  Thanks.

	-Paul Bame <bame@debian.org>


diff -urN linux-2.4.20/Documentation/Configure.help linux-hp-diva/Documentation/Configure.help
--- linux-2.4.20/Documentation/Configure.help	Thu Nov 28 16:53:08 2002
+++ linux-hp-diva/Documentation/Configure.help	Fri May  2 12:15:27 2003
@@ -3347,6 +3347,14 @@
 
   Most people can say N here.
 
+HP (GSP/ECI/MP) Remote Management Console support
+CONFIG_HP_DIVA
+  If you have an HP IA64 or HP PA-RISC server with a remote
+  management console say Y here to use all its serial ports.
+
+  It is always safe to say Y but your kernel will be a tiny
+  bit bigger.
+
 Extended dumb serial driver options
 CONFIG_SERIAL_EXTENDED
   If you wish to use any non-standard features of the standard "dumb"
diff -urN linux-2.4.20/drivers/char/Config.in linux-hp-diva/drivers/char/Config.in
--- linux-2.4.20/drivers/char/Config.in	Thu Nov 28 16:53:12 2002
+++ linux-hp-diva/drivers/char/Config.in	Fri May  2 12:15:27 2003
@@ -24,6 +24,9 @@
       tristate '   Atomwide serial port support' CONFIG_ATOMWIDE_SERIAL
       tristate '   Dual serial port support' CONFIG_DUALSP_SERIAL
    fi
+   if [ "$CONFIG_IA64" = "y" -o "$CONFIG_PARISC" = "y" ]; then
+      bool '   HP (GSP/ECI/MP) Remote Management Console support' CONFIG_HP_DIVA
+   fi
 fi
 dep_mbool 'Extended dumb serial driver options' CONFIG_SERIAL_EXTENDED $CONFIG_SERIAL
 if [ "$CONFIG_SERIAL_EXTENDED" = "y" ]; then
diff -urN linux-2.4.20/drivers/char/serial.c linux-hp-diva/drivers/char/serial.c
--- linux-2.4.20/drivers/char/serial.c	Thu Nov 28 16:53:12 2002
+++ linux-hp-diva/drivers/char/serial.c	Fri May  2 12:18:37 2003
@@ -62,6 +62,10 @@
  *        Robert Schwebel <robert@schwebel.de>,
  *        Juergen Beisert <jbeisert@eurodsn.de>,
  *        Theodore Ts'o <tytso@mit.edu>
+ *
+ * 05/03: Isolate HP Diva changes with CONFIG_HP_DIVA and work
+ *        around a diva interrupt problem.  Diva only known to be
+ *        in HP PA-RISC and HP IA64 boxes.  Paul Bame <bame@debian.org>
  */
 
 static char *serial_version = "5.05c";
@@ -257,6 +261,14 @@
 
 static struct timer_list serial_timer;
 
+#ifdef CONFIG_HP_DIVA
+#define HP_DIVA_CHECKTIME (1*HZ)
+static struct timer_list hp_diva_timer;
+static int hp_diva_count = 0;
+#define HP_DIVA_IRQS 256
+static int hp_diva_irqs[HP_DIVA_IRQS];
+#endif /* CONFIG_HP_DIVA */
+
 /* serial subtype definitions */
 #ifndef SERIAL_TYPE_NORMAL
 #define SERIAL_TYPE_NORMAL	1
@@ -792,6 +804,44 @@
 	}
 }
 
+#ifdef CONFIG_HP_DIVA
+static inline int is_hp_diva_info(struct async_struct *info) 
+{
+    struct pci_dev *dev = info->state->dev;
+    return (dev && dev->vendor == PCI_VENDOR_ID_HP &&
+		dev->device == PCI_DEVICE_ID_HP_SAS);
+}
+
+static inline int is_hp_diva_irq(int irq)
+{
+    struct async_struct *info = IRQ_ports[irq];
+    return (info && is_hp_diva_info(info));
+}
+
+/*
+ * It is possible to "use up" transmit empty interrupts in some
+ * cases with HP Diva cards.  Figure out if there _should_ be a
+ * transmit interrupt and if so, return a suitable iir value so
+ * that we can recover when called from rs_timer().  See also
+ * hp_diva_check()
+ */
+static inline int hp_diva_iir(int irq, struct async_struct *info)
+{
+	int iir = serial_in(info, UART_IIR);
+
+	if (is_hp_diva_info(info) &&
+		(iir & UART_IIR_NO_INT) != 0 &&
+		(info->IER & UART_IER_THRI) != 0 &&
+		(info->xmit.head != info->xmit.tail || info->x_char) &&
+		(serial_in(info, UART_LSR) & UART_LSR_THRE) != 0) {
+		    iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
+		    iir |= UART_IIR_THRI;
+	}
+
+	return iir;
+}
+#endif /* CONFIG_HP_DIVA */
+
 #ifdef CONFIG_SERIAL_SHARE_IRQ
 /*
  * This is the serial driver's generic interrupt routine
@@ -823,7 +873,11 @@
 
 	do {
 		if (!info->tty ||
+#ifdef CONFIG_HP_DIVA
+		    ((iir=hp_diva_iir(irq, info)) & UART_IIR_NO_INT)) {
+#else
 		    ((iir=serial_in(info, UART_IIR)) & UART_IIR_NO_INT)) {
+#endif
 			if (!end_mark)
 				end_mark = info;
 			goto next;
@@ -1087,9 +1141,14 @@
 #ifdef CONFIG_SERIAL_SHARE_IRQ
 			if (info->next_port) {
 				do {
-					serial_out(info, UART_IER, 0);
-					info->IER |= UART_IER_THRI;
-					serial_out(info, UART_IER, info->IER);
+#ifdef CONFIG_HP_DIVA
+					if (!is_hp_diva_info(info))
+#endif
+					{
+						serial_out(info, UART_IER, 0);
+						info->IER |= UART_IER_THRI;
+						serial_out(info, UART_IER, info->IER);
+					}
 					info = info->next_port;
 				} while (info);
 #ifdef CONFIG_SERIAL_MULTIPORT
@@ -1120,6 +1179,34 @@
 	}
 }
 
+#ifdef CONFIG_HP_DIVA
+/*
+ * This is called when the hp_diva_timer goes off.  In certain
+ * cases (multiple gettys in particular) Diva seems
+ * to issue only a single transmit empty interrupt instead of one each
+ * time THRI is enabled, causing interrupts to be "used up".  This
+ * serves to poll the Diva UARTS more frequently than rs_timer() does.
+ * See also hp_diva_iir()
+ */
+static void hp_diva_check(unsigned long dummy)
+{
+	static unsigned long last_strobe;
+	unsigned long flags;
+	int i;
+
+	if (time_after_eq(jiffies, last_strobe + HP_DIVA_CHECKTIME)) {
+		for (i = 0; i < hp_diva_count; i++) {
+			save_flags(flags); cli();
+			rs_interrupt(hp_diva_irqs[i], NULL, NULL);
+			restore_flags(flags);
+		}
+	}
+	last_strobe = jiffies;
+	mod_timer(&hp_diva_timer, jiffies + HP_DIVA_CHECKTIME);
+}
+#endif /* CONFIG_HP_DIVA */
+
+
 /*
  * ---------------------------------------------------------------
  * Low level utility subroutines for the serial driver:  routines to
@@ -4245,6 +4332,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_HP_DIVA
 /*
  * HP's Remote Management Console.  The Diva chip came in several
  * different versions.  N-class, L2000 and A500 have two Diva chips, each
@@ -4276,8 +4364,20 @@
 		break;
 	}
 
+	if (hp_diva_count < HP_DIVA_IRQS) {
+		hp_diva_irqs[hp_diva_count] = dev->irq;
+	} else {
+		printk(KERN_INFO "Please increase HP_DIVA_IRQS in drivers/char/serial.c\n");
+	}
+	if (hp_diva_count++ == 0) {
+		init_timer(&hp_diva_timer);
+		hp_diva_timer.function = hp_diva_check;
+		mod_timer(&hp_diva_timer, jiffies + HP_DIVA_CHECKTIME);
+	}
+
 	return 0;
 }
+#endif /* CONFIG_HP_DIVA */
 
 static int __devinit
 pci_xircom_fn(struct pci_dev *dev, struct pci_board *board, int enable)
@@ -4435,7 +4535,9 @@
 		8<<2, 2, pci_inteli960ni_fn, 0x10000},
 	{ SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,		   /* pbn_sgi_ioc3 */
 		1, 458333, 0, 0, 0, 0x20178 },
+#ifdef CONFIG_HP_DIVA
 	{ SPCI_FL_BASE0, 5, 115200, 8, 0, pci_hp_diva, 0},   /* pbn_hp_diva */
+#endif
 #ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.
@@ -4531,7 +4633,8 @@
 	if (ent->driver_data == pbn_default &&
 	    serial_pci_guess_board(dev, board))
 		return -ENODEV;
-	else if (serial_pci_guess_board(dev, &tmp) == 0) {
+	else if ((board->num_ports == 1) &&
+			serial_pci_guess_board(dev, &tmp) == 0) {
 		printk(KERN_INFO "Redundant entry in serial pci_table.  "
 		       "Please send the output of\n"
 		       "lspci -vv, this message (%04x,%04x,%04x,%04x)\n"
@@ -4885,10 +4988,12 @@
 		0x1048, 0x1500, 0, 0,
 		pbn_b1_1_115200 },
 
+	/* SGI IOC3 board */
 	{	PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
 		0xFF00, 0, 0, 0,
 		pbn_sgi_ioc3 },
 
+#ifdef CONFIG_HP_DIVA
 	/* HP Diva card */
 	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_SAS,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -4896,7 +5001,7 @@
 	{	PCI_VENDOR_ID_HP, 0x1290,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_1_115200 },
-
+#endif
 #ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.
@@ -5714,6 +5819,10 @@
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
 	del_timer_sync(&serial_timer);
+#ifdef CONFIG_HP_DIVA
+	if (hp_diva_count > 0)
+		del_timer_sync(&hp_diva_timer);
+#endif
 	save_flags(flags); cli();
         remove_bh(SERIAL_BH);
 	if ((e1 = tty_unregister_driver(&serial_driver)))
