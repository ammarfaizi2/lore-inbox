Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVBRUEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVBRUEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVBRUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:04:04 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:25094 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261468AbVBRUDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:03:45 -0500
Date: Fri, 18 Feb 2005 15:03:37 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch libata-dev-2.6 3/5] libata: filter SET_FEATURES - XFER MODE from ATA pass thru
Message-ID: <20050218200337.GD3197@tuxdriver.com>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20050218195027.GB3197@tuxdriver.com> <20050218195512.GC3197@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218195512.GC3197@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filter-out attempts to issue a SET_FEATURES - XFER MODE command
via the ATA pass thru mechanism.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-scsi.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

--- sata-smart-2.6/drivers/scsi/libata-scsi.c.filter	2005-02-17 16:49:51.362715273 -0500
+++ sata-smart-2.6/drivers/scsi/libata-scsi.c	2005-02-17 16:50:03.907040725 -0500
@@ -1764,6 +1764,17 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	}
 
 	/*
+	 * Filter SET_FEATURES - XFER MODE command -- otherwise,
+	 * SET_FEATURES - XFER MODE must be preceded/succeeded
+	 * by an update to hardware-specific registers for each
+	 * controller (i.e. the reason for ->set_piomode(),
+	 * ->set_dmamode(), and ->post_set_mode() hooks).
+	 */
+	if ((tf->command == ATA_CMD_SET_FEATURES)
+	 && (tf->feature == SETFEATURES_XFER))
+		return 1;
+
+	/*
 	 * Set flags so that all registers will be written,
 	 * and pass on write indication (used for PIO/DMA
 	 * setup.)
-- 
John W. Linville
linville@tuxdriver.com
