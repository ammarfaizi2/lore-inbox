Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263013AbTC1Omn>; Fri, 28 Mar 2003 09:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263014AbTC1Omn>; Fri, 28 Mar 2003 09:42:43 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:14310 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263013AbTC1Omd>; Fri, 28 Mar 2003 09:42:33 -0500
Date: Fri, 28 Mar 2003 15:53:28 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: generic suspend/resume capability
Message-ID: <20030328145328.GA3330@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The socket drivers already offer suspend and resume
capability. Integrate this with the driver model, based on a
suggestion by Russell King.

Also, remove two never-used functions from the socket drivers (to_ns).

 drivers/pcmcia/cs.c             |   70 ++++++++++++++++++++--------------------
 drivers/pcmcia/cs_internal.h    |    1
 drivers/pcmcia/hd64465_ss.c     |    2 +
 drivers/pcmcia/i82092.c         |   17 ++++++---
 drivers/pcmcia/i82365.c         |    2 +
 drivers/pcmcia/pci_socket.c     |   15 +-------
 drivers/pcmcia/sa1100_generic.c |    2 +
 drivers/pcmcia/sa1111_generic.c |   14 +-------
 drivers/pcmcia/tcic.c           |    7 +---
 include/pcmcia/ss.h             |    5 ++
 10 files changed, 64 insertions(+), 71 deletions(-)


diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-03-28 15:42:20.000000000 +0100
@@ -111,13 +111,6 @@
 /* Access speed for IO windows */
 INT_MODULE_PARM(io_speed,	0);		/* ns */
 
-/* Optional features */
-#ifdef CONFIG_PM
-INT_MODULE_PARM(do_apm,		1);
-#else
-INT_MODULE_PARM(do_apm,		0);
-#endif
-
 #ifdef PCMCIA_DEBUG
 INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
 static const char *version =
@@ -348,7 +341,6 @@
 		/* base address = 0, map = 0 */
 		s->cis_mem.flags = 0;
 		s->cis_mem.speed = cis_speed;
-		s->use_bus_pm = cls_d->use_bus_pm;
 		s->erase_busy.next = s->erase_busy.prev = &s->erase_busy;
 		spin_lock_init(&s->lock);
     
@@ -756,33 +748,47 @@
 	parse_events(s, SS_DETECT);
 }
 
-static int handle_pm_event(struct pm_dev *dev, pm_request_t rqst, void *data)
+
+int pcmcia_socket_dev_suspend(struct device * dev, u32 state, u32 level)
 {
-    int i;
-    socket_info_t *s;
+	struct pcmcia_socket_class_data *cls_d = to_class_data(dev);
+	socket_info_t *s;
+	int i;
 
-    /* only for busses that don't suspend/resume slots directly */
+	if ((!cls_d) || (level != SUSPEND_SAVE_STATE))
+		return 0;
 
-    switch (rqst) {
-    case PM_SUSPEND:
-	DEBUG(1, "cs: received suspend notification\n");
-	for (i = 0; i < sockets; i++) {
-	    s = socket_table [i];
-	    if (!s->use_bus_pm)
-		pcmcia_suspend_socket (socket_table [i]);
+	s = (socket_info_t *) cls_d->s_info;
+
+	for (i = 0; i < cls_d->nsock; i++) {
+		pcmcia_suspend_socket(s);
+		s++;
 	}
-	break;
-    case PM_RESUME:
-	DEBUG(1, "cs: received resume notification\n");
-	for (i = 0; i < sockets; i++) {
-	    s = socket_table [i];
-	    if (!s->use_bus_pm)
-		pcmcia_resume_socket (socket_table [i]);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcmcia_socket_dev_suspend);
+
+int pcmcia_socket_dev_resume(struct device * dev, u32 level)
+{
+	struct pcmcia_socket_class_data *cls_d = to_class_data(dev);
+	socket_info_t *s;
+	int i;
+
+	if ((!cls_d) || (level != RESUME_RESTORE_STATE))
+		return 0;
+
+	s = (socket_info_t *) cls_d->s_info;
+
+	for (i = 0; i < cls_d->nsock; i++) {
+		pcmcia_resume_socket(s);
+		s++;
 	}
-	break;
-    }
-    return 0;
-} /* handle_pm_event */
+
+	return 0;
+}
+EXPORT_SYMBOL(pcmcia_socket_dev_resume);
+
 
 /*======================================================================
 
@@ -2429,8 +2435,6 @@
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
     devclass_register(&pcmcia_socket_class);
-    if (do_apm)
-	pm_register(PM_SYS_DEV, PM_SYS_PCMCIA, handle_pm_event);
 #ifdef CONFIG_PROC_FS
     proc_pccard = proc_mkdir("pccard", proc_bus);
 #endif
@@ -2446,8 +2450,6 @@
 	remove_proc_entry("pccard", proc_bus);
     }
 #endif
-    if (do_apm)
-	pm_unregister_all(handle_pm_event);
     release_resource_db();
     devclass_unregister(&pcmcia_socket_class);
 }
diff -ruN linux-original/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- linux-original/drivers/pcmcia/cs_internal.h	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/cs_internal.h	2003-03-28 15:41:32.000000000 +0100
@@ -157,7 +157,6 @@
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry	*proc;
 #endif
-    int				use_bus_pm;
 } socket_info_t;
 
 /* Flags in config state */
diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/hd64465_ss.c	2003-03-28 15:38:29.000000000 +0100
@@ -968,6 +968,8 @@
 	.name = "hd64465-pcmcia",
 	.bus = &platform_bus_type,
 	.devclass = &pcmcia_socket_class,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device hd64465_device = {
diff -ruN linux-original/drivers/pcmcia/i82092.c linux/drivers/pcmcia/i82092.c
--- linux-original/drivers/pcmcia/i82092.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/i82092.c	2003-03-28 15:44:18.000000000 +0100
@@ -42,11 +42,23 @@
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
+static int i82092aa_socket_suspend (struct pci_dev *dev, u32 state)
+{
+	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
+}
+
+static int i82092aa_socket_resume (struct pci_dev *dev)
+{
+	return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
+}
+
 static struct pci_driver i82092aa_pci_drv = {
 	.name           = "i82092aa",
 	.id_table       = i82092aa_pci_ids,
 	.probe          = i82092aa_pci_probe,
 	.remove         = __devexit_p(i82092aa_pci_remove),
+	.suspend        = i82092aa_socket_suspend,
+	.resume         = i82092aa_socket_resume,
 	.driver		= {
 		.devclass = &pcmcia_socket_class,
 	},
@@ -302,11 +314,6 @@
 		return 0;
 }
     
-static int to_ns(int cycles)
-{
-	return cycle_time*cycles;
-}
-
 
 /* Interrupt handler functionality */
 
diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-03-28 15:39:48.000000000 +0100
@@ -1511,6 +1511,8 @@
 	.name = "i82365",
 	.bus = &platform_bus_type,
 	.devclass = &pcmcia_socket_class,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device i82365_device = {
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-03-28 15:42:43.000000000 +0100
@@ -31,10 +31,6 @@
 #include "pci_socket.h"
 
 
-extern void pcmcia_suspend_socket (struct socket_info_t *socket);
-extern void pcmcia_resume_socket (struct socket_info_t *socket);
-
-
 /*
  * Arbitrary define. This is the array of active cardbus
  * entries.
@@ -157,7 +153,6 @@
 	socket->cls_d.nsock = 1; /* yenta is 1, no other low-level driver uses
 			     this yet */
 	socket->cls_d.ops = &pci_socket_operations;
-	socket->cls_d.use_bus_pm = 1;
 	dev->dev.class_data = &socket->cls_d;
 
 	/* prepare pci_socket_t */
@@ -204,18 +199,12 @@
 
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
 {
-	pci_socket_t *socket = pci_get_drvdata(dev);
-	if (socket && socket->cls_d.s_info)
-		pcmcia_suspend_socket (socket->cls_d.s_info);
-	return 0;
+	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
 }
 
 static int cardbus_resume (struct pci_dev *dev)
 {
-	pci_socket_t *socket = pci_get_drvdata(dev);
-	if (socket && socket->cls_d.s_info)
-		pcmcia_resume_socket (socket->cls_d.s_info);
-	return 0;
+	return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
 }
 
 
diff -ruN linux-original/drivers/pcmcia/sa1100_generic.c linux/drivers/pcmcia/sa1100_generic.c
--- linux-original/drivers/pcmcia/sa1100_generic.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/sa1100_generic.c	2003-03-28 15:38:09.000000000 +0100
@@ -1020,6 +1020,8 @@
 	.name		= "sa11x0-pcmcia",
 	.bus		= &platform_bus_type,
 	.devclass	= &pcmcia_socket_class,
+	.suspend 	= pcmcia_socket_dev_suspend,
+	.resume 	= pcmcia_socket_dev_resume,
 };
 
 static struct platform_device sa1100_pcmcia_device = {
diff -ruN linux-original/drivers/pcmcia/sa1111_generic.c linux/drivers/pcmcia/sa1111_generic.c
--- linux-original/drivers/pcmcia/sa1111_generic.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/sa1111_generic.c	2003-03-28 15:37:39.000000000 +0100
@@ -257,16 +257,6 @@
 	return 0;
 }
 
-static int pcmcia_suspend(struct device *dev, u32 state, u32 level)
-{
-	return 0;
-}
-
-static int pcmcia_resume(struct device *dev, u32 level)
-{
-	return 0;
-}
-
 static struct sa1111_driver pcmcia_driver = {
 	.drv = {
 		.name		= "sa1111-pcmcia",
@@ -274,8 +264,8 @@
 		.devclass	= &pcmcia_socket_class,
 		.probe		= pcmcia_probe,
 		.remove		= __devexit_p(pcmcia_remove),
-		.suspend	= pcmcia_suspend,
-		.resume		= pcmcia_resume,
+		.suspend 	= pcmcia_socket_dev_suspend,
+		.resume 	= pcmcia_socket_dev_resume,
 	},
 	.devid			= SA1111_DEVID_PCMCIA,
 };
diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-03-28 15:44:29.000000000 +0100
@@ -225,11 +225,6 @@
 	return 2*(ns-14)/cycle_time;
 }
 
-static int to_ns(int cycles)
-{
-    return (cycles*cycle_time)/2 + 14;
-}
-
 /*====================================================================*/
 
 static volatile u_int irq_hits;
@@ -384,6 +379,8 @@
 	.name = "tcic-pcmcia",
 	.bus = &platform_bus_type,
 	.devclass = &pcmcia_socket_class,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device tcic_device = {
diff -ruN linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-03-27 18:21:54.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-03-28 15:29:03.000000000 +0100
@@ -148,9 +148,12 @@
 	 * returned to driver) = sock_offset + (0, 1, .. , (nsock-1) */
 	struct pccard_operations *ops;		/* see above */
 	void *s_info;				/* socket_info_t */
-	unsigned int use_bus_pm;
 };
 
 extern struct device_class pcmcia_socket_class;
 
+/* socket drivers are expected to use these callbacks in their .drv struct */
+int pcmcia_socket_dev_suspend(struct device * dev, u32 state, u32 level);
+int pcmcia_socket_dev_resume(struct device * dev, u32 level);
+
 #endif /* _LINUX_SS_H */
