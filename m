Return-Path: <linux-kernel-owner+w=401wt.eu-S1750899AbXAEXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXAEXrP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXAEXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:47:15 -0500
Received: from mail0.lsil.com ([147.145.40.20]:44701 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbXAEXrO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:47:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] scsi: megaraid_{mm,mbox} init fix for kdump
Date: Fri, 5 Jan 2007 16:47:00 -0700
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82298909B0@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] scsi: megaraid_{mm,mbox} init fix for kdump
Thread-Index: AccxEWzE50tt4lNAR7SgRl0ILJ0KPgAEZcmQ
From: "Patro, Sumant" <Sumant.Patro@lsi.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Cc: <James.Bottomley@SteelEye.com>, <akpm@osdl.org>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Kolli, Neela" <Neela.Kolli@lsi.com>, "Yang, Bo" <Bo.Yang@lsi.com>
X-OriginalArrivalTime: 05 Jan 2007 23:47:01.0768 (UTC) FILETIME=[CBE3F880:01C73123]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

	At this time I am not trying to modify the function comment
style of existing megaraid_mbox code. For the new function the
description style is in sync with the preexisting code.
	So, I request for the patch to be accepted in its current
submitted form. 

Regards,

Sumant 

-----Original Message-----
From: Randy Dunlap [mailto:randy.dunlap@oracle.com] 
Sent: Friday, January 05, 2007 1:35 PM
To: Patro, Sumant
Cc: James.Bottomley@SteelEye.com; akpm@osdl.org;
linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Kolli, Neela;
Yang, Bo; Patro, Sumant
Subject: Re: [PATCH] scsi: megaraid_{mm,mbox} init fix for kdump

On Fri, 05 Jan 2007 07:10:09 -0800 Sumant Patro wrote:

Hi,

> ---
> 
>  Documentation/scsi/ChangeLog.megaraid |   16 ++
>  drivers/scsi/megaraid/megaraid_mbox.c |  140 +++++++++++++++++++-----
>  drivers/scsi/megaraid/megaraid_mbox.h |    4
>  3 files changed, 130 insertions(+), 30 deletions(-)
> 
> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c
linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c
2006-12-28 09:56:04.000000000 -0800
> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
2007-01-04 11:22:21.000000000 -0800
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
> + * Clears the pending cmds in FW and reinits its RAID structs  */ 
> +static int megaraid_mbox_fire_sync_cmd(adapter_t *adapter) {
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
>   * megaraid_mbox_display_scb - display SCB information, mostly debug
purposes
>   * @param adapter	: controllers' soft state
>   * @param scb  : SCB to be displayed

I haven't looked at the entire source file, but these extra "param"
words should not be there.  kernel-doc syntax is just
  @name: description


---
~Randy
