Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVHDHFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVHDHFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVHDHFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:05:06 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:44849 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261849AbVHDHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:05:03 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.95,166,1120428000"; 
   d="diff'?scan'208"; a="12120083:sNHT55468324"
Message-ID: <42F1BE18.9000105@fujitsu-siemens.com>
Date: Thu, 04 Aug 2005 09:04:56 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adam Goode <adam@evdebs.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: [PATCH] Fix HD activity LED with ahci
References: <42EF93F8.8050601@fujitsu-siemens.com>	 <20050802163519.GB3710@suse.de>  <42F05359.7030006@fujitsu-siemens.com> <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu>
In-Reply-To: <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu>
Content-Type: multipart/mixed;
 boundary="------------060001050205090301000602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001050205090301000602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All right,

this looks like a pretty broad agreement on this issue.
Jeff, would you please apply this patch?

Regards,
Martin



--------------060001050205090301000602
Content-Type: text/x-patch;
 name="ahci_sactive.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci_sactive.diff"

Patch: fix wrong HD activity control by ahci driver
Signed-off-by: Martin.Wilck@fujitsu-siemens.com

The ahci driver 1.0 sets the SActive bit on every transaction,
causing the LED to light up. The SActive bit is used only for
native command queuing (NCQ) which the current driver version 
doesn't implement. Resetting the SActive bit is the device's 
responsibility (by sending a "Set Device Bits FIS" to the
host adapter) but this is not required in response to 
non-NCQ commands, and (most) devices don't. Thus the LED 
stays always on. This patch fixes the LED behavior.

Spec references:
http://www.intel.com/technology/serialata/pdf/rev1_1.pdf, sec. 3.3.13, 5.5.1
http://www.serialata.org/docs/serialata10a.pdf
http://www.intel.com/design/storage/papers/25266401.pdf

--- linux-2.6.13-rc5/drivers/scsi/ahci.c.orig	2005-08-04 08:14:44.000000000 +0200
+++ linux-2.6.13-rc5/drivers/scsi/ahci.c	2005-08-04 08:19:06.000000000 +0200
@@ -696,9 +696,6 @@ static int ahci_qc_issue(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
-
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 

--------------060001050205090301000602--
