Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbTIUMR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTIUMR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:17:57 -0400
Received: from 4demon.com ([217.160.186.4]:33252 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S262374AbTIUMR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:17:56 -0400
Message-ID: <3F6DB250.6000207@pro-linux.de>
Date: Sun, 21 Sep 2003 14:14:40 +0000
From: Mirko Lindner <demon@pro-linux.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       mlindner@syskonnect.de
Subject: Re: [PATCH] [2.4] Fix memleak on error exit path in sk98 driver.
References: <20030921114529.GA31747@linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. Will be done tomorrow.

Cheers,

Mirko


Oleg Drokin schrieb:
> Hello!
> 
>    There is a trivial memleak in sk98 ioctl handling routinue,
>    the patch is also trivial. Please apply.
>    Found with help of smatch.
> 
> ===== drivers/net/sk98lin/skge.c 1.14 vs edited =====
> --- 1.14/drivers/net/sk98lin/skge.c	Wed Sep  3 21:15:10 2003
> +++ edited/drivers/net/sk98lin/skge.c	Sun Sep 21 15:38:01 2003
> @@ -3616,20 +3616,21 @@
>  			Length = sizeof(pAC->PnmiStruct) + HeaderLength;
>  		}
>  		if (NULL == (pMemBuf = kmalloc(Length, GFP_KERNEL))) {
> -			return -EFAULT;
> +			return -ENOMEM;
>  		}
>  		if(copy_from_user(pMemBuf, Ioctl.pData, Length)) {
> -			return -EFAULT;
> +			goto fault;
>  		}
>  		if ((Ret = SkPnmiGenIoctl(pAC, pAC->IoBase, pMemBuf, &Length, 0)) < 0) {
> -			return -EFAULT;
> +			goto fault;
>  		}
>  		if(copy_to_user(Ioctl.pData, pMemBuf, Length) ) {
> -			return -EFAULT;
> +			goto fault;
>  		}
>  		Ioctl.Len = Length;
>  		if(copy_to_user(rq->ifr_data, &Ioctl, sizeof(SK_GE_IOCTL))) {
> -			return -EFAULT;
> +fault:
> +			Err = -EFAULT;
>  		}
>  		kfree(pMemBuf); /* cleanup everything */
>  		break;
> 
> 
> <!DSPAM:3f6d8f69246641288117544>
> 


