Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXAEVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAEVfu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXAEVft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:35:49 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:53608 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAEVfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:35:48 -0500
Date: Fri, 5 Jan 2007 13:34:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Sumant Patro <sumantp@lsil.com>
Cc: James.Bottomley@SteelEye.com, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, neela.kolli@lsi.com, bo.yang@lsi.com,
       sumant.patro@lsi.com
Subject: Re: [PATCH] scsi: megaraid_{mm,mbox} init fix for kdump
Message-Id: <20070105133430.07a338e4.randy.dunlap@oracle.com>
In-Reply-To: <1168009809.4188.10.camel@dumbo>
References: <1168009809.4188.10.camel@dumbo>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jan 2007 07:10:09 -0800 Sumant Patro wrote:

Hi,

> ---
> 
>  Documentation/scsi/ChangeLog.megaraid |   16 ++
>  drivers/scsi/megaraid/megaraid_mbox.c |  140 +++++++++++++++++++-----
>  drivers/scsi/megaraid/megaraid_mbox.h |    4
>  3 files changed, 130 insertions(+), 30 deletions(-)
> 
> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c	2006-12-28 09:56:04.000000000 -0800
> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c	2007-01-04 11:22:21.000000000 -0800
> @@ -3380,6 +3386,84 @@ megaraid_mbox_flush_cache(adapter_t *ada
>  
>  
>  /**
> + * megaraid_mbox_fire_sync_cmd - fire the sync cmd
> + * @param adapter	: soft state for the controller

That (above) should just be:
 * @adapter:  (plus its description; the description there
   doesn't seem to agree with its parameter name).


> + *
> + * Clears the pending cmds in FW and reinits its RAID structs
> + */
> +static int
> +megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
> +{
> +	mbox_t	*mbox;
> +	uint8_t	raw_mbox[sizeof(mbox_t)];
> +	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
> +	mbox64_t *mbox64;
> +	int	status = 0;
> +	int i;
> +	uint32_t dword;
> +
> +	mbox = (mbox_t *)raw_mbox;
> +
> +	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));
> +
> +	raw_mbox[0] = 0xFF;
> +
> +	mbox64	= raid_dev->mbox64;
> +	mbox	= raid_dev->mbox;
> +
> +	/* Wait until mailbox is free */
> +	if (megaraid_busywait_mbox(raid_dev) != 0) {
> +		status = 1;
> +		goto blocked_mailbox;
> +	}
> +
> +	/* Copy mailbox data into host structure */
> +	memcpy((caddr_t)mbox, (caddr_t)raw_mbox, 16);
> +	mbox->cmdid		= 0xFE;
> +	mbox->busy		= 1;
> +	mbox->poll		= 0;
> +	mbox->ack		= 0;
> +	mbox->numstatus		= 0;
> +	mbox->status		= 0;
> +
> +	wmb();
> +	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
> +
> +	/* Wait for maximum 1 min for status to post.
> +	 * If the Firmware SUPPORTS the ABOVE COMMAND,
> +	 * mbox->cmd will be set to 0
> +	 * else
> +	 * the firmware will reject the command with
> +	 * mbox->numstatus set to 1
> +	 */
> +
> +	i = 0;
> +	status = 0;
> +	while (!mbox->numstatus && mbox->cmd == 0xFF) {
> +		rmb();
> +		msleep(1);
> +		i++;
> +		if (i > 1000 * 60) {
> +			status = 1;
> +			break;
> +		}
> +	}
> +	if (mbox->numstatus == 1)
> +		status = 1; /*cmd not supported*/
> +
> +	/* Check for interrupt line */
> +	dword = RDOUTDOOR(raid_dev);
> +	WROUTDOOR(raid_dev, dword);
> +	WRINDOOR(raid_dev,2);
> +
> +	return status;
> +
> +blocked_mailbox:
> +	con_log(CL_ANN, (KERN_WARNING "megaraid: blocked mailbox\n"));
> +	return status;
> +}
> +
> +/**
>   * megaraid_mbox_display_scb - display SCB information, mostly debug purposes
>   * @param adapter	: controllers' soft state
>   * @param scb  : SCB to be displayed

I haven't looked at the entire source file, but these extra
"param" words should not be there.  kernel-doc syntax is just
  @name: description


---
~Randy
