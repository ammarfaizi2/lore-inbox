Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271098AbUJUX1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271098AbUJUX1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271095AbUJUXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:24:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20894 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S271100AbUJUXR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:17:26 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use mmiowb in qla1280.c
Date: Thu, 21 Oct 2004 16:17:14 -0700
User-Agent: KMail/1.7
Cc: linux-scsi@vger.kernel.org, jeremy@sgi.com, jes@sgi.com
References: <200410211613.19601.jbarnes@engr.sgi.com>
In-Reply-To: <200410211613.19601.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6NEeBMBYJqaNBpN"
Message-Id: <200410211617.14809.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6NEeBMBYJqaNBpN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There are a few spots in qla1280.c that don't need a full PCI write flush to 
the device, but rather a simple write ordering guarantee.  This patch changes 
some of the PIO reads that cause write flushes into mmiowb calls instead, 
which is a lighter weight way of ensuring ordering.

Jes and James, can you ack this and/or push it in via the SCSI BK tree?

Thanks,
Jesse

Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Jesse Barnes <jbarnes@sgi.com>



--Boundary-00=_6NEeBMBYJqaNBpN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="qla1280-mmiowb-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="qla1280-mmiowb-4.patch"

===== drivers/scsi/qla1280.c 1.69 vs edited =====
--- 1.69/drivers/scsi/qla1280.c	2004-10-20 06:46:21 -07:00
+++ edited/drivers/scsi/qla1280.c	2004-10-21 16:06:11 -07:00
@@ -3400,7 +3400,8 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
+	mmiowb();
 
  out:
 	if (status)
@@ -3668,7 +3669,8 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
+	mmiowb();
 
 out:
 	if (status)
@@ -3778,9 +3780,21 @@
 	} else
 		ha->request_ring_ptr++;
 
-	/* Set chip new ring index. */
+	/*
+	 * Update request index to mailbox4 (Request Queue In).
+	 * The mmiowb() ensures that this write is ordered with writes by other
+	 * CPUs.  Without the mmiowb(), it is possible for the following:
+	 *    CPUA posts write of index 5 to mailbox4
+	 *    CPUA releases host lock
+	 *    CPUB acquires host lock
+	 *    CPUB posts write of index 6 to mailbox4
+	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
+	 *       causing chip to issue full queue of stale commands
+	 * The mmiowb() prevents future writes from crossing the barrier.
+	 * See Documentation/DocBook/deviceiobook.tmpl for more information.
+	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb();
 
 	LEAVE("qla1280_isp_cmd");
 }

--Boundary-00=_6NEeBMBYJqaNBpN--
