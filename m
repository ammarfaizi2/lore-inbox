Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266387AbSKZQNN>; Tue, 26 Nov 2002 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266390AbSKZQNM>; Tue, 26 Nov 2002 11:13:12 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:6866 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266387AbSKZQNL>; Tue, 26 Nov 2002 11:13:11 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 26 Nov 2002 08:18:34 -0800
Message-Id: <200211261618.IAA03839@baldur.yggdrasil.com>
To: ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, vandrove@vc.cvut.cz,
       zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> = Adam Richter
>>  = Rusty Russell
>   = Ingo Oeser

>>>     5. At modprobe time, being able to decide to load a module
>>>        as non-removable to avoid loading .exit{,data} for a smaller
>>>        kernel footprint.  This might only require insmod changes
>>>        for the user level insmod.
>> Hmm, I already discard these if !CONFIG_MODULE_UNLOAD, but it'd be a
>> cute hack to let the user do this.
> 
>No. That means dangling pointers everywhere. Remember dev_exit_p() 
>and why it was introduced.

	First of all, let's understand how small this problem is.
dev_exit_p was introduceed to allow a debugging using a feature of
newer versions of ld.  It was never essential.  devexit_p() is only
relevant to non-hotplug systems.

	devexit_p() is currently is used only for static
initialization of driver->remove(), although I suspect that that ld
debugging feature has probably exposed some bugs that have been fixed.
So, in practice, all of the dangling pointers that it currently
avoids could be avoided by adding a few lines in places like
driver_register():

#ifndef CONFIG_HOTPLUG
	if (!driver->module->removable)
		driver->remove = invoke_bug;
#endif

	It's probably overkill, but, in the longer term, we could
eliminate CONFIG_HOTPLUG, have .devexit{,data} sections, and build yet
another ELF section listing the devexit_p pointers, by defining
devexit_p like so.

#define devexit_p(symbol)	( \
			asm (".pushsection .devexit_p_refs\n"	\
			     ".long " #symbol "\n"		\
			     ".popsection\n");			\
			symbol )


	Then "--permanent --disable-hotplug" could be selected
at modprobe time and at boot time (the .devexit{,func} sections
would be loaded just before .init{,func}, and could be dropped or
kept).  modprobe could then clear all devexit_p references if we
really wanted to bother. and the kernel could do the same for
its built-in objects.  We could also have a binary utility to
scrape out the hotplug support from a .o file based on the
contents of the .devexit_p_refs section if we wanted to use
that ld debugging feature or for smaller .o and bzImage file
sizes.

	If you want to be even fancier, we could have separate
CONFIG_PCI_HOTPLUG, CONFIG_USB_HOTPLUG, and pci_devexit_p(),
usb_devexit_p(), a .pci_devexit_p section, a .usb_devexit_p
section, and so on for each pluggable bus type.

	Would this be overkill?  CONFIG_HOTPLUG currently only
controls hot plugging for busses where it is wiredly used (USB,
CardBus, but not ordinary PCI cards).  To my knowledge, nobody has
complained about the lack of "!CONFIG_HOTPLUG" for pcmcia, for
example.  An alternative is to drop "!CONFIG_HOTPLUG" support, and
have CardBus and USB always support hotplug.  Eliminating
CONFIG_HOTPLUG would simplify a lot of source code at the expense of
making object files and the kernel footprint slightly larger for users
that would otherwise want to compile it out.

	Anyhow, eliminating "ifdef MODULE" from <linux/init.h> is
not immenent, and having driver_register() clobber driver->remove
for non-removable modules in non-hotplug systems should initially
address the runtime issues (although not the loss of that ld debugging
check).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
