Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131673AbQKAWkE>; Wed, 1 Nov 2000 17:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbQKAWjp>; Wed, 1 Nov 2000 17:39:45 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:16656 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131673AbQKAWjl> convert rfc822-to-8bit; Wed, 1 Nov 2000 17:39:41 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBF5@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Anthony Towns'" <aj@azure.humbug.org.au>
Cc: 'Pasi Kärkkäinen' <pk@edu.joroinen.fi>,
        Rik van Riel <riel@conectiva.com.br>,
        "Forever shall I be." <zinx@microsoftisevil.com>,
        linux-kernel@vger.kernel.org
Subject: RE: 3-order allocation failed
Date: Wed, 1 Nov 2000 14:39:01 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, I bet that's been there awhile.

BTW, did you submit this patch earlier?  I don't
recall having seen it.

I'll forward it.

Thanks,
~Randy_________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
----------------------------------------------- 

> -----Original Message-----
> From: Anthony Towns [mailto:aj@azure.humbug.org.au]
> Sent: Wednesday, November 01, 2000 2:21 PM
> To: unlisted-recipients
> Cc: 'Pasi Kärkkäinen'; Rik van Riel; Forever shall I be.;
> linux-kernel@vger.kernel.org
> Subject: Re: 3-order allocation failed
> 
> 
> On Wed, Nov 01, 2000 at 01:42:17PM -0800, Dunlap, Randy wrote:
> > > Is this bug in the usb-driver (usb-uhci), in the camera's driver
> > > (cpia_usb) or in the v4l?
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > Could there be a memory leak as well?  But I expect that
> > it's simply that memory is just fragmented so that enough
> > contiguous pages aren't available, like Rik said.
> 
> There is a memory leak, the memory kmalloc'ed in cpia_usb_open for
> sbuf[*].data is never kfree'd (except when an error occurs during
> initialisation). Adding some kfree's in cpia_usb_free_resources fixed
> the problem in test7 or so, here's a patch against -test10.
> 
> --- drivers/media/video/cpia_usb.c.orig	Wed Nov  1 14:14:37 2000
> +++ drivers/media/video/cpia_usb.c	Wed Nov  1 14:16:05 2000
> @@ -432,10 +432,20 @@
>  		ucpia->sbuf[1].urb = NULL;
>  	}
>  
> +	if (ucpia->sbuf[1].data) {
> +		kfree(ucpia->sbuf[1].data);
> +		ucpia->sbuf[1].data = NULL;
> +	}
> + 
>  	if (ucpia->sbuf[0].urb) {
>  		usb_unlink_urb(ucpia->sbuf[0].urb);
>  		usb_free_urb(ucpia->sbuf[0].urb);
>  		ucpia->sbuf[0].urb = NULL;
> +	}
> +
> +	if (ucpia->sbuf[0].data) {
> +		kfree(ucpia->sbuf[0].data);
> +		ucpia->sbuf[0].data = NULL;
>  	}
>  }
> 
> HTH.
> 
> Cheers,
> aj 
> 
> -- 
> Anthony Towns <aj@humbug.org.au> <http://azure.humbug.org.au/~aj/>
> I don't speak for anyone save myself. GPG signed mail preferred.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
