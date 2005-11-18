Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVKRQSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVKRQSB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVKRQSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:18:00 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:44118 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932339AbVKRQSA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cBMXUdMqGmHI2tXvtitMz6cxLTEmpmfN0a56E+3ntO6k0SxzKxPhJbfZA8lRMpkQs3wAgrnTxy5AD3wSycvBSm1NkSxbhFI+ZiD8MqAdo/JyDMqmLblOBZCfUzEeFoHqdtubd/ns5iYUH4cW6ST2jyNtRBKBI2s2IRp3rsHM3BA=
Message-ID: <58cb370e0511180817p48602e3ap6d3ef49b842e8a00@mail.gmail.com>
Date: Fri, 18 Nov 2005 17:17:58 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support to IDE
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <437DF271.6050702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.5A77ED53@htj.dyndns.org>
	 <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
	 <437DF271.6050702@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Tejun Heo <htejun@gmail.com> wrote:
> Hi, Bartlomiej.
>
> Bartlomiej Zolnierkiewicz wrote:
> > On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> >
> > What does happen for fua && drive->vdma case?
> >
>
> Thanks for pointing out, wasn't thinking about that.  Hmmm... When using
> vdma, single-sector PIO commands are issued instead but there's no
> single-sector FUA PIO command.  Would issuing
> ATA_CMD_WRITE_MULTI_FUA_EXT instead of ATA_CMD_WRITE_FUA_EXT work?  Or
> should I just disable FUA on vdma case?

Probably it should work fine given that drive->mult_count is on.

The only controller using drive->vdma in the current tree is cs5520
so you should confirm this with Mark Lord & Alan Cox.

> >
> >>                        } else {
> >>                                command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
> >>                                if (drive->vdma)
> >>@@ -284,8 +298,20 @@ static ide_startstop_t __ide_do_rw_disk(
> >>        } else {
> >>                if (drive->mult_count) {
> >>                        hwif->data_phase = TASKFILE_MULTI_OUT;
> >>-                       command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
> >>+                       if (!fua)
> >>+                               command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
> >>+                       else
> >>+                               command = ATA_CMD_WRITE_MULTI_FUA_EXT;
> >>                } else {
> >>+                       if (unlikely(fua)) {
> >>+                               /*
> >>+                                * This happens if multisector PIO is
> >>+                                * turned off during operation.
> >>+                                */
> >>+                               printk(KERN_ERR "%s: FUA write but in single "
> >>+                                      "sector PIO mode\n", drive->name);
> >>+                               goto fail;
> >>+                       }
> >
> >
> > Wouldn't it be better to do the following check at the beginning
> > of __ide_do_rw_disk() (after checking for dma vs lba48):
> >
> >         if (fua) {
> >                 if (!lba48 || ((!dma || drive->vdma) && !drive->mult_count))
> >                         goto fail_fua;
> >         }
> >
> > ...
> >
> > and fail the request if needed *before* actually touching any
> > hardware registers?
> >
> > fail_fua:
> >         printk(KERN_ERR "%s: FUA write unsupported (lba48=%u dma=%u"
> >                                        " vdma=%u mult_count=%u)\n", drive->name,
> >                                        lba48, dma, drive->vdma,
> > drive->mult_count);
> >         ide_end_request(drive, 0, 0);
> >         return ide_stopped;
> >
>
> Hmmm... The thing is that those failure cases will happen extremely
> rarely if at all.  Remember this post?
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111798102108338&w=3
>
> It's mostly guaranteed that those failure cases don't occur, so I
> thought avoiding IO on failure case wasn't that helpful.

There are two problems with this approach:

* configuration can change dynamically
* locking for configuration changes is flakey

so it can happen that FUA request will slip into __ide_do_rw_disk().

The best way to deal with such case is to kill it early without
touching I/O registers and/or DMA engine and causing big havoc.

> >>@@ -967,10 +997,19 @@ static void idedisk_setup (ide_drive_t *
> >>                        barrier = 0;
> >>        }
> >>
> >>-       printk(KERN_INFO "%s: cache flushes %ssupported\n",
> >>-               drive->name, barrier ? "" : "not ");
> >>+       fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
> >>+       /* When using PIO, FUA needs multisector. */
> >>+       if ((!drive->using_dma || drive->hwif->no_lba48_dma) &&
> >>+           drive->mult_count == 0)
> >>+               fua = 0;
> >
> >
> > Shouldn't this check also for drive->vdma?
> >
>
> Yes, it does.  Thanks for pointing out.  One question though.  FUA
> support should be changed if using_dma/mult_count settings are changed.
>   As using_dma configuration is handled by IDE midlayer, we might need
> to add a callback there.  What do you think?

It seems it is needed nowadays as there are multiple I/O barrier methods.

Maybe the other alternative is to add ->rq_select_barrier() hook to the
block layer and for each request check what kind of barrier should be
issued (it still won't help for flakey configuration locking but you won't
have to add any callbacks etc).

Long-term we should see if it is possible to remove dynamic IDE
drive configuration and always just use the best possible settings.

Thanks,
Bartlomiej
