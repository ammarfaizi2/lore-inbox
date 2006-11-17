Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755921AbWKQVDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbWKQVDa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755918AbWKQVD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:03:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:50144 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755906AbWKQVBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:51 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 10/15] aic94xx: Don't call pci_map_sg for already-mapped scatterlists
Date: Fri, 17 Nov 2006 13:08:17 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210817.17052.27478.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It turns out that libata has already dma_map_sg'd the scatterlist
entries that go with an ata_queued_cmd by the time it calls
sas_ata_qc_issue.  sas_ata_qc_issue passes this scatterlist to aic94xx. 
Unfortunately, aic94xx assumes that any scatterlist passed to it needs
to be pci_map_sg'd... which blows away the mapping that libata created! 
This causes (on a x260) Calgary IOMMU table leaks and duplicate frees
when aic94xx and libata try to {pci,dma}_unmap_sg the scatterlist. 

Since dma_map_sg and pci_map_sg are fed the same struct device, I think
it's safe to add a flag to sas_task that tells aic94xx that it need
not map the scatterlist.  It didn't break anything on the x260, though
I don't have any SATAPI devices handy for testing.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/aic94xx/aic94xx_task.c |   17 +++++++++++------
 drivers/scsi/libsas/sas_ata.c       |    1 +
 include/scsi/libsas.h               |    1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 466b492..f801c64 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -74,8 +74,11 @@ static inline int asd_map_scatterlist(st
 		return 0;
 	}
 
-	num_sg = pci_map_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-			    task->data_dir);
+	if (task->external_sg)
+		num_sg = task->num_scatter;
+	else
+		num_sg = pci_map_sg(asd_ha->pcidev, task->scatter,
+				    task->num_scatter, task->data_dir);
 	if (num_sg == 0)
 		return -ENOMEM;
 
@@ -120,8 +123,9 @@ static inline int asd_map_scatterlist(st
 
 	return 0;
 err_unmap:
-	pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-		     task->data_dir);
+	if (!task->external_sg)
+		pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
+			     task->data_dir);
 	return res;
 }
 
@@ -142,8 +146,9 @@ static inline void asd_unmap_scatterlist
 	}
 
 	asd_free_coherent(asd_ha, ascb->sg_arr);
-	pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-		     task->data_dir);
+	if (!task->external_sg)
+		pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
+			     task->data_dir);
 }
 
 /* ---------- Task complete tasklet ---------- */
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 209f402..77860ab 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -169,6 +169,7 @@ static unsigned int sas_ata_qc_issue(str
 		task->num_scatter = num;
 	}
 
+	task->external_sg = 1;
 	task->data_dir = qc->dma_dir;
 	task->scatter = qc->__sg;
 	task->ata_task.retry_count = 1;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index a06cbde..7dcf593 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -538,6 +538,7 @@ struct sas_task {
 	void   *uldd_task;
 
 	struct work_struct abort_work;
+	int    external_sg;
 };
 
 
