Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTGKRqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTGKRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:46:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264569AbTGKRpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:45:55 -0400
Date: Fri, 11 Jul 2003 10:53:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: schmurtz@netcourrier.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Linux 2.5.75 - still can't load aha152x (isapnp) => OOPS
Message-Id: <20030711105358.00b125f0.akpm@osdl.org>
In-Reply-To: <wazza.87y8z5xre4.fsf@message.id>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
	<wazza.87y8z5xre4.fsf@message.id>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schmurtz@netcourrier.com wrote:
>
> I'm still getting oops when loading aha152x..

Does this fix it?

(This patch is also in the linux-scsi tree.  James, is a merge planned
soon?)




From: Martin Diehl <lists@mdiehl.de>

Seems there are two problems:

* interrupt handler expects to find the host in aha152x_host[] array which
  is currently set too late after probing irq's

* despite testing for NULL swintr derefences a shpnt==NULL anyway, looks 
  like a victim of HOSTNO obfuscation ;-)

The patch below fixes the issue for me - succesfully tested to compile, 
load and even use my attached scanner.



 drivers/scsi/aha152x.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff -puN drivers/scsi/aha152x.c~aha152x-oops-fix drivers/scsi/aha152x.c
--- 25/drivers/scsi/aha152x.c~aha152x-oops-fix	2003-06-26 18:38:55.000000000 -0700
+++ 25-akpm/drivers/scsi/aha152x.c	2003-06-26 18:38:55.000000000 -0700
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

_

