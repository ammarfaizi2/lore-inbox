Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSGQWm0>; Wed, 17 Jul 2002 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGQWm0>; Wed, 17 Jul 2002 18:42:26 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:61200 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316820AbSGQWmX>; Wed, 17 Jul 2002 18:42:23 -0400
Date: Thu, 18 Jul 2002 00:45:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
In-Reply-To: <E17UvVM-0004Pp-00@starship>
Message-ID: <Pine.LNX.4.44.0207172338150.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 Jul 2002, Daniel Phillips wrote:

> > The start/stop methods are not needed to fix the races, they allow better
> > control of the unload process.
>
> I'm afraid it must show that I didn't read the previous threads closely
> enough, but what is the specific benefit supposed to be, if not to address
> the races?

The basic idea is to allow modules to let the unload fail. The unload
process would basically look like this:

	unregister all interfaces;
	if (no users)
		free all resources;

These two phases have to be done anyway, making it explicit in the module
interface gives more control to the user, e.g. you can disallow the
mounting of a new fs, while others are still mounted.

> > For filesystems it's only simpler because they only have a single entry
> > point, but the basic problem is always the same.
>
> What do you mean by single entry point?  Mount?  Register_filesystem?

I meant the first entry point into the module code that needs to be
protected (e.g. get_sb during mount).

> So, I'm still hoping to hear a substantive reason why the filesystem model
> can't be applied in general to all forms of modular code.

It's possible to use the filesystem model, but it's unnecessary complex
and inflexible. It should be possible to keep try_inc_mod_count() out of
the hot paths, but you have to call it e.g. at every single open().
Another problem is that the more interfaces a module has (e.g. proc), the
harder it becomes to unload a module (or the easier it becomes to prevent
the unloading of a module).

>  To remind you
> of the issue: the proposition is that the subsystem in the module is
> always capable of knowing when the module is quiescent, because it does
> whatever is necessary to keep track of the users and what they're doing.

The problem is that the module can't do anything with that information, at
the time cleanup_module() is called it's already to late. That information
has currently to be managed completely outside of the module.

bye, Roman

