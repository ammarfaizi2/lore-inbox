Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGRPfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGRPfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUGRPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 11:35:43 -0400
Received: from havoc.gtf.org ([216.162.42.101]:33723 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264261AbUGRPfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 11:35:37 -0400
Date: Sun, 18 Jul 2004 11:35:35 -0400
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] pmac_zilog: serial minors taken failure path fix (resend/combined)
Message-ID: <20040718153535.GA5169@havoc.gtf.org>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

It turns out that the pmac_zilog fix just patched over the symptom of
a bad failure path.  Please apply this to properly fix the problem.
There are three patches (and a more lengthy explanation) of this over
in the pmac_zilog thread:

+ one to fix the dev major/minor is taken failure path
+ one to patch the patch (stupid mistake), and
+ one to restore the default ppc config to what it had been 
  (apologies to Hollis and trini) 

Here are all three combined for your convenience.

-dte

I've tracked down the core issue giving me the oops wrt pmac_zilog.

When you have two serial drivers, (e.g. 8250 and PMAC_ZILOG) they both say

"I want to reserve X ports starting with major TTY_MAJOR and minor 64".

By the time pmac_zilog gets there, the ports it requests are already
reserved.  Unfortunately, init_pmz() doesn't check for pmz_register()
failure, and so it merrily goes on to register the half-initialized
pmac_zilog driver with the power management subsystem.
 
This path provides a proper failure path.

Also: 

Restore ppc configs now that I know people use AT Keyboards on CHRP and PReP
machines, and the zilog driver is no longer Oops'ing.

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
--- a/arch/ppc/defconfig	2004-07-18 11:29:40 -04:00
+++ b/arch/ppc/defconfig	2004-07-18 11:29:41 -04:00
@@ -689,7 +689,7 @@
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
@@ -724,8 +724,8 @@
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_CORE is not set
-# CONFIG_SERIAL_PMACZILOG is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_PMACZILOG=y
 # CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c	2004-07-18 11:29:40 -04:00
+++ b/drivers/serial/pmac_zilog.c	2004-07-18 11:29:40 -04:00
@@ -1433,6 +1433,7 @@
 			ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
 		if (uap->rx_dma_regs == NULL) {	
 			iounmap((void *)uap->tx_dma_regs);
+			uap->tx_dma_regs = NULL;
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
@@ -1490,7 +1491,6 @@
 	uap->port.ops = &pmz_pops;
 	uap->port.type = PORT_PMAC_ZILOG;
 	uap->port.flags = 0;
-	spin_lock_init(&uap->port.lock);
 
 	/* Setup some valid baud rate information in the register
 	 * shadows so we don't write crap there before baud rate is
@@ -1508,10 +1508,13 @@
 {
 	struct device_node *np;
 
-	iounmap((void *)uap->control_reg);
 	np = uap->node;
+	iounmap((void *)uap->rx_dma_regs);
+	iounmap((void *)uap->tx_dma_regs);
+	iounmap((void *)uap->control_reg);
 	uap->node = NULL;
 	of_node_put(np);
+	memset(uap, 0, sizeof(struct uart_pmac_port));
 }
 
 /*
@@ -1798,7 +1801,7 @@
 	 * Register this driver with the serial core
 	 */
 	rc = uart_register_driver(&pmz_uart_reg);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	/*
@@ -1808,10 +1811,19 @@
 		struct uart_pmac_port *uport = &pmz_ports[i];
 		/* NULL node may happen on wallstreet */
 		if (uport->node != NULL)
-			uart_add_one_port(&pmz_uart_reg, &uport->port);
+			rc = uart_add_one_port(&pmz_uart_reg, &uport->port);
+		if (rc)
+			goto err_out;
 	}
 
 	return 0;
+err_out:
+	while (i-- > 0) {
+		struct uart_pmac_port *uport = &pmz_ports[i];
+		uart_remove_one_port(&pmz_uart_reg, &uport->port);
+	}
+	uart_unregister_driver(&pmz_uart_reg);
+	return rc;
 }
 
 static struct of_match pmz_match[] = 
@@ -1841,6 +1853,7 @@
 
 static int __init init_pmz(void)
 {
+	int rc, i;
 	printk(KERN_INFO "%s\n", version);
 
 	/* 
@@ -1862,7 +1875,16 @@
 	/*
 	 * Now we register with the serial layer
 	 */
-	pmz_register();
+	rc = pmz_register();
+	if (rc) {
+		printk(KERN_ERR 
+			"pmac_zilog: Error registering serial device, disabling pmac_zilog.\n"
+		 	"pmac_zilog: Did another serial driver already claim the minors?\n"); 
+		/* effectively "pmz_unprobe()" */
+		for (i=0; i < pmz_ports_count; i++)
+			pmz_dispose_port(&pmz_ports[i]);
+		return rc;
+	}
 	
 	/*
 	 * Then we register the macio driver itself
