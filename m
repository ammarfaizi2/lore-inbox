Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276686AbRJKS3v>; Thu, 11 Oct 2001 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276682AbRJKS3n>; Thu, 11 Oct 2001 14:29:43 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:48396 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S276686AbRJKS3b>; Thu, 11 Oct 2001 14:29:31 -0400
Date: Thu, 11 Oct 2001 12:33:22 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Vincent Sweeney <v.sweeney@dexterus.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Lost Partition
Message-ID: <20011011123322.B29671@vger.timpanogas.org>
In-Reply-To: <3BC58D32.F500422@dexterus.com> <Pine.GSO.4.21.0110110919021.22698-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0110110919021.22698-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 09:19:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al,

Please check the NWFS code posted at vger.timpanogas.org, specifically,
nwconfig.c (top area of file).  One thing NetWare did that I thought
was rather clever was to stamp a copy of the boot sector into the 
second sector of every new partition in the event someone ever 
wrote to the boot sector and trashed someone's partition table.  I
do not know if Linux has something like this, but it was sure a lifesaver
when errant NLMs stepped all over the hard drive and trashed the 
boot sector, causing all the partition info to get wiped.  Each 
partition header was time stamped so someone could just scan the 
first two sectors of every partition (after locating the fist one
via brute force) and determine which copy was most recent.  

I realize this may not have been the problem here, but it would sure
make it easier for EXT3, REISER, etc. to recover trashed partition
tables a lot easier than custom patches if Linux could pick a sector
on one of these volumes, and make it a bogus file or something by
default and stamp a copy of the boot sector into every partition
that gets created along with a time stamp of some sort so you know 
which one is most recent.  Then fsck would be able to recover hosed
partition tables very quickly.

:-)

Jeff

On Thu, Oct 11, 2001 at 09:19:58AM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 11 Oct 2001, Vincent Sweeney wrote:
> 
> > I have just upgrade my kernel to 2.4.12 and in the process I've lost a
> > partition on my secondary IDE drive. Since this is my /usr partition
> > it's kind of important ;)
> 
> Please, see if the following fixes the problem.
> 
> --- S11/fs/partitions/msdos.c	Tue Oct  9 21:47:27 2001
> +++ /tmp/msdos.c	Thu Oct 11 09:18:22 2001
> @@ -103,21 +103,20 @@
>   */
>  
>  static void extended_partition(struct gendisk *hd, struct block_device *bdev,
> -				int minor, int *current_minor)
> +			int minor, unsigned long first_size, int *current_minor)
>  {
>  	struct partition *p;
>  	Sector sect;
>  	unsigned char *data;
> -	unsigned long first_sector, first_size, this_sector, this_size;
> +	unsigned long first_sector, this_sector, this_size;
>  	int mask = (1 << hd->minor_shift) - 1;
>  	int sector_size = get_hardsect_size(to_kdev_t(bdev->bd_dev)) / 512;
>  	int loopct = 0;		/* number of links followed
>  				   without finding a data partition */
>  	int i;
>  
> -	first_sector = hd->part[minor].start_sect;
> -	first_size = hd->part[minor].nr_sects;
> -	this_sector = first_sector;
> +	this_sector = first_sector = hd->part[minor].start_sect;
> +	this_size = first_size;
>  
>  	while (1) {
>  		if (++loopct > 100)
> @@ -133,8 +132,6 @@
>  
>  		p = (struct partition *) (data + 0x1be);
>  
> -		this_size = hd->part[minor].nr_sects;
> -
>  		/*
>  		 * Usually, the first entry is the real data partition,
>  		 * the 2nd entry is the next extended partition, or empty,
> @@ -196,6 +193,7 @@
>  			goto done;	 /* nothing left to do */
>  
>  		this_sector = first_sector + START_SECT(p) * sector_size;
> +		this_size = NR_SECTS(p) * sector_size;
>  		minor = *current_minor;
>  		put_dev_sector(sect);
>  	}
> @@ -586,12 +584,13 @@
>  		}
>  #endif
>  		if (is_extended_partition(p)) {
> +			unsigned long size = hd->part[minor].nr_sects;
>  			printk(" <");
>  			/* prevent someone doing mkfs or mkswap on an
>  			   extended partition, but leave room for LILO */
> -			if (hd->part[minor].nr_sects > 2)
> +			if (size > 2)
>  				hd->part[minor].nr_sects = 2;
> -			extended_partition(hd, bdev, minor, &current_minor);
> +			extended_partition(hd, bdev, minor, size, &current_minor);
>  			printk(" >");
>  		}
>  	}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
