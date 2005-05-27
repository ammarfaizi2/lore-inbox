Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVE0ImV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVE0ImV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVE0ImU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:42:20 -0400
Received: from brick.kernel.dk ([62.242.22.158]:58266 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S262251AbVE0Ilt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:41:49 -0400
Date: Fri, 27 May 2005 10:42:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527084254.GU1435@suse.de>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <4296DA4B.6040303@pobox.com> <20050527083509.GT1435@suse.de> <4296DC75.2020809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296DC75.2020809@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Actually, I didn't look far enough up - ata_scsi_qc_new() already
> >completes the command with QUEUE_FULL if ata_qc_new_init() fails. So
> >there's no bug, but perhaps it would be cleaner to move it to
> >ata_scsi_translate instead?
> 
> Ah, ok.
> 
> Yes, if you are in a cleaning mood, that would be a better location.

Always in a code cleaning mood - here it is against vanilla, I've
integrated it in the ncq stuff as well.

Index: drivers/scsi/libata-scsi.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/libata-scsi.c  (mode:100644)
+++ uncommitted/drivers/scsi/libata-scsi.c  (mode:100644)
@@ -145,9 +145,6 @@
 			qc->sg = &qc->sgent;
 			qc->n_elem = 1;
 		}
-	} else {
-		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
-		done(cmd);
 	}
 
 	return qc;
@@ -670,8 +667,11 @@
 	VPRINTK("ENTER\n");
 
 	qc = ata_scsi_qc_new(ap, dev, cmd, done);
-	if (!qc)
+	if (!qc) {
+		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
+		done(cmd);
 		return;
+	}
 
 	/* data is present; dma-map it */
 	if (cmd->sc_data_direction == DMA_FROM_DEVICE ||

-- 
Jens Axboe

