Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbTBOQlp>; Sat, 15 Feb 2003 11:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbTBOQlp>; Sat, 15 Feb 2003 11:41:45 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:62425 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263313AbTBOQlj>; Sat, 15 Feb 2003 11:41:39 -0500
Date: Sat, 15 Feb 2003 17:49:34 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, dahinds@users.sourceforge.net, davej@suse.de,
       alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, pcmcia-cs-devel@lists.sourceforge.net
Subject: [UPDATED PATCH 2.5.61] pcmcia: add device_class pcmcia_socket, update devices & drivers
Message-ID: <20030215164934.GA7204@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new device_class "pcmcia_socket_class" is introduced for PCMCIA and
CardBus sockets. All socket drivers I could find are updated so that they
register a driver, and -if necessary- the "platform"/legacy device. This
will allow for a cleanup of pcmcia_{un}register_socket() / 
{un}register_ss_entry() as well as reflect the parent for pcmcia_bus 
devices. Russell King allowed me to break sa1100_generic pcmcia support for
the time being - so drop that part of the patch for the moment.

	Dominik

 drivers/pcmcia/cs.c         |   12 +++++++++++-
 drivers/pcmcia/hd64465_ss.c |   34 +++++++++++++++++++++++++++++-----
 drivers/pcmcia/i82092.c     |    4 ++++
 drivers/pcmcia/i82365.c     |   20 ++++++++++++++++++++
 drivers/pcmcia/pci_socket.c |    6 +++++-
 drivers/pcmcia/tcic.c       |   26 ++++++++++++++++++++++++++
 include/pcmcia/ss.h         |    2 ++
 7 files changed, 97 insertions(+), 7 deletions(-)

diff -ruN linux-original/drivers/pcmcia/cs.c linux-pcmcia/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2002-12-20 17:13:47.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/cs.c	2003-02-14 23:17:57.000000000 +0100
@@ -47,6 +47,7 @@
 #include <linux/proc_fs.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
+#include <linux/device.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -2415,16 +2416,24 @@
 EXPORT_SYMBOL(pcmcia_suspend_socket);
 EXPORT_SYMBOL(pcmcia_resume_socket);
 
+struct device_class pcmcia_socket_class = {
+	.name = "pcmcia_socket",
+};
+EXPORT_SYMBOL(pcmcia_socket_class);
+
+
 static int __init init_pcmcia_cs(void)
 {
     printk(KERN_INFO "%s\n", release);
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
+    devclass_register(&pcmcia_socket_class);
     if (do_apm)
 	pm_register(PM_SYS_DEV, PM_SYS_PCMCIA, handle_pm_event);
 #ifdef CONFIG_PROC_FS
     proc_pccard = proc_mkdir("pccard", proc_bus);
 #endif
+
     return 0;
 }
 
@@ -2439,9 +2448,10 @@
     if (do_apm)
 	pm_unregister_all(handle_pm_event);
     release_resource_db();
+    devclass_unregister(&pcmcia_socket_class);
 }
 
-module_init(init_pcmcia_cs);
+subsys_initcall(init_pcmcia_cs);
 module_exit(exit_pcmcia_cs);
 
 /*====================================================================*/
diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux-pcmcia/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2002-12-20 17:13:51.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/hd64465_ss.c	2003-02-14 23:17:58.000000000 +0100
@@ -38,6 +38,7 @@
 #include <asm/errno.h>
 #include <linux/irq.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/hd64465.h>
@@ -991,6 +992,20 @@
 }
 
 
+static struct device_driver hd64465_driver = {
+	.name = "hd64465-pcmcia",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
+static struct platform_device hd64465_device = {
+	.name = "hd64465-pcmcia",
+	.id = 0,
+	.dev = {
+		.name = "hd64465-pcmcia",
+	},
+};
+
 static int __init init_hs(void)
 {
 	servinfo_t serv;
@@ -1007,6 +1022,7 @@
 	}
 
 /*	hd64465_io_debug = 1; */
+	register_driver(&hd64465_driver);
 	
 	/* Wake both sockets out of STANDBY mode */
 	/* TODO: wait 15ms */
@@ -1036,21 +1052,27 @@
 	    HD64465_IRQ_PCMCIA0,
 	    HD64465_PCC0_BASE,
 	    HD64465_REG_PCC0ISR);
-	if (i < 0)
-	    return i;
+	if (i < 0) {
+		unregister_driver(&hd64465_driver);
+		return i;
+	}
 	i = hs_init_socket(&hs_sockets[1],
 	    HD64465_IRQ_PCMCIA1,
 	    HD64465_PCC1_BASE,
 	    HD64465_REG_PCC1ISR);
-	if (i < 0)
-	    return i;
+	if (i < 0) {
+		unregister_driver(&hd64465_driver);
+		return i;
+	}
 
 /*	hd64465_io_debug = 0; */
-	    
+	platform_device_register(&hd64465_device);
 
 	if (register_ss_entry(HS_MAX_SOCKETS, &hs_operations) != 0) {
 	    for (i=0 ; i<HS_MAX_SOCKETS ; i++)
 		hs_exit_socket(&hs_sockets[i]);
+	    platform_device_unregister(&hd64465_device);
+	    unregister_driver(&hd64465_driver);
     	    return -ENODEV;
 	}
 
@@ -1078,9 +1100,11 @@
 	 */
 	for (i=0 ; i<HS_MAX_SOCKETS ; i++)
 	    hs_exit_socket(&hs_sockets[i]);
+	platform_device_unregister(&hd64465_device);
 	unregister_ss_entry(&hs_operations);
 	
 	restore_flags(flags);
+	unregister_driver(&hd64465_driver);
 }
 
 module_init(init_hs);
diff -ruN linux-original/drivers/pcmcia/i82092.c linux-pcmcia/drivers/pcmcia/i82092.c
--- linux-original/drivers/pcmcia/i82092.c	2003-02-15 10:08:41.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/i82092.c	2003-02-15 10:09:21.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 
 #include <pcmcia/cs_types.h>
 #include <pcmcia/ss.h>
@@ -46,6 +47,9 @@
 	.id_table       = i82092aa_pci_ids,
 	.probe          = i82092aa_pci_probe,
 	.remove         = __devexit_p(i82092aa_pci_remove),
+	.driver		= {
+		.devclass = &pcmcia_socket_class,
+	},
 };
 
 
diff -ruN linux-original/drivers/pcmcia/i82365.c linux-pcmcia/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-01-17 16:50:13.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/i82365.c	2003-02-14 23:17:58.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -1583,6 +1584,20 @@
 
 /*====================================================================*/
 
+static struct device_driver i82365_driver = {
+	.name = "i82365",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
+static struct platform_device i82365_device = {
+	.name = "i82365",
+	.id = 0,
+	.dev = {
+		.name = "i82365",
+	},
+};
+
 static int __init init_i82365(void)
 {
     servinfo_t serv;
@@ -1595,6 +1610,7 @@
     DEBUG(0, "%s\n", version);
     printk(KERN_INFO "Intel PCIC probe: ");
     sockets = 0;
+    driver_register(&i82365_driver);
 
 #ifdef CONFIG_ISA
     isa_probe();
@@ -1602,6 +1618,7 @@
 
     if (sockets == 0) {
 	printk("not found.\n");
+	driver_unregister(&i82365_driver);
 	return -ENODEV;
     }
 
@@ -1611,6 +1628,7 @@
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
     
+    platform_device_register(&i82365_device);
     if (register_ss_entry(sockets, &pcic_operations) != 0)
 	printk(KERN_NOTICE "i82365: register_ss_entry() failed\n");
 
@@ -1634,6 +1652,7 @@
     for (i = 0; i < sockets; i++) pcic_proc_remove(i);
 #endif
     unregister_ss_entry(&pcic_operations);
+    platform_device_unregister(&i82365_device);
     if (poll_interval != 0)
 	del_timer_sync(&poll_timer);
 #ifdef CONFIG_ISA
@@ -1649,6 +1668,7 @@
     if (i82365_pnpdev)
     		pnp_disable_dev(i82365_pnpdev);
 #endif
+    driver_unregister(&i82365_driver);
 } /* exit_i82365 */
 
 module_init(init_i82365);
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux-pcmcia/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2002-12-20 17:13:51.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/pci_socket.c	2003-02-14 23:17:58.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 
 #include <pcmcia/ss.h>
 
@@ -253,11 +254,14 @@
 	.remove		= __devexit_p(cardbus_remove),
 	.suspend	= cardbus_suspend,
 	.resume		= cardbus_resume,
+	.driver		= {
+		.devclass = &pcmcia_socket_class,
+	},
 };
 
 static int __init pci_socket_init(void)
 {
-	return pci_module_init (&pci_cardbus_driver);
+	return pci_register_driver (&pci_cardbus_driver);
 }
 
 static void __exit pci_socket_exit (void)
diff -ruN linux-original/drivers/pcmcia/tcic.c linux-pcmcia/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2002-12-20 17:14:01.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/tcic.c	2003-02-14 23:17:58.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -375,6 +376,21 @@
 
 /*====================================================================*/
 
+
+static struct device_driver tcic_driver = {
+	.name = "tcic-pcmcia",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
+static struct platform_device tcic_device = {
+	.name = "tcic-pcmcia",
+	.id = 0,
+	.dev = {
+		.name = "tcic-pcmcia",
+	},
+};
+
 static int __init init_tcic(void)
 {
     int i, sock;
@@ -388,12 +404,15 @@
 	       "does not match!\n");
 	return -1;
     }
+
+    driver_register(&tcic_driver);
     
     printk(KERN_INFO "Databook TCIC-2 PCMCIA probe: ");
     sock = 0;
 
     if (!request_region(tcic_base, 16, "tcic-2")) {
 	printk("could not allocate ports,\n ");
+	driver_unregister(&tcic_driver);
 	return -ENODEV;
     }
     else {
@@ -416,6 +435,7 @@
     if (sock == 0) {
 	printk("not found.\n");
 	release_region(tcic_base, 16);
+	driver_unregister(&tcic_driver);
 	return -ENODEV;
     }
 
@@ -429,6 +449,8 @@
 	sockets++;
     }
 
+    platform_device_register(&tcic_device);
+
     switch (socket_table[0].id) {
     case TCIC_ID_DB86082:
 	printk("DB86082"); break;
@@ -504,6 +526,8 @@
 	release_region(tcic_base, 16);
 	if (cs_irq != 0)
 	    free_irq(cs_irq, tcic_interrupt);
+	platform_device_unregister(&tcic_device);
+	driver_unregister(&tcic_driver);
 	return -ENODEV;
     }
 
@@ -522,6 +546,8 @@
 	free_irq(cs_irq, tcic_interrupt);
     }
     release_region(tcic_base, 16);
+    platform_device_unregister(&tcic_device);
+    driver_unregister(&tcic_driver);
 } /* exit_tcic */
 
 /*====================================================================*/
diff -ruN linux-original/include/pcmcia/ss.h linux-pcmcia/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2002-02-20 09:58:06.000000000 +0100
+++ linux-pcmcia/include/pcmcia/ss.h	2003-02-14 23:17:19.000000000 +0100
@@ -145,4 +145,6 @@
 extern int register_ss_entry(int nsock, struct pccard_operations *ops);
 extern void unregister_ss_entry(struct pccard_operations *ops);
 
+extern struct device_class pcmcia_socket_class;
+
 #endif /* _LINUX_SS_H */
