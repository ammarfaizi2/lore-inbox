Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUIMV2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUIMV2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIMV2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:28:25 -0400
Received: from ms-smtp-02-qfe0.socal.rr.com ([66.75.162.134]:10965 "EHLO
	ms-smtp-02-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S268972AbUIMV1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:27:33 -0400
Date: Mon, 13 Sep 2004 14:24:13 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 qlogic oops
Message-ID: <20040913212413.GA22149@praka.san.rr.com>
Mail-Followup-To: Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1095100546.3628.162.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1095100546.3628.162.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.9-rc1-mm2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, 13 Sep 2004, Badari Pulavarty wrote:

> 
> I get this Oops with qlogic 2200 FC controllers with 2.6.9-rc1-mm5.
> Is this a known issue ? Any fixes ?
> 

Hmm, there seems to be some merging problems in changeset 1.44 for
qla_os.c -- the 'DMA pool/api usage' patch I sent is not completely
integrated (appears to be massaging problems while attempting to apply
on top off 1.43).

Please apply the attached patch which should address the issue.

Regards,
Andrew Vasquez

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dma_fixups.diff"

===== drivers/scsi/qla2xxx/qla_os.c 1.46 vs edited =====
--- 1.46/drivers/scsi/qla2xxx/qla_os.c	2004-09-06 12:07:52 -07:00
+++ edited/drivers/scsi/qla2xxx/qla_os.c	2004-09-13 14:07:23 -07:00
@@ -2892,6 +2892,19 @@
 			continue;
 		}
 
+		/* get consistent memory allocated for init control block */
+		ha->init_cb = dma_pool_alloc(ha->s_dma_pool, GFP_KERNEL,
+		    &ha->init_cb_dma);
+		if (ha->init_cb == NULL) {
+			qla_printk(KERN_WARNING, ha,
+			    "Memory Allocation failed - init_cb\n");
+
+			qla2x00_mem_free(ha);
+			msleep(100);
+
+			continue;
+		}
+		memset(ha->init_cb, 0, sizeof(init_cb_t));
 
 		/* Get consistent memory allocated for Get Port Database cmd */
 		ha->iodesc_pd = dma_pool_alloc(ha->s_dma_pool, GFP_KERNEL,
@@ -2982,21 +2995,6 @@
 			}
 			memset(ha->ct_sns, 0, sizeof(struct ct_sns_pkt));
 		}
-
-		/* Get consistent memory allocated for Get Port Database cmd */
-		ha->iodesc_pd = pci_alloc_consistent(ha->pdev,
-		    PORT_DATABASE_SIZE, &ha->iodesc_pd_dma);
-		if (ha->iodesc_pd == NULL) {
-			/* error */
-			qla_printk(KERN_WARNING, ha,
-			    "Memory Allocation failed - iodesc_pd\n");
-
-			qla2x00_mem_free(ha);
-			msleep(100);
-
-			continue;
-		}
-		memset(ha->iodesc_pd, 0, PORT_DATABASE_SIZE);
 
 		/* Done all allocations without any error. */
 		status = 0;

--Kj7319i9nmIyA2yE--
