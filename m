Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbQJ1BaC>; Fri, 27 Oct 2000 21:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbQJ1B3w>; Fri, 27 Oct 2000 21:29:52 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:20495 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130721AbQJ1B3r>;
	Fri, 27 Oct 2000 21:29:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'Hunt Kent'" <kenthunt@yahoo.com>,
        "'lmcclef@lmc.ericsson.se'" <lmcclef@lmc.ericsson.se>,
        "'f5ibh@db0bm.ampr.org'" <f5ibh@db0bm.ampr.org>,
        Greg KH <greg@wirex.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: test[9-10] USB depmod unresolved symbols 
In-Reply-To: Your message of "Fri, 27 Oct 2000 12:55:57 PDT."
             <D5E932F578EBD111AC3F00A0C96B1E6F07DBDB99@orsmsx31.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 12:29:39 +1100
Message-ID: <4565.972696579@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 12:55:57 -0700, 
"Dunlap, Randy" <randy.dunlap@intel.com> wrote:
>I'm currently using 2.4.0-test10-pre6.
>Now if I am running 't10pre6' (no USB in kernel)
>and I do 'depmod -ae', I get lots of these
>"Unresolved symbol" messages from depmod.
>However, if I boot 't10pre6-kuc' (USBcore in kernel)
>and i do 'depmod -ae', it works fine, no errors.

The problem is actually caused by the drivers/usb/Makefile.  Right at
the start we have

  # Objects that export symbols.
  export-objs             := usb.o

Tells the kernel build that usb.o needs compile flag -DEXPORT_SYMTAB.

  # Multipart objects.
  list-multi              := usbcore.o
  usbcore-objs            := usb.o usb-debug.o hub.o

Tells kbuild that usb.o is not a free standing module, instead usb.o,
usb-debug.o and hub.o are linked into module usbcore.o.  There is no
reference to usb.o in the rest of the Makefile, instead you have

  obj-$(CONFIG_USB)               += usbcore.o

All of this is quite normal, kbuild massages the object lists according
to whether they are being built as an object or as a module, part of
that massaging is to handle multiple objects linked into a single
object.  After all the config dependencies have been created, there is
bolierplate code to handle overlapping entries in the various variable
lists, starting with

  # Extract lists of the multi-part drivers.

However there are two lines missing from the end of this boilerplate
code.

  # Take multi-part drivers out of obj-y and put components in.
  obj-y           := $(filter-out $(list-multi), $(obj-y)) $(int-y)

Because those lines are missing, when USB is built into the kernel,
obj-y contains usbcore.o instead of its expansion (usb.o usb-debug.o
hub.o).  When kdbuild compiles the USB objects for the kernel, it does
not know about the special compile flags for usb.o.  usb.o is built as
a normal object (no -DEXPORT_SYMTAB) and linked into usbcore.o which in
turn is linked into usbdrv.o.  What should happen is that usb.o is
compiled with -DEXPORT_SYMTAB, usb-debug.o and hub.o are compiled
without -DEXPORT_SYMTAB, all three are linked directly into usbdrv.o,
The object usbcore.o should not be built when USB is in the kernel, it
is a module only object.

The incorrect compile flags on usb.o mean that instead of exporting
usb_deregister in /proc/ksyms, it exports __VERSIONED_SYMBOL(usb_deregister),
the macro does not get expanded.  This causes all the unresolved
symbols.  At first glance the fix is easy, just put the missing lines
back into Makefile, that definitely fixes the export symbol problem.

  # Take multi-part drivers out of obj-y and put components in.
  obj-y           := $(filter-out $(list-multi), $(obj-y)) $(int-y)

However USB has another problem, which is probably why those lines were
removed in the first place.  Adding $int-y to the end of the obj-y list
means that usb.o, usb-debug.o and hub.o are linked into usbdrv.o as the
last objects.  This disturbs the order of the __init routines, usb_init
in usb.o is executed last when the above lines are in Makefile.

This is a generic kbuild problem, other directories have similar link
order problems, they get around it by explicitly ordering entries in
Makefile.  This kludge will not work for USB because you have a special
case, nobody else has this order problem with a multi part object.  If
usbcore was a single source instead of being built from three sources
then the explicit order kludge would work.

The kbuild group has been discussing adding a couple of extra variables
to kbuild to solve this link order problem, LINK_FIRST and LINK_LAST.
We were going to leave it until kernel 2.5 but it looks like we need
this functionality now.  LINK_FIRST says "iff these objects are part of
O_TARGET then link them into O_TARGET before all other objects".
LINK_LAST says "iff these objects are part of O_TARGET then link them
into O_TARGET after all other objects".  The rest of the objects will
then be linked into O_TARGET in an *arbitrary* order (probably sorted
alphabetically) after LINK_FIRST and before LINK_LAST.

The only justification for LINK_FIRST is to ensure that initialisation
routines run in the correct order.  The only justification for
LINK_LAST is to put older device drivers after newer ones when the
hardware is such that both drivers would recognise it but you want the
newer driver to probe first.  The kbuild group requires that all use of
LINK_FIRST and LINK_LAST be justified and documented, to avoid
undocumented gotchas coming back to bite us.

I will add LINK_FIRST and LINK_LAST to kbuild this weekend and
reinstate the missing lines in drivers/usb/Makefile.  What I need from
the USB group is a documented (i.e. *why* is this order required)
definition of what needs to be linked first into usbdrv.o, and somebody
we can query if there are problems in the future.  It will probably be
as simple as

  # usb.o contains __init usb_init which must be executed before all
  # other usb __init routines, the remaining usb __init routines can be
  # executed in any order.  Execution order of __init routines depends on
  # link order so usb.o must be linked first.  Joe Bloggs 28 Oct 2000.
  LINK_FIRST := usb.o

but you know better than I what the required order will be and why.
Are there any other link order problems in USB?  Replace Joe Bloggs
with somebody in the USB group who defined the list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
