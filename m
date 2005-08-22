Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVHVVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVHVVJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVHVVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:09:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35307 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751198AbVHVVJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:09:12 -0400
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200508221517.j7MFHiu10054@inv.it.uc3m.es>
Subject: Re: sleep under spinlock, sequencer.c, 2.6.12.5
In-Reply-To: <29495f1d05081917012fbb57aa@mail.gmail.com> from "Nish Aravamudan"
 at "Aug 19, 2005 05:01:37 pm"
To: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Date: Mon, 22 Aug 2005 17:17:44 +0200 (MET DST)
CC: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, ptb@inv.it.uc3m.es,
       "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Nish Aravamudan:"
> On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Gwe, 2005-08-19 at 10:13 +0200, Peter T. Breuer wrote:
> > > The following "sleep under spinlock" is still present as of linux
> > > 2.6.12.5 in sound/oss/sequencer.c in midi_outc:
> > >
> > >
> > >         n = 3 * HZ;             /* Timeout */
> > >
> > >         spin_lock_irqsave(&lock,flags);
> > >         while (n && !midi_devs[dev]->outputc(dev, data)) {
> > >                 interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
> > >                 n--;
> > >         }
> > >         spin_unlock_irqrestore(&lock,flags);
> > >
> > >
> > > I haven't thought about it, just noted it. It's been there forever
> > > (some others in the sound architecture have been gradually disappearing
> > > as newer kernels come out).
> > 
> > Yep thats a blind substition of lock_kernel in an old tree it seems.
> > Probably my fault. Should drop it before the sleep and take it straight
> > after.
> 
> Also, the use of n makes no sense. Indicates total sleep for 3

Well spotted.

> seconds, but actually sleep for 40 milliseconds 3*HZ times
> (potentially)?

I presume it should be 

      n -= HZ/25;

(and "n > 0", of course).

> In any case, probably should be:
> 
> timeout = jiffies + 3*HZ;
> 
> spin_lock_irqsave(&lock, flags);
> while (time_before(jiffies, timeout) && !midi_devs[dev]->outputc(dev, data)) {
>      spin_unlock_irqrestore(&lock, flags);
>      interruptible_sleep_on_timeout(&seq_sleeper, msecs_to_jiffies(40));

Well, you'd know. Is there something there really not taken care of by
"HZ"?

>      spin_lock_irqsave(&lock, flags);
> }
> spin_lock_irqrestore(&lock, flags);


Peter
