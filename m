Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSKFAHr>; Tue, 5 Nov 2002 19:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSKFAHr>; Tue, 5 Nov 2002 19:07:47 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:23768 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265413AbSKFAHl>; Tue, 5 Nov 2002 19:07:41 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Nov 2002 16:14:09 -0800
Message-Id: <200211060014.QAA01196@baldur.yggdrasil.com>
To: ink@jurassic.park.msu.ru
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, jgarzik@pobox.com,
       jung-ik.lee@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
>On Tue, Nov 05, 2002 at 05:17:10AM -0800, Adam J. Richter wrote:
>> 	If pci_do_fixups determines that f->vendor and f->device do
>> not match the device in question, it will not call the corresponding
>> f->hook, so it is OK for that f->hook to point to the address of a
>> discarded __init routine that now contains garbage as long as the
>> ID's will not match any hot plugged device.
                 ^^^^^

>Unless f->device == PCI_ANY_ID.

	I said "match", not "equal."


>Plus you won't be able to discard the list itself.

	Your original claim was:

| You cannot mark individual quirk routines differently as long as they
| belong in the same quirk list. If the list is __devinitdata and some
| of routines in it are __init, you'll have an oops in the hotplug path.

	I think that that has been disproven and you are now arguing a
different claim: that while the list *can* safely be __devinitdata
with some __init routines, it might save some space to split the lists
so the list that hold the __init routines can also be __initdata.  I'd
just like to be clear so that we understand that your proposal no
longer has the urgency of being needed to solve Jung-Ik's crash.  That
is just a matter of changing one or two routines to __devinit and
pci{,bios}_fixups[] to __devinitdata (or to __pcidevinit{,data} if you
want to add that facility).

	Given that we're now examining the trade-offs of an optional
change, let's try to quantify it, starting with the benefits.

	sizeof(struct pci_fixup) == 12 or 16 bytes

	pci_fixups[] has 42 entries == 504 or 672 bytes

	i386 pcibios_fixups[] has 17 entries == 204 bytes

	If half of these entries would remain __init, so that would
save 354 bytes on i386.  Probably more than half can remain __init.
So, on x86, we would expect that ~250-350 bytes of table space could
remain in __initdata.  You will also gain a negligible speed
improvement in PCI hotplug insertion (not really a critical path, but
I mention it for completeness).

	Now let's look at the costs.  The system_running global
variable will already tell you if __init{,data} are no longer valid,
so there is no need to add a new variable, your proposed routine
would become:

static struct pci_fixup pci_fixups_initial[] __initdata = {
	...
};

static struct pci_fixup pci_fixups[] __pcidevinitdata = {
	...
};

void __pcidevinit pci_fixup_device(int pass, struct pci_dev *dev)
{
        pci_do_fixups(dev, pass, pcibios_fixups);
	if (!system_running)
		pci_do_fixups(dev, pass, pci_fixups_initial);
        pci_do_fixups(dev, pass, pci_fixups);
}

	(Change __pcidevinit{,data} to __devinit{data,} if that facility
is not added.)

	Your additional code will probably be ~30 bytes.  We do not
have to count the space for the terminating entries for the additional
tables, because those would be __init.  There may be some implicit
ordering beyond PCI_FIXUP_{HEADER,FINAL} for a routine or two that you
will need to duplicate between the __init and __devinit tables or
accomodate in some other way, so let's assume 20 bytes there.

	Subtracting the negatives from the positives, your proposal
would probably save ~300 bytes on x86, or ~200 bytes if you only split
pci_fixups[] (as above), more as additional __init fixups appear or if
struct pci_fixup grows.

	There is also the question of whether you want to have a third
set of tables for __pcidevinitdata routines.  Probably, if you did the
carbus_legacy call separately, you would only need __initdata and
__pcidevinitdata tables, so CONFIG_PCI_HOTPLUG users would keep
one table and regular CONFIG_PCI users would keep none, saving
them another 200-300 bytes (i.e., getting back to the current
utilization of no tables after ).

	I like the idea of your change.  For what it's worth,
I recommend the following.

	1. Immediately change pci{,bios}_fixups[] to __devinitdata
(or __pcidevinitdata if that facility is added, as it appears
that CardBus insertion calls pci_insert_device directly, skipping
pci_fixup_device).  This is a real bug.  pci_fixup_device is a
__devinit routine walking an __initdata table.

	2. If Jung-Ik gets around to posting his lspci or
/proc/bus/pci/devices, change his particular fixup routines to
__devinit.

	3. If you want to pursue splitting pci_fixups into
__initdata and __pcidevinitdata (or __devinitdata) as an
optimization, fine.  I'd recommend that you start with just
splitting pci_fixups[] so you do not have to coordinate with
a bunch of architectures initially.  It's simple and I think
200 bytes for CONFIG_PCI_HOTPLUG users is worth one "if" and
splitting one table.  It would not surprise me if Linus or,
better, whoever you go through to feed patches to Linus (I
guess Greg is volunteering for that) might want to wait
until after the "freeze", although I have no objection to
splitting pci_fixups[] now.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
