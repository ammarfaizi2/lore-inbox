Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbSKDPVH>; Mon, 4 Nov 2002 10:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSKDPVH>; Mon, 4 Nov 2002 10:21:07 -0500
Received: from [217.167.51.129] ([217.167.51.129]:47326 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S264701AbSKDPVF>;
	Mon, 4 Nov 2002 10:21:05 -0500
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Mon, 4 Nov 2002 16:27:23 +0100
Message-Id: <20021104152724.25083@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44.0211040638000.771-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211040638000.771-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Anyway, this is why I'd much rather have higher layers use a standardized
>queue packet (a SCSI command) to inform lower-level drivers about special
>events, rather than have the lower levels decide on their own command set
>and have specialized ways to try to tell them to use that specialized
>command some other way (a bdev "ops" structure would probably be the way
>we'd go).
>
>So assuming that drivers will accepts commands down the request queue 
>anyway (because it's the only sane way to push them down and get any kind 
>of reasonable ordering), then that would make it a waste of time and extra 
>complexity to _also_ have another interface to push special commands. 
>Especially as that other interface would end up being almost certainly 
>broken wrt synchronization (proof: look at the current mess).

Ok, I see your point. However, even if having a common mecanism to
push down a "generic" (ie SCSI packet) "suspend" command down the
queue, the problem of doing proper suspend/resume has other issues
to deal with, and it's basically not a higher level layer thing.

One is ordering (regarding the controller's own power management
facilities if any, I do power down the controller itself on pmacs
for example, or regarding other PM issues on the bus path down to
that controller). A given IDE disk/cd/tape (same with SCSI or
anything else) must be suspended/resumed at the proper moment,
that is exactly just before it's parent, as a result of the
suspend request getting down the device tree.

Another is proper save/restore. We aren't just sending a "please
stop that disk spinning" command, like one would do for automatic
power management of inactive disks or whatever. Indeed, a common
packet command would be very well suited for that. But in our case,
we are dealing with suspend-to-disk/ram, which usually involves
a bit more than that. We want to block the queue atomically with
reception of this suspend command for example until machine is
resumed. We need to send commands to restore the device state
(ATA/ATAPI reset, LBA setting, timings, ...) on resume before
we actually accept new commands from the queue (pushing them
at head of queue before de-blocking it ?)

All of the above is quite device specific. You won't need the
same commands & state restore stuffs for a disk, cd, tape, ...
So it's really the driver for that specific device that is
the only one to know what has to be done for this specific
device. 

I'm not quite yet sure what is the best way to deal with all
that yet for IDE, what I did for pmac so far was a lot simpler
but not definitely generic enough (basically blocking the
hwgroup state to "busy" and hand-blasting ATA regs to send
STANDBY command).

Ben.


