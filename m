Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWFNIgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWFNIgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 04:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFNIgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 04:36:24 -0400
Received: from stats.hypersurf.com ([209.237.0.12]:34317 "EHLO
	stats.hypersurf.com") by vger.kernel.org with ESMTP
	id S1751247AbWFNIgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 04:36:24 -0400
From: HighPoint Linux Team <linux@highpoint-tech.com>
Organization: HighPoint Technologies, Inc.
To: James.Bottomley@SteelEye.com
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Date: Wed, 14 Jun 2006 16:50:57 +0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
References: <200606111706.52930.linux@highpoint-tech.com>
In-Reply-To: <200606111706.52930.linux@highpoint-tech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141650.57740.linux@highpoint-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates:
- don't bypass SYNCHRONIZE_CACHE command
- return SCSI_MLQUEUE_HOST_BUSY when no free request slots
- move scsi_remove_host() to the begin of hpt_remove(), or it will
  not work after resources being released.


Signed-off-by: HighPoint Linux Team <linux@highpoint-tech.com>
---

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 8302f3b..a96751c 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -504,19 +504,10 @@ static int hptiop_queuecommand(struct sc
 	BUG_ON(!done);
 	scp->scsi_done = done;
 
-	/*
-	 * hptiop_shutdown will flash controller cache.
-	 */
-	if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
-		scp->result = DID_OK<<16;
-		goto cmd_done;
-	}
-
 	_req = get_req(hba);
 	if (_req == NULL) {
 		dprintk("hptiop_queuecmd : no free req\n");
-		scp->result = DID_BUS_BUSY << 16;
-		goto cmd_done;
+		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
 	_req->scp = scp;
@@ -1429,6 +1420,8 @@ static void hptiop_remove(struct pci_dev
 
 	dprintk("scsi%d: hptiop_remove\n", hba->host->host_no);
 
+	scsi_remove_host(host);
+
 	spin_lock(&hptiop_hba_list_lock);
 	list_del_init(&hba->link);
 	spin_unlock(&hptiop_hba_list_lock);
@@ -1448,7 +1441,6 @@ static void hptiop_remove(struct pci_dev
 	pci_set_drvdata(hba->pcidev, NULL);
 	pci_disable_device(hba->pcidev);
 
-	scsi_remove_host(host);
 	scsi_host_put(host);
 }
 

