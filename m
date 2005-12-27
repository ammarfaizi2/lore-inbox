Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVL0XIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVL0XIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVL0XIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:08:00 -0500
Received: from 83-103-88-29.ip.fastwebnet.it ([83.103.88.29]:10656 "EHLO
	maruska.gotadns.org") by vger.kernel.org with ESMTP id S932379AbVL0XH7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:07:59 -0500
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz, arjan@infradead.org, george@mvista.com
Subject: Re: [PATCH 2.6.15-rc7] clocks: export symbol
 do_posix_clock_monotonic_gettime + input: monotonic timestamps for evdev
X-Archive: encrypt
References: <m264pbo5zt.fsf@linux11.maruska.tin.it>
	<1135669949.2926.13.camel@laptopd505.fenrus.org>
From: mmc@maruska.dyndns.org (Michal =?iso-8859-2?q?Maru=B9ka?=)
In-Reply-To: <1135669949.2926.13.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Tue, 27 Dec 2005 08:52:29 +0100")
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) Emacs/22.0.50 (gnu/linux)
Date: Wed, 28 Dec 2005 00:07:49 +0100
Message-ID: <m2bqz2m94q.fsf_-_@linux11.maruska.tin.it>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Arjan van de Ven <arjan@infradead.org> writes:

> could you also include the patch to add the user (say evdev) in the same
> patch please?

here is my complete patch updated for -rc7:

Summary:
- export do_posix_clock_monotonic_gettime 
- implement an ioctl call for EVDEV to request timestamping of events with
  monotonic time. 

For complete explanation see my previous mail http://lkml.org/lkml/2005/10/6/92 



Signed-off-by: Michal Maruska <mmc@maruska.dyndns.org> 

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=mono-evdev.patch

--- linux-2.6.15-rc7/kernel/posix-timers.c	2005-12-26 13:01:54.000000000 +0100
+++ linux-2.6.15-rc7.mmc/kernel/posix-timers.c	2005-12-26 22:59:11.883817855 +0100
@@ -1219,6 +1219,7 @@ int do_posix_clock_monotonic_gettime(str
 {
 	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
 }
+EXPORT_SYMBOL_GPL(do_posix_clock_monotonic_gettime);
 
 int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {
--- linux-2.6.15-rc7/drivers/input/evdev.c	2005-12-26 13:01:54.000000000 +0100
+++ linux-2.6.15-rc7.mmc/drivers/input/evdev.c	2005-12-27 16:41:06.842396740 +0100
@@ -6,6 +6,11 @@
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
+ *
+ * 
+ * 2005-12-27  Optional timestamping with monotonic time
+ *                by  Michal Maruska <mmc@maruska.dyndns.org>
+ *     
  */
 
 #define EVDEV_MINOR_BASE	64
@@ -37,6 +42,7 @@ struct evdev_list {
 	struct input_event buffer[EVDEV_BUFFER_SIZE];
 	int head;
 	int tail;
+        int time_kind;      /* which time to use for the timestamps. Monotonic or timeofday. Should I use enum? */
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -44,15 +50,37 @@ struct evdev_list {
 
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
+        mtv.tv_usec = mts.tv_nsec / 1000;
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
@@ -62,7 +90,11 @@ static void evdev_event(struct input_han
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
@@ -134,6 +166,7 @@ static int evdev_open(struct inode * ino
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct evdev_list));
 
+        list->time_kind = EV_USE_DAY_TIME; /* for backward compatibility! */
 	list->evdev = evdev_table[i];
 	list_add_tail(&list->node, &evdev_table[i]->list);
 	file->private_data = list;
@@ -370,6 +403,17 @@ static long evdev_ioctl(struct file *fil
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
 
--- linux-2.6.15-rc7/include/linux/input.h	2005-12-26 13:01:54.000000000 +0100
+++ linux-2.6.15-rc7.mmc/include/linux/input.h	2005-12-27 16:48:09.932302548 +0100
@@ -79,6 +79,15 @@ struct input_absinfo {
 
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

--=-=-=--
