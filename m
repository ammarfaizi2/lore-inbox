Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSK0SL7>; Wed, 27 Nov 2002 13:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSK0SL7>; Wed, 27 Nov 2002 13:11:59 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:12164 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261963AbSK0SL5>; Wed, 27 Nov 2002 13:11:57 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 10:19:02 -0800
Message-Id: <200211271819.KAA24041@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Modules with list
Cc: ingo.oeser@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
>On Tue, 26 Nov 2002, Adam J. Richter wrote:
>> >No. That means dangling pointers everywhere. Remember dev_exit_p() 
>> >and why it was introduced.
>> 
>> 	First of all, let's understand how small this problem is.
>> dev_exit_p was introduceed to allow a debugging using a feature of
>> newer versions of ld.  It was never essential.  devexit_p() is only
>> relevant to non-hotplug systems.

>That's wrong. [...]

>[...] It's not a debugging feature of ld, it's just
>correct behavior and it's not possible to turn it off.

	Hmm.  We could certainly have a binary editing tool to remove
what was the .exit{,func} sections after the link.  Perhaps we can
even express this as an ld script for linking the core kernel.  We
could put .exit{,func} at the end of the kernel and turn it into
section like bss (SHT_NOBITS?) that has valid addresses but no
contents.  I haven't tried this, so I don't know if ld would
barf when asked to throw away data this way, but anyhow here
is an untried diff just to illustrate:

--- linux/arch/i386/vmlinux.lds.orig    2002-11-27 09:51:42.000000000 -0800
+++ linux/arch/i386/vmlinux.lds.S       2002-11-27 09:54:17.000000000 -0800
@@ -97,11 +97,11 @@
   _end = . ;
 
   /* Sections to be discarded */
-  /DISCARD/ : {
+  .discard : {
        *(.exit.text)
        *(.exit.data)
        *(.exitcall.exit)
-       }
+       } = 0x0001              /* Like bss: SEC_ALLOC, but no SEC_LOAD */
 
   /* Stabs debugging sections.  */
   .stab 0 : { *(.stab) }



[...]
>> 	It's probably overkill, but, in the longer term, we could
>> eliminate CONFIG_HOTPLUG, have .devexit{,data} sections, and build yet
>> another ELF section listing the devexit_p pointers, by defining
>> devexit_p like so.
>> 
>> #define devexit_p(symbol)	( \
>> 			asm (".pushsection .devexit_p_refs\n"	\
>> 			     ".long " #symbol "\n"		\
>> 			     ".popsection\n");			\
>> 			symbol )

>Again, that doesn't fix the problem that we have a reference to a symbol 
>which doesn't exist since we just discarded it.

	In this scenario, the .exit{,func} section would be linked
in and then discarded by the module loader, by the process of the
kernel releasing its .init{,data} areas, or, if you wanted to build
a bzImage without CONFIG_HOTPLUG, by using a binary editing tool or
perhaps an ld script as I mentioned earlier in this response.

	The point of the .devexit_p_refs section would just be to
set those references to NULL if that was useful.  The kernel module
load code would do something like:

	if (!module->removable) {
		void **pptr = module->devexit_p_start;
		while (pptr != module->devexit_p_end) {
			*pptr = NULL;
			pptr++;
		}
	}

>One way to fix this is to make my_remove a weak symbol, so that the linker
>just silently puts in NULL when it's not defined elsewhere,

	I don't believe that will work, since the "weak" facility
is for resolving external symbols.  For example, as barfs when I try
the following:

	.weak foo
foo=0
	.section .exit
foo:


[...]
>Another way to fix this is of course to always have CONFIG_HOTPLUG=y,
>which may become necessary anyway when properly shutting down devices at
>shutdown/reboot.

Going off topic here:

	Most devices do not need custom reset code because the parent
bus's reset operation will reset them.  Those few devices that need
custom reset code can register a device_driver->shutdown instead of
or in addition to device_driver->remove, regardless of CONFIG_HOTPLUG.

	Calling every device's remove function wastes time, especially
since remove functions have to block until all IO's terminate in one
form or another so that the system can reuse things like USB device
ID's in future, something completely unnecessary if a bus level reset
and system reboot are about to be done.  More importantly, calling
every driver's ->remove() function means decreasing reliability,
because one reason for rebooting is that a driver is confused, and
each driver's ->remove() function does a fair amount of house keeping.
So, it would become much more common to be unable to do a remote soft
reboot to recover from a confused device driver.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
