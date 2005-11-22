Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVKVIjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVKVIjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVKVIjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:39:48 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:45359 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751269AbVKVIjr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:39:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ocvL2o8U8h1GnPXZNE2nlA1qWxdV3/4RHU7NZs1M+DLmJmHre/33mk9nYUXuNMEcWKm0CEx/lIv6U2nABCehzoejwp40eU6oG54DLqybiNAxB2jTySGE1Z4Yys4MaVTFoDssLhpOroGWgUFXB+I05B5UZh+T5fdX/YzAfhWmzg0=
Message-ID: <58cb370e0511220039m40633ab5n3468dee2e38b6128@mail.gmail.com>
Date: Tue, 22 Nov 2005 09:39:46 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.061D8991@htj.dyndns.org>
	 <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
	 <437DEE35.9060901@gmail.com>
	 <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
	 <20051122024401.GB10213@htj.dyndns.org>
	 <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thinko

On 11/22/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> > > > >> static void ide_cacheflush_p(ide_drive_t *drive)
> > > > >>@@ -1034,6 +993,8 @@ static int ide_disk_remove(struct device
> > > > >>        struct ide_disk_obj *idkp = drive->driver_data;
> > > > >>        struct gendisk *g = idkp->disk;
> > > > >>
> > > > >>+       blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
> > > > >>+
> > > > >
> > > > >
> > > > > Shouldn't this be done in ide_disk_release()?
> > > >
> > > > Hmmm... The thing is that, AFAIK, requests are not supposed to be issued
> > > > after ->remove is called (->remove is called only on module unload
> > > > unless hardware is hot-unplugged and HL driver cannot be unloaded while
> > > > it's still opened).  I think that's why both sd and ide-disk issue the
> > > > last cache flush in ->remove callbacks but not in ->release.
> > >
> > > Are you sure?  I think that only calling del_gendisk() assures you
> > > that there won't be outstanding fs requests?
> > >
> > > I have also noticed bug in ide_disk_remove() - ide_cacheflush_p()
> > > should be called after del_gendisk() - I will fix it later.
> > >
> > > BTW Nowadays you can dynamically dettach/attach driver from/to
> > > device using sysfs interface.
> >
> > I agree that it should go into ->release, but I am still a bit scared
> > about issuing commands in ->release (it might access some data
> > structure which might be gone by then).  Also, the correct order seems
> > to be 'turning off ordered' and then 'perform the last cache flush'.
> > So, how about adding blk_queue_ordered right above the last
> > ide_cacheflush_p() now and move both to ->release in a separate patch
> > for both IDE and SCSI?
>
> Not needed, when ide-disk is fixed to call del_gendisk() after
> ide_cacheflush_p(), we can add blk_queue_orderer() before

ide_cacheflush_p() after del_gendisk()

> the latter and then everything should be OK.

blk_queue_ordererd() before ide_cache_flush_p()

:)
