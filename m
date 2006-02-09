Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWBIXBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWBIXBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBIXBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:01:12 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:63423 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750783AbWBIXBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:01:11 -0500
Date: Fri, 10 Feb 2006 00:01:01 +0100
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, greg@kroah.com
Subject: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
 hackers.
Message-Id: <20060210000101.2f028801.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Booted 2.6.16-rc2 on my AMD x86_64 notebook and saw something new in the
log (different from 2.6.15):

ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative [20060127]

[Same error repeated 3 more times]

Searching the archives gives:

linux-2.6.16-rc1-mm2: new ACPI errors [2006-01-21]
http://marc.theaimsgroup.com/?l=linux-acpi&m=113786840630844&w=2

Wherein the reporter points to a previous display of a similar looking
message (but not exactly like it) in:

Re: 2.6.12.3 clock drifting twice too fast (amd64) [2005-08-17]
http://marc.theaimsgroup.com/?l=linux-kernel&m=112428492427357&w=2

He did not receive any reply/response to his report and that is a MAJOR
error as far as kernel programmer <--> kernel tester relationship goes.

If the error is harmless, then for the love of Embla just jot down a
quick reply, and hide the freakin message from user eyes. Now I have
to waste additional time asking the same thing: "Is this a real error?
Is it OK for my dsdt to lack these _PRx objects?".

My machine doesn't seem to behave differently from 2.6.15 so a gut
feeling says 'Disregard the message'. But will the message now linger on
just like that PCI error message that never got any love (yeah Greg KH,
I'm blaming you here):

Re: PCI error on x86_64 2.6.13 kernel [2005-11-19]
http://marc.theaimsgroup.com/?l=linux-kernel&m=113236418300012&w=2

In that message you ask me to do a git bisect, Greg, since I had seen
when the message first turned up. So I did, and identified the offender
as git-299de0343c7d18448a69c635378342e9214b14af After that... complete
silence, not even an ACK.

And the PCI error _still_ stares a user in the face, 3 months later in
2.6.16-rc2:

PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0

You've written a slew of documents about how users, testers and patch
submitters should behave towards the linux kernel hackers, Greg.
Perhaps it's time to point the pen in the other direction. Let me start
the job for you:

"1) Silence is _not_ golden."

Please, we the users breathe and bleed just like you do.

As for the PCI error, I made a patch against 2.6.15-rc6 backing out the
offending parts. The message went away and nothing bad happened to my
machine:

diff -Nur linux-2.6.15-rc6-clean/arch/i386/pci/i386.c linux-2.6.15-rc6-hacked/arch/i386/pci/i386.c
--- linux-2.6.15-rc6-clean/arch/i386/pci/i386.c	2005-12-21 19:10:20.000000000 +0100
+++ linux-2.6.15-rc6-hacked/arch/i386/pci/i386.c	2005-12-21 19:15:03.000000000 +0100
@@ -106,16 +106,11 @@
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->flags)
+				if (!r->start)
 					continue;
 				pr = pci_find_parent_resource(dev, r);
-				if (!r->start || !pr || request_resource(pr, r) < 0) {
+				if (!pr || request_resource(pr, r) < 0)
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
-					/* Something is wrong with the region.
-					   Invalidate the resource to prevent child
-					   resource allocations in this range. */
-					r->flags = 0;
-				}
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
@@ -188,8 +183,6 @@
 		}
 	}
 
-	pci_assign_unassigned_resources();
-
 	return 0;
 }
 
@@ -215,7 +208,7 @@
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+	for(idx=0; idx<6; idx++) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
diff -Nur linux-2.6.15-rc6-clean/drivers/pci/setup-bus.c linux-2.6.15-rc6-hacked/drivers/pci/setup-bus.c
--- linux-2.6.15-rc6-clean/drivers/pci/setup-bus.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-hacked/drivers/pci/setup-bus.c	2005-12-21 19:12:49.000000000 +0100
@@ -268,8 +268,6 @@
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
-		if (r == &ioport_resource || r == &iomem_resource)
-			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}



Mvh
Mats Johannesson
--
