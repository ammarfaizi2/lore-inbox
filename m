Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSGRJ6P>; Thu, 18 Jul 2002 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317699AbSGRJ6P>; Thu, 18 Jul 2002 05:58:15 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:54279 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316848AbSGRJ6P>; Thu, 18 Jul 2002 05:58:15 -0400
Date: Thu, 18 Jul 2002 12:01:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
In-Reply-To: <E17UyWI-0004fQ-00@starship>
Message-ID: <Pine.LNX.4.44.0207181124010.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jul 2002, Daniel Phillips wrote:

> But I don't see why this needs to be a two step process:
>
>        module support calls mod->cleanup
>               module code checks number of users
>               if none, unregister all interfaces
>               otherwise return -EBUSY
>        if return wasn't -EBUSY, free all resources

So after you checked for users, someone starts using the module again,
before you were able to remove all interfaces -> OOPS.
This is exactly the reason why I prefer to make this explicit in the
module interface - the chances are higher to get this right.

> > It's possible to use the filesystem model, but it's unnecessary complex
> > and inflexible.
>
> What is the complex and inflexible part?

It has to work around the problem that cleanup_module() can't fail.

> > Another problem is that the more interfaces a module has (e.g. proc), the
> > harder it becomes to unload a module (or the easier it becomes to prevent
> > the unloading of a module).
>
> I don't see that this makes any difference at all.

It's currently impossible to force the unloading of a module, some user
can always keep a reference to the module. Even if you kill the process,
someone else can get a new reference, before you could unload the module.

> I'm proposing to add a return code to mod->cleanup (and pick a better
> name).  Yes, every module will have to be fixed to use this interface, but
> why not?

I don't disagree, but if we break the module interface anyway, why don't
we clean it up properly?
(Patches that do that will follow shortly.)

> Anyway, you're proposing to do it backwards.  We need to first ensure
> there are no users, then unregister the interfaces.

That's broken (see above).

bye, Roman

