Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTAKN53>; Sat, 11 Jan 2003 08:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAKN52>; Sat, 11 Jan 2003 08:57:28 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:400 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267224AbTAKN51>; Sat, 11 Jan 2003 08:57:27 -0500
Date: Sat, 11 Jan 2003 15:06:02 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030111140602.GA20221@averell>
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <m3iswv27o3.fsf@averell.firstfloor.org> <1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main problems are
>   - Incorrect locking all over the place

Hmm bad. Is it that hard to fix ?

>   - Incorrect timings on some phases

Can't you just take out the timings in that case? 
My (not very informed) understanding is: 
everything should work with the BIOS timings and generic IDE,
having own timings is just an optimization to squeeze out a bit
more speed.

>   - ISAPnP IDE doesn't work right now

Hardly a release show stopper I guess

(ISA support in general being rather broken, but I doubt many people care
still) 

>   - Flaws in error recovery paths in certain situations
>   - Lots of random oopses on boot/remove that were apparently
>     introduced by the kobject/sysfs people and need chasing
>     down. (There are some non sysfs ones mostly fixed)

I guess the kobject/sysfs stuff could be ripped out if it doesn't
work - it is probably not a "must have" feature.


>   - ide-scsi needs some cleanup to fix switchover ide-cd/scsi
>     (We can't dump ide-scsi)
>   - Unregister path has races which cause all the long
>     standing problems with pcmcia and prevents pci unreg

Can't you just disable module unloading for the release ?
(not nice, but has worked for other subsystems like IPv6 too in the past)
Also 2.4 didn't have much problems without modular IDE, 2.6 will
be probably able to tolerate it too.

>   - IDE raid hasn't been ported to 2.5 at all yet

Vendor problem ?
> 
> > > broken and nobody has even started fixing it. Just try a mass of parallel
> > > tty/pty activity . It was problematic before, pre-empt has taken it  to dead, 
> > > defunct and buried. 
> > 
> > Can someone shortly describe what is the main problem with TTY?
> > 
> > >From what I can see the high level tty code mostly takes lock_kernel
> > before doing anything.
> 
> Which works really well with all the IRQ paths on it

Then 2.0/2.2/2.4 would have been racy too :-) Apparently they worked though.

High level tty code doesn't touch any ttys as far as I can see.

It is done in n_tty.c, which apparently needs a bit of work
(found some races together with Rik there)

> > On reads access to file->private_data is not serialized, but it at 
> > least shouldn't go away because VFS takes care of struct file
> > reference counting.
> 
> The refcounting bugs are/were in the ldisc stuff. I thought the
> bluetooth folks (Max and co) fixed that one

I was thinking about races with tty_release (= own tty_struct suddenly
going away). VFS would prevent that.


-Andi
