Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUHYAyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUHYAyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUHYAyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:54:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:63156 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267186AbUHYAsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:48:35 -0400
Subject: [PATCH] interrupt driven hvc_console as vio device
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-J9h0F5dzflHDjIq+mpBb"
Organization: IBM
Message-Id: <1093394937.3402.83.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 19:48:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J9h0F5dzflHDjIq+mpBb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew, Paul,

This is an hvc_console patch which provides driver and ppc64
architecture fixes to enable the hvc_console driver to register itself
as a vio device with the vio bus, provide hotplug add/remove for vty
adapters, and act as an interrupt driven driver on Power-5 hardware or
remain as a polling driver on Power-4 hardware. 

Paul MacKerras should probably approve this patch since it includes
arch/ppc64/ changes.

Ben Herrenschmidt wrote the original patch for the Ameslab tree, which
provided the int-driven or poll driven console that this patch is
extends upon.  He had me add his 'signed-off-by' line.

Changelog:

arch/ppc64/kernel/hvconsole.c
-----------------------------------------------------------------------
-Changed hvc_get_chars() and hvc_put_chars() api to take vtermno rather
than index number.

-Added hvc_find_vtys() function which walks the bus looking for
vterm/vty devices to callback to the hvc_console driver.  This provides
console output functionality prior to early console init (pre mem init
and pre device probe).

include/asm-ppc64/hvconsole.h
-----------------------------------------------------------------------

-Changed hvc_get_chars() and hvc_put_chars() api to take vtermno rather
than index number.

-Added hvc_find_vtys() function.

-Added hvc_instantiate() function which is implemented by a console
driver wanting to receive a callback of and early console init.

drivers/char/hvc_console.c
-----------------------------------------------------------------------

-Switch khvcd from kernel_threads to kthreads which got rid of
deprecated daemonize().

-Added module exit clause to be thorough (not terribly necessary with a
console driver of course)

-Added early discovery of vterm/vty adapters by doing a bus walk on
early console init which results in hvc_instantiate() callback and
addition of the vtermno into a static array of vtermnos supported as
console adapters (meaning the console api's work against these vtermnos
prior to full console initialization).

-This driver is now registered as a vio driver which means that vty
adapters are now managed via probe/remove.  This means hvc_console
supports hotplug vty adapters.

-Driver now requests more device nodes than what was found on the
initial bus walk when registered as a tty driver to make room for
hotplug vty adapters.  These secondary vty adapters provide a tty tunnel
between partitions.

-Removed static hvc_struct array and replaced with a linux list that has
elements (hvc_struct instances) added/removed on probe/remove AFTER
early console init.  This is important because kmalloc can't be done at
early console init.

-Driver now either runs in interrupt driven mode or in polling mode on
older hardware.  The khvcd is smart enough to not 'schedule()' when
there are no interrupts.

-kobjects are now used for ref counting on the hvc_struct instances.

This patch was tested on both Power-4 and Power-5 hardware.
Thanks,

Ryan S. Arnold
IBM Linux Technology Center

--=-J9h0F5dzflHDjIq+mpBb
Content-Disposition: attachment; filename=interrupt-driven_hvc_console_draft2.patch
Content-Type: text/x-patch; name=interrupt-driven_hvc_console_draft2.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>

--- linux-2.6.8.1/arch/ppc64/kernel/hvconsole.c	Sat Aug 14 05:55:32 2004
+++ hvc_console_linux-2.6.8.1/arch/ppc64/kernel/hvconsole.c	Tue Aug 24 19:32:20 2004
@@ -1,6 +1,10 @@
 /*
  * hvconsole.c
  * Copyright (C) 2004 Hollis Blanchard, IBM Corporation
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Additional Author(s):
+ *  Ryan S. Arnold <rsa@us.ibm.com>
  *
  * LPAR console support.
  * 
@@ -22,14 +26,22 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/hvcall.h>
-#include <asm/prom.h>
 #include <asm/hvconsole.h>
+#include <asm/prom.h>
 
-int hvc_get_chars(int index, char *buf, int count)
+/**
+ * hvc_get_chars - retrieve characters from firmware for denoted vterm adatper
+ * @vtermno: The vtermno or unit_address of the adapter from which to fetch the
+ *	data.
+ * @buf: The character buffer into which to put the character data fetched from
+ *	firmware.
+ * @count: not used?
+ */
+int hvc_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	unsigned long got;
 
-	if (plpar_hcall(H_GET_TERM_CHAR, index, 0, 0, 0, &got,
+	if (plpar_hcall(H_GET_TERM_CHAR, vtermno, 0, 0, 0, &got,
 		(unsigned long *)buf, (unsigned long *)buf+1) == H_Success) {
 		/*
 		 * Work around a HV bug where it gives us a null
@@ -53,41 +65,57 @@
 
 EXPORT_SYMBOL(hvc_get_chars);
 
-int hvc_put_chars(int index, const char *buf, int count)
+/**
+ * hvc_put_chars: send characters to firmware for denoted vterm adapter
+ * @vtermno: The vtermno or unit_address of the adapter from which the data
+ *	originated.
+ * @buf: The character buffer that contains the character data to send to
+ *	firmware.
+ * @count: Send this number of characters.
+ */
+int hvc_put_chars(uint32_t vtermno, const char *buf, int count)
 {
 	unsigned long *lbuf = (unsigned long *) buf;
 	long ret;
 
-	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, index, count, lbuf[0],
+	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, vtermno, count, lbuf[0],
 				 lbuf[1]);
 	if (ret == H_Success)
 		return count;
 	if (ret == H_Busy)
 		return 0;
-	return -1;
+	return -EIO;
 }
 
 EXPORT_SYMBOL(hvc_put_chars);
 
-/* return the number of client vterms present */
-/* XXX this requires an interface change to handle multiple discontiguous
- * vterms */
-int hvc_count(int *start_termno)
+/*
+ * We hope/assume that the first vty found corresponds to the first console
+ * device.
+ */
+int hvc_find_vtys(void)
 {
 	struct device_node *vty;
-	int num_found = 0;
+	int count = 0;
 
-	/* consider only the first vty node.
-	 * we should _always_ be able to find one. */
-	vty = of_find_node_by_name(NULL, "vty");
-	if (vty && device_is_compatible(vty, "hvterm1")) {
-		u32 *termno = (u32 *)get_property(vty, "reg", NULL);
-
-		if (termno && start_termno)
-			*start_termno = *termno;
-		num_found = 1;
-		of_node_put(vty);
+	for (vty = of_find_node_by_name(NULL, "vty"); vty != NULL;
+			vty = of_find_node_by_name(vty, "vty")) {
+		uint32_t *vtermno;
+
+		vtermno = (uint32_t *)get_property(vty, "reg", NULL);
+		if (!vtermno)
+			continue;
+
+		/* We have statically defined space for only a certain number of
+		 * console adapters. */
+		if (count >= MAX_NR_HVC_CONSOLES)
+			break;
+
+		if (device_is_compatible(vty, "hvterm1")) {
+			hvc_instantiate(*vtermno, count);
+			count++;
+		}
 	}
 
-	return num_found;
+	return count;
 }
--- linux-2.6.8.1/include/asm-ppc64/hvconsole.h	Sat Aug 14 05:55:33 2004
+++ hvc_console_linux-2.6.8.1/include/asm-ppc64/hvconsole.h	Thu Aug 19 11:12:58 2004
@@ -22,9 +22,19 @@
 #ifndef _PPC64_HVCONSOLE_H
 #define _PPC64_HVCONSOLE_H
 
-extern int hvc_get_chars(int index, char *buf, int count);
-extern int hvc_put_chars(int index, const char *buf, int count);
-extern int hvc_count(int *start_termno);
+/*
+ * This is the max number of console adapters that can/will be found as
+ * console devices on first stage console init.  Any number beyond this range
+ * can't be used as a console device but is still a valid tty device.
+ */
+#define MAX_NR_HVC_CONSOLES	16
 
-#endif /* _PPC64_HVCONSOLE_H */
+extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
+extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
+
+/* Early discovery of console adapters. */
+extern int hvc_find_vtys(void);
 
+/* Implemented by a console driver */
+extern int hvc_instantiate(uint32_t vtermno, int index);
+#endif /* _PPC64_HVCONSOLE_H */
--- linux-2.6.8.1/drivers/char/hvc_console.c	Sat Aug 14 05:56:00 2004
+++ hvc_console_linux-2.6.8.1/drivers/char/hvc_console.c	Tue Aug 24 19:41:27 2004
@@ -1,6 +1,11 @@
 /*
  * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
  * Copyright (C) 2001 Paul Mackerras <paulus@au.ibm.com>, IBM
+ * Copyright (C) 2004 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Additional Author(s):
+ *  Ryan S. Arnold <rsa@us.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,38 +22,45 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/console.h>
+#include <linux/cpumask.h>
 #include <linux/init.h>
+#include <linux/kbd_kern.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/console.h>
 #include <linux/major.h>
-#include <linux/kernel.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/sched.h>
-#include <linux/kbd_kern.h>
-#include <asm/uaccess.h>
 #include <linux/spinlock.h>
-#include <linux/cpumask.h>
-
-extern int hvc_count(int *);
-extern int hvc_get_chars(int index, char *buf, int count);
-extern int hvc_put_chars(int index, const char *buf, int count);
+#include <asm/uaccess.h>
+#include <asm/hvconsole.h>
+#include <asm/vio.h>
 
 #define HVC_MAJOR	229
 #define HVC_MINOR	0
 
-#define MAX_NR_HVC_CONSOLES	4
-
 #define TIMEOUT		((HZ + 99) / 100)
 
+/*
+ * The Linux TTY code does not support dynamic addition of tty derived devices
+ * so we need to know how many tty devices we might need when space is allocated
+ * for the tty device.  Since this driver supports hotplug of vty adapters we
+ * need to make sure we have enough allocated.
+ */
+#define HVC_ALLOC_TTY_ADAPTERS	8
+
 static struct tty_driver *hvc_driver;
-static int hvc_offset;
 #ifdef CONFIG_MAGIC_SYSRQ
 static int sysrq_pressed;
 #endif
 
 #define N_OUTBUF	16
+#define N_INBUF		16
 
 #define __ALIGNED__	__attribute__((__aligned__(8)))
 
@@ -60,59 +72,237 @@
 	int do_wakeup;
 	char outbuf[N_OUTBUF] __ALIGNED__;
 	int n_outbuf;
+	uint32_t vtermno;
+	int irq_requested;
+	int irq;
+	struct list_head next;
+	struct kobject kobj; /* ref count & hvc_struct lifetime */
+	struct vio_dev *vdev;
 };
 
-struct hvc_struct hvc_struct[MAX_NR_HVC_CONSOLES];
+/* dynamic list of hvc_struct instances */
+static struct list_head hvc_structs = LIST_HEAD_INIT(hvc_structs);
 
-static int hvc_open(struct tty_struct *tty, struct file * filp)
+/*
+ * Protect the list of hvc_struct instances from inserts and removals during
+ * list traversal.
+ */
+static spinlock_t hvc_structs_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Initial console vtermnos for console API usage prior to full console
+ * initialization.  Any vty adapter outside this range will not have usable
+ * console interfaces but can still be used as a tty device.  This has to be
+ * static because kmalloc will not work during early console init.
+ */
+static uint32_t vtermnos[MAX_NR_HVC_CONSOLES];
+
+/* Used for accounting purposes */
+static int num_vterms = 0;
+
+static struct task_struct *hvc_task;
+
+/*
+ * This value is used to associate a tty->index value to a hvc_struct based
+ * upon order of exposure via hvc_probe().
+ */
+static int hvc_count = -1;
+
+/* Picks up late kicks after list walk but before schedule() */
+static int hvc_kicked;
+
+/* Wake the sleeping khvcd */
+static void hvc_kick(void)
+{
+	hvc_kicked = 1;
+	wake_up_process(hvc_task);
+}
+
+/*
+ * NOTE: This API isn't used if the console adapter doesn't support interrupts.
+ * In this case the console is poll driven.
+ */
+static irqreturn_t hvc_handle_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	hvc_kick();
+	return IRQ_HANDLED;
+}
+
+static void hvc_unthrottle(struct tty_struct *tty)
+{
+	hvc_kick();
+}
+
+/*
+ * Do not call this function with either the hvc_strucst_lock or the hvc_struct
+ * lock held.  If successful, this function increments the kobject reference
+ * count against the target hvc_struct so it should be released when finished.
+ */
+struct hvc_struct *hvc_get_by_index(int index)
 {
-	int line = tty->index;
 	struct hvc_struct *hp;
 	unsigned long flags;
 
-	if (line < 0 || line >= MAX_NR_HVC_CONSOLES)
+	spin_lock(&hvc_structs_lock);
+
+	list_for_each_entry(hp, &hvc_structs, next) {
+		spin_lock_irqsave(&hp->lock, flags);
+		if (hp->index == index) {
+			kobject_get(&hp->kobj);
+			spin_unlock_irqrestore(&hp->lock, flags);
+			spin_unlock(&hvc_structs_lock);
+			return hp;
+		}
+		spin_unlock_irqrestore(&hp->lock, flags);
+	}
+	hp = NULL;
+
+	spin_unlock(&hvc_structs_lock);
+	return hp;
+}
+
+/*
+ * The TTY interface won't be used until after the vio layer has exposed the vty
+ * adapter to the kernel.
+ */
+static int hvc_open(struct tty_struct *tty, struct file * filp)
+{
+	struct hvc_struct *hp;
+	unsigned long flags;
+	int irq = NO_IRQ;
+	int rc = 0;
+	struct kobject *kobjp;
+
+	/* Auto increments kobject reference if found. */
+	if (!(hp = hvc_get_by_index(tty->index))) {
+		printk(KERN_WARNING "hvc_console: tty open failed, no vty associated with tty.\n");
 		return -ENODEV;
-	hp = &hvc_struct[line];
+	}
 
-	tty->driver_data = hp;
 	spin_lock_irqsave(&hp->lock, flags);
+	/* Check and then increment for fast path open. */
+	if (hp->count++ > 0) {
+		spin_unlock_irqrestore(&hp->lock, flags);
+		hvc_kick();
+		return 0;
+	} /* else count == 0 */
+
+	tty->driver_data = hp;
 	hp->tty = tty;
-	hp->count++;
+	/* Save for request_irq outside of spin_lock. */
+	irq = hp->irq;
+	if (irq != NO_IRQ)
+		hp->irq_requested = 1;
+
+	kobjp = &hp->kobj;
+
 	spin_unlock_irqrestore(&hp->lock, flags);
+	/* check error, fallback to non-irq */
+	if (irq != NO_IRQ)
+		rc = request_irq(irq, hvc_handle_interrupt, SA_INTERRUPT, "hvc_console", hp);
+
+	/*
+	 * If the request_irq() fails and we return an error.  The tty layer
+	 * will call hvc_close() after a failed open but we don't want to clean
+	 * up there so we'll clean up here and clear out the previously set
+	 * tty fields and return the kobject reference.
+	 */
+	if (rc) {
+		spin_lock_irqsave(&hp->lock, flags);
+		hp->tty = NULL;
+		hp->irq_requested = 0;
+		spin_unlock_irqrestore(&hp->lock, flags);
+		tty->driver_data = NULL;
+		kobject_put(kobjp);
+	}
+	/* Force wakeup of the polling thread */
+	hvc_kick();
 
-	return 0;
+	return rc;
 }
 
 static void hvc_close(struct tty_struct *tty, struct file * filp)
 {
-	struct hvc_struct *hp = tty->driver_data;
+	struct hvc_struct *hp;
+	struct kobject *kobjp;
+	int irq = NO_IRQ;
+	int final = 1;
 	unsigned long flags;
 
-	if (tty_hung_up_p(filp))
+	/*
+	 * No driver_data means that this close was issued after a failed
+	 * hvcs_open by the tty layer's release_dev() function and we can just
+	 * exit cleanly. */
+	if (!tty->driver_data) {
 		return;
+	}
+
+	hp = tty->driver_data;
 	spin_lock_irqsave(&hp->lock, flags);
-	if (--hp->count == 0)
+
+	kobjp = &hp->kobj;
+	if (tty_hung_up_p(filp))
+		goto bail;
+
+	if (--hp->count == 0) {
 		hp->tty = NULL;
-	else if (hp->count < 0)
-		printk(KERN_ERR "hvc_close %lu: oops, count is %d\n",
-		       hp - hvc_struct, hp->count);
+		while (hp->n_outbuf) {
+			spin_unlock_irqrestore(&hp->lock, flags);
+			yield();
+			spin_lock_irqsave(&hp->lock, flags);
+		}
+		if (hp->irq_requested)
+			irq = hp->irq;
+		hp->irq_requested = 0;
+	} else if (hp->count < 0)
+		printk(KERN_ERR "hvc_close %X: oops, count is %d\n",
+		       hp->vtermno, hp->count);
+	else
+		final = 0; /* only free the irq on the last close */
+ bail:
 	spin_unlock_irqrestore(&hp->lock, flags);
+	kobject_put(kobjp);
+	/* Only free the IRQ after closing the last instance. */
+	if (final && irq != NO_IRQ)
+		free_irq(irq, hp);
 }
 
 static void hvc_hangup(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
+	unsigned long flags;
+	int irq = NO_IRQ;
+	int temp_open_count;
+	struct kobject *kobjp;
 
+	spin_lock_irqsave(&hp->lock, flags);
+	kobjp = &hp->kobj;
+	temp_open_count = hp->count;
 	hp->count = 0;
+	hp->n_outbuf = 0;
 	hp->tty = NULL;
+	if (hp->irq_requested)
+		/* Saved for use outside of spin_lock. */
+		irq = hp->irq;
+	hp->irq_requested = 0;
+	spin_unlock_irqrestore(&hp->lock, flags);
+	if (irq != NO_IRQ)
+		free_irq(irq, hp);
+	while(temp_open_count) {
+		--temp_open_count;
+		kobject_put(kobjp);
+	}
 }
 
-/* called with hp->lock held */
+/*
+ * Push buffered characters whether they were just recently buffered or waiting
+ * on a blocked hypervisor.  Call this function with hp->lock held.
+ */
 static void hvc_push(struct hvc_struct *hp)
 {
 	int n;
 
-	n = hvc_put_chars(hp->index + hvc_offset, hp->outbuf, hp->n_outbuf);
+	n = hvc_put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
 	if (n <= 0) {
 		if (n == 0)
 			return;
@@ -127,135 +317,239 @@
 		hp->do_wakeup = 1;
 }
 
-static int hvc_write(struct tty_struct *tty, int from_user,
-		     const unsigned char *buf, int count)
+static inline int __hvc_write_user(struct hvc_struct *hp,
+				   const unsigned char *buf, int count)
 {
-	struct hvc_struct *hp = tty->driver_data;
 	char *tbuf, *p;
 	int tbsize, rsize, written = 0;
 	unsigned long flags;
 
-	if (from_user) {
-		tbsize = min(count, (int)PAGE_SIZE);
-		if (!(tbuf = kmalloc(tbsize, GFP_KERNEL)))
-			return -ENOMEM;
-
-		while ((rsize = count - written) > 0) {
-			int wsize;
-			if (rsize > tbsize)
-				rsize = tbsize;
-
-			p = tbuf;
-			rsize -= copy_from_user(p, buf, rsize);
-			if (!rsize) {
-				if (written == 0)
-					written = -EFAULT;
-				break;
-			}
-			buf += rsize;
-			written += rsize;
-
-			spin_lock_irqsave(&hp->lock, flags);
-			for (wsize = N_OUTBUF - hp->n_outbuf; rsize && wsize;
-					wsize = N_OUTBUF - hp->n_outbuf) {
-				if (wsize > rsize)
-					wsize = rsize;
-				memcpy(hp->outbuf + hp->n_outbuf, p, wsize);
-				hp->n_outbuf += wsize;
-				hvc_push(hp);
-				rsize -= wsize;
-				p += wsize;
-			}
-			spin_unlock_irqrestore(&hp->lock, flags);
-
-			if (rsize)
-				break;
+	tbsize = min(count, (int)PAGE_SIZE);
+	if (!(tbuf = kmalloc(tbsize, GFP_KERNEL)))
+		return -ENOMEM;
 
-			if (count < tbsize)
-				tbsize = count;
+	while ((rsize = count - written) > 0) {
+		int wsize;
+		if (rsize > tbsize)
+			rsize = tbsize;
+
+		p = tbuf;
+		rsize -= copy_from_user(p, buf, rsize);
+		if (!rsize) {
+			if (written == 0)
+				written = -EFAULT;
+			break;
 		}
+		buf += rsize;
 
-		kfree(tbuf);
-	} else {
 		spin_lock_irqsave(&hp->lock, flags);
-		while (count > 0 && (rsize = N_OUTBUF - hp->n_outbuf) > 0) {
-			if (rsize > count)
-				rsize = count;
-			memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
-			count -= rsize;
-			buf += rsize;
-			hp->n_outbuf += rsize;
-			written += rsize;
+
+		/* Push pending writes: make some room in buffer */
+		if (hp->n_outbuf > 0)
+			hvc_push(hp);
+
+		for (wsize = N_OUTBUF - hp->n_outbuf; rsize && wsize;
+		     wsize = N_OUTBUF - hp->n_outbuf) {
+			if (wsize > rsize)
+				wsize = rsize;
+			memcpy(hp->outbuf + hp->n_outbuf, p, wsize);
+			hp->n_outbuf += wsize;
 			hvc_push(hp);
+			rsize -= wsize;
+			p += wsize;
+			written += wsize;
 		}
 		spin_unlock_irqrestore(&hp->lock, flags);
+
+		if (rsize)
+			break;
+
+		if (count < tbsize)
+			tbsize = count;
+	}
+
+	kfree(tbuf);
+
+	return written;
+}
+
+static inline int __hvc_write_kernel(struct hvc_struct *hp,
+				   const unsigned char *buf, int count)
+{
+	unsigned long flags;
+	int rsize, written = 0;
+
+	spin_lock_irqsave(&hp->lock, flags);
+
+	/* Push pending writes */
+	if (hp->n_outbuf > 0)
+		hvc_push(hp);
+
+	while (count > 0 && (rsize = N_OUTBUF - hp->n_outbuf) > 0) {
+		if (rsize > count)
+			rsize = count;
+		memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
+		count -= rsize;
+		buf += rsize;
+		hp->n_outbuf += rsize;
+		written += rsize;
+		hvc_push(hp);
 	}
+	spin_unlock_irqrestore(&hp->lock, flags);
+
+	return written;
+}
+static int hvc_write(struct tty_struct *tty, int from_user,
+		     const unsigned char *buf, int count)
+{
+	struct hvc_struct *hp = tty->driver_data;
+	int written;
+
+	if (from_user)
+		written = __hvc_write_user(hp, buf, count);
+	else
+		written = __hvc_write_kernel(hp, buf, count);
+
+	/*
+	 * Racy, but harmless, kick thread if there is still pending data.
+	 * There really is nothing wrong with kicking the thread, even if there
+	 * is no buffered data.
+	 */
+	if (hp->n_outbuf)
+		hvc_kick();
 
 	return written;
 }
 
+/*
+ * This is actually a contract between the driver and the tty layer outlining
+ * how much write room the driver can guarentee will be sent OR BUFFERED.  This
+ * driver MUST honor the return value.
+ */
 static int hvc_write_room(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
+	unsigned long flags;
+	int retval;
 
-	return N_OUTBUF - hp->n_outbuf;
+	spin_lock_irqsave(&hp->lock, flags);
+	retval = N_OUTBUF - hp->n_outbuf;
+	spin_unlock_irqrestore(&hp->lock, flags);
+	return retval;
 }
 
 static int hvc_chars_in_buffer(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
+	unsigned long flags;
+	int retval;
 
-	return hp->n_outbuf;
+	spin_lock_irqsave(&hp->lock, flags);
+	retval = hp->n_outbuf;
+	spin_unlock_irqrestore(&hp->lock, flags);
+	return retval;
 }
 
-static void hvc_poll(int index)
+#define HVC_POLL_READ	0x00000001
+#define HVC_POLL_WRITE	0x00000002
+#define HVC_POLL_QUICK	0x00000004
+
+static int hvc_poll(struct hvc_struct *hp)
 {
-	struct hvc_struct *hp = &hvc_struct[index];
 	struct tty_struct *tty;
-	int i, n;
-	char buf[16] __ALIGNED__;
+	int i, n, poll_mask = 0;
+	char buf[N_INBUF] __ALIGNED__;
 	unsigned long flags;
+	int read_total = 0;
 
 	spin_lock_irqsave(&hp->lock, flags);
 
+	/* Push pending writes */
 	if (hp->n_outbuf > 0)
 		hvc_push(hp);
+	/* Reschedule us if still some write pending */
+	if (hp->n_outbuf > 0)
+		poll_mask |= HVC_POLL_WRITE;
 
+	/* No tty attached, just skip */
 	tty = hp->tty;
-	if (tty) {
-		for (;;) {
-			if (TTY_FLIPBUF_SIZE - tty->flip.count < sizeof(buf))
-				break;
-			n = hvc_get_chars(index + hvc_offset, buf, sizeof(buf));
-			if (n <= 0)
-				break;
-			for (i = 0; i < n; ++i) {
-#ifdef CONFIG_MAGIC_SYSRQ		/* Handle the SysRq Hack */
-				if (buf[i] == '\x0f') {	/* ^O -- should support a sequence */
-					sysrq_pressed = 1;
-					continue;
-				} else if (sysrq_pressed) {
-					handle_sysrq(buf[i], NULL, tty);
-					sysrq_pressed = 0;
-					continue;
-				}
-#endif
-				tty_insert_flip_char(tty, buf[i], 0);
+	if (tty == NULL)
+		goto bail;
+
+	/* Now check if we can get data (are we throttled ?) */
+	if (test_bit(TTY_THROTTLED, &tty->flags))
+		goto throttled;
+
+	/* If we aren't interrupt driven and aren't throttled, we always
+	 * request a reschedule
+	 */
+	if (hp->irq == NO_IRQ)
+		poll_mask |= HVC_POLL_READ;
+
+	/* Read data if any */
+	for (;;) {
+		int count = N_INBUF;
+		if (count > (TTY_FLIPBUF_SIZE - tty->flip.count))
+			count = TTY_FLIPBUF_SIZE - tty->flip.count;
+
+		/* If flip is full, just reschedule a later read */
+		if (count == 0) {
+			poll_mask |= HVC_POLL_READ;
+			break;
+		}
+		
+		n = hvc_get_chars(hp->vtermno, buf, count);
+		if (n <= 0) {
+			/* Hangup the tty when disconnected from host */
+			if (n == -EPIPE) {
+				spin_unlock_irqrestore(&hp->lock, flags);
+				tty_hangup(tty);
+				spin_lock_irqsave(&hp->lock, flags);
+			}
+			break;
+		}
+		for (i = 0; i < n; ++i) {
+#ifdef CONFIG_MAGIC_SYSRQ
+			/* Handle the SysRq Hack */
+			if (buf[i] == '\x0f') {	/* ^O -- should support a sequence */
+				sysrq_pressed = 1;
+				continue;
+			} else if (sysrq_pressed) {
+				handle_sysrq(buf[i], NULL, tty);
+				sysrq_pressed = 0;
+				continue;
 			}
+#endif /* CONFIG_MAGIC_SYSRQ */
+			tty_insert_flip_char(tty, buf[i], 0);
 		}
+
 		if (tty->flip.count)
 			tty_schedule_flip(tty);
 
-		if (hp->do_wakeup) {
-			hp->do_wakeup = 0;
-			if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
-			    && tty->ldisc.write_wakeup)
-				(tty->ldisc.write_wakeup)(tty);
-			wake_up_interruptible(&tty->write_wait);
+		/*
+		 * Account for the total amount read in one loop, and if above
+		 * 64 bytes, we do a quick schedule loop to let the tty grok the
+		 * data and eventually throttle us.
+		 */
+		read_total += n;
+		if (read_total >= 64) {
+			poll_mask |= HVC_POLL_QUICK;
+			break;
 		}
 	}
-
+ throttled:
+	/* Wakeup write queue if necessary */
+	if (hp->do_wakeup) {
+		hp->do_wakeup = 0;
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
+		    && tty->ldisc.write_wakeup)
+			(tty->ldisc.write_wakeup)(tty);
+		wake_up_interruptible(&tty->write_wait);
+	}
+ bail:
 	spin_unlock_irqrestore(&hp->lock, flags);
+
+	return poll_mask;
 }
 
 #if defined(CONFIG_XMON) && defined(CONFIG_SMP)
@@ -264,21 +558,47 @@
 static const cpumask_t cpus_in_xmon = CPU_MASK_NONE;
 #endif
 
-
+/*
+ * This kthread is either polling or interrupt driven.  This is determined by
+ * calling hvc_poll() who determines whether a console adapter support
+ * interrupts.
+ */
 int khvcd(void *unused)
 {
-	int i;
-
-	daemonize("khvcd");
+	int poll_mask;
+	struct hvc_struct *hp;
 
-	for (;;) {
+	__set_current_state(TASK_RUNNING);
+	do {
+		poll_mask = 0;
+		hvc_kicked = 0;
+		wmb();
 		if (cpus_empty(cpus_in_xmon)) {
-			for (i = 0; i < MAX_NR_HVC_CONSOLES; ++i)
-				hvc_poll(i);
+			spin_lock(&hvc_structs_lock);
+			list_for_each_entry(hp, &hvc_structs, next) {
+				/*hp = list_entry(node, struct hvc_struct, * next); */
+				poll_mask |= hvc_poll(hp);
+			}
+			spin_unlock(&hvc_structs_lock);
+		} else
+			poll_mask |= HVC_POLL_READ;
+		if (hvc_kicked)
+			continue;
+		if (poll_mask & HVC_POLL_QUICK) {
+			yield();
+			continue;
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(TIMEOUT);
-	}
+		if (!hvc_kicked) {
+			if (poll_mask == 0)
+				schedule();
+			else
+				schedule_timeout(TIMEOUT);
+		}
+		__set_current_state(TASK_RUNNING);
+	} while (!kthread_should_stop());
+
+	return 0;
 }
 
 static struct tty_operations hvc_ops = {
@@ -286,19 +606,124 @@
 	.close = hvc_close,
 	.write = hvc_write,
 	.hangup = hvc_hangup,
+	.unthrottle = hvc_unthrottle,
 	.write_room = hvc_write_room,
 	.chars_in_buffer = hvc_chars_in_buffer,
 };
 
-int __init hvc_init(void)
+char hvc_driver_name[] = "hvc_console";
+
+static struct vio_device_id hvc_driver_table[] __devinitdata= {
+	{"serial", "hvterm1"},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(vio, hvc_driver_table);
+
+/* callback when the kboject ref count reaches zero. */
+static void destroy_hvc_struct(struct kobject *kobj)
 {
-	int num = hvc_count(&hvc_offset);
-	int i;
+	struct hvc_struct *hp = container_of(kobj, struct hvc_struct, kobj);
+	unsigned long flags;
 
-	if (num > MAX_NR_HVC_CONSOLES)
-		num = MAX_NR_HVC_CONSOLES;
+	spin_lock(&hvc_structs_lock);
+
+	spin_lock_irqsave(&hp->lock, flags);
+	list_del(&(hp->next));
+	spin_unlock_irqrestore(&hp->lock, flags);
+
+	spin_unlock(&hvc_structs_lock);
+
+	kfree(hp);
+}
 
-	hvc_driver = alloc_tty_driver(num);
+static struct kobj_type hvc_kobj_type = {
+	.release = destroy_hvc_struct,
+};
+
+static int __devinit hvc_probe(
+		struct vio_dev *dev,
+		const struct vio_device_id *id)
+{
+	struct hvc_struct *hp;
+
+	/* probed with invalid parameters. */
+	if (!dev || !id)
+		return -EPERM;
+
+	hp = kmalloc(sizeof(*hp), GFP_KERNEL);
+	if (!hp)
+		return -ENOMEM;
+
+	memset(hp, 0x00, sizeof(*hp));
+	hp->vtermno = dev->unit_address;
+	hp->vdev = dev;
+	hp->vdev->dev.driver_data = hp;
+	hp->irq = dev->irq;
+
+	kobject_init(&hp->kobj);
+	hp->kobj.ktype = &hvc_kobj_type;
+
+	hp->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock(&hvc_structs_lock);
+	hp->index = ++hvc_count;
+	list_add_tail(&(hp->next), &hvc_structs);
+	spin_unlock(&hvc_structs_lock);
+
+	return 0;
+}
+
+static int __devexit hvc_remove(struct vio_dev *dev)
+{
+	struct hvc_struct *hp = dev->dev.driver_data;
+	unsigned long flags;
+	struct kobject *kobjp;
+	struct tty_struct *tty;
+
+	spin_lock_irqsave(&hp->lock, flags);
+	tty = hp->tty;
+	kobjp = &hp->kobj;
+
+	if (hp->index < MAX_NR_HVC_CONSOLES)
+		vtermnos[hp->index] = -1;
+
+	/* Don't whack hp->irq because tty_hangup() will need to free the irq. */
+
+	spin_unlock_irqrestore(&hp->lock, flags);
+
+	/*
+	 * We 'put' the instance that was grabbed when the kobject instance
+	 * was intialized using kobject_init().  Let the last holder of this
+	 * kobject cause it to be removed, which will probably be the tty_hangup
+	 * below.
+	 */
+	kobject_put(kobjp);
+
+	/*
+	 * This function call will auto chain call hvc_hangup.  The tty should
+	 * always be valid at this time unless a simultaneous tty close already
+	 * cleaned up the hvc_struct.
+	 */
+	if (tty)
+		tty_hangup(tty);
+	return 0;
+}
+
+static struct vio_driver hvc_vio_driver = {
+	.name		= hvc_driver_name,
+	.id_table	= hvc_driver_table,
+	.probe		= hvc_probe,
+	.remove		= hvc_remove,
+};
+
+/* Driver initialization.  Follow console initialization.  This is where the TTY
+ * interfaces start to become available. */
+int __init hvc_init(void)
+{
+	int rc;
+
+	/* We need more than num_vterms adapters due to hotplug additions. */
+	hvc_driver = alloc_tty_driver(HVC_ALLOC_TTY_ADAPTERS);
+	/* hvc_driver = alloc_tty_driver(num_vterms); */
 	if (!hvc_driver)
 		return -ENOMEM;
 
@@ -312,31 +737,73 @@
 	hvc_driver->init_termios = tty_std_termios;
 	hvc_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(hvc_driver, &hvc_ops);
-	for (i = 0; i < num; i++) {
-		hvc_struct[i].lock = SPIN_LOCK_UNLOCKED;
-		hvc_struct[i].index = i;
-	}
 
 	if (tty_register_driver(hvc_driver))
 		panic("Couldn't register hvc console driver\n");
 
-	if (num > 0)
-		kernel_thread(khvcd, NULL, CLONE_KERNEL);
+	/* Always start the kthread because there can be hotplug vty adapters
+	 * added later. */
+	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	if (IS_ERR(hvc_task)) {
+		panic("Couldn't create kthread for console.\n");
+		put_tty_driver(hvc_driver);
+		return -EIO;
+	}
 
-	return 0;
+	/* Register as a vio device to receive callbacks */
+	rc = vio_register_driver(&hvc_vio_driver);
+
+	return rc;
 }
 
+/* This isn't particularily necessary due to this being a console driver but it
+ * is nice to be thorough */
 static void __exit hvc_exit(void)
 {
+	kthread_stop(hvc_task);
+
+	vio_unregister_driver(&hvc_vio_driver);
+	tty_unregister_driver(hvc_driver);
+	/* return tty_struct instances allocated in hvc_init(). */
+	put_tty_driver(hvc_driver);
+}
+
+/*
+ * Console APIs, NOT TTY.  These APIs are available immediately when
+ * hvc_console_setup() finds adapters.
+ */
+
+/*
+ * hvc_instantiate() is an early console discovery method which locates consoles
+ * prior to the vio subsystem discovering them.  Hotplugged vty adapters do NOT
+ * get an hvc_instantiate() callback since the appear after early console init.
+ */
+int hvc_instantiate(uint32_t vtermno, int index)
+{
+	if (index < 0 || index >= MAX_NR_HVC_CONSOLES)
+		return -1;
+
+	if (vtermnos[index] != -1)
+		return -1;
+
+	vtermnos[index] = vtermno;
+	return 0;
 }
 
 void hvc_console_print(struct console *co, const char *b, unsigned count)
 {
 	char c[16] __ALIGNED__;
-	unsigned i, n;
+	unsigned i, n = 0;
 	int r, donecr = 0;
 
-	i = n = 0;
+	/* Console access attempt outside of acceptable console range. */
+	if (co->index >= MAX_NR_HVC_CONSOLES)
+		return;
+
+	/* This console adapter was removed so it is not useable. */
+	if (vtermnos[co->index] < 0)
+		return;
+
 	while (count > 0 || i > 0) {
 		if (count > 0 && i < sizeof(c)) {
 			if (b[n] == '\n' && !donecr) {
@@ -348,7 +815,7 @@
 				--count;
 			}
 		} else {
-			r = hvc_put_chars(co->index + hvc_offset, c, i);
+			r = hvc_put_chars(vtermnos[co->index], c, i);
 			if (r < 0) {
 				/* throw away chars on error */
 				i = 0;
@@ -369,9 +836,6 @@
 
 static int __init hvc_console_setup(struct console *co, char *options)
 {
-	if (co->index < 0 || co->index >= MAX_NR_HVC_CONSOLES
-	    || co->index >= hvc_count(&hvc_offset))
-		return -1;
 	return 0;
 }
 
@@ -384,8 +848,14 @@
 	.index		= -1,
 };
 
+/* Early console initialization.  Preceeds driver initialization. */
 static int __init hvc_console_init(void)
 {
+	int i;
+
+	for (i=0; i<MAX_NR_HVC_CONSOLES; i++)
+		vtermnos[i] = -1;
+	num_vterms = hvc_find_vtys();
 	register_console(&hvc_con_driver);
 	return 0;
 }

--=-J9h0F5dzflHDjIq+mpBb--

