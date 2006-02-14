Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWBNUfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWBNUfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBNUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:35:38 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:23312 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932376AbWBNUfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:35:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <s5hzmktaecj.wl%tiwai@suse.de>
X-OriginalArrivalTime: 14 Feb 2006 20:35:29.0781 (UTC) FILETIME=[31E12A50:01C631A6]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Add cast to __iomem pointer in scsi drivers
Date: Tue, 14 Feb 2006 15:35:29 -0500
Message-ID: <Pine.LNX.4.61.0602141530420.32364@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add cast to __iomem pointer in scsi drivers
thread-index: AcYxpjHoGZxYhPneTcCm135B006uxw==
References: <s5hzmktaecj.wl%tiwai@suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2006, Takashi Iwai wrote:

> Add the missing cast to __iomem pointer in some scsi drivers.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> ---
> drivers/scsi/megaraid.c |    8 ++++----
> drivers/scsi/sata_svw.c |   41 +++++++++++++++++++++++------------------
> drivers/scsi/sata_vsc.c |   43 ++++++++++++++++++++++++-------------------
> 3 files changed, 51 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
> index d101a8a..13c9395 100644
> --- a/drivers/scsi/megaraid.c
> +++ b/drivers/scsi/megaraid.c
> @@ -72,10 +72,10 @@ static unsigned short int max_mbox_busy_
> module_param(max_mbox_busy_wait, ushort, 0);
> MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
>
> -#define RDINDOOR(adapter)		readl((adapter)->base + 0x20)
> -#define RDOUTDOOR(adapter)		readl((adapter)->base + 0x2C)
> -#define WRINDOOR(adapter,value)		writel(value, (adapter)->base + 0x20)
> -#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
> +#define RDINDOOR(adapter)		readl((void __iomem *)((adapter)->base + 0x20))
> +#define RDOUTDOOR(adapter)		readl((void __iomem *)((adapter)->base + 0x2C))
> +#define WRINDOOR(adapter,value)		writel(value, (void __iomem *)((adapter)->base + 0x20))
> +#define WROUTDOOR(adapter,value)	writel(value, (void __iomem *)((adapter)->base + 0x2C))
>
> /*
>  * Global variables
> diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
> index d847256..862a3ba 100644
> --- a/drivers/scsi/sata_svw.c
> +++ b/drivers/scsi/sata_svw.c
> @@ -110,26 +110,31 @@ static void k2_sata_tf_load(struct ata_p
> 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
>
> 	if (tf->ctl != ap->last_ctl) {
> -		writeb(tf->ctl, ioaddr->ctl_addr);
> +		writeb(tf->ctl, (void __iomem *) ioaddr->ctl_addr);
> 		ap->last_ctl = tf->ctl;
> 		ata_wait_idle(ap);
> 	}
> 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> -		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
> -		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
> -		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
> -		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
> -		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
> +		writew(tf->feature | (((u16)tf->hob_feature) << 8),
> +		       (void __iomem *) ioaddr->feature_addr);
> +		writew(tf->nsect | (((u16)tf->hob_nsect) << 8),
> +		       (void __iomem *) ioaddr->nsect_addr);
> +		writew(tf->lbal | (((u16)tf->hob_lbal) << 8),
> +		       (void __iomem *) ioaddr->lbal_addr);
> +		writew(tf->lbam | (((u16)tf->hob_lbam) << 8),
> +		       (void __iomem *) ioaddr->lbam_addr);
> +		writew(tf->lbah | (((u16)tf->hob_lbah) << 8),
> +		       (void __iomem *) ioaddr->lbah_addr);
> 	} else if (is_addr) {
> -		writew(tf->feature, ioaddr->feature_addr);
> -		writew(tf->nsect, ioaddr->nsect_addr);
> -		writew(tf->lbal, ioaddr->lbal_addr);
> -		writew(tf->lbam, ioaddr->lbam_addr);
> -		writew(tf->lbah, ioaddr->lbah_addr);
> +		writew(tf->feature, (void __iomem *) ioaddr->feature_addr);
> +		writew(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
> +		writew(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
> +		writew(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
> +		writew(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
> 	}
>
> 	if (tf->flags & ATA_TFLAG_DEVICE)
> -		writeb(tf->device, ioaddr->device_addr);
> +		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
>
> 	ata_wait_idle(ap);
> }
> @@ -141,12 +146,12 @@ static void k2_sata_tf_read(struct ata_p
> 	u16 nsect, lbal, lbam, lbah, feature;
>
> 	tf->command = k2_stat_check_status(ap);
> -	tf->device = readw(ioaddr->device_addr);
> -	feature = readw(ioaddr->error_addr);
> -	nsect = readw(ioaddr->nsect_addr);
> -	lbal = readw(ioaddr->lbal_addr);
> -	lbam = readw(ioaddr->lbam_addr);
> -	lbah = readw(ioaddr->lbah_addr);
> +	tf->device = readw((void __iomem *) ioaddr->device_addr);
> +	feature = readw((void __iomem *) ioaddr->error_addr);
> +	nsect = readw((void __iomem *) ioaddr->nsect_addr);
> +	lbal = readw((void __iomem *) ioaddr->lbal_addr);
> +	lbam = readw((void __iomem *) ioaddr->lbam_addr);
> +	lbah = readw((void __iomem *) ioaddr->lbah_addr);
>
> 	tf->feature = feature;
> 	tf->nsect = nsect;
> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> index 2e2c3b7..cacacc5 100644
> --- a/drivers/scsi/sata_vsc.c
> +++ b/drivers/scsi/sata_vsc.c
> @@ -130,21 +130,26 @@ static void vsc_sata_tf_load(struct ata_
> 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
> 	}
> 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> -		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
> -		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
> -		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
> -		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
> -		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
> +		writew(tf->feature | (((u16)tf->hob_feature) << 8),
> +		       (void __iomem *) ioaddr->feature_addr);
> +		writew(tf->nsect | (((u16)tf->hob_nsect) << 8),
> +		       (void __iomem *) ioaddr->nsect_addr);
> +		writew(tf->lbal | (((u16)tf->hob_lbal) << 8),
> +		       (void __iomem *) ioaddr->lbal_addr);
> +		writew(tf->lbam | (((u16)tf->hob_lbam) << 8),
> +		       (void __iomem *) ioaddr->lbam_addr);
> +		writew(tf->lbah | (((u16)tf->hob_lbah) << 8),
> +		       (void __iomem *) ioaddr->lbah_addr);
> 	} else if (is_addr) {
> -		writew(tf->feature, ioaddr->feature_addr);
> -		writew(tf->nsect, ioaddr->nsect_addr);
> -		writew(tf->lbal, ioaddr->lbal_addr);
> -		writew(tf->lbam, ioaddr->lbam_addr);
> -		writew(tf->lbah, ioaddr->lbah_addr);
> +		writew(tf->feature, (void __iomem *) ioaddr->feature_addr);
> +		writew(tf->nsect, (void __iomem *) ioaddr->nsect_addr);
> +		writew(tf->lbal, (void __iomem *) ioaddr->lbal_addr);
> +		writew(tf->lbam, (void __iomem *) ioaddr->lbam_addr);
> +		writew(tf->lbah, (void __iomem *) ioaddr->lbah_addr);
> 	}
>
> 	if (tf->flags & ATA_TFLAG_DEVICE)
> -		writeb(tf->device, ioaddr->device_addr);
> +		writeb(tf->device, (void __iomem *) ioaddr->device_addr);
>
> 	ata_wait_idle(ap);
> }
> @@ -156,12 +161,12 @@ static void vsc_sata_tf_read(struct ata_
> 	u16 nsect, lbal, lbam, lbah, feature;
>
> 	tf->command = ata_check_status(ap);
> -	tf->device = readw(ioaddr->device_addr);
> -	feature = readw(ioaddr->error_addr);
> -	nsect = readw(ioaddr->nsect_addr);
> -	lbal = readw(ioaddr->lbal_addr);
> -	lbam = readw(ioaddr->lbam_addr);
> -	lbah = readw(ioaddr->lbah_addr);
> +	tf->device = readw((void __iomem *) ioaddr->device_addr);
> +	feature = readw((void __iomem *) ioaddr->error_addr);
> +	nsect = readw((void __iomem *) ioaddr->nsect_addr);
> +	lbal = readw((void __iomem *) ioaddr->lbal_addr);
> +	lbam = readw((void __iomem *) ioaddr->lbam_addr);
> +	lbah = readw((void __iomem *) ioaddr->lbah_addr);
>
> 	tf->feature = feature;
> 	tf->nsect = nsect;
> @@ -279,8 +284,8 @@ static void __devinit vsc_sata_setup_por
> 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
> 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
> 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
> -	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
> -	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
> +	writel(0, (void __iomem *) (base + VSC_SATA_UP_DESCRIPTOR_OFFSET));
> +	writel(0, (void __iomem *) (base + VSC_SATA_UP_DATA_BUFFER_OFFSET));
> }


With all these casts, doesn't it point out that something is wrong
with writel(), writew(), readl(), and readw() ??? The cast's to
volatile types should be within the macros, not scattered
throughout everyone's driver code!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
