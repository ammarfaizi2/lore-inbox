Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWBBT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBBT2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBBT2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:28:07 -0500
Received: from xenotime.net ([66.160.160.81]:16841 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750985AbWBBT2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:28:06 -0500
Date: Thu, 2 Feb 2006 11:28:04 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab
 corruption.
In-Reply-To: <20060202192414.GA22074@redhat.com>
Message-ID: <Pine.LNX.4.58.0602021126340.16597@shark.he.net>
References: <20060202192414.GA22074@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Dave Jones wrote:

> In the case where we detect a single bit has been flipped, we spew
> the usual slab corruption message, which users instantly think
> is a kernel bug.  In a lot of cases, single bit errors are
> down to bad memory, or other hardware failure.
>
> This patch adds an extra line to the slab debug messages in those
> cases, in the hope that users will try memtest before they report a bug.
>
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Single bit error detected. Possibly bad RAM. Please run memtest86.

does memtest86 run on all $ARCHes ?
or this is good for <large percentage>, so it's Good.  :)
Just checking; it is a good idea.

> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- linux-2.6.15/mm/slab.c~	2006-01-09 13:25:17.000000000 -0500
> +++ linux-2.6.15/mm/slab.c	2006-01-09 13:26:01.000000000 -0500
> @@ -1313,8 +1313,11 @@ static void poison_obj(kmem_cache_t *cac
>  static void dump_line(char *data, int offset, int limit)
>  {
>  	int i;
> +	unsigned char total=0;
>  	printk(KERN_ERR "%03x:", offset);
>  	for (i = 0; i < limit; i++) {
> +		if (data[offset+i] != POISON_FREE)
> +			total += data[offset+i];
>  		printk(" %02x", (unsigned char)data[offset + i]);
>  	}
>  	printk("\n");
> @@ -1019,6 +1023,18 @@ static void dump_line(char *data, int of
>  		}
>  	}
>  	printk("\n");
> +	switch (total) {
> +		case 0x36:
> +		case 0x6a:
> +		case 0x6f:
> +		case 0x81:
> +		case 0xac:
> +		case 0xd3:
> +		case 0xd5:
> +		case 0xea:
> +			printk (KERN_ERR "Single bit error detected. Possibly bad RAM. Please run memtest86.\n");
> +			return;
> +	}
>  }
>  #endif
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
~Randy
