Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbREUQ77>; Mon, 21 May 2001 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbREUQ7t>; Mon, 21 May 2001 12:59:49 -0400
Received: from ns.caldera.de ([212.34.180.1]:36253 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261574AbREUQ7d>;
	Mon, 21 May 2001 12:59:33 -0400
Date: Mon, 21 May 2001 18:58:46 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: toshoboe 2.4 PCI api
Message-ID: <20010521185846.A21960@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cleaned up the Toshoboe IrDA driver:
- Ported to Linux 2.4 PCI API. Including PowerManagement this time.
- got rid of static dev array, using pci device data
- some misc cleanups.

Tested that IrDA still works on Toshiba Satellite 4080XCDT with irdadump
and a Siemens S25.

Ciao, Marcus

Index: drivers/net/irda/toshoboe.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/net/irda/toshoboe.c,v
retrieving revision 1.18
diff -u -r1.18 toshoboe.c
--- drivers/net/irda/toshoboe.c	2001/05/03 13:16:09	1.18
+++ drivers/net/irda/toshoboe.c	2001/05/21 16:14:13
@@ -43,9 +43,6 @@
 /* Define this to enable FIR and MIR support */
 #define ENABLE_FAST
 
-/* Number of ports this driver can support, you also need to edit dev_self below */
-#define NSELFS 4
-
 /* Size of IO window */
 #define CHIP_IO_EXTENT	0x1f
 
@@ -77,7 +74,6 @@
 #include <net/irda/irda_device.h>
 
 #include <linux/pm.h>
-static int toshoboe_pmproc (struct pm_dev *dev, pm_request_t rqst, void *data);
 
 #include <net/irda/toshoboe.h>
 
@@ -92,8 +88,6 @@
 
 static const char *driver_name = "toshoboe";
 
-static struct toshoboe_cb *dev_self[NSELFS + 1];
-
 static int max_baud = 4000000;
 
 /* Shutdown the chip and point the taskfile reg somewhere else */
@@ -644,21 +638,20 @@
 	return ret;
 }
 
-#ifdef MODULE
-
 MODULE_DESCRIPTION("Toshiba OBOE IrDA Device Driver");
 MODULE_AUTHOR("James McKenzie <james@fishsoup.dhs.org>");
 MODULE_PARM (max_baud, "i");
 MODULE_PARM_DESC(max_baus, "Maximum baud rate");
 
-static int
-toshoboe_close (struct toshoboe_cb *self)
+static void
+toshoboe_remove (struct pci_dev *pci_dev)
 {
   int i;
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
 
   IRDA_DEBUG (4, __FUNCTION__ "()\n");
 
-  ASSERT (self != NULL, return -1;
+  ASSERT (self != NULL, return;
     );
 
   if (!self->stopped)
@@ -693,16 +686,12 @@
   self->taskfilebuf = NULL;
   self->taskfile = NULL;
 
-  return (0);
+  return;
 
 }
 
-#endif
-
-
-
 static int
-toshoboe_open (struct pci_dev *pci_dev)
+toshoboe_probe (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
 {
   struct toshoboe_cb *self;
   struct net_device *dev;
@@ -713,15 +702,6 @@
 
   IRDA_DEBUG (4, __FUNCTION__ "()\n");
 
-  while (dev_self[i])
-    i++;
-
-  if (i == NSELFS)
-    {
-      printk (KERN_ERR "Oboe: No more instances available");
-      return -ENOMEM;
-    }
-
   if ((err=pci_enable_device(pci_dev)))
 	  return err;
 
@@ -736,12 +716,10 @@
 
   memset (self, 0, sizeof (struct toshoboe_cb));
 
-  dev_self[i] = self;           /*This needs moving if we ever get more than one chip */
-
   self->open = 0;
   self->stopped = 0;
   self->pdev = pci_dev;
-  self->base = pci_dev->resource[0].start;
+  self->base = pci_resource_start(pci_dev,0);
 
   self->io.sir_base = self->base;
   self->io.irq = pci_dev->irq;
@@ -749,19 +727,15 @@
   self->io.speed = 9600;
 
   /* Lock the port that we need */
-  i = check_region (self->io.sir_base, self->io.sir_ext);
-  if (i < 0)
+  if (NULL==request_region (self->io.sir_base, self->io.sir_ext, driver_name))
     {
       IRDA_DEBUG (0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
              self->io.sir_base);
-
-      dev_self[i] = NULL;
-      kfree (self);
 
-      return -ENODEV;
+      err = -EBUSY;
+      goto freeself;
     }
 
-
   irda_init_max_qos_capabilies (&self->qos);
   self->qos.baud_rate.bits = 0;
 
@@ -804,8 +778,8 @@
   if (!self->taskfilebuf)
     {
       printk (KERN_ERR "toshoboe: kmalloc for DMA failed()\n");
-      kfree (self);
-      return -ENOMEM;
+      err = -ENOMEM;
+      goto freeregion;
     }
 
 
@@ -839,25 +813,16 @@
   if (ok != RX_SLOTS + TX_SLOTS)
     {
       printk (KERN_ERR "toshoboe: kmalloc for buffers failed()\n");
-
-
-      for (i = 0; i < TX_SLOTS; ++i)
-        if (self->xmit_bufs[i])
-          kfree (self->xmit_bufs[i]);
-      for (i = 0; i < RX_SLOTS; ++i)
-        if (self->recv_bufs[i])
-          kfree (self->recv_bufs[i]);
-
-      kfree (self);
-      return -ENOMEM;
+      err = -ENOMEM;
+      goto freebufs;
 
-    }
+  }
 
-  request_region (self->io.sir_base, self->io.sir_ext, driver_name);
 
   if (!(dev = dev_alloc("irda%d", &err))) {
-	  ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
-	  return -ENOMEM;
+      ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
+      err = -ENOMEM;
+      goto freebufs;
   }
   dev->priv = (void *) self;
   self->netdev = dev;
@@ -875,12 +840,15 @@
   rtnl_unlock();
   if (err) {
 	  ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
-	  return -1;
+	  /* XXX there is not freeing for dev? */
+          goto freebufs;
   }
+  pci_set_drvdata(pci_dev,self);
 
-  pmdev = pm_register (PM_PCI_DEV, PM_PCI_ID(pci_dev), toshoboe_pmproc);
+/*  pmdev = pm_register (PM_PCI_DEV, PM_PCI_ID(pci_dev), toshoboe_pmproc);
   if (pmdev)
 	  pmdev->data = self;
+	  */
 
   printk (KERN_WARNING "ToshOboe: Using ");
 #ifdef ONETASK
@@ -891,16 +859,30 @@
   printk (" tasks, version %s\n", rcsid);
 
   return (0);
+freebufs:
+      for (i = 0; i < TX_SLOTS; ++i)
+        if (self->xmit_bufs[i])
+          kfree (self->xmit_bufs[i]);
+      for (i = 0; i < RX_SLOTS; ++i)
+        if (self->recv_bufs[i])
+          kfree (self->recv_bufs[i]);
+      kfree(self->taskfilebuf);
+freeregion:
+      release_region (self->io.sir_base, self->io.sir_ext);
+freeself:
+      kfree (self);
+      return err;
 }
 
 static void 
-toshoboe_gotosleep (struct toshoboe_cb *self)
+toshoboe_suspend (struct pci_dev *pci_dev)
 {
   int i = 10;
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
 
   printk (KERN_WARNING "ToshOboe: suspending\n");
 
-  if (self->stopped)
+  if (!self || self->stopped)
     return;
 
   self->stopped = 1;
@@ -922,10 +904,14 @@
 
 
 static void 
-toshoboe_wakeup (struct toshoboe_cb *self)
+toshoboe_resume (struct pci_dev *pci_dev)
 {
+  struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
 
+  if (!self)
+    return;
+
   if (!self->stopped)
     return;
 
@@ -949,108 +935,28 @@
   netif_wake_queue(self->netdev);
   restore_flags (flags);
   printk (KERN_WARNING "ToshOboe: waking up\n");
-
 }
 
-static int 
-toshoboe_pmproc (struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-  struct toshoboe_cb *self = (struct toshoboe_cb *) dev->data;
-  if (self) {
-	  switch (rqst) {
-	  case PM_SUSPEND:
-		  toshoboe_gotosleep (self);
-		  break;
-	  case PM_RESUME:
-		  toshoboe_wakeup (self);
-		  break;
-	  }
-  }
-  return 0;
-}
-
-
-int __init toshoboe_init (void)
-{
-  struct pci_dev *pci_dev = NULL;
-  int found = 0;
-
-  do
-    {
-      pci_dev = pci_find_device (PCI_VENDOR_ID_TOSHIBA,
-                                 PCI_DEVICE_ID_FIR701, pci_dev);
-      if (pci_dev)
-        {
-          printk (KERN_WARNING "ToshOboe: Found 701 chip at 0x%0lx irq %d\n",
-		  pci_dev->resource[0].start,
-                  pci_dev->irq);
-
-          if (!toshoboe_open (pci_dev))
-	      found++;
-        }
-
-    }
-  while (pci_dev);
-
-  if (!found) do
-    {
-      pci_dev = pci_find_device (PCI_VENDOR_ID_TOSHIBA,
-                                 PCI_DEVICE_ID_FIR701b, pci_dev);
-      if (pci_dev)
-        {
-          printk (KERN_WARNING "ToshOboe: Found 701b chip at 0x%0lx irq %d\n",
-		  pci_dev->resource[0].start,
-                  pci_dev->irq);
-
-          if (!toshoboe_open (pci_dev))
-	      found++;
-        }
-
-    }
-  while (pci_dev);
-
-
-
-  if (found)
-    {
-      return 0;
-    }
-
-  return -ENODEV;
-}
-
-#ifdef MODULE
-
-static void
-toshoboe_cleanup (void)
-{
-  int i;
-
-  IRDA_DEBUG (4, __FUNCTION__ "()\n");
-
-  for (i = 0; i < 4; i++)
-    {
-      if (dev_self[i])
-        toshoboe_close (dev_self[i]);
-    }
-
-  pm_unregister_all (toshoboe_pmproc);
-}
-
-
+static struct pci_driver toshoboe_pci_driver = {
+  name		: "toshoboe",
+  id_table	: toshoboe_pci_tbl,
+  probe		: toshoboe_probe,
+  remove	: toshoboe_remove,
+  suspend	: toshoboe_suspend,
+  resume	: toshoboe_resume 
+};
 
-int
-init_module (void)
-{
-  return toshoboe_init ();
+int __init
+toshoboe_init (void) {
+  pci_module_init(&toshoboe_pci_driver);
+  return 0;
 }
 
-
 void
-cleanup_module (void)
+toshoboe_cleanup (void)
 {
-  toshoboe_cleanup ();
+  pci_unregister_driver(&toshoboe_pci_driver);
 }
 
-
-#endif
+module_init(toshoboe_init);
+module_exit(toshoboe_cleanup);
