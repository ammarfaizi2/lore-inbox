Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130050AbQJZSCx>; Thu, 26 Oct 2000 14:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQJZSCo>; Thu, 26 Oct 2000 14:02:44 -0400
Received: from styx.suse.cz ([195.70.145.226]:21491 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130050AbQJZSCd>;
	Thu, 26 Oct 2000 14:02:33 -0400
Date: Thu, 26 Oct 2000 20:02:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Yoann Vandoorselaere <yoann@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001026200220.A492@suse.cz>
In-Reply-To: <20001026190309.A372@suse.cz> <Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Oct 26, 2000 at 01:42:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 01:42:29PM -0400, Richard B. Johnson wrote:

> > > ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> > > to the timer. It writes 0 to the control-word for timer 0. This
> > > does the following:
> [Snipped...]
> >  
> > Well, at least on 2.4.0-test9, the above timing code is #ifed to
> > DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
> > include/linux/ide.h.
> > 
> > So this is not our problem here. Anyway I guess it's time to hunt for
> > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > they're not probably the cause of the problem we see here.
> 
> Okay, good.

Ok, here is a list of places within the kernel that access the PIT
timer, plus the method of locking (i386 arch only):

Usage:						Lock method:

arch/i386/kernel/time.c:170:			spin_lock()
arch/i386/kernel/time.c:491:			spin_lock()
arch/i386/kernel/time.c:575:			none (init)
arch/i386/kernel/i8259.c:491:			none (init)
arch/i386/kernel/apm.c:871:			cli()
arch/i386/kernel/apic.c:398:			spin_lock_irqsave()

drivers/char/vt.c:121:				cli()
drivers/char/ftape/lowlevel/ftape-calibr.c:80:	cli()
drivers/char/ftape/lowlevel/ftape-calibr.c:99: 	cli()
drivers/char/joystick/analog.c:142:		cli() __cli()
drivers/char/joystick/gameport.c:66:		cli()
drivers/ide/hd.c:137:   		 	cli()
drivers/ide/ide.c:206:  		  	__cli()

I guess we'll need to fix this. While races here are not likely (the
most likely is a beep by vt.c at a wrong moment), they're possible.

However, these don't seem to be the cause of the problem we see here
anyway.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
