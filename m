Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIKGzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIKGzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 02:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUIKGzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 02:55:53 -0400
Received: from ozlabs.org ([203.10.76.45]:54757 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267410AbUIKGzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 02:55:49 -0400
Date: Sat, 11 Sep 2004 16:54:06 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix real bugs uncovered by -Wno-uninitialized removal
Message-ID: <20040911065406.GA32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The removal of -Wno-uninitialized on ppc64 revealed a number of real
bugs.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN drivers/char/hvcs.c~realbugs drivers/char/hvcs.c
--- foobar2/drivers/char/hvcs.c~realbugs	2004-09-11 15:32:35.532933850 +1000
+++ foobar2-anton/drivers/char/hvcs.c	2004-09-11 15:32:35.580930160 +1000
@@ -427,7 +427,7 @@ static int hvcs_io(struct hvcs_struct *h
 	struct tty_struct *tty;
 	char buf[HVCS_BUFF_LEN] __ALIGNED__;
 	unsigned long flags;
-	int got;
+	int got = 0;
 	int i;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
@@ -945,7 +945,7 @@ static int hvcs_enable_device(struct hvc
  */
 struct hvcs_struct *hvcs_get_by_index(int index)
 {
-	struct hvcs_struct *hvcsd;
+	struct hvcs_struct *hvcsd = NULL;
 	unsigned long flags;
 
 	spin_lock(&hvcs_structs_lock);
@@ -1433,7 +1433,7 @@ static int __init hvcs_module_init(void)
 			" as a tty driver failed.\n");
 		hvcs_free_index_list();
 		put_tty_driver(hvcs_tty_driver);
-		return rc;
+		return -EIO;
 	}
 
 	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
diff -puN drivers/net/ibmveth.c~realbugs drivers/net/ibmveth.c
--- foobar2/drivers/net/ibmveth.c~realbugs	2004-09-11 15:32:35.538933389 +1000
+++ foobar2-anton/drivers/net/ibmveth.c	2004-09-11 15:41:13.949998616 +1000
@@ -885,13 +885,16 @@ static int __devinit ibmveth_probe(struc
 
 	mac_addr_p = (unsigned char *) vio_get_attribute(dev, VETH_MAC_ADDR, 0);
 	if(!mac_addr_p) {
-		ibmveth_error_printk("Can't find VETH_MAC_ADDR attribute\n");
+		printk(KERN_ERR "(%s:%3.3d) ERROR: Can't find VETH_MAC_ADDR "
+				"attribute\n", __FILE__, __LINE__); 
 		return 0;
 	}
 	
 	mcastFilterSize_p= (unsigned int *) vio_get_attribute(dev, VETH_MCAST_FILTER_SIZE, 0);
 	if(!mcastFilterSize_p) {
-		ibmveth_error_printk("Can't find VETH_MCAST_FILTER_SIZE attribute\n");
+		printk(KERN_ERR "(%s:%3.3d) ERROR: Can't find "
+				"VETH_MCAST_FILTER_SIZE attribute\n",
+				__FILE__, __LINE__); 
 		return 0;
 	}
 	
diff -puN drivers/pci/hotplug/rpaphp_core.c~realbugs drivers/pci/hotplug/rpaphp_core.c
--- foobar2/drivers/pci/hotplug/rpaphp_core.c~realbugs	2004-09-11 15:32:35.545932850 +1000
+++ foobar2-anton/drivers/pci/hotplug/rpaphp_core.c	2004-09-11 15:32:35.575930545 +1000
@@ -449,7 +449,7 @@ static int rpaphp_disable_slot(struct pc
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	int retval;
+	int retval = -EINVAL;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
 	dbg("%s - Entry: slot[%s]\n", __FUNCTION__, slot->name);
diff -puN drivers/pci/hotplug/rpaphp_pci.c~realbugs drivers/pci/hotplug/rpaphp_pci.c
--- foobar2/drivers/pci/hotplug/rpaphp_pci.c~realbugs	2004-09-11 15:32:35.551932389 +1000
+++ foobar2-anton/drivers/pci/hotplug/rpaphp_pci.c	2004-09-11 15:32:35.582930007 +1000
@@ -186,7 +186,7 @@ static struct pci_dev *
 rpaphp_pci_config_slot(struct device_node *dn, struct pci_bus *bus)
 {
 	struct device_node *eads_first_child = dn->child;
-	struct pci_dev *dev;
+	struct pci_dev *dev = NULL;
 	int num;
 	
 	dbg("Enter %s: dn=%s bus=%s\n", __FUNCTION__, dn->full_name, bus->name);
diff -puN arch/ppc64/kernel/iSeries_pci_reset.c~realbugs arch/ppc64/kernel/iSeries_pci_reset.c
--- foobar2/arch/ppc64/kernel/iSeries_pci_reset.c~realbugs	2004-09-11 16:11:41.437058963 +1000
+++ foobar2-anton/arch/ppc64/kernel/iSeries_pci_reset.c	2004-09-11 16:11:45.839379196 +1000
@@ -65,7 +65,8 @@ int iSeries_Device_ToggleReset(struct pc
 		AssertDelay = (5 * HZ) / 10;
 	else
 		AssertDelay = (AssertTime * HZ) / 10;
-	if (WaitDelay == 0)
+
+	if (DelayTime == 0)
 		WaitDelay = (30 * HZ) / 10;
 	else
 		WaitDelay = (DelayTime * HZ) / 10;
_
