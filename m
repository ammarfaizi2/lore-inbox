Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317927AbSGRLFF>; Thu, 18 Jul 2002 07:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317930AbSGRLFF>; Thu, 18 Jul 2002 07:05:05 -0400
Received: from dsl-213-023-043-252.arcor-ip.net ([213.23.43.252]:44742 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317927AbSGRLFE>;
	Thu, 18 Jul 2002 07:05:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] new module format
Date: Thu, 18 Jul 2002 13:09:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207181124010.28515-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207181124010.28515-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17V9A1-0004ml-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 12:01, Roman Zippel wrote:
> Hi,
> 
> On Thu, 18 Jul 2002, Daniel Phillips wrote:
> 
> > But I don't see why this needs to be a two step process:
> >
> >        module support calls mod->cleanup
> >               module code checks number of users
> >               if none, unregister all interfaces
> >               otherwise return -EBUSY
> >        if return wasn't -EBUSY, free all resources
> 
> So after you checked for users, someone starts using the module again,
> before you were able to remove all interfaces -> OOPS.

That's a different issue, and it is handled, though I omitted some details
for brevity:

       module support calls mod->cleanup

              spin_lock(&some_spinlock);
              if (<mod_user_count>)
                     <clear_mod_active_bit>
              spin_unlock(&some_spinlock);

              if <no users>, unregister all interfaces, free resources
              otherwise return -EBUSY
       if return wasn't -EBUSY, free module itself

To add a new user, the active bit has to be set, as shown in this skeleton,
which is pretty much the existing try_inc_mod_count scheme:

       spin_lock(&some_spinlock);
       if (<mod_active_bit>)
               <inc_mod_user_count>
       spin_unlock(&some_spinlock);

       if <users>, do the mount

In other words, the module has some state, the transitions of which are
protected by a spinlock.  My improvement is to move that code out of the
module support code and into the module code itself, so that the module
support code doesn't have to be aware of the details of how this
particular serialization is done - allowing the possibility of other
ways of accomplishing it.  Rusty had no trouble pointing out an example
where the filesystem mechanism per se doesn't work: LSM, where the
module hooks little bits of code in the vfs that cut across all the
file interfaces; it isn't practical to unmount all filesystems to remove
a security module.  So there isn't going to be any 'one size fits all'
determination of what constitutes 'no users', or possibly there really
are modules that just can't be unloaded.

> This is exactly the reason why I prefer to make this explicit in the
> module interface - the chances are higher to get this right.

You see that the code form spin_lock to if <no users> can be a helper
function.  This is truly a dumbed-down interface.

> > > It's possible to use the filesystem model, but it's unnecessary complex
> > > and inflexible.
> >
> > What is the complex and inflexible part?
> 
> It has to work around the problem that cleanup_module() can't fail.

That's a circular argument.  I said above that mod->clean aka cleanup_module
*can* fail, in a nice defined way.  It fails early, before unregistering or
destroying any resources, if there are users on the module.  This is totally
flexible, because it's under the control of the module code.

> > > Another problem is that the more interfaces a module has (e.g. proc), the
> > > harder it becomes to unload a module (or the easier it becomes to prevent
> > > the unloading of a module).
> >
> > I don't see that this makes any difference at all.
> 
> It's currently impossible to force the unloading of a module, some user
> can always keep a reference to the module. Even if you kill the process,
> someone else can get a new reference, before you could unload the module.

The module's active bit prevents that, and forced uload (i.e., the
filesystem module tries to umount all users) is permitted by the
interface.  To accomodate this, we just have to pass a 'force' flag to
mod->cleanup (which, I mentioned, would get a new name).

> > I'm proposing to add a return code to mod->cleanup (and pick a better
> > name).  Yes, every module will have to be fixed to use this interface, but
> > why not?
> 
> I don't disagree, but if we break the module interface anyway, why don't
> we clean it up properly?
> (Patches that do that will follow shortly.)

I am talking about cleaning it up properly, we just disagree on what the
definition of proper is.  Perhaps you haven't explained yourself clearly,
but you have not yet proved a need to add two new function hooks to the
module interface.

I presume we do agree that, if there are two possible interfaces that
accomplish the same thing, we should choose the simpler of them.

> > Anyway, you're proposing to do it backwards.  We need to first ensure
> > there are no users, then unregister the interfaces.
> 
> That's broken (see above).

Err.  I don't see that, no.  Currently, filesystems currently check for
users before unregistering.  I can see there's no way to do that for
LSM, and we may well want to remove all the interfaces first in that
case, then try some of the voodoo that is supposed to ensure no task
is executing in the module code, or give up and admit it's too messy.
In any event, either way of doing it is accomodated by the simple
interface I propose.   It's entirely up to the module to decide which
it should use.

-- 
Daniel
