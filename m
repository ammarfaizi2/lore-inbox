Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTEOV1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEOV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:27:46 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:640 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264256AbTEOV1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:27:40 -0400
Date: Thu, 15 May 2003 17:40:33 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305152140.h4FLeX101951@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] allow atm to be loaded as a module
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.68/net/Kconfig.002	Thu May 15 14:37:28 2003
+++ linux-2.5.68/net/Kconfig	Thu May 15 14:37:50 2003
@@ -213,7 +213,7 @@
 source "net/sctp/Kconfig"
 
 config ATM
-	bool "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
+	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	---help---
 	  ATM is a high-speed networking technology for Local Area Networks
--- linux-2.5.68/net/sched/Kconfig.000	Thu May 15 14:38:02 2003
+++ linux-2.5.68/net/sched/Kconfig	Thu May 15 14:38:42 2003
@@ -63,7 +63,7 @@
 #tristate '  H-PFQ packet scheduler' CONFIG_NET_SCH_HPFQ
 #tristate '  H-FSC packet scheduler' CONFIG_NET_SCH_HFCS
 config NET_SCH_ATM
-	bool "ATM pseudo-scheduler"
+	tristate "ATM pseudo-scheduler"
 	depends on NET_SCHED && ATM
 	---help---
 	  Say Y here if you want to use the ATM pseudo-scheduler.  This
--- linux-2.5.68/net/atm/Makefile.002	Thu May 15 15:12:02 2003
+++ linux-2.5.68/net/atm/Makefile	Thu May 15 15:12:22 2003
@@ -11,7 +11,7 @@
 obj-$(CONFIG_ATM_BR2684) += br2684.o
 atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
 atm-$(subst m,y,$CONFIG_NET_SCH_ATM)) += ipcommon.o
-obj-$(CONFIG_PROC_FS) += proc.o
+atm-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o
 obj-$(CONFIG_ATM_MPOA) += mpoa.o
--- linux-2.5.68/net/atm/common.c.006	Thu May 15 14:37:03 2003
+++ linux-2.5.68/net/atm/common.c	Thu May 15 17:36:53 2003
@@ -1209,3 +1209,42 @@
         return;
 }        
 #endif
+
+static int __init atm_init(void)
+{
+	int error;
+
+	if ((error = atmpvc_init()) < 0) {
+		printk(KERN_ERR "atmpvc_init() failed with %d\n", error);
+		goto done;
+	}
+	if ((error = atmsvc_init()) < 0) {
+		printk(KERN_ERR "atmsvc_init() failed with %d\n", error);
+		atmpvc_exit();
+		goto done;
+	}
+#ifdef CONFIG_PROC_FS
+        if ((error = atm_proc_init()) < 0) {
+		printk(KERN_ERR "atm_proc_init() failed with %d\n",error);
+		atmpvc_exit();
+		atmsvc_exit();
+		goto done;
+	}
+#endif
+done:
+	return error;
+}
+
+static void __exit atm_exit(void)
+{
+#ifdef CONFIG_PROC_FS
+	atm_proc_exit();
+#endif
+	atmsvc_exit();
+	atmpvc_exit();
+}
+
+module_init(atm_init);
+module_exit(atm_exit);
+
+MODULE_LICENSE("GPL");
--- linux-2.5.68/net/atm/common.h.000	Thu May 15 15:00:31 2003
+++ linux-2.5.68/net/atm/common.h	Thu May 15 14:53:12 2003
@@ -28,7 +28,12 @@
 void atm_release_vcc_sk(struct sock *sk,int free_sk);
 void atm_shutdown_dev(struct atm_dev *dev);
 
+int atmpvc_init(void);
+void atmpvc_exit(void);
+int atmsvc_init(void);
+void atmsvc_exit(void);
 int atm_proc_init(void);
+void atm_proc_exit(void);
 
 /* SVC */
 
--- linux-2.5.68/net/atm/svc.c.002	Thu May 15 14:39:08 2003
+++ linux-2.5.68/net/atm/svc.c	Thu May 15 15:06:03 2003
@@ -439,13 +439,12 @@
  *	Initialize the ATM SVC protocol family
  */
 
-static int __init atmsvc_init(void)
+int __init atmsvc_init(void)
 {
-	if (sock_register(&svc_family_ops) < 0) {
-		printk(KERN_ERR "ATMSVC: can't register");
-		return -1;
-	}
-	return 0;
+	return sock_register(&svc_family_ops);
 }
 
-module_init(atmsvc_init);
+void __exit atmsvc_exit(void)
+{
+	sock_unregister(PF_ATMSVC);
+}
--- linux-2.5.68/net/atm/pvc.c.001	Thu May 15 14:39:11 2003
+++ linux-2.5.68/net/atm/pvc.c	Thu May 15 15:05:58 2003
@@ -116,20 +116,12 @@
  */
 
 
-static int __init atmpvc_init(void)
+int __init atmpvc_init(void)
 {
-	int error;
-
-	error = sock_register(&pvc_family_ops);
-	if (error < 0) {
-		printk(KERN_ERR "ATMPVC: can't register (%d)",error);
-		return error;
-	}
-#ifdef CONFIG_PROC_FS
-	error = atm_proc_init();
-	if (error) printk("atm_proc_init fails with %d\n",error);
-#endif
-	return 0;
+	return sock_register(&pvc_family_ops);
 }
 
-module_init(atmpvc_init);
+void __exit atmpvc_exit(void)
+{
+	sock_unregister(PF_ATMPVC);
+}
--- linux-2.5.68/net/atm/proc.c.002	Thu May 15 15:00:43 2003
+++ linux-2.5.68/net/atm/proc.c	Thu May 15 17:18:36 2003
@@ -630,12 +630,28 @@
     name->proc_fops = &proc_spec_atm_operations; \
     name->owner = THIS_MODULE
 
+static struct proc_dir_entry *devices = NULL, *pvc = NULL,
+		*svc = NULL, *arp = NULL, *lec = NULL, *vc = NULL;
 
-int __init atm_proc_init(void)
+static void atm_proc_cleanup(void)
 {
-	struct proc_dir_entry *devices = NULL,*pvc = NULL,*svc = NULL;
-	struct proc_dir_entry *arp = NULL,*lec = NULL,*vc = NULL;
+	if (devices)
+		remove_proc_entry("devices",atm_proc_root);
+	if (pvc)
+		remove_proc_entry("pvc",atm_proc_root);
+	if (svc)
+		remove_proc_entry("svc",atm_proc_root);
+	if (arp)
+		remove_proc_entry("arp",atm_proc_root);
+	if (lec)
+		remove_proc_entry("lec",atm_proc_root);
+	if (vc)
+		remove_proc_entry("vc",atm_proc_root);
+	remove_proc_entry("net/atm",NULL);
+}
 
+int __init atm_proc_init(void)
+{
 	atm_proc_root = proc_mkdir("net/atm",NULL);
 	if (!atm_proc_root)
 		return -ENOMEM;
@@ -652,12 +668,11 @@
 	return 0;
 
 cleanup:
-	if (devices) remove_proc_entry("devices",atm_proc_root);
-	if (pvc) remove_proc_entry("pvc",atm_proc_root);
-	if (svc) remove_proc_entry("svc",atm_proc_root);
-	if (arp) remove_proc_entry("arp",atm_proc_root);
-	if (lec) remove_proc_entry("lec",atm_proc_root);
-	if (vc) remove_proc_entry("vc",atm_proc_root);
-	remove_proc_entry("net/atm",NULL);
+	atm_proc_cleanup();
 	return -ENOMEM;
 }
+
+void __exit atm_proc_exit(void)
+{
+	atm_proc_cleanup();
+}
--- linux-2.5.68/drivers/atm/Kconfig.001	Thu May 15 17:29:51 2003
+++ linux-2.5.68/drivers/atm/Kconfig	Thu May 15 17:32:59 2003
@@ -7,14 +7,14 @@
 
 config ATM_TCP
 	tristate "ATM over TCP"
-	depends on INET
+	depends on INET && ATM
 	help
 	  ATM over TCP driver. Useful mainly for development and for
 	  experiments. If unsure, say N.
 
 config ATM_LANAI
 	tristate "Efficient Networks Speedstream 3010"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  Supports ATM cards based on the Efficient Networks "Lanai"
 	  chipset such as the Speedstream 3010 and the ENI-25p.  The
@@ -23,7 +23,7 @@
 
 config ATM_ENI
 	tristate "Efficient Networks ENI155P"
-	depends on PCI
+	depends on PCI && ATM
 	---help---
 	  Driver for the Efficient Networks ENI155p series and SMC ATM
 	  Power155 155 Mbps ATM adapters. Both, the versions with 512KB and
@@ -133,7 +133,7 @@
 
 config ATM_FIRESTREAM
 	tristate "Fujitsu FireStream (FS50/FS155) "
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  Driver for the Fujitsu FireStream 155 (MB86697) and
 	  FireStream 50 (MB86695) ATM PCI chips.
@@ -145,7 +145,7 @@
 
 config ATM_ZATM
 	tristate "ZeitNet ZN1221/ZN1225"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  Driver for the ZeitNet ZN1221 (MMF) and ZN1225 (UTP-5) 155 Mbps ATM
 	  adapters.
@@ -182,7 +182,7 @@
 #   fi
 config ATM_NICSTAR
 	tristate "IDT 77201 (NICStAR) (ForeRunnerLE)"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  The NICStAR chipset family is used in a large number of ATM NICs for
 	  25 and for 155 Mbps, including IDT cards and the Fore ForeRunnerLE
@@ -217,7 +217,7 @@
 
 config ATM_IDT77252
 	tristate "IDT 77252 (NICStAR II)"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  Driver for the IDT 77252 ATM PCI chips.
 
@@ -253,7 +253,7 @@
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
@@ -277,7 +277,7 @@
 
 config ATM_HORIZON
 	tristate "Madge Horizon [Ultra] (Collage PCI 25 and Collage PCI 155 Client)"
-	depends on PCI
+	depends on PCI && ATM
 	help
 	  This is a driver for the Horizon chipset ATM adapter cards once
 	  produced by Madge Networks Ltd. Say Y (or M to compile as a module
@@ -301,7 +301,7 @@
 
 config ATM_IA
 	tristate "Interphase ATM PCI x575/x525/x531"
-	depends on PCI
+	depends on PCI && ATM
 	---help---
 	  This is a driver for the Interphase (i)ChipSAR adapter cards
 	  which include a variety of variants in term of the size of the
@@ -334,7 +334,7 @@
 
 config ATM_FORE200E_MAYBE
 	tristate "FORE Systems 200E-series"
-	depends on PCI || SBUS
+	depends on (PCI || SBUS) && ATM
 	---help---
 	  This is a driver for the FORE Systems 200E-series ATM adapter
 	  cards. It simultaneously supports PCA-200E and SBA-200E models
