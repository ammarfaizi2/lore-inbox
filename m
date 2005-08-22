Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVHVUoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVHVUoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVHVUov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41959 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751172AbVHVUoh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nNC1eiwM81vT/Nvbn0qmsY2DYNRur1XNOEntkughuoqZYBcOxdK705rOmr3W178S29sNy6xwWxi0BR0ecWxqx7IwYc7afM7/Ej8l4Q7geD0wNeyJSaKPWX+tCo7trJXroGeEck6SgnONCoMsYU29fzYtYM7ZvUeZjrxaRZpWll0=
Message-ID: <29495f1d050822092210719787@mail.gmail.com>
Date: Mon, 22 Aug 2005 09:22:40 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: ptb@inv.it.uc3m.es
Subject: Re: sleep under spinlock, sequencer.c, 2.6.12.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508221517.j7MFHiu10054@inv.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <29495f1d05081917012fbb57aa@mail.gmail.com>
	 <200508221517.j7MFHiu10054@inv.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Peter T. Breuer <ptb@inv.it.uc3m.es> wrote:
> "Also sprach Nish Aravamudan:"
> > On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > On Gwe, 2005-08-19 at 10:13 +0200, Peter T. Breuer wrote:
> > > > The following "sleep under spinlock" is still present as of linux
> > > > 2.6.12.5 in sound/oss/sequencer.c in midi_outc:
> > > >
> > > >
> > > >         n = 3 * HZ;             /* Timeout */
> > > >
> > > >         spin_lock_irqsave(&lock,flags);
> > > >         while (n && !midi_devs[dev]->outputc(dev, data)) {
> > > >                 interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
> > > >                 n--;
> > > >         }
> > > >         spin_unlock_irqrestore(&lock,flags);
> > > >
> > > >
> > > > I haven't thought about it, just noted it. It's been there forever
> > > > (some others in the sound architecture have been gradually disappearing
> > > > as newer kernels come out).
> > >
> > > Yep thats a blind substition of lock_kernel in an old tree it seems.
> > > Probably my fault. Should drop it before the sleep and take it straight
> > > after.
> >
> > Also, the use of n makes no sense. Indicates total sleep for 3
> 
> Well spotted.
> 
> > seconds, but actually sleep for 40 milliseconds 3*HZ times
> > (potentially)?
> 
> I presume it should be
> 
>       n -= HZ/25;

Well that's the problem; you're presuming that an (eventual)
schedule_timeout(HZ/25) call would actually sleep for HZ/25 jiffies.
More than likely, though, it may sleep a little longer. Generally,
code that is trying to sleep up to a certain time from now should use
time_after() or time_before().

> (and "n > 0", of course).
> 
> > In any case, probably should be:
> >
> > timeout = jiffies + 3*HZ;
> >
> > spin_lock_irqsave(&lock, flags);
> > while (time_before(jiffies, timeout) && !midi_devs[dev]->outputc(dev, data)) {
> >      spin_unlock_irqrestore(&lock, flags);
> >      interruptible_sleep_on_timeout(&seq_sleeper, msecs_to_jiffies(40));
> 
> Well, you'd know. Is there something there really not taken care of by
> "HZ"?

1) Makes this code consistent with other users in the kernel (Although
I have tried to reduce the number of users of the sleep_on() family).

2) If HZ eventually is allowed to take other values (e.g., 864 for
x86), then HZ/25 leads to rounding issues. msecs_to_jiffies() takes
care of those issues *and* makes it a little clear what you're doing,
IMO.

Thanks,
Nish
