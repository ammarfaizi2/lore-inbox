Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUB1TLH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 14:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUB1TLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 14:11:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38302 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261901AbUB1TK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 14:10:57 -0500
Message-ID: <4040E7B5.4020709@pobox.com>
Date: Sat, 28 Feb 2004 14:10:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH/RFT] libata "DMA timeout" fix
Content-Type: multipart/mixed;
 boundary="------------070400050706040108030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070400050706040108030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The desired effect of a DMA timeout should be to throw an I/O error, but 
that doesn't appear to be happening.

Those seeing DMA timeout messages, please test this patch.

Kernel hacker note:  James B recommended that I implement my own 
scsi_done() function, which duplicates the real scsi_done() but omits 
the scsi_delete_timer() call.  This is probably the best long term fix, 
but doing so involves exporting several currently-private bits of SCSI 
mid-layer, which I would rather not do.  Probably best to create a 
__scsi_done() inside the SCSI mid-layer, and call that.

	Jeff, the only user of ->eh_strategy_handler() in any kernel




--------------070400050706040108030905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.19 vs edited =====
--- 1.19/drivers/scsi/libata-core.c	Wed Feb 25 22:41:13 2004
+++ edited/drivers/scsi/libata-core.c	Sat Feb 28 14:03:18 2004
@@ -2130,6 +2130,14 @@
 				cmd->result = SAM_STAT_CHECK_CONDITION;
 			else
 				ata_to_sense_error(qc);
+
+			/* hack alert! we need this to get past the
+			 * first check in scsi_done().  libata is the
+			 * -only- user of ->eh_strategy_handler() in
+			 * any kernel tree, which exposes some incorrect
+			 * assumptions in the SCSI layer.
+			 */
+			scsi_add_timer(cmd, 2000 * HZ, NULL);
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}

--------------070400050706040108030905--

