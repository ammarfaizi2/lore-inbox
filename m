Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUE1Piv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUE1Piv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUE1Piu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:38:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35996 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263467AbUE1Pin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:38:43 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Date: Fri, 28 May 2004 17:40:50 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040527194920.A1709@jurassic.park.msu.ru> <200405271940.49386.bzolnier@elka.pw.edu.pl> <20040528191028.A1117@jurassic.park.msu.ru>
In-Reply-To: <20040528191028.A1117@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405281740.50798.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 of May 2004 17:10, Ivan Kokshaysky wrote:
> On Thu, May 27, 2004 at 07:40:49PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Would #ifdef __alpha__ be better?
> >
> > actually CONFIG_ALPHA + comment why it is needed
>
> Ok, but now I'm thinking of probably better solution:
> consider sys_state == SYSTEM_HALT as another special case
> where we put the disk into standby mode *only* if it does
> have write cache but doesn't suppurt cache flush command
> (or cache flush fails for some reason).
>
> Hopefully, most drives won't be spun down on halt.
> I think that it should be acceptable for x86 as well.

- AFAIR there are some buggy disks having flush cache
  bits that need standby anyway

- you will hit 'halt problem' on alpha if your disk has
  write cache enabled and it doesn't have flush cache bits

-EAGAIN ;)

> Ivan.
>
> --- 2.6/drivers/ide/ide-disk.c	Fri May 28 17:46:35 2004
> +++ linux/drivers/ide/ide-disk.c	Fri May 28 18:42:47 2004
> @@ -1686,13 +1686,19 @@ static void idedisk_setup (ide_drive_t *
>  #endif
>  }
>
> -static void ide_cacheflush_p(ide_drive_t *drive)
> +static int ide_cacheflush_p(ide_drive_t *drive)
>  {
> -	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
> -		return;
> +	if (!drive->wcache)
> +		return 0;
> +
> +	if (!ide_id_has_flush_cache(drive->id))
> +		return 1;
>
> -	if (do_idedisk_flushcache(drive))
> -		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
> +	if (!do_idedisk_flushcache(drive))
> +		return 0;
> +
> +	printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
> +	return 1;
>  }
>
>  static int idedisk_cleanup (ide_drive_t *drive)
> @@ -1713,10 +1719,16 @@ static void ide_device_shutdown(struct d
>  {
>  	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
>
> +	/* Never spin the disk down on reboot. */
>  	if (system_state == SYSTEM_RESTART) {
>  		ide_cacheflush_p(drive);
>  		return;
>  	}
> +
> +	/* Spin the disk down on halt only if attempt to flush the
> +	   write cache fails. */
> +	if (system_state == SYSTEM_HALT && !ide_cacheflush_p(drive))
> +		return;
>
>  	printk("Shutdown: %s\n", drive->name);
>  	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);

