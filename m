Return-Path: <linux-kernel-owner+w=401wt.eu-S1751095AbXASD5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbXASD5z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXASD5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:57:55 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45423 "EHLO
	topsns2.toshiba-tops.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbXASD5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:57:54 -0500
Date: Fri, 19 Jan 2007 12:57:51 +0900 (JST)
Message-Id: <20070119.125751.104030382.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070119.121910.96686038.nemoto@toshiba-tops.co.jp>
References: <20070118160338.GA6343@linux-mips.org>
	<20070118135326.c0238873.akpm@osdl.org>
	<20070119.121910.96686038.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007 12:19:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> OK, here is a revised patch which uses pci= option instead of config
> parameters.

Sorry, this patch would cause build failure if setup-bus.c was not
built into kernel.  Revised again.


Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable

CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
might result in allocation failure for the reserving itself on some
platforms (for example typical 32bit MIPS).  Make it (and
CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 drivers/pci/pci.c                   |   16 ++++++++++++++++
 drivers/pci/setup-bus.c             |   27 ++++++++++-----------------
 include/linux/pci.h                 |    3 +++
 4 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 25d2985..ace7a9a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters. 
 				This sorting is done to get a device
 				order compatible with older (<= 2.4) kernels.
 		nobfsort	Don't sort PCI devices into breadth-first order.
+		cbiosize=nn[KMG]	A fixed amount of bus space is
+				reserved for CardBus bridges.
+				The default value is 256 bytes.
+		cbmemsize=nn[KMG]	A fixed amount of bus space is
+				reserved for CardBus bridges.
+				The default value is 64 megabytes.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 206c834..dc7f40e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1159,6 +1159,16 @@ static int __devinit pci_init(void)
 	return 0;
 }
 
+/*
+ * FIXME: IO should be max 256 bytes.  However, since we may
+ * have a P2P bridge below a cardbus bridge, we need 4K.
+ */
+#define DEFAULT_CARDBUS_IO_SIZE		(256)
+#define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
+/* pci=cbmemsize=nnM,cbiosize=nn can override this */
+unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
+unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
+
 static int __devinit pci_setup(char *str)
 {
 	while (str) {
@@ -1168,6 +1178,12 @@ static int __devinit pci_setup(char *str
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strncmp(str, "cbiosize=", 9)) {
+				pci_cardbus_io_size =
+					memparse(str + 9, &str);
+			} else if (!strncmp(str, "cbmemsize=", 10)) {
+				pci_cardbus_mem_size =
+					memparse(str + 10, &str);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 89f3036..3554f39 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -36,13 +36,6 @@ #endif
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
-/*
- * FIXME: IO should be max 256 bytes.  However, since we may
- * have a P2P bridge below a cardbus bridge, we need 4K.
- */
-#define CARDBUS_IO_SIZE		(256)
-#define CARDBUS_MEM_SIZE	(64*1024*1024)
-
 static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
@@ -415,12 +408,12 @@ pci_bus_size_cardbus(struct pci_bus *bus
 	 * Reserve some resources for CardBus.  We reserve
 	 * a fixed amount of bus space for CardBus bridges.
 	 */
-	b_res[0].start = CARDBUS_IO_SIZE;
-	b_res[0].end = b_res[0].start + CARDBUS_IO_SIZE - 1;
+	b_res[0].start = pci_cardbus_io_size;
+	b_res[0].end = b_res[0].start + pci_cardbus_io_size - 1;
 	b_res[0].flags |= IORESOURCE_IO;
 
-	b_res[1].start = CARDBUS_IO_SIZE;
-	b_res[1].end = b_res[1].start + CARDBUS_IO_SIZE - 1;
+	b_res[1].start = pci_cardbus_io_size;
+	b_res[1].end = b_res[1].start + pci_cardbus_io_size - 1;
 	b_res[1].flags |= IORESOURCE_IO;
 
 	/*
@@ -440,16 +433,16 @@ pci_bus_size_cardbus(struct pci_bus *bus
 	 * twice the size.
 	 */
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
-		b_res[2].start = CARDBUS_MEM_SIZE;
-		b_res[2].end = b_res[2].start + CARDBUS_MEM_SIZE - 1;
+		b_res[2].start = pci_cardbus_mem_size;
+		b_res[2].end = b_res[2].start + pci_cardbus_mem_size - 1;
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
-		b_res[3].start = CARDBUS_MEM_SIZE;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE - 1;
+		b_res[3].start = pci_cardbus_mem_size;
+		b_res[3].end = b_res[3].start + pci_cardbus_mem_size - 1;
 		b_res[3].flags |= IORESOURCE_MEM;
 	} else {
-		b_res[3].start = CARDBUS_MEM_SIZE * 2;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE * 2 - 1;
+		b_res[3].start = pci_cardbus_mem_size * 2;
+		b_res[3].end = b_res[3].start + pci_cardbus_mem_size * 2 - 1;
 		b_res[3].flags |= IORESOURCE_MEM;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3c617e..ff04c69 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -837,5 +837,8 @@ #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32	/* Need low latency setting */
 #define PCIAGP_FAIL		64	/* No PCI to AGP DMA */
 
+extern unsigned long pci_cardbus_io_size;
+extern unsigned long pci_cardbus_mem_size;
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
