Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWCVOuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWCVOuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWCVOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:50:23 -0500
Received: from rtr.ca ([64.26.128.89]:25756 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750743AbWCVOuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:50:22 -0500
From: Mark Lord <lkml@rtr.ca>
To: sander@humilis.net
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Wed, 22 Mar 2006 09:50:11 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius>
In-Reply-To: <20060322090006.GA8462@favonius>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220950.11922.lkml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
>
> The 2.6.16-git3 snapshot is stable for me like -rc6-mm1 and -rc6-mm2
> are :-)
..
> Btw, I do still get these (any kernel), but with no visible effect:
> 
> [ 2306.952183] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
0xb/47/00
> [ 2306.952246] ata6: status=0xd0 { Busy }
> [ 2891.892225] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
0xb/47/00
> [ 2891.892277] ata5: status=0xd0 { Busy }
> [ 4550.013582] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
0xb/47/00
> [ 4550.013637] ata6: status=0xd0 { Busy }
> [ 4864.850340] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
0xb/47/00
> [ 4864.850393] ata9: status=0xd0 { Busy }
> [ 4968.681651] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
0xb/47/00
> [ 4968.681711] ata9: status=0xd0 { Busy }

The 2.6.16-git3 (and -git4) drivers are still missing the latest critical fix
that started this thread.  Could you apply that also, and see if the messages
above go away?

Thanks.

--- sata_mv.c-2.6.16-git4	2006-03-22 09:41:29.000000000 -0500
+++ sata_mv.c	2006-03-22 09:45:42.000000000 -0500
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.6-ml1"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -1263,6 +1263,7 @@
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 	u32 out_ptr;
+	u8 ata_status;
 
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
@@ -1270,6 +1271,8 @@
 	WARN_ON(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
 		pp->rsp_consumer);
 
+	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
 
@@ -1284,7 +1287,7 @@
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
-	return (pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT);
+	return ata_status;
 }
 
 /**
