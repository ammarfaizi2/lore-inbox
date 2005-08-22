Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVHVW5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVHVW5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHVW5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:57:12 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9614 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932178AbVHVW44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:56 -0400
Message-ID: <430955FC.9080106@pobox.com>
Date: Mon, 22 Aug 2005 00:35:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       Jens Axboe <axboe@suse.de>
CC: Adam Goode <adam@evdebs.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: [PATCH] Fix HD activity LED with ahci
References: <42EF93F8.8050601@fujitsu-siemens.com>	 <20050802163519.GB3710@suse.de>  <42F05359.7030006@fujitsu-siemens.com> <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu> <42F1BE18.9000105@fujitsu-siemens.com>
In-Reply-To: <42F1BE18.9000105@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> All right,
> 
> this looks like a pretty broad agreement on this issue.
> Jeff, would you please apply this patch?
> 
> Regards,
> Martin
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Patch: fix wrong HD activity control by ahci driver
> Signed-off-by: Martin.Wilck@fujitsu-siemens.com
> 
> The ahci driver 1.0 sets the SActive bit on every transaction,
> causing the LED to light up. The SActive bit is used only for
> native command queuing (NCQ) which the current driver version 
> doesn't implement. Resetting the SActive bit is the device's 
> responsibility (by sending a "Set Device Bits FIS" to the
> host adapter) but this is not required in response to 
> non-NCQ commands, and (most) devices don't. Thus the LED 
> stays always on. This patch fixes the LED behavior.
> 
> Spec references:
> http://www.intel.com/technology/serialata/pdf/rev1_1.pdf, sec. 3.3.13, 5.5.1
> http://www.serialata.org/docs/serialata10a.pdf
> http://www.intel.com/design/storage/papers/25266401.pdf
> 
> --- linux-2.6.13-rc5/drivers/scsi/ahci.c.orig	2005-08-04 08:14:44.000000000 +0200
> +++ linux-2.6.13-rc5/drivers/scsi/ahci.c	2005-08-04 08:19:06.000000000 +0200
> @@ -696,9 +696,6 @@ static int ahci_qc_issue(struct ata_queu
>  	struct ata_port *ap = qc->ap;
>  	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
>  
> -	writel(1, port_mmio + PORT_SCR_ACT);
> -	readl(port_mmio + PORT_SCR_ACT);	/* flush */
> -
>  	writel(1, port_mmio + PORT_CMD_ISSUE);
>  	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */

To answer the question everybody was asking, this line was in the code 
because it was in the patch that got AHCI working.

I'm inclined to apply the above patch, but I'll wait until 2.6.13, so 
that we can get some decent testing.

	Jeff


