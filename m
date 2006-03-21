Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWCUBxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWCUBxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCUBxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:53:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:21222 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751444AbWCUBxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:53:07 -0500
Message-ID: <441F5C7D.2050600@pobox.com>
Date: Mon, 20 Mar 2006 20:53:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Geoff Rivell <grivell@comcast.net>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI SATA vendor update from VIA
References: <439CF812.8010107@pobox.com> <20060315191736.231a2894.vsu@altlinux.ru>
In-Reply-To: <20060315191736.231a2894.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.3 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> What is needed to get the VT8251 support into the kernel tree?

1) Doing what you are doing:  asking questions like this.  :)

2) Watching Tejun Heo's reset work.  He already has an AHCI soft reset 
patch, and the VIA AHCI work really depends on this.


> I have looked at the patch, and it basically does three things:
> 
> 1) Apparently the VT8251 hardware does not like the standard reset
>    sequence performed by __sata_phy_reset() - the phy seems to become
>    ready, but the ATA_BUSY bit never goes off.  So the patch authors
>    just duplicated ahci_phy_reset(), inserted the whole code of
>    __sata_phy_reset() in there, and added this part before the
>    ata_busy_sleep() call:
> 
> +	/*Fix the VIA busy bug by a software reset*/
> +	for (i = 0; i < 100; i++) {
> +		tmp_status = ap->ops->check_status(ap);
> +		if ((tmp_status & ATA_BUSY) == 0) break;
> +		msleep(10);
> +	}
> +
> +	if ((tmp_status & ATA_BUSY)) {
> +		DPRINTK("Busy after CommReset, do softreset...\n"); 
> +		/*set the PxCMD.CLO bit to clear BUSY and DRQ, to make the reset command sent out*/
> +		tmp = readl(port_mmio + PORT_CMD);
> +		tmp |= PORT_CMD_CLO;
> +		writel(tmp, port_mmio + PORT_CMD);
> +		readl(port_mmio + PORT_CMD); /* flush */
> +
> +		if (via_ahci_softreset(ap)) {
> +			printk(KERN_WARNING "softreset failed\n");
> +			return;
> +		}
> +	}
> 
>    Now, if this is really a chip bug, we don't have any choice except
>    adding this workaround, but obviously not in this way.  What do you
>    think about splitting __sata_phy_reset() in two parts -
>    __sata_phy_reset_start() (everything up to the point where
>    ata_busy_sleep() is called) and __sata_phy_reset_end()
>    (ata_busy_sleep() and the rest), so that the low-level driver could
>    insert its own code between these parts?  Or should a hook for this
>    be added to ->ops instead?

Tejun's stuff broke up this sequence, so it should be much easier to 
utilize his new reset code (in libata-dev.git#upstream, queued for 2.6.17).


> 2) via_ahci_qc_issue really just filters out the SETFEATURES_XFER
>    command; only VIA can tell why this is needed, and is there a better
>    way to do this.  However, at least some duplicated code could be
>    removed easily:
> 
> static int via_ahci_qc_issue(struct ata_queued_cmd *qc)
> {
> 	if (qc && qc->tf.command == ATA_CMD_SET_FEATURES &&
> 	    qc->tf.feature == SETFEATURES_XFER) {
> 		/* skip set xfer mode process */
> 		ata_qc_complete(qc);
> 		return 0;
> 	}
> 	return ahci_qc_issue(qc);
> }
> 
>    Would this be acceptable?

I wonder first if this actually solves some problems.  I would prefer to 
-not- do this, and see what happens.


> 3) What via_ahci_port_stop() does, I just don't understand - it is
>    basically a copy of ahci_port_stop() at that time, but with clearing
>    of the PORT_CMD bits removed - so nothing is stopped actually.
>    Again, only VIA can tell why is this needed, but this part of the
>    patch looks like a bug.

As your instinct seems to be, I would prefer to avoid this change if 
possible.

	Jeff



