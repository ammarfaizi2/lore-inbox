Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSK0Q7I>; Wed, 27 Nov 2002 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSK0Q7H>; Wed, 27 Nov 2002 11:59:07 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:11966 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263491AbSK0Q7G>; Wed, 27 Nov 2002 11:59:06 -0500
Date: Wed, 27 Nov 2002 11:05:58 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: ingo.oeser@informatik.tu-chemnitz.de, <linux-kernel@vger.kernel.org>,
       <rusty@rustcorp.com.au>, <vandrove@vc.cvut.cz>, <zippel@linux-m68k.org>
Subject: Re: Modules with list
In-Reply-To: <200211261618.IAA03839@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211271052320.3864-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Adam J. Richter wrote:

> >No. That means dangling pointers everywhere. Remember dev_exit_p() 
> >and why it was introduced.
> 
> 	First of all, let's understand how small this problem is.
> dev_exit_p was introduceed to allow a debugging using a feature of
> newer versions of ld.  It was never essential.  devexit_p() is only
> relevant to non-hotplug systems.

That's wrong. It's essential, since the following happens:

static void __devexit my_remove()
{
}

static struct pci_driver my_driver = {
	.name		= "my",
	.probe		= my_probe,
	.remove		= __devexit_p(my_remove),
};

For CONFIG_HOTPLUG set, __devexit == "" and __devexit_p(x) == x,
so everything's obviously fine.

For CONFIG_HOTPLUT not set, my_remove gets discarded from vmlinux, so we 
cannot set my_driver.remove = my_remove, since that symbol doesn't even 
exist anymore. Older binutils quietly accepted this, but recent ones
correctly barf. That's why in that case __devexit_p(x) == NULL, so
my_remove isn't referenced. It's not a debugging feature of ld, it's just
correct behavior and it's not possible to turn it off.

> 	devexit_p() is currently is used only for static
> initialization of driver->remove(), although I suspect that that ld
> debugging feature has probably exposed some bugs that have been fixed.
> So, in practice, all of the dangling pointers that it currently
> avoids could be avoided by adding a few lines in places like
> driver_register():
> 
> #ifndef CONFIG_HOTPLUG
> 	if (!driver->module->removable)
> 		driver->remove = invoke_bug;
> #endif

Since in that case driver->remove == NULL, that gives you a nice oops
when trying to invoke it, no need for an explicit invoke_bug ;)

> 	It's probably overkill, but, in the longer term, we could
> eliminate CONFIG_HOTPLUG, have .devexit{,data} sections, and build yet
> another ELF section listing the devexit_p pointers, by defining
> devexit_p like so.
> 
> #define devexit_p(symbol)	( \
> 			asm (".pushsection .devexit_p_refs\n"	\
> 			     ".long " #symbol "\n"		\
> 			     ".popsection\n");			\
> 			symbol )

Again, that doesn't fix the problem that we have a reference to a symbol 
which doesn't exist since we just discarded it.

One way to fix this is to make my_remove a weak symbol, so that the linker
just silently puts in NULL when it's not defined elsewhere, which would
avoid the ugly __devexit_p(). Not sure if that doesn't end up in even 
uglier hacks, though.

Another way to fix this is of course to always have CONFIG_HOTPLUG=y,
which may become necessary anyway when properly shutting down devices at
shutdown/reboot.

--Kai


