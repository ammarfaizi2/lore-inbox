Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSKZLia>; Tue, 26 Nov 2002 06:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSKZLia>; Tue, 26 Nov 2002 06:38:30 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:25996 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264639AbSKZLi3>; Tue, 26 Nov 2002 06:38:29 -0500
Date: Tue, 26 Nov 2002 08:57:22 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, vandrove@vc.cvut.cz,
       zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Modules with list
Message-ID: <20021126085722.S628@nightmaster.csn.tu-chemnitz.de>
References: <200211252211.OAA02085@baldur.yggdrasil.com> <20021126003800.6BC312C2C0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021126003800.6BC312C2C0@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 26, 2002 at 11:35:09AM +1100
X-Spam-Score: -3.2 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Ge9v-0006jc-00*P5nG9AwiiJg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 11:35:09AM +1100, Rusty Russell wrote:
> In message <200211252211.OAA02085@baldur.yggdrasil.com> you write:
> > 	2. Eventually have the same build command for modules and
> > 	   compiled in objects so that distribution makes can ship an
> > 	   "all modules" build and link script to allow much more
> > 	   customization by users who do not want to recompile kernel code.
> 
> Hmm, I've never really aimed for this, and as you've noticed, there
> are a few issues.
 
Maybe that could be done already by having a list of modules for
initramfs? That's Alans plan anyway, so we might as well solve it
here.

> > 		2c. Eliminate "#ifdef MODULE" init.h, module.h, and,
> > 		    eventually, almost everywhere.
> > 
> > 		2d. In the core kernel, THIS_MODULE would point to
> > 		    a struct module rather than being NULL (eliminating
> > 		    many little banches).
> 
> I thought about doing this, but the branch cost IRL is trivial on
> modern processors with decent branch prediction (since it will almost
> always be the same way).
 
It's not about branch prediction, it's about the branch
instruction and readable code. Most code dependend on MODULE can
be made dependend on CONFIG_MODULE_UNLOAD, because the rest is
common or should be rewritten that way.

> > 	5. At modprobe time, being able to decide to load a module
> > 	   as non-removable to avoid loading .exit{,data} for a smaller
> > 	   kernel footprint.  This might only require insmod changes
> > 	   for the user level insmod.
> Hmm, I already discard these if !CONFIG_MODULE_UNLOAD, but it'd be a
> cute hack to let the user do this.
 
No. That means dangling pointers everywhere. Remember dev_exit_p() 
and why it was introduced.

> > 	10. Move tracking of dependencies among loaded modules to
> > 	    user land (and be able to reconstruct in some cases
> > 	    from modules.dep).
> 
> Personally, I think the userspace module loaders are clearly inferior,
> especially as you're gonna break userspace with almost every one of
> these changes.  Sure, you can use a kernel-specific library to give
> you back the interface flexibility, but why?  You gain complexity and
> your kernel doesn't get any smaller anyway.
> 
> Anyway, I think supporting both doesn't make sense.  Either the
> in-kernel module loader is better, in which case it should be kept, or
> it isn't in which case it should be junked.

At least resolving module name aliases to modules and options
hould be done in user space, because that's critical to auto
configuration and readable configuration of the system.

module_name_deamon anyone?

This resolving is clearly seperateable and might not even require
root privileges and can be done as a special user (passed as
kernel parameter and defaulting to UID 0), because we just need
to read a kind of database.

That reduces buffer overflow attacks and the like.

That resolving I'm really missing from the new scheme.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
