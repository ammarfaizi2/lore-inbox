Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbSKSTGA>; Tue, 19 Nov 2002 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbSKSTGA>; Tue, 19 Nov 2002 14:06:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:49128 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267086AbSKSTF4>;
	Tue, 19 Nov 2002 14:05:56 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC960@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Peter Waechtler'" <pwaechtler@mac.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: Michal Wronski <wrona@mat.uni.torun.pl>, linux-kernel@vger.kernel.org,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: RE: [PATCH] unified SysV and POSIX mqueues - complete rewrite
Date: Tue, 19 Nov 2002 11:12:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C28FFF.AB8D45B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C28FFF.AB8D45B0
Content-Type: text/plain;
	charset="iso-8859-1"


> We could implement some kind of priority sorted waitqueue.
> I read about some prio aware waitqueue patch (from Ingo Molnar) used
> by a NGPT developer for the futexes (I.Gonzalez?)

I am just a contributor to NGPT ... what I did was to apply the
concept in Ingo's O(1) scheduling to the selection of tasks waiting
for the futex event.

> I thought about some waitqueue in the kernel, that at least put
> realtime processes at the front of the waitqueue.
> 
> It would be nice to have some generic mechanism in the kernel since
> only prio aware message read feature does not buy you much, IMHO

I did something like that also for the futexes [priority based futexes].
Check the attached patch vs. 2.5.45 [sorry for not inlining it, but I
am w/ Outlook now and it breaks it].

The nice next step would be to go ahead and create a breed of wait queues
that supported priority-based wake up, but there seemed to be not too
much interest; in any case, we'd need to come out with a sollution that
would not waste 2*sizeof(void*) * NUM_PRIO bytes per wait-queue, but
still being O(1) [and now that we are at asking, if somebody knows where
to buy a brand new Mercedes Benz C320 at 25%, pls email me]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


------_=_NextPart_000_01C28FFF.AB8D45B0
Content-Type: application/octet-stream;
	name="prioarray-2.5.45.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="prioarray-2.5.45.patch"

diff -u /dev/null include/linux/prioarray.h:1.1.2.1
--- /dev/null	Tue Nov 19 11:01:07 2002
+++ include/linux/prioarray.h	Tue Oct 15 15:17:29 2002
@@ -0,0 +1,57 @@
+/*
+ * O(1) priority arrays
+ *
+ * Modified from code (C) 2002 Ingo Molnar <mingo@redhat.com> in
+ * sched.c by I=F1aky P=E9rez-Gonz=E1lez =
<inaky.perez-gonzalez@intel.com> so
+ * that other parts of the kernel can use the same constructs.
+ */
+
+#ifndef _LINUX_PRIOARRAY_
+#define _LINUX_PRIOARRAY_
+
+        /* This inclusion is kind of recursive ... hmmm */
+
+#include <linux/sched.h>
+
+struct prio_array {
+	int nr_active;
+	unsigned long bitmap[BITMAP_SIZE];
+	struct list_head queue[MAX_PRIO];
+};
+
+typedef struct prio_array prio_array_t;
+
+static inline
+void pa_init (prio_array_t *array)
+{
+        unsigned cnt;
+	array->nr_active =3D 0;
+        memset (array->bitmap, 0, sizeof (array->bitmap));
+        for (cnt =3D 0; cnt < MAX_PRIO; cnt++)
+                INIT_LIST_HEAD (&array->queue[cnt]);
+}
+
+/*
+ * Adding/removing a node to/from a priority array:
+ */
+
+static inline
+void pa_dequeue (struct list_head *p, unsigned prio, prio_array_t =
*array)
+{
+	array->nr_active--;
+	list_del(p);
+	if (list_empty(array->queue + prio))
+		__clear_bit(prio, array->bitmap);
+}
+
+static inline
+void pa_enqueue (struct list_head *p, unsigned prio, prio_array_t =
*array)
+{
+	list_add_tail(p, array->queue + prio);
+	__set_bit(prio, array->bitmap);
+	array->nr_active++;
+}
+
+
+
+#endif /* #ifndef _LINUX_PRIOARRAY_ */

diff -u include/linux/sched.h:1.1.1.4 include/linux/sched.h:1.1.1.1.2.4
--- include/linux/sched.h:1.1.1.4	Thu Oct 31 15:28:29 2002
+++ include/linux/sched.h	Thu Oct 31 15:36:14 2002
@@ -241,6 +241,9 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
=20
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+
+#include <linux/prioarray.h> /* Okay, this is ugly, but needs MAX_PRIO =
*/
 =20
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -265,7 +268,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
=20
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
=20
 struct task_struct {

diff -u kernel/sched.c:1.1.1.3 kernel/sched.c:1.1.1.1.2.2
--- kernel/sched.c:1.1.1.3	Thu Oct 17 13:08:31 2002
+++ kernel/sched.c	Thu Oct 17 13:51:57 2002
@@ -129,15 +129,8 @@
  * These are the runqueue data structures:
  */
=20
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;
=20
-struct prio_array {
-	int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
-};
=20
 /*
  * This is the main, per-CPU runqueue data structure.
@@ -225,17 +218,12 @@
  */
 static inline void dequeue_task(struct task_struct *p, prio_array_t =
*array)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+        pa_dequeue (&p->run_list, p->prio, array);
 }
=20
 static inline void enqueue_task(struct task_struct *p, prio_array_t =
*array)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
+        pa_enqueue (&p->run_list, p->prio, array);
 	p->array =3D array;
 }
=20

------_=_NextPart_000_01C28FFF.AB8D45B0--
