Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbQKDPhD>; Sat, 4 Nov 2000 10:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDPgy>; Sat, 4 Nov 2000 10:36:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50191 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129040AbQKDPgl>;
	Sat, 4 Nov 2000 10:36:41 -0500
Message-ID: <3A042D04.5B3A7946@mandrakesoft.com>
Date: Sat, 04 Nov 2000 10:36:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Sat, Nov 04, 2000 at 04:45:33AM -0500, Jeff Garzik wrote:
> >
> > > *       What about dev->open and dev->stop ?
> >
> > Sleep all you want, we'll leave the light on for ya.
> 
> ... but make sure you have no module unload races (or at least not too
> huge holes, some are probably unavoidable with the current network
> driver interface, e.g. without moving module count management a bit up).
> This means you should do MOD_INC_USE_COUNT very early at least to
> minimize the windows (and DEC_USE_COUNT very late)

Can you provide a trace of a race or deadlock?  I do not see where there
are races in the current 2.4.x code.


> > dev->do_ioctl:
> >       Locking: Inside rtnl_lock() semaphore.
> >       Sleeping: OK
> 
> Just make sure you lock against your interrupt and xmit threads.

But of course :)  My doc only covered locks external to the driver.


> >       Locking: Inside dev->xmit_lock spinlock.
> >       Sleeping: NO[1]
> >
> >
> > NOTE [1]: On principle, you should not sleep when a spinlock is held.
> > However, since this spinlock is per-net-device, we only block ourselves
> > if we sleep, so the effect is mitigated.
> 
> Sounds like dangerous advice.

Probably... I changed the doc "just say no" :)

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
