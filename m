Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVCUHht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVCUHht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 02:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVCUHht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 02:37:49 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:32219 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S261644AbVCUHfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 02:35:46 -0500
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI handler message passing / work deferral API
Date: Sun, 20 Mar 2005 23:35:33 -0800
User-Agent: KMail/1.5.3
Cc: oprofile-list@lists.sourceforge.net, dsp@llnl.gov, dave_peterson@pobox.com
References: <200503202056.02429.dave_peterson@pobox.com>
In-Reply-To: <200503202056.02429.dave_peterson@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503202335.33976.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, one more try... This time my email client is set to "no word-wrap".
Now the patch should apply cleanly.  Sorry about the mistake...

Dave


diff -urNp -X dontdiff linux-2.6.11.5/arch/i386/defconfig linux-2.6.11.5-nmi/arch/i386/defconfig
--- linux-2.6.11.5/arch/i386/defconfig	2005-03-18 22:35:00.000000000 -0800
+++ linux-2.6.11.5-nmi/arch/i386/defconfig	2005-03-20 09:37:36.000000000 -0800
@@ -101,6 +101,7 @@ CONFIG_X86_TSC=y
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_NONFATAL=y
 CONFIG_X86_MCE_P4THERMAL=y
+# CONFIG_NMI_EXTENDED is not set
 # CONFIG_TOSHIBA is not set
 # CONFIG_I8K is not set
 # CONFIG_MICROCODE is not set
diff -urNp -X dontdiff linux-2.6.11.5/arch/i386/Kconfig linux-2.6.11.5-nmi/arch/i386/Kconfig
--- linux-2.6.11.5/arch/i386/Kconfig	2005-03-18 22:34:52.000000000 -0800
+++ linux-2.6.11.5-nmi/arch/i386/Kconfig	2005-03-20 09:37:36.000000000 -0800
@@ -610,6 +610,13 @@ config X86_MCE_P4THERMAL
 	  Enabling this feature will cause a message to be printed when the P4
 	  enters thermal throttling.
 
+config NMI_EXTENDED
+	bool "Extended support for NMI handlers (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This option provides a few things that facilitate writing kernel
+	  modules that handle NMIs (nonmaskable interrupts).
+
 config TOSHIBA
 	tristate "Toshiba Laptop support"
 	---help---
diff -urNp -X dontdiff linux-2.6.11.5/arch/x86_64/defconfig linux-2.6.11.5-nmi/arch/x86_64/defconfig
--- linux-2.6.11.5/arch/x86_64/defconfig	2005-03-18 22:35:00.000000000 -0800
+++ linux-2.6.11.5-nmi/arch/x86_64/defconfig	2005-03-20 09:37:36.000000000 -0800
@@ -93,6 +93,7 @@ CONFIG_GART_IOMMU=y
 CONFIG_SWIOTLB=y
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_INTEL=y
+# CONFIG_NMI_EXTENDED is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 
diff -urNp -X dontdiff linux-2.6.11.5/arch/x86_64/Kconfig linux-2.6.11.5-nmi/arch/x86_64/Kconfig
--- linux-2.6.11.5/arch/x86_64/Kconfig	2005-03-18 22:35:01.000000000 -0800
+++ linux-2.6.11.5-nmi/arch/x86_64/Kconfig	2005-03-20 09:37:36.000000000 -0800
@@ -350,6 +350,14 @@ config X86_MCE_INTEL
 	help
 	   Additional support for intel specific MCE features such as
 	   the thermal monitor.
+
+config NMI_EXTENDED
+	bool "Extended support for NMI handlers (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This option provides a few things that facilitate writing kernel
+	  modules that handle NMIs (nonmaskable interrupts).
+
 endmenu
 
 #
diff -urNp -X dontdiff linux-2.6.11.5/include/linux/nmi.h linux-2.6.11.5-nmi/include/linux/nmi.h
--- linux-2.6.11.5/include/linux/nmi.h	2005-03-18 22:34:49.000000000 -0800
+++ linux-2.6.11.5-nmi/include/linux/nmi.h	2005-03-20 19:45:58.420053288 -0800
@@ -1,10 +1,20 @@
 /*
  *  linux/include/linux/nmi.h
+ *
+ *  NMI producer/consumer, message queue, and defer callback implementations:
+ *      Copyright (C) 2005  The Regents of the University of California.
+ *      Produced at the Lawrence Livermore National Laboratory.
+ *      Written by David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>.
+ *      All rights reserved.
+ *      See preamble notice and terms and conditions in kernel/nmi.c.
  */
 #ifndef LINUX_NMI_H
 #define LINUX_NMI_H
 
+#include <linux/percpu.h>
+#include <linux/list.h>
 #include <asm/irq.h>
+#include <asm/system.h>
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
@@ -19,4 +29,195 @@ extern void touch_nmi_watchdog(void);
 # define touch_nmi_watchdog() do { } while(0)
 #endif
 
+#ifdef CONFIG_NMI_EXTENDED
+
+/* NMI producer/consumer interface.  This is a bare-bones mechanism for
+ * passing information from NMI handlers to other parts of the kernel in a
+ * manner that is free from deadlocks and race conditions.  For most purposes
+ * you will probably want to use the NMI message queue interface rather than
+ * directly accessing the producer/consumer mechanism.
+ */
+
+/* NMI producer/consumer data structure.  For SMP safety, use one of these for
+ * each CPU and be sure preemption is disabled before accessing.
+ */
+typedef struct {
+	/* containers for info to be passed fromm NMI handler */
+	void *container[2];
+
+	/* boolean flags are set if containers are not empty */
+	volatile int has_items[2];
+
+	int active_container_nr;  /* container for NMI handler to use */
+} nmi_producer_consumer_t;
+
+/* Initialize an nmi_producer_consumer_t object.  container0 and container1
+ * point to a pair of containers for storing the information we wish to
+ * transfer from the NMI handler.
+ */
+static inline void nmi_producer_consumer_init
+		(nmi_producer_consumer_t *p, void *container0,
+		 void *container1)
+{
+	p->container[0] = container0;
+	p->container[1] = container1;
+	p->has_items[0] = 0;
+	p->has_items[1] = 0;
+	p->active_container_nr = 0;
+}
+
+/* The producer (NMI handler) calls this function to obtain a container to
+ * place items in.  The function returns a pointer to the container to use.
+ */
+static inline void * nmi_producer_start_put (nmi_producer_consumer_t *p)
+{
+	int n;
+
+	n = p->active_container_nr;
+	p->has_items[n] = 1;  /* because we are about to add items */
+	return p->container[n];
+}
+
+/* The consumer (code that does --not-- execute at NMI time) calls this
+ * function to obtain a container to empty.  The function returns a pointer
+ * to the container to empty.
+ */
+static inline void * nmi_consumer_start_get (nmi_producer_consumer_t *p)
+{
+	int n;
+
+	/* NMI handler is currently placing items in this container. */
+	n = p->active_container_nr;
+
+	/* Tell NMI handler to start using other container.  Then we may
+	 * safely access this container.
+	 */
+	p->active_container_nr = !n;
+	barrier();
+
+	/* because we are about to empty this container */
+	p->has_items[n] = 0;
+
+	return p->container[n];
+}
+
+/* The consumer (code that does --not-- execute at NMI time) calls this
+ * function to see if any items are available to be consumed.
+ */
+static inline int nmi_consumer_check (const nmi_producer_consumer_t *p)
+{
+	return p->has_items[p->active_container_nr];
+}
+
+/* NMI message queue interface.  This is built on top of the above NMI
+ * producer/consumer interface.  It implements message queue send/receive
+ * semantics and handles the details of maintaining a set of free message
+ * buffers for allocation by NMI handler code.  This should be sufficient for
+ * the great majority of uses.  If it is not suitable for your needs, you may
+ * build your own message passing mechanism on top of the NMI
+ * producer/consumer interface.
+ */
+
+/* A message buffer for tranferring information from NMI handler code. */
+typedef struct {
+	struct list_head link;
+	void *data;  /* pointer to user-defined data */
+} nmi_msgbuf_t;
+
+/* Used internally by NMI message queue mechanism.  Do not access this
+ * directly.
+ */
+typedef struct {
+	struct list_head head;
+	unsigned nr_items;
+} nmi_msgbuf_freelist_t;
+
+/* NMI message queue data structure.  For SMP safety, use one of these for
+ * each CPU and be sure preemption is disabled before accessing.
+ */
+typedef struct {
+	/* message buffers that NMI handler has queued for delivery */
+	nmi_producer_consumer_t queue;
+	struct list_head qpair[2];
+
+	/* free message buffers for allocation by NMI handler */
+	nmi_msgbuf_freelist_t freelists[2];
+	int filling;
+	int filling_which;
+} nmi_msgqueue_t;
+
+void nmi_msgqueue_init (nmi_msgqueue_t *q);
+void nmi_msgqueue_send (nmi_msgqueue_t *q, nmi_msgbuf_t *msg);
+void nmi_msgqueue_receive (nmi_msgqueue_t *q, struct list_head *list);
+nmi_msgbuf_t * nmi_msgqueue_getbuf (nmi_msgqueue_t *q);
+void nmi_msgqueue_putbuf (nmi_msgqueue_t *q, nmi_msgbuf_t *buf);
+
+/* The receiver (code that does --not-- execute at NMI time) calls this
+ * function to see if any messages are queued for delivery from the NMI
+ * handler on the calling CPU.
+ */
+static inline int nmi_msgqueue_check (const nmi_msgqueue_t *q)
+{
+	return nmi_consumer_check(&q->queue);
+}
+
+/* nmi_defer_callback_t structures represent callbacks to be scheduled by NMI
+ * handler code.  An NMI handler may schedule a callback onto an
+ * nmi_defer_callback_list_t by calling nmi_defer_callback_set().  The
+ * callback will then execute when code executing outside NMI context invokes
+ * __do_nmi_defer_callbacks() for the list that the callback was scheduled
+ * onto.  Deferring work from NMI handlers in this manner is a means of
+ * avoiding deadlocks and race conditions.
+ *
+ * For SMP safety, nmi_defer_callback_t and nmi_defer_callback_list_t
+ * structures must be used on a per-CPU basis.
+ */
+
+typedef void (*nmi_defer_callback_fn_t) (void *data);
+
+typedef struct {
+	struct list_head link;
+	nmi_defer_callback_fn_t fn;
+	void *data;  /* parameter passed to callback function */
+	int pending;
+} nmi_defer_callback_t;
+
+typedef struct {
+	nmi_producer_consumer_t list;
+	struct list_head listpair[2];
+	int pending;
+} nmi_defer_callback_list_t;
+
+void init_nmi_defer_callback_list (nmi_defer_callback_list_t *list);
+void nmi_defer_callback_set (nmi_defer_callback_list_t *list,
+		nmi_defer_callback_t *callback);
+void __do_nmi_defer_callbacks (nmi_defer_callback_list_t *list);
+
+static inline void init_nmi_defer_callback (nmi_defer_callback_t *callback,
+		nmi_defer_callback_fn_t fn, void *data)
+{
+	callback->fn = fn;
+	callback->data = data;
+	callback->pending = 0;
+	INIT_LIST_HEAD(&callback->link);
+}
+
+/* Return 1 if list contains at least one pending callback.  Else return 0. */
+static inline int nmi_defer_callback_pending
+		(const nmi_defer_callback_list_t *list)
+{
+	return list->pending;
+}
+
+/* Code executing outside NMI context calls this to execute any pending
+ * callbacks.
+ */
+static inline void do_nmi_defer_callbacks (nmi_defer_callback_list_t *list)
+{
+	if (nmi_defer_callback_pending(list))
+		__do_nmi_defer_callbacks(list);
+}
+
+#endif /* CONFIG_NMI_EXTENDED */
+
 #endif
diff -urNp -X dontdiff linux-2.6.11.5/kernel/Makefile linux-2.6.11.5-nmi/kernel/Makefile
--- linux-2.6.11.5/kernel/Makefile	2005-03-18 22:34:53.000000000 -0800
+++ linux-2.6.11.5-nmi/kernel/Makefile	2005-03-20 09:37:36.457195000 -0800
@@ -26,6 +26,7 @@ obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_NMI_EXTENDED) += nmi.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urNp -X dontdiff linux-2.6.11.5/kernel/nmi.c linux-2.6.11.5-nmi/kernel/nmi.c
--- linux-2.6.11.5/kernel/nmi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11.5-nmi/kernel/nmi.c	2005-03-20 17:06:42.328799976 -0800
@@ -0,0 +1,342 @@
+/*
+ * linux/kernel/nmi.c
+ *
+ * Copyright (C) 2005  The Regents of the University of California.
+ * Produced at the Lawrence Livermore National Laboratory.
+ * Written by David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>.
+ * UCRL-CODE-155961
+ * All rights reserved.
+ *
+ * Our Preamble Notice
+ * -------------------
+ * A.  This notice is required to be provided under our contract with the U.S.
+ *     Department of Energy (DOE).  This work was produced at the University
+ *     of California, Lawrence Livermore National Laboratory under Contract
+ *     No. W-7405-ENG-48 with the DOE.
+ *
+ * B.  Neither the United States Government nor the University of California
+ *     nor any of their employees, makes any warranty, express or implied, or
+ *     assumes any liability or responsibility for the accuracy, completeness,
+ *     or usefulness of any information, apparatus, product, or process
+ *     disclosed, or represents that its use would not infringe
+ *     privately-owned rights.
+ *
+ * C.  Also, reference herein to any specific commercial products, process, or
+ *     services by trade name, trademark, manufacturer or otherwise does not
+ *     necessarily constitute or imply its endorsement, recommendation, or
+ *     favoring by the United States Government or the University of
+ *     California.  The views and opinions of authors expressed herein do not
+ *     necessarily state or reflect those of the United States Government or
+ *     the University of California, and shall not be used for advertising or
+ *     product endorsement purposes.  The precise terms and conditions for
+ *     copying, distribution and modification follows.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ * 1. Redistributions of source code must retain the above copyright notice,
+ *    this list of conditions, and the entire permission notice, including
+ *    the above preamble.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions, and the entire permission notice,
+ *    including the above preamble in the documentation and/or other
+ *    materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * ALTERNATIVELY, this product may be distributed under the terms of the GNU
+ * General Public License, in which case the provisions of the GPL are
+ * required INSTEAD OF the above restrictions.  (This clause is necessary due
+ * to a potential bad interaction between the GPL and the restrictions
+ * contained in a BSD-style copyright.)
+ *
+ * GNU Terms and Conditions for Copying, Distribution, and Modification
+ * --------------------------------------------------------------------
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/nmi.h>
+
+void nmi_msgqueue_init (nmi_msgqueue_t *q)
+{
+	INIT_LIST_HEAD(&q->qpair[0]);
+	INIT_LIST_HEAD(&q->qpair[1]);
+	nmi_producer_consumer_init(&q->queue, &q->qpair[0], &q->qpair[1]);
+	INIT_LIST_HEAD(&q->freelists[0].head);
+	q->freelists[0].nr_items = 0;
+	INIT_LIST_HEAD(&q->freelists[1].head);
+	q->freelists[1].nr_items = 0;
+	q->filling = 0;
+	q->filling_which = 0;
+}
+
+EXPORT_SYMBOL(nmi_msgqueue_init);
+
+/* The NMI handler calls this function to queue a message buffer for
+ * delivery to the receiver (code that does --not-- execute at NMI time).
+ */
+void nmi_msgqueue_send (nmi_msgqueue_t *q, nmi_msgbuf_t *msg)
+{
+	list_add_tail(&msg->link,
+		(struct list_head *) nmi_producer_start_put(&q->queue));
+}
+
+EXPORT_SYMBOL(nmi_msgqueue_send);
+
+/* The receiver (code that does --not-- execute at NMI time) calls this
+ * function to receive a list of all messages currently queued for delivery
+ * from the NMI handler on the calling CPU.  It is assumed that list has been
+ * initialized by caller.
+ */
+void nmi_msgqueue_receive (nmi_msgqueue_t *q, struct list_head *list)
+{
+	list_splice_init(
+		(struct list_head *) nmi_consumer_start_get(&q->queue), list);
+}
+
+EXPORT_SYMBOL(nmi_msgqueue_receive);
+
+static nmi_msgbuf_t * freelist_getbuf (nmi_msgbuf_freelist_t *list)
+{
+	struct list_head *item;
+
+	/* The NMI handler should be provided with enough free buffers so that
+	 * this will not happen in practice.
+	 */
+	if (unlikely(list_empty(&list->head)))
+		return NULL;
+
+	BUG_ON(list->nr_items == 0);
+	item = list->head.next;
+	list_del(item);
+	list->nr_items--;
+	return list_entry(item, nmi_msgbuf_t, link);
+}
+
+static inline void freelist_putbuf (nmi_msgbuf_freelist_t *list,
+				    nmi_msgbuf_t *buf)
+{
+	list_add(&buf->link, &list->head);
+	list->nr_items++;
+}
+
+/* The NMI handler calls this function to allocate a message buffer for
+ * sending to the receiver.  Return a pointer to the newly allocated buffer
+ * or NULL on allocation failure.
+ */
+nmi_msgbuf_t * nmi_msgqueue_getbuf (nmi_msgqueue_t *q)
+{
+	nmi_msgbuf_freelist_t *shorter, *longer;
+	int list1_shorter;
+	nmi_msgbuf_t *buf;
+
+	/* If the receiver is currently adding a buffer to a freelist, we must
+	 * allocate from the other list.  Since the receiver always adds to
+	 * the shorter list, we end up allocating from the longer list.  To
+	 * avoid starvation, this is exactly what we want.  Due to the way we
+	 * manage the freelists, the longer list will almost always contain
+	 * essentially all of the free buffers.
+	 */
+	if (unlikely(q->filling))
+		return freelist_getbuf(&q->freelists[!q->filling_which]);
+
+	/* If we get this far, we may safely access both lists.  Unless the
+	 * shorter list is empty, allocate from the shorter list.  If both
+	 * lists have equal length, we consider list 0 to be "shorter".
+	 * This must match the behavior of nmi_msgqueue_putbuf().  Otherwise
+	 * the following situation could occur:
+	 *
+	 *     1.  The receiver finds both lists to be equal in length and
+	 *         chooses list 0 as the one it will add a free buffer to.
+	 *     2.  Before the receiver sets q->filling to 1, an NMI occurs and
+	 *         the NMI handler allocates buffers from list 1.
+	 *     3.  The receiver sets q->filling to 1 and starts filling
+	 *         list 0 (which is now the longer list).
+	 *     4.  While the receiver is filling list 0, another NMI occurs.
+	 *         The NMI handler is forced to allocate from list 1.  Since
+	 *         list 1 is now the shorter list, this behavior is
+	 *         suboptimal.
+	 */
+	list1_shorter = (q->freelists[1].nr_items < q->freelists[0].nr_items);
+	shorter = &q->freelists[list1_shorter];
+	longer = &q->freelists[!list1_shorter];
+	buf = freelist_getbuf(shorter->nr_items ? shorter : longer);
+
+	/* Move all remaining buffers on the shorter list to the longer list.
+	 * Note that if we moved all buffers on the longer list to the shorter
+	 * list, the above-mentioned behavior could occur.  In this case the
+	 * result would be allocation failure when there are plenty of free
+	 * buffers.
+	 *
+	 * Calls to nmi_msgqueue_putbuf() will tend to balance the lists by
+	 * always adding buffers to the shorter list.  Here we unbalance the
+	 * lists so more buffers will be available if an NMI occurs while a
+	 * buffer is being freed (added to the shorter list).
+	 */
+	list_splice_init(&shorter->head, &longer->head);
+	longer->nr_items += shorter->nr_items;
+	shorter->nr_items = 0;
+
+	return buf;
+}
+
+EXPORT_SYMBOL(nmi_msgqueue_getbuf);
+
+/* The receiver (code that does --not-- execute at NMI time) calls this
+ * function to add a message buffer to the freelists.  By repeatedly calling
+ * this function at boot time or module initialization time, the receiver may
+ * prime the message queue with enough free buffers so that allocation
+ * failure in the NMI handler is highly unlikely.  After receiving a message
+ * buffer, the receiver may call this function to recycle the buffer so that
+ * plenty of free buffers are always available.
+ */
+void nmi_msgqueue_putbuf (nmi_msgqueue_t *q, nmi_msgbuf_t *buf)
+{
+	nmi_msgbuf_freelist_t *list;
+	int filling_which;
+
+	/* Add the buffer to the shorter list.  If an NMI occurs while we are
+	 * adding the buffer, the NMI handler will be forced to use the longer
+	 * list.
+	 *
+	 * While we are comparing the two values below, the NMI handler
+	 * may modify one or both of them.  Because of the way
+	 * nmi_msgqueue_getbuf() is implemented, interference from the NMI
+	 * handler will cause us to overestimate the length of the shorter
+	 * list and underestimate the length of the longer list.  Therefore we
+	 * will never choose the longer list by mistake.  Here we assume that
+	 * reading a single unsigned int is atomic on all architectures.
+	 *
+	 * The way the comparison below is written, we will choose list 0 as
+	 * the "shorter" list if both lists are equal in length.  This must
+	 * match the behavior of nmi_msgqueue_getbuf().  See comments in
+	 * nmi_msgqueue_getbuf().
+	 */
+	filling_which = (q->freelists[1].nr_items < q->freelists[0].nr_items);
+	list = &q->freelists[filling_which];
+
+	BUG_ON(q->filling);
+
+	/* By setting q->filling to 1, we tell the NMI handler that we are
+	 * filling the freelist indicated by q->filling_which.  Then the NMI
+	 * handler knows it must allocate buffers from the other freelist.
+	 * The NMI handler must see a value of 1 in q->filling AFTER we have
+	 * set q->filling_which and BEFORE we start freeing the buffer.
+	 * The NMI handler must not see a value of 0 in q->filling until AFTER
+	 * we are finished freeing the buffer.
+	 */
+	q->filling_which = filling_which;
+	barrier();
+	q->filling = 1;
+	barrier();
+	freelist_putbuf(list, buf);
+	barrier();
+	q->filling = 0;
+}
+
+EXPORT_SYMBOL(nmi_msgqueue_putbuf);
+
+void init_nmi_defer_callback_list (nmi_defer_callback_list_t *list)
+{
+	INIT_LIST_HEAD(&list->listpair[0]);
+	INIT_LIST_HEAD(&list->listpair[1]);
+	nmi_producer_consumer_init(&list->list, &list->listpair[0],
+			&list->listpair[1]);
+	list->pending = 0;
+}
+
+EXPORT_SYMBOL(init_nmi_defer_callback_list);
+
+/* NMI handlers call this to schedule a callback for execution outside NMI
+ * context.  The callback will execute when code executing outside NMI context
+ * invokes __do_nmi_defer_callbacks() for the list that the callback was
+ * scheduled onto.
+ */
+void nmi_defer_callback_set (nmi_defer_callback_list_t *list,
+		nmi_defer_callback_t *callback)
+{
+	if (callback->pending)
+		return;
+
+	callback->pending = 1;
+	list_add_tail(&callback->link,
+		(struct list_head *) nmi_producer_start_put(&list->list));
+	list->pending = 1;
+}
+
+EXPORT_SYMBOL(nmi_defer_callback_set);
+
+/* Execute a list of callbacks that were scheduled by NMI handler code.  Must
+ * be called outside NMI context on the same CPU that the callbacks were
+ * scheduled on.  If both (maskable) interrupt handler code and base-level
+ * code may invoke this function on a given list, then the caller must handle
+ * the necessary synchronization (i.e. disabling interrupts around calls to
+ * this function).
+ */
+void __do_nmi_defer_callbacks (nmi_defer_callback_list_t *list)
+{
+	struct list_head head, *item;
+	nmi_defer_callback_t *callback;
+
+	/* We must clear this flag BEFORE we get the list of pending
+	 * callbacks.  If we cleared it afterwards, then the following problem
+	 * could occur:
+	 *
+	 *     1.  We get the list of pending callbacks.
+	 *     2.  An NMI handler queues a callback and sets the flag.
+	 *     3.  We clear the flag.  Now the newly queued callback will be
+	 *         delayed indefinitely.
+	 */
+	list->pending = 0;
+	barrier();
+
+	INIT_LIST_HEAD(&head);
+	list_splice_init(
+		(struct list_head *) nmi_consumer_start_get(&list->list),
+		&head);
+
+	/* Here we can not assume that the list is nonempty.  This is because
+	 * an NMI handler may schedule a callback after we clear list->pending
+	 * and before we call nmi_consumer_start_get() above.
+	 */
+	while (!list_empty(&head)) {
+		item = head.next;
+		list_del(item);
+		callback = list_entry(item, nmi_defer_callback_t, link);
+
+		/* We must clear the pending flag AFTER removing the callback
+		 * from the list.  Otherwise an NMI handler could requeue the
+		 * callback while it is still on the list.
+		 *
+		 * We must clear the pending flag BEFORE executing the
+		 * callback.  Otherwise an NMI handler could call
+		 * nmi_defer_callback_set() after we execute the callback and
+		 * before we clear the flag.  Then the callback would not be
+		 * scheduled.
+		 */
+		barrier();
+		callback->pending = 0;
+		barrier();
+		callback->fn(callback->data);
+	}
+}
+
+EXPORT_SYMBOL(__do_nmi_defer_callbacks);
