Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVJFNMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVJFNMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJFNMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:12:32 -0400
Received: from 83-103-88-29.ip.fastwebnet.it ([83.103.88.29]:60106 "EHLO
	maruska.ath.cx") by vger.kernel.org with ESMTP id S1750873AbVJFNMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:12:32 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.14-rc3] evded: timestamping with monotonic time (+
 configuration ioctl)
X-Archive: encrypt
From: mmc@maruska.dyndns.org (Michal =?iso-8859-2?q?Maru=B9ka?=)
Date: Thu, 06 Oct 2005 14:50:10 +0200
Message-ID: <m2slveyflp.fsf@linux11.maruska.tin.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For my modification of XFree86 keyboard event handling I need to detect *duration*
of key presses, i.e. difference in time between 2 input events.

Evdev, in current version, timestamps each event with do_gettimeofday(). In
presence of adjustements to timeofday the difference/duration information is
damaged.

I would like to read the events timestamped with
do_posix_clock_monotonic_gettime() time.

I have prepared a patch, which provides an IOCTL call with which a reader can
request this monotonic timestamp. The default behaviour remains unchanged (I
think useless).


What i am not sure about:

* evdev builds as module, so do_posix_clock_monotonic_gettime is needed
exported... so my patch adds
EXPORT_SYMBOL_GPL(do_posix_clock_monotonic_gettime) in kernel/posix-timers.c.

*  _IOW macro to declare the ioctl number
 I took just a successor of the highest pre-existant number.


* I don't know how interrupt handlers preempt one another. So, in my attempt to
  attain the most precise timestamp, I would like the interrupt routine to ask
  for the timestamp as soon as possible. I could prepare another patch, which
  adds to each "struct input_dev" a slot where the timestamp is stored at the
  beginning of the interrupt routine.  Evdev then uses such timestamp, if the
  lower-level driver provides it.


Signed-off-by: Michal Maruska <mmc@maruska.dyndns.org> 

--- linux-2.6.14-rc3.orig/drivers/input/evdev.c	2005-10-05 22:47:40.000000000 +0200
+++ linux-2.6.14-rc3.mmc/drivers/input/evdev.c	2005-10-06 14:27:16.084510018 +0200
@@ -38,6 +38,7 @@
 	struct input_event buffer[EVDEV_BUFFER_SIZE];
 	int head;
 	int tail;
+        int time_kind;      /* which time to use for the timestamps. Monotonic or timeofday */
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -45,15 +46,37 @@
 
 static struct evdev *evdev_table[EVDEV_MINORS];
 
+static inline
+void 
+mem_copy_time(struct timeval *a, struct timeval* b)
+{
+        memcpy(a, b, sizeof(struct timeval));
+}
+
 static void evdev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
+        struct timeval mtv, dtv;
+        /* `do_posix_clock_monotonic_gettime' delivers a different struct,
+         * but i do the conversion immediately, and once. */
+        struct timespec mts;
+        
+        do_posix_clock_monotonic_gettime(&mts);
+        mtv.tv_sec = mts.tv_sec;
+        mtv.tv_usec = mts.tv_nsec / 1000; /* should I >> 10 ? */
+        
+        do_gettimeofday(&dtv);         /* for backward compatibility: */
+
 	if (evdev->grab) {
 		list = evdev->grab;
 
-		do_gettimeofday(&list->buffer[list->head].time);
+                if (list->time_kind == EV_USE_DAY_TIME)
+                        mem_copy_time(&list->buffer[list->head].time,&dtv);
+                else
+                        mem_copy_time(&list->buffer[list->head].time,&mtv);
+
 		list->buffer[list->head].type = type;
 		list->buffer[list->head].code = code;
 		list->buffer[list->head].value = value;
@@ -63,7 +86,11 @@
 	} else
 		list_for_each_entry(list, &evdev->list, node) {
 
-			do_gettimeofday(&list->buffer[list->head].time);
+                        if (list->time_kind == EV_USE_DAY_TIME)
+                                mem_copy_time(&list->buffer[list->head].time,&dtv);
+                        else
+                                mem_copy_time(&list->buffer[list->head].time,&mtv);
+
 			list->buffer[list->head].type = type;
 			list->buffer[list->head].code = code;
 			list->buffer[list->head].value = value;
@@ -135,6 +162,7 @@
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct evdev_list));
 
+        list->time_kind = EV_USE_DAY_TIME; /* for backward compatibility! */
 	list->evdev = evdev_table[i];
 	list_add_tail(&list->node, &evdev_table[i]->list);
 	file->private_data = list;
@@ -371,6 +399,17 @@
 				evdev->grab = NULL;
 				return 0;
 			}
+                case EVIOCTIME:
+                        switch (arg) {
+                        case EV_USE_MONOTONIC_TIME:
+                                list->time_kind = EV_USE_MONOTONIC_TIME;
+				return 0;
+			case EV_USE_DAY_TIME:
+                                list->time_kind = EV_USE_DAY_TIME;
+				return 0;
+                        default:
+                                return -EINVAL;
+			}
 
 		default:
 
--- linux-2.6.14-rc3.orig/include/linux/input.h	2005-10-05 23:07:39.833168000 +0200
+++ linux-2.6.14-rc3.mmc/include/linux/input.h	2005-10-05 22:47:40.000000000 +0200
@@ -78,6 +78,15 @@
 
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
 
+#define EVIOCTIME		_IOW('E', 0x91, int)			/* choose what kind of time to use for timestamps */
+
+/*
+ * Time used to timestamp 
+ */
+#define EV_USE_MONOTONIC_TIME 0
+#define EV_USE_DAY_TIME 1
+
+
 /*
  * Event types
  */
--- linux-2.6.14-rc3/kernel/posix-timers.c	2005-10-05 23:07:40.295183000 +0200
+++ linux-2.6.14-rc3.mmc/kernel/posix-timers.c	2005-10-06 14:30:30.831829116 +0200
@@ -1223,6 +1223,7 @@
 {
 	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
 }
+EXPORT_SYMBOL_GPL(do_posix_clock_monotonic_gettime);
 
 int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {
