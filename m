Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUDSMP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264390AbUDSMP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:15:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28332 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264388AbUDSMPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:15:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Date: Mon, 19 Apr 2004 14:14:15 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca
References: <20040418194357.4cd02a06.rddunlap@osdl.org> <20040418195131.7133cb0f.rddunlap@osdl.org>
In-Reply-To: <20040418195131.7133cb0f.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191414.15702.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Randy,

I wonder if PC9800 fixes are worth the hassle as PC9800 merge
(AFAIR first patch went into 2.5.50!) was never finished.

I think somebody should fix it or we should just remove it completely.

Cheers,
Bartlomiej

On Monday 19 of April 2004 04:51, Randy.Dunlap wrote:
> Convert floppy98.c to use kernel min/max, like floppy.c.
>
>
> diffstat:=
>  drivers/block/floppy98.c |   28 ++++++----------------------
>  1 files changed, 6 insertions(+), 22 deletions(-)
>
>
> diff -Naurp ./drivers/block/floppy98.c~fd98_minmax
> ./drivers/block/floppy98.c ---
> ./drivers/block/floppy98.c~fd98_minmax	2004-04-18 17:54:42.000000000 -0700
> +++ ./drivers/block/floppy98.c	2004-04-18 18:12:38.000000000 -0700 @@
> -720,25 +720,9 @@ static void reschedule_timeout(int drive
>  	timeout_message = message;
>  }
>
> -static int maximum(int a, int b)
> -{
> -	if (a > b)
> -		return a;
> -	else
> -		return b;
> -}
> -
> -#define INFBOUND(a,b) (a)=maximum((a),(b));
> -
> -static int minimum(int a, int b)
> -{
> -	if (a < b)
> -		return a;
> -	else
> -		return b;
> -}
> +#define INFBOUND(a,b) (a)=max_t(int, a, b)
>
> -#define SUPBOUND(a,b) (a)=minimum((a),(b));
> +#define SUPBOUND(a,b) (a)=min_t(int, a, b)
>
>  /*
>   * Bottom half floppy driver.
> @@ -2556,12 +2540,12 @@ static void copy_buffer(int ssize, int m
>  	int size, i;
>
>  	max_sector = transfer_size(ssize,
> -				   minimum(max_sector, max_sector_2),
> +				   min(max_sector, max_sector_2),
>  				   current_req->nr_sectors);
>
>  	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
>  	    buffer_max > fsector_t + current_req->nr_sectors)
> -		current_count_sectors = minimum(buffer_max - fsector_t,
> +		current_count_sectors = min_t(int, buffer_max - fsector_t,
>  						current_req->nr_sectors);
>
>  	remaining = current_count_sectors << 9;
> @@ -2580,7 +2564,7 @@ static void copy_buffer(int ssize, int m
>  	}
>  #endif
>
> -	buffer_max = maximum(max_sector, buffer_max);
> +	buffer_max = max(max_sector, buffer_max);
>
>  	dma_buffer = floppy_track_buffer + ((fsector_t - buffer_min) << 9);
>
> @@ -2733,7 +2717,7 @@ static int make_raw_rw_request(void)
>  		max_sector = 2 * _floppy->sect / 3;
>  		if (fsector_t >= max_sector) {
>  			current_count_sectors =
> -			    minimum(_floppy->sect - fsector_t,
> +			    min_t(int, _floppy->sect - fsector_t,
>  				    current_req->nr_sectors);
>  			return 1;
>  		}
> --
> ~Randy

