Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUA0Qds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbUA0Qdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:33:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36552 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265578AbUA0Qdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:33:44 -0500
Date: Tue, 27 Jan 2004 17:33:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
Message-ID: <20040127163339.GB11683@suse.de>
References: <20040127110713.GR11683@suse.de> <Pine.LNX.4.44.0401271406070.881-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401271406070.881-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27 2004, Pascal Schmidt wrote:
> > Hmm, looks a bit strange. You want write protect to be set _if_
> > detection works, not otherwise. If it fails, just assume that you can
> > write to the drive and let the normal drive rejection work fail those
> > (maybe even catch them and write protect then).
> 
> Before I had this worked out, I accidentally tried fscking a
> write-protected disc. Yes, it errored out at the end of the fsck, but
> the error messages are quite unintuitive. Lot's of I/O error in the
> kernel log and an error=0x70 from the drive. I sure didn't realize
> at first what the problem really was.

I'm surprised the sense messages don't show that it's a write to a write
protected disc (xx/27/zz, where xx == 0x07 or 0x05). However, it's even
more annoying to _not_ be able to write to a media because the kernel
thinks it knows better. In your fsck case you sort of get what you ask
for, by shooting yourself in the foot :)

> > Seeing as the method is
> > unreliable, we cannot solely rely on that.
> 
> I've not seen all three variants fail, yet. I was following sd.c's
> example, that also sets write protect by default if it cannot get
> info from the drive.
> 
> It's fine with me either way. Do you want me to resend with the
> default fallback changed?

Yes please.

> Oh, BTW, while I have your attention ;), have you looked at my
> latest variable blocksize support patch for ide-cd? I've tried to
> incorporate yours and Bart's suggestions.
> 
> Here it is again in case you missed it in the thread.
> 
> 
> --- linux-2.6.2-rc1/drivers/ide/ide-cd.c.orig	Sat Jan 24 01:24:03 2004
> +++ linux-2.6.2-rc1/drivers/ide/ide-cd.c	Sat Jan 24 01:39:40 2004
> @@ -294,10 +294,12 @@
>   * 4.60  Dec 17, 2003	- Add mt rainier support
>   *			- Bump timeout for packet commands, matches sr
>   *			- Odd stuff
> + * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
> + *			  Pascal Schmidt <der.eremit@email.de>
>   *
>   *************************************************************************/
>   
> -#define IDECD_VERSION "4.60"
> +#define IDECD_VERSION "4.61"
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> @@ -1211,6 +1213,7 @@ static int cdrom_read_from_buffer (ide_d
>  {
>  	struct cdrom_info *info = drive->driver_data;
>  	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;

Nitpick: sectors_per_frame = queue_hardsect_size(q) >> 9;

That's about, the rest looks fine.

-- 
Jens Axboe

