Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbTCJTM0>; Mon, 10 Mar 2003 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbTCJTM0>; Mon, 10 Mar 2003 14:12:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34321 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261429AbTCJTMT>; Mon, 10 Mar 2003 14:12:19 -0500
Date: Mon, 10 Mar 2003 20:23:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030310192300.GC11310@atrey.karlin.mff.cuni.cz>
References: <20030307202759.GA2447@elf.ucw.cz> <Pine.LNX.4.33.0303101012230.1002-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303101012230.1002-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But your solution would also only support *one* suspend partition,
> > right? (And patches for using more than one swap partition are
> > available for 2.4.X; I don't like them due to added complexity).
> 
> Having a dedicated partition has an advantage in just that - it's 
> dedicated to saving system state. Users must consciously create it, and 
> must make it as big as the size of memory they have (or will have). Plus, 
> it's not tied to the amount of memory being used when you suspend. 

That's a problem. Users do not have suspend partitions, but they do
have swap partition. And repartitioning existing installation is very
painfull. OTOH it is true that if we want
"emergency-suspend-to-disk-when-battery-low", dedicated partition
makes some sense.... ... Well. You can always do swapoff, swapon,
swsusp. Maybe some processes will die, but that's life ;-).

[But for that you'd have to guarantee that suspend always works, which
is hard, anyway.] 

> Swap space has a specific purpose, I see it as a detriment to overload its 
> intended usage. Of couse, that's just my opinion, and I don't have code to 
> back it up. 

Well, I see it as advantage because I have swap space anyway (rarely
really used), so why not reuse it for swsusp?

> > It is pretty magical operation, so you are at least warned. [And this has
> > nothing to do with fact we suspend-to-swap].
> 
> IMO, warnings should be conveyed in comments, not in cryptic function 
> names. Besides, there is nothing magical about it, unless that sequence of 
> instructions actually does make your computer glow, levitate, or turn into 
> a mermaid. In which case, I would like to know where I can find one. ;)

:-). Well, comments were getting out of date because code was in
permanent flux. It makes sense to comment it now.

> > Your solution will not work if your suspend partition is not there.
> 
> I didn't mean to sound like a hypocrit, I apologize. The advantage of 
> using a dedicated partition over swap is that in order to create the 
> partition, the user must make a conscious decision to do so. 
> 
> There are parameters that can be enforced when making the partition, like 
> the size and its existence on a persistant medium. These can be enforced 
> by a user making a swap partition, but it places extra burden on the user. 

Well, IMO checklist like:

if you want to use swsusp you have to 

a) check swap is on persistent medium

b) make sure swap is at least as big as memory/2 [not really
neccessary, we might be lucky and swsusp with 30MB of swap...]

is easier for the user than repartitioning their harddrives. [I'd like
to see someone running swap on floppy ;-)]

> > So you don't really want to create separate "suspend partition"? Good.
> 
> Sorry, the patch included a few distinct things, and I should have made it
> a bit more clear. In includes:
> 
> - A generic PM framework which PM drivers can register with. 
> 
> Users can specificy which handler they wish to use for different states, 
> based on their preference or the capabilities of their systems. 
> 
> They can also use one mechanism for entering power states: 
> /sys/power/power_state, instead of relying different mechanisms for 
> different PM drivers (/proc/acpi/sleep vs. apm(1)
> vs. sys_reboot()). 

I believe sys_reboot() is the right way to do
that. /sys/power/... needs sysfs mounted etc. /proc/acpi/sleep just
happened to already be there and be very convenient.

> In the long run, I'd like to develop a solution using a dedicated 
> partition. But, that wouldn't necessarily obviate the use of swsusp. It 
> would coexist alongside it. 

Actually "dedicated partition" vs. "swap partition" is quite a small
detail. It only affects disk allocation routines. Basic stuff like
"atomic copy" stays the same...

> > > I understand you may not a rewrite of swsusp (regardless of how much
> > > cleaner the code is), and I respect that. I'm completely willing to leave
> > > kernel/suspend.c intact, and let you work in the integration into the
> > > generic PM model, and/or simply rename the new code something like
> > > swsusp2, swsusp-XP, or swsusp-pat. ;)
> > 
> > So you want to develop swsusp-pat that will suspend to partition,
> > allow another kernel version, and you think you can suspend when 90%
> > of your memory is kmalloc()-ed? Do you agree that separate disk
> > drivers for suspend is bad idea?
> 
> Yes.

Do you think you can suspend with 90% memory kmalloc()-ed?

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
