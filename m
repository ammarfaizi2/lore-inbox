Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSGQXnY>; Wed, 17 Jul 2002 19:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSGQXnY>; Wed, 17 Jul 2002 19:43:24 -0400
Received: from dsl-213-023-043-222.arcor-ip.net ([213.23.43.222]:50112 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316851AbSGQXnX>;
	Wed, 17 Jul 2002 19:43:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] new module format
Date: Thu, 18 Jul 2002 01:47:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207172338150.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207172338150.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UyWI-0004fQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 00:45, Roman Zippel wrote:
> Hi,
> 
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> 
> > > The start/stop methods are not needed to fix the races, they allow better
> > > control of the unload process.
> >
> > I'm afraid it must show that I didn't read the previous threads closely
> > enough, but what is the specific benefit supposed to be, if not to address
> > the races?
> 
> The basic idea is to allow modules to let the unload fail. The unload
> process would basically look like this:
> 
> 	unregister all interfaces;
> 	if (no users)
> 		free all resources;
> 
> These two phases have to be done anyway, making it explicit in the module
> interface gives more control to the user, e.g. you can disallow the
> mounting of a new fs, while others are still mounted.

But I don't see why this needs to be a two step process:

       module support calls mod->cleanup
              module code checks number of users
              if none, unregister all interfaces
              otherwise return -EBUSY
       if return wasn't -EBUSY, free all resources

> > > For filesystems it's only simpler because they only have a single entry
> > > point, but the basic problem is always the same.
> >
> > What do you mean by single entry point?  Mount?  Register_filesystem?
> 
> I meant the first entry point into the module code that needs to be
> protected (e.g. get_sb during mount).

You haven't given a coherent argument re why it gets harder when there
are multiple ways of adding a user.  Conceptually, each user incs
mod->count; we don't care how many they are, or what kind they are or
when they do it.  All we care about is that they inc the count under
the appropriate lock.

> > So, I'm still hoping to hear a substantive reason why the filesystem model
> > can't be applied in general to all forms of modular code.
> 
> It's possible to use the filesystem model, but it's unnecessary complex
> and inflexible.

What is the complex and inflexible part?

> It should be possible to keep try_inc_mod_count() out of
> the hot paths, but you have to call it e.g. at every single open().

That's not correct.  It's currently called on every mount.

> Another problem is that the more interfaces a module has (e.g. proc), the
> harder it becomes to unload a module (or the easier it becomes to prevent
> the unloading of a module).

I don't see that this makes any difference at all.

> >  To remind you
> > of the issue: the proposition is that the subsystem in the module is
> > always capable of knowing when the module is quiescent, because it does
> > whatever is necessary to keep track of the users and what they're doing.
> 
> The problem is that the module can't do anything with that information, at
> the time cleanup_module() is called it's already to late. That information
> has currently to be managed completely outside of the module.

I'm proposing to add a return code to mod->cleanup (and pick a better
name).  Yes, every module will have to be fixed to use this interface, but
why not?  The current interface is broken, and besides, changing the module
interface every year or so helps nVidia remember why they should be good
and document their hardware, so we can maintain their driver for them.

Since we are changing the interface whichever way it goes, we should favor
the simplest interface.

Anyway, you're proposing to do it backwards.  We need to first ensure
there are no users, then unregister the interfaces.

-- 
Daniel
