Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTBAEFC>; Fri, 31 Jan 2003 23:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTBAEFC>; Fri, 31 Jan 2003 23:05:02 -0500
Received: from dp.samba.org ([66.70.73.150]:45213 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264715AbTBAEFA>;
	Fri, 31 Jan 2003 23:05:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Fri, 31 Jan 2003 00:23:56 MDT."
             <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu> 
Date: Sat, 01 Feb 2003 14:49:57 +1100
Message-Id: <20030201041428.28F682C08C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu> y
ou write:
> On Fri, 31 Jan 2003, Rusty Russell wrote:
> > D: Introduces "MODULE_ALIAS" which modules can use to embed their own
> > D: aliases for modprobe to use.  Also adds a "finishing" step to modules to
> > D: supplement their aliases based on MODULE_TABLE declarations, eg.
> > D: 'usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*' for drivers/usb/net/pegasus.o
> 
> Some comments:
> o First of all, we're basically moving depmod functionality into the 
>   kernel tree, which I regard as a good thing, since we have to deal
>   with actual kernel structures here. (The obvious disadvantage is that
>   this makes it much easier to change these kernel structures, which
>   breaks compatibility with other (user space) tools who expect a certain
>   format)

Yes, but people already expect to run depmod at boot, and I haven't
made depmod safe for cross compiling.  It could be done, but is it
worth it?  I don't know.

BTW, the reason for using the alias mechanism is that aliases are
useful in themselves: consider you write a "new_foo" driver, you can
do "MODULE_ALIAS("foo")" and so no userspace changes are neccessary.
module-init-tools 0.9.8 already supported this.

> o My nm (RH 7.2 or .3, GNU nm 2.11.90.0.8) doesn't support --print-size.
>   That'll probably affect many users.

OK.  Fortunately I have a new version of the table2alias program which
takes the elf object directly, anyway, which has the benifit of being
faster, too.

> o What about collecting the struct xxx_device_id definitions into some
>   header which could be included from the userspace code extracting
>   the info instead of duplicating it. Still not quite fool-proof, but
>   better than duplicating the info.

Great minds think alike: this was what Greg said.  I did this in the
updated patch.

> o I think it'd be a good time to consider naming these sections e.g.
>   "__discard.modalias", the license one "__discard.license" and have
>   the kernel module loader discard "__discard*", so that it doesn't
>   need to be aware of all that special crap, nor waste space for it. 
>   (Well, it needs to know about the license, anyway, so that's not such
>   a good example).

I prefer to keep special symbols out of section names, so we can do
nice tricks later with __start_.  So __discard_modalias would be my
preference if we're going to change it.

> o I'm not totally happy with the integration into the build system yet,
>   but it'll clash with the module versioning changes anyway ;)

Yeah, I thought you'd say that 8).  I consider this to be after
modversions in the queue, and I don't want to overload you.

> The modversions patch introduces a postprocessing stage for modules, which 
> currently will only be invoked with CONFIG_MODVERSIONS set. However, I'm 
> considering to make that pass mandatory either way. It basically obtains 
> the list of all modules from the earlier stage, so it doesn't recurse and 
> can thus be very fast. I'm currently coding the actual versioning process 
> in C, since the shell / sed / grep based solution's performance isn't 
> exactly great. In doing that, I already notice unresolved symbols and warn 
> about them, which I think is an improvement to the build process, missing 
> EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.

Well, you get them as warnings from depmod, but more timely checks is
good.

> Doing this postprocessing unconditionally would allow to generate the 
> alias tables at this point as well.
> 
> And while we're at it, we could add another section which specifies which 
> other modules this module depends on (a.k.a which symbols it uses), making 
> depmod kinda obsolete.

We can already figure what symbols it uses in depmod: the original
modprobe did just that, but Adam Richter complained about speed with
1200 modules (sure, it's < 1 second for most people, but Debian on an
old 486 would suck hard).

But putting the dependent module names in a section... I must say I
rather like that.  I'll have to mull it over though.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
