Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWCKDsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWCKDsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWCKDsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:48:00 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:12271 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932395AbWCKDr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:47:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lvRe0dBP8ZJoIIrIFZxyc6WwZQmg0T/TvAM/6oKng7rn1XwgOcNxt4xINFdvdAicWUCYTd/ab7jhaH4NDvBSH1hvlwFFsT/F9A7ULcIDaDQjHFrsfLMqaAgf4lyx9hq/WFS3dYkKZMwnMfrLMqwG2bk1toql8grsF9CkGE3RwMc=
Date: Sat, 11 Mar 2006 12:47:54 +0900
From: Tejun Heo <htejun@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: fix NULL pointer dereference detected by Coverity
Message-ID: <20060311034754.GA31198@htj.dyndns.org>
References: <20060310193414.GT21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310193414.GT21864@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference detected by the Coverity checker.  Kill
dev -> pdev -> dev conversion while at it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>

--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -778,23 +778,17 @@ static irqreturn_t ahci_interrupt (int i
 			struct ata_queued_cmd *qc;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (!ahci_host_intr(ap, qc))
-				if (ata_ratelimit()) {
-					struct pci_dev *pdev =
-						to_pci_dev(ap->host_set->dev);
-					dev_printk(KERN_WARNING, &pdev->dev,
+				if (ata_ratelimit())
+					dev_printk(KERN_WARNING, host_set->dev,
 					  "unhandled interrupt on port %u\n",
 					  i);
-				}
 
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
-			if (ata_ratelimit()) {
-				struct pci_dev *pdev =
-					to_pci_dev(ap->host_set->dev);
-				dev_printk(KERN_WARNING, &pdev->dev,
+			if (ata_ratelimit())
+				dev_printk(KERN_WARNING, host_set->dev,
 					"interrupt on disabled port %u\n", i);
-			}
 		}
 
 		irq_ack |= (1 << i);
