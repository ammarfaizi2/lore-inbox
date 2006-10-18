Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWJRIYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWJRIYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWJRIYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:24:30 -0400
Received: from mx10.go2.pl ([193.17.41.74]:55745 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750882AbWJRIY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:24:29 -0400
Date: Wed, 18 Oct 2006 10:29:32 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Amit Choudhary <amit2030@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc2] [REVISED] drivers/media/video/se401.c: check kmalloc() return value.
Message-ID: <20061018082931.GA2051@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Amit Choudhary <amit2030@gmail.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017213155.35983846.amit2030@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-2006 06:31, Amit Choudhary wrote:
> Description: Check the return value of kmalloc() in function se401_start_stream(), in file drivers/media/video/se401.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
> index 7aeec57..fe94227 100644
> --- a/drivers/media/video/se401.c
> +++ b/drivers/media/video/se401.c
> @@ -450,6 +450,8 @@ static int se401_start_stream(struct usb
>  	}
>  	for (i=0; i<SE401_NUMSBUF; i++) {
>  		se401->sbuf[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
> +		if (!se401->sbuf[i].data)
> +			goto nomem_err;
>  	}
>  
>  	se401->bayeroffset=0;
> @@ -458,13 +460,15 @@ static int se401_start_stream(struct usb
>  	se401->scratch_overflow=0;
>  	for (i=0; i<SE401_NUMSCRATCH; i++) {
>  		se401->scratch[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
> +		if (!se401->scratch[i].data)
> +			goto nomem_err;
>  		se401->scratch[i].state=BUFFER_UNUSED;
>  	}
>  
>  	for (i=0; i<SE401_NUMSBUF; i++) {
>  		urb=usb_alloc_urb(0, GFP_KERNEL);
>  		if(!urb)
> -			return -ENOMEM;
> +			goto nomem_err;
>  
>  		usb_fill_bulk_urb(urb, se401->dev,
>  			usb_rcvbulkpipe(se401->dev, SE401_VIDEO_ENDPOINT),
> @@ -482,6 +486,20 @@ static int se401_start_stream(struct usb
>  	se401->framecount=0;
>  
>  	return 0;
> +
> + nomem_err:
> +	for (i=0; i<SE401_NUMSBUF; i++) {
> +		usb_kill_urb(se401->urb[i]);
> +		usb_free_urb(se401->urb[i]);
> +		se401->urb[i] = NULL;
> +		kfree(se401->sbuf[i].data);
...

I see before se401_start_stream usually this is done: 

static int se401_stop_stream(struct usb_se401 *se401)
{
...
	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
		usb_kill_urb(se401->urb[i]);
		usb_free_urb(se401->urb[i]);
		se401->urb[i]=NULL;
		kfree(se401->sbuf[i].data);
	}
	for (i=0; i<SE401_NUMSCRATCH; i++) {
		kfree(se401->scratch[i].data);
		se401->scratch[i].data=NULL;
	}

	return 0;
}

... but because above there is no: 
se401->sbuf[i].data=NULL;
after kfree(se401->sbuf[i].data);
it is possible that in se401_start_stream we have
kmalloc error for e.g. i == 0 but kfree for i >= 1,
which could be not NULL (but kfreed)... 

Regards,

Jarek P.
