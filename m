Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSIYVXn>; Wed, 25 Sep 2002 17:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262073AbSIYVXn>; Wed, 25 Sep 2002 17:23:43 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:54793 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262065AbSIYVXl>; Wed, 25 Sep 2002 17:23:41 -0400
Date: Wed, 25 Sep 2002 23:28:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020925125556.6321A2C387@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209252003370.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Sep 2002, Rusty Russell wrote:

> Once you move the linking outside the kernel, you need to communicate
> more information.  You need some form of "allocate", and "here is all
> the other symbol information", then "please tell me what you used so I
> can update the reference counts" and "place linked module".  So you've
> added some complexity to deal with synchronization of these acts with
> a userspace process.

With the new module layout this will be avoided as much as possible. This
information is already mostly generated during compile time and only
extracted by insmod. So to avoid this we only need to store the
information in a way the kernel can find it itself without insmod help.
Now let's look at the new module interface:

DEFINE_MODULE
	.init	= init_affs_fs,
	.exit	= exit_affs_fs,
DEFINE_MODULE_END

DEFINE_MODULE is used to define a structure, which looks like this:

struct module __this_module = {
	.ex_table_start	= __ex_table_start,
	.ex_table_end	= __ex_table_end,
	.syms_start	= __syms_start,
	.syms_end	= __syms_end,

Now we can use a linker script like this:

SECTIONS
{
	.module : { *(.module_struct) }
	.text : { *(.text) }
	.data : { *(.data) }
	.syms : {
		__syms_start = .;
		*(__ksymtab)
		__syms_end = .;
	}
	.ex_table : {
		__ex_table_start = .;
		*(__ex_table)
		__ex_table_end = .;
	}
	.bss : { *(.bss) }
}

which can be used to add all the information usually added by insmod. So
ld does already most of the work and insmod only needs to do the
relocation and the kernel finds at the start of the module all
information it needs. The only information which is left to be added are
the module arguments.

> Now, say your architecture decided that it wanted to try to allocate
> its modules: it wants to allocate one part for init and one for core
> (so the init can be easily discarded), but if they're not close
> enough, it'll give up and allocate one big one and not discard init.
>
> But half if it is in userspace, so you have to support both in the
> kernel and both in userspace while you are in transition.  Or, say the
> kernel slightly changes the way it parses boot paramters and you
> wanted the module to match?  Or you wanted to change the version
> encoding?  Or something else I don't know about yet?

A possible solution would be to do something what I'm planning to do for
kernel conf - export it as library, then external tools can link the
module linker in dynamically.

> Let's look at what we can expect to remove from the kernel by moving
> the linking stage out.  Probably the most complex architecture to link
> is ia64.  And that linker is 507 lines (approx, it needs to be updated
> to the latest patch).  x86 is 130 lines.  Add maybe 200 lines of
> arch-independent code to help.
>
> It it *now* clear why I'm not interested in saving a few hundred lines
> of kernel code, even if the communication overhead didn't eat them up
> again?

It's not only this. A kernel linker would force us to keep all symbol
information in kernel space. Doing the linking in userspace would allow us
to remove all symbol information from the kernel (and only keep them for
debugging, e.g. kksymoops), even module dependency tracking could be done
completely from userspace. Module related information could be reduced to
an absolute minimum, so that a nonmodular kernel had no advantage to a
modular kernel anymore.

bye, Roman

