Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132257AbRCVX6t>; Thu, 22 Mar 2001 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132246AbRCVX6d>; Thu, 22 Mar 2001 18:58:33 -0500
Received: from epic8.Stanford.EDU ([171.64.15.41]:62700 "EHLO
	epic8.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132262AbRCVX5u>; Thu, 22 Mar 2001 18:57:50 -0500
Date: Thu, 22 Mar 2001 15:49:31 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: <jt@hpl.hp.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : [CHECKER] 28 potential interrupt errors
In-Reply-To: <20010322153641.B13162@bougret.hpl.hp.com>
Message-ID: <Pine.GSO.4.31.0103221543240.29011-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometimes the line number reported by the checker is not correct.
But if you go into the function, you can find the bug.

On Thu, 22 Mar 2001, Jean Tourrilhes wrote:

> Junfeng Yang wrote :
> > Hi,
> >
> > Here are yet more results from the MC project.  This checker looks for
> > inconsistent usage of interrupt functions.
> [...]
> > ---------------------------------------------------------
> > [BUG] error path

at line 952, this function exits without restoring flags.

> >
> > /u2/acc/oses/linux/2.4.1/drivers/net/irda/irport.c:943:irport_net_ioctl: ERROR:INTR:947:997: Interrupts inconsistent, severity `20':997
> >
> >         /* Disable interrupts & save flags */
> >         save_flags(flags);
> > Start --->
> >         cli();
> >
> >         switch (cmd) {
> >         case SIOCSBANDWIDTH: /* Set bandwidth */
> >                 if (!capable(CAP_NET_ADMIN))
> >                         return -EPERM;
> >                 irda_task_execute(self, __irport_change_speed, NULL, NULL,
> >
> >         ... DELETED 40 lines ...
> >
> >         }
> >
> >         restore_flags(flags);
> >
> > Error --->
> >         return ret;
> > }
> >
> > [BUG] error path. this bug is interesting
> >
> > /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats: ERROR:INTR:2528:2561: Interrupts inconsistent, severity `20':2561
> >
> >
> >   /* Disable interrupts & save flags */
> > Start --->
> >   spin_lock_irqsave (&lp->lock, flags);
> >
> >   if(lp == (net_local *) NULL)

return without restoring flags here
(use lp->lock first, then check if lp == NULL)
--->

> >     return (iw_stats *) NULL;
> >   wstats = &lp->wstats;
> >
> >   /* Get data from the mmc */
> >
> >         ... DELETED 23 lines ...
> >

