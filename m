Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUE2SKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUE2SKD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUE2SKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:10:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63402 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264330AbUE2SJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:09:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Date: Sat, 29 May 2004 20:07:38 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040527194920.A1709@jurassic.park.msu.ru> <200405281740.50798.bzolnier@elka.pw.edu.pl> <20040529013738.A629@den.park.msu.ru>
In-Reply-To: <20040529013738.A629@den.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405292007.38248.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 of May 2004 23:37, Ivan Kokshaysky wrote:
> On Fri, May 28, 2004 at 05:40:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > - AFAIR there are some buggy disks having flush cache
> >   bits that need standby anyway
>
> Oh horror. I wouldn't be surprised if some drives don't flush
> the cache even on standby...
>
> > - you will hit 'halt problem' on alpha if your disk has
> >   write cache enabled and it doesn't have flush cache bits
> >
> > -EAGAIN ;)
>
> Yep... :-(
>
> Here's variant of the first patch with CONFIG_ALPHA and a Very Big Comment.

Looks good, thanks!

> Ivan.
>
> --- 2.6/drivers/ide/ide-disk.c	Sat May 29 00:43:41 2004
> +++ linux/drivers/ide/ide-disk.c	Sat May 29 00:43:06 2004
> @@ -1713,7 +1713,22 @@ static void ide_device_shutdown(struct d
>  {
>  	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
>
> +#ifdef	CONFIG_ALPHA
> +	/* On Alpha, halt(8) doesn't actually turn the machine off,
> +	   it puts you into the sort of firmware monitor. Typically,
> +	   it's used to boot another kernel image, so it's not much
> +	   different from reboot(8). Therefore, we don't need to
> +	   spin down the disk in this case, especially since Alpha
> +	   firmware doesn't handle disks in standby mode properly.
> +	   On the other hand, it's reasonably safe to turn the power
> +	   off when the shutdown process reaches the firmware prompt,
> +	   as the firmware initialization takes rather long time -
> +	   at least 10 seconds, which should be sufficient for
> +	   the disk to expire its write cache. */
> +	if (system_state != SYSTEM_POWER_OFF) {
> +#else
>  	if (system_state == SYSTEM_RESTART) {
> +#endif
>  		ide_cacheflush_p(drive);
>  		return;
>  	}

