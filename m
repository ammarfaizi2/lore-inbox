Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTH2Uu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTH2Uu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:50:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:65491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263470AbTH2UsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:48:19 -0400
Date: Fri, 29 Aug 2003 13:46:05 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] /proc/acpi/sleep needs to stay
In-Reply-To: <20030828211905.GA380@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0308291329050.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> acpi/sleep needs to stay. It is published interface, being used in
> 2.4.X and 2.6.0-test3. That makes it wrong to change it in
> 2.6.0-test4. [I've seen two different people trying to use
> /proc/acpi/sleep in last week, *in person*.]

I will add it back, since it was a known interface. Note, however, the 
past justifications the ACPI people have used to remove procfs interfaces 
during stable series. 

It will also only mimic what /sys/power/state does.  /proc/acpi/sleep was
broken. I'm not going to reinstitute a broken interface. (And, having two
interfaces that do the same thing, but take different parameters, with one
that exists only on a subset of systems seems silly. However, I will add
it back in the name of backward compatibilty.)

> Also your new /sys/power/state is bogus. You invented new abstraction,
> alas that abstraction is harmfull. 

Please assume for a moment that there are other platforms that exist that 
want to do power management. Please also assume that it might be a good 
thing to have one unified interface to do such a thing. 

> User needs to know if he is doing
> S4BIOS or swsusp: in first case he needs to set up special partition,
> in second case he needs to pass resume= flag.

They should already know this. I don't see the point to your argument.  
With the sysfs interface, this actually becomes more flexible. A user may
decide which they want to do, via the /sys/power/disk file. A user may
write one of the following to that file:

	"firmware"
	"platform"
	"shutdown"
	"reboot"

..which tells the PM core how to handle suspend-to-disk. If 'firmware' is 
the choice, the core will call directly down to the pm_ops->enter() 
method, which will do S4bios, or APM suspend, etc (depending on if the 
platform driver has set the pm_ops->pm_disk_mode flag appropriately before 
registering it). 

Otherwise, swsusp will take care of saving state and writing it to swap. 
Depending on the mode, the core will either tell the platform to enter a 
low-power state (the real S4 state) or shutdown (or reboot for testing). 

/proc/acpi/sleep would completely bypass ACPI when doing S4 that wasn't 
handled by the BIOS. That's technically incorrect. The new interface fixes 
that, and should work on all platforms. 

There are still some rough edges to be worked out, some which are fixed in 
my current patch set (which I will post later today), and some which I've 
yet to tackle. 

Please read the code and the documentation and try to make objective 
observations about the advantages/disadvantages before posting next time. 

Thanks,


	Pat

