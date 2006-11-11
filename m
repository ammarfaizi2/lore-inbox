Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424473AbWKKA71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424473AbWKKA71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424471AbWKKA71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:59:27 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:3740 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1424469AbWKKA70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:59:26 -0500
Message-ID: <4555206C.8010909@us.ibm.com>
Date: Fri, 10 Nov 2006 16:59:24 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] aic94xx: Don't call pci_map_sg for already-mapped scatterlists
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
I don't have any SATAPI devices to test with.  Is this the correct
approach to fixing this problem?

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 9840708..eaffaa6 100644
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
index 8f8cd40..04115c3 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -167,6 +167,7 @@ static unsigned int sas_ata_qc_issue(str
 		task->num_scatter = num;
 	}
 
+	task->external_sg = 1;
 	task->data_dir = qc->dma_dir;
 	task->scatter = qc->__sg;
 	task->ata_task.retry_count = 1;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 1263bd5..25a1fb3 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -546,6 +546,7 @@ struct sas_task {
 	void   *uldd_task;
 
 	struct work_struct abort_work;
+	int    external_sg;
 };
 
 
