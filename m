Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUD2UNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUD2UNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUD2UNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:13:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20889 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264958AbUD2UND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:13:03 -0400
Date: Thu, 29 Apr 2004 21:43:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: locking in psmouse
Message-ID: <20040429194344.GB468@openzaurus.ucw.cz>
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net> <20040429095830.GD390@elf.ucw.cz> <200404290740.18182.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404290740.18182.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Anyway, locking still seems to be needed: 
> > 
> >         while (psmouse->cmdcnt && timeout--) {
> > 
> >                 if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
> >                                 timeout > 100000) /* do not run in a endless loop */
> >                         timeout = 100000; /* 1 sec */
> > 
> >                 if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
> >                     psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
> >                         psmouse->cmdcnt = 0;
> >                         break;
> >                 }
> > 
> >                 spin_unlock_irq(&psmouse_lock);
> >                 udelay(1);
> >                 spin_lock_irq(&psmouse_lock);
> >         }
> > 
> > racing with
> > 
> >         if (psmouse->cmdcnt) {
> >                 psmouse->cmdbuf[--psmouse->cmdcnt] = data;
> >                 goto out;
> >         }
> > 
> > now... if each runs on different CPU, it can be possible that
> > psmouse->cmdcnt is seen as 1 but data are not yet in
> > psmouse->cmdbuf... Locking seems neccessary here.
> 
> I see.. but this particular case can be resolved but rearranging the code to
> write command response first and then decrementing the counter... and putting
> a barrier? Or just make cmdcnt atomic... spin_lock_irq feels heavier than
> absolutely necessary.

cmdcnt would have to be atomic_t, ack too, state too, and
you'd have to be very carefull with memory barriers...
I guess spinlock is better solution.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

