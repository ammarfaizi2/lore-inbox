Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUG2J1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUG2J1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUG2J1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:27:49 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:9574 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267426AbUG2J0L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:26:11 -0400
From: tabris <tabris@tabris.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Repost] IDE error 2.6.7-rc3-mm2 and 2.6.8-rc1-mm1
Date: Thu, 29 Jul 2004 05:26:02 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407220659.22948.tabris@tabriel.tabris.net> <200407271407.10631.tabris@tabris.net> <20040727195224.GA10654@suse.de>
In-Reply-To: <20040727195224.GA10654@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407290526.08113.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 27 July 2004 3:52 pm, Jens Axboe wrote:
> On Tue, Jul 27 2004, tabris wrote:
> > On Thursday 22 July 2004 11:39 am, Jens Axboe wrote:
> > > On Thu, Jul 22 2004, Tabris wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> >
>
> Try this.
	Works. I don't see the error in my syslog anymore. Thank you. Hopefully 
this fix will make it into -mm and/or mainline soon.
>
> --- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-22
> 13:37:09.000000000 -0200 +++
> linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-27
> 03:39:11.016545806 -0200 @@ -1248,7 +1248,8 @@
>
>  	memset(rq->cmd, 0, sizeof(rq->cmd));
>
> -	if ((drive->id->cfs_enable_2 & 0x2400) == 0x2400)
> +	if (ide_id_has_flush_cache_ext(drive->id) &&
> +	    (drive->capacity64 >= (1UL << 28)))
>  		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
>  	else
>  		rq->cmd[0] = WIN_FLUSH_CACHE;
> @@ -1616,9 +1617,8 @@
>  	 * properly. We can safely support FLUSH_CACHE on lba48, if
> capacity * doesn't exceed lba28
>  	 */
> -	barrier = 1;
> +	barrier = ide_id_has_flush_cache(id);
>  	if (drive->addressing == 1) {
> -		barrier = ide_id_has_flush_cache(id);
>  		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
>  			barrier = 0;
>  	}
> --- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22
> 13:37:09.000000000 -0200 +++
> linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22
> 13:38:23.000000000 -0200 @@ -67,7 +67,8 @@
>  	rq->buffer = buf;
>  	rq->buffer[0] = WIN_FLUSH_CACHE;
>
> -	if (ide_id_has_flush_cache_ext(drive->id))
> +	if (ide_id_has_flush_cache_ext(drive->id) &&
> +	    (drive->capacity64 >= (1UL << 28)))
>  		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
>  }

- -- 
Actually, what I'd like is a little toy spaceship!!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCMKu1U5ZaPMbKQcRApIoAJ4tqGgBsO5nekX8zGzYchr08puxaQCePWiv
xMyfv0AGbauPXXsxw1zSVA4=
=aftH
-----END PGP SIGNATURE-----
