Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbTCJRDC>; Mon, 10 Mar 2003 12:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbTCJRDB>; Mon, 10 Mar 2003 12:03:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261307AbTCJRC5>;
	Mon, 10 Mar 2003 12:02:57 -0500
Date: Mon, 10 Mar 2003 10:49:01 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <20030307202759.GA2447@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0303101012230.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But your solution would also only support *one* suspend partition,
> right? (And patches for using more than one swap partition are
> available for 2.4.X; I don't like them due to added complexity).

Having a dedicated partition has an advantage in just that - it's 
dedicated to saving system state. Users must consciously create it, and 
must make it as big as the size of memory they have (or will have). Plus, 
it's not tied to the amount of memory being used when you suspend. 

Swap space has a specific purpose, I see it as a detriment to overload its 
intended usage. Of couse, that's just my opinion, and I don't have code to 
back it up. 

> > - Not resetting swap signature if a resume failed. 
> 
> Can be fixed in userland. Add option -s that for mkswap that fixes
> signature only if it was overwritten by suspend, and add mkswap -s
> /swap/partiton in your init scripts.

That's wrong, IMO. If the kernel modifies it, it should reset it. You 
shouldn't impose extra burden on the users because your code failed. 
Besides, it's fixed anyway. 

> > - Almost complete lack of a recovery path if anything failed (i.e. trying 
> >   to back out of what has happened, instead of calling BUG() or
> > panic()).
> 
> Those BUGs / panics should be impossible to trigger. [And this has
> nothing to do with fact we suspend-to-swap].

[ I know these are not suspend-to-swap specific; sorry for implying that.]

If they're really impossible to trigger, then they shouldn't be there at 
all. If you can recover from them, then you should, instead of giving up. 
Besides, a lot of them were completely bogus things like

	BUG_ON(sizeof(foo) != sizeof(bar))

Which are known at compile time, but were buried in the code to read/write 
the data, and only convoluted the code even more. 

> > - Function names like do_magic() and friends. 
> 
> It is pretty magical operation, so you are at least warned. [And this has
> nothing to do with fact we suspend-to-swap].

IMO, warnings should be conveyed in comments, not in cryptic function 
names. Besides, there is nothing magical about it, unless that sequence of 
instructions actually does make your computer glow, levitate, or turn into 
a mermaid. In which case, I would like to know where I can find one. ;)

Seriously, you described below what it does, which helps a lot more than 
anything named 'magic'. 

> > The general problems that I see with the solution are:
> > 
> > - It simply won't work if you're low on swap or memory. 
> 
> Your solution will not work with too small suspend partition
> too. Being low on memory... You'd have to have > 50% of your memory
> allocated by kernel for swsusp to fail. I do not think it can be
> sanely done other way. [Having separate disk drivers just for suspend
> is *not* sane.]
> 
> > - It won't work if you're swap is not persistant across reboots. 
> 
> Your solution will not work if your suspend partition is not
> persistant across reboots. AND WHAT?
> 
> > - It won't work if you don't use swap. 
> 
> Your solution will not work if your suspend partition is not there.

I didn't mean to sound like a hypocrit, I apologize. The advantage of 
using a dedicated partition over swap is that in order to create the 
partition, the user must make a conscious decision to do so. 

There are parameters that can be enforced when making the partition, like 
the size and its existence on a persistant medium. These can be enforced 
by a user making a swap partition, but it places extra burden on the user. 


> > I've created a registration mechanism for PM 'drivers', and a way for
> > users to select which driver they want to use for the different PM states.  
> > In the patch, swsusp is just another driver. It can coexist with ACPI or
> > APM (theoretically) just fine, without requiring a kernel rebuild or
> > reboot.
> 
> I believe it can coexist with ACPI and APM already just okay. You can
> echo 4b to /proc/acpi/sleep to trigger S4bios.
> 
> > This also involves a generic framework for doing system-wide power 
> > management. In this, I've begun extracting bits from swsusp that are 
> > useful for any PM sequence. My goal is to reduce swsusp to just a small 
> > layer that writes/reads the saved pages from swap. The rest of the 
> > sequence, including memory and device handling, happens in generic
> > code. 
> 
> So you don't really want to create separate "suspend partition"? Good.

Sorry, the patch included a few distinct things, and I should have made it
a bit more clear. In includes:

- A generic PM framework which PM drivers can register with. 

Users can specificy which handler they wish to use for different states, 
based on their preference or the capabilities of their systems. 

They can also use one mechanism for entering power states: 
/sys/power/power_state, instead of relying different mechanisms for 
different PM drivers (/proc/acpi/sleep vs. apm(1) vs. sys_reboot()). 

- Generic sequence for entering sleep states, in drivers/power/main.c

- Clean up of swsusp.

- Conversion of swsusp and ACPI to register with the PM model.

- Extraction of swsusp-specific features into the generic PM framework, so 
  they can be shared with everyone. 


In the long run, I'd like to develop a solution using a dedicated 
partition. But, that wouldn't necessarily obviate the use of swsusp. It 
would coexist alongside it. 

> > I understand you may not a rewrite of swsusp (regardless of how much
> > cleaner the code is), and I respect that. I'm completely willing to leave
> > kernel/suspend.c intact, and let you work in the integration into the
> > generic PM model, and/or simply rename the new code something like
> > swsusp2, swsusp-XP, or swsusp-pat. ;)
> 
> So you want to develop swsusp-pat that will suspend to partition,
> allow another kernel version, and you think you can suspend when 90%
> of your memory is kmalloc()-ed? Do you agree that separate disk
> drivers for suspend is bad idea?

Yes.


	-pat

