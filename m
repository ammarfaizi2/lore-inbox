Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSJJSnp>; Thu, 10 Oct 2002 14:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262110AbSJJSnp>; Thu, 10 Oct 2002 14:43:45 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15503 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261807AbSJJSnn>; Thu, 10 Oct 2002 14:43:43 -0400
Date: Thu, 10 Oct 2002 13:49:22 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210100107410.338-100000@serv>
Message-ID: <Pine.LNX.4.44.0210101315240.10911-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2002, Roman Zippel wrote:

> > So at this point, you decide to rather not have the user wait
> > forever until his "rmmod net_pci" succeeds, but return -EBUSY right away.
> > You do it by running MOD_INC_USE_COUNT in ::open(), and DEC again in
> > ::close().
> 
> You don't really want to do this. Imagine what happens if you get
> preempted before you had a chance to run MOD_INC_USE_COUNT.

Well, a rmmod could potentially leave the module in "deleted" but not 
"freed" state for a long time. Basically the same thing which happens for 
your solution, where you call the state "cleanup". But I agree, this is 
not desirable at all (nor do I think your cleanup state is). That's why I 
said you should be using the right APIs. And the network layer does things 
correctly, you don't need any MOD_INC_USE_COUNT in your network driver at 
all, just set .owner and the network layer does it all and race-free for 
you.

> The unload path could look something like this:
> 
> 	if (mod->usecount())
> 		return -EBUSY;
> 	mod->state = cleanup;
> 	if (mod->exit())
> 		return -EBUSY;
> 	(free module)
> 
> So this does what you want. The only problem is here that the exit call
> can fail, because there are still users, so the module will stay in the
> cleanup state. start/stop functions would give you better control over
> this.

Well, I don't think I have a general problem with allowing module_exit()  
to fail, though again I don't think it's necessary for drivers which use
safe standard APIs. I'm not sure about your cleanup state, why is that
necessary? Say you do pci_unregister_driver() in your module_exit(). That
means that no users will find your driver on the list of all drivers, so
they have nothing to do try_inc_mod_count() on, which you're trying to
protect against? This is, AFAICS, currently only needed to guarantee
race-free access to the module's use count. Since you're only using that
as a hint right now and leave the final decision to ->exit(), it shouldn't
be necessary.

> > And, done right, the API for the current implementation is so simple that
> > I doubt you'll be able to come up with something with more ease-of-use.
> 
> The current API just hides the complexity, but it requires extra checks
> all over the kernel, to test if an object belongs to a module and if the
> module is running. My proposal would get rid of this.
> Deciding whether when you can release a device object or a driver object
> is pretty much the same problem and a common solution is IMO prefered. The
> module code should work like the remaining kernel and not require extra
> care everywhere.
> The diff below shows how filesystem.c would change, which becomes simpler
> as it doesn't has to care about the module state anymore.

(This example seems to emphasize what I just said, no checking for state 
cleanup neeeded, at least I don't see it).

You're right, code providing standard APIs to drivers (be it filesystem 
drivers or network card drivers) need to be aware that these drivers can 
be modular, and need to get that case right.

However, the try_inc_mod_count() is only ever used in the slow 
registration paths (in the example e.g. for mounting, but not for accesses 
to a mounted file system), so performance is not an issue. And getting 
APIs exported to drivers right needs thinking, yes, but the module 
locking isn't even the hard part there, I would claim.

What you are doing is basically removing the infrastructure to get the use 
count right in a race-free way, and cope with the race by leaving modules 
in 'cleanup' but not 'freed' state until the users you raced with have 
gone away.

BTW, the patch below also needs changes to each filesystem driver to 
return &fs->refcnt as ->use_count(), I think. And since there's no global 
lock to protect it, as opposed to the unload_lock for the old module use 
count, you have no way to protect the use_count between checking it 
to be zero and calling ->exit(). It can be incremented in between, and you 
cover up for that race by failing ->exit(), leaving the file_system in 
used but not registered state. I just don't like this any better.

--Kai

