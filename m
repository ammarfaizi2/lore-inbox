Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTJPBy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 21:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTJPBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 21:54:28 -0400
Received: from panda.sul.com.br ([200.219.150.4]:26372 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262665AbTJPBy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 21:54:26 -0400
Date: Wed, 15 Oct 2003 23:53:49 -0200
To: linux-kernel@vger.kernel.org
Cc: Brard Roudier <groudier@free.fr>
Subject: [patch][2/3] qlogic: call request_irq() with private data
Message-ID: <20031016015349.GB1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-- 
aris


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-request_irq.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-15 23:42:15.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-15 23:44:11.000000000 -0200
@@ -667,9 +667,6 @@
 		qlirq = j;
 	} else
 		printk(KERN_INFO "Ql: Using preset IRQ %d\n", qlirq);
-
-	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
-		host->can_queue = 1;
 #endif
 	hreg = scsi_host_alloc(host, 0);	/* no host data */
 	if (!hreg)
@@ -677,17 +674,23 @@
 	hreg->io_port = qbase;
 	hreg->n_io_port = 16;
 	hreg->dma_channel = -1;
-	if (qlirq != -1)
-		hreg->irq = qlirq;
+	hreg->irq = qlirq;
+	hreg->can_queue = 1;
 	INIT_LIST_HEAD(&hreg->sht_legacy_list);
 
 	sprintf(qinfo,
 		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
 		qltyp, qbase, qlirq, QL_TURBO_PDMA);
 	host->name = qinfo;
+#ifdef QL_USE_IRQ
+	if (qlirq < 0 || request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", hreg))
+		goto free_scsi_host;
+#endif
 
 	return hreg;
 
+free_scsi_host:
+	kfree(hreg);
 err_release_mem:
 	release_region(qbase, 0x10);
 	if (host->can_queue)

--dc+cDN39EJAMEtIO--
