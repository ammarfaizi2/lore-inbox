Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVHBPoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVHBPoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVHBPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:42:12 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:64330 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261575AbVHBPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:40:48 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.95,162,1120428000"; 
   d="diff'?scan'208"; a="13496492:sNHT47169056"
Message-ID: <42EF93F8.8050601@fujitsu-siemens.com>
Date: Tue, 02 Aug 2005 17:40:40 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
Cc: "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: ahci, SActive flag, and the HD activity LED
Content-Type: multipart/mixed;
 boundary="------------030509070302080501090105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509070302080501090105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jeff, hello Jens, hello everybody,

I am referring to the debate about whether or not setting the SActive 
bit for non-NCQ ATA commands (e.g. http://lkml.org/lkml/2005/5/26/142).

In our machines, this behavior of the Linux AHCI driver causes the HD 
activity LED to stay on all the time. If I apply the attached trivial 
patch (this is for the RedHat EL4.0-U1 kernel), the LED behaves nicely.

Jeff has stated in the above thread that "SActive is intentionally used 
for non-NCQ devices". However I find clear indication in the specs that 
the SActive flag should be set if and only if tagged queuing is being 
used, and only for a specified subset of commands that support queuing 
(http://www.t13.org/docs2005/D1699r1e-ATA8-ACS.pdf, secs. 4.19 and 
4.20). The current mainline driver doesn't use queuing.

If I am reading the specs correctly, that'd mean the ahci driver is 
wrong in setting the SActive bit. Could you please comment? Jeff, in 
particular, could you please give more detail why you say this flag is 
"intentionally used"?

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy


--------------030509070302080501090105
Content-Type: text/x-patch;
 name="ahci_sactive.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci_sactive.diff"

--- ahci.c.orig	2005-06-13 11:39:26.000000000 +0200
+++ ahci.c	2005-08-02 10:48:47.000000000 +0200
@@ -691,9 +703,6 @@
 	struct ata_port *ap = qc->ap;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
-
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 

--------------030509070302080501090105--
