Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUAWPLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUAWPLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:11:19 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5045 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266569AbUAWPKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:10:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pascal Schmidt <der.eremit@email.de>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
Date: Fri, 23 Jan 2004 16:12:47 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
In-Reply-To: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401231612.47506.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pascal!

> --- linux-2.6.2-rc1/drivers/ide/ide-cd.h.orig	Thu Jan 22 18:05:04 2004
> +++ linux-2.6.2-rc1/drivers/ide/ide-cd.h	Thu Jan 22 18:07:14 2004
> @@ -109,6 +109,7 @@ struct ide_cd_state_flags {
>  	__u8 door_locked   : 1; /* We think that the drive door is locked. */
>  	__u8 writing       : 1; /* the drive is currently writing */
>  	__u8 reserved      : 4;
> +	byte sectors_per_frame;	/* Current sectors per hw frame */
>  	byte current_speed;	/* Current speed of the drive */
>  };

Please don't use 'byte' type in your patch, use 'u8' instead.

> @@ -1346,13 +1332,14 @@ static ide_startstop_t cdrom_seek_intr (
>  static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
>  {
>  	struct request *rq = HWGROUP(drive)->rq;
> +	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
>  	int sector, frame, nskip;
>
>  	sector = rq->sector;
> -	nskip = (sector % SECTORS_PER_FRAME);
> +	nskip = (sector % sectors_per_frame);
>  	if (nskip > 0)
>  		sector -= nskip;
> -	frame = sector / SECTORS_PER_FRAME;
> +	frame = sector / sectors_per_frame;
>
>  	memset(rq->cmd, 0, sizeof(rq->cmd));
>  	rq->cmd[0] = GPCMD_SEEK;

You can as well clean this up while at it.
We don't need 'nskip' for calculating 'frame',

	frame = rq->sector / sectors_per_frame;

should be enough.

--bart

