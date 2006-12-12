Return-Path: <linux-kernel-owner+w=401wt.eu-S932422AbWLLTzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWLLTzA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWLLTzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:55:00 -0500
Received: from palrel13.hp.com ([156.153.255.238]:57390 "EHLO palrel13.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416AbWLLTy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:54:59 -0500
Date: Tue, 12 Dec 2006 13:54:58 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] cciss: remove calls to pci_disable_device
Message-ID: <20061212195458.GB2471@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 2/2

This patch removes calls to pci_disable_device except in fail_all_cmds. The pci_disable_device function does something nasty to Smart Array controllers that pci_enable_device does not undo. So if the driver is unloaded it cannot be reloaded.
Also, customers can disable any pci device via the ROM Based Setup Utility (RBSU). If the customer has disabled the controller we should not try to blindly enable the card from the driver.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 drivers/block/cciss.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)
--------------------------------------------------------------------------------
diff -puN drivers/block/cciss.c~cciss_remove_pci_disable_device drivers/block/cciss.c
--- linux-2.6-work/drivers/block/cciss.c~cciss_remove_pci_disable_device	2006-12-11 15:28:37.000000000 -0600
+++ linux-2.6-work-mikem/drivers/block/cciss.c	2006-12-11 15:29:52.000000000 -0600
@@ -3006,10 +3006,8 @@ static int cciss_pci_init(ctlr_info_t *c
 
       err_out_free_res:
 	pci_release_regions(pdev);
-
-      err_out_disable_pdev:
-	pci_disable_device(pdev);
 	return err;
+
 }
 
 /*
@@ -3383,7 +3381,6 @@ static int __devinit cciss_init_one(stru
 			blk_cleanup_queue(drv->queue);
 	}
 	pci_release_regions(pdev);
-	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_hba(i);
 	return -1;
@@ -3453,7 +3450,6 @@ static void __devexit cciss_remove_one(s
 	kfree(hba[i]->scsi_rejects.complete);
 #endif
 	pci_release_regions(pdev);
-	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_hba(i);
 }
_
