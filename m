Return-Path: <linux-kernel-owner+w=401wt.eu-S1422984AbWLUR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWLUR0R (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422988AbWLUR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:26:17 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:62171 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422984AbWLUR0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:26:16 -0500
X-Greylist: delayed 1511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 12:26:16 EST
Date: Fri, 22 Dec 2006 02:01:02 +0900 (JST)
Message-Id: <20061222.020102.11963437.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ralf@linux-mips.org
Subject: [PATCH] serial: serial_txx9 driver update
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the serial_txx9 driver.

 * Configurable manumum port number. (SERIAL_TXX9_NR_UARTS)
 * Remove some code which is unneeded if CONFIG_PM=n.
 * Use PCI_DEVICE() for pci device id table and make it const.
 * Do not include <asm/irq.h>

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 Kconfig       |    5 +++++
 serial_txx9.c |   23 +++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 2978c09..5cc6b91 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -916,6 +916,11 @@ config SERIAL_TXX9
 config HAS_TXX9_SERIAL
 	bool
 
+config SERIAL_TXX9_NR_UARTS
+	int "Maximum number of TMPTX39XX/49XX SIO ports"
+	depends on SERIAL_TXX9
+	default "6"
+
 config SERIAL_TXX9_CONSOLE
 	bool "TMPTX39XX/49XX SIO Console support"
 	depends on SERIAL_TXX9=y
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 7186a82..f4440d3 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -37,6 +37,7 @@
  *	1.06	Do not insert a char caused previous overrun.
  *		Fix some spin_locks.
  *		Do not call uart_add_one_port for absent ports.
+ *	1.07	Use CONFIG_SERIAL_TXX9_NR_UARTS.  Cleanup.
  */
 
 #if defined(CONFIG_SERIAL_TXX9_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -58,9 +59,8 @@ #include <linux/serial.h>
 #include <linux/mutex.h>
 
 #include <asm/io.h>
-#include <asm/irq.h>
 
-static char *serial_version = "1.06";
+static char *serial_version = "1.07";
 static char *serial_name = "TX39/49 Serial driver";
 
 #define PASS_LIMIT	256
@@ -88,12 +88,7 @@ #endif
 /*
  * Number of serial ports
  */
-#ifdef ENABLE_SERIAL_TXX9_PCI
-#define NR_PCI_BOARDS	4
-#define UART_NR  (4 + NR_PCI_BOARDS)
-#else
-#define UART_NR  4
-#endif
+#define UART_NR  CONFIG_SERIAL_TXX9_NR_UARTS
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
@@ -987,6 +982,7 @@ int __init early_serial_txx9_setup(struc
 }
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
+#ifdef CONFIG_PM
 /**
  *	serial_txx9_suspend_port - suspend one serial port
  *	@line:  serial line number
@@ -1008,6 +1004,7 @@ static void serial_txx9_resume_port(int 
 {
 	uart_resume_port(&serial_txx9_reg, &serial_txx9_ports[line].port);
 }
+#endif
 
 static DEFINE_MUTEX(serial_txx9_mutex);
 
@@ -1118,6 +1115,7 @@ static void __devexit pciserial_txx9_rem
 	}
 }
 
+#ifdef CONFIG_PM
 static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	int line = (int)(long)pci_get_drvdata(dev);
@@ -1142,11 +1140,10 @@ static int pciserial_txx9_resume_one(str
 	}
 	return 0;
 }
+#endif
 
-static struct pci_device_id serial_txx9_pci_tbl[] = {
-	{	PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_MISC,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, 0 },
+static const struct pci_device_id serial_txx9_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_MISC) },
 	{ 0, }
 };
 
@@ -1154,8 +1151,10 @@ static struct pci_driver serial_txx9_pci
 	.name		= "serial_txx9",
 	.probe		= pciserial_txx9_init_one,
 	.remove		= __devexit_p(pciserial_txx9_remove_one),
+#ifdef CONFIG_PM
 	.suspend	= pciserial_txx9_suspend_one,
 	.resume		= pciserial_txx9_resume_one,
+#endif
 	.id_table	= serial_txx9_pci_tbl,
 };
 
