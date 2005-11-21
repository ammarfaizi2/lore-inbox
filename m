Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVKURsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVKURsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVKURsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:48:21 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26011 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932403AbVKURsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:48:20 -0500
Date: Mon, 21 Nov 2005 18:47:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: [patch 1/5] s390: atomic primitives.
Message-ID: <20051121174738.GA9638@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hugh Dickins <hugh@veritas.com>

[patch 1/5] s390: atomic primitives.

Fix the broken atomic_cmpxchg primitive. Add atomic_sub_and_test,
atomic64_sub_return, atomic64_sub_and_test, atomic64_cmpxchg,
atomic64_add_unless and atomic64_inc_not_zero. Replace old style
atomic_compare_and_swap by atomic_cmpxchg. Shorten the whole
header by defining most primitives with the two inline functions
atomic_add_return and atomic_sub_return.

In addition this patch contains the s390 related fixes of Hugh's
"mm: fill arch atomic64 gaps" patch.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/machine_kexec.c |    2 
 arch/s390/kernel/smp.c           |    6 -
 drivers/s390/block/dasd.c        |    4 
 drivers/s390/char/sclp_quiesce.c |    2 
 drivers/s390/char/tape_block.c   |    2 
 drivers/s390/cio/ccwgroup.c      |    6 -
 drivers/s390/cio/device.c        |    4 
 drivers/s390/net/iucv.c          |    8 -
 drivers/s390/net/qeth_main.c     |   26 ++---
 include/asm-s390/atomic.h        |  183 +++++++++++++++------------------------
 10 files changed, 104 insertions(+), 139 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/machine_kexec.c linux-2.6-patched/arch/s390/kernel/machine_kexec.c
--- linux-2.6/arch/s390/kernel/machine_kexec.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/machine_kexec.c	2005-11-21 18:40:03.000000000 +0100
@@ -85,7 +85,7 @@ kexec_halt_all_cpus(void *kernel_image)
 		pfault_fini();
 #endif
 
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
 		signal_processor(smp_processor_id(), sigp_stop);
 
 	/* Wait for all other cpus to enter stopped state */
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-11-21 18:39:34.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-11-21 18:40:03.000000000 +0100
@@ -263,7 +263,7 @@ static void do_machine_restart(void * __
 	int cpu;
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
 		signal_processor(smp_processor_id(), sigp_stop);
 
 	/* Wait for all other cpus to enter stopped state */
@@ -313,7 +313,7 @@ static void do_machine_halt(void * __unu
 {
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid) == 0) {
+	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) == -1) {
 		smp_send_stop();
 		if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
 			cpcmd(vmhalt_cmd, NULL, 0, NULL);
@@ -332,7 +332,7 @@ static void do_machine_power_off(void * 
 {
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid) == 0) {
+	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) == -1) {
 		smp_send_stop();
 		if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
 			cpcmd(vmpoff_cmd, NULL, 0, NULL);
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-11-21 18:40:03.000000000 +0100
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.167 $
+ * $Revision: 1.169 $
  */
 
 #include <linux/config.h>
@@ -1323,7 +1323,7 @@ void
 dasd_schedule_bh(struct dasd_device * device)
 {
 	/* Protect against rescheduling. */
-	if (atomic_compare_and_swap (0, 1, &device->tasklet_scheduled))
+	if (atomic_cmpxchg (&device->tasklet_scheduled, 0, 1) != 0)
 		return;
 	dasd_get_device(device);
 	tasklet_hi_schedule(&device->tasklet);
diff -urpN linux-2.6/drivers/s390/char/sclp_quiesce.c linux-2.6-patched/drivers/s390/char/sclp_quiesce.c
--- linux-2.6/drivers/s390/char/sclp_quiesce.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_quiesce.c	2005-11-21 18:40:03.000000000 +0100
@@ -32,7 +32,7 @@ do_load_quiesce_psw(void * __unused)
 	psw_t quiesce_psw;
 	int cpu;
 
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+	if (atomic_cmpxchg(&cpuid, -1, smp_processor_id()) != -1)
 		signal_processor(smp_processor_id(), sigp_stop);
 	/* Wait for all other cpus to enter stopped state */
 	for_each_online_cpu(cpu) {
diff -urpN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-patched/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_block.c	2005-11-21 18:40:03.000000000 +0100
@@ -65,7 +65,7 @@ static void
 tapeblock_trigger_requeue(struct tape_device *device)
 {
 	/* Protect against rescheduling. */
-	if (atomic_compare_and_swap(0, 1, &device->blk_data.requeue_scheduled))
+	if (atomic_cmpxchg(&device->blk_data.requeue_scheduled, 0, 1) != 0)
 		return;
 	schedule_work(&device->blk_data.requeue_task);
 }
diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2005-11-21 18:40:04.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.32 $
+ *   $Revision: 1.33 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -263,7 +263,7 @@ ccwgroup_set_online(struct ccwgroup_devi
 	struct ccwgroup_driver *gdrv;
 	int ret;
 
-	if (atomic_compare_and_swap(0, 1, &gdev->onoff))
+	if (atomic_cmpxchg(&gdev->onoff, 0, 1) != 0)
 		return -EAGAIN;
 	if (gdev->state == CCWGROUP_ONLINE) {
 		ret = 0;
@@ -289,7 +289,7 @@ ccwgroup_set_offline(struct ccwgroup_dev
 	struct ccwgroup_driver *gdrv;
 	int ret;
 
-	if (atomic_compare_and_swap(0, 1, &gdev->onoff))
+	if (atomic_cmpxchg(&gdev->onoff, 0, 1) != 0)
 		return -EAGAIN;
 	if (gdev->state == CCWGROUP_OFFLINE) {
 		ret = 0;
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-11-21 18:40:04.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.131 $
+ *   $Revision: 1.137 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -374,7 +374,7 @@ online_store (struct device *dev, struct
 	int i, force, ret;
 	char *tmp;
 
-	if (atomic_compare_and_swap(0, 1, &cdev->private->onoff))
+	if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
 		return -EAGAIN;
 
 	if (cdev->drv && !try_module_get(cdev->drv->owner)) {
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2005-11-21 18:40:04.000000000 +0100
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.45 2005/04/26 22:59:06 braunu Exp $
+ * $Id: iucv.c,v 1.47 2005/11/21 11:35:22 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.45 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.47 $
  *
  */
 
@@ -355,7 +355,7 @@ do { \
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.45 $";
+	char vbuf[] = "$Revision: 1.47 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -477,7 +477,7 @@ grab_param(void)
 		ptr++;
 		if (ptr >= iucv_param_pool + PARAM_POOL_SIZE)
 			ptr = iucv_param_pool;
-	} while (atomic_compare_and_swap(0, 1, &ptr->in_use));
+	} while (atomic_cmpxchg(&ptr->in_use, 0, 1) != 0);
 	hint = ptr - iucv_param_pool;
 
 	memset(&ptr->param, 0, sizeof(ptr->param));
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-11-21 18:39:42.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-11-21 18:40:04.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.242 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.248 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.242 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.248 $	 $Date: 2005/11/21 11:35:22 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.242 $"
+#define VERSION_QETH_C "$Revision: 1.248 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -1396,7 +1396,7 @@ qeth_idx_activate_get_answer(struct qeth
 	channel->ccw.cda = (__u32) __pa(iob->data);
 
 	wait_event(card->wait_q,
-		   atomic_compare_and_swap(0,1,&channel->irq_pending) == 0);
+		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(setup, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_start(channel->ccwdev,
@@ -1463,7 +1463,7 @@ qeth_idx_activate_channel(struct qeth_ch
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(iob->data), &temp, 2);
 
 	wait_event(card->wait_q,
-		   atomic_compare_and_swap(0,1,&channel->irq_pending) == 0);
+		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(setup, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	rc = ccw_device_start(channel->ccwdev,
@@ -1616,7 +1616,7 @@ qeth_issue_next_read(struct qeth_card *c
 	}
 	qeth_setup_ccw(&card->read, iob->data, QETH_BUFSIZE);
 	wait_event(card->wait_q,
-		   atomic_compare_and_swap(0,1,&card->read.irq_pending) == 0);
+		   atomic_cmpxchg(&card->read.irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(trace, 6, "noirqpnd");
 	rc = ccw_device_start(card->read.ccwdev, &card->read.ccw,
 			      (addr_t) iob, 0, 0);
@@ -1883,7 +1883,7 @@ qeth_send_control_data(struct qeth_card 
 	spin_unlock_irqrestore(&card->lock, flags);
 	QETH_DBF_HEX(control, 2, iob->data, QETH_DBF_CONTROL_LEN);
 	wait_event(card->wait_q,
-		   atomic_compare_and_swap(0,1,&card->write.irq_pending) == 0);
+		   atomic_cmpxchg(&card->write.irq_pending, 0, 1) == 0);
 	qeth_prepare_control_data(card, len, iob);
 	if (IS_IPA(iob->data))
 		timer.expires = jiffies + QETH_IPA_TIMEOUT;
@@ -1925,7 +1925,7 @@ qeth_osn_send_control_data(struct qeth_c
 	QETH_DBF_TEXT(trace, 5, "osndctrd");
 
 	wait_event(card->wait_q,
-		   atomic_compare_and_swap(0,1,&card->write.irq_pending) == 0);
+		   atomic_cmpxchg(&card->write.irq_pending, 0, 1) == 0);
 	qeth_prepare_control_data(card, len, iob);
 	QETH_DBF_TEXT(trace, 6, "osnoirqp");
 	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
@@ -4237,9 +4237,8 @@ qeth_do_send_packet_fast(struct qeth_car
 	QETH_DBF_TEXT(trace, 6, "dosndpfa");
 
 	/* spin until we get the queue ... */
-	while (atomic_compare_and_swap(QETH_OUT_Q_UNLOCKED,
-				       QETH_OUT_Q_LOCKED,
-				       &queue->state));
+	while (atomic_cmpxchg(&queue->state, QETH_OUT_Q_UNLOCKED,
+			      QETH_OUT_Q_LOCKED) != QETH_OUT_Q_UNLOCKED);
 	/* ... now we've got the queue */
 	index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
@@ -4293,9 +4292,8 @@ qeth_do_send_packet(struct qeth_card *ca
 	QETH_DBF_TEXT(trace, 6, "dosndpkt");
 
 	/* spin until we get the queue ... */
-	while (atomic_compare_and_swap(QETH_OUT_Q_UNLOCKED,
-				       QETH_OUT_Q_LOCKED,
-				       &queue->state));
+	while (atomic_cmpxchg(&queue->state, QETH_OUT_Q_UNLOCKED,
+			      QETH_OUT_Q_LOCKED) != QETH_OUT_Q_UNLOCKED);
 	start_index = queue->next_buf_to_fill;
 	buffer = &queue->bufs[queue->next_buf_to_fill];
 	/*
diff -urpN linux-2.6/include/asm-s390/atomic.h linux-2.6-patched/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	2005-11-21 18:39:53.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/atomic.h	2005-11-21 18:40:04.000000000 +0100
@@ -5,7 +5,7 @@
  *  include/asm-s390/atomic.h
  *
  *  S390 version
- *    Copyright (C) 1999-2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 1999-2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Denis Joseph Barrow,
  *		 Arnd Bergmann (arndb@de.ibm.com)
@@ -45,59 +45,57 @@ typedef struct {
 #define atomic_read(v)          ((v)->counter)
 #define atomic_set(v,i)         (((v)->counter) = (i))
 
-static __inline__ void atomic_add(int i, atomic_t * v)
-{
-	       __CS_LOOP(v, i, "ar");
-}
 static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
 	return __CS_LOOP(v, i, "ar");
 }
-static __inline__ int atomic_add_negative(int i, atomic_t * v)
-{
-	return __CS_LOOP(v, i, "ar") < 0;
-}
-static __inline__ void atomic_sub(int i, atomic_t * v)
-{
-	       __CS_LOOP(v, i, "sr");
-}
+#define atomic_add(_i, _v)		atomic_add_return(_i, _v)
+#define atomic_add_negative(_i, _v)	(atomic_add_return(_i, _v) < 0)
+#define atomic_inc(_v)			atomic_add_return(1, _v)
+#define atomic_inc_return(_v)		atomic_add_return(1, _v)
+#define atomic_inc_and_test(_v)		(atomic_add_return(1, _v) == 0)
+
 static __inline__ int atomic_sub_return(int i, atomic_t * v)
 {
 	return __CS_LOOP(v, i, "sr");
 }
-static __inline__ void atomic_inc(volatile atomic_t * v)
-{
-	       __CS_LOOP(v, 1, "ar");
-}
-static __inline__ int atomic_inc_return(volatile atomic_t * v)
-{
-	return __CS_LOOP(v, 1, "ar");
-}
+#define atomic_sub(_i, _v)		atomic_sub_return(_i, _v)
+#define atomic_sub_and_test(_i, _v)	(atomic_sub_return(_i, _v) == 0)
+#define atomic_dec(_v)			atomic_sub_return(1, _v)
+#define atomic_dec_return(_v)		atomic_sub_return(1, _v)
+#define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
-{
-	return __CS_LOOP(v, 1, "ar") == 0;
-}
-static __inline__ void atomic_dec(volatile atomic_t * v)
-{
-	       __CS_LOOP(v, 1, "sr");
-}
-static __inline__ int atomic_dec_return(volatile atomic_t * v)
-{
-	return __CS_LOOP(v, 1, "sr");
-}
-static __inline__ int atomic_dec_and_test(volatile atomic_t * v)
-{
-	return __CS_LOOP(v, 1, "sr") == 0;
-}
 static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t * v)
 {
 	       __CS_LOOP(v, ~mask, "nr");
 }
+
 static __inline__ void atomic_set_mask(unsigned long mask, atomic_t * v)
 {
 	       __CS_LOOP(v, mask, "or");
 }
+
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	__asm__ __volatile__("  cs   %0,%3,0(%2)\n"
+			     : "+d" (old), "=m" (v->counter)
+			     : "a" (v), "d" (new), "m" (v->counter)
+			     : "cc", "memory" );
+	return old;
+}
+
+static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int c, old;
+
+	c = atomic_read(v);
+	while (c != u && (old = atomic_cmpxchg(v, c, c + a)) != c)
+		c = old;
+	return c != u;
+}
+
+#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
+
 #undef __CS_LOOP
 
 #ifdef __s390x__
@@ -123,92 +121,61 @@ typedef struct {
 #define atomic64_read(v)          ((v)->counter)
 #define atomic64_set(v,i)         (((v)->counter) = (i))
 
-static __inline__ void atomic64_add(long long i, atomic64_t * v)
-{
-	       __CSG_LOOP(v, i, "agr");
-}
 static __inline__ long long atomic64_add_return(long long i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "agr");
 }
-static __inline__ long long atomic64_add_negative(long long i, atomic64_t * v)
-{
-	return __CSG_LOOP(v, i, "agr") < 0;
-}
-static __inline__ void atomic64_sub(long long i, atomic64_t * v)
-{
-	       __CSG_LOOP(v, i, "sgr");
-}
-static __inline__ void atomic64_inc(volatile atomic64_t * v)
-{
-	       __CSG_LOOP(v, 1, "agr");
-}
-static __inline__ long long atomic64_inc_return(volatile atomic64_t * v)
-{
-	return __CSG_LOOP(v, 1, "agr");
-}
-static __inline__ long long atomic64_inc_and_test(volatile atomic64_t * v)
-{
-	return __CSG_LOOP(v, 1, "agr") == 0;
-}
-static __inline__ void atomic64_dec(volatile atomic64_t * v)
-{
-	       __CSG_LOOP(v, 1, "sgr");
-}
-static __inline__ long long atomic64_dec_return(volatile atomic64_t * v)
-{
-	return __CSG_LOOP(v, 1, "sgr");
-}
-static __inline__ long long atomic64_dec_and_test(volatile atomic64_t * v)
-{
-	return __CSG_LOOP(v, 1, "sgr") == 0;
-}
+#define atomic64_add(_i, _v)		atomic64_add_return(_i, _v)
+#define atomic64_add_negative(_i, _v)	(atomic64_add_return(_i, _v) < 0)
+#define atomic64_inc(_v)		atomic64_add_return(1, _v)
+#define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
+#define atomic64_inc_and_test(_v)	(atomic64_add_return(1, _v) == 0)
+
+static __inline__ long long atomic64_sub_return(long long i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "sgr");
+}
+#define atomic64_sub(_i, _v)		atomic64_sub_return(_i, _v)
+#define atomic64_sub_and_test(_i, _v)	(atomic64_sub_return(_i, _v) == 0)
+#define atomic64_dec(_v)		atomic64_sub_return(1, _v)
+#define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
+#define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
+
 static __inline__ void atomic64_clear_mask(unsigned long mask, atomic64_t * v)
 {
 	       __CSG_LOOP(v, ~mask, "ngr");
 }
+
 static __inline__ void atomic64_set_mask(unsigned long mask, atomic64_t * v)
 {
 	       __CSG_LOOP(v, mask, "ogr");
 }
 
-#undef __CSG_LOOP
-#endif
+static __inline__ long long atomic64_cmpxchg(atomic64_t *v,
+					     long long old, long long new)
+{
+	__asm__ __volatile__("  csg  %0,%3,0(%2)\n"
+			     : "+d" (old), "=m" (v->counter)
+			     : "a" (v), "d" (new), "m" (v->counter)
+			     : "cc", "memory" );
+	return old;
+}
 
-/*
-  returns 0  if expected_oldval==value in *v ( swap was successful )
-  returns 1  if unsuccessful.
+static __inline__ int atomic64_add_unless(atomic64_t *v,
+					  long long a, long long u)
+{
+	long long c, old;
 
-  This is non-portable, use bitops or spinlocks instead!
-*/
-static __inline__ int
-atomic_compare_and_swap(int expected_oldval,int new_val,atomic_t *v)
-{
-        int retval;
-
-        __asm__ __volatile__(
-                "  lr   %0,%3\n"
-                "  cs   %0,%4,0(%2)\n"
-                "  ipm  %0\n"
-                "  srl  %0,28\n"
-                "0:"
-                : "=&d" (retval), "=m" (v->counter)
-                : "a" (v), "d" (expected_oldval) , "d" (new_val),
-		  "m" (v->counter) : "cc", "memory" );
-        return retval;
-}
-
-#define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
-
-#define atomic_add_unless(v, a, u)				\
-({								\
-	int c, old;						\
-	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
-		c = old;					\
-	c != (u);						\
-})
-#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
+	c = atomic64_read(v);
+	while (c != u && (old = atomic64_cmpxchg(v, c, c + a)) != c)
+		c = old;
+	return c != u;
+}
+
+#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+
+#undef __CSG_LOOP
+#endif
 
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
