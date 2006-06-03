Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWFCLHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWFCLHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWFCLHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:07:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30351 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932605AbWFCLHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:07:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 3 Jun 2006 13:05:12 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/2] sbp2: fix deregistration of status fifo address space
To: linux1394-devel@lists.sourceforge.net
cc: Andreas Schwab <schwab@suse.de>, scjody@modernduck.com,
       bcollins@ubuntu.com, mjt@tls.msk.ru, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060603024305.dd0404d0.akpm@osdl.org>
Message-ID: <tkrat.3b83a79240807095@s5r6.in-berlin.de>
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
 <20060603013515.GV18769@moss.sous-sol.org>
 <44814A63.1080707@s5r6.in-berlin.de> <44815283.7080306@tls.msk.ru>
 <jemzcu7fgw.fsf@sykes.suse.de> <20060603024305.dd0404d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.364) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The proper designator of an invalid CSR address is ~(u64)0, not (u64)0.
Use the correct value in initialization and deregistration.
Also, scsi_id->sbp2_lun does not need to be initialized twice.
(scsi_id was kzalloc'd.)

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-06-03 02:13:18.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-06-03 11:49:18.000000000 +0200
@@ -794,12 +794,12 @@ static struct scsi_id_instance_data *sbp
 	scsi_id->ud = ud;
 	scsi_id->speed_code = IEEE1394_SPEED_100;
 	scsi_id->max_payload_size = sbp2_speedto_max_payload[IEEE1394_SPEED_100];
+	scsi_id->status_fifo_addr = ~0ULL;
 	atomic_set(&scsi_id->sbp2_login_complete, 0);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_inuse);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_completed);
 	INIT_LIST_HEAD(&scsi_id->scsi_list);
 	spin_lock_init(&scsi_id->sbp2_command_orb_lock);
-	scsi_id->sbp2_lun = 0;
 
 	ud->device.driver_data = scsi_id;
 
@@ -1090,7 +1090,7 @@ static void sbp2_remove_device(struct sc
 		SBP2_DMA_FREE("single query logins data");
 	}
 
-	if (scsi_id->status_fifo_addr)
+	if (scsi_id->status_fifo_addr != ~0ULL)
 		hpsb_unregister_addrspace(&sbp2_highlevel, hi->host,
 			scsi_id->status_fifo_addr);
 


