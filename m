Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSHWHFr>; Fri, 23 Aug 2002 03:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHWHFr>; Fri, 23 Aug 2002 03:05:47 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:17649 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318510AbSHWHFp>; Fri, 23 Aug 2002 03:05:45 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 23 Aug 2002 01:07:59 -0600
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020823070759.GS19435@clusterfs.com>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15717.52317.654149.636236@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2002  15:47 +1000, Peter Chubb wrote:
> This part just fixes printk() formats to allow sector_t to be either
> 32 or 64 bit.

> @@ -175,8 +175,8 @@
>                  drv = &h->drv[i];
>  		if (drv->block_size == 0)
>  			continue;
> -                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%d\n",
> -                                ctlr, i, drv->block_size, drv->nr_blocks);
> +                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%llu\n",
> +                                ctlr, i, drv->block_size, (unsigned long long)drv->nr_blocks);

Ugh.  My personal preference would be to have two things:

1) A kernel-wide definition like the following, maybe in asm/types where
   the __u64 types are defined in the first place, to fix printing of __u64
   (granted, this isn't exactly your problem, but it is related):

#if BITS_PER_LONG > 32
#define PFU64 "%lu"
#define PFD64 "%ld"
#define PFX64 "%lx"
#else
#define PFU64 "%Lu"
#define PFD64 "%Ld"
#define PFX64 "%Lx"
#endif

Then the following works properly without ugly casts or warnings:

	__u64 val = 1;

	printk("at least "PFU64" of your u64s are belong to us\n", val);

2) Define the sector_t printing similarly so it works without casting:

#if SECTOR_T_BITS == 64 // or whatever
#define PFST "%lu"
#else
#define PFST "%Lu"
#endif

	size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks="PFST"\n",
		ctlr, i, drv->block_size, drv->nr_blocks);

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

