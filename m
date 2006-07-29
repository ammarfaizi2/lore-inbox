Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751968AbWG2Ql3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWG2Ql3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWG2Ql3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:41:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751968AbWG2Ql3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:41:29 -0400
Date: Sat, 29 Jul 2006 12:41:15 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via sata oops on init
Message-ID: <20060729164115.GA16946@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060728233950.GD3217@redhat.com> <20060729144528.GD28712@leiferikson.dystopia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729144528.GD28712@leiferikson.dystopia.lan>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 04:45:28PM +0200, Johannes Weiner wrote:

 >  ..
 > ata_device_add fails, calls ata_host_remove with pointers to unitialized
 > memory.

This should do it.  Jeff?

Fix reference of uninitialised memory in ata_device_add()

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/scsi/libata-core.c~	2006-07-29 12:35:32.000000000 -0400
+++ linux-2.6/drivers/scsi/libata-core.c	2006-07-29 12:39:08.000000000 -0400
@@ -5419,10 +5419,10 @@ int ata_device_add(const struct ata_prob
 		unsigned long xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
+		host_set->ports[i] = ap;
 		if (!ap)
 			goto err_out;
 
-		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
@@ -5532,6 +5532,8 @@ int ata_device_add(const struct ata_prob
 
 err_out:
 	for (i = 0; i < count; i++) {
+		if (!host_set->ports[i])
+			break;
 		ata_host_remove(host_set->ports[i], 1);
 		scsi_host_put(host_set->ports[i]->host);
 	}

-- 
http://www.codemonkey.org.uk
