Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTBJWwq>; Mon, 10 Feb 2003 17:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTBJWwq>; Mon, 10 Feb 2003 17:52:46 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:59301 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265570AbTBJWwj>; Mon, 10 Feb 2003 17:52:39 -0500
Date: Tue, 11 Feb 2003 00:02:06 +0100
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
Cc: linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia: new device class "pcmcia_socket"
Message-ID: <20030210230206.GA3082@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New device_class pcmcia_socket_class. Added a struct device_driver to all
pcmcia socket drivers I could find; most of them are drivers for
platform-bus devices.

	Dominik

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-10 23:50:18.000000000 +0100
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
diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/hd64465_ss.c	2003-02-10 23:43:27.000000000 +0100
@@ -38,6 +38,7 @@
 #include <asm/errno.h>
 #include <linux/irq.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/hd64465.h>
@@ -991,6 +992,12 @@
 }
 
 
+static struct device_driver hd64465_driver = {
+	.name = "hd64465-pcmcia",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
 static int __init init_hs(void)
 {
 	servinfo_t serv;
@@ -1007,6 +1014,7 @@
 	}
 
 /*	hd64465_io_debug = 1; */
+	register_driver(&hd64465_driver);
 	
 	/* Wake both sockets out of STANDBY mode */
 	/* TODO: wait 15ms */
@@ -1036,14 +1044,18 @@
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
 	    
@@ -1051,6 +1063,7 @@
 	if (register_ss_entry(HS_MAX_SOCKETS, &hs_operations) != 0) {
 	    for (i=0 ; i<HS_MAX_SOCKETS ; i++)
 		hs_exit_socket(&hs_sockets[i]);
+	    unregister_driver(&hd64465_driver);
     	    return -ENODEV;
 	}
 
@@ -1081,6 +1094,7 @@
 	unregister_ss_entry(&hs_operations);
 	
 	restore_flags(flags);
+	unregister_driver(&hd64465_driver);
 }
 
 module_init(init_hs);
diff -ruN linux-original/drivers/pcmcia/i82092.c linux/drivers/pcmcia/i82092.c
--- linux-original/drivers/pcmcia/i82092.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/i82092.c	2003-02-10 23:42:34.000000000 +0100
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
 
 
diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-02-10 23:43:45.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -1583,6 +1584,12 @@
 
 /*====================================================================*/
 
+static struct device_driver i82365_driver = {
+	.name = "i82365",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
 static int __init init_i82365(void)
 {
     servinfo_t serv;
@@ -1595,6 +1602,7 @@
     DEBUG(0, "%s\n", version);
     printk(KERN_INFO "Intel PCIC probe: ");
     sockets = 0;
+    driver_register(&i82365_driver);
 
 #ifdef CONFIG_ISA
     isa_probe();
@@ -1602,6 +1610,7 @@
 
     if (sockets == 0) {
 	printk("not found.\n");
+	driver_unregister(&i82365_driver);
 	return -ENODEV;
     }
 
@@ -1649,6 +1658,7 @@
     if (i82365_pnpdev)
     		pnp_disable_dev(i82365_pnpdev);
 #endif
+    driver_unregister(&i82365_driver);
 } /* exit_i82365 */
 
 module_init(init_i82365);
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-02-10 23:07:26.000000000 +0100
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
diff -ruN linux-original/drivers/pcmcia/sa1100_generic.c linux/drivers/pcmcia/sa1100_generic.c
--- linux-original/drivers/pcmcia/sa1100_generic.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/sa1100_generic.c	2003-02-10 23:43:52.000000000 +0100
@@ -47,7 +47,7 @@
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
-#include <linux/cpufreq.h>
+#include <linux/device.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -1092,6 +1092,12 @@
 }
 EXPORT_SYMBOL(sa1100_unregister_pcmcia);
 
+static struct device_driver sa1100_pcmcia_driver = {
+	.name = "sa1100_pcmcia",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
 /* sa1100_pcmcia_init()
  * ^^^^^^^^^^^^^^^^^^^^
  *
@@ -1124,6 +1130,8 @@
 		skt->speed_mem  = SA1100_PCMCIA_5V_MEM_ACCESS;
 	}
 
+	driver_register(&sa1100_pcmcia_driver);
+
 #ifdef CONFIG_CPU_FREQ
 	ret = cpufreq_register_notifier(&sa1100_pcmcia_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
@@ -1223,6 +1231,8 @@
 #ifdef CONFIG_CPU_FREQ
 	cpufreq_unregister_notifier(&sa1100_pcmcia_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
+
+	driver_unregister(&sa1100_pcmcia_driver);
 }
 
 MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-02-10 22:57:52.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-02-10 23:51:12.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -375,6 +376,13 @@
 
 /*====================================================================*/
 
+
+static struct device_driver tcic_driver = {
+	.name = "tcic-pcmcia",
+	.bus = &platform_bus_type,
+	.devclass = &pcmcia_socket_class,
+};
+
 static int __init init_tcic(void)
 {
     int i, sock;
@@ -388,12 +396,15 @@
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
@@ -416,6 +427,7 @@
     if (sock == 0) {
 	printk("not found.\n");
 	release_region(tcic_base, 16);
+	driver_unregister(&tcic_driver);
 	return -ENODEV;
     }
 
@@ -504,6 +516,7 @@
 	release_region(tcic_base, 16);
 	if (cs_irq != 0)
 	    free_irq(cs_irq, tcic_interrupt);
+	driver_unregister(&tcic_driver);
 	return -ENODEV;
     }
 
@@ -522,6 +535,7 @@
 	free_irq(cs_irq, tcic_interrupt);
     }
     release_region(tcic_base, 16);
+    driver_unregister(&tcic_driver);
 } /* exit_tcic */
 
 /*====================================================================*/
diff -ruN linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-10 22:57:58.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-02-10 23:08:13.000000000 +0100
@@ -145,4 +145,6 @@
 extern int register_ss_entry(int nsock, struct pccard_operations *ops);
 extern void unregister_ss_entry(struct pccard_operations *ops);
 
+extern struct device_class pcmcia_socket_class;
+
 #endif /* _LINUX_SS_H */
