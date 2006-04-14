Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWDNOBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDNOBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDNOBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:01:44 -0400
Received: from apunkt.ffii.org ([217.72.130.54]:46495 "EHLO apunkt.ffii.org")
	by vger.kernel.org with ESMTP id S964786AbWDNOBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:01:44 -0400
Date: Fri, 14 Apr 2006 16:01:29 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] Cardbus cards hidden, fixup parent subordinate# carefully
In-Reply-To: <20060218014102.0647c0ce.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604132200100.18866@jbgna.fhfr.qr>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
 <1136555288.30498.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr> <20060218014102.0647c0ce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, Andrew Morton wrote:
> Bernhard Kaindl <bk@suse.de> wrote:
> >
> > "In some cases, especially on modern laptops with a lot of PCI and cardbus
> >  bridges, we're unable to assign correct secondary/subordinate bus numbers
> >  to all cardbus bridges due to BIOS limitations unless we are using
> >  "pci=assign-busses" boot option." -- Ivan Kokshaysky (from a patch comment)
[...]
> > [ snip patch which uses a DMI table to auto-set "pci=assign-busses" ]
> 
> I guess if this is the only way in which we can do this, and nobody has any
> better solutions then sure, it'll get people's machines going.  We'll be
> forever patching that table though.
> 
> But _does_ anyone have any better solutions?

Now, yes: The patch is in the git-pcmcia-2.6 tree for testing it in -mm
and I include it here also - should peope wish to add it to their trees too.

Comments welcome!

Thanks,
Bernhard

------------------------------------------------------------------------

There are currently two ways to fix the problem of hidden cardbus cards:
One is to use

setpci -s 0:a.0 SUBORDINATE_BUS=0x0A (or similar)

On Presario R3000/R4000 series and HP zv5000 series, this is the standard.

Using pci=assign-busses is the other, but as ACPI may contain references
to PCI bus numbers and as files like xorg.conf file can also contain
references to PCI devices, it can break installations:

https://bugzilla.novell.com/show_bug.cgi?id=146438

It would also be a big change to enable it by default on many machines.

The other possiblity is to fixup the parent subordinate numbers after
we completed the initial PCI scan, so that we can do checks to prevent
overlapping bus numbers when trying to increase the subordinate number.

I created a kernel module for testing code which does that and it
was tested on Presario R3000 laptops and a Samsung X20 notebook.

I then trimmed it down to call it from the CardBus probe function,
before the socket is registered and the bus(es) below it are scanned.

>From that location, we can directly check the parent of the CardBus
bridge and that simplifies the code dramatically, so I could merge
it into one small function.

It was tested on my X20 and (it seems) a R3000 series notebook:
https://bugzilla.novell.com/show_bug.cgi?id=146438#c31

Conclusion:
-----------

We apparently have a better solution, and since the full PCI renumbering
could cause problems which I mentioned above, I think we should revert my
previous patch which was committed to 2.6.17-rc1:

commit 8c4b2cf9af9b4ecc29d4f0ec4ecc8e94dc4432d7
Author: Bernhard Kaindl <bk@suse.de>
Date:   Sat Feb 18 01:36:55 2006 -0800

Regarding the waring message patched in that commit: It gives a few
(partly) false warnings, because it's not specific enough in its tests.
So that part should be reverted too and I'll propose a fix for this
warning check, preferably depending on this patch (we could skip
cardbus there then), in separate mail.

Short patch comment:

Fixup the subordinate number of the parent of CardBus bridges carefully
before the the slots are scanned by PCI, to make the CardBus cards and
child busses which may otherwise be hidden from PCI scans seen.

Affected systems (from an internet search), supposed to be fixed:
* ASUS Z71V and L3s
* Samsung X20 (fixed in latest BIOS, but older BIOSes are affected)
* Compaq R3140us and all Compaq R3000 series (AMD64-based Laptops),
  also Compaq R4000 series
* HP zv5000z (AMD64 3700+, known that fixup_parent_subordinate_busnr fixes it)
* HP zv5200z
* HP SE2000L amd64 Turino laptop
* IBM ThinkPad 240
* An IBM ThinkPad (1.8 GHz Pentium M) debugged by Pavel Machek
  gives the message which detects the problem.
* MSI S260 / Medion SIM 2100 MD 95600

Tested-by: Andreas Schneider   <mail@cynapses.org>
Signed-off-by: Bernhard Kaindl <bk@suse.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

--- linux-2.6.16/drivers/pcmcia/yenta_socket.c
+++ linux-2.6.16/drivers/pcmcia/yenta_socket.c	2006/04/08 11:51:20
@@ -998,6 +998,78 @@
 	config_writew(socket, CB_BRIDGE_CONTROL, bridge);
 }

+/**
+ * yenta_fixup_parent_subordinate - Fix subordinate bus# of the parent bridge
+ * @cardbus_bridge: The PCI bus which the CardBus bridge bridges to
+ *
+ * Checks if devices on the bus which the CardBus bridge bridges to would be
+ * invisible during PCI scans because of a misconfigured subordinate number
+ * of the parent brige - some BIOSes seem to be too lazy to set it right.
+ * Does the fixup carefully by checking how far it can go without conflicts.
+ * See http://bugzilla.kernel.org/show_bug.cgi?id=2944 for more information.
+ */
+static void yenta_fixup_parent_bridge(struct pci_bus *cardbus_bridge)
+{
+	struct list_head *tmp;
+	/* Our starting point is the max PCI bus number */
+	unsigned char upper_limit = 0xff;
+ 	/*
+	 * We only check and fix the parent bridge: All systems which need
+	 * this fixup that have been reviewed are laptops and the only bridge
+	 * which needed fixing was the parent bridge of the CardBus bridge:
+	 */
+	struct pci_bus *bridge_to_fix = cardbus_bridge->parent;
+
+	/* Check bus numbers are already set up correctly: */
+	if (bridge_to_fix->subordinate >= cardbus_bridge->subordinate)
+		return; /* The subordinate number is ok, nothing to do */
+
+	if (!bridge_to_fix->parent)
+		return; /* Root bridges are ok */
+
+	/* stay within the limits of the bus range of the parent: */
+	upper_limit = bridge_to_fix->parent->subordinate;
+
+	/* check the bus ranges of all silbling bridges to prevent overlap */
+	list_for_each(tmp, &bridge_to_fix->parent->children) {
+		struct pci_bus * silbling = pci_bus_b(tmp);
+		/*
+		 * If the silbling has a higher secondary bus number
+		 * and it's secondary is equal or smaller than our
+		 * current upper limit, set the new upper limit to
+		 * the bus number below the silbling's range:
+		 */
+		if (silbling->secondary > bridge_to_fix->subordinate
+		    && silbling->secondary <= upper_limit)
+			upper_limit = silbling->secondary - 1;
+	}
+
+	/* Show that the wanted subordinate number is not possible: */
+	if (cardbus_bridge->subordinate > upper_limit)
+		printk(KERN_WARNING "Yenta: Upper limit for fixing this "
+			"bridge's parent bridge: #%02x\n", upper_limit);
+
+	/* If we have room to increase the bridge's subordinate number, */
+	if (bridge_to_fix->subordinate < upper_limit) {
+
+		/* use the highest number of the hidden bus, within limits */
+		unsigned char subordinate_to_assign =
+			min(cardbus_bridge->subordinate, upper_limit);
+
+		printk(KERN_INFO "Yenta: Raising subordinate bus# of parent "
+			"bus (#%02x) from #%02x to #%02x\n",
+			bridge_to_fix->number,
+			bridge_to_fix->subordinate, subordinate_to_assign);
+
+		/* Save the new subordinate in the bus struct of the bridge */
+		bridge_to_fix->subordinate = subordinate_to_assign;
+
+		/* and update the PCI config space with the new subordinate */
+		pci_write_config_byte(bridge_to_fix->self,
+			PCI_SUBORDINATE_BUS, bridge_to_fix->subordinate);
+	}
+}
+
 /*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
@@ -1113,6 +1184,8 @@
 	yenta_get_socket_capabilities(socket, isa_interrupts);
 	printk(KERN_INFO "Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));

+	yenta_fixup_parent_bridge(dev->subordinate);
+
 	/* Register it with the pcmcia layer.. */
 	ret = pcmcia_register_socket(&socket->socket);
 	if (ret == 0) {
