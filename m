Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbTCLTjd>; Wed, 12 Mar 2003 14:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbTCLTjd>; Wed, 12 Mar 2003 14:39:33 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:10127 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261972AbTCLTjb>; Wed, 12 Mar 2003 14:39:31 -0500
Message-ID: <3E6F91E0.1020601@pacbell.net>
Date: Wed, 12 Mar 2003 12:00:32 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: alan@redhat.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.4] Memleak in drivers/usb/hub.c::usb_reset_device
References: <20030312194133.GA27968@linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> Hello!
> 
>    There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
>    on error exit path. See the patch.
>    Found with help of smatch + enhanced unfree script.

Hmm ... and 2.5 allocates it on the stack, which is actually
illegal (DMA-to-stack is nonportable).  This looks like a case
where it'd be good to make 2.5 look more like 2.4 (+ this patch).

- Dave


> Bye,
>     Oleg
> ===== drivers/usb/hub.c 1.19 vs edited =====
> --- 1.19/drivers/usb/hub.c	Sat Sep 21 00:12:53 2002
> +++ edited/drivers/usb/hub.c	Wed Mar 12 22:38:43 2003
> @@ -1057,8 +1057,10 @@
>  	}
>  	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, descriptor,
>  			sizeof(*descriptor));
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(descriptor);
>  		return ret;
> +	}
>  
>  	le16_to_cpus(&descriptor->bcdUSB);
>  	le16_to_cpus(&descriptor->idVendor);
> 



