Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTJTXYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTJTXYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:24:32 -0400
Received: from panda.sul.com.br ([200.219.150.4]:28683 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263005AbTJTXY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:24:29 -0400
Date: Mon, 20 Oct 2003 21:23:20 -0200
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: [patch] qlogic: call request_irq() with private data
Message-ID: <20031020232320.GB473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



-- 
aris


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-request_irq_with_priv_data.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-17 16:49:30.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-17 16:54:06.000000000 -0200
@@ -650,9 +650,6 @@
 	} else
 		printk(KERN_INFO "Ql: Using preset IRQ %d\n", qlirq);
 
-	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
-		host->can_queue = 1;
-
 	hreg = scsi_register(host, 0);	/* no host data */
 	if (!hreg)
 		goto err_release_mem;
@@ -666,12 +663,20 @@
 		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
 		qltyp, qbase, qlirq, QL_TURBO_PDMA);
 
+	if (request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", hreg))
+		goto free_scsi_host;
+
 	return hreg;
 
+free_scsi_host:
+#ifdef PCMCIA
+	scsi_host_put(hreg);
+#else
+	scsi_unregister(hreg);
+#endif
+
 err_release_mem:
 	release_region(qbase, 0x10);
-	if (host->can_queue)
-		free_irq(qlirq, do_ql_ihandl);
 	return NULL;;
 
 }

--i9LlY+UWpKt15+FH--
