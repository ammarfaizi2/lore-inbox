Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSG1Lyr>; Sun, 28 Jul 2002 07:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSG1Lyr>; Sun, 28 Jul 2002 07:54:47 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:36619 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315758AbSG1Lyq>; Sun, 28 Jul 2002 07:54:46 -0400
Date: Sun, 28 Jul 2002 13:57:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface 
In-Reply-To: <20020727070413.EF52943E4@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207281236160.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 27 Jul 2002, Rusty Russell wrote:

> > Converting the module pointer into a counter is the easiest way to convert
> > to the new interface. Behind that is a very important concept - complete
> > seperation of module state management (done in kernel/module.c) and module
> > usage management (done by the module). Both are independent in my patch,
> > so the module has complete freedom how to do the later. This means it
> > doesn't has to use a counter, the usecount function could be as well
> > something like "return busy ? 1 : 0;" and the module won't be bothered
> > with unloading.
>
> But your added flexibility doesn't actually buy you any more power.
> It does mean (as implemented) that even without module support in your
> kernel, filesystems have to be reference counted.

Somehow you to keep the filesystem busy, while it's mounted, how else do
you want to do this?

> > On the other hand if a module needs something more
> > complex, it can do so without bothering the remaining the module code
> > (e.g. if I look at the LSM hooks, I'm really not sure how to sanely unload
> > a module from that).
>
> Exactly.  I don't see how it is a definitive win 8(

The important point is seperation of concepts and consequently making them
independent. This means I can exchange parts of them without breaking
anything else. Reference counting is simple and portable, whereas
scheduling tricks are not. If LSM needs a synchronize_kernel() to unload,
it's not difficult to add it to my patch, but if someone changes the
scheduler and breaks synchronize_kernel(), it will only break LSM
unloading and not every single module. My module interface is more
resistant to changes in other parts of the kernel.

> The implementation in the older patches did:
>
> 	module->waiting = current;
> 	err = module->stop();
> 	if (err)
> 		return err;
> 	synchronize_kernel();
> 	module_put(module);
> 	while (atomic_read(&module->count)) {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule();
> 	}

What is stop() supposed to do? If it just removes interfaces, it still
possible someone starts using the module and you possibly wait forever in
the loop.

> > Insmod just had to relocate the
> > module and the kernel only needs the pointer to the module structure and
> > finds the rest through it, so no adding of new sections/symbols or
> > initialization of the module structure would be required, so insmod hadn'
>
> I think the in-kernel linker is much neater, and much smaller than the
> combined one.  One big advantage is that I don't have to do 64-bit
> links on a 32-bit userspace.

Linking a 64-bit module in 32-bit userspace shouldn't be that big
problem? Initializing some kernel structures would be a problem, but I
want to get rid of this too and keep them in userspace. The userspace
linker could be as simple as your kernel linker.

bye, Roman

