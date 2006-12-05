Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968456AbWLERDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968456AbWLERDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968463AbWLERDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:03:05 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:54754 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968456AbWLERDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:03:02 -0500
Subject: Re: [PATCH] aic94xx: Don't call pci_map_sg for already-mapped
	scatterlists
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
In-Reply-To: <4555206C.8010909@us.ibm.com>
References: <4555206C.8010909@us.ibm.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 11:01:31 -0600
Message-Id: <1165338091.2785.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 16:59 -0800, Darrick J. Wong wrote:
> It turns out that libata has already dma_map_sg'd the scatterlist
> entries that go with an ata_queued_cmd by the time it calls
> sas_ata_qc_issue.  sas_ata_qc_issue passes this scatterlist to aic94xx. 
> Unfortunately, aic94xx assumes that any scatterlist passed to it needs
> to be pci_map_sg'd... which blows away the mapping that libata created! 
> This causes (on a x260) Calgary IOMMU table leaks and duplicate frees
> when aic94xx and libata try to {pci,dma}_unmap_sg the scatterlist. 
> 
> Since dma_map_sg and pci_map_sg are fed the same struct device, I think
> it's safe to add a flag to sas_task that tells aic94xx that it need
> not map the scatterlist.  It didn't break anything on the x260, though
> I don't have any SATAPI devices to test with.  Is this the correct
> approach to fixing this problem?

Rather than introduce an extra flag, I think we can key of the protocol
flag:  libata is the only thing that initiates STP tasks.  How does this
look?

James

Index: BUILD-2.6/drivers/scsi/aic94xx/aic94xx_task.c
===================================================================
--- BUILD-2.6.orig/drivers/scsi/aic94xx/aic94xx_task.c	2006-12-03 17:57:27.000000000 -0600
+++ BUILD-2.6/drivers/scsi/aic94xx/aic94xx_task.c	2006-12-05 10:43:01.000000000 -0600
@@ -74,8 +74,13 @@ static inline int asd_map_scatterlist(st
 		return 0;
 	}
 
-	num_sg = pci_map_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-			    task->data_dir);
+	/* STP tasks come from libata which has already mapped
+	 * the SG list */
+	if (task->task_proto == SAS_PROTOCOL_STP)
+		num_sg = task->num_scatter;
+	else
+		num_sg = pci_map_sg(asd_ha->pcidev, task->scatter,
+				    task->num_scatter, task->data_dir);
 	if (num_sg == 0)
 		return -ENOMEM;
 
@@ -120,8 +125,9 @@ static inline int asd_map_scatterlist(st
 
 	return 0;
 err_unmap:
-	pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-		     task->data_dir);
+	if (task->task_proto != SAS_PROTOCOL_STP)
+		pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
+			     task->data_dir);
 	return res;
 }
 
@@ -142,8 +148,9 @@ static inline void asd_unmap_scatterlist
 	}
 
 	asd_free_coherent(asd_ha, ascb->sg_arr);
-	pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
-		     task->data_dir);
+	if (task->task_proto != SAS_PROTOCOL_STP)
+		pci_unmap_sg(asd_ha->pcidev, task->scatter, task->num_scatter,
+			     task->data_dir);
 }
 
 /* ---------- Task complete tasklet ---------- */


