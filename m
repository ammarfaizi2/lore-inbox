Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUFRSaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUFRSaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUFRSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:30:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:39568 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266643AbUFRS1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:27:11 -0400
X-Authenticated: #20450766
Date: Fri, 18 Jun 2004 20:26:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org, Eberhard Moenkeberg <emoenke@gwdg.de>,
       Eric van der Maarel <H.T.M.v.d.Maarel@marin.nl>
Subject: Re: [PATCH] check_/request_region fixes & request for enlightenment
In-Reply-To: <Pine.LNX.4.56.0406180007530.15935@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.60.0406182021200.7426@poirot.grange>
References: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.60.0406172036001.3926@poirot.grange>
 <Pine.LNX.4.56.0406180007530.15935@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jesper Juhl wrote:

>> That looks like a bug - release_region() without request_region().
>>
> Since check_region is now request_region I assume things are now OK..?

Yep.

> Or maybe something like this is better, to just have a single exit point?
> The code is shorter this way, and there's less chance if error if one
> wants to update the return value (only one place to edit)... Which one is
> the prefered approach?

I think, it is the preferred way. At least I don't see anything else 
obviously wrong there:-)

Guennadi

> --- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
> +++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-18 00:09:49.000000000 +0200
> @@ -118,17 +118,17 @@ int __init isp16_init(void)
>
> 	if (!strcmp(isp16_cdrom_type, "noisp16")) {
> 		printk("ISP16: no cdrom interface configured.\n");
> -		return (0);
> +		return 0;
> 	}
>
> -	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
> +	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
> 		printk("ISP16: i/o ports already in use.\n");
> -		return (-EIO);
> +		goto out;
> 	}
>
> 	if ((isp16_type = isp16_detect()) < 0) {
> 		printk("ISP16: no cdrom interface found.\n");
> -		return (-EIO);
> +		goto cleanup_out;
> 	}
>
> 	printk(KERN_INFO
> @@ -148,27 +148,32 @@ int __init isp16_init(void)
> 	else {
> 		printk("ISP16: %s not supported by cdrom interface.\n",
> 		       isp16_cdrom_type);
> -		return (-EIO);
> +		goto cleanup_out;
> 	}
>
> 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
> 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
> 		printk
> 		    ("ISP16: cdrom interface has not been properly configured.\n");
> -		return (-EIO);
> +		goto cleanup_out;
> 	}
> 	printk(KERN_INFO
> 	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
> 	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
> 	       isp16_cdrom_dma, isp16_cdrom_type);
> -	return (0);
> +	return 0;
> +
> +cleanup_out:
> +	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
> +out:
> +	return -EIO;
> }
>
> static short __init isp16_detect(void)
> {
>
> 	if (isp16_c929__detect() >= 0)
> -		return (2);
> +		return 2;
> 	else
> 		return (isp16_c928__detect());
> }
> @@ -206,7 +211,7 @@ static short __init isp16_c928__detect(v
> 			ISP16_OUT(ISP16_C928__ENABLE_PORT, enable_cdrom);
> 		} else {	/* bits are not the same */
> 			ISP16_OUT(ISP16_CTRL_PORT, ctrl);
> -			return (i);	/* -> not detected: possibly incorrect conclusion */
> +			return i;	/* -> not detected: possibly incorrect conclusion */
> 		}
> 	} else if (enable_cdrom == 0x20)
> 		i = 0;
> @@ -215,7 +220,7 @@ static short __init isp16_c928__detect(v
>
> 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);
>
> -	return (i);
> +	return i;
> }
>
> static short __init isp16_c929__detect(void)
> @@ -236,12 +241,12 @@ static short __init isp16_c929__detect(v
> 	tmp = ISP16_IN(ISP16_CTRL_PORT);
>
> 	if (tmp != 2)		/* isp16 with 82C929 not detected */
> -		return (-1);
> +		return -1;
>
> 	/* restore ctrl port value */
> 	ISP16_OUT(ISP16_CTRL_PORT, ctrl);
>
> -	return (2);
> +	return 2;
> }
>
> static short __init
> @@ -272,7 +277,7 @@ isp16_cdi_config(int base, u_char drive_
> 		printk
> 		    ("ISP16: base address 0x%03X not supported by cdrom interface.\n",
> 		     base);
> -		return (-1);
> +		return -1;
> 	}
> 	switch (irq) {
> 	case 0:
> @@ -303,7 +308,7 @@ isp16_cdi_config(int base, u_char drive_
> 	default:
> 		printk("ISP16: irq %d not supported by cdrom interface.\n",
> 		       irq);
> -		return (-1);
> +		return -1;
> 	}
> 	switch (dma) {
> 	case 0:
> @@ -312,7 +317,7 @@ isp16_cdi_config(int base, u_char drive_
> 	case 1:
> 		printk("ISP16: dma 1 cannot be used by cdrom interface,"
> 		       " due to conflict with the sound card.\n");
> -		return (-1);
> +		return -1;
> 		break;
> 	case 3:
> 		dma_code = ISP16_DMA_3;
> @@ -329,7 +334,7 @@ isp16_cdi_config(int base, u_char drive_
> 	default:
> 		printk("ISP16: dma %d not supported by cdrom interface.\n",
> 		       dma);
> -		return (-1);
> +		return -1;
> 	}
>
> 	if (drive_type != ISP16_SONY && drive_type != ISP16_PANASONIC0 &&
> @@ -339,7 +344,7 @@ isp16_cdi_config(int base, u_char drive_
> 		printk
> 		    ("ISP16: drive type (code 0x%02X) not supported by cdrom"
> 		     " interface.\n", drive_type);
> -		return (-1);
> +		return -1;
> 	}
>
> 	/* set type of interface */
> @@ -354,7 +359,7 @@ isp16_cdi_config(int base, u_char drive_
> 	i = ISP16_IN(ISP16_IO_SET_PORT) & ISP16_IO_SET_MASK;	/* keep some bits */
> 	ISP16_OUT(ISP16_IO_SET_PORT, i | base_code | irq_code | dma_code);
>
> -	return (0);
> +	return 0;
> }
>
> void __exit isp16_exit(void)
>
>
> I've added the original author as well as the NON-IDE/NON-SCSI CDROM
> DRIVER maintainer Eberhard Moenkeberg to the CC list - hoping for more
> comments :)
>
>
> Regarding trm290;
>
>> trm290_init_one
>>    ide_setup_pci_device
>>
>> first calls
>>
>>      do_ide_setup_pci_device
>>        ide_pci_setup_ports
>>          d->init_hwif(hwif) = init_hwif_trm290
>>            ***check_region***
>>
>> then it calls
>>
>>      probe_hwif_init
>>        probe_hwif
>>          ide_hwif_request_regions
>>
>
> Perfect. That plus your clarifying text was just the explanation I needed.
> I'll get to work on a revised patch for trm290 - and I'll post that in a
> sepperate thread (I'll CC you (Guennadi) on that if you don't mind?).
>
>
> --
> Jesper Juhl <juhl-lkml@dif.dk>
>
>

---
Guennadi Liakhovetski

