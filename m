Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUI3HQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUI3HQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUI3HQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:16:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60895 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269030AbUI3HQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:16:10 -0400
Date: Thu, 30 Sep 2004 00:15:41 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, gnb@sgi.com
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20040930071541.GA201816@sgi.com>
References: <200409271103.39913.jbarnes@engr.sgi.com> <200409291555.29138.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409291555.29138.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the qla1280 patch to go with Jesse's mmiowb patch.
Comments are verbose to satisfy a request from Mr. Bottomley.

signed-off-by: Jeremy Higdon  <jeremy@sgi.com>

===== drivers/scsi/qla1280.c 1.65 vs edited =====
--- 1.65/drivers/scsi/qla1280.c	2004-07-28 20:59:10 -07:00
+++ edited/drivers/scsi/qla1280.c	2004-09-29 23:43:30 -07:00
@@ -3397,8 +3397,22 @@
 		"qla1280_64bit_start_scsi: Wakeup RISC for pending command\n");
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
+
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
 
  out:
 	if (status)
@@ -3665,8 +3679,22 @@
 		"for pending command\n");
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
+
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
 
 out:
 	if (status)
@@ -3776,9 +3804,21 @@
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
