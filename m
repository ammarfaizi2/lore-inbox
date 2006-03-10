Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCJWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCJWYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbWCJWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:24:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8452 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752075AbWCJWYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:24:10 -0500
Date: Fri, 10 Mar 2006 23:24:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/NCR_D700.c: fix a NULL dereference
Message-ID: <20060310222408.GV21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this NULL dereference.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/scsi/NCR_D700.c.old	2006-03-10 20:25:29.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/scsi/NCR_D700.c	2006-03-10 20:25:45.000000000 +0100
@@ -206,31 +206,31 @@ NCR_D700_probe_one(struct NCR_D700_priva
 	if (!host) {
 		ret = -ENOMEM;
 		goto detect_failed;
 	}
 
 	p->hosts[siop] = host;
 	/* FIXME: read this from SUS */
 	host->this_id = id_array[slot * 2 + siop];
 	host->irq = irq;
 	host->base = region;
 	scsi_scan_host(host);
 
 	return 0;
 
  detect_failed:
-	release_region(host->base, 64);
+	release_region(region, 64);
  region_failed:
 	kfree(hostdata);
 
 	return ret;
 }
 
 static int
 NCR_D700_intr(int irq, void *data, struct pt_regs *regs)
 {
 	struct NCR_D700_private *p = (struct NCR_D700_private *)data;
 	int i, found = 0;
 
 	for (i = 0; i < 2; i++)
 		if (p->hosts[i] &&
 		    NCR_700_intr(irq, p->hosts[i], regs) == IRQ_HANDLED)

