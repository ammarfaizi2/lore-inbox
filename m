Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTFUOOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTFUOOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:14:48 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:50696 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264376AbTFUOOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:14:40 -0400
Date: Sat, 21 Jun 2003 16:29:06 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: schmurtz@netcourrier.com
cc: fischer@norbit.de, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.72-bk3 oops when loading aha152X(isapnp)
In-Reply-To: <wazza.87wuffacm9.fsf@message.id>
Message-ID: <Pine.LNX.4.44.0306211618330.12412-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003 schmurtz@netcourrier.com wrote:

> aha152x0: trying software interrupt, <1>Unable to handle kernel NULL pointer dec
...
> EIP is at swintr+0x4a/0x70 [aha152x]

Seems there are two problems:
* interrupt handler expects to find the host in aha152x_host[] array which
  is currently set too late after probing irq's
* despite testing for NULL swintr derefences a shpnt==NULL anyway, looks 
  like a victim of HOSTNO obfuscation ;-)

The patch below fixes the issue for me - succesfully tested to compile, 
load and even use my attached scanner.

Martin
----------------------

--- linux-2.5.72-bk3/drivers/scsi/aha152x.c	Sat Jun 21 16:14:40 2003
+++ v2.5.72bk3-md/drivers/scsi/aha152x.c	Sat Jun 21 16:07:05 2003
@@ -941,7 +941,8 @@ static irqreturn_t swintr(int irqno, voi
 	struct Scsi_Host *shpnt = lookup_irq(irqno);
 
 	if (!shpnt) {
-        	printk(KERN_ERR "aha152x%d: catched software interrupt %d for unknown controller.\n", HOSTNO, irqno);
+		/* no point using HOSTNO here! */
+        	printk(KERN_ERR "aha152x: catched software interrupt %d for unknown controller.\n", irqno);
 		return IRQ_NONE;
 	}
 
@@ -1049,6 +1050,10 @@ struct Scsi_Host *aha152x_probe_one(stru
 
 	printk(KERN_INFO "aha152x%d: trying software interrupt, ",
 			 shost->host_no);
+
+	/* need to have host registered before triggering any interrupt */
+	aha152x_host[registered_count] = shost;
+	mb();
 	SETPORT(DMACNTRL0, SWINT|INTEN);
 	mdelay(1000);
 	free_irq(shost->irq, shost);
@@ -1064,7 +1069,7 @@ struct Scsi_Host *aha152x_probe_one(stru
 
 		printk(KERN_ERR "aha152x%d: IRQ %d possibly wrong.  "
 				"Please verify.\n", shost->host_no, shost->irq);
-		goto out_release_region;
+		goto out_unregister_host;
 	}
 	printk("ok.\n");
 
@@ -1077,12 +1082,12 @@ struct Scsi_Host *aha152x_probe_one(stru
 				"aha152x", shost) < 0) {
 		printk(KERN_ERR "aha152x%d: failed to reassign interrupt.\n",
 				shost->host_no);
-		goto out_release_region;
+		goto out_unregister_host;
 	}
-
-	aha152x_host[registered_count] = shost;
 	return shost;	/* the pcmcia stub needs the return value; */
 
+out_unregister_host:
+	aha152x_host[registered_count] = NULL;
 out_release_region:
 	release_region(shost->io_port, IO_RANGE);
 out_unregister:

