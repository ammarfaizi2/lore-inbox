Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310380AbSCLD36>; Mon, 11 Mar 2002 22:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310376AbSCLD3t>; Mon, 11 Mar 2002 22:29:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310380AbSCLD3o>; Mon, 11 Mar 2002 22:29:44 -0500
Date: Mon, 11 Mar 2002 19:28:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "J. Dow" <jdow@earthlink.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D71AC.3080305@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203111916000.18604-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Mar 2002, Jeff Garzik wrote:
> 
> 1) There should be a raw device command interface (not ATA or SCSI specific)

Well, since the raw commands themselves will be bus-specific, you can't
really avoid THAT part.

The thing I want to be generic is the fact that everybody uses the 
"request->cmd[]" array, along with the flags in "request->flags" to 
specify what kind of command it is.

We actually have this infrastructure already, it's just not fully used.

> 2) There should be kernel interfaces for the standard cases, so that the 
> raw device command interface is often not needed

Absolutely.

> 3) There should be capability to optionally install filter the raw 
> device command interface.  The filter is built into the kernel at 
> compile-time, but can also be disabled at boot time.

This is the part I really don't like.

Thinking like a sysadmin, I want to be able to run programs that I would 
not allow my users to run or want to be run accidentally. And I do _not_ 
want to reboot my kernel just because one of my mirrored disks died, I 
hot-replaced it, and I notice that I need to upgrade the firmware on the 
thing to make it play nice with the other disks in the array.

See? A setup that either allows everything or nothing is fundamentally
flawed in this kind of situation - suddenly I as a sysadmin cannot do
something without bringing the machine down. Which makes all the hotplug
interfaces useless - or then I as a sysadmin just have to leave a kernel 
in place that allows the kinds of raw command accesses that I am so scared 
of.

One solution may be to have the whole raw cmd thing as a loadable module, 
and then I can make sure that it's not even available on the system so 
that I have to do some work to find it, and somebody elses program won't 
just know what to do.

But in that case is should be far removed from the IDE driver - it would 
just be a module that inserts a raw request on the request queue, and NOT 
inside some subsystem driver that I obviously want to have available all 
the time.

See?

		Linus

