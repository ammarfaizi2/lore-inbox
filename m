Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936553AbWLAUsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936553AbWLAUsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936554AbWLAUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:48:11 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:55884 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936553AbWLAUsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:48:09 -0500
Date: Fri, 1 Dec 2006 12:48:37 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: ALi M5229 - CD-ROM not found with pata_ali
Message-Id: <20061201124837.6d0d8adb.randy.dunlap@oracle.com>
In-Reply-To: <200612012335.29179.arvidjaar@mail.ru>
References: <200606220004.30863.arvidjaar@mail.ru>
	<200612012335.29179.arvidjaar@mail.ru>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 23:35:28 +0300 Andrey Borzenkov wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thursday 22 June 2006 00:04, Andrey Borzenkov wrote:
> > Just in case you have missed this on LKML :)
> >
> > Alan Cox wrote:
> > > http://zeniv.linux.org.uk/~alan/IDE
> > >
> > > This is basically a resync versus 2.6.17, the head of the PATA tree is
> > > now built against Jeffs tree with revised error handling and the like.
> >
> > Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
> > Notice "ata2: command 0xa0 timeout" below.
> >
> 
> Still the same in 2.6.19 + suspend pata_ali patch. The only way I can get 
> CD-ROM is with
> 
> options pata_ali atapi_max_xfer_mask=0x7f
> 
> and patch
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 1d695df..a0b9e49 100644
> - --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -329,6 +329,16 @@ static void ali_lock_sectors(struct ata_
>         adev->max_sectors = 255;
>  }
> 
> +static unsigned long atapi_max_xfer_mask = ~0;
> +module_param(atapi_max_xfer_mask, ulong, 644);
                                            ^^^
BTW:                                        0644


> +
> +static unsigned long ali_mode_filter(const struct ata_port *ap, struct 
> ata_devi
> ce *adev, unsigned long xfer_mask)
> +{
> +       if (adev->class == ATA_DEV_ATAPI)
> +               xfer_mask &= atapi_max_xfer_mask;
> +       return ata_pci_default_filter(ap, adev, xfer_mask);
> +}
> +
>  static struct scsi_host_template ali_sht = {
>         .module                 = THIS_MODULE,
>         .name                   = DRV_NAME,
> @@ -428,7 +438,7 @@ static struct ata_port_operations ali_c2
>         .port_disable   = ata_port_disable,
>         .set_piomode    = ali_set_piomode,
>         .set_dmamode    = ali_set_dmamode,
> - -       .mode_filter    = ata_pci_default_filter,
> +       .mode_filter    = ali_mode_filter,
>         .tf_load        = ata_tf_load,
>         .tf_read        = ata_tf_read,
>         .check_status   = ata_check_status,
> 
> allowing even MWDMA results in the same timeouts and CD-ROM not found.

---
~Randy
