Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTH3K25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTH3K25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:28:57 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:9432 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263467AbTH3K2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:28:55 -0400
Date: Sat, 30 Aug 2003 12:28:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] /proc/acpi/sleep needs to stay
Message-ID: <20030830102839.GA341@elf.ucw.cz>
References: <20030828211905.GA380@elf.ucw.cz> <Pine.LNX.4.33.0308291329050.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308291329050.944-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > acpi/sleep needs to stay. It is published interface, being used in
> > 2.4.X and 2.6.0-test3. That makes it wrong to change it in
> > 2.6.0-test4. [I've seen two different people trying to use
> > /proc/acpi/sleep in last week, *in person*.]
> 
> I will add it back, since it was a known interface. Note, however, the 
> past justifications the ACPI people have used to remove procfs interfaces 
> during stable series. 
> 
> It will also only mimic what /sys/power/state does.  /proc/acpi/sleep was
> broken. I'm not going to reinstitute a broken interface. (And, having two
> interfaces that do the same thing, but take different parameters, with one
> that exists only on a subset of systems seems silly. However, I will add
> it back in the name of backward compatibilty.)

Good.

> > User needs to know if he is doing
> > S4BIOS or swsusp: in first case he needs to set up special partition,
> > in second case he needs to pass resume= flag.
> 
> They should already know this. I don't see the point to your argument.  
> With the sysfs interface, this actually becomes more flexible. A user may
> decide which they want to do, via the /sys/power/disk file. A user may
> write one of the following to that file:
> 
> 	"firmware"
> 	"platform"
> 	"shutdown"
> 	"reboot"
> 
> ..which tells the PM core how to handle suspend-to-disk. If 'firmware' is 
> the choice, the core will call directly down to the pm_ops->enter() 
> method, which will do S4bios, or APM suspend, etc (depending on if the 
> platform driver has set the pm_ops->pm_disk_mode flag appropriately before 
> registering it). 

So if I want to do S4bios you have to 

echo "firmware" > disk
echo "disk" > state

? That seems unneccessarily complicated. I though about it a bit, and
there really is really has one reason to exist: automatic suspend on
battery critical.

OTOH, many machines do stuff like going S3 on battery critical
(notebook can usually stay alive for >10 hours on battery critical),
so current "disk" file may not be flexible enough for this.

What about file state, where you'd explicitly say how you want to
enter suspend to disk (for example "echo disk-swsusp > state, or echo
disk-firmware > state"), and file "on-battery-critical", where you
had all the choices in state (plus maybe "ignore"). (Shutdown/reboot
is usefull for debugging, but that's it, could be handled by
disk-swsusp-reboot).

> /proc/acpi/sleep would completely bypass ACPI when doing S4 that wasn't 
> handled by the BIOS. That's technically incorrect. The new interface fixes 
> that, and should work on all platforms. 

That was more or less implementation limitation noone bothered to fix.

> There are still some rough edges to be worked out, some which are fixed in 
> my current patch set (which I will post later today), and some which I've 
> yet to tackle. 
> 
> Please read the code and the documentation and try to make objective 
> observations about the advantages/disadvantages before posting next
> time. 

Unfortunately, you are producing way too much documentation way too
fast :-(.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
