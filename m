Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVIMIgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVIMIgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVIMIgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:36:46 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:47057 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbVIMIgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XEZ7mi+q3N81xLZ+3Oza2n742WvCLz6q8VuUXKtiSSOqO6XQncO4/RVEAkRwACG9pm1aiOTtt1I3bV/1vkjYe1nRK/ftU07Fyv78/uZ8a18BEvFIw48wpn14bdUQJNPVOh2qRW0Vivk9EarSUq1PvASdIrYjRoWMZ/8IciG4Bpo=
Message-ID: <58cb370e050913013677fec525@mail.gmail.com>
Date: Tue, 13 Sep 2005 10:36:42 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: bzolnier@gmail.com
To: Thomas Kleffel <tk@maintech.de>
Subject: Re: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is removed while mounted.
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4325C448.6000303@maintech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431DE5E8.8000703@maintech.de>
	 <58cb370e05091207435b91206f@mail.gmail.com>
	 <4325C448.6000303@maintech.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Thomas Kleffel <tk@maintech.de> wrote:
> Hi,
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >> [...]
> >>1b) When a disk is released by disk_release(), its queue's reference
> >>count shall be decremented by calling blk_cleanup_queue().
> >
> >
> > Which conflicts with IDE layer reference counting  & locking scheme
> > as IDE layer can send (special) requests to the device without any
> > device driver loaded.
> 
> But the IDE layer won't do that anymore after ide_unregister() was
> called, while a device driver doesn't know that the device doesn't exist
> anymore, so it may still access the queue until it releases the disk.

The point is that you have added blk_cleanup_queue() to the ide-disk
driver release function and it is perfectly fine for IDE layer to send requests
after unloading ide-disk driver.

> >>2a) When a physical drive is released by drive_release_dev(), the
> >>corresponding queue is marked dead, so that no further calls to the
> >>physical device's queue-handler are made.
> >>
> >>2b) When a request is submitted to a dead queue using
> >>generic_make_request(), the request shall be failed immedaiately with
> >>-ENXIO which causes the caller to recive a "Bus error". This is the same
> >>beaviour as when a USB-Storage device gets pulled while in use.
> >
> >
> > The fix would be to fail the previous requests during removal of the
> > device [ somebody already posted a patch to do that but I didn't have
> > time to give it proper thought ] or alternatively to add the offline state to
> > the device [ so processing of the requests would be resumed after device
> > is online again ].
> 
> I don't think it'd be wise to resume request processing on the same
> device as the CF Card inserted again might not be the same one as the
> user pulled out before. Performing old, cached writes on the new card
> could destroy innocent data.

Yes, that is why failing old requests is a preferred solution.

>  From your responses I read that the correct solution would be to keep
> the old pysical device as long as the ide layer still has references to
> it and to fail all requests in the meantime.
> 
> Is that correct?

Yes, we should just fail all the requests if the device is not present.
[ What do you mean by the old physical device, old 'ide_drive_t *'? ]

Regards,
Bartlomiej

> Best regards,
> 
> Thomas
> 
> 
> 
>
