Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUFHLH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUFHLH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbUFHLH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:07:26 -0400
Received: from may.priocom.com ([213.156.65.50]:60365 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S265029AbUFHLHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:07:20 -0400
Subject: Re: [PATCH] 2.6.6 invalid usage of GFP_DMA in drivers/scsi/pluto.c
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: jj@sunsite.ms.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20040608031753.3ebaf77a.akpm@osdl.org>
References: <1086689511.2818.15.camel@firefly>
	 <20040608031753.3ebaf77a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086692848.2818.52.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 14:07:28 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 13:17, Andrew Morton wrote:
> Yury Umanets <torque@ukrpost.net> wrote:
> >
> > Hello Andrew, guys,
> > 
> > Found this, what seems to be an invalid usage of GFP_DMA flag. Is this
> > patch okay?
> 
> Nope.
> 
> GFP_DMA means "from the lower 16MB of memory".  It's needed for crufty old
> eisa hardware which only does 24-bit DMA.
This is clear. And sure, it shows that caller wants some memory from DMA
zone if it is possible.

What I mean is that, GFP_DMA seems to be not full specifier and only
flag which can be used along with something else. 

Say gfp mask roughly consist of two kinds on instructions:
* what memory zone to use - zone specifier.
* how to behave during allocation (IO, sleep, etc) - behavior specifier.

My concern is will it behave correctly with only GFP_DMA? It seems to
behave like do not use emergency pools and do not wait at the same time
what is risky. Is that right?

>   It's meaningless to OR this with
> GFP_KERNEL.

> 
> However it's a bit odd that GFP_DMA implies !__GFP_WAIT.  It would be valid
> to hunt down GFP_DMA users who should really be using GFP_DMA|__GFP_WAIT,

Seems that all GFP_DMA users use it with __GFP_WAIT or GFP_KERNEL. And
I'd prefer to add __GFP_WAIT here also.


> but this stuff is so old and crufty I'd be inclined to leave it all alone.
> 
> 
> > 
> > --- ./linux-2.6.6/drivers/scsi/pluto.c	Mon May 10 05:32:27 2004
> > +++ ./linux-2.6.6-modified/drivers/scsi/pluto.c	Tue Jun  8 11:26:07 2004
> > @@ -117,7 +117,8 @@ int __init pluto_detect(Scsi_Host_Templa
> >  #endif
> >  			return 0;
> >  	}
> > -	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
> > fcscount, GFP_DMA);
> > +	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
> > fcscount, 
> > +			GFP_KERNEL | GFP_DMA);
> >  	if (!fcs) {
> >  		printk ("PLUTO: Not enough memory to probe\n");
> >  		return 0;
> > 
> 

> Your patch is wordwrapped and uses weird headers (please omit the leading
> ./ from the pathnames).
Sorry, next will use another mailer.

-- 
umka

