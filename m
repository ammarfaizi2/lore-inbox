Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTBAHME>; Sat, 1 Feb 2003 02:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTBAHME>; Sat, 1 Feb 2003 02:12:04 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30697 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264739AbTBAHMD>; Sat, 1 Feb 2003 02:12:03 -0500
Date: Sat, 1 Feb 2003 01:20:43 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: <20030201041428.28F682C08C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302010057100.18814-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2003, Rusty Russell wrote:

> > o First of all, we're basically moving depmod functionality into the 
> >   kernel tree, which I regard as a good thing, since we have to deal
> >   with actual kernel structures here. (The obvious disadvantage is that
> >   this makes it much easier to change these kernel structures, which
> >   breaks compatibility with other (user space) tools who expect a certain
> >   format)
> 
> Yes, but people already expect to run depmod at boot, and I haven't
> made depmod safe for cross compiling.  It could be done, but is it
> worth it?  I don't know.

Well, I don't necessarily mean to kill all of depmod, I guess it still 
makes sense to have userspace code extract and contract dependency and 
alias information, so that modprobe doesn't need to open all modules just 
to find the one which is requested. 

It's not mandatory to use depmod though, it's e.g. possible someone comes 
up with code which composes an initramfs on the fly, that might be 
perfectly happy with extracting the information directly from the modules.

> BTW, the reason for using the alias mechanism is that aliases are
> useful in themselves: consider you write a "new_foo" driver, you can
> do "MODULE_ALIAS("foo")" and so no userspace changes are neccessary.
> module-init-tools 0.9.8 already supported this.

Yup, that's nice.

> > o My nm (RH 7.2 or .3, GNU nm 2.11.90.0.8) doesn't support --print-size.
> >   That'll probably affect many users.
> 
> OK.  Fortunately I have a new version of the table2alias program which
> takes the elf object directly, anyway, which has the benifit of being
> faster, too.

Alright. I think we're heading towards a generic postprocessor here, which
takes the .o, extracts information as necessary and generates some .c file 
which contains e.g. checksums for the unresolved symbols (when MODVERSIONS 
is selected), a section to record which modules we depend on, an alias 
section etc. This .c is then compiled and linked into the final .ko

table2alias would then be just another module in this postprocessor.
(My current version is in C already but calls "nm" to extract symbol info. 
If we put in the code from your new table2alias, I suppose we can instead 
open the object directly and find the information as necessary)

> I prefer to keep special symbols out of section names, so we can do
> nice tricks later with __start_.  So __discard_modalias would be my
> preference if we're going to change it.

Fine with me. Since it's not being actually used yet, if you agree on 
changing it, let's do it now ;)
> 
> > o I'm not totally happy with the integration into the build system yet,
> >   but it'll clash with the module versioning changes anyway ;)
> 
> Yeah, I thought you'd say that 8).  I consider this to be after
> modversions in the queue, and I don't want to overload you.

Yup, I think modversions should have a little time to settle first. 
There's really only one tricky point with modversions (and the other stuff 
above), i.e. we need a complete list of all modules. With people 
playing tricks with "make SUBDIRS=..." that needs some care to not go 
accidentally wrong.

> We can already figure what symbols it uses in depmod: the original
> modprobe did just that, but Adam Richter complained about speed with
> 1200 modules (sure, it's < 1 second for most people, but Debian on an
> old 486 would suck hard).

Well, just reading the symbols from my 100 modules takes about 1.5 secs on 
the laptop here, and that's with everything in cache, so I think Adam was 
right there ;)

--Kai

