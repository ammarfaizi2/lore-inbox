Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBKB0V>; Mon, 10 Feb 2003 20:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTBKB0U>; Mon, 10 Feb 2003 20:26:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:46075 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265446AbTBKB0T>;
	Mon, 10 Feb 2003 20:26:19 -0500
Message-ID: <3E48536B.272E5630@mvista.com>
Date: Mon, 10 Feb 2003 17:35:39 -0800
From: Kenneth Sumrall <ken@mvista.com>
Organization: MontaVista Software
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: suparna@in.ibm.com, Corey Minyard <cminyard@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
		<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
		<20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > On Sun, Feb 09, 2003 at 11:39:27AM -0700, Eric W. Biederman wrote:
> > > Corey Minyard <cminyard@mvista.com> writes:
> > >
> > > With respect to DMA and SMP handling for kexec on panic that case is
> > > much trickier.  A lot of the normal methods simply don't apply because
> > > by definition in a panic something is broken, and that something may
> > > be the code we need to cleanly shutdown the hardware.  But I an not
> > > ready to sacrifice a method that works well in a properly working
> > > kernel just because the panic case can't use it.
> > >
> > > In getting it working I suggest we start with the easy cases, where
> > > DMA and SMP are not big issues.  And then we can have a working
> > > framework.
> >
> > I'd agree. That was also the idea behind the patch we'd just posted
> > for LKCD. With a basic working framework in hand that works for
> > simpler cases, we can now keep working on addressing more and harder
> > situations bit by bit.
> 
> Agreed.  I guess the primary question is can we trust the current
> device shutdown + reboot notifier path or do we need to make some
> large changes to avoid it.
> 
So are the functions registered on the reboot notifier path guaranteed
to be non-blocking?  In the kexec on panic case, calls that can block
would obviously be a bad thing.  If they can block, perhaps we could add
a new flag SYS_PANIC or something like that to tell the driver to only
do a non-blocking shutdown of the chip.


> > Are you trying to address the possibility that DMA is overwriting
> > memory we are using in the recovery code, due to a runaway driver
> > or other code passing a wrong memory address to a device (e.g. in
> > a corrupted command area) ?
> 
> Not primarily.  Instead I am trying to address the possibility that
> DMA is overwriting the recovery code due to a device not being shutdown
> properly.  Though it would happen to cover many cases of the wrong
> memory address being passed to a device.
>
The problem we were seeing was that rogue DMA from a network interface
chip was corrupting dentry's in the dirent cache when the rebooted
kernel was coming back up.  This caused a whole new set of panics. :-(
 
Ken Sumrall
ken@mvista.com
