Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWGJJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWGJJbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGJJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:31:21 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:19135 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932513AbWGJJbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:31:18 -0400
Subject: s390 update.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 10 Jul 2006 11:31:04 +0200
Message-Id: <1152523864.5834.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 drivers/s390/cio/cio.c       |    1 +
 drivers/s390/cio/cio.h       |    3 ++-
 drivers/s390/cio/css.c       |   24 +++++++++++++++++++++---
 drivers/s390/cio/css.h       |    2 ++
 drivers/s390/cio/device.c    |    6 +++---
 include/asm-s390/bug.h       |   11 ++++++++++-
 include/asm-s390/futex.h     |    5 +++--
 include/asm-s390/irqflags.h  |   18 ++++++++++++------
 include/asm-s390/processor.h |   16 +++++++---------
 include/asm-s390/setup.h     |    3 ++-
 10 files changed, 63 insertions(+), 26 deletions(-)

Cornelia Huck:
      [S390] subchannel register/unregister mutex.

Heiko Carstens:
      [S390] __builtin_trap() and gcc version.
      [S390] raw_local_save_flags/raw_local_irq_restore type check
      [S390] cpu_relax() is supposed to have barrier() semantics.

Martin Schwidefsky:
      [S390] fix futex_atomic_cmpxchg_inatomic

diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 6fec90e..f27b2b8 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -519,6 +519,7 @@ cio_validate_subchannel (struct subchann
 	memset(sch, 0, sizeof(struct subchannel));
 
 	spin_lock_init(&sch->lock);
+	mutex_init(&sch->reg_mutex);
 
 	/* Set a name for the subchannel */
 	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 0ca9873..4541c1a 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -2,6 +2,7 @@ #ifndef S390_CIO_H
 #define S390_CIO_H
 
 #include "schid.h"
+#include <linux/mutex.h>
 
 /*
  * where we put the ssd info
@@ -87,7 +88,7 @@ struct orb {
 struct subchannel {
 	struct subchannel_id schid;
 	spinlock_t lock;	/* subchannel lock */
-
+	struct mutex reg_mutex;
 	enum {
 		SUBCHANNEL_TYPE_IO = 0,
 		SUBCHANNEL_TYPE_CHSC = 1,
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 1d3be80..a09deea 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -108,6 +108,24 @@ css_subchannel_release(struct device *de
 
 extern int css_get_ssd_info(struct subchannel *sch);
 
+
+int css_sch_device_register(struct subchannel *sch)
+{
+	int ret;
+
+	mutex_lock(&sch->reg_mutex);
+	ret = device_register(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+	return ret;
+}
+
+void css_sch_device_unregister(struct subchannel *sch)
+{
+	mutex_lock(&sch->reg_mutex);
+	device_unregister(&sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+}
+
 static int
 css_register_subchannel(struct subchannel *sch)
 {
@@ -119,7 +137,7 @@ css_register_subchannel(struct subchanne
 	sch->dev.release = &css_subchannel_release;
 	
 	/* make it known to the system */
-	ret = device_register(&sch->dev);
+	ret = css_sch_device_register(sch);
 	if (ret)
 		printk (KERN_WARNING "%s: could not register %s\n",
 			__func__, sch->dev.bus_id);
@@ -250,7 +268,7 @@ css_evaluate_subchannel(struct subchanne
 		 * The device will be killed automatically.
 		 */
 		cio_disable_subchannel(sch);
-		device_unregister(&sch->dev);
+		css_sch_device_unregister(sch);
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
@@ -264,7 +282,7 @@ css_evaluate_subchannel(struct subchanne
 		 * away in any case.
 		 */
 		if (!disc) {
-			device_unregister(&sch->dev);
+			css_sch_device_unregister(sch);
 			/* Reset intparm to zeroes. */
 			sch->schib.pmcw.intparm = 0;
 			cio_modify(sch);
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index e210f89..15f7f7c 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -136,6 +136,8 @@ extern struct bus_type css_bus_type;
 extern struct css_driver io_subchannel_driver;
 
 extern int css_probe_device(struct subchannel_id);
+extern int css_sch_device_register(struct subchannel *);
+extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 67f0de6..9db0987 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -280,7 +280,7 @@ ccw_device_remove_disconnected(struct cc
 	 * 'throw away device'.
 	 */
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
@@ -625,7 +625,7 @@ ccw_device_do_unreg_rereg(void *data)
 					other_sch->schib.pmcw.intparm = 0;
 					cio_modify(other_sch);
 				}
-				device_unregister(&other_sch->dev);
+				css_sch_device_unregister(other_sch);
 			}
 		}
 		/* Update ssd info here. */
@@ -709,7 +709,7 @@ ccw_device_call_sch_unregister(void *dat
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
diff --git a/include/asm-s390/bug.h b/include/asm-s390/bug.h
index 7ddaa05..8768983 100644
--- a/include/asm-s390/bug.h
+++ b/include/asm-s390/bug.h
@@ -5,9 +5,18 @@ #include <linux/kernel.h>
 
 #ifdef CONFIG_BUG
 
+static inline __attribute__((noreturn)) void __do_illegal_op(void)
+{
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+	__builtin_trap();
+#else
+	asm volatile(".long 0");
+#endif
+}
+
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__builtin_trap(); \
+	__do_illegal_op(); \
 } while (0)
 
 #define HAVE_ARCH_BUG
diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
index 1802775..ffedf14 100644
--- a/include/asm-s390/futex.h
+++ b/include/asm-s390/futex.h
@@ -98,9 +98,10 @@ futex_atomic_cmpxchg_inatomic(int __user
 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
-	asm volatile("   cs   %1,%4,0(%5)\n"
+	asm volatile("   sacf 256\n"
+		     "   cs   %1,%4,0(%5)\n"
 		     "0: lr   %0,%1\n"
-		     "1:\n"
+		     "1: sacf 0\n"
 #ifndef __s390x__
 		     ".section __ex_table,\"a\"\n"
 		     "   .align 4\n"
diff --git a/include/asm-s390/irqflags.h b/include/asm-s390/irqflags.h
index 65f4db6..3b566a5 100644
--- a/include/asm-s390/irqflags.h
+++ b/include/asm-s390/irqflags.h
@@ -25,16 +25,22 @@ #define raw_local_irq_disable() ({ \
 	__flags; \
 	})
 
-#define raw_local_save_flags(x) \
-	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) )
-
-#define raw_local_irq_restore(x) \
-	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory")
+#define raw_local_save_flags(x)							\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) );	\
+} while (0)
+
+#define raw_local_irq_restore(x)						\
+do {										\
+	typecheck(unsigned long, x);						\
+	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory");	\
+} while (0)
 
 #define raw_irqs_disabled()		\
 ({					\
 	unsigned long flags;		\
-	local_save_flags(flags);	\
+	raw_local_save_flags(flags);	\
 	!((flags >> __FLAG_SHIFT) & 3);	\
 })
 
diff --git a/include/asm-s390/processor.h b/include/asm-s390/processor.h
index c5cbc4b..5b71d37 100644
--- a/include/asm-s390/processor.h
+++ b/include/asm-s390/processor.h
@@ -199,15 +199,13 @@ #define KSTK_ESP(tsk)	(task_pt_regs(tsk)
 /*
  * Give up the time slice of the virtual PU.
  */
-#ifndef __s390x__
-# define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
-#else /* __s390x__ */
-# define cpu_relax() \
-	do { \
-		if (MACHINE_HAS_DIAG44) \
-			asm volatile ("diag 0,0,68" : : : "memory"); \
-	} while (0)
-#endif /* __s390x__ */
+static inline void cpu_relax(void)
+{
+	if (MACHINE_HAS_DIAG44)
+		asm volatile ("diag 0,0,68" : : : "memory");
+	else
+		barrier();
+}
 
 /*
  * Set PSW to specified value.
diff --git a/include/asm-s390/setup.h b/include/asm-s390/setup.h
index da3fd4a..19e3197 100644
--- a/include/asm-s390/setup.h
+++ b/include/asm-s390/setup.h
@@ -40,15 +40,16 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_VM		(machine_flags & 1)
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
 
 #ifndef __s390x__
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
 #define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_DIAG44	(1)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
+#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 #endif /* __s390x__ */
 
 


