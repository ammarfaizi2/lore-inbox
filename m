Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbUBLVar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUBLVar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:30:47 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:6975 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266270AbUBLVap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:30:45 -0500
Date: Fri, 13 Feb 2004 08:28:11 +1100
From: Nathan Scott <nathans@sgi.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-lvm@sistina.com
Subject: Re: 2.6.3-rc2-mm1 (dm)
Message-ID: <20040212212811.GA655@frodo>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212203306.GA13192@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212203306.GA13192@cistron.nl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 09:33:07PM +0100, Miquel van Smoorenburg wrote:
> ...
> However there's still one issue:
> 
> I created a LVM volume on /dev/sda2, called /dev/vg0/test. Then
> I created and mounted an XFS partition on /dev/vg0/test. XFS uses
> a 512 byte blocksize by default, but the underlying /dev/sda2

(thats a 512 byte "sector size" in XFS-speak)

> device had a soft blocksize of 4096 (default after boot is 1024,
> but I had been mucking around with it so it got set to 4096).
> 
> As a result, I couldn't get more than 35 MB/sec write speed out
> of XFS mounted on the LVM device.
> 
> I added this little patch:
> 
> --- drivers/md/dm-table.c.ORIG  2004-02-12 20:49:47.000000000 +0100
> +++ drivers/md/dm-table.c       2004-02-12 20:56:59.000000000 +0100
> @@ -361,7 +361,7 @@
>                 blkdev_put(bdev, BDEV_RAW);
>         else {
>                 d->bdev = bdev;
> -               set_blocksize(bdev, d->bdev->bd_block_size);
> +               set_blocksize(bdev, 512);
>         }
>         return r;
>  }
> 
> This forces the underlying device(s) to a soft blocksize of 512. And
> I had my 80 MB/sec write speed back !
> 
> I'm not sure if setting the blocksize of the underlying device
> always to 512 is the right solution. I think that set_blocksize

Hmm... that set_blocksize there must be new in -mm, I don't see
that in mainline yet.  I would guess that bdev_hardsect_size()
would be more appropriate here than hard-coding 512 bytes.  I
don't know the details of the problem being solving by adding
set_blocksize() in there though, so I might be completely wrong.

cheers.

-- 
Nathan
