Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUFHKSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUFHKSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUFHKSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:18:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:21655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264946AbUFHKSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:18:45 -0400
Date: Tue, 8 Jun 2004 03:17:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yury Umanets <torque@ukrpost.net>
Cc: jj@sunsite.ms.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 invalid usage of GFP_DMA in drivers/scsi/pluto.c
Message-Id: <20040608031753.3ebaf77a.akpm@osdl.org>
In-Reply-To: <1086689511.2818.15.camel@firefly>
References: <1086689511.2818.15.camel@firefly>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Umanets <torque@ukrpost.net> wrote:
>
> Hello Andrew, guys,
> 
> Found this, what seems to be an invalid usage of GFP_DMA flag. Is this
> patch okay?

Nope.

GFP_DMA means "from the lower 16MB of memory".  It's needed for crufty old
eisa hardware which only does 24-bit DMA.  It's meaningless to OR this with
GFP_KERNEL.

However it's a bit odd that GFP_DMA implies !__GFP_WAIT.  It would be valid
to hunt down GFP_DMA users who should really be using GFP_DMA|__GFP_WAIT,
but this stuff is so old and crufty I'd be inclined to leave it all alone.


> 
> --- ./linux-2.6.6/drivers/scsi/pluto.c	Mon May 10 05:32:27 2004
> +++ ./linux-2.6.6-modified/drivers/scsi/pluto.c	Tue Jun  8 11:26:07 2004
> @@ -117,7 +117,8 @@ int __init pluto_detect(Scsi_Host_Templa
>  #endif
>  			return 0;
>  	}
> -	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
> fcscount, GFP_DMA);
> +	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
> fcscount, 
> +			GFP_KERNEL | GFP_DMA);
>  	if (!fcs) {
>  		printk ("PLUTO: Not enough memory to probe\n");
>  		return 0;
> 

Your patch is wordwrapped and uses weird headers (please omit the leading
./ from the pathnames).

