Return-Path: <linux-kernel-owner+w=401wt.eu-S932347AbWLLSzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWLLSzE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWLLSzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:55:04 -0500
Received: from mx0.karneval.cz ([81.27.192.123]:28416 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932347AbWLLSzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:55:00 -0500
Message-id: <806927252142229961@karneval.cz>
In-reply-to: <5182276292485062@karneval.cz>
Subject: [PATCH 2/3] Char: mxser_new, fix non-PCI build
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Dec 2006 19:15:29 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, fix non-PCI build

When CONFIG_PCI is not defined (i.e. PCI bus is disabled), the mxser_new
driver fails to link, since some pci functions are not available. Fix this
behaviour to be able to compile this driver on machines with no PCI bus (but
with ISA bus support).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 1bdc489336b6f2e6909c553f88f8275fafe741c6
tree 6030266a0852f5c00cc6714246f3ed8bde1dd58a
parent 1d9d86f80880cefeca436667a7824c9fe81ec6df
author Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:56:38 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:56:38 +0100

 drivers/char/Kconfig     |    2 +-
 drivers/char/mxser_new.c |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index d9095ff..f64f131 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -203,7 +203,7 @@ config MOXA_SMARTIO
 
 config MOXA_SMARTIO_NEW
 	tristate "Moxa SmartIO support v. 2.0 (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index efa8076..cd989dc 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -315,6 +315,7 @@ static struct mxser_mon_ext mon_data_ext;
 static int mxser_set_baud_method[MXSER_PORTS + 1];
 static spinlock_t gm_lock;
 
+#ifdef CONFIG_PCI
 static int CheckIsMoxaMust(int io)
 {
 	u8 oldmcr, hwid;
@@ -337,6 +338,7 @@ static int CheckIsMoxaMust(int io)
 	}
 	return MOXA_OTHER_UART;
 }
+#endif
 
 static void process_txrx_fifo(struct mxser_port *info)
 {
@@ -2380,9 +2382,11 @@ static void mxser_release_res(struct mxser_board *brd, struct pci_dev *pdev,
 	if (irq)
 		free_irq(brd->irq, brd);
 	if (pdev != NULL) {	/* PCI */
+#ifdef CONFIG_PCI
 		pci_release_region(pdev, 2);
 		pci_release_region(pdev, 3);
 		pci_dev_put(pdev);
+#endif
 	} else {
 		release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
 		release_region(brd->vector, 1);
@@ -2546,6 +2550,7 @@ static int __init mxser_get_ISA_conf(int cap, struct mxser_board *brd)
 static int __devinit mxser_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
+#ifdef CONFIG_PCI
 	struct mxser_board *brd;
 	unsigned int i, j;
 	unsigned long ioaddress;
@@ -2644,6 +2649,9 @@ err_relio:
 	brd->info = NULL;
 err:
 	return retval;
+#else
+	return -ENODEV;
+#endif
 }
 
 static void __devexit mxser_remove(struct pci_dev *pdev)
