Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273058AbRIWVVz>; Sun, 23 Sep 2001 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRIWVVp>; Sun, 23 Sep 2001 17:21:45 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:38880 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S273058AbRIWVVi>; Sun, 23 Sep 2001 17:21:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 23 Sep 2001 14:21:59 -0700
Message-Id: <200109232121.OAA03841@adam.yggdrasil.com>
To: mm@ns.caldera.de
Subject: Re: PATCH: linux-2.4.10-pre14/drivers/sound/maestro.c ignored pci_module_init results
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Adam Richter
>  = Marcus Meissner

>> 	The initialization routine in
>> linux-2.4.10-pre14/drivers/sound/maestro.c ignores the return value
>> from pci_module_init, and allows module initialization to succeed
>> even if pci_module_init failed.  pci_module_init fails and unloads
>> the driver if the caller is a module and there is no matching hardware.
>> Because maestro.c ignored this failure, loading maestro.o on a system
>> where the corresponding alsa driver was already loaded or on a system
>> without matchin hardware would result in a kernel null pointer dereference
>> in pci_unregister_driver when the module is unloaded or when one
>> attempts to reboot the system (i.e., when the module attempt to
>> unregister a PCI driver that is not registered).

>Why and where does it Oops?

	On a machine that has no maestro hardware or that already has
the alsa drivers bound to the maestro PCI hardware, either of the
following will cause a null pointer dereference when
pci_unregister_driver tries to unregister a driver that is not registered:

		modprobe maestro
		rmmod maestro

		(as cleanup_maestro incorrectly calls pci_unregister_driver
		on a PCI driver that is not loaded.)

	...or...

		modprobe meastro
		reboot

		(as maestro_notifier incorrectly calls pci_unregister_driver
		on a PCI driver that is not loaded.)

	I experimentally verified both of these on a machine that already
had the maestro ALSA drivers loaded.  I assume the null pointer dereference
would be from the list_del(&drv->node) in pci_unregister_driver, since
list_del calls __list_del, which assumes that drv->node->{prev,next} are
not NULL, but they would have been set to NULL by the first
pci_remove_module, which pci_module_init called when the driver failed
to bind to anything, but which the maestro driver incorrectly ignored.

>The code for pci_unregister_driver in
>drivers/pci/pci.c looks correct and should not Oops.
>
>The reboot notifier might be problematic, but I have not checked it.

	There is nothing wrong with pci_unregister_driver.  The bug
is where init_maestro in maestro.c ignored the results of
pci_module_init, which is what my patch fixes.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
