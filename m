Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbSJCF5j>; Thu, 3 Oct 2002 01:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbSJCF5j>; Thu, 3 Oct 2002 01:57:39 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:14323 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262741AbSJCF5i>; Thu, 3 Oct 2002 01:57:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 3 Oct 2002 00:01:03 -0600
To: peterc@gelato.unsw.edu.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large Block device patch part 3/4
Message-ID: <20021003060103.GE3000@clusterfs.com>
Mail-Followup-To: peterc@gelato.unsw.edu.au, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <15771.54177.488730.544483@lemon.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15771.54177.488730.544483@lemon.gelato.unsw.EDU.AU>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2002  15:20 +1000, peterc@gelato.unsw.edu.au wrote:
> diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
> --- a/drivers/block/cciss.c	Thu Oct  3 15:06:13 2002
> +++ b/drivers/block/cciss.c	Thu Oct  3 15:06:13 2002
> @@ -405,7 +405,7 @@
>                  } else {
>                          driver_geo.heads = 0xff;
>                          driver_geo.sectors = 0x3f;
> -                        driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
> +                        driver_geo.cylinders = (int)hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
>                  }
>                  driver_geo.start= get_start_sect(inode->i_bdev);
>                  if (copy_to_user((void *) arg, &driver_geo,

Wouldn't this be better off as:

    driver_geo.cylinders = (int)(hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f));

> diff -Nru a/drivers/md/linear.c b/drivers/md/linear.c
> --- a/drivers/md/linear.c	Thu Oct  3 15:06:13 2002
> +++ b/drivers/md/linear.c	Thu Oct  3 15:06:13 2002
> @@ -72,10 +72,12 @@
>  		goto out;
>  	}
>  
> -	nb_zone = conf->nr_zones =
> -		md_size[mdidx(mddev)] / conf->smallest->size +
> -		((md_size[mdidx(mddev)] % conf->smallest->size) ? 1 : 0);
> -  
> +	{
> +		sector_t sz = md_size[mdidx(mddev)];
> +		unsigned round = sector_div(sz, conf->smallest->size);
> +		nb_zone = conf->nr_zones = sz + (round ? 1 : 0);
> +	}
> +			
>  	conf->hash_table = kmalloc (sizeof (struct linear_hash) * nb_zone,
>  					GFP_KERNEL);
>  	if (!conf->hash_table)

Something like the following should work for most cases (i.e. as long as
an individual device isn't larger than 2TB):

	round = do_div(sz, conf->smallest_size);

>  	printk("raid0 : conf->smallest->size is %ld blocks.\n", conf->smallest->size);
>  	nb_zone = md_size[mdidx(mddev)]/conf->smallest->size +
> -			(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
> -	printk("raid0 : nb_zone is %ld.\n", nb_zone);
> +		(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
> +	printk("raid0 : nb_zone is %d.\n", nb_zone);

Don't we need something similar here also?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

