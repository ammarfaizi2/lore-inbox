Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbVHTABi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbVHTABi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbVHTABi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:01:38 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:9659 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932767AbVHTABi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:01:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tyI5fXUWyc5xPkUAi8qWfeVI4Xoy1inL/JIMvZ0aPiMuajU3Ijleu1sANROI4Y+Ubl2ExUP3cIZBXtGux/9Cl9ykex9Vs5Td15wgz/4Jss+5EwAXZHkv0pDgYDH8Y/iW8bmPw4ri8kYuxmXhPWBB7op6xr1uyMaaJGFToQGDvP4=
Message-ID: <29495f1d05081917012fbb57aa@mail.gmail.com>
Date: Fri, 19 Aug 2005 17:01:37 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sleep under spinlock, sequencer.c, 2.6.12.5
Cc: ptb@inv.it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1124474829.32050.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508190813.j7J8Dml28378@inv.it.uc3m.es>
	 <1124474829.32050.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-08-19 at 10:13 +0200, Peter T. Breuer wrote:
> > The following "sleep under spinlock" is still present as of linux
> > 2.6.12.5 in sound/oss/sequencer.c in midi_outc:
> >
> >
> >         n = 3 * HZ;             /* Timeout */
> >
> >         spin_lock_irqsave(&lock,flags);
> >         while (n && !midi_devs[dev]->outputc(dev, data)) {
> >                 interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
> >                 n--;
> >         }
> >         spin_unlock_irqrestore(&lock,flags);
> >
> >
> > I haven't thought about it, just noted it. It's been there forever
> > (some others in the sound architecture have been gradually disappearing
> > as newer kernels come out).
> 
> Yep thats a blind substition of lock_kernel in an old tree it seems.
> Probably my fault. Should drop it before the sleep and take it straight
> after.

Also, the use of n makes no sense. Indicates total sleep for 3
seconds, but actually sleep for 40 milliseconds 3*HZ times
(potentially)?

In any case, probably should be:

timeout = jiffies + 3*HZ;

spin_lock_irqsave(&lock, flags);
while (time_before(jiffies, timeout) && !midi_devs[dev]->outputc(dev, data)) {
     spin_unlock_irqrestore(&lock, flags);
     interruptible_sleep_on_timeout(&seq_sleeper, msecs_to_jiffies(40));
     spin_lock_irqsave(&lock, flags);
}
spin_lock_irqrestore(&lock, flags);

Or something similar....

If those locks weren't there, we could use
wait_event_interruptible_timeout(). Should we create a locked version?

Thanks,
Nish
