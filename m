Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbSLUJLN>; Sat, 21 Dec 2002 04:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbSLUJLN>; Sat, 21 Dec 2002 04:11:13 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:32991 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266844AbSLUJLK>;
	Sat, 21 Dec 2002 04:11:10 -0500
Date: Sat, 21 Dec 2002 10:18:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Bjorn Helgaas <bjorn_helgaas@hp.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
Message-ID: <20021221101851.A29004@ucw.cz>
References: <200212161227.38764.bjorn_helgaas@hp.com> <3E02F3EE.C1367073@mvista.com> <20021220142443.A26184@ucw.cz> <3E03526A.2AA4B685@mvista.com> <20021220183544.A26785@ucw.cz> <3E035E7B.D3B60845@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E035E7B.D3B60845@mvista.com>; from george@mvista.com on Fri, Dec 20, 2002 at 10:16:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 10:16:27AM -0800, george anzinger wrote:
> Vojtech Pavlik wrote:
> > 
> > On Fri, Dec 20, 2002 at 09:24:58AM -0800, george anzinger wrote:
> > > Vojtech Pavlik wrote:
> > > >
> > > > On Fri, Dec 20, 2002 at 02:41:50AM -0800, george anzinger wrote:
> > > > > Bjorn Helgaas wrote:
> > > > > >
> > > > > > * fix a problem with HZ->millisecond transformation on
> > > > > >   non-x86 archs (from 2.5 change by vojtech@suse.cz)
> > > > > >
> > > > > > Applies to 2.4.20.
> > > > > >
> > > > > > diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
> > > > > > --- a/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > > > > +++ b/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> > > > > > @@ -50,6 +50,8 @@
> > > > > >  #define JOYDEV_MINORS          32
> > > > > >  #define JOYDEV_BUFFER_SIZE     64
> > > > > >
> > > > > > +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
> > > > > Uh...
> > > > > ^^^^^^^^^^^^^^^^
> > > > > by definition this is zero, is it not?
> > > >
> > > > No, both parts of the equaition can be nonzero.
> > >
> > > I don't think so.  s%HZ has to be less than HZ.  Then
> > > dividing that by HZ should result in zero.  Where is my
> > > thinking flawed?
> > 
> > You first multiply it by 1000.
> 
> But then it should read: (1000 * (t)) % HZ) / HZ

The expression is evaluated from left to right. No need for parentheses
here.

> But this is still zero.  There is no way that ((X % HZ) /
> HZ) is other than zero, me thinks.

Example:

HZ = 100
t = 70

1000 * (t % HZ) / HZ = 1000 * 70 / 100 = 700 != 0

Anyway (x % HZ) / HZ must be zero, but that's something different.

> > > > Though it might be easier to say (1000 * t) / HZ, now that I think about
> > > > it.
> > >
> > > That overflows...  As does the other if HZ is less than 1000....
> > 
> > You're right, t can be all 32 bits.
> 
> What, exactly, is this code trying to do?  It looks like the
> number is being passed to user space...

It's trying to convert jiffies to microseconds from computer start (or
any other arbitrary point in time), thus making the value independent of
HZ.

> -- 
> George Anzinger   george@mvista.com
> High-res-timers: 
> http://sourceforge.net/projects/high-res-timers/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml

-- 
Vojtech Pavlik
SuSE Labs
