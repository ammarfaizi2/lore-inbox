Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQLWNY3>; Sat, 23 Dec 2000 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbQLWNYT>; Sat, 23 Dec 2000 08:24:19 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:960 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129930AbQLWNYM>; Sat, 23 Dec 2000 08:24:12 -0500
Message-ID: <3A44A170.4D864E7F@uow.edu.au>
Date: Sat, 23 Dec 2000 23:58:24 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        stefani@lkg.dec.com, lkml <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: [patch] remove init_fddidev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was pretty simple.  Also did the SET_MODULE_OWNER thing.

It affects two files:

drivers/net/defxx.c
drivers/net/ptifddi.c

I'm not sure what the story is with ptifddi.c.  It isn't
mentioned in any of the kernel Makefiles?

Now just 67 ethernet drivers to do :)


--- linux-2.4.0-test13pre4-ac2/drivers/net/defxx.c	Sat Sep  9 16:19:26 2000
+++ linux-akpm/drivers/net/defxx.c	Sat Dec 23 23:48:35 2000
@@ -423,15 +423,17 @@
 	}
 
 	/*
-	 * init_fddidev() allocates a device structure with private data, clears the device structure and private data,
-	 * and  calls fddi_setup() and register_netdev(). Not much left to do for us here.
+	 * prepare_fddidev() allocates a device structure with private data, clears the device
+	 * structure and private data and then calls fddi_setup().  Once the device is ready
+	 * to be opened we call publish_netdev() to advertise its availability.
 	 */
-	dev = init_fddidev( NULL, sizeof(*bp));
+	dev = prepare_fddidev(NULL, sizeof(*bp));
 
 	if (!dev) {
 		printk (KERN_ERR "defxx: unable to allocate fddidev, aborting\n");
 		return -ENOMEM;
 	}
+	SET_MODULE_OWNER(dev);
 
 	bp = (DFX_board_t*)dev->priv;
 
@@ -470,12 +472,13 @@
 	if (dfx_driver_init(dev) != DFX_K_SUCCESS)
 		goto err_out_region;
 
+	publish_netdev(dev);
 	return 0;
 
 err_out_region:
 	release_region(ioaddr, pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN);
 err_out:
-	unregister_netdev(dev);
+	withdraw_netdev(dev);
 	kfree(dev);
 	return -ENODEV;
 }
@@ -1187,14 +1190,11 @@
 
 	DBG_printk("In dfx_open...\n");
 	
-	MOD_INC_USE_COUNT;
-
 	/* Register IRQ - support shared interrupts by passing device ptr */
 
 	if (request_irq(dev->irq, (void *)dfx_interrupt, SA_SHIRQ, dev->name, dev))
 	{
 		printk(KERN_ERR "%s: Requested IRQ %d is busy\n", dev->name, dev->irq);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 
@@ -1232,7 +1232,6 @@
 	{
 		printk(KERN_ERR "%s: Adapter open failed!\n", dev->name);
 		free_irq(dev->irq, dev);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 
@@ -1326,7 +1325,6 @@
 
 	free_irq(dev->irq, dev);
 	
-	MOD_DEC_USE_COUNT;
 	return(0);
 }
 
--- linux-2.4.0-test13pre4-ac2/drivers/net/ptifddi.c	Sat Jul 15 19:36:08 2000
+++ linux-akpm/drivers/net/ptifddi.c	Sat Dec 23 23:49:09 2000
@@ -154,18 +154,23 @@
 	static unsigned version_printed = 0;
 	struct ptifddi *pp;
 	int i;
-
-	dev = init_fddidev(0, sizeof(struct ptifddi));
+	int retval;
 
 	if(version_printed++ == 0)
 		printk(version);
 
+	dev = prepare_fddidev(0, sizeof(struct ptifddi));
+	if (dev == NULL)
+		return -ENOMEM;
+	SET_MODULE_OWNER(dev);
+
 	/* Register 0 mapping contains DPRAM. */
 	pp->dpram = (struct dfddi_ram *) sbus_ioremap(
 	    &sdep->resource[0], 0, sizeof(sturct dfddi_ram), "PTI FDDI DPRAM");
 	if(!pp->dpram) {
 		printk("ptiFDDI: Cannot map DPRAM I/O area.\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_out;
 	}
 
 	/* Next, register 1 contains reset byte. */
@@ -173,7 +178,8 @@
 	    &sdep->resource[1], 0, 1, "PTI FDDI RESET Byte");
 	if(!pp->reset) {
 		printk("ptiFDDI: Cannot map RESET byte.\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_out;
 	}
 
 	/* Register 2 contains unreset byte. */
@@ -181,7 +187,8 @@
 	    &sdep->resource[2], 0, 1, "PTI FDDI UNRESET Byte");
 	if(!pp->unreset) {
 		printk("ptiFDDI: Cannot map UNRESET byte.\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_out;
 	}
 
 	/* Reset the card. */
@@ -191,7 +198,8 @@
 	i = pti_card_test(pp);
 	if(i) {
 		printk("ptiFDDI: Bootup card test fails.\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_out;
 	}
 
 	/* Clear DPRAM, start afresh. */
@@ -202,6 +210,12 @@
 
 	/* Now load main card FDDI firmware, using the loader. */
 	pti_load_main_firmware(pp);
+	publish_netdev(dev);
+	return 0;
+err_out:
+	withdraw_netdev(dev);
+	kfree(dev);
+	return retval;
 }
 
 int __init ptifddi_sbus_probe(struct net_device *dev)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
