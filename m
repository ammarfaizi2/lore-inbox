Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVHISNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVHISNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVHISNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:13:23 -0400
Received: from fmr22.intel.com ([143.183.121.14]:65481 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964908AbVHISNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:13:21 -0400
Date: Tue, 9 Aug 2005 11:12:37 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@muc.de, ashok.raj@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.13-rc5-mm1 doesnt boot on x86_64
Message-ID: <20050809111237.A32614@unix-os.sc.intel.com>
References: <20050808094818.A17579@unix-os.sc.intel.com> <20050808171126.GA32092@muc.de> <1123522409.5019.0.camel@mulgrave> <20050808104206.42a51477.akpm@osdl.org> <1123546010.8235.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1123546010.8235.18.camel@mulgrave>; from James.Bottomley@SteelEye.com on Mon, Aug 08, 2005 at 07:06:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 07:06:50PM -0500, James Bottomley wrote:
> On Mon, 2005-08-08 at 10:42 -0700, Andrew Morton wrote:
> > -mm has extra list_head debugging goodies.  I'd be suspecting a list_head
> > corruption detected somewhere under spi_release_transport().
> 
> Aha, looking in wrong driver ... the problem actually appears to be a
> double release of the transport template in aic79xx.  Try this patch

Hi James

Sorry for the delay...

This patch works like a charm!.....

Cheers,
ashok
> 
> James
> 
> diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
> --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
> @@ -2326,8 +2326,6 @@ done:
>  	return (retval);
>  }
>  
> -static void ahd_linux_exit(void);
> -
>  static void ahd_linux_set_width(struct scsi_target *starget, int width)
>  {
>  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
> @@ -2772,7 +2770,7 @@ ahd_linux_init(void)
>  	if (ahd_linux_detect(&aic79xx_driver_template) > 0)
>  		return 0;
>  	spi_release_transport(ahd_linux_transport_template);
> -	ahd_linux_exit();
> +
>  	return -ENODEV;
>  }
>  
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> --- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> @@ -2331,8 +2331,6 @@ ahc_platform_dump_card_state(struct ahc_
>  {
>  }
>  
> -static void ahc_linux_exit(void);
> -
>  static void ahc_linux_set_width(struct scsi_target *starget, int width)
>  {
>  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
> 
> 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
