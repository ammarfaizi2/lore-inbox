Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132926AbRDEPdU>; Thu, 5 Apr 2001 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRDEPdL>; Thu, 5 Apr 2001 11:33:11 -0400
Received: from hermes.sistina.com ([208.210.145.141]:8713 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S132926AbRDEPc7>;
	Thu, 5 Apr 2001 11:32:59 -0400
Date: Thu, 5 Apr 2001 16:32:39 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
To: Jens Axboe <axboe@suse.de>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@EZ-Darmstadt.Telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405163239.F6981@sistina.com>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de> <20010405163818.M418@suse.de> <20010405164942.N418@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010405164942.N418@suse.de>; from axboe@suse.de on Thu, Apr 05, 2001 at 04:49:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

thanks for the b_dev hint you provided.

On Thu, Apr 05, 2001 at 04:49:42PM +0200, Jens Axboe wrote:
> On Thu, Apr 05 2001, Jens Axboe wrote:
> > To the LVM folks: you can't use b_dev or b_blocknr inside your
> > make_request_fn, it destroys stacking drivers such as loop. And
> > is just plain wrong in the general case too.
> 
> Irks, another one. lvm_make_request_fn also needs to call b_end_io
> if a map fails.

This is wrong.

In case of an io error we do already call buffer_IO_error() on 2.4 in lvm_map().

In 2.2 ll_rw_block() does change the state of the buffer and calls
b_end_io() for us at the end of the function:

      sorry:
        for (i = 0; i < nr; i++) {
                if (bh[i]) {
                        clear_bit(BH_Dirty, &bh[i]->b_state);
                        clear_bit(BH_Uptodate, &bh[i]->b_state);
                        bh[i]->b_end_io(bh[i], 0);
                }
        }


> Updated patch attached, I'll collate further
> patches if I find more :-)

Please do that. Thanks again.

Regards,
Heinz    -- The LVM Guy --

>
> 
> -- 
> Jens Axboe
> 

> --- /opt/kernel/linux-2.4.3/drivers/md/lvm.c	Mon Jan 29 01:11:20 2001
> +++ drivers/md/lvm.c	Thu Apr  5 16:48:52 2001
> @@ -148,6 +148,9 @@
>   *                 procfs is always supported now. (JT)
>   *    12/01/2001 - avoided flushing logical volume in case of shrinking
>   *                 because of unecessary overhead in case of heavy updates
> + *    05/04/2001 - lvm_map bugs: don't use b_blocknr/b_dev in lvm_map, it
> + *		   destroys stacking devices. call b_end_io on failed maps.
> + *		   (Jens Axboe)
>   *
>   */
>  
> @@ -1480,14 +1483,14 @@
>   */
>  static int lvm_map(struct buffer_head *bh, int rw)
>  {
> -	int minor = MINOR(bh->b_dev);
> +	int minor = MINOR(bh->b_rdev);
>  	int ret = 0;
>  	ulong index;
>  	ulong pe_start;
>  	ulong size = bh->b_size >> 9;
> -	ulong rsector_tmp = bh->b_blocknr * size;
> +	ulong rsector_tmp = bh->b_rsector;
>  	ulong rsector_sav;
> -	kdev_t rdev_tmp = bh->b_dev;
> +	kdev_t rdev_tmp = bh->b_rdev;
>  	kdev_t rdev_sav;
>  	vg_t *vg_this = vg[VG_BLK(minor)];
>  	lv_t *lv = vg_this->lv[LV_BLK(minor)];
> @@ -1676,8 +1679,12 @@
>   */
>  static int lvm_make_request_fn(request_queue_t *q,
>  			       int rw,
> -			       struct buffer_head *bh) {
> -	return (lvm_map(bh, rw) < 0) ? 0 : 1;
> +			       struct buffer_head *bh)
> +{
> +	int ret = lvm_map(bh, rw);
> +	if (ret)
> +		bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
> +	return ret;
>  }
>  
>  

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
