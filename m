Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSL0Vv5>; Fri, 27 Dec 2002 16:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSL0Vv5>; Fri, 27 Dec 2002 16:51:57 -0500
Received: from havoc.daloft.com ([64.213.145.173]:30678 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S264815AbSL0Vv4>;
	Fri, 27 Dec 2002 16:51:56 -0500
Date: Fri, 27 Dec 2002 17:00:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kevin Corry <corry@ecn.purdue.edu>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, dm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm.c : Check memory allocations
Message-ID: <20021227220008.GA11577@gtf.org>
References: <200212272155.gBRLtWD7013508@shay.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212272155.gBRLtWD7013508@shay.ecn.purdue.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 04:55:31PM -0500, Kevin Corry wrote:
> Check memory allocations when cloning bio's.
> 
> --- linux-2.5.53a/drivers/md/dm.c	Mon Dec 23 23:21:04 2002
> +++ linux-2.5.53b/drivers/md/dm.c	Fri Dec 27 14:50:29 2002
> @@ -394,6 +393,10 @@
>  		 */
>  		clone = clone_bio(bio, ci->sector, ci->idx,
>  				  bio->bi_vcnt - ci->idx, ci->sector_count);
> +		if (!clone) {
> +			dec_pending(ci->io, -ENOMEM);
> +			return;
> +		}
>  		__map_bio(ti, clone, ci->io);
>  		ci->sector_count = 0;
>  
> @@ -417,6 +420,10 @@
>  		}
>  
>  		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
> +		if (!clone) {
> +			dec_pending(ci->io, -ENOMEM);
> +			return;
> +		}
>  		__map_bio(ti, clone, ci->io);
>  
>  		ci->sector += len;


This seems a bit insufficient.  Why is this error not propagated up
through to __split_bio ?

	Jeff



