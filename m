Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWIGJPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWIGJPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWIGJPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:15:34 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:46318 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751357AbWIGJPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:15:33 -0400
Date: Thu, 7 Sep 2006 11:15:17 +0200
From: Olaf Hering <olaf@aepfle.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060907091517.GA21728@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de> <1157490066.3463.73.camel@mulgrave.il.steeleye.com> <20060906110147.GA12101@aepfle.de> <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, James Bottomley wrote:

> On Wed, 2006-09-06 at 13:01 +0200, Olaf Hering wrote:
> > This causes another machine check because it runs ahc_inb(ahc, SBLKCTL) again.
> > With debug I get:
> 
> Exactly.  It's not a card state problem; the register simply doesn't
> exist.  It looks like from the source code, it only exists on twin or U2
> and above chipsets (i.e. those supporting LVD).
> 
> Try this patch, which should deduce the bus type for U and below without
> resorting to the SBLKCTL register.
> 
> James
> 
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> index e5bb4d8..0b3c01a 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> @@ -2539,15 +2539,23 @@ #endif
>  static void ahc_linux_get_signalling(struct Scsi_Host *shost)
>  {
>  	struct ahc_softc *ahc = *(struct ahc_softc **)shost->hostdata;
> -	u8 mode = ahc_inb(ahc, SBLKCTL);
> +	u8 mode;
>  
> -	if (mode & ENAB40)
> -		spi_signalling(shost) = SPI_SIGNAL_LVD;
> -	else if (mode & ENAB20)
> +	if (!(ahc->features & AHC_ULTRA2)) {

This does not work: ahc_linux_get_signalling: f 56f6

echo $(( 0x56f6 & 0x00002 )) gives 2, and the ahc_inb is called.
