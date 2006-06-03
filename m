Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWFCACs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWFCACs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWFCACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:02:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60637 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751557AbWFCACr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:02:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 3 Jun 2006 02:00:33 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] sbp2: fix check of return value of
 hpsb_allocate_and_register_addrspace
To: Linus Torvalds <torvalds@osdl.org>, stable@kernel.org
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
Message-ID: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.266) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added a failure check in patch "sbp2: variable status FIFO address
(fix login timeout)" --- alas for a wrong error value.  This is a bug
since Linux 2.6.16.  Leads to NULL pointer dereference if the call
failed, and bogus failure handling if call succeeded.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
applies to 2.6.17-rc5
applies to 2.6.16.x after patch ''ohci1394, sbp2: fix "scsi_add_device
failed" with PL-3507 based devices''

Index: linux-2.6.17-rc5/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/ieee1394/sbp2.c	2006-06-03 01:52:54.000000000 +0200
+++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c	2006-06-03 01:54:23.000000000 +0200
@@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
 			0x010000000000ULL, CSR1212_ALL_SPACE_END);
-	if (!scsi_id->status_fifo_addr) {
+	if (scsi_id->status_fifo_addr == ~0ULL) {
 		SBP2_ERR("failed to allocate status FIFO address range");
 		goto failed_alloc;
 	}


