Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRCEMh6>; Mon, 5 Mar 2001 07:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRCEMhs>; Mon, 5 Mar 2001 07:37:48 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:46348 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129211AbRCEMhe>; Mon, 5 Mar 2001 07:37:34 -0500
Date: Mon, 5 Mar 2001 15:37:04 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Cc: tytso@valinux.com
Subject: [PATCH] /drivers/char/serial.c cleanup
Message-ID: <20010305153704.A20753@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

I already sent this patch some days ago, but didn't get an answer :(
So, i'm trying to resubmit it.

Attached patch (2.4.2-ac11) makes some changes in serial driver:
adds ioremap() return code checks, removes panic() calls
and adds better error handling in start_pci_pnp_board() function.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial
Content-Transfer-Encoding: quoted-printable

diff -u /linux.vanilla/drivers/char/serial.c /linux/drivers/char/serial.c
--- /linux.vanilla/drivers/char/serial.c	Thu Mar  1 20:15:43 2001
+++ /linux/drivers/char/serial.c	Fri Mar  2 00:10:29 2001
@@ -3876,7 +3876,10 @@
 		return 0;
 	}
 	req->io_type =3D SERIAL_IO_MEM;
-	req->iomem_base =3D ioremap(port, board->uart_offset);
+	if ((req->iomem_base =3D ioremap(port, board->uart_offset))) {
+		printk(KERN_ERR "serial: Couldn's remap IO memory at %#lx\n", port);
+		return 1;
+	}
 	req->iomem_reg_shift =3D board->reg_shift;
 	req->port =3D 0;
 	return 0;
@@ -3939,8 +3942,13 @@
 	 * shutdown the board on a module unload.
 	 */
 	if (DEACTIVATE_FUNC(dev) || board->init_fn) {
-		if (serial_pci_board_idx >=3D NR_PCI_BOARDS)
+		if (serial_pci_board_idx >=3D NR_PCI_BOARDS) {
+			if (board->init_fn)
+				(board->init_fn)(dev, board, 0);
+			if (board->flags & SPCI_FL_ISPNP)
+				(DEACTIVATE_FUNC(dev))(dev);
 			return;
+		}
 		serial_pci_board[serial_pci_board_idx].board =3D *board;
 		serial_pci_board[serial_pci_board_idx].dev =3D dev;
 		serial_pci_board_idx++;
@@ -3954,8 +3962,13 @@
=20
 	for (k=3D0; k < board->num_ports; k++) {
 		serial_req.irq =3D get_pci_irq(dev, board, k);
-		if (get_pci_port(dev, board, &serial_req, k))
+		if (get_pci_port(dev, board, &serial_req, k)) {
+			if (board->init_fn)
+				(board->init_fn)(dev, board, 0);
+			if ((board->flags & SPCI_FL_ISPNP) && (k =3D=3D 0))
+				(DEACTIVATE_FUNC(dev))(dev);
 			break;
+		}
 		serial_req.flags =3D ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
 #ifdef SERIAL_DEBUG_PCI
 		printk("Setup PCI/PNP port: port %x, irq %d, type %d\n",
@@ -4010,7 +4023,11 @@
 				      data | pci_config);
 =09
 	/* enable/disable interrupts */
-	p =3D ioremap(pci_resource_start(dev, 0), 0x80);
+	if ((p =3D ioremap(pci_resource_start(dev, 0), 0x80))) {
+		printk( KERN_ERR "serial: Couldn't remap IO memory at %#lx\n",
+			pci_resource_start(dev, 0));
+		return 1;
+	}
 	writel(enable ? irq_config : 0x00, (unsigned long)p + 0x4c);
 	iounmap(p);
=20
@@ -4053,7 +4070,11 @@
=20
        if (!enable) return 0;
=20
-       p =3D ioremap(pci_resource_start(dev, 0), 0x80);
+       if ((p =3D ioremap(pci_resource_start(dev, 0), 0x80))) {
+       		printk( KERN_ERR "serial: Couldn't remap IO memory at %#lx\n",
+			pci_resource_start(dev, 0));
+		return 1;
+       }
=20
        switch (dev->device & 0xfff8) {
                case PCI_DEVICE_ID_SIIG_1S_10x:         /* 1S */
@@ -5215,6 +5236,16 @@
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
@@ -5315,11 +5346,17 @@
 	callout_driver.proc_entry =3D 0;
 #endif
=20
-	if (tty_register_driver(&serial_driver))
-		panic("Couldn't register serial driver\n");
-	if (tty_register_driver(&callout_driver))
-		panic("Couldn't register callout driver\n");
-=09
+	if ((i =3D tty_register_driver(&serial_driver))) {
+		printk(KERN_ERR "serial: Couldn't register serial driver\n");
+		rs_cleanup_after_failure(NULL);
+		return i;
+	}
+	if ((i =3D tty_register_driver(&callout_driver))) {
+		printk(KERN_ERR "serial: Couldn't register callout driver\n");
+		rs_cleanup_after_failure(&serial_driver);
+		return i;
+	}
+
 	for (i =3D 0, state =3D rs_table; i < NR_PORTS; i++,state++) {
 		state->magic =3D SSTATE_MAGIC;
 		state->line =3D i;

--ReaqsoxgOBHFXBhH--

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6o4hwBm4rlNOo3YgRAgkLAKCJG66YTK9YLWdW7TytaxZr/fjjxwCfa80p
Di9OumOXYyfVh1pOjOpNwPA=
=5Jrn
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
