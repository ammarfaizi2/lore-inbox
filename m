Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSALLqF>; Sat, 12 Jan 2002 06:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285783AbSALLp4>; Sat, 12 Jan 2002 06:45:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7493 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285747AbSALLpk>; Sat, 12 Jan 2002 06:45:40 -0500
Date: Sat, 12 Jan 2002 12:45:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, bcrl@redhat.com,
        axboe@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Mostly PAGE_SIZE IO for RAW (NEW VERSION)
Message-ID: <20020112124504.C1482@inspiron.school.suse.de>
In-Reply-To: <200201112351.g0BNp8912572@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201112351.g0BNp8912572@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Fri, Jan 11, 2002 at 03:51:08PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:51:08PM -0800, Badari Pulavarty wrote:
> diff -Nur -X dontdiff linux/drivers/block/ll_rw_blk.c linux-2417newvary/drivers/block/ll_rw_blk.c
> --- linux/drivers/block/ll_rw_blk.c	Mon Oct 29 12:11:17 2001
> +++ linux-2417newvary/drivers/block/ll_rw_blk.c	Fri Jan 11 16:58:37 2002
> @@ -874,20 +881,7 @@
>  }
>  
>  
> -/**
> - * submit_bh: submit a buffer_head to the block device later for I/O
> - * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
> - * @bh: The &struct buffer_head which describes the I/O
> - *
> - * submit_bh() is very similar in purpose to generic_make_request(), and
> - * uses that function to do most of the work.
> - *
> - * The extra functionality provided by submit_bh is to determine
> - * b_rsector from b_blocknr and b_size, and to set b_rdev from b_dev.
> - * This is is appropriate for IO requests that come from the buffer
> - * cache and page cache which (currently) always use aligned blocks.
> - */
> -void submit_bh(int rw, struct buffer_head * bh)
> +static inline void submit_bh_rsector(int rw, struct buffer_head * bh, int rsect)
>  {
>  	int count = bh->b_size >> 9;
>  
> @@ -901,7 +895,7 @@
>  	 * further remap this.
>  	 */
>  	bh->b_rdev = bh->b_dev;
> -	bh->b_rsector = bh->b_blocknr * count;
> +	bh->b_rsector = rsect;
>  
>  	generic_make_request(rw, bh);
>  
> @@ -913,6 +907,33 @@
>  			kstat.pgpgin += count;
>  			break;
>  	}
> +}
> +
> +/**
> + * submit_bh: submit a buffer_head to the block device later for I/O
> + * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
> + * @bh: The &struct buffer_head which describes the I/O
> + *
> + * submit_bh() is very similar in purpose to generic_make_request(), and
> + * uses that function to do most of the work.
> + *
> + * The extra functionality provided by submit_bh is to determine
> + * b_rsector from b_blocknr and b_size, and to set b_rdev from b_dev.
> + * This is is appropriate for IO requests that come from the buffer
> + * cache and page cache which (currently) always use aligned blocks.
> + */
> +void submit_bh(int rw, struct buffer_head * bh)
> +{
> +	submit_bh_rsector(rw, bh, bh->b_blocknr * (bh->b_size >> 9));
> +}
> +
> +/*
> + * submit_bh_blknr() - same as submit_bh() except that b_rsector is
> + * set to b_blocknr. Used for RAW VARY.
> + */
> +void submit_bh_blknr(int rw, struct buffer_head * bh)
> +{
> +	submit_bh_rsector(rw, bh, bh->b_blocknr);
>  }
>  
>  /**

I find confusing to mix the semantics of b_blocknr with b_rsector,
they've different meanings, I'd prefer if you would recall
submit_bh_rsector directly, rather than adding a submit_bh_blknr. You
can implement submit_bh_rsector extern for buffer.c and inline for
ll_rw_block, so submit_bh remains fast and you still avoid code
duplication.

> diff -Nur -X dontdiff linux/drivers/char/raw.c linux-2417newvary/drivers/char/raw.c
> --- linux/drivers/char/raw.c	Sat Sep 22 20:35:43 2001
> +++ linux-2417newvary/drivers/char/raw.c	Fri Jan 11 21:37:16 2002
> @@ -308,6 +312,7 @@
>  	sector_bits = raw_devices[minor].sector_bits;
>  	sector_mask = sector_size- 1;
>  	max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);
> +	can_do_varyio = raw_devices[minor].can_do_vary;
>  	
>  	if (blk_size[MAJOR(dev)])
>  		limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
> @@ -350,8 +355,12 @@
>  
>  		for (i=0; i < blocks; i++) 
>  			iobuf->blocks[i] = blocknr++;
> +
> +		iobuf->dovary = can_do_varyio;
>  		
>  		err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
> +
> +		iobuf->dovary = 0;
>  
>  		if (rw == READ && err > 0)
>  			mark_dirty_kiobuf(iobuf, err);

I don't think you need to initialize this bit in any fast path,
initializing it in raw_open for the preallocated iobuf, and after the
alloc_kiovec of the slow path of rw_raw_dev should be enough.

> diff -Nur -X dontdiff linux/drivers/scsi/sd.c linux-2417newvary/drivers/scsi/sd.c
> --- linux/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
> +++ linux-2417newvary/drivers/scsi/sd.c	Fri Jan 11 21:34:19 2002
> @@ -1241,6 +1241,8 @@
>  	return 1;
>  }
>  
> +#define SD_DISK_MAJOR(i)	SD_MAJOR((i) >> 4)
> +
>  static int sd_attach(Scsi_Device * SDp)
>  {
>          unsigned int devnum;
> @@ -1274,6 +1276,22 @@
>  	printk("Attached scsi %sdisk %s at scsi%d, channel %d, id %d, lun %d\n",
>  	       SDp->removable ? "removable " : "",
>  	       nbuff, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
> +
> +	if (SDp->host->hostt->can_do_varyio) {
> +		char *varyio;
> +
> +		varyio = blkdev_varyio[SD_DISK_MAJOR(i)];
> +		if (varyio == NULL) {
> +			varyio =  kmalloc((sd_template.dev_max << 4), GFP_ATOMIC);

how big is this kmalloc (dunno on top of my head, depends on .dev_max)?
The only thing we must make sure is that insmod sd.c won't fail because
of fragmentation (in such case either make it static [so it will be in
the module vmalloced space automatically] or use vmalloc instead).

This updated patch looked much better btw :).

Andrea
