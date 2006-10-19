Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423330AbWJSMYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423330AbWJSMYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423332AbWJSMYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:24:25 -0400
Received: from mx7.mail.ru ([194.67.23.27]:43587 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id S1423330AbWJSMYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:24:24 -0400
Date: Thu, 19 Oct 2006 16:25:16 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genhd fix or ide workaround -- choose one
Message-ID: <20061019122516.GA9040@localhost>
Reply-To: cbou@mail.ru
References: <20061018221506.GA4187@localhost> <1161259553.17335.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1161259553.17335.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:05:52PM +0100, Alan Cox wrote:
> Ar Iau, 2006-10-19 am 02:15 +0400, ysgrifennodd Anton Vorontsov:
> > Hi all,
> > 
> > I've caught deadlock inside IDE layer using IDE-CS: after accessing
> > to IDE disk placed in PCMCIA (CF card really), it will never probe
> > again after pulling it from PCMCIA/CF.
> 
> Works for me, and has done for a long time and I've also had no other
> reports of this in the past couple of years so I'm curious what trips it
> in your case ?

It just happens every time on HP iPaq hx4700. hx4700 have internal CF
slot, which is working via pxa2xx pcmcia driver.

Have you tried it recently or about six months ago? Because at that time
it was working for me too, but some kernel change
(I suppose semaphores->completion conversion) unearthed that bug, but I'm
not sure.

> > The kernel is stuck at
> > drivers/ide/ide.c:ide_unregister():604:
> > 
> >         602                 spin_unlock_irq(&ide_lock);
> >         603                 device_unregister(&drive->gendev);
> >         604                 wait_for_completion(&drive->gendev_rel_comp);
> >         605                 spin_lock_irq(&ide_lock);
> 
> We need to know all the references have gone away, if someone has a disk
> referenced and you pull it out we can't clean up immediately so this is
> the right place to get stuck both on a refcounting bug and if you've got
> something holding a reference for real (eg HAL)

No HAL used. No udev used. Bare kernel + static /dev + shell. CF is not
even mounted once.

Have you read comments inside -fix patch? Imho it's obvious that nobody
putting driverfs_device second time, but got it twice.

Thanks,

-- Anton (irc: bd2)
