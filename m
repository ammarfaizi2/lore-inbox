Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbULHNmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbULHNmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULHNk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:40:56 -0500
Received: from users.linvision.com ([62.58.92.114]:6887 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261217AbULHNaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:30:02 -0500
Date: Wed, 8 Dec 2004 14:30:00 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: [PATCH] SX
Message-ID: <20041208133000.GD19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Patrick van de Lageweg <patrick@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch converts all save_flags/restore_flags to the new
spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
other 2.6.X cleanups. This allows the "sx" driver to become
SMP safe.


Signed-off-by: Patrick vd Lageweg <patrick@bitwizard.nl>
Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>

        Patrick

--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-08122004-2.6.10-rc3-sx"

diff -u -r linux-2.6.10-rc3-clean/drivers/char/Kconfig linux-2.6.10-rc3-sx/drivers/char/Kconfig
--- linux-2.6.10-rc3-clean/drivers/char/Kconfig	Fri Dec  3 15:13:32 2004
+++ linux-2.6.10-rc3-sx/drivers/char/Kconfig	Fri Dec  3 15:25:17 2004
@@ -288,7 +288,7 @@
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.
diff -u -r linux-2.6.10-rc3-clean/drivers/char/sx.c linux-2.6.10-rc3-sx/drivers/char/sx.c
--- linux-2.6.10-rc3-clean/drivers/char/sx.c	Fri Dec  3 15:13:33 2004
+++ linux-2.6.10-rc3-sx/drivers/char/sx.c	Fri Dec  3 15:25:17 2004
@@ -4,7 +4,7 @@
  *  This driver will also support the older SI, and XIO cards.
  *
  *
- *   (C) 1998 - 2000  R.E.Wolff@BitWizard.nl
+ *   (C) 1998 - 2004  R.E.Wolff@BitWizard.nl
  *
  *  Simon Allen (simonallen@cix.compulink.co.uk) wrote a previous
  *  version of this driver. Some fragments may have been copied. (none
@@ -251,6 +251,8 @@
 #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
 #endif
 
+/* Not used anymore??? - PVDL */
+#if 1
 #ifdef CONFIG_PCI
 static struct pci_device_id sx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, PCI_ANY_ID, PCI_ANY_ID },
@@ -258,6 +260,7 @@
 };
 MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
 #endif /* CONFIG_PCI */
+#endif
 
 /* Configurable options: 
    (Don't be too sure that it'll work if you toggle them) */
@@ -354,13 +357,13 @@
    Some architectures may need more. */
 static int sx_irqmask = -1;
 
-MODULE_PARM(sx_probe_addrs, "i");
-MODULE_PARM(si_probe_addrs, "i");
-MODULE_PARM(sx_poll, "i");
-MODULE_PARM(sx_slowpoll, "i");
-MODULE_PARM(sx_maxints, "i");
-MODULE_PARM(sx_debug, "i");
-MODULE_PARM(sx_irqmask, "i");
+module_param_array(sx_probe_addrs, int, NULL, 0);
+module_param_array(si_probe_addrs, int, NULL, 0);
+module_param(sx_poll, int, 0);
+module_param(sx_slowpoll, int, 0);
+module_param(sx_maxints, int, 0);
+module_param(sx_debug, int, 0);
+module_param(sx_irqmask, int, 0);
 
 MODULE_LICENSE("GPL");
 
@@ -396,7 +399,7 @@
 
 
 
-#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\b",__FUNCTION__)
+#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n",__FUNCTION__)
 #define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  %s\n", __FUNCTION__)
 
 #define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", \
@@ -1158,7 +1161,6 @@
 	if (hi_state & ST_BREAK) {
 		hi_state &= ~ST_BREAK;
 		sx_dprintk (SX_DEBUG_MODEMSIGNALS, "got a break.\n");
-
 		sx_write_channel_byte (port, hi_state, hi_state);
 		gs_got_break (&port->gs);
 	}
@@ -1206,7 +1208,7 @@
 	struct sx_port *port;
 	int i;
 
-	/*   func_enter ();  */
+	func_enter (); 
 	sx_dprintk (SX_DEBUG_FLOW, "sx: enter sx_interrupt (%d/%d)\n", irq, board->irq); 
 
 	/* AAargh! The order in which to do these things is essential and
@@ -1297,7 +1299,7 @@
 	clear_bit (SX_BOARD_INTR_LOCK, &board->locks);
 
 	sx_dprintk (SX_DEBUG_FLOW, "sx: exit sx_interrupt (%d/%d)\n", irq, board->irq); 
-	/*  func_exit ();  */
+        func_exit (); 
 	return IRQ_HANDLED;
 }
 
@@ -1428,6 +1430,7 @@
 {
 	struct sx_port *port;
 	int retval, line;
+	unsigned long flags;
 
 	func_enter();
 
@@ -1449,9 +1452,12 @@
 
 	sx_dprintk (SX_DEBUG_OPEN, "port = %p c_dcd = %d\n", port, port->c_dcd);
 
+	spin_lock_irqsave(&port->gs.driver_lock, flags);
+
 	tty->driver_data = port;
 	port->gs.tty = tty;
 	port->gs.count++;
+	spin_unlock_irqrestore(&port->gs.driver_lock, flags);
 
 	sx_dprintk (SX_DEBUG_OPEN, "starting port\n");
 
@@ -1466,7 +1472,8 @@
 	}
 
 	port->gs.flags |= GS_ACTIVE;
-	sx_setsignals (port, 1,1);
+	if (port->gs.count <= 1)
+		sx_setsignals (port, 1,1);
 
 #if 0
 	if (sx_debug & SX_DEBUG_OPEN)
@@ -1475,11 +1482,15 @@
 	if (sx_debug & SX_DEBUG_OPEN)
 		my_hd_io (port->board->base + port->ch_base, sizeof (*port));
 #endif
-
-	if (sx_send_command (port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
-		printk (KERN_ERR "sx: Card didn't respond to LOPEN command.\n");
-		port->gs.count--;
-		return -EIO;
+	
+	if (port->gs.count <= 1) {
+		if (sx_send_command (port, HS_LOPEN, -1, HS_IDLE_OPEN) != 1) {
+			printk (KERN_ERR "sx: Card didn't respond to LOPEN command.\n");
+			spin_lock_irqsave(&port->gs.driver_lock, flags);
+			port->gs.count--;
+			spin_unlock_irqrestore(&port->gs.driver_lock, flags);
+			return -EIO;
+		}
 	}
 
 	retval = gs_block_til_ready(port, filp);
@@ -1497,6 +1508,7 @@
 
 	port->c_dcd = sx_get_CD (port);
 	sx_dprintk (SX_DEBUG_OPEN, "at open: cd=%d\n", port->c_dcd);
+
 	func_exit();
 	return 0;
 
@@ -1535,7 +1547,8 @@
 
 	if(port->gs.count) {
 		sx_dprintk(SX_DEBUG_CLOSE, "WARNING port count:%d\n", port->gs.count);
-		port->gs.count = 0;
+		//printk ("%s SETTING port count to zero: %p count: %d\n", __FUNCTION__, port, port->gs.count);
+		//port->gs.count = 0;
 	}
 
 	func_exit ();
@@ -1751,12 +1764,16 @@
 	struct sx_port *port = tty->driver_data;
 	int rv;
 
+	func_enter ();
+
 	if (flag) 
 		rv = sx_send_command (port, HS_START, -1, HS_IDLE_BREAK);
 	else 
 		rv = sx_send_command (port, HS_STOP, -1, HS_IDLE_OPEN);
 	if (rv != 1) printk (KERN_ERR "sx: couldn't send break (%x).\n",
 			read_sx_byte (port->board, CHAN_OFFSET (port, hi_hstat)));
+
+	func_exit ();
 }
 
 
@@ -2105,7 +2122,7 @@
 		}
 
 		if (((vpdp.uniqid >> 24) & SX_UNIQUEID_MASK) == SX_ISA_UNIQUEID1) {
-			if (board->hw_base & 0x8000) {
+			if (((unsigned long)board->hw_base) & 0x8000) {
 				printk (KERN_WARNING "sx: Warning: There may be hardware problems with the card at %lx.\n", board->hw_base);
 				printk (KERN_WARNING "sx: Read sx.txt for more info.\n");
 			}
@@ -2154,6 +2171,7 @@
 	    }
 		for (i=0;i<8;i++) {
 			if ((read_sx_byte (board, SI2_ISA_ID_BASE+7-i) & 7) != i) {
+				func_exit ();
 				return 0;
 			}
 		}
@@ -2168,11 +2186,13 @@
 		/* This should be an SI1 board, which has this
 		   location writable... */
 		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10)
+			func_exit ();
 			return 0; 
 	} else {
 		/* This should be an SI2 board, which has the bottom
 		   3 bits non-writable... */
 		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10)
+			func_exit ();
 			return 0; 
 	}
 
@@ -2185,11 +2205,13 @@
 		/* This should be an SI1 board, which has this
 		   location writable... */
 		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10)
+			func_exit();
 			return 0; 
 	} else {
 		/* This should be an SI2 board, which has the bottom
 		   3 bits non-writable... */
 		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10)
+			func_exit ();
 			return 0; 
 	}
 
@@ -2306,6 +2328,7 @@
 #ifdef NEW_WRITE_LOCKING
 			port->gs.port_write_sem = MUTEX;
 #endif
+			port->gs.driver_lock = SPIN_LOCK_UNLOCKED;
 			/*
 			 * Initializing wait queue
 			 */
@@ -2477,7 +2500,7 @@
 			found++;
 			fix_sx_pci (pdev, board);
 		} else 
-			iounmap(board->base);
+			iounmap(board->base2);
 	}
 #endif
 

--k4f25fnPtRuIRUb3--
