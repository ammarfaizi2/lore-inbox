Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTAPFYR>; Thu, 16 Jan 2003 00:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTAPFYQ>; Thu, 16 Jan 2003 00:24:16 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:49031 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267026AbTAPFYO>; Thu, 16 Jan 2003 00:24:14 -0500
Date: Thu, 16 Jan 2003 00:33:05 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@penguin.co.intel.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [BUG][2.5]deadlock on cpci hot insert
In-Reply-To: <200301160111.h0G1B6ZE020954@penguin.co.intel.com>
Message-ID: <Pine.LNX.4.44.0301160014250.20085-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Rusty Lynch wrote:

> When I hot insert a cpci peripheral board into a ZT5084 chassis
> with a ZT5550 system master board, my ZT5550 locks up.  I managed
> to isolate the problem to a deadlock with list_lock

[snip deadlock scenario]

Good catch.  Up until now, I've not been building with either pre-empt
or SMP support here, which is why I've never been bitten by this.

> I'm not sure which is the correct way to fix this.  Maybe a
> cpci_unlocked_find_slot()?

I'm attaching my preferred fix, which I've only just compile tested
at the moment.  It removes cpci_find_slot completely through usage (the 
first I believe :) of the data member of pci_visit_dev's wrapped_dev
structure.  I'd thought about doing something along these lines in the 
past, so it isn't totally out of left field.  Removing cpci_find_slot
does change the exported board specific driver API, but it was a bit of
an afterthought on my part to EXPORT it anyways, since none of the board 
drivers I've built so far use it.

> hmm... pci_visit_dev is exported, so anybody could call it.

That's actually not a problem, since the used pci_visit structures and
the function pointers they contain are static to cpci_hotplug_pci.c.
The functions in cpci_hotplug_pci.c (cpci_*configure_slot) that do call 
pci_visit_dev, while not static, are not EXPORTed.

Scott

PS: Any word on whether my ZT5550 driver patch from last Friday fixes
    your ZT5084 chassis issues?


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.58/drivers/hotplug/cpci_hotplug.h linux-2.5.58-dev/drivers/hotplug/cpci_hotplug.h
--- linux-2.5.58/drivers/hotplug/cpci_hotplug.h	Thu Jan 16 00:06:58 2003
+++ linux-2.5.58-dev/drivers/hotplug/cpci_hotplug.h	Wed Jan 15 23:43:28 2003
@@ -75,7 +75,6 @@
 extern int cpci_hp_unregister_controller(struct cpci_hp_controller *controller);
 extern int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
 extern int cpci_hp_unregister_bus(struct pci_bus *bus);
-extern struct slot *cpci_find_slot(struct pci_bus *bus, unsigned int devfn);
 extern int cpci_hp_start(void);
 extern int cpci_hp_stop(void);
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.58/drivers/hotplug/cpci_hotplug_core.c linux-2.5.58-dev/drivers/hotplug/cpci_hotplug_core.c
--- linux-2.5.58/drivers/hotplug/cpci_hotplug_core.c	Thu Jan 16 00:06:58 2003
+++ linux-2.5.58-dev/drivers/hotplug/cpci_hotplug_core.c	Thu Jan 16 00:00:17 2003
@@ -417,34 +417,6 @@
 	return 0;
 }
 
-struct slot *
-cpci_find_slot(struct pci_bus *bus, unsigned int devfn)
-{
-	struct slot *slot;
-	struct slot *found;
-	struct list_head *tmp;
-
-	if(!bus) {
-		return NULL;
-	}
-
-	spin_lock(&list_lock);
-	if(!slots) {
-		spin_unlock(&list_lock);
-		return NULL;
-	}
-	found = NULL;
-	list_for_each(tmp, &slot_list) {
-		slot = list_entry(tmp, struct slot, slot_list);
-		if(slot->bus == bus && slot->devfn == devfn) {
-			found = slot;
-			break;
-		}
-	}
-	spin_unlock(&list_lock);
-	return found;
-}
-
 /* This is the interrupt mode interrupt handler */
 void
 cpci_hp_intr(int irq, void *data, struct pt_regs *regs)
@@ -915,6 +887,5 @@
 EXPORT_SYMBOL_GPL(cpci_hp_unregister_controller);
 EXPORT_SYMBOL_GPL(cpci_hp_register_bus);
 EXPORT_SYMBOL_GPL(cpci_hp_unregister_bus);
-EXPORT_SYMBOL_GPL(cpci_find_slot);
 EXPORT_SYMBOL_GPL(cpci_hp_start);
 EXPORT_SYMBOL_GPL(cpci_hp_stop);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5.58/drivers/hotplug/cpci_hotplug_pci.c linux-2.5.58-dev/drivers/hotplug/cpci_hotplug_pci.c
--- linux-2.5.58/drivers/hotplug/cpci_hotplug_pci.c	Thu Jan 16 00:06:58 2003
+++ linux-2.5.58-dev/drivers/hotplug/cpci_hotplug_pci.c	Wed Jan 15 23:42:34 2003
@@ -446,7 +446,7 @@
 }
 
 static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
-			struct pci_bus_wrapped *wrapped_bus)
+				   struct pci_bus_wrapped *wrapped_bus)
 {
 	int rc;
 	struct pci_dev *dev = wrapped_dev->dev;
@@ -459,8 +459,8 @@
 	 * We need to fix up the hotplug representation with the Linux
 	 * representation.
 	 */
-	slot = cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot = (struct slot*) wrapped_dev->data;
 		slot->dev = dev;
 	}
 
@@ -482,7 +482,7 @@
 }
 
 static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrapped_dev,
-				 struct pci_bus_wrapped *wrapped_bus)
+					    struct pci_bus_wrapped *wrapped_bus)
 {
 	struct pci_dev *dev = wrapped_dev->dev;
 
@@ -525,8 +525,8 @@
 	/*
 	 * Now remove the hotplug representation.
 	 */
-	slot = cpci_find_slot(dev->bus, dev->devfn);
-	if(slot) {
+	if(wrapped_dev->data) {
+		slot = (struct slot*) wrapped_dev->data;
 		slot->dev = NULL;
 	} else {
 		dbg("No hotplug representation for %02x:%02x.%x",
@@ -634,6 +634,10 @@
 				continue;
 			wrapped_dev.dev = dev;
 			wrapped_bus.bus = slot->dev->bus;
+			if(i)
+				wrapped_dev.data = NULL;
+			else
+				wrapped_dev.data = (void*) slot;
 			rc = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
 		}
 	}
@@ -666,16 +670,21 @@
 		if(dev) {
 			wrapped_dev.dev = dev;
 			wrapped_bus.bus = dev->bus;
+			if(i)
+				wrapped_dev.data = NULL;
+			else
+				wrapped_dev.data = (void*) slot;
 			dbg("%s - unconfigure phase 1", __FUNCTION__);
 			rc = pci_visit_dev(&unconfigure_functions_phase1,
-					   &wrapped_dev, &wrapped_bus);
-			if(rc) {
+					   &wrapped_dev,
+					   &wrapped_bus);
+			if(rc)
 				break;
-			}
 
 			dbg("%s - unconfigure phase 2", __FUNCTION__);
 			rc = pci_visit_dev(&unconfigure_functions_phase2,
-					   &wrapped_dev, &wrapped_bus);
+					   &wrapped_dev,
+					   &wrapped_bus);
 			if(rc)
 				break;
 		}


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

