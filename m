Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUAYAkt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUAYAkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:40:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9703 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261774AbUAYAke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:40:34 -0500
Date: Sun, 25 Jan 2004 01:40:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       irda-users@lists.sourceforge.net, linux-irda@pasta.cs.uit.no,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.4 patch] fix via-ircc.c .text.exit error
Message-ID: <20040125004030.GE6441@fs.tum.de>
References: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 12:11:58PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.25-pre5 to v2.4.25-pre6
> ============================================
>...
> Jean Tourrilhes:
>...
>   o VIA IrDA driver
>...

I got the following link error in 2.4.25-pre7 when trying to compile 
drivers/net/irda/via-ircc.c statically into the kernel:

<--  snip  -->

...
        -o vmlinux
local symbol 0: discarded in section `.text.exit' from drivers/net/irda/irda.o
make: *** [vmlinux] Error 1

<--  snip  -->


The patch below fixes this issue. It does:
- remove __init/__exit from function prototypes (not needed)
- __init -> __devinit
- __exit -> __devexit
- __devexit_p for via_remove_one


cu
Adrian


--- linux-2.4.25-pre7-full/drivers/net/irda/via-ircc.c.old	2004-01-24 20:19:32.000000000 +0100
+++ linux-2.4.25-pre7-full/drivers/net/irda/via-ircc.c	2004-01-24 20:23:16.000000000 +0100
@@ -79,7 +79,7 @@
 
 /* Some prototypes */
 static int via_ircc_open(int i, chipio_t * info, unsigned int id);
-static int __exit via_ircc_close(struct via_ircc_cb *self);
+static int via_ircc_close(struct via_ircc_cb *self);
 static int via_ircc_setup(chipio_t * info, unsigned int id);
 static int via_ircc_dma_receive(struct via_ircc_cb *self);
 static int via_ircc_dma_receive_complete(struct via_ircc_cb *self,
@@ -107,8 +107,8 @@
 void hwreset(struct via_ircc_cb *self);
 static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase);
 static int upload_rxdata(struct via_ircc_cb *self, int iobase);
-static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
-static void __exit via_remove_one (struct pci_dev *pdev);
+static int via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
+static void via_remove_one (struct pci_dev *pdev);
 
 /* Should use udelay() instead, even if we are x86 only - Jean II */
 void iodelay(int udelay)
@@ -137,7 +137,7 @@
 	.name		= VIA_MODULE_NAME,
 	.id_table	= via_pci_tbl,
 	.probe		= via_init_one,
-	.remove		= via_remove_one,
+	.remove		= __devexit_p(via_remove_one),
 };
 
 
@@ -146,7 +146,7 @@
  *
  *    Initialize chip. Just find out chip type and resource.
  */
-int __init via_ircc_init(void)
+int __devinit via_ircc_init(void)
 {
 	int rc;
 
@@ -168,7 +168,7 @@
 
 }
 
-static int __init via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
+static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id)
 {
 	int rc;
         u8 temp,oldPCI_40,oldPCI_44,bTmp,bTmp1;
@@ -288,7 +288,7 @@
  *    Close all configured chips
  *
  */
-static void __exit via_ircc_clean(void)
+static void __devexit via_ircc_clean(void)
 {
 	int i;
 
@@ -301,7 +301,7 @@
 	}
 }
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 #ifdef	HEADMSG
         DBG(printk(KERN_INFO "via_remove_one :  ......\n"));
@@ -310,7 +310,7 @@
 
 }
 
-static void __exit via_ircc_cleanup(void)
+static void __devexit via_ircc_cleanup(void)
 {
 
 #ifdef	HEADMSG
@@ -326,7 +326,7 @@
  *    Open driver instance
  *
  */
-static __init int via_ircc_open(int i, chipio_t * info, unsigned int id)
+static __devinit int via_ircc_open(int i, chipio_t * info, unsigned int id)
 {
 	struct net_device *dev;
 	struct via_ircc_cb *self;
@@ -460,7 +460,7 @@
  *    Close driver instance
  *
  */
-static int __exit via_ircc_close(struct via_ircc_cb *self)
+static int __devexit via_ircc_close(struct via_ircc_cb *self)
 {
 	int iobase;
 
