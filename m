Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130224AbRBZO2t>; Mon, 26 Feb 2001 09:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRBZO2n>; Mon, 26 Feb 2001 09:28:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130215AbRBZO22>;
	Mon, 26 Feb 2001 09:28:28 -0500
Date: Mon, 26 Feb 2001 16:30:08 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial drivers: get rid of panic() call
Message-ID: <20010226163008.A9084@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

please take a look at attached patches (2.4.2-ac1):

cyclades.c: remove panic() calls;

serial.c: ioremap() checks, better error handling in start_pci_pnp_board() =
function
(dectivate/deinit device on failire), remove panic() calls.


Also I have some questions:
 - trying to remove panic() from epca.c I found that it calls tty_register_=
driver()
3 times and tty_unregister_driver() 2 times (registers pc_driver, pc_callou=
t and=20
pc_info, but unregisters only first two). BUG ?

 - is here any sane reason (this question also about epca.c) to detect PCI =
devices=20
before tty_register_driver() calls ?

 - amiserial.c calls requesst_irq() for IRQ_AMIGA_TBE and IRQ_AMIGA_RBF, but
doesn't free then on unload and doesn't check return values. BUG too ?

I don't know anything about Amiga's, so last question can be horribly stupi=
d :))

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cyclades

diff -ur /linux.vanilla/drivers/char/cyclades.c /linux/drivers/char/cyclades.c
--- /linux.vanilla/drivers/char/cyclades.c	Fri Feb 23 20:37:51 2001
+++ /linux/drivers/char/cyclades.c	Mon Feb 26 23:05:10 2001
@@ -5478,6 +5478,15 @@
     extra ports are ignored.
  */
 
+static void __init cy_cleanup_after_failure(struct tty_driver *tty)
+{
+	unsigned long flags;
+	save_flags(flags); cli();
+	remove_bh(CYCLADES_BH);
+	if (tty) tty_unregister_driver(tty);
+	restore_flags(flags);
+}
+
 int __init
 cy_init(void)
 {
@@ -5544,10 +5553,16 @@
     cy_callout_driver.proc_entry = 0;
 
 
-    if (tty_register_driver(&cy_serial_driver))
-            panic("Couldn't register Cyclades serial driver\n");
-    if (tty_register_driver(&cy_callout_driver))
-            panic("Couldn't register Cyclades callout driver\n");
+    if ((i = tty_register_driver(&cy_serial_driver))) {
+	    printk(KERN_ERR "cyclades: Couldn't register Cyclades serial driver\n");
+	    cy_cleanup_after_failure(NULL);
+	    return i;
+    }
+    if ((i = tty_register_driver(&cy_callout_driver))) {
+	    printk(KERN_ERR "cyclades: Couldn't register Cyclades callout driver\n");
+	    cy_cleanup_after_failure(&cy_serial_driver);
+	    return i;
+    }
 
     for (i = 0; i < NR_CARDS; i++) {
             /* base_addr=0 indicates board not found */

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial

diff -ur linux.vanilla/drivers/char/serial.c linux/drivers/char/serial.c
--- linux.vanilla/drivers/char/serial.c	Thu Feb 22 17:20:27 2001
+++ linux/drivers/char/serial.c	Mon Feb 26 16:04:02 2001
@@ -3876,7 +3876,8 @@
 		return 0;
 	}
 	req->io_type = SERIAL_IO_MEM;
-	req->iomem_base = ioremap(port, board->uart_offset);
+	if ((req->iomem_base = ioremap(port, board->uart_offset)) == NULL)
+		return 1;
 	req->iomem_reg_shift = board->reg_shift;
 	req->port = 0;
 	return 0;
@@ -3939,8 +3940,13 @@
 	 * shutdown the board on a module unload.
 	 */
 	if (DEACTIVATE_FUNC(dev) || board->init_fn) {
-		if (serial_pci_board_idx >= NR_PCI_BOARDS)
+		if (serial_pci_board_idx >= NR_PCI_BOARDS) {
+			if (board->init_fn)
+				(board->init_fn)(dev, board, 0);
+			if (board->flags & SPCI_FL_ISPNP)
+				(DEACTIVATE_FUNC(dev))(dev);
 			return;
+		}
 		serial_pci_board[serial_pci_board_idx].board = *board;
 		serial_pci_board[serial_pci_board_idx].dev = dev;
 		serial_pci_board_idx++;
@@ -3954,8 +3960,15 @@
 
 	for (k=0; k < board->num_ports; k++) {
 		serial_req.irq = get_pci_irq(dev, board, k);
-		if (get_pci_port(dev, board, &serial_req, k))
+		if (get_pci_port(dev, board, &serial_req, k)) {
+			if (!k) {
+				if (board->init_fn)
+					(board->init_fn)(dev, board, 0);
+				if (board->flags & SPCI_FL_ISPNP)
+					(DEACTIVATE_FUNC(dev))(dev);
+			}
 			break;
+		}
 		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
 #ifdef SERIAL_DEBUG_PCI
 		printk("Setup PCI/PNP port: port %x, irq %d, type %d\n",
@@ -4010,7 +4023,8 @@
 				      data | pci_config);
 	
 	/* enable/disable interrupts */
-	p = ioremap(pci_resource_start(dev, 0), 0x80);
+	if ((p = ioremap(pci_resource_start(dev, 0), 0x80)) == NULL)
+		return 1;
 	writel(enable ? irq_config : 0x00, (unsigned long)p + 0x4c);
 	iounmap(p);
 
@@ -4053,7 +4067,8 @@
 
        if (!enable) return 0;
 
-       p = ioremap(pci_resource_start(dev, 0), 0x80);
+       if ((p = ioremap(pci_resource_start(dev, 0), 0x80)) == NULL)
+		return 1;
 
        switch (dev->device & 0xfff8) {
                case PCI_DEVICE_ID_SIIG_1S_10x:         /* 1S */
@@ -5099,6 +5114,16 @@
 /*
  * The serial driver boot-time initialization code!
  */
+static void __init rs_cleanup_after_failure(struct tty_driver *tty)
+{
+	unsigned long flags;
+	del_timer_sync(&serial_timer);
+	save_flags(flags); cli();
+	remove_bh(SERIAL_BH);
+	if (tty) tty_unregister_driver(tty);
+	restore_flags(flags);
+}
+
 static int __init rs_init(void)
 {
 	int i;
@@ -5198,11 +5223,17 @@
 	callout_driver.proc_entry = 0;
 #endif
 
-	if (tty_register_driver(&serial_driver))
-		panic("Couldn't register serial driver\n");
-	if (tty_register_driver(&callout_driver))
-		panic("Couldn't register callout driver\n");
-	
+	if ((i = tty_register_driver(&serial_driver))) {
+		printk(KERN_ERR "serial: Couldn't register serial driver\n");
+		rs_cleanup_after_failure(NULL);
+		return i;
+	}
+	if ((i = tty_register_driver(&callout_driver))) {
+		printk(KERN_ERR "serial: Couldn't register callout driver\n");
+		rs_cleanup_after_failure(&serial_driver);
+		return i;
+	}
+
 	for (i = 0, state = rs_table; i < NR_PORTS; i++,state++) {
 		state->magic = SSTATE_MAGIC;
 		state->line = i;

--tjCHc7DPkfUGtrlw--

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6mlpgBm4rlNOo3YgRAhicAKCMrpeyjDacFQtu1N751eQABPEzmACdEuHw
8x+F5/XEYU5Gji6hgI/5Nso=
=HNe/
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
