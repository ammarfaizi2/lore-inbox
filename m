Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVF3AV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVF3AV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVF3AV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:21:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262767AbVF3AVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:21:22 -0400
Date: Wed, 29 Jun 2005 17:21:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.12.2
Message-ID: <20050630002115.GR9046@shell0.pdx.osdl.net>
References: <20050630002046.GQ9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630002046.GQ9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .1
+EXTRAVERSION = .2
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -435,6 +435,7 @@ acpi_pci_irq_enable (
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
+			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);
 		}
 		else {
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2307,6 +2307,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 	tso = e1000_tso(adapter, skb);
 	if (tso < 0) {
 		dev_kfree_skb_any(skb);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return NETDEV_TX_OK;
 	}
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -396,7 +396,7 @@ int pci_register_driver(struct pci_drive
 	/* FIXME, once all of the existing PCI drivers have been fixed to set
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
-		drv->driver.shutdown = pci_device_shutdown,
+		drv->driver.shutdown = pci_device_shutdown;
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1150,7 +1150,7 @@ iospace_error_exit:
  */
 int qla2x00_probe_one(struct pci_dev *pdev, struct qla_board_info *brd_info)
 {
-	int	ret;
+	int	ret = -ENODEV;
 	device_reg_t __iomem *reg;
 	struct Scsi_Host *host;
 	scsi_qla_host_t *ha;
@@ -1161,7 +1161,7 @@ int qla2x00_probe_one(struct pci_dev *pd
 	fc_port_t *fcport;
 
 	if (pci_enable_device(pdev))
-		return -1;
+		goto probe_out;
 
 	host = scsi_host_alloc(&qla2x00_driver_template,
 	    sizeof(scsi_qla_host_t));
@@ -1183,9 +1183,8 @@ int qla2x00_probe_one(struct pci_dev *pd
 
 	/* Configure PCI I/O space */
 	ret = qla2x00_iospace_config(ha);
-	if (ret != 0) {
-		goto probe_alloc_failed;
-	}
+	if (ret)
+		goto probe_failed;
 
 	/* Sanitize the information from PCI BIOS. */
 	host->irq = pdev->irq;
@@ -1258,23 +1257,10 @@ int qla2x00_probe_one(struct pci_dev *pd
 		qla_printk(KERN_WARNING, ha,
 		    "[ERROR] Failed to allocate memory for adapter\n");
 
-		goto probe_alloc_failed;
+		ret = -ENOMEM;
+		goto probe_failed;
 	}
 
-	pci_set_drvdata(pdev, ha);
-	host->this_id = 255;
-	host->cmd_per_lun = 3;
-	host->unique_id = ha->instance;
-	host->max_cmd_len = MAX_CMDSZ;
-	host->max_channel = ha->ports - 1;
-	host->max_id = ha->max_targets;
-	host->max_lun = ha->max_luns;
-	host->transportt = qla2xxx_transport_template;
-	if (scsi_add_host(host, &pdev->dev))
-		goto probe_alloc_failed;
-
-	qla2x00_alloc_sysfs_attr(ha);
-
 	if (qla2x00_initialize_adapter(ha) &&
 	    !(ha->device_flags & DFLG_NO_CABLE)) {
 
@@ -1285,11 +1271,10 @@ int qla2x00_probe_one(struct pci_dev *pd
 		    "Adapter flags %x.\n",
 		    ha->host_no, ha->device_flags));
 
+		ret = -ENODEV;
 		goto probe_failed;
 	}
 
-	qla2x00_init_host_attr(ha);
-
 	/*
 	 * Startup the kernel thread for this host adapter
 	 */
@@ -1299,17 +1284,26 @@ int qla2x00_probe_one(struct pci_dev *pd
 		qla_printk(KERN_WARNING, ha,
 		    "Unable to start DPC thread!\n");
 
+		ret = -ENODEV;
 		goto probe_failed;
 	}
 	wait_for_completion(&ha->dpc_inited);
 
+	host->this_id = 255;
+	host->cmd_per_lun = 3;
+	host->unique_id = ha->instance;
+	host->max_cmd_len = MAX_CMDSZ;
+	host->max_channel = ha->ports - 1;
+	host->max_lun = MAX_LUNS;
+	host->transportt = qla2xxx_transport_template;
+
 	if (IS_QLA2100(ha) || IS_QLA2200(ha))
 		ret = request_irq(host->irq, qla2100_intr_handler,
 		    SA_INTERRUPT|SA_SHIRQ, ha->brd_info->drv_name, ha);
 	else
 		ret = request_irq(host->irq, qla2300_intr_handler,
 		    SA_INTERRUPT|SA_SHIRQ, ha->brd_info->drv_name, ha);
-	if (ret != 0) {
+	if (ret) {
 		qla_printk(KERN_WARNING, ha,
 		    "Failed to reserve interrupt %d already in use.\n",
 		    host->irq);
@@ -1363,9 +1357,18 @@ int qla2x00_probe_one(struct pci_dev *pd
 		msleep(10);
 	}
 
+	pci_set_drvdata(pdev, ha);
 	ha->flags.init_done = 1;
 	num_hosts++;
 
+	ret = scsi_add_host(host, &pdev->dev);
+	if (ret)
+		goto probe_failed;
+
+	qla2x00_alloc_sysfs_attr(ha);
+
+	qla2x00_init_host_attr(ha);
+
 	qla_printk(KERN_INFO, ha, "\n"
 	    " QLogic Fibre Channel HBA Driver: %s\n"
 	    "  QLogic %s - %s\n"
@@ -1384,9 +1387,6 @@ int qla2x00_probe_one(struct pci_dev *pd
 probe_failed:
 	fc_remove_host(ha->host);
 
-	scsi_remove_host(host);
-
-probe_alloc_failed:
 	qla2x00_free_device(ha);
 
 	scsi_host_put(host);
@@ -1394,7 +1394,8 @@ probe_alloc_failed:
 probe_disable_device:
 	pci_disable_device(pdev);
 
-	return -1;
+probe_out:
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qla2x00_probe_one);
 
diff --git a/include/asm-i386/string.h b/include/asm-i386/string.h
--- a/include/asm-i386/string.h
+++ b/include/asm-i386/string.h
@@ -116,7 +116,8 @@ __asm__ __volatile__(
 	"orb $1,%%al\n"
 	"3:"
 	:"=a" (__res), "=&S" (d0), "=&D" (d1)
-		     :"1" (cs),"2" (ct));
+	:"1" (cs),"2" (ct)
+	:"memory");
 return __res;
 }
 
@@ -138,8 +139,9 @@ __asm__ __volatile__(
 	"3:\tsbbl %%eax,%%eax\n\t"
 	"orb $1,%%al\n"
 	"4:"
-		     :"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
-		     :"1" (cs),"2" (ct),"3" (count));
+	:"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
+	:"1" (cs),"2" (ct),"3" (count)
+	:"memory");
 return __res;
 }
 
@@ -158,7 +160,9 @@ __asm__ __volatile__(
 	"movl $1,%1\n"
 	"2:\tmovl %1,%0\n\t"
 	"decl %0"
-	:"=a" (__res), "=&S" (d0) : "1" (s),"0" (c));
+	:"=a" (__res), "=&S" (d0)
+	:"1" (s),"0" (c)
+	:"memory");
 return __res;
 }
 
@@ -175,7 +179,9 @@ __asm__ __volatile__(
 	"leal -1(%%esi),%0\n"
 	"2:\ttestb %%al,%%al\n\t"
 	"jne 1b"
-	:"=g" (__res), "=&S" (d0), "=&a" (d1) :"0" (0),"1" (s),"2" (c));
+	:"=g" (__res), "=&S" (d0), "=&a" (d1)
+	:"0" (0),"1" (s),"2" (c)
+	:"memory");
 return __res;
 }
 
@@ -189,7 +195,9 @@ __asm__ __volatile__(
 	"scasb\n\t"
 	"notl %0\n\t"
 	"decl %0"
-	:"=c" (__res), "=&D" (d0) :"1" (s),"a" (0), "0" (0xffffffffu));
+	:"=c" (__res), "=&D" (d0)
+	:"1" (s),"a" (0), "0" (0xffffffffu)
+	:"memory");
 return __res;
 }
 
@@ -333,7 +341,9 @@ __asm__ __volatile__(
 	"je 1f\n\t"
 	"movl $1,%0\n"
 	"1:\tdecl %0"
-	:"=D" (__res), "=&c" (d0) : "a" (c),"0" (cs),"1" (count));
+	:"=D" (__res), "=&c" (d0)
+	:"a" (c),"0" (cs),"1" (count)
+	:"memory");
 return __res;
 }
 
@@ -369,7 +379,7 @@ __asm__ __volatile__(
 	"je 2f\n\t"
 	"stosb\n"
 	"2:"
-	: "=&c" (d0), "=&D" (d1)
+	:"=&c" (d0), "=&D" (d1)
 	:"a" (c), "q" (count), "0" (count/4), "1" ((long) s)
 	:"memory");
 return (s);	
@@ -392,7 +402,8 @@ __asm__ __volatile__(
 	"jne 1b\n"
 	"3:\tsubl %2,%0"
 	:"=a" (__res), "=&d" (d0)
-	:"c" (s),"1" (count));
+	:"c" (s),"1" (count)
+	:"memory");
 return __res;
 }
 /* end of additional stuff */
@@ -473,7 +484,8 @@ static inline void * memscan(void * addr
 		"dec %%edi\n"
 		"1:"
 		: "=D" (addr), "=c" (size)
-		: "0" (addr), "1" (size), "a" (c));
+		: "0" (addr), "1" (size), "a" (c)
+		: "memory");
 	return addr;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1164,7 +1164,7 @@ int remap_pfn_range(struct vm_area_struc
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long end = addr + size;
+	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -315,8 +315,8 @@ err:
 static void netlink_remove(struct sock *sk)
 {
 	netlink_table_grab();
-	nl_table[sk->sk_protocol].hash.entries--;
-	sk_del_node_init(sk);
+	if (sk_del_node_init(sk))
+		nl_table[sk->sk_protocol].hash.entries--;
 	if (nlk_sk(sk)->groups)
 		__sk_del_bind_node(sk);
 	netlink_table_ungrab();
@@ -429,7 +429,12 @@ retry:
 	err = netlink_insert(sk, pid);
 	if (err == -EADDRINUSE)
 		goto retry;
-	return 0;
+
+	/* If 2 threads race to autobind, that is fine.  */
+	if (err == -EBUSY)
+		err = 0;
+
+	return err;
 }
 
 static inline int netlink_capable(struct socket *sock, unsigned int flag) 
