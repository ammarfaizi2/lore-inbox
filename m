Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSKDIC2>; Mon, 4 Nov 2002 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265983AbSKDIC2>; Mon, 4 Nov 2002 03:02:28 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:54661 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265982AbSKDICZ>; Mon, 4 Nov 2002 03:02:25 -0500
From: <benh@kernel.crashing.org>
To: "Linus Torvalds" <torvalds@transmeta.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Mon, 4 Nov 2002 09:08:38 +0100
Message-Id: <20021104080838.19142@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Note that "should work" does not necessarily mean "does work". For
>example, in the IDE world, some of the generic packet command stuff is
>only understood by ide-cd.c, and the generic IDE layer doesn't necessarily
>understand it even if you have a disk that speaks ATAPI. I think Jens will 
>fix that wart.

Which is why, IMHO (am I repeating myself ? :) that command has to
be sent down the queue by the _lowest_ level device driver, that
is ide-cd, ide-disk, etc...

This is the way our new device model is designed, at least from
my understanding of our numerous discussions with Patrick. The
actual device beeing suspended is the ide-disk (/cd/tape/...),
it is the target of the suspend request, it gets it from it's
parent in the bus binding (PCI mostly, non-PCI controllers will
have to provide something here), and it's the only place of code
that _knows_ what have to be done.

"knowing" that an ATA disk wants a SYNC. CACHE and/or STANDBY
command while an ATAPI CD wants a packet command (with eventually
a door unlock, and a check unit attention on resume) is not
the responsibility of the block layer nor even the ATA layer,
that would be a layering violation. It's the driver for the
actual device which is the one to know what to do with it's
device and when to do it (when = bus binding).

Pavel propose to stop processes & threads to make things easier
regarding VM, I now tend to think it will indeed make things
less intricated at first and agree we should keep it for now
especially with suspend-to-disk, but it's not the responsibility
of any generic, subsystem or whatever code to actually go suspend
the IO queues down to the drivers (it may be to stop feeding them,
which is the point of stopping processes).

I have the feeling that Alan is trying to avoid any kind of
responsibility upon drivers ;) Well, unfortunately, I think
we have no choice here, and that mean yes, we will have
eventually a few broken drivers that won't play nice with
suspend-to-disk/ram at first, and yes, users will notice,
post bug reports, and hopefully this will be fixed over
time...

Ben.


