Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVHWXry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVHWXry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVHWXry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:47:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9675 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932335AbVHWXrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:47:52 -0400
Date: Tue, 23 Aug 2005 18:47:47 -0500
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
       moilanen@austin.ibm.com, akpm@osdl.org, greg@kroah.com
Subject: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050823234747.GI18113@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Content-Disposition: inline
In-Reply-To: <20050823232143.003048000@bilge>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Various PCI bus errors can be signaled by newer PCI controllers.  The
core error recovery routines are architecture dependent.  This patch adds
a recovery infrastructure for the  PPC64 pSeries systems.

Signed-off-by: Linas Vepstas <linas@linas.org>

--
 arch/ppc64/kernel/Makefile     |    2=20
 arch/ppc64/kernel/eeh.c        |  543 +++++++++++++++++++++++++++++-------=
-----
 arch/ppc64/kernel/eeh_driver.c |  361 +++++++++++++++++++++++++++
 arch/ppc64/kernel/eeh_event.c  |  116 ++++++++
 arch/ppc64/kernel/eeh_event.h  |   52 +++
 arch/ppc64/kernel/rtas_pci.c   |    5=20
 include/asm-ppc64/eeh.h        |  105 +++++--
 include/asm-ppc64/prom.h       |   10=20
 include/asm-ppc64/rtas.h       |    2=20
 9 files changed, 1001 insertions(+), 195 deletions(-)

Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/kernel/eeh.c	2005-08-19 12:52:31.=
000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh.c	2005-08-23 16:53:05.00000=
0000 -0500
@@ -1,32 +1,33 @@
 /*
+ *
  * eeh.c
  * Copyright (C) 2001 Dave Engebretsen & Todd Inglett IBM Corporation
- *=20
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *=20
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *=20
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
=20
-#include <linux/bootmem.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/list.h>
-#include <linux/mm.h>
-#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <asm/atomic.h>
 #include <asm/eeh.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
@@ -34,6 +35,7 @@
 #include <asm/atomic.h>
 #include <asm/systemcfg.h>
 #include "pci.h"
+#include "eeh_event.h"
=20
 #undef DEBUG
=20
@@ -49,8 +51,8 @@
  *  were "empty": all reads return 0xff's and all writes are silently
  *  ignored.  EEH slot isolation events can be triggered by parity
  *  errors on the address or data busses (e.g. during posted writes),
- *  which in turn might be caused by dust, vibration, humidity,
- *  radioactivity or plain-old failed hardware.
+ *  which in turn might be caused by low voltage on the bus, dust,
+ *  vibration, humidity, radioactivity or plain-old failed hardware.
  *
  *  Note, however, that one of the leading causes of EEH slot
  *  freeze events are buggy device drivers, buggy device microcode,
@@ -75,22 +77,13 @@
 #define BUID_HI(buid) ((buid) >> 32)
 #define BUID_LO(buid) ((buid) & 0xffffffff)
=20
-/* EEH event workqueue setup. */
-static DEFINE_SPINLOCK(eeh_eventlist_lock);
-LIST_HEAD(eeh_eventlist);
-static void eeh_event_handler(void *);
-DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
-
-static struct notifier_block *eeh_notifier_chain;
-
 /*
  * If a device driver keeps reading an MMIO register in an interrupt
  * handler after a slot isolation event has occurred, we assume it
  * is broken and panic.  This sets the threshold for how many read
  * attempts we allow before panicking.
  */
-#define EEH_MAX_FAILS	1000
-static atomic_t eeh_fail_count;
+#define EEH_MAX_FAILS	100000
=20
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -107,6 +100,10 @@
 static int eeh_error_buf_size;
=20
 /* System monitoring statistics */
+static DEFINE_PER_CPU(unsigned long, no_device);
+static DEFINE_PER_CPU(unsigned long, no_dn);
+static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
+static DEFINE_PER_CPU(unsigned long, ignored_check);
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
@@ -224,9 +221,9 @@
 	while (*p) {
 		parent =3D *p;
 		piar =3D rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (alo < piar->addr_lo) {
+		if (ahi < piar->addr_lo) {
 			p =3D &parent->rb_left;
-		} else if (ahi > piar->addr_hi) {
+		} else if (alo > piar->addr_hi) {
 			p =3D &parent->rb_right;
 		} else {
 			if (dev !=3D piar->pcidev ||
@@ -245,6 +242,11 @@
 	piar->pcidev =3D dev;
 	piar->flags =3D flags;
=20
+#ifdef DEBUG
+	printk (KERN_DEBUG "PIAR: insert range=3D[%lx:%lx] dev=3D%s\n",
+	               alo, ahi, pci_name (dev));
+#endif
+
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
=20
@@ -268,8 +270,8 @@
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
 #ifdef DEBUG
-		printk(KERN_INFO "PCI: skip building address cache for=3D%s\n",
-		       pci_name(dev));
+		printk(KERN_INFO "PCI: skip building address cache for=3D%s %s\n",
+		       pci_name(dev), dn->type);
 #endif
 		return;
 	}
@@ -368,8 +370,12 @@
  */
 void __init pci_addr_cache_build(void)
 {
+	struct device_node *dn;
 	struct pci_dev *dev =3D NULL;
=20
+	if (!eeh_subsystem_enabled)
+		return;
+
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
=20
 	while ((dev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) !=3D NULL) {
@@ -378,6 +384,17 @@
 			continue;
 		}
 		pci_addr_cache_insert_device(dev);
+
+		/* Save the BAR's; firmware doesn't restore these after EEH reset */
+		dn =3D pci_device_to_OF_node(dev);
+		if (dn) {
+			int i;
+			for (i =3D 0; i < 16; i++)
+				pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+			if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE)
+				dn->eeh_is_bridge =3D 1;
+		}
 	}
=20
 #ifdef DEBUG
@@ -389,24 +406,32 @@
 /* --------------------------------------------------------------- */
 /* Above lies the PCI Address Cache. Below lies the EEH event infrastructu=
re */
=20
-/**
- * eeh_register_notifier - Register to find out about EEH events.
- * @nb: notifier block to callback on events
- */
-int eeh_register_notifier(struct notifier_block *nb)
+void eeh_slot_error_detail (struct device_node *dn, int severity)
 {
-	return notifier_chain_register(&eeh_notifier_chain, nb);
-}
+	unsigned long flags;
+	int rc;
=20
-/**
- * eeh_unregister_notifier - Unregister to an EEH event notifier.
- * @nb: notifier block to callback on events
- */
-int eeh_unregister_notifier(struct notifier_block *nb)
-{
-	return notifier_chain_unregister(&eeh_notifier_chain, nb);
+	if (!dn) return;
+
+	/* Log the error with the rtas logger */
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	rc =3D rtas_call(ibm_slot_error_detail,
+	               8, 1, NULL, dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid), NULL, 0,
+	               virt_to_phys(slot_errbuf),
+	               eeh_error_buf_size,
+	               severity);
+
+	if (rc =3D=3D 0)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 }
=20
+EXPORT_SYMBOL(eeh_slot_error_detail);
+
 /**
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
@@ -421,6 +446,7 @@
 		outputs =3D 4;
 	} else {
 		token =3D ibm_read_slot_reset_state;
+		rets[2] =3D 0; /* fake PE Unavailable info */
 		outputs =3D 3;
 	}
=20
@@ -429,75 +455,8 @@
 }
=20
 /**
- * eeh_panic - call panic() for an eeh event that cannot be handled.
- * The philosophy of this routine is that it is better to panic and
- * halt the OS than it is to risk possible data corruption by
- * oblivious device drivers that don't know better.
- *
- * @dev pci device that had an eeh event
- * @reset_state current reset state of the device slot
- */
-static void eeh_panic(struct pci_dev *dev, int reset_state)
-{
-	/*
-	 * XXX We should create a separate sysctl for this.
-	 *
-	 * Since the panic_on_oops sysctl is used to halt the system
-	 * in light of potential corruption, we can use it here.
-	 */
-	if (panic_on_oops)
-		panic("EEH: MMIO failure (%d) on device:%s\n", reset_state,
-		      pci_name(dev));
-	else {
-		__get_cpu_var(ignored_failures)++;
-		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s\n",
-		       reset_state, pci_name(dev));
-	}
-}
-
-/**
- * eeh_event_handler - dispatch EEH events.  The detection of a frozen
- * slot can occur inside an interrupt, where it can be hard to do
- * anything about it.  The goal of this routine is to pull these
- * detection events out of the context of the interrupt handler, and
- * re-dispatch them for processing at a later time in a normal context.
- *
- * @dummy - unused
- */
-static void eeh_event_handler(void *dummy)
-{
-	unsigned long flags;
-	struct eeh_event	*event;
-
-	while (1) {
-		spin_lock_irqsave(&eeh_eventlist_lock, flags);
-		event =3D NULL;
-		if (!list_empty(&eeh_eventlist)) {
-			event =3D list_entry(eeh_eventlist.next, struct eeh_event, list);
-			list_del(&event->list);
-		}
-		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-		if (event =3D=3D NULL)
-			break;
-
-		printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
-		       "%s\n", event->reset_state,
-		       pci_name(event->dev));
-
-		atomic_set(&eeh_fail_count, 0);
-		notifier_call_chain (&eeh_notifier_chain,
-				     EEH_NOTIFY_FREEZE, event);
-
-		__get_cpu_var(slot_resets)++;
-
-		pci_dev_put(event->dev);
-		kfree(event);
-	}
-}
-
-/**
- * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xE....
+ * eeh_token_to_phys - convert I/O address to phys address
+ * @token i/o token, should be address in the form 0xA....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -512,6 +471,39 @@
 	return pa | (token & (PAGE_SIZE-1));
 }
=20
+/** Mark all devices that are peers of this device as failed.
+ *  Mark the device driver too, so that it can see the failure
+ *  immediately; this is critical, since some drivers poll
+ *  status registers in interrupts ... If a driver is polling,
+ *  and the slot is frozen, then the driver can deadlock in
+ *  an interrupt context, which is bad.
+ */
+static inline void eeh_mark_slot (struct device_node *dn)
+{
+	while (dn) {
+		dn->eeh_mode |=3D EEH_MODE_ISOLATED;
+
+		/* Mark the pci device driver too */
+		struct pci_dev *dev =3D dn->pcidev;
+		if (dev && dev->driver) {
+			dev->error_state =3D pci_channel_io_frozen;
+		}
+		if (dn->child)
+			eeh_mark_slot (dn->child);
+		dn =3D dn->sibling;
+	}
+}
+
+static inline void eeh_clear_slot (struct device_node *dn)
+{
+	while (dn) {
+		dn->eeh_mode &=3D ~(EEH_MODE_RECOVERING|EEH_MODE_ISOLATED);
+		if (dn->child)
+			eeh_clear_slot (dn->child);
+		dn =3D dn->sibling;
+	}
+}
+
 /**
  * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
  * @dn device node
@@ -527,29 +519,37 @@
  *
  * It is safe to call this routine in an interrupt context.
  */
+extern void disable_irq_nosync(unsigned int);
+
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	int rets[3];
-	unsigned long flags;
-	int rc, reset_state;
-	struct eeh_event  *event;
+	enum pci_channel_state state;
=20
 	__get_cpu_var(total_mmio_ffs)++;
=20
 	if (!eeh_subsystem_enabled)
 		return 0;
=20
-	if (!dn)
+	if (!dn) {
+		__get_cpu_var(no_dn)++;
 		return 0;
+	}
=20
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(dn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    dn->eeh_mode & EEH_MODE_NOCHECK) {
+		__get_cpu_var(ignored_check)++;
+#ifdef DEBUG
+		printk ("EEH:ignored check for %s %s\n",
+		           pci_name (dev), dn->full_name);
+#endif
 		return 0;
 	}
=20
 	if (!dn->eeh_config_addr) {
+		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
=20
@@ -558,12 +558,18 @@
 	 * slot, we know it's bad already, we don't need to check...
 	 */
 	if (dn->eeh_mode & EEH_MODE_ISOLATED) {
-		atomic_inc(&eeh_fail_count);
-		if (atomic_read(&eeh_fail_count) >=3D EEH_MAX_FAILS) {
+		dn->eeh_check_count ++;
+		if (dn->eeh_check_count >=3D EEH_MAX_FAILS) {
+			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
+			        dn->eeh_check_count);
+			dump_stack();
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(dn, rets) !=3D 0)
 				rets[0] =3D -1;	/* reset state unknown */
-			eeh_panic(dev, rets[0]);
+
+			/* If we are here, then we hit an infinite loop. Stop. */
+			panic("EEH: MMIO halt (%d) on device:%s\n", rets[0],
+		      pci_name(dev));
 		}
 		return 0;
 	}
@@ -576,53 +582,36 @@
 	 * In any case they must share a common PHB.
 	 */
 	ret =3D read_slot_reset_state(dn, rets);
-	if (!(ret =3D=3D 0 && rets[1] =3D=3D 1 && (rets[0] =3D=3D 2 || rets[0] =
=3D=3D 4))) {
+	if (!(ret =3D=3D 0 && ((rets[1] =3D=3D 1 && (rets[0] =3D=3D 2 || rets[0] =
>=3D 4))
+	                   || (rets[0] =3D=3D 5)))) {
 		__get_cpu_var(false_positives)++;
 		return 0;
 	}
=20
-	/* prevent repeated reports of this failure */
-	dn->eeh_mode |=3D EEH_MODE_ISOLATED;
-
-	reset_state =3D rets[0];
-
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
-
-	rc =3D rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, dn->eeh_config_addr,
-	               BUID_HI(dn->phb->buid),
-	               BUID_LO(dn->phb->buid), NULL, 0,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               1 /* Temporary Error */);
+	/* Note that empty slots will fail; empty slots don't have children... */
+	if ((rets[0] =3D=3D 5) && (dn->child =3D=3D NULL)) {
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
=20
-	if (rc =3D=3D 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+	/* Avoid repeated reports of this failure, including problems
+	 * with other functions on this device, and functions under
+	 * bridges. */
+	eeh_mark_slot (dn->parent->child);
+	__get_cpu_var(slot_resets)++;
+
+	state =3D pci_channel_io_normal;
+	if ((rets[0] =3D=3D 2) || (rets[0] =3D=3D 4))
+		state =3D pci_channel_io_frozen;
+	if (rets[0] =3D=3D 5)
+		state =3D pci_channel_io_perm_failure;
=20
-	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
-	       rets[0], dn->name, dn->full_name);
-	event =3D kmalloc(sizeof(*event), GFP_ATOMIC);
-	if (event =3D=3D NULL) {
-		eeh_panic(dev, reset_state);
-		return 1;
- 	}
-
-	event->dev =3D dev;
-	event->dn =3D dn;
-	event->reset_state =3D reset_state;
-
-	/* We may or may not be called in an interrupt context */
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	list_add(&event->list, &eeh_eventlist);
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+	eeh_send_failure_event (dn, dev, state, rets[2]);
=20
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	dump_stack();
-	schedule_work(&eeh_event_wq);
+	if (rets[0] !=3D 5) dump_stack();
=20
 	return 0;
 }
@@ -634,7 +623,6 @@
  * @token i/o token, should be address in the form 0xA....
  * @val value, should be all 1's (XXX why do we need this arg??)
  *
- * Check for an eeh failure at the given token address.
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
  * find out if this is due to an EEH slot freeze event.  This routine
@@ -651,8 +639,10 @@
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr =3D eeh_token_to_phys((unsigned long __force) token);
 	dev =3D pci_get_device_by_addr(addr);
-	if (!dev)
+	if (!dev) {
+		__get_cpu_var(no_device)++;
 		return val;
+	}
=20
 	dn =3D pci_device_to_OF_node(dev);
 	eeh_dn_check_failure (dn, dev);
@@ -663,6 +653,209 @@
=20
 EXPORT_SYMBOL(eeh_check_failure);
=20
+/* ------------------------------------------------------------- */
+/* The code below deals with error recovery */
+
+/** eeh_pci_slot_reset -- raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ */
+void
+eeh_pci_slot_reset(struct pci_dev *dev, int state)
+{
+	struct device_node *dn =3D pci_device_to_OF_node(dev);
+	rtas_pci_slot_reset (dn, state);
+}
+
+/** Return negative value if a permanent error, else return
+ * a number of milliseconds to wait until the PCI slot is
+ * ready to be used.
+ */
+static int
+eeh_slot_availability(struct device_node *dn)
+{
+	int rc;
+	int rets[3];
+
+	rc =3D read_slot_reset_state(dn, rets);
+
+	if (rc) return rc;
+
+	if (rets[1] =3D=3D 0) return -1;  /* EEH is not supported */
+	if (rets[0] =3D=3D 0)  return 0;  /* Oll Korrect */
+	if (rets[0] =3D=3D 5) {
+		if (rets[2] =3D=3D 0) return -1; /* permanently unavailable */
+		return rets[2]; /* number of millisecs to wait */
+	}
+	return -1;
+}
+
+int
+eeh_pci_slot_availability(struct pci_dev *dev)
+{
+	struct device_node *dn =3D pci_device_to_OF_node(dev);
+	if (!dn) return -1;
+
+	BUG_ON (dn->phb=3D=3DNULL);
+	if (dn->phb=3D=3DNULL) {
+		printk (KERN_ERR "EEH, checking on slot with no phb dn=3D%s dev=3D%s\n",
+		       dn->full_name, pci_name(dev));
+		return -1;
+	}
+	return eeh_slot_availability (dn);
+}
+
+void
+rtas_pci_slot_reset(struct device_node *dn, int state)
+{
+	int rc;
+
+	if (!dn)
+		return;
+	if (!dn->phb) {
+		printk (KERN_WARNING "EEH: in slot reset, device node %s has no phb\n", =
                   dn->full_name);
+		return;
+	}
+
+	dn->eeh_mode |=3D EEH_MODE_RECOVERING;
+	rc =3D rtas_call(ibm_set_slot_reset,4,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid),
+	               state);
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to reset the failed slot, (%d) #RST=3D=
%d\n", rc, state);
+		return;
+	}
+
+	if (state =3D=3D 0)
+		eeh_clear_slot (dn->parent->child);
+}
+
+/** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
+ *  dn -- device node to be reset.
+ */
+
+void
+rtas_set_slot_reset(struct device_node *dn)
+{
+	int i, rc;
+
+	rtas_pci_slot_reset (dn, 1);
+
+	/* The PCI bus requires that the reset be held high for at least
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
+
+#define PCI_BUS_RST_HOLD_TIME_MSEC 250
+	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	rtas_pci_slot_reset (dn, 0);
+
+	/* After a PCI slot has been reset, the PCI Express spec requires
+	 * a 1.5 second idle time for the bus to stabilize, before starting
+	 * up traffic. */
+#define PCI_BUS_SETTLE_TIME_MSEC 1800
+	msleep (PCI_BUS_SETTLE_TIME_MSEC);
+
+	/* Now double check with the firmware to make sure the device is
+	 * ready to be used; if not, wait for recovery. */
+	for (i=3D0; i<10; i++) {
+		rc =3D eeh_slot_availability (dn);
+		if (rc <=3D 0) break;
+
+		msleep (rc+100);
+	}
+}
+
+EXPORT_SYMBOL(rtas_set_slot_reset);
+
+void
+rtas_configure_bridge(struct device_node *dn)
+{
+	int token =3D rtas_token ("ibm,configure-bridge");
+	int rc;
+
+	if (token =3D=3D RTAS_UNKNOWN_SERVICE)
+		return;
+	rc =3D rtas_call(token,3,1, NULL,
+	               dn->eeh_config_addr,
+	               BUID_HI(dn->phb->buid),
+	               BUID_LO(dn->phb->buid));
+	if (rc) {
+		printk (KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s=
\n",
+		        rc, dn->full_name);
+	}
+}
+
+EXPORT_SYMBOL(rtas_configure_bridge);
+
+/* ------------------------------------------------------- */
+/** Save and restore of PCI BARs
+ *
+ * Although firmware will set up BARs during boot, it doesn't
+ * set up device BAR's after a device reset, although it will,
+ * if requested, set up bridge configuration. Thus, we need to
+ * configure the PCI devices ourselves.  Config-space setup is
+ * stored in the PCI structures which are normally deleted during
+ * device removal.  Thus, the "save" routine references the
+ * structures so that they aren't deleted.
+ */
+
+/**
+ * __restore_bars - Restore the Base Address Registers
+ * Loads the PCI configuration space base address registers,
+ * the expansion ROM base address, the latency timer, and etc.
+ * from the saved values in the device node.
+ */
+static inline void __restore_bars (struct device_node *dn)
+{
+	int i;
+
+	if (NULL=3D=3Ddn->phb) return;
+	for (i=3D4; i<10; i++) {
+		rtas_write_config(dn, i*4, 4, dn->config_space[i]);
+	}
+
+	/* 12 =3D=3D Expansion ROM Address */
+	rtas_write_config(dn, 12*4, 4, dn->config_space[12]);
+
+#define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
+#define SAVED_BYTE(OFF) (((u8 *)(dn->config_space))[BYTE_SWAP(OFF)])
+
+	rtas_write_config (dn, PCI_CACHE_LINE_SIZE, 1,
+	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
+
+	rtas_write_config (dn, PCI_LATENCY_TIMER, 1,
+	            SAVED_BYTE(PCI_LATENCY_TIMER));
+
+	/* max latency, min grant, interrupt pin and line */
+	rtas_write_config(dn, 15*4, 4, dn->config_space[15]);
+}
+
+/**
+ * eeh_restore_bars - restore the PCI config space info
+ */
+void eeh_restore_bars(struct device_node *dn)
+{
+	if (! dn->eeh_is_bridge)
+		__restore_bars (dn);
+
+	if (dn->child)
+		eeh_restore_bars (dn->child);
+}
+
+void eeh_pci_restore_bars(struct pci_dev *dev)
+{
+	struct device_node *dn =3D pci_device_to_OF_node(dev);
+	eeh_restore_bars (dn);
+}
+
+/* ------------------------------------------------------------- */
+/* The code below deals with enabling EEH for devices during  the
+ * early boot sequence.  EEH must be enabled before any PCI probing
+ * can be done.
+ */
+
+#define EEH_ENABLE 1
+
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
@@ -681,6 +874,8 @@
 	int enable;
=20
 	dn->eeh_mode =3D 0;
+	dn->eeh_check_count =3D 0;
+	dn->eeh_freeze_count =3D 0;
=20
 	if (status && strcmp(status, "ok") !=3D 0)
 		return NULL;	/* ignore devices with bad status */
@@ -704,8 +899,10 @@
 	 * But there are a few cases like display devices that make sense.
 	 */
 	enable =3D 1;	/* i.e. we will do checking */
+#if 0
 	if ((*class_code >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY)
 		enable =3D 0;
+#endif
=20
 	if (!enable)
 		dn->eeh_mode |=3D EEH_MODE_NOCHECK;
@@ -742,7 +939,7 @@
 		       dn->full_name);
 	}
=20
-	return NULL;=20
+	return NULL;
 }
=20
 /*
@@ -827,7 +1024,9 @@
 		return;
 	phb =3D dn->phb;
 	if (NULL =3D=3D phb || 0 =3D=3D phb->buid) {
-		printk(KERN_WARNING "EEH: Expected buid but found none\n");
+		printk(KERN_WARNING "EEH: Expected buid but found none for %s\n",
+		        dn->full_name);
+		dump_stack();
 		return;
 	}
=20
@@ -846,6 +1045,9 @@
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
+	int i;
+	struct device_node *dn;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
=20
@@ -854,6 +1056,17 @@
 #endif
=20
 	pci_addr_cache_insert_device (dev);
+
+	/* Save the BAR's; firmware doesn't restore these after EEH reset */
+	dn =3D pci_device_to_OF_node(dev);
+	for (i =3D 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4, &dn->config_space[i]);
+
+	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE)
+		dn->eeh_is_bridge =3D 1;
+
+	pci_dev_get (dev);
+	dn->pcidev =3D dev;
 }
 EXPORT_SYMBOL(eeh_add_device_late);
=20
@@ -866,6 +1079,7 @@
  */
 void eeh_remove_device(struct pci_dev *dev)
 {
+	struct device_node *dn;
 	if (!dev || !eeh_subsystem_enabled)
 		return;
=20
@@ -874,6 +1088,10 @@
 	printk(KERN_DEBUG "EEH: remove device %s\n", pci_name(dev));
 #endif
 	pci_addr_cache_remove_device(dev);
+
+	dn =3D pci_device_to_OF_node(dev);
+	dn->pcidev =3D NULL;
+	pci_dev_put (dev);
 }
 EXPORT_SYMBOL(eeh_remove_device);
=20
@@ -882,12 +1100,17 @@
 	unsigned int cpu;
 	unsigned long ffs =3D 0, positives =3D 0, failures =3D 0;
 	unsigned long resets =3D 0;
+	unsigned long no_dev =3D 0, no_dn =3D 0, no_cfg =3D 0, no_check =3D 0;
=20
 	for_each_cpu(cpu) {
 		ffs +=3D per_cpu(total_mmio_ffs, cpu);
 		positives +=3D per_cpu(false_positives, cpu);
 		failures +=3D per_cpu(ignored_failures, cpu);
 		resets +=3D per_cpu(slot_resets, cpu);
+		no_dev +=3D per_cpu(no_device, cpu);
+		no_dn +=3D per_cpu(no_dn, cpu);
+		no_cfg +=3D per_cpu(no_cfg_addr, cpu);
+		no_check +=3D per_cpu(ignored_check, cpu);
 	}
=20
 	if (0 =3D=3D eeh_subsystem_enabled) {
@@ -895,13 +1118,17 @@
 		seq_printf(m, "eeh_total_mmio_ffs=3D%ld\n", ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=3D%ld\n"
+		seq_printf(m,
+				"no device=3D%ld\n"
+				"no device node=3D%ld\n"
+				"no config address=3D%ld\n"
+				"check not wanted=3D%ld\n"
+				"eeh_total_mmio_ffs=3D%ld\n"
 			   "eeh_false_positives=3D%ld\n"
 			   "eeh_ignored_failures=3D%ld\n"
-			   "eeh_slot_resets=3D%ld\n"
-				"eeh_fail_count=3D%d\n",
-			   ffs, positives, failures, resets,
-				eeh_fail_count.counter);
+			   "eeh_slot_resets=3D%ld\n",
+				no_dev, no_dn, no_cfg, no_check,
+			   ffs, positives, failures, resets);
 	}
=20
 	return 0;
Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_driver.c	2005-08-23 14:34:4=
4.000000000 -0500
@@ -0,0 +1,361 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ * Copyright (C) 2004, 2005 Linas Vepstas <linas@linas.org>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <linas@us.ibm.com>
+ *
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <asm/eeh.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+
+#include "eeh_event.h"
+#include "../../../drivers/pci/pci.h"
+#include "../../../drivers/pci/hotplug/rpaphp.h"
+
+/**
+ * pci_search_bus_for_dev - return 1 if device is under this bus, else 0
+ * @bus: the bus to search for this device.
+ * @dev: the pci device we are looking for.
+ *
+ * XXX should this be moved to drivers/pci/search.c ?
+ */
+static int pci_search_bus_for_dev (struct pci_bus *bus, struct pci_dev *de=
v)
+{
+	struct list_head *ln;
+
+	if (!bus) return 0;
+
+	for (ln =3D bus->devices.next; ln !=3D &bus->devices; ln =3D ln->next) {
+		struct pci_dev *pdev =3D pci_dev_b(ln);
+		if (pdev =3D=3D dev)
+			return 1;
+		if (pdev->subordinate) {
+			int rc;
+			rc =3D pci_search_bus_for_dev (pdev->subordinate, dev);
+			if (rc)
+				return 1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * rpaphp_find_slot - find and return the slot holding the device
+ * @dev: pci device for which we want the slot structure.
+ */
+static struct slot *rpaphp_find_slot(struct pci_dev *dev)
+{
+	struct list_head *tmp, *n;
+	struct slot	*slot;
+
+	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+		struct pci_bus *bus;
+
+		slot =3D list_entry(tmp, struct slot, rpaphp_slot_list);
+
+		/* PHB's don't have bridges. */
+		bus =3D slot->bus;
+		if (bus =3D=3D NULL)
+			continue;
+
+		/* The PCI device could be the slot itself. */
+		if (bus->self =3D=3D dev)
+			return slot;
+
+		if (pci_search_bus_for_dev (bus, dev))
+			return slot;
+	}
+	return NULL;
+}
+
+struct hotplug_slot *pci_hp_find_slot(struct pci_dev *dev)
+{
+	struct slot *slot =3D rpaphp_find_slot(dev);
+	if (slot)
+		return slot->hotplug_slot;
+	return NULL;
+}
+
+/* ------------------------------------------------------- */
+/** eeh_report_error - report an EEH error to each device,
+ *  collect up and merge the device responses.
+ */
+
+static void eeh_report_error(struct pci_dev *dev, void *userdata)
+{
+	enum pcierr_result rc, *res =3D userdata;
+	struct pci_driver *driver =3D dev->driver;
+
+	dev->error_state =3D pci_channel_io_frozen;
+
+	if (!driver)
+		return;
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->error_detected)
+		return;
+
+	rc =3D driver->err_handler->error_detected (dev, pci_channel_io_frozen);
+	if (*res =3D=3D PCIERR_RESULT_NONE) *res =3D rc;
+	if (*res =3D=3D PCIERR_RESULT_NEED_RESET) return;
+	if (*res =3D=3D PCIERR_RESULT_DISCONNECT &&
+	     rc =3D=3D PCIERR_RESULT_NEED_RESET) *res =3D rc;
+}
+
+/** eeh_report_reset -- tell this device that the pci slot
+ *  has been reset.
+ */
+
+static void eeh_report_reset(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver =3D dev->driver;
+
+	if (!driver)
+		return;
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->slot_reset)
+		return;
+
+	driver->err_handler->slot_reset (dev);
+}
+
+static void eeh_report_resume(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver =3D dev->driver;
+
+	dev->error_state =3D pci_channel_io_normal;
+
+	if (!driver)
+		return;
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->resume)
+		return;
+
+	driver->err_handler->resume (dev);
+}
+
+static void eeh_report_failure(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver =3D dev->driver;
+
+	dev->error_state =3D pci_channel_io_perm_failure;
+
+	if (!driver)
+		return;
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->error_detected)
+		return;
+	driver->err_handler->error_detected (dev, pci_channel_io_perm_failure);
+}
+
+/* ------------------------------------------------------- */
+/**
+ * handle_eeh_events -- reset a PCI device after hard lockup.
+ *
+ * pSeries systems will isolate a PCI slot if the PCI-Host
+ * bridge detects address or data parity errors, DMA's
+ * occuring to wild addresses (which usually happen due to
+ * bugs in device drivers or in PCI adapter firmware).
+ * Slot isolations also occur if #SERR, #PERR or other misc
+ * PCI-related errors are detected.
+ *
+ * Recovery process consists of unplugging the device driver
+ * (which generated hotplug events to userspace), then issuing
+ * a PCI #RST to the device, then reconfiguring the PCI config
+ * space for all bridges & devices under this slot, and then
+ * finally restarting the device drivers (which cause a second
+ * set of hotplug events to go out to userspace).
+ */
+
+int eeh_reset_device (struct pci_dev *dev, struct device_node *dn, int rec=
onfig)
+{
+	struct hotplug_slot *frozen_slot=3D NULL;
+	struct hotplug_slot_ops *frozen_ops=3D NULL;
+
+	if (!dev)
+		return 1;
+
+	if (reconfig) {
+		frozen_slot =3D pci_hp_find_slot(dev);
+		if (frozen_slot)
+			frozen_ops =3D frozen_slot->ops;
+	}
+
+	if (frozen_ops) frozen_ops->disable_slot (frozen_slot);
+
+	/* Reset the pci controller. (Asserts RST#; resets config space).
+	 * Reconfigure bridges and devices */
+	rtas_set_slot_reset (dn->child);
+
+	/* Walk over all functions on this device */
+	struct device_node *peer =3D dn->child;
+	while (peer) {
+		rtas_configure_bridge(peer);
+		eeh_restore_bars(peer);
+		peer =3D peer->sibling;
+	}
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug scripts, e.g. ifdown for ethernet.  Yes, this is a hack,
+	 * but if we don't do this, weird things happen.
+	 */
+	if (frozen_ops) {
+		ssleep (5);
+		frozen_ops->enable_slot (frozen_slot);
+	}
+	return 0;
+}
+
+/* The longest amount of time to wait for a pci device
+ * to come back on line, in seconds.
+ */
+#define MAX_WAIT_FOR_RECOVERY 15
+
+int handle_eeh_events (struct eeh_event *event)
+{
+	int freeze_count=3D0;
+	struct device_node *frozen_device;
+	struct pci_dev *dev =3D event->dev;
+	int perm_failure =3D 0;
+
+	/* We might not have a pci device, if it was a config space read
+	 * that failed.  Find the pci device now.  */
+	if (!dev)
+		dev =3D event->dn->pcidev;
+	if (!dev)
+	{
+		printk ("EEH: EEH error caught, but no PCI device found!\n");
+		return 1;
+	}
+
+	/* Some devices go crazy if irq's are not ack'ed; disable irq now */
+	disable_irq_nosync (dev->irq);
+
+	frozen_device =3D pci_bus_to_OF_node(dev->bus);
+	if (!frozen_device)
+	{
+		printk (KERN_ERR "EEH: Cannot find PCI controller for %s\n",
+				pci_name(dev));
+
+		return 1;
+	}
+	BUG_ON (frozen_device->phb=3D=3DNULL);
+
+	/* We get "permanent failure" messages on empty slots.
+	 * These are false alarms. Empty slots have no child dn. */
+	if ((event->state =3D=3D pci_channel_io_perm_failure) && (frozen_device =
=3D=3D NULL))
+		return 0;
+
+	if (frozen_device)
+		freeze_count =3D frozen_device->eeh_freeze_count;
+	freeze_count ++;
+	if (freeze_count > EEH_MAX_ALLOWED_FREEZES)
+		perm_failure =3D 1;
+
+	/* If the reset state is a '5' and the time to reset is 0 (infinity)
+	 * or is more then 15 seconds, then mark this as a permanent failure.
+	 */
+	if ((event->state =3D=3D pci_channel_io_perm_failure) &&
+	    ((event->time_unavail <=3D 0) ||
+	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000)))
+	{
+		perm_failure =3D 1;
+	}
+
+	/* Log the error with the rtas logger. */
+	if (perm_failure) {
+		/*
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		printk (KERN_ERR
+		   "EEH: PCI device %s has failed %d times \n"
+			"and has been permanently disabled.  Please try reseating\n"
+		   "this device or replacing it.\n",
+			pci_name (dev),
+			freeze_count);
+
+		eeh_slot_error_detail (frozen_device, 2 /* Permanent Error */);
+
+		/* Notify all devices that they're about to go down. */
+		pci_walk_bus (dev->bus, eeh_report_failure, 0);
+
+		/* If there's a hotplug slot, unconfigure it */
+		// XXX we need alternate way to deconfigure non-hotplug slots.
+		struct hotplug_slot * frozen_slot =3D pci_hp_find_slot(dev);
+		if (frozen_slot && frozen_slot->ops)
+			frozen_slot->ops->disable_slot (frozen_slot);
+		return 1;
+	} else {
+		eeh_slot_error_detail (frozen_device, 1 /* Temporary Error */);
+	}
+
+	printk (KERN_WARNING
+	   "EEH: This PCI device has failed %d times since last reboot: %s\n",
+		freeze_count,
+		pci_name (dev));
+
+	/* Walk the various device drivers attached to this slot,
+	 * letting each know about the EEH bug.
+	 */
+	enum pcierr_result result =3D PCIERR_RESULT_NONE;
+	pci_walk_bus (dev->bus, eeh_report_error, &result);
+
+	/* If all device drivers were EEH-unaware, then pci hotplug
+	 * the device, and hope that clears the error. */
+	if (result =3D=3D PCIERR_RESULT_NONE) {
+		eeh_reset_device (dev, frozen_device, 1);
+	}
+
+	/* If any device called out for a reset, then reset the slot */
+	if (result =3D=3D PCIERR_RESULT_NEED_RESET) {
+		eeh_reset_device (dev, frozen_device, 0);
+		pci_walk_bus (dev->bus, eeh_report_reset, 0);
+	}
+
+	/* If all devices reported they can proceed, the re-enable PIO */
+	if (result =3D=3D PCIERR_RESULT_CAN_RECOVER) {
+		/* XXX Not supported; we brute-force reset the device */
+		eeh_reset_device (dev, frozen_device, 0);
+		pci_walk_bus (dev->bus, eeh_report_reset, 0);
+	}
+
+	/* Tell all device drivers that they can resume operations */
+	pci_walk_bus (dev->bus, eeh_report_resume, 0);
+
+	/* Store the freeze count with the pci adapter, and not the slot.
+	 * This way, if the device is replaced, the count is cleared.
+	 */
+	frozen_device->eeh_freeze_count =3D freeze_count;
+
+	return 1;
+}
+
+/* ---------- end of file ---------- */
Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_event.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_event.c	2005-08-23 10:33:40=
=2E000000000 -0500
@@ -0,0 +1,116 @@
+/*
+ * eeh_event.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
+ */
+
+#include <linux/list.h>
+#include <linux/pci.h>
+#include "eeh_event.h"
+
+/** Overview:
+ *  EEH error states may be detected within exception handlers;
+ *  however, the recovery processing needs to occur asynchronously
+ *  in a normal kernel context and not an interrupt context.
+ *  This pair of routines creates an event and queues it onto a
+ *  work-queue, where a worker thread can drive recovery.
+ */
+
+/* EEH event workqueue setup. */
+static spinlock_t eeh_eventlist_lock =3D SPIN_LOCK_UNLOCKED;
+LIST_HEAD(eeh_eventlist);
+static void eeh_event_handler(void *);
+DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);
+
+int handle_eeh_events (struct eeh_event *event);
+
+/**
+ * eeh_event_handler - dispatch EEH events.  The detection of a frozen
+ * slot can occur inside an interrupt, where it can be hard to do
+ * anything about it.  The goal of this routine is to pull these
+ * detection events out of the context of the interrupt handler, and
+ * re-dispatch them for processing at a later time in a normal context.
+ *
+ * @dummy - unused
+ */
+static void eeh_event_handler(void *dummy)
+{
+	unsigned long flags;
+	struct eeh_event	*event;
+
+	while (1) {
+		spin_lock_irqsave(&eeh_eventlist_lock, flags);
+		event =3D NULL;
+		if (!list_empty(&eeh_eventlist)) {
+			event =3D list_entry(eeh_eventlist.next, struct eeh_event, list);
+			list_del(&event->list);
+		}
+		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+		if (event =3D=3D NULL)
+			break;
+
+		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
+		       pci_name(event->dev));
+
+		handle_eeh_events(event);
+
+		pci_dev_put(event->dev);
+		kfree(event);
+	}
+}
+
+/**
+ * eeh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).
+ */
+int eeh_send_failure_event (struct device_node *dn,
+                            struct pci_dev *dev,
+                            enum pci_channel_state state,
+                            int time_unavail)
+{
+	unsigned long flags;
+	struct eeh_event *event;
+
+	event =3D kmalloc(sizeof(*event), GFP_ATOMIC);
+	if (event =3D=3D NULL) {
+		printk (KERN_ERR "EEH: out of memory, event not handled\n");
+		return 1;
+ 	}
+
+	if (dev)
+		pci_dev_get(dev);
+
+	event->dn =3D dn;
+	event->dev =3D dev;
+	event->state =3D state;
+	event->time_unavail =3D time_unavail;
+
+	/* We may or may not be called in an interrupt context */
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	list_add(&event->list, &eeh_eventlist);
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
+	schedule_work(&eeh_event_wq);
+
+	return 0;
+}
+
+/********************** END OF FILE ******************************/
Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_event.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_event.h	2005-08-19 15:52:59=
=2E000000000 -0500
@@ -0,0 +1,52 @@
+/*
+ *	eeh_event.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Copyright (c) 2005 Linas Vepstas <linas@linas.org>
+ */
+
+#ifndef ASM_PPC64_EEH_EVENT_H
+#define ASM_PPC64_EEH_EVENT_H
+
+/** EEH event -- structure holding pci controller data that describes
+ *  a change in the isolation status of a PCI slot.  A pointer
+ *  to this struct is passed as the data pointer in a notify callback.
+ */
+struct eeh_event {
+	struct list_head     list;
+	struct device_node 	*dn;   /* struct device node */
+	struct pci_dev       *dev;  /* affected device */
+	enum pci_channel_state state; /* PCI bus state for the affected device */
+	int time_unavail;    /* milliseconds until device might be available */
+};
+
+/**
+ * eeh_send_failure_event - generate a PCI error event
+ * @dev pci device
+ *
+ * This routine builds a PCI error event which will be delivered
+ * to all listeners on the peh_notifier_chain.
+ *
+ * This routine can be called within an interrupt context;
+ * the actual event will be delivered in a normal context
+ * (from a workqueue).
+ */
+int eeh_send_failure_event (struct device_node *dn,
+                            struct pci_dev *dev,
+                            enum pci_channel_state state,
+                            int time_unavail);
+
+#endif /* ASM_PPC64_EEH_EVENT_H */
Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/rtas_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/kernel/rtas_pci.c	2005-08-19 12:0=
1:00.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/rtas_pci.c	2005-08-23 14:37:20.=
000000000 -0500
@@ -58,7 +58,7 @@
 	return 0;
 }
=20
-static int rtas_read_config(struct device_node *dn, int where, int size, u=
32 *val)
+int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval =3D -1;
 	unsigned long buid, addr;
@@ -105,10 +105,11 @@
 	for (dn =3D busdn->child; dn; dn =3D dn->sibling)
 		if (dn->devfn =3D=3D devfn)
 			return rtas_read_config(dn, where, size, val);
+
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
=20
-static int rtas_write_config(struct device_node *dn, int where, int size, =
u32 val)
+int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;
Index: linux-2.6.13-rc6-git9/include/asm-ppc64/eeh.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/include/asm-ppc64/eeh.h	2005-07-15 16:18:57.=
000000000 -0500
+++ linux-2.6.13-rc6-git9/include/asm-ppc64/eeh.h	2005-08-19 15:02:28.00000=
0000 -0500
@@ -1,4 +1,4 @@
-/*=20
+/*
  * eeh.h
  * Copyright (C) 2001  Dave Engebretsen & Todd Inglett IBM Corporation.
  *
@@ -6,12 +6,12 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *=20
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *=20
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -36,6 +36,11 @@
 #define EEH_MODE_SUPPORTED	(1<<0)
 #define EEH_MODE_NOCHECK	(1<<1)
 #define EEH_MODE_ISOLATED	(1<<2)
+#define EEH_MODE_RECOVERING	(1<<3)
+
+/* Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled. */
+#define EEH_MAX_ALLOWED_FREEZES 5
=20
 void __init eeh_init(void);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
@@ -59,35 +64,71 @@
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
- * This routine should be when a device is removed from a running
- * system (e.g. by hotplug or dlpar).
+ * This routine should be called when a device is removed from
+ * a running system (e.g. by hotplug or dlpar).  It unregisters
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
  */
 void eeh_remove_device(struct pci_dev *);
=20
-#define EEH_DISABLE		0
-#define EEH_ENABLE		1
-#define EEH_RELEASE_LOADSTORE	2
-#define EEH_RELEASE_DMA		3
+/**
+ * eeh_slot_error_detail -- record and EEH error condition to the log
+ * @severity: 1 if temporary, 2 if permanent failure.
+ *
+ * Obtains the the EEH error details from the RTAS subsystem,
+ * and then logs these details with the RTAS error log system.
+ */
+void eeh_slot_error_detail (struct device_node *dn, int severity);
=20
 /**
- * Notifier event flags.
+ * rtas_set_slot_reset -- unfreeze a frozen slot
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * does this by asserting the PCI #RST line for 1/8th of
+ * a second; this routine will sleep while the adapter is
+ * being reset.
  */
-#define EEH_NOTIFY_FREEZE  1
+void rtas_set_slot_reset (struct device_node *dn);
=20
-/** EEH event -- structure holding pci slot data that describes
- *  a change in the isolation status of a PCI slot.  A pointer
- *  to this struct is passed as the data pointer in a notify callback.
- */
-struct eeh_event {
-	struct list_head     list;
-	struct pci_dev       *dev;
-	struct device_node   *dn;
-	int                  reset_state;
-};
-
-/** Register to find out about EEH events. */
-int eeh_register_notifier(struct notifier_block *nb);
-int eeh_unregister_notifier(struct notifier_block *nb);
+/** rtas_pci_slot_reset raises/lowers the pci #RST line
+ *  state: 1/0 to raise/lower the #RST
+ *
+ * Clear the EEH-frozen condition on a slot.  This routine
+ * asserts the PCI #RST line if the 'state' argument is '1',
+ * and drops the #RST line if 'state is '0'.  This routine is
+ * safe to call in an interrupt context.
+ *
+ */
+void rtas_pci_slot_reset(struct device_node *dn, int state);
+void eeh_pci_slot_reset(struct pci_dev *dev, int state);
+
+/** eeh_pci_slot_availability -- Indicates whether a PCI
+ *  slot is ready to be used. After a PCI reset, it may take a while
+ *  for the PCI fabric to fully reset the comminucations path to the
+ *  given PCI card.  This routine can be used to determine how long
+ *  to wait before a PCI slot might become usable.
+ *
+ *  This routine returns how long to wait (in milliseconds) before
+ *  the slot is expected to be usable.  A value of zero means the
+ *  slot is immediately usable. A negavitve value means that the
+ *  slot is permanently disabled.
+ */
+int eeh_pci_slot_availability(struct pci_dev *dev);
+
+/** Restore device configuration info across device resets.
+ */
+void eeh_restore_bars(struct device_node *);
+void eeh_pci_restore_bars(struct pci_dev *dev);
+
+/**
+ * rtas_configure_bridge -- firmware initialization of pci bridge
+ *
+ * Ask the firmware to configure any PCI bridge devices
+ * located behind the indicated node. Required after a
+ * pci device reset.
+ */
+void rtas_configure_bridge(struct device_node *dn);
=20
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
@@ -129,7 +170,7 @@
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
=20
-/*=20
+/*
  * MMIO read/write operations with EEH support.
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr)
@@ -251,21 +292,21 @@
 		*((u8 *)dest) =3D *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc =3D (void *)((unsigned long)vsrc + 1);
-		dest =3D (void *)((unsigned long)dest + 1);		=09
+		dest =3D (void *)((unsigned long)dest + 1);
 		n--;
 	}
 	while(n > 4) {
 		*((u32 *)dest) =3D *((volatile u32 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc =3D (void *)((unsigned long)vsrc + 4);
-		dest =3D (void *)((unsigned long)dest + 4);		=09
+		dest =3D (void *)((unsigned long)dest + 4);
 		n -=3D 4;
 	}
 	while(n) {
 		*((u8 *)dest) =3D *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc =3D (void *)((unsigned long)vsrc + 1);
-		dest =3D (void *)((unsigned long)dest + 1);		=09
+		dest =3D (void *)((unsigned long)dest + 1);
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
@@ -287,19 +328,19 @@
 	while(n && (!EEH_CHECK_ALIGN(vdest, 4) || !EEH_CHECK_ALIGN(src, 4))) {
 		*((volatile u8 *)vdest) =3D *((u8 *)src);
 		src =3D (void *)((unsigned long)src + 1);
-		vdest =3D (void *)((unsigned long)vdest + 1);		=09
+		vdest =3D (void *)((unsigned long)vdest + 1);
 		n--;
 	}
 	while(n > 4) {
 		*((volatile u32 *)vdest) =3D *((volatile u32 *)src);
 		src =3D (void *)((unsigned long)src + 4);
-		vdest =3D (void *)((unsigned long)vdest + 4);		=09
+		vdest =3D (void *)((unsigned long)vdest + 4);
 		n-=3D4;
 	}
 	while(n) {
 		*((volatile u8 *)vdest) =3D *((u8 *)src);
 		src =3D (void *)((unsigned long)src + 1);
-		vdest =3D (void *)((unsigned long)vdest + 1);		=09
+		vdest =3D (void *)((unsigned long)vdest + 1);
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
Index: linux-2.6.13-rc6-git9/include/asm-ppc64/rtas.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/include/asm-ppc64/rtas.h	2005-08-17 15:17:44=
=2E000000000 -0500
+++ linux-2.6.13-rc6-git9/include/asm-ppc64/rtas.h	2005-08-19 15:02:28.0000=
00000 -0500
@@ -246,4 +246,6 @@
=20
 #define GLOBAL_INTERRUPT_QUEUE 9005
=20
+extern int rtas_write_config(struct device_node *dn, int where, int size, =
u32 val);
+
 #endif /* _PPC64_RTAS_H */
Index: linux-2.6.13-rc6-git9/include/asm-ppc64/prom.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/include/asm-ppc64/prom.h	2005-08-19 15:11:39=
=2E000000000 -0500
+++ linux-2.6.13-rc6-git9/include/asm-ppc64/prom.h	2005-08-23 13:31:52.0000=
00000 -0500
@@ -135,11 +135,17 @@
 	int	busno;			/* for pci devices */
 	int	bussubno;		/* for pci devices */
 	int	devfn;			/* for pci devices */
-	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
-	int	eeh_config_addr;
+	int   eeh_mode;      /* See eeh.h for possible EEH_MODEs */
+	int   eeh_config_addr;
+	int   eeh_check_count;    /* number of times device driver ignored error =
*/
+	int   eeh_freeze_count;   /* number of times this device froze up. */
+	int   eeh_is_bridge;      /* device is pci-to-pci bridge */
+
 	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	struct   pci_dev *pcidev;    /* back-pointer to the pci device */
+	u32      config_space[16]; /* saved PCI config space */
=20
 	struct	property *properties;
 	struct	device_node *parent;
Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.13-rc6-git9.orig/arch/ppc64/kernel/Makefile	2005-08-17 15:40:=
18.000000000 -0500
+++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/Makefile	2005-08-19 15:54:26.00=
0000000 -0500
@@ -37,7 +37,7 @@
 			 bpa_iic.o spider-pic.o
=20
 obj-$(CONFIG_KEXEC)		+=3D machine_kexec.o
-obj-$(CONFIG_EEH)		+=3D eeh.o
+obj-$(CONFIG_EEH)		+=3D eeh.o eeh_driver.o eeh_event.o
 obj-$(CONFIG_PROC_FS)		+=3D proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+=3D rtas_flash.o
 obj-$(CONFIG_SMP)		+=3D smp.o

--

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDC7WiZKmaggEEWTMRAjd/AJ4qHAHHbsgQkmWY2GLMOyRenxIgXgCfTdI2
l15rqMNwC/pg63UhfG3SLrs=
=2Co5
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--
