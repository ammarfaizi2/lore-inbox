Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUENAOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUENAOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 20:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUENAOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 20:14:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14060 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264208AbUENAOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 20:14:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Fri, 14 May 2004 02:14:07 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A404A5.8070500@keyaccess.nl>
In-Reply-To: <40A404A5.8070500@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405140214.08136.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 01:28, Rene Herman wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Comments, suggestions, complains?
>
> Yes, this works to stop it from complaining (on 6Y120P0). It comes up
> with write cache enabled, and hdparm -W0/-W1 work to disable/enable
> write cache as evidenced by the tiobench results. Not as evidenced by
> /proc/ide/hda/settings (drive->wcache) which is always 1 and which will
> probably confuse more users than just me -- I believe I saw hdparm just
> pushes a drive command through an ioctl?

Yep, you are right and we shouldn't worry about confusion too much,
we have similar situation till now (wcache was zero even if enabled).

> Question though:
> > @@ -1678,8 +1683,12 @@ static void idedisk_setup (ide_drive_t *
> >  #endif	/* CONFIG_IDEDISK_MULTI_MODE */
> >  	}
> >  	drive->no_io_32bit = id->dword_io ? 1 : 0;
> > -	if (drive->id->cfs_enable_2 & 0x3000)
> > -		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> > +
> > +	/* write cache enabled? */
> > +	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
> > +		drive->wcache = 1;
> > +
> > +	write_cache(drive, 1);
>
> write_cache() also sets drive->wcache (to the argument, 1 in this case)
> and you call that unconditionally, so the "if (foo) drive->wcache = 1"
> seems superfluous. If the idea indeed is to unconditionally enable write
> cache, it seems just

Please look at write_cache(), it will try to {en,dis}able write cache
and then set drive->wcache *only* if disk has ATA-6 cache flush bits.

I think that we can change write_cache() to always allow enabling of
write cache so hdparm can be fixed to use HDIO_{GET,SET}_WCACHE ioctls
but we should be careful about always enabling write cache in a driver
(there may be some unknown yet side-effects).

Whatever we decide we can do this later after this patch is merged.

> write_cache(drive, 1);
>
> would be equivalent. Or if that wasn't the intention, maybe:
>
> if (foo)
> 	write_cache(drive, 1);
>
> or if it should in fact be disabled if (!foo):
>
> write_cache(drive, (id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)));
>
> or ...
>
> Ignore me if I completely missed the point, just looks odd.

:-)

Thanks,
Bartlomiej


