Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132663AbQKDKTj>; Sat, 4 Nov 2000 05:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbQKDKTU>; Sat, 4 Nov 2000 05:19:20 -0500
Received: from Cantor.suse.de ([194.112.123.193]:45062 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132663AbQKDKTM>;
	Sat, 4 Nov 2000 05:19:12 -0500
Date: Sat, 4 Nov 2000 11:19:09 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
Message-ID: <20001104111909.A11500@gruyere.muc.suse.de>
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A03DABD.AF4B9AD5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 04, 2000 at 04:45:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 04:45:33AM -0500, Jeff Garzik wrote:
> 
> > *       What about dev->open and dev->stop ?
> 
> Sleep all you want, we'll leave the light on for ya.


... but make sure you have no module unload races (or at least not too
huge holes, some are probably unavoidable with the current network
driver interface, e.g. without moving module count management a bit up). 
This means you should do MOD_INC_USE_COUNT very early at least to
minimize the windows (and DEC_USE_COUNT very late) 

> dev->do_ioctl:
> 	Locking: Inside rtnl_lock() semaphore.
> 	Sleeping: OK

Just make sure you lock against your interrupt and xmit threads.

> 	Locking: Inside dev->xmit_lock spinlock.
> 	Sleeping: NO[1]
> 
> 
> NOTE [1]: On principle, you should not sleep when a spinlock is held.
> However, since this spinlock is per-net-device, we only block ourselves
> if we sleep, so the effect is mitigated.

Sounds like dangerous advice.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
