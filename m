Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTCENvF>; Wed, 5 Mar 2003 08:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTCENvF>; Wed, 5 Mar 2003 08:51:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11015 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266379AbTCENvE>;
	Wed, 5 Mar 2003 08:51:04 -0500
Date: Wed, 5 Mar 2003 14:01:34 +0000
From: Matthew Wilcox <willy@debian.org>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] more potential deadlocks
Message-ID: <20030305140134.A28386@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> here are some more potential deadlocks. These results are just for:
>          drivers/pci*
>         drivers/usb*
>         drivers/ide*
>         drivers/scsi*
>         net/*ipv[46]*/netfilter*
>         ipc/*
>         mm/*
>         kernel/*
>         net/*ipv4_*
> 
> if there are any other directories that people are likely to inspect
> bugs from, let me know and I'll add them.

fs/ seems an obvious addition to me.  Could you cc linux-fsdevel on
anything you find in there?  Documentation/filesystems/Locking is not
too inaccurate and might help winnow the wheat from the chaff.

I think we'd benefit from the tty code being audited too --
drivers/char/*tty*

> These deadlocks often involve locks accessed through pointers.
> Unfortunately, if the pointers can never point to the same object the
> error is a false positive.
> 
> BTW, is there a locking ettiquette w.r.t. cli()? E.g., are you not
> supposed to acquire a spinlock if you have interrupts disabled (or
> vice versa)?

enabling/disabling interrupts is also a locking mechnism ;-)  When
you access data from interrupt context, you need to disable interrupts
to avoid that race.  So it's perfectly fine to do:

spin_lock_irq(foo);
spin_lock(bar);
spin_unlock(bar);
spin_unlock_irq(foo);

Also, are you modelling spin_lock_bh() yet?  That has a similar
function to spin_lock_irq() except it only protects against
softirqs/tasklets/timers, not regular interrupts.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
