Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267709AbTAaGOm>; Fri, 31 Jan 2003 01:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267710AbTAaGOm>; Fri, 31 Jan 2003 01:14:42 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50917 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267709AbTAaGOl>; Fri, 31 Jan 2003 01:14:41 -0500
Date: Fri, 31 Jan 2003 00:23:56 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <20030131002043.947632C056@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2003, Rusty Russell wrote:

> This patch adds MODULE_ALIAS("foo") capability, and uses it to
> automatically generate sensible aliases from device tables.  The
> post-processing is a little rough, but works.
> 
> Name: Module alias and device table support
> Author: Rusty Russell
> Status: Tested on 2.5.59
> 
> D: Introduces "MODULE_ALIAS" which modules can use to embed their own
> D: aliases for modprobe to use.  Also adds a "finishing" step to modules to
> D: supplement their aliases based on MODULE_TABLE declarations, eg.
> D: 'usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*' for drivers/usb/net/pegasus.o

Some comments:
o First of all, we're basically moving depmod functionality into the 
  kernel tree, which I regard as a good thing, since we have to deal
  with actual kernel structures here. (The obvious disadvantage is that
  this makes it much easier to change these kernel structures, which
  breaks compatibility with other (user space) tools who expect a certain
  format)
  I was wondering if it's not somewhat kludgy to add info into an ELF 
  section into a module, just to have it extracted again by modutils
  shortly afterwards - the alternative would be to have the kernel
  generate modules.*map directly (or rather modules.alias now).
  However, I guess I'm convinced now that this is per-module information
  and should be kept as such. To avoid all kinds of trouble with separate 
  files (module.ko and module.alias), it's probably really best to store 
  it into an elf section directly.
o My nm (RH 7.2 or .3, GNU nm 2.11.90.0.8) doesn't support --print-size.
  That'll probably affect many users.
o What about collecting the struct xxx_device_id definitions into some
  header which could be included from the userspace code extracting
  the info instead of duplicating it. Still not quite fool-proof, but
  better than duplicating the info.
o I think it'd be a good time to consider naming these sections e.g.
  "__discard.modalias", the license one "__discard.license" and have
  the kernel module loader discard "__discard*", so that it doesn't
  need to be aware of all that special crap, nor waste space for it. 
  (Well, it needs to know about the license, anyway, so that's not such
  a good example).
o I'm not totally happy with the integration into the build system yet,
  but it'll clash with the module versioning changes anyway ;)

The modversions patch introduces a postprocessing stage for modules, which 
currently will only be invoked with CONFIG_MODVERSIONS set. However, I'm 
considering to make that pass mandatory either way. It basically obtains 
the list of all modules from the earlier stage, so it doesn't recurse and 
can thus be very fast. I'm currently coding the actual versioning process 
in C, since the shell / sed / grep based solution's performance isn't 
exactly great. In doing that, I already notice unresolved symbols and warn 
about them, which I think is an improvement to the build process, missing 
EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.

Doing this postprocessing unconditionally would allow to generate the 
alias tables at this point as well.

And while we're at it, we could add another section which specifies which 
other modules this module depends on (a.k.a which symbols it uses), making 
depmod kinda obsolete.

--Kai

