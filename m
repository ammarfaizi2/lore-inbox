Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTBCKoP>; Mon, 3 Feb 2003 05:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTBCKoP>; Mon, 3 Feb 2003 05:44:15 -0500
Received: from dp.samba.org ([66.70.73.150]:46984 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265708AbTBCKoK>;
	Mon, 3 Feb 2003 05:44:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Mon, 03 Feb 2003 09:31:35 BST."
             <200302030831.h138VZ4p011397@eeyore.valparaiso.cl> 
Date: Mon, 03 Feb 2003 21:52:45 +1100
Message-Id: <20030203105342.15D152C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302030831.h138VZ4p011397@eeyore.valparaiso.cl> you write:
> Rusty Russell <rusty@rustcorp.com.au> said:
> > Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
> > foo driver isn't found, and (2) the new driver author decides that
> > it's a valid replacement.
> 
> So the alias only works if the original isn't found?

It's defined to be that way for aliases taken from the modules
themselves, for this very reason: the admin has no control over it.

It's undefined for the "in the config file case" (they curently *do*
override, but that's an implementation detail).  It'd be clearer to
explicitly say "you can't override module names with "alias", use
"install" instead, IMHO.

> Weird... I'd just
> rename the dang thing and get over it. A distribution kernel won't be able
> to use this anyway, as they'll either build both alternatives or just one
> of them and adjust configuration to match.

I'm not so sure.  There have been several cases where a more than one
driver supports the same card, but the old one is kept around "just in
case".  Backwards compatibility during such a transition would be
really nice.

In most cases the admin, not the distribution, is the one setting the
module options: losing them when you upgrade the kernel is not good.

> > Whether (2) is ever justified, I'm happy leaving to the individual
> > author (I know, that makes me a wimp).
> 
> Don't trust authors too much when it comes to guessing at random individual
> installations... ;-)

Well, true, but if they don't, there's a deeper problem.

> > Consider another example: convenience aliases such as char-major-xxx.
> > Now, I'm not convinced they're a great idea anyway, but if people are
> > going to do this, I'd rather they did it in the kernel, rather than
> > some random userspace program.
> 
> The module munging programs and their configuration are (logically) a part
> of the kernel (configuration). So this goes against the current wave of
> exporting as much as possible from the kernel.

Well, one major point of the module rewrite is that kernel internals
belong in the kernel sources.  If you disagree with that, we're
probably not going to make progress.

> And IMHO it places policy into the kernel, where it has no place.

I try to avoid such fuzzy discussions, as they are rarely benificial.

I would point suggest that you grep for "request_module" in order to
understand (1) where policy already is in the kernel, (2) why it is in
the kernel, and (3) why this suggestion merely centralizes it.

> Plus it enlarges modules, which is a consideration for
> installation/rescue media.

Now I think you're really grasping at straws, but you could always use
"strip -R .modinfo" if you want to save ~20 bytes.

> Maybe I'm just being a bit too conservative here. But I still think this is
> too dangerous for little (or even no) real gain.

Possibly.  However I beg you to consider how you would introduce a new
cypher into 2.6.3.

> Could you please provide examples of use in generic, distribution kernels?
> Contrast with configuration in /etc/modules.conf and/or modprobe (I think
> placing this stuff in modprobe is wrong, but that is the way it is today). 

Ignoring the hotplug stuff which is going to use it, consider adding a
new binary format for XYZ3000 compatibility.  For 2.4, you have to do:

	1) Write the new binfmt_XYZ3000 module.

	2) Write a patch to the modutils to place it in the built-in
	   modules config.  Keith's quite receptive with this.

	3) Tell your users to upgrade modutils or place "alias
	   binfmt-764 binfmt_XYZ3000" in their /etc/modules.conf (or
	   /etc/modprobe.d/local for Debian).

For 2.5:
	1) Write the new binfmt_XYZ3000 module.

	2) Place MODULE_ALIAS("binfmt-764") at the bottom.

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
