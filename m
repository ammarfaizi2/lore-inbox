Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbRCGVS4>; Wed, 7 Mar 2001 16:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRCGVSt>; Wed, 7 Mar 2001 16:18:49 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9613 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131200AbRCGVS2>;
	Wed, 7 Mar 2001 16:18:28 -0500
Message-ID: <3AA6A570.57FF2D36@mandrakesoft.com>
Date: Wed, 07 Mar 2001 16:17:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
        "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com
Subject: [PATCH] RFC: fix ethernet device initialization
Content-Type: multipart/mixed;
 boundary="------------83E4F9CA0D3D41503ACE4163"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83E4F9CA0D3D41503ACE4163
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

People from time to time point out a wart in ethernet initialization:

The net_device is allocated and registered to the system in
init_etherdev, which is usually one of the first things an ethernet
driver probe function does.  The net_device's final members are setup at
some time between then and the exit of the probe function.  There is
never a clear point where the net device is available to the system for
use.

Our API already supports a solution -- setup the device, then call
register_netdev.  The patch below adds a helper, alloc_etherdev, to
eliminate duplicate code in drivers.  Ethernet device initialization,
after the patch, should now look like

	dev = alloc_etherdev(sizeof(struct netdev_private));
	... initialize device ...
	... set up net_device struct members ...
	rc = register_netdevice(dev);
	if (rc) /* handle error */
	netif_start_queue(dev);

This makes the ethernet driver look and behave similar to other APIs in
the kernel, and presents a nice and atomic
present-this-netdev-to-the-system operation.

It should be noted that there is a net_device::init function.  IIRC in
the last discussion of this issue, ::init() was mentioned as a possible
solution.  I agree that init() can be used, but I do not like the idea
of using init as a probe function, as the ISA drivers do it.  This means
the ethernet device has the potential of holdling rtnl_lock for a long
time, and staying in the probe function, inside register_netdevice, for
a long time.  And...  I agree that init() can be used as a constructor
for filling in dev->xxx and dev->priv->xxx values, but I think doing so
is pointless: you must fill in certain values before your "constructor"
is called, just so your constructor has enough information to operate.

Patch description:

* Add alloc_etherdev, alloc_trdev, alloc_hippi_dev, alloc_fcdev, ...
* Use declarator macros to create init_etherdev, init_trdev, etc., and
remove duplicate code.
* Move net_init EXPORT_SYMBOL from net/netsyms.c to net_init.c.
* Convert drivers/net/8139too.c to use alloc_etherdev, as an example.

Final word, mostly PCI drivers need this change.  ISA drivers use the
net_device::init constructor approach.  IMHO they shouldn't stay in
register_netdevice so long, but that is a wart.  This patch fixes a bug,
the huge span of time between init_etherdev and the indeterminant point
in the future when the net device is ready for use.

Comments?

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------83E4F9CA0D3D41503ACE4163
Content-Type: text/plain; charset=us-ascii;
 name="alloc-netdev-2.4.3.3.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alloc-netdev-2.4.3.3.patch.txt"

Index: drivers/net/8139too.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/8139too.c,v
retrieving revision 1.1.1.29
diff -u -r1.1.1.29 8139too.c
--- drivers/net/8139too.c	2001/03/05 23:46:05	1.1.1.29
+++ drivers/net/8139too.c	2001/03/07 20:58:24
@@ -647,11 +647,43 @@
 	  (RX_DMA_BURST << RxCfgDMAShift);
 
 
+static void __rtl8139_cleanup_dev (struct net_device *dev)
+{
+	struct rtl8139_private *tp;
+	struct pci_dev *pdev;
+
+	assert (dev != NULL);
+	assert (dev->priv != NULL);
+
+	tp = dev->priv;
+	assert (tp->pci_dev != NULL);
+	pdev = tp->pci_dev;
+
+#ifndef USE_IO_OPS
+	if (tp->mmio_addr)
+		iounmap (tp->mmio_addr);
+#endif /* !USE_IO_OPS */
+
+	/* it's ok to call this even if we have no regions to free */
+	pci_release_regions (pdev);
+
+#ifndef RTL8139_NDEBUG
+	/* poison memory before freeing */
+	memset (dev, 0xBC,
+		sizeof (struct net_device) +
+		sizeof (struct rtl8139_private));
+#endif /* RTL8139_NDEBUG */
+
+	kfree (dev);
+
+	pci_set_drvdata (pdev, NULL);
+}
+
+
 static int __devinit rtl8139_init_board (struct pci_dev *pdev,
-					 struct net_device **dev_out,
-					 void **ioaddr_out)
+					 struct net_device **dev_out)
 {
-	void *ioaddr = NULL;
+	void *ioaddr;
 	struct net_device *dev;
 	struct rtl8139_private *tp;
 	u8 tmp8;
@@ -663,20 +695,19 @@
 	DPRINTK ("ENTER\n");
 
 	assert (pdev != NULL);
-	assert (ioaddr_out != NULL);
 
-	*ioaddr_out = NULL;
 	*dev_out = NULL;
 
-	/* dev zeroed in init_etherdev */
-	dev = init_etherdev (NULL, sizeof (*tp));
+	/* dev and dev->priv zeroed in alloc_etherdev */
+	dev = alloc_etherdev (sizeof (*tp));
 	if (dev == NULL) {
-		printk (KERN_ERR PFX "unable to alloc new ethernet\n");
+		printk (KERN_ERR PFX "Unable to alloc new net device\n");
 		DPRINTK ("EXIT, returning -ENOMEM\n");
 		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);
 	tp = dev->priv;
+	tp->pci_dev = pdev;
 
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pci_enable_device (pdev);
@@ -722,7 +753,7 @@
 		goto err_out;
 	}
 
-	rc = pci_request_regions (pdev, dev->name);
+	rc = pci_request_regions (pdev, "8139too");
 	if (rc)
 		goto err_out;
 
@@ -731,14 +762,17 @@
 
 #ifdef USE_IO_OPS
 	ioaddr = (void *) pio_start;
+	dev->base_addr = pio_start;
 #else
 	/* ioremap MMIO region */
 	ioaddr = ioremap (mmio_start, mmio_len);
 	if (ioaddr == NULL) {
 		printk (KERN_ERR PFX "cannot remap MMIO, aborting\n");
 		rc = -EIO;
-		goto err_out_free_res;
+		goto err_out;
 	}
+	dev->base_addr = (long) ioaddr;
+	tp->mmio_addr = ioaddr;
 #endif /* USE_IO_OPS */
 
 	/* Soft reset the chip. */
@@ -766,12 +800,12 @@
 	if ((tmp8 & Cfg1_PIO) == 0) {
 		printk (KERN_ERR PFX "PIO not enabled, Cfg1=%02X, aborting\n", tmp8);
 		rc = -EIO;
-		goto err_out_iounmap;
+		goto err_out;
 	}
 	if ((tmp8 & Cfg1_MMIO) == 0) {
 		printk (KERN_ERR PFX "MMIO not enabled, Cfg1=%02X, aborting\n", tmp8);
 		rc = -EIO;
-		goto err_out_iounmap;
+		goto err_out;
 	}
 
 	/* identify chip attached to board */
@@ -795,20 +829,11 @@
 		rtl_chip_info[tp->chipset].name);
 
 	DPRINTK ("EXIT, returning 0\n");
-	*ioaddr_out = ioaddr;
 	*dev_out = dev;
 	return 0;
 
-err_out_iounmap:
-	assert (ioaddr > 0);
-#ifndef USE_IO_OPS
-	iounmap (ioaddr);
-err_out_free_res:
-#endif /* !USE_IO_OPS */
-	pci_release_regions (pdev);
 err_out:
-	unregister_netdev (dev);
-	kfree (dev);
+	__rtl8139_cleanup_dev (dev);
 	DPRINTK ("EXIT, returning %d\n", rc);
 	return rc;
 }
@@ -820,7 +845,7 @@
 	struct net_device *dev = NULL;
 	struct rtl8139_private *tp;
 	int i, addr_len, option;
-	void *ioaddr = NULL;
+	void *ioaddr;
 	static int board_idx = -1;
 	static int printed_version;
 	u8 tmp;
@@ -837,13 +862,14 @@
 		printed_version = 1;
 	}
 
-	i = rtl8139_init_board (pdev, &dev, &ioaddr);
+	i = rtl8139_init_board (pdev, &dev);
 	if (i < 0) {
 		DPRINTK ("EXIT, returning %d\n", i);
 		return i;
 	}
 
 	tp = dev->priv;
+	ioaddr = tp->mmio_addr;
 
 	assert (ioaddr != NULL);
 	assert (dev != NULL);
@@ -865,20 +891,22 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	dev->irq = pdev->irq;
-	dev->base_addr = (unsigned long) ioaddr;
 
 	/* dev->priv/tp zeroed and aligned in init_etherdev */
 	tp = dev->priv;
 
 	/* note: tp->chipset set in rtl8139_init_board */
 	tp->drv_flags = board_info[ent->driver_data].hw_flags;
-	tp->pci_dev = pdev;
 	tp->mmio_addr = ioaddr;
 	spin_lock_init (&tp->lock);
 	init_waitqueue_head (&tp->thr_wait);
 	init_MUTEX_LOCKED (&tp->thr_exited);
+
+	/* dev is fully set up and ready to use now */
+	i = register_netdev (dev);
+	if (i) goto err_out;
 
-	pci_set_drvdata(pdev, dev);
+	pci_set_drvdata (pdev, dev);
 
 	printk (KERN_INFO "%s: %s at 0x%lx, "
 		"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, "
@@ -954,6 +982,10 @@
 
 	DPRINTK ("EXIT - returning 0\n");
 	return 0;
+
+err_out:
+	__rtl8139_cleanup_dev (dev);
+	return i;
 }
 
 
@@ -965,28 +997,12 @@
 	DPRINTK ("ENTER\n");
 
 	assert (dev != NULL);
-
-	np = (struct rtl8139_private *) (dev->priv);
+	np = dev->priv;
 	assert (np != NULL);
 
 	unregister_netdev (dev);
 
-#ifndef USE_IO_OPS
-	iounmap (np->mmio_addr);
-#endif /* !USE_IO_OPS */
-
-	pci_release_regions (pdev);
-
-#ifndef RTL8139_NDEBUG
-	/* poison memory before freeing */
-	memset (dev, 0xBC,
-		sizeof (struct net_device) +
-		sizeof (struct rtl8139_private));
-#endif /* RTL8139_NDEBUG */
-
-	kfree (dev);
-
-	pci_set_drvdata (pdev, NULL);
+	__rtl8139_cleanup_dev (dev);
 
 	DPRINTK ("EXIT\n");
 }
Index: drivers/net/Makefile
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/Makefile,v
retrieving revision 1.1.1.25.2.1
diff -u -r1.1.1.25.2.1 Makefile
--- drivers/net/Makefile	2001/03/07 09:28:01	1.1.1.25.2.1
+++ drivers/net/Makefile	2001/03/07 20:58:24
@@ -15,8 +15,9 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o ppp_async.o \
-			ppp_generic.o slhc.o pppox.o auto_irq.o
+export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o \
+			ppp_async.o ppp_generic.o slhc.o pppox.o auto_irq.o \
+			net_init.o
 
 ifeq ($(CONFIG_TULIP),y)
   obj-y += tulip/tulip.o
Index: drivers/net/net_init.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/net_init.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 net_init.c
--- drivers/net/net_init.c	2001/02/27 03:03:50	1.1.1.8
+++ drivers/net/net_init.c	2001/03/07 20:58:25
@@ -28,10 +28,14 @@
 			up. We now share common code and have regularised name
 			allocation setups. Abolished the 16 card limits.
 	03/19/2000 - jgarzik and Urban Widmark: init_etherdev 32-byte align
+	Mar 7, 2001 - jgarzik: Add alloc_<foo>dev for various protocols.
+		      Coalesce duplicate functions into macro calls to
+		      DECLARE_*DEV macros.
 
 */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>
@@ -50,6 +54,7 @@
 #include <linux/rtnetlink.h>
 #include <net/neighbour.h>
 
+
 /* The network devices currently exist only in the socket namespace, so these
    entries are unused.  The only ones that make sense are
     open	start the ethercard
@@ -67,6 +72,69 @@
 	and a space waste]
 */
 
+#define DECLARE_INIT_DEV(suffix,mask,setup) \
+	struct net_device *init_##suffix(struct net_device *dev, int sizeof_priv) \
+	{ return init_netdev(dev, sizeof_priv, mask, setup); }	\
+	EXPORT_SYMBOL(init_##suffix)
+
+#define DECLARE_ALLOC_DEV(suffix,mask,setup) \
+	struct net_device *alloc_##suffix(unsigned int sizeof_priv)	\
+	{								\
+		struct net_device * dev;				\
+		dev = alloc_netdev(sizeof_priv, setup);			\
+		if (dev)						\
+			strcpy(dev->name, mask);			\
+		return dev;						\
+	}								\
+	EXPORT_SYMBOL(alloc_##suffix)
+
+#define DECLARE_REG_DEV(suffix)	\
+	int register_##suffix(struct net_device *dev)			\
+	{								\
+	        dev_init_buffers(dev);					\
+	        if (dev->init && dev->init(dev) != 0) {			\
+	                unregister_##suffix(dev);			\
+	                return -EIO;					\
+	        }							\
+	        return 0;						\
+	}								\
+	EXPORT_SYMBOL(register_##suffix)
+
+#define DECLARE_UNREG_DEV(suffix) \
+	void unregister_##suffix(struct net_device *dev)		\
+	{ unregister_netdev(dev); }					\
+	EXPORT_SYMBOL(unregister_##suffix)
+
+#define DECLARE_CHG_MTU(suffix,low,high) \
+	static int suffix##_change_mtu(struct net_device *dev, int new_mtu) \
+	{								\
+		if ((new_mtu < low) || (new_mtu > high))		\
+			return -EINVAL;					\
+		dev->mtu = new_mtu;					\
+		return 0;						\
+	}
+
+
+
+static struct net_device *alloc_netdev(unsigned int sizeof_priv,
+				       void (*setup)(struct net_device *))
+{
+	struct net_device *dev;
+	int alloc_size;
+
+	/* ensure 32-byte alignment of the private area */
+	alloc_size = sizeof (*dev) + sizeof_priv + 31;
+
+	dev = kmalloc (sizeof (*dev) + sizeof_priv, GFP_KERNEL);
+	if (!dev)
+		return NULL;
+	memset (dev, 0, sizeof (*dev) + sizeof_priv);
+	if (sizeof_priv)
+		dev->priv = (void *) (((long)(dev + 1) + 31) & ~31);
+	setup (dev);
+	return dev;
+}
+
 
 static struct net_device *init_alloc_dev(int sizeof_priv)
 {
@@ -153,18 +221,16 @@
  *
  * If no device structure is passed, a new one is constructed, complete with
  * a private data area of size @sizeof_priv.  A 32-byte (not bit)
- * alignment is enforced for this private data area.
+ * alignment is guaranteed for this private data area.
  *
  * If an empty string area is passed as dev->name, or a new structure is made,
  * a new name string is constructed.
  */
 
-struct net_device *init_etherdev(struct net_device *dev, int sizeof_priv)
-{
-	return init_netdev(dev, sizeof_priv, "eth%d", ether_setup);
-}
+DECLARE_INIT_DEV(etherdev, "eth%d", ether_setup);
+DECLARE_ALLOC_DEV(etherdev, "eth%d", ether_setup);
+DECLARE_CHG_MTU(eth, 68, 1500);
 
-
 static int eth_mac_addr(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr=p;
@@ -174,45 +240,14 @@
 	return 0;
 }
 
-static int eth_change_mtu(struct net_device *dev, int new_mtu)
-{
-	if ((new_mtu < 68) || (new_mtu > 1500))
-		return -EINVAL;
-	dev->mtu = new_mtu;
-	return 0;
-}
-
 #ifdef CONFIG_FDDI
-
-struct net_device *init_fddidev(struct net_device *dev, int sizeof_priv)
-{
-	return init_netdev(dev, sizeof_priv, "fddi%d", fddi_setup);
-}
-
-static int fddi_change_mtu(struct net_device *dev, int new_mtu)
-{
-	if ((new_mtu < FDDI_K_SNAP_HLEN) || (new_mtu > FDDI_K_SNAP_DLEN))
-		return(-EINVAL);
-	dev->mtu = new_mtu;
-	return(0);
-}
-
+DECLARE_INIT_DEV(fddidev, "fddi%d", fddi_setup);
+DECLARE_ALLOC_DEV(fddidev, "fddi%d", fddi_setup);
+DECLARE_CHG_MTU(fddi, FDDI_K_SNAP_HLEN, FDDI_K_SNAP_DLEN);
 #endif /* CONFIG_FDDI */
 
 #ifdef CONFIG_HIPPI
 
-static int hippi_change_mtu(struct net_device *dev, int new_mtu)
-{
-	/*
-	 * HIPPI's got these nice large MTUs.
-	 */
-	if ((new_mtu < 68) || (new_mtu > 65280))
-		return -EINVAL;
-	dev->mtu = new_mtu;
-	return(0);
-}
-
-
 /*
  * For HIPPI we will actually use the lower 4 bytes of the hardware
  * address as the I-FIELD rather than the actual hardware address.
@@ -225,21 +260,11 @@
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
 	return 0;
 }
-
-
-struct net_device *init_hippi_dev(struct net_device *dev, int sizeof_priv)
-{
-	return init_netdev(dev, sizeof_priv, "hip%d", hippi_setup);
-}
-
-
-void unregister_hipdev(struct net_device *dev)
-{
-	rtnl_lock();
-	unregister_netdevice(dev);
-	rtnl_unlock();
-}
 
+DECLARE_INIT_DEV(hippi_dev, "hip%d", hippi_setup);
+DECLARE_ALLOC_DEV(hippi_dev, "hip%d", hippi_setup);
+DECLARE_UNREG_DEV(hipdev); /* "hipdev" is not a typo -jgarzik */
+DECLARE_CHG_MTU(hippi, 68, 65280);
 
 static int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p)
 {
@@ -283,9 +308,9 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(ether_setup);
 
 #ifdef CONFIG_FDDI
-
 void fddi_setup(struct net_device *dev)
 {
 	/*
@@ -312,13 +337,13 @@
 	
 	return;
 }
-
+EXPORT_SYMBOL(fddi_setup);
 #endif /* CONFIG_FDDI */
 
 #ifdef CONFIG_HIPPI
 void hippi_setup(struct net_device *dev)
 {
-	dev->set_multicast_list	= NULL;
+	dev->set_multicast_list		= NULL;
 	dev->change_mtu			= hippi_change_mtu;
 	dev->hard_header		= hippi_header;
 	dev->rebuild_header 		= hippi_rebuild_header;
@@ -349,8 +374,10 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(hippi_setup);
 #endif /* CONFIG_HIPPI */
 
+
 #if defined(CONFIG_ATALK) || defined(CONFIG_ATALK_MODULE)
 
 static int ltalk_change_mtu(struct net_device *dev, int mtu)
@@ -363,7 +390,6 @@
 	return -EINVAL;
 }
 
-
 void ltalk_setup(struct net_device *dev)
 {
 	/* Fill in the fields of the device structure with localtalk-generic values. */
@@ -387,9 +413,11 @@
 
 	dev_init_buffers(dev);
 }
+EXPORT_SYMBOL(ltalk_setup);
 
 #endif /* CONFIG_ATALK || CONFIG_ATALK_MODULE */
 
+
 int register_netdev(struct net_device *dev)
 {
 	int err;
@@ -438,7 +466,10 @@
 	rtnl_unlock();
 }
 
+EXPORT_SYMBOL(register_netdev);
+EXPORT_SYMBOL(unregister_netdev);
 
+
 #ifdef CONFIG_TR
 
 static void tr_configure(struct net_device *dev)
@@ -462,32 +493,17 @@
 	dev->flags		= IFF_BROADCAST | IFF_MULTICAST ;
 }
 
-struct net_device *init_trdev(struct net_device *dev, int sizeof_priv)
-{
-	return init_netdev(dev, sizeof_priv, "tr%d", tr_configure);
-}
+DECLARE_INIT_DEV(trdev, "tr%d", tr_configure);
+DECLARE_ALLOC_DEV(trdev, "tr%d", tr_configure);
+DECLARE_REG_DEV(trdev);
+DECLARE_UNREG_DEV(trdev);
 
 void tr_setup(struct net_device *dev)
 {
+	tr_configure(dev);
 }
+EXPORT_SYMBOL(tr_setup);
 
-int register_trdev(struct net_device *dev)
-{
-	dev_init_buffers(dev);
-	
-	if (dev->init && dev->init(dev) != 0) {
-		unregister_trdev(dev);
-		return -EIO;
-	}
-	return 0;
-}
-
-void unregister_trdev(struct net_device *dev)
-{
-	rtnl_lock();
-	unregister_netdevice(dev);
-	rtnl_unlock();
-}
 #endif /* CONFIG_TR */
 
 
@@ -511,29 +527,11 @@
 	dev_init_buffers(dev);
         return;
 }
+EXPORT_SYMBOL(fc_setup);
 
+DECLARE_INIT_DEV(fcdev, "fc%d", fc_setup);
+DECLARE_ALLOC_DEV(fcdev, "fc%d", fc_setup);
+DECLARE_REG_DEV(fcdev);
+DECLARE_UNREG_DEV(fcdev);
 
-struct net_device *init_fcdev(struct net_device *dev, int sizeof_priv)
-{
-	return init_netdev(dev, sizeof_priv, "fc%d", fc_setup);
-}
-
-int register_fcdev(struct net_device *dev)
-{
-        dev_init_buffers(dev);
-        if (dev->init && dev->init(dev) != 0) {
-                unregister_fcdev(dev);
-                return -EIO;
-        }
-        return 0;
-}                                               
-        
-void unregister_fcdev(struct net_device *dev)
-{
-        rtnl_lock();
-	unregister_netdevice(dev);
-        rtnl_unlock();
-}
-
 #endif /* CONFIG_NET_FC */
-
Index: include/linux/etherdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 etherdevice.h
--- include/linux/etherdevice.h	2001/03/07 08:25:42	1.1.1.10
+++ include/linux/etherdevice.h	2001/03/07 20:58:26
@@ -39,6 +39,7 @@
 extern int		eth_header_parse(struct sk_buff *skb,
 					 unsigned char *haddr);
 extern struct net_device	* init_etherdev(struct net_device *, int);
+extern struct net_device	* alloc_etherdev(unsigned int);
 
 static __inline__ void eth_copy_and_sum (struct sk_buff *dest, unsigned char *src, int len, int base)
 {
Index: include/linux/fcdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/fcdevice.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fcdevice.h
--- include/linux/fcdevice.h	2000/10/22 19:36:14	1.1.1.1
+++ include/linux/fcdevice.h	2001/03/07 20:58:26
@@ -34,6 +34,7 @@
 //extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
 
 extern struct net_device    * init_fcdev(struct net_device *, int);
+extern struct net_device    * alloc_fcdev(unsigned int);
 
 #endif
 
Index: include/linux/fddidevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/fddidevice.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 fddidevice.h
--- include/linux/fddidevice.h	2000/10/22 20:44:24	1.1.1.2
+++ include/linux/fddidevice.h	2001/03/07 20:58:26
@@ -35,6 +35,7 @@
 extern unsigned short	fddi_type_trans(struct sk_buff *skb,
 				struct net_device *dev);
 extern struct net_device        * init_fddidev(struct net_device *, int);
+extern struct net_device        * alloc_fddidev(unsigned int);
 #endif
 
 #endif	/* _LINUX_FDDIDEVICE_H */
Index: include/linux/hippidevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/hippidevice.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 hippidevice.h
--- include/linux/hippidevice.h	2000/10/22 19:36:13	1.1.1.1
+++ include/linux/hippidevice.h	2001/03/07 20:58:26
@@ -52,6 +52,7 @@
 void hippi_setup(struct net_device *dev);
 
 extern struct net_device *init_hippi_dev(struct net_device *, int);
+extern struct net_device *alloc_hippi_dev(unsigned int);
 extern void unregister_hipdev(struct net_device *dev);
 #endif
 
Index: include/linux/trdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/trdevice.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 trdevice.h
--- include/linux/trdevice.h	2000/10/22 19:36:03	1.1.1.1
+++ include/linux/trdevice.h	2001/03/07 20:58:26
@@ -34,6 +34,7 @@
 extern int		tr_rebuild_header(struct sk_buff *skb);
 extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern struct net_device    * init_trdev(struct net_device *, int);
+extern struct net_device    * alloc_trdev(unsigned int);
 
 #endif
 
Index: net/netsyms.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/net/netsyms.c,v
retrieving revision 1.1.1.19
diff -u -r1.1.1.19 netsyms.c
--- net/netsyms.c	2001/03/07 08:27:32	1.1.1.19
+++ net/netsyms.c	2001/03/07 20:58:26
@@ -432,33 +432,19 @@
 #endif  /* CONFIG_INET */
 
 #ifdef CONFIG_TR
-EXPORT_SYMBOL(tr_setup);
 EXPORT_SYMBOL(tr_type_trans);
-EXPORT_SYMBOL(register_trdev);
-EXPORT_SYMBOL(unregister_trdev);
-EXPORT_SYMBOL(init_trdev);
 #endif
 
-#ifdef CONFIG_NET_FC
-EXPORT_SYMBOL(register_fcdev);
-EXPORT_SYMBOL(unregister_fcdev);
-EXPORT_SYMBOL(init_fcdev);
-#endif
-
 /* Device callback registration */
 EXPORT_SYMBOL(register_netdevice_notifier);
 EXPORT_SYMBOL(unregister_netdevice_notifier);
 
 /* support for loadable net drivers */
 #ifdef CONFIG_NET
-EXPORT_SYMBOL(init_etherdev);
 EXPORT_SYMBOL(loopback_dev);
 EXPORT_SYMBOL(register_netdevice);
 EXPORT_SYMBOL(unregister_netdevice);
-EXPORT_SYMBOL(register_netdev);
-EXPORT_SYMBOL(unregister_netdev);
 EXPORT_SYMBOL(netdev_state_change);
-EXPORT_SYMBOL(ether_setup);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_index);
 EXPORT_SYMBOL(__dev_get_by_index);
@@ -469,8 +455,6 @@
 EXPORT_SYMBOL(eth_type_trans);
 #ifdef CONFIG_FDDI
 EXPORT_SYMBOL(fddi_type_trans);
-EXPORT_SYMBOL(fddi_setup);
-EXPORT_SYMBOL(init_fddidev);
 #endif /* CONFIG_FDDI */
 #if 0
 EXPORT_SYMBOL(eth_copy_and_sum);
@@ -511,8 +495,6 @@
 
 #ifdef CONFIG_HIPPI
 EXPORT_SYMBOL(hippi_type_trans);
-EXPORT_SYMBOL(init_hippi_dev);
-EXPORT_SYMBOL(unregister_hipdev);
 #endif
 
 #ifdef CONFIG_SYSCTL
@@ -522,12 +504,6 @@
 EXPORT_SYMBOL(sysctl_ip_default_ttl);
 #endif
 #endif
-
-#if defined(CONFIG_ATALK) || defined(CONFIG_ATALK_MODULE) 
-#include<linux/if_ltalk.h>
-EXPORT_SYMBOL(ltalk_setup);
-#endif
-
 
 /* Packet scheduler modules want these. */
 EXPORT_SYMBOL(qdisc_destroy);

--------------83E4F9CA0D3D41503ACE4163--

