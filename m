Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTEFQTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTEFQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:18:59 -0400
Received: from mail.convergence.de ([212.84.236.4]:6345 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263930AbTEFQN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:58 -0400
Message-ID: <3EB7DCF0.2070207@convergence.de>
Date: Tue, 06 May 2003 18:04:00 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][3-11] update dvb subsystem core
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010504070901060405020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504070901060405020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the dvb subsystem core.

Fixed problems:
- partly reintroduced the DVB_DEVFS_ONLY switch, which was previously
wiped out by Alan Cox: if enabled, some really obscure code is not
compiled into the kernel that is necessary to xxx
- switched from user-land types like __u8 to u8 and uint16_t to u16
this makes the patch rather large.
- updated the dvr (digital videorecording) facility
- renamed some structures, like "struct dmxdev_s" to "struct dmxdev"
- introduced dvb_functions.[ch], where some linux-kernel specific
functions are encapsulated. by this, the dvb subsystem stays quite
independent from deeper linux kernel functions.
- moved dvb_usercopy() to dvb_functions.c -- this is essentially
video_usercopy() which should be generic_usercopy() instead... ;-)
- Made the dvb-core in dvbdev.c work with devfs again. I had to
introduce some #if KERNELVERSION magic again here, sorry. I'll fix it up
with the next patchset.

Please review and apply.

Thanks
Michael Hunold.





--------------010504070901060405020403
Content-Type: text/plain;
 name="03-dvb-core-driver.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-dvb-core-driver.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/Makefile linux-2.5.69.patch/drivers/media/dvb/Makefile
--- linux-2.5.69/drivers/media/dvb/Makefile	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/Makefile	2003-05-06 16:23:39.000000000 +0200
@@ -2,4 +2,4 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := dvb-core/ frontends/ ttpci/ # ttusb-budget/
+obj-y        := dvb-core/ frontends/ ttpci/ # ttusb-dec/ ttusb-budget/ 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/Kconfig linux-2.5.69.patch/drivers/media/dvb/dvb-core/Kconfig
--- linux-2.5.69/drivers/media/dvb/dvb-core/Kconfig	2003-04-07 19:32:50.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/Kconfig	2003-04-24 11:57:09.000000000 +0200
@@ -5,3 +5,13 @@
 	  DVB core utility functions for device handling, software fallbacks etc.
 
 	  Say Y when you have a DVB card and want to use it. If unsure say N.
+
+config DVB_DEVFS_ONLY
+       bool "devfs only"
+       depends on DVB_CORE=y && DEVFS_FS
+       help
+	 If you rely completly on devfs, you can drop support for the old
+	 major/minor device scheme. This omits some really awkward lines of
+	 code and saves some space in your kernel image.
+
+	 But as always: If unsure say N.

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/Makefile linux-2.5.69.patch/drivers/media/dvb/dvb-core/Makefile
--- linux-2.5.69/drivers/media/dvb/dvb-core/Makefile	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/Makefile	2003-05-06 16:41:01.000000000 +0200
@@ -3,6 +3,6 @@
 #
 
 dvb-core-objs = dvbdev.o dmxdev.o dvb_demux.o dvb_filter.o \
-		dvb_frontend.o dvb_i2c.o dvb_net.o dvb_ksyms.o dvb_ringbuffer.o
+		dvb_functions.o dvb_frontend.o dvb_i2c.o dvb_net.o dvb_ksyms.o dvb_ringbuffer.o
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/demux.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/demux.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/demux.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/demux.h	2003-04-15 15:25:18.000000000 +0200
@@ -25,14 +25,10 @@
 #ifndef __DEMUX_H 
 #define __DEMUX_H 
 
-#ifndef __KERNEL__ 
-#define __KERNEL__ 
-#endif 
-
-#include <linux/types.h>
+#include <asm/types.h>
+#include <asm/errno.h>
 #include <linux/list.h> 
 #include <linux/time.h> 
-#include <linux/errno.h>
 
 /*--------------------------------------------------------------------------*/ 
 /* Common definitions */ 
@@ -115,7 +111,7 @@
         struct dmx_demux_s *parent; /* Back-pointer */
         void *priv; /* Pointer to private data of the API client */ 
         int (*set) (struct dmx_ts_feed_s *feed, 
-		    uint16_t pid,
+		    u16 pid,
 		    int type, 
 		    dmx_ts_pes_t pes_type,
 		    size_t callback_length, 
@@ -133,9 +129,9 @@
 /*--------------------------------------------------------------------------*/ 
 
 typedef struct { 
-        __u8 filter_value [DMX_MAX_FILTER_SIZE]; 
-        __u8 filter_mask [DMX_MAX_FILTER_SIZE]; 
-        __u8 filter_mode [DMX_MAX_FILTER_SIZE]; 
+        u8 filter_value [DMX_MAX_FILTER_SIZE]; 
+        u8 filter_mask [DMX_MAX_FILTER_SIZE]; 
+        u8 filter_mode [DMX_MAX_FILTER_SIZE]; 
         struct dmx_section_feed_s* parent; /* Back-pointer */ 
         void* priv; /* Pointer to private data of the API client */ 
 } dmx_section_filter_t;
@@ -153,7 +149,7 @@
         int seclen;
 
         int (*set) (struct dmx_section_feed_s* feed, 
-		    __u16 pid, 
+		    u16 pid, 
 		    size_t circular_buffer_size, 
 		    int descramble, 
 		    int check_crc); 
@@ -201,10 +197,6 @@
 } dmx_frontend_source_t; 
 
 typedef struct { 
-        /* The following char* fields point to NULL terminated strings */ 
-        char* id;                    /* Unique front-end identifier */ 
-        char* vendor;                /* Name of the front-end vendor */ 
-        char* model;                 /* Name of the front-end model */ 
         struct list_head connectivity_list; /* List of front-ends that can 
 					       be connected to a particular 
 					       demux */ 
@@ -243,11 +235,7 @@
 #define DMX_FE_ENTRY(list) list_entry(list, dmx_frontend_t, connectivity_list) 
 
 struct dmx_demux_s { 
-        /* The following char* fields point to NULL terminated strings */ 
-        char* id;                    /* Unique demux identifier */ 
-        char* vendor;                /* Name of the demux vendor */ 
-        char* model;                 /* Name of the demux model */ 
-        __u32 capabilities;          /* Bitfield of capability flags */ 
+        u32 capabilities;            /* Bitfield of capability flags */ 
         dmx_frontend_t* frontend;    /* Front-end connected to the demux */ 
         struct list_head reg_list;   /* List of registered demuxes */
         void* priv;                  /* Pointer to private data of the API client */ 
@@ -266,16 +254,16 @@
         int (*release_section_feed) (struct dmx_demux_s* demux,
 				     dmx_section_feed_t* feed); 
         int (*descramble_mac_address) (struct dmx_demux_s* demux, 
-				       __u8* buffer1, 
+				       u8* buffer1, 
 				       size_t buffer1_length, 
-				       __u8* buffer2, 
+				       u8* buffer2, 
 				       size_t buffer2_length,
-				       __u16 pid); 
+				       u16 pid); 
         int (*descramble_section_payload) (struct dmx_demux_s* demux,
-					   __u8* buffer1, 
+					   u8* buffer1, 
 					   size_t buffer1_length,
-					   __u8* buffer2, size_t buffer2_length,
-					   __u16 pid); 
+					   u8* buffer2, size_t buffer2_length,
+					   u16 pid); 
         int (*add_frontend) (struct dmx_demux_s* demux, 
 			     dmx_frontend_t* frontend); 
         int (*remove_frontend) (struct dmx_demux_s* demux,
@@ -285,10 +273,10 @@
 				 dmx_frontend_t* frontend); 
         int (*disconnect_frontend) (struct dmx_demux_s* demux); 
 
-        int (*get_pes_pids) (struct dmx_demux_s* demux, __u16 *pids);
+        int (*get_pes_pids) (struct dmx_demux_s* demux, u16 *pids);
 
         int (*get_stc) (struct dmx_demux_s* demux, unsigned int num,
-			uint64_t *stc, unsigned int *base);
+			u64 *stc, unsigned int *base);
 }; 
 typedef struct dmx_demux_s dmx_demux_t; 
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dmxdev.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dmxdev.c	2003-04-30 12:03:49.000000000 +0200
@@ -21,22 +21,20 @@
  *
  */
 
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/poll.h>
-#include <asm/uaccess.h>
+#include <linux/ioctl.h>
+#include <linux/wait.h>
 
 #include "dmxdev.h"
+#include "dvb_functions.h"
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#endif
-
-//MODULE_DESCRIPTION("");
-//MODULE_AUTHOR("Ralph Metzler, Marcus Metzler");
-//#ifdef MODULE_LICENSE
-//MODULE_LICENSE("GPL");
-//#endif
 MODULE_PARM(debug,"i");
 static int debug = 0;
 
@@ -483,7 +481,7 @@
 {
 	int i;
 	dmxdev_t *dmxdev = filter->dev;
-	uint16_t pid = filter->params.sec.pid;
+	u16 pid = filter->params.sec.pid;
 	
 	for (i=0; i<dmxdev->filternum; i++) 
 		if (dmxdev->filter[i].state>=DMXDEV_STATE_GO &&
@@ -959,7 +957,7 @@
 			ret=-EINVAL;
 			break;
 		}
-		dmxdev->demux->get_pes_pids(dmxdev->demux, (uint16_t *)parg);
+		dmxdev->demux->get_pes_pids(dmxdev->demux, (u16 *)parg);
 		break;
 
 	case DMX_GET_STC:
@@ -999,7 +997,8 @@
 	poll_wait(file, &dmxdevfilter->buffer.queue, wait);
 
 	if (dmxdevfilter->state != DMXDEV_STATE_GO &&
-	    dmxdevfilter->state != DMXDEV_STATE_DONE)
+	    dmxdevfilter->state != DMXDEV_STATE_DONE &&
+	    dmxdevfilter->state != DMXDEV_STATE_TIMEDOUT)
 		return 0;
 
 	if (dmxdevfilter->buffer.error)
@@ -1103,7 +1106,8 @@
 	.poll		= dvb_dvr_poll,
 };
 
-static struct dvb_device dvbdev_dvr = {
+static
+struct dvb_device dvbdev_dvr = {
 	.priv		= 0,
 	.users		= 1,
 	.writers	= 1,
@@ -1125,9 +1129,10 @@
 	dmxdev->dvr=vmalloc(dmxdev->filternum*sizeof(dmxdev_dvr_t));
 	if (!dmxdev->dvr) {
 		vfree(dmxdev->filter);
-		dmxdev->filter=0;
+		dmxdev->filter = NULL;
 		return -ENOMEM;
 	}
+
 	sema_init(&dmxdev->mutex, 1);
 	spin_lock_init(&dmxdev->lock);
 	for (i=0; i<dmxdev->filternum; i++) {
@@ -1143,8 +1149,7 @@
 	dvb_register_device(dvb_adapter, &dmxdev->dvr_dvbdev, &dvbdev_dvr, dmxdev, DVB_DEVICE_DVR);
 
 	dvb_dmxdev_buffer_init(&dmxdev->dvr_buffer);
-	/* fixme: is this correct? */
-	try_module_get(THIS_MODULE);
+
 	return 0;
 }
 
@@ -1162,8 +1169,6 @@
 		dmxdev->dvr=0;
 	}
 	dmxdev->demux->close(dmxdev->demux);
-	/* fixme: is this correct? */
-	module_put(THIS_MODULE);
 }
 
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dmxdev.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dmxdev.h	2003-04-14 23:03:49.000000000 +0200
@@ -24,16 +24,16 @@
 #ifndef _DMXDEV_H_
 #define _DMXDEV_H_
 
-#ifndef __KERNEL__ 
-#define __KERNEL__ 
-#endif 
-
-#include <linux/dvb/dmx.h>
-
-#include <linux/version.h>
+#include <asm/types.h>
+#include <asm/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
 #include <linux/wait.h>
-#include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/string.h>
+
+#include <linux/dvb/dmx.h>
 
 #include "dvbdev.h"
 #include "demux.h"
@@ -53,17 +53,17 @@
 	DMXDEV_STATE_TIMEDOUT
 } dmxdev_state_t;
 
-typedef struct dmxdev_buffer_s {
-        uint8_t *data;
-        uint32_t size;
-        int32_t  pread;
-        int32_t  pwrite;
+typedef struct dmxdev_buffer {
+        u8 *data;
+        int size;
+        int pread;
+        int pwrite;
 	wait_queue_head_t queue;
         int error;
 } dmxdev_buffer_t;
 
 
-typedef struct dmxdev_filter_s {
+typedef struct dmxdev_filter {
 	struct dvb_device *dvbdev;
 
         union {
@@ -82,7 +82,7 @@
 
         int type;
         dmxdev_state_t state;
-        struct dmxdev_s *dev;
+        struct dmxdev *dev;
         dmxdev_buffer_t buffer;
 
 	struct semaphore mutex;
@@ -90,20 +90,20 @@
         // only for sections
         struct timer_list timer;
         int todo;
-        uint8_t secheader[3];
+        u8 secheader[3];
 
         u16 pid;
 } dmxdev_filter_t;
 
 
-typedef struct dmxdev_dvr_s {
+typedef struct dmxdev_dvr {
         int state;
-        struct dmxdev_s *dev;
+        struct dmxdev *dev;
         dmxdev_buffer_t buffer;
 } dmxdev_dvr_t;
 
 
-typedef struct dmxdev_s {
+typedef struct dmxdev {
 	struct dvb_device *dvbdev;
 	struct dvb_device *dvr_dvbdev;
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_demux.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_demux.c	2003-05-06 16:59:56.000000000 +0200
@@ -21,19 +21,17 @@
  *
  */
 
+#include <asm/uaccess.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/poll.h>
-#include <linux/version.h>
-#include <asm/uaccess.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#else
+#include <linux/string.h>
 	#include <linux/crc32.h>
-#endif
 
 #include "dvb_demux.h"
+#include "dvb_functions.h"
 
 #define NOBUFS  
 
@@ -42,21 +40,8 @@
 
 int dmx_register_demux(dmx_demux_t *demux) 
 {
-	struct list_head *pos;
-	
-	if (!(demux->id && demux->vendor && demux->model)) 
-		return -EINVAL;
-
-	list_for_each(pos, &dmx_muxs) {
-		if (!strcmp(DMX_DIR_ENTRY(pos)->id, demux->id))
-			return -EEXIST;
-	}
-
 	demux->users = 0;
 	list_add(&demux->reg_list, &dmx_muxs);
-	/* fixme: is this correct? */
-	try_module_get(THIS_MODULE);
-
 	return 0;
 }
 
@@ -69,8 +54,6 @@
 			if (demux->users>0)
 				return -EINVAL;
 			list_del(pos);
-			/* fixme: is this correct? */
-			module_put(THIS_MODULE);
 			return 0;
 		}
 	}
@@ -506,12 +491,14 @@
 	if (pid == feed->pid)
 		return 0;
 
-	if (feed->pid <= DMX_MAX_PID)
-		list_for_each_safe(pos, n, head)
+	if (feed->pid <= DMX_MAX_PID) {
+		list_for_each_safe(pos, n, head) {
 			if (DMX_FEED_ENTRY(pos)->pid == feed->pid) {
 				list_del(pos);
 				break;
 			}
+		}
+	}
 
 	list_add(&feed->list_head, head);
 	feed->pid = pid;
@@ -684,12 +671,12 @@
 	feed->buffer = 0;
 
 	(*ts_feed) = &feed->feed.ts;
-	(*ts_feed)->is_filtering = 0;
 	(*ts_feed)->parent = dmx;
 	(*ts_feed)->priv = 0;
-	(*ts_feed)->set = dmx_ts_feed_set;
+	(*ts_feed)->is_filtering = 0;
 	(*ts_feed)->start_filtering = dmx_ts_feed_start_filtering;
 	(*ts_feed)->stop_filtering = dmx_ts_feed_stop_filtering;
+	(*ts_feed)->set = dmx_ts_feed_set;
 
 
 	if (!(feed->filter = dvb_dmx_filter_alloc(demux))) {
@@ -767,8 +754,9 @@
 	dvbdmxfilter=dvb_dmx_filter_alloc(dvbdemux);
 	if (!dvbdmxfilter) {
 		up(&dvbdemux->mutex);
-		return -ENOSPC;
+		return -EBUSY;
 	}
+
 	spin_lock_irq(&dvbdemux->lock);
 	*filter=&dvbdmxfilter->filter;
 	(*filter)->parent=feed;
@@ -799,16 +788,18 @@
 	if (down_interruptible (&dvbdmx->mutex))
 		return -ERESTARTSYS;
 	
-	if (dvbdmxfeed->pid <= DMX_MAX_PID)
-		list_for_each_safe(pos, n, head)
+	if (dvbdmxfeed->pid <= DMX_MAX_PID) {
+		list_for_each_safe(pos, n, head) {
 			if (DMX_FEED_ENTRY(pos)->pid == dvbdmxfeed->pid) {
 				list_del(pos);
 				break;
 			}
+		}
+	}
 
 	list_add(&dvbdmxfeed->list_head, head);
-	dvbdmxfeed->pid=pid;
 
+	dvbdmxfeed->pid = pid;
 	dvbdmxfeed->buffer_size=circular_buffer_size;
 	dvbdmxfeed->descramble=descramble;
 	if (dvbdmxfeed->descramble) {
@@ -834,8 +828,8 @@
 static void prepare_secfilters(struct dvb_demux_feed *dvbdmxfeed)
 {
 	int i;
-	dmx_section_filter_t *sf;
 	struct dvb_demux_filter *f;
+	dmx_section_filter_t *sf;
 	u8 mask, mode, doneq;
 		
 	if (!(f=dvbdmxfeed->filter))
@@ -938,9 +941,10 @@
 	
 	spin_lock_irq(&dvbdmx->lock);
 	f=dvbdmxfeed->filter;
-	if (f==dvbdmxfilter)
+
+	if (f == dvbdmxfilter) {
 		dvbdmxfeed->filter=dvbdmxfilter->next;
-	else {
+	} else {
 		while(f->next!=dvbdmxfilter)
 			f=f->next;
 		f->next=f->next->next;
@@ -977,11 +983,12 @@
 	(*feed)->is_filtering=0;
 	(*feed)->parent=demux;
 	(*feed)->priv=0;
+
 	(*feed)->set=dmx_section_feed_set;
 	(*feed)->allocate_filter=dmx_section_feed_allocate_filter;
-	(*feed)->release_filter=dmx_section_feed_release_filter;
 	(*feed)->start_filtering=dmx_section_feed_start_filtering;
 	(*feed)->stop_filtering=dmx_section_feed_stop_filtering;
+	(*feed)->release_filter = dmx_section_feed_release_filter;
 
 	up(&dvbdmx->mutex);
 	return 0;
@@ -1010,11 +1017,12 @@
 	dvbdmxfeed->state=DMX_STATE_FREE;
 
 	if (dvbdmxfeed->pid <= DMX_MAX_PID) {
-		list_for_each_safe(pos, n, head)
+		list_for_each_safe(pos, n, head) {
 			if (DMX_FEED_ENTRY(pos)->pid == dvbdmxfeed->pid) {
 				list_del(pos);
 				break;
 			}
+		}
 		dvbdmxfeed->pid = 0xffff;
 	}
 
@@ -1052,8 +1064,7 @@
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 
-	if ((!demux->frontend) ||
-	    (demux->frontend->source!=DMX_MEMORY_FE))
+	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))
 		return -EINVAL;
 
 	if (down_interruptible (&dvbdemux->mutex))
@@ -1065,21 +1077,13 @@
 }
 
 
-static int dvbdmx_add_frontend(dmx_demux_t *demux, 
-			       dmx_frontend_t *frontend)
+static int dvbdmx_add_frontend(dmx_demux_t *demux, dmx_frontend_t *frontend)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
-	struct list_head *pos, *head=&dvbdemux->frontend_list;
-	
-	if (!(frontend->id && frontend->vendor && frontend->model)) 
-		return -EINVAL;
-	list_for_each(pos, head) 
-	{
-		if (!strcmp(DMX_FE_ENTRY(pos)->id, frontend->id))
-			return -EEXIST;
-	}
+	struct list_head *head = &dvbdemux->frontend_list;
 
 	list_add(&(frontend->connectivity_list), head);
+
 	return 0;
 }
 
@@ -1083,17 +1087,15 @@
 	return 0;
 }
 
+
 static int 
-dvbdmx_remove_frontend(dmx_demux_t *demux, 
-		       dmx_frontend_t *frontend)
+dvbdmx_remove_frontend(dmx_demux_t *demux, dmx_frontend_t *frontend)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 	struct list_head *pos, *n, *head=&dvbdemux->frontend_list;
 
-	list_for_each_safe (pos, n, head) 
-	{
-		if (DMX_FE_ENTRY(pos)==frontend) 
-		{
+	list_for_each_safe (pos, n, head) {
+		if (DMX_FE_ENTRY(pos) == frontend) {
 			list_del(pos);
 			return 0;
 		}
@@ -1111,8 +1116,8 @@
 	return &dvbdemux->frontend_list;
 }
 
-static int dvbdmx_connect_frontend(dmx_demux_t *demux, 
-				   dmx_frontend_t *frontend)
+
+int dvbdmx_connect_frontend(dmx_demux_t *demux, dmx_frontend_t *frontend)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 
@@ -1127,7 +1132,8 @@
 	return 0;
 }
 
-static int dvbdmx_disconnect_frontend(dmx_demux_t *demux)
+
+int dvbdmx_disconnect_frontend(dmx_demux_t *demux)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 
@@ -1150,7 +1159,7 @@
 int 
 dvb_dmx_init(struct dvb_demux *dvbdemux)
 {
-	int i;
+	int i, err;
 	dmx_demux_t *dmx=&dvbdemux->dmx;
 
 	dvbdemux->users=0;
@@ -1176,8 +1190,11 @@
 		dvbdemux->pesfilter[i]=NULL;
 		dvbdemux->pids[i]=0xffff;
 	}
-	dvbdemux->playing=dvbdemux->recording=0;
+
 	INIT_LIST_HEAD(&dvbdemux->feed_list);
+
+	dvbdemux->playing = 0;
+	dvbdemux->recording = 0;
 	dvbdemux->tsbufp=0;
 
 	if (!dvbdemux->check_crc32)
@@ -1187,9 +1204,8 @@
 		 dvbdemux->memcopy = dvb_dmx_memcopy;
 
 	dmx->frontend=0;
-	dmx->reg_list.next=dmx->reg_list.prev=&dmx->reg_list;
+	dmx->reg_list.prev = dmx->reg_list.next = &dmx->reg_list;
 	dmx->priv=(void *) dvbdemux;
-	//dmx->users=0;		  // reset in dmx_register_demux() 
 	dmx->open=dvbdmx_open;
 	dmx->close=dvbdmx_close;
 	dmx->write=dvbdmx_write;
@@ -1210,8 +1227,8 @@
 	sema_init(&dvbdemux->mutex, 1);
 	spin_lock_init(&dvbdemux->lock);
 
-	if (dmx_register_demux(dmx)<0) 
-		return -1;
+	if ((err = dmx_register_demux(dmx)) < 0) 
+		return err;
 
 	return 0;
 }
@@ -1228,10 +1246,3 @@
 		vfree(dvbdemux->feed);
 	return 0;
 }
-
-#if 0
-MODULE_DESCRIPTION("Software MPEG Demultiplexer");
-MODULE_AUTHOR("Ralph Metzler, Markus Metzler");
-MODULE_LICENSE("GPL");
-#endif
-
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_demux.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_demux.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_demux.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_demux.h	2003-04-28 18:49:26.000000000 +0200
@@ -26,7 +26,9 @@
 #define _DVB_DEMUX_H_
 
 #include <asm/semaphore.h>
+#include <linux/time.h>
 #include <linux/timer.h>
+#include <linux/spinlock.h>
 
 #include "demux.h"
 
@@ -140,4 +142,8 @@
 void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf, size_t count);
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count);
 
+int dvbdmx_connect_frontend(dmx_demux_t *demux, dmx_frontend_t *frontend);
+int dvbdmx_disconnect_frontend(dmx_demux_t *demux);
+
 #endif /* _DVB_DEMUX_H_ */
+
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_filter.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_filter.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_filter.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_filter.c	2003-03-21 16:09:54.000000000 +0100
@@ -1,4 +1,6 @@
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include "dvb_filter.h"
 
 unsigned int bitrates[3][16] =
@@ -6,14 +8,14 @@
  {0,32,48,56,64,80,96,112,128,160,192,224,256,320,384,0},
  {0,32,40,48,56,64,80,96,112,128,160,192,224,256,320,0}};
 
-uint32_t freq[4] = {441, 480, 320, 0};
+u32 freq[4] = {441, 480, 320, 0};
 
 unsigned int ac3_bitrates[32] =
     {32,40,48,56,64,80,96,112,128,160,192,224,256,320,384,448,512,576,640,
      0,0,0,0,0,0,0,0,0,0,0,0,0};
 
-uint32_t ac3_freq[4] = {480, 441, 320, 0};
-uint32_t ac3_frames[3][32] =
+u32 ac3_freq[4] = {480, 441, 320, 0};
+u32 ac3_frames[3][32] =
     {{64,80,96,112,128,160,192,224,256,320,384,448,512,640,768,896,1024,
       1152,1280,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {69,87,104,121,139,174,208,243,278,348,417,487,557,696,835,975,1114,
@@ -67,9 +69,9 @@
 #if 0
 /* needs 5 byte input, returns picture coding type*/
 static
-int read_picture_header(uint8_t *headr, mpg_picture *pic, int field, int pr)
+int read_picture_header(u8 *headr, mpg_picture *pic, int field, int pr)
 {
-	uint8_t pct;
+	u8 pct;
 
 	if (pr) printk( "Pic header: ");
         pic->temporal_reference[field] = (( headr[0] << 2 ) | 
@@ -114,7 +116,7 @@
 #if 0
 /* needs 4 byte input */
 static
-int read_gop_header(uint8_t *headr, mpg_picture *pic, int pr)
+int read_gop_header(u8 *headr, mpg_picture *pic, int pr)
 {
 	if (pr) printk("GOP header: "); 
 
@@ -146,7 +148,7 @@
 #if 0
 /* needs 8 byte input */
 static
-int read_sequence_header(uint8_t *headr, VideoInfo *vi, int pr)
+int read_sequence_header(u8 *headr, VideoInfo *vi, int pr)
 {
         int sw;
 	int form = -1;
@@ -261,14 +263,14 @@
 
 #if 0
 static
-int get_vinfo(uint8_t *mbuf, int count, VideoInfo *vi, int pr)
+int get_vinfo(u8 *mbuf, int count, VideoInfo *vi, int pr)
 {
-	uint8_t *headr;
+	u8 *headr;
 	int found = 0;
 	int c = 0;
 
 	while (found < 4 && c+4 < count){
-		uint8_t *b;
+		u8 *b;
 
 		b = mbuf+c;
 		if ( b[0] == 0x00 && b[1] == 0x00 && b[2] == 0x01
@@ -291,15 +293,15 @@
 
 #if 0
 static
-int get_ainfo(uint8_t *mbuf, int count, AudioInfo *ai, int pr)
+int get_ainfo(u8 *mbuf, int count, AudioInfo *ai, int pr)
 {
-	uint8_t *headr;
+	u8 *headr;
 	int found = 0;
 	int c = 0;
 	int fr = 0;
 
 	while (found < 2 && c < count){
-		uint8_t b[2];
+		u8 b[2];
 		memcpy( b, mbuf+c, 2);
 
 		if ( b[0] == 0xff && (b[1] & 0xf8) == 0xf8)
@@ -346,16 +348,16 @@
 #endif
 
 
-int dvb_filter_get_ac3info(uint8_t *mbuf, int count, AudioInfo *ai, int pr)
+int dvb_filter_get_ac3info(u8 *mbuf, int count, AudioInfo *ai, int pr)
 {
-	uint8_t *headr;
+	u8 *headr;
 	int found = 0;
 	int c = 0;
-	uint8_t frame = 0;
+	u8 frame = 0;
 	int fr = 0;
 	
 	while ( !found  && c < count){
-		uint8_t *b = mbuf+c;
+		u8 *b = mbuf+c;
 
 		if ( b[0] == 0x0b &&  b[1] == 0x77 )
 			found = 1;
@@ -378,18 +380,18 @@
 	ai->bit_rate = ac3_bitrates[frame >> 1]*1000;
 
 	if (pr)
-		printk("  BRate: %d kb/s", ai->bit_rate/1000);
+		printk("  BRate: %d kb/s", (int) ai->bit_rate/1000);
 
 	ai->frequency = (headr[2] & 0xc0 ) >> 6;
 	fr = (headr[2] & 0xc0 ) >> 6;
 	ai->frequency = freq[fr]*100;
-	if (pr) printk ("  Freq: %d Hz\n", ai->frequency);
+	if (pr) printk ("  Freq: %d Hz\n", (int) ai->frequency);
 
 
 	ai->framesize = ac3_frames[fr][frame >> 1];
 	if ((frame & 1) &&  (fr == 1)) ai->framesize++;
 	ai->framesize = ai->framesize << 1;
-	if (pr) printk ("  Framesize %d\n", ai->framesize);
+	if (pr) printk ("  Framesize %d\n",(int) ai->framesize);
 
 
 	return 0;
@@ -398,11 +400,11 @@
 
 #if 0
 static
-uint8_t *skip_pes_header(uint8_t **bufp)
+u8 *skip_pes_header(u8 **bufp)
 {
-        uint8_t *inbuf = *bufp;
-        uint8_t *buf = inbuf;
-        uint8_t *pts = NULL;
+        u8 *inbuf = *bufp;
+        u8 *buf = inbuf;
+        u8 *pts = NULL;
         int skip = 0;
 
 	static const int mpeg1_skip_table[16] = {
@@ -437,7 +439,7 @@
 
 #if 0
 static
-void initialize_quant_matrix( uint32_t *matrix )
+void initialize_quant_matrix( u32 *matrix )
 {
         int i;
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_filter.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_filter.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_filter.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_filter.h	2003-03-21 16:09:54.000000000 +0100
@@ -2,7 +2,6 @@
 #define _DVB_FILTER_H_
 
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 
 #include "demux.h"
 
@@ -116,7 +115,7 @@
 	int found;
 	u8 *buf;
 	u8 cid;
-	uint32_t plength;
+	u32 plength;
 	u8 plen[2];
 	u8 flag1;
 	u8 flag2;
@@ -134,17 +133,17 @@
 } ipack;
 
 typedef struct video_i{
-	uint32_t horizontal_size;
-	uint32_t vertical_size;
-	uint32_t aspect_ratio;
-	uint32_t framerate;
-	uint32_t video_format;
-	uint32_t bit_rate;
-	uint32_t comp_bit_rate;
-	uint32_t vbv_buffer_size;
-        int16_t  vbv_delay;
-	uint32_t CSPF;
-	uint32_t off;
+	u32 horizontal_size;
+	u32 vertical_size;
+	u32 aspect_ratio;
+	u32 framerate;
+	u32 video_format;
+	u32 bit_rate;
+	u32 comp_bit_rate;
+	u32 vbv_buffer_size;
+        s16 vbv_delay;
+	u32 CSPF;
+	u32 off;
 } VideoInfo;            
 
 
@@ -156,9 +155,9 @@
 typedef struct mpg_picture_s{
         int       channel;
 	VideoInfo vinfo;
-        uint32_t  *sequence_gop_header;
-        uint32_t  *picture_header;
-        int32_t   time_code;
+        u32      *sequence_gop_header;
+        u32      *picture_header;
+        s32       time_code;
         int       low_delay;
         int       closed_gop;
         int       broken_link;
@@ -166,12 +165,12 @@
         int       gop_flag;              
         int       sequence_end_flag;
                                                                 
-        uint8_t   profile_and_level;
-        int32_t   picture_coding_parameter;
-        uint32_t  matrix[32];
-        int8_t    matrix_change_flag;
+        u8        profile_and_level;
+        s32       picture_coding_parameter;
+        u32       matrix[32];
+        s8        matrix_change_flag;
 
-        uint8_t   picture_header_parameter;
+        u8        picture_header_parameter;
   /* bit 0 - 2: bwd f code
      bit 3    : fpb vector
      bit 4 - 6: fwd f code
@@ -180,11 +179,11 @@
         int       mpeg1_flag;
         int       progressive_sequence;
         int       sequence_display_extension_flag;
-        uint32_t  sequence_header_data;
-        int16_t   last_frame_centre_horizontal_offset;
-        int16_t   last_frame_centre_vertical_offset;
+        u32       sequence_header_data;
+        s16       last_frame_centre_horizontal_offset;
+        s16       last_frame_centre_vertical_offset;
 
-        uint32_t  pts[2]; /* [0] 1st field, [1] 2nd field */
+        u32       pts[2]; /* [0] 1st field, [1] 2nd field */
         int       top_field_first;
         int       repeat_first_field;
         int       progressive_frame;
@@ -192,21 +191,21 @@
         int       forward_bank;
         int       backward_bank;
         int       compress;
-        int16_t   frame_centre_horizontal_offset[OFF_SIZE];                   
+        s16       frame_centre_horizontal_offset[OFF_SIZE];                   
                   /* [0-2] 1st field, [3] 2nd field */
-        int16_t   frame_centre_vertical_offset[OFF_SIZE];
+        s16       frame_centre_vertical_offset[OFF_SIZE];
                   /* [0-2] 1st field, [3] 2nd field */
-        int16_t   temporal_reference[2];                               
+        s16       temporal_reference[2];                               
                   /* [0] 1st field, [1] 2nd field */
 
-        int8_t    picture_coding_type[2];
+        s8        picture_coding_type[2];
                  /* [0] 1st field, [1] 2nd field */
-        int8_t    picture_structure[2];
+        s8        picture_structure[2];
                  /* [0] 1st field, [1] 2nd field */
-        int8_t    picture_display_extension_flag[2];
+        s8        picture_display_extension_flag[2];
                  /* [0] 1st field, [1] 2nd field */
                  /* picture_display_extenion() 0:no 1:exit*/
-        int8_t    pts_flag[2];
+        s8        pts_flag[2];
                  /* [0] 1st field, [1] 2nd field */
 } mpg_picture;
 
@@ -215,16 +214,16 @@
 
 typedef struct audio_i{
 	int layer               ;
-	uint32_t bit_rate    ;
-	uint32_t frequency   ;
-	uint32_t mode                ;
-	uint32_t mode_extension ;
-	uint32_t emphasis    ;
-	uint32_t framesize;
-	uint32_t off;
+	u32 bit_rate;
+	u32 frequency;
+	u32 mode;
+	u32 mode_extension ;
+	u32 emphasis;
+	u32 framesize;
+	u32 off;
 } AudioInfo;
 
-int dvb_filter_get_ac3info(uint8_t *mbuf, int count, AudioInfo *ai, int pr);
+int dvb_filter_get_ac3info(u8 *mbuf, int count, AudioInfo *ai, int pr);
 
 
 #endif
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_frontend.c	2003-05-06 16:46:00.000000000 +0200
@@ -22,8 +22,13 @@
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <asm/processor.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/smp_lock.h>
+#include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/module.h>
@@ -31,6 +36,7 @@
 
 #include "dvb_frontend.h"
 #include "dvbdev.h"
+#include "dvb_functions.h"
 
 
 static int dvb_frontend_debug = 0;
@@ -98,14 +104,6 @@
 
 
 static
-inline void ddelay (int ms)
-{
-	current->state=TASK_INTERRUPTIBLE;
-	schedule_timeout((HZ*ms)/1000);
-}
-
-
-static
 int dvb_frontend_internal_ioctl (struct dvb_frontend *frontend, 
 				 unsigned int cmd, void *arg)
 {
@@ -198,7 +196,7 @@
 		fe->lost_sync_jiffies = jiffies;
 
 	if (((s ^ fe->status) & FE_HAS_LOCK) && (s & FE_HAS_LOCK))
-		ddelay (fe->info->notifier_delay);
+		dvb_delay (fe->info->notifier_delay);
 
 	fe->status = s;
 
@@ -313,7 +311,7 @@
 	dvb_bend_frequency (fe, 0);
 
 	dprintk ("%s: f == %i, drift == %i\n",
-		 __FUNCTION__, param->frequency, fe->lnb_drift);
+		 __FUNCTION__, (int) param->frequency, (int) fe->lnb_drift);
 
 	param->frequency += fe->lnb_drift + fe->bending;
 	err = dvb_frontend_internal_ioctl (frontend, FE_SET_FRONTEND, param);
@@ -428,33 +426,23 @@
 int dvb_frontend_thread (void *data)
 {
 	struct dvb_frontend_data *fe = (struct dvb_frontend_data *) data;
+	char name [15];
 	int quality = 0, delay = 3*HZ;
 	fe_status_t s;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	lock_kernel ();
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,61))
-	daemonize ();
-#else
-	daemonize ("dvb fe");
-#endif
-/*	not needed anymore in 2.5.x, done in daemonize() */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-	reparent_to_init ();
-#endif
+	snprintf (name, sizeof(name), "kdvb-fe-%i:%i",
+		  fe->frontend.i2c->adapter->num, fe->frontend.i2c->id);
+
+	dvb_kernel_thread_setup (name);
 
-	sigfillset (&current->blocked);
 	fe->thread = current;
-	snprintf (current->comm, sizeof (current->comm), "kdvb-fe-%i:%i",
-		  fe->frontend.i2c->adapter->num, fe->frontend.i2c->id);
-	unlock_kernel ();
+	fe->lost_sync_count = -1;
 
 	dvb_call_frontend_notifiers (fe, 0);
 	dvb_frontend_init (fe);
 
-	fe->lost_sync_count = -1;
-
 	while (!dvb_frontend_is_exiting (fe)) {
 		up (&fe->sem);      /* is locked when we enter the thread... */
 
@@ -518,7 +506,7 @@
 	while (fe->thread) {
 		fe->exit = 1;
 		wake_up_interruptible (&fe->wait_queue);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout (5);
 		if (signal_pending(current))
 			break;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_functions.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_functions.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_functions.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_functions.c	2003-05-06 16:55:25.000000000 +0200
@@ -0,0 +1,99 @@
+#include <linux/smp_lock.h>
+#include <linux/version.h>
+#include <asm/uaccess.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/version.h>
+#include <linux/fs.h>
+#include <asm/uaccess.h>
+#include <asm/errno.h>
+#include <linux/module.h>
+#include <linux/ioctl.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+
+void dvb_kernel_thread_setup (const char *thread_name)
+{
+        lock_kernel ();
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,61))
+        daemonize ();
+	strncpy (current->comm, thread_name, sizeof(current->comm));
+#else
+        daemonize (thread_name);
+#endif
+
+/*      not needed anymore in 2.5.x, done in daemonize() */
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+        reparent_to_init();
+#endif
+
+        sigfillset (&current->blocked);
+        unlock_kernel ();
+}
+
+/* if the miracle happens and "generic_usercopy()" is included into
+   the kernel, then this can vanish. please don't make the mistake and
+   define this as video_usercopy(). this will introduce a dependecy
+   to the v4l "videodev.o" module, which is unnecessary for some
+   cards (ie. the budget dvb-cards don't need the v4l module...) */
+int dvb_usercopy(struct inode *inode, struct file *file,
+	             unsigned int cmd, unsigned long arg,
+		     int (*func)(struct inode *inode, struct file *file,
+		     unsigned int cmd, void *arg))
+{
+        char    sbuf[128];
+        void    *mbuf = NULL;
+        void    *parg = NULL;
+        int     err  = -EINVAL;
+
+        /*  Copy arguments into temp kernel buffer  */
+        switch (_IOC_DIR(cmd)) {
+        case _IOC_NONE:
+                parg = (void *)arg;
+                break;
+        case _IOC_READ: /* some v4l ioctls are marked wrong ... */
+        case _IOC_WRITE:
+        case (_IOC_WRITE | _IOC_READ):
+                if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
+                        parg = sbuf;
+                } else {
+                        /* too big to allocate from stack */
+                        mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
+                        if (NULL == mbuf)
+                                return -ENOMEM;
+                        parg = mbuf;
+                }
+
+                err = -EFAULT;
+                if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
+                        goto out;
+                break;
+        }
+
+        /* call driver */
+        if ((err = func(inode, file, cmd, parg)) == -ENOIOCTLCMD)
+                err = -EINVAL;
+
+        if (err < 0)
+                goto out;
+
+        /*  Copy results into user buffer  */
+        switch (_IOC_DIR(cmd))
+        {
+        case _IOC_READ:
+        case (_IOC_WRITE | _IOC_READ):
+                if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
+                        err = -EFAULT;
+                break;
+        }
+
+out:
+        if (mbuf)
+                kfree(mbuf);
+
+        return err;
+}
+
+EXPORT_SYMBOL(dvb_usercopy);
+EXPORT_SYMBOL(dvb_kernel_thread_setup);
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_functions.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_functions.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_functions.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_functions.h	2003-05-06 17:02:03.000000000 +0200
@@ -0,0 +1,29 @@
+#ifndef __DVB_FUNCTIONS_H__
+#define __DVB_FUNCTIONS_H__
+
+/**
+ *  a sleeping delay function, waits i ms
+ *
+ */
+static inline
+void dvb_delay(int i)
+{
+	current->state=TASK_INTERRUPTIBLE;
+	schedule_timeout((HZ*i)/1000);
+}
+
+/* we don't mess with video_usercopy() any more,
+we simply define out own dvb_usercopy(), which will hopefull become
+generic_usercopy()  someday... */
+
+extern int dvb_usercopy(struct inode *inode, struct file *file,
+	                    unsigned int cmd, unsigned long arg,
+			    int (*func)(struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg));
+
+extern void dvb_kernel_thread_setup (const char *thread_name);
+
+#include "dvb_compat.h"
+
+#endif
+
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_i2c.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_i2c.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-04-30 12:03:46.000000000 +0200
@@ -19,16 +19,15 @@
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <asm/semaphore.h>
+#include <asm/errno.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#endif
 
 #include "dvb_i2c.h"
+#include "dvb_functions.h"
+
 
 struct dvb_i2c_device {
 	struct list_head list_head;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ksyms.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ksyms.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-05-06 16:55:20.000000000 +0200
@@ -1,76 +1,15 @@
+#include <asm/uaccess.h>
+#include <asm/errno.h>
 #include <linux/module.h>
+#include <linux/ioctl.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
 
 #include "dmxdev.h"
-#include "dvb_filter.h"
-#include "dvb_frontend.h"
-#include "dvb_i2c.h"
-#include "dvbdev.h"
 #include "dvb_demux.h"
+#include "dvb_frontend.h"
 #include "dvb_net.h"
-
-/* if the miracle happens and "generic_usercopy()" is included into
-   the kernel, then this can vanish. please don't make the mistake and
-   define this as video_usercopy(). this will introduce a dependecy
-   to the v4l "videodev.o" module, which is unnecessary for some
-   cards (ie. the budget dvb-cards don't need the v4l module...) */
-int dvb_usercopy(struct inode *inode, struct file *file,
-	             unsigned int cmd, unsigned long arg,
-		     int (*func)(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg))
-{
-        char    sbuf[128];
-        void    *mbuf = NULL;
-        void    *parg = NULL;
-        int     err  = -EINVAL;
-
-        /*  Copy arguments into temp kernel buffer  */
-        switch (_IOC_DIR(cmd)) {
-        case _IOC_NONE:
-                parg = (void *)arg;
-                break;
-        case _IOC_READ: /* some v4l ioctls are marked wrong ... */
-        case _IOC_WRITE:
-        case (_IOC_WRITE | _IOC_READ):
-                if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
-                        parg = sbuf;
-                } else {
-                        /* too big to allocate from stack */
-                        mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
-                        if (NULL == mbuf)
-                                return -ENOMEM;
-                        parg = mbuf;
-                }
-
-                err = -EFAULT;
-                if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
-                        goto out;
-                break;
-        }
-
-        /* call driver */
-        if ((err = func(inode, file, cmd, parg)) == -ENOIOCTLCMD)
-                err = -EINVAL;
-
-        if (err < 0)
-                goto out;
-
-        /*  Copy results into user buffer  */
-        switch (_IOC_DIR(cmd))
-        {
-        case _IOC_READ:
-        case (_IOC_WRITE | _IOC_READ):
-                if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
-                        err = -EFAULT;
-                break;
-        }
-
-out:
-        if (mbuf)
-                kfree(mbuf);
-
-        return err;
-}
-EXPORT_SYMBOL(dvb_usercopy);
+#include "dvb_filter.h"
 
 EXPORT_SYMBOL(dvb_dmxdev_init);
 EXPORT_SYMBOL(dvb_dmxdev_release);
@@ -79,6 +18,8 @@
 EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
 EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
 EXPORT_SYMBOL(dvb_dmx_swfilter);
+EXPORT_SYMBOL(dvbdmx_connect_frontend);
+EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 EXPORT_SYMBOL(dvb_register_frontend);
 EXPORT_SYMBOL(dvb_unregister_frontend);
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_net.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_net.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_net.c	2003-04-30 12:02:58.000000000 +0200
@@ -24,15 +24,18 @@
  * 
  */
 
+#include <asm/errno.h>
 #include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ioctl.h>
+#include <linux/slab.h>
 
 #include <linux/dvb/net.h>
+
 #include "dvb_demux.h"
 #include "dvb_net.h"
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#endif
+#include "dvb_functions.h"
 
 #define DVB_NET_MULTICAST_MAX 10
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ringbuffer.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ringbuffer.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2003-03-21 16:09:55.000000000 +0100
@@ -32,10 +32,12 @@
 
 
 #define __KERNEL_SYSCALLS__
+#include <asm/uaccess.h>
+#include <asm/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/module.h>
-#include <asm/uaccess.h>
+#include <linux/sched.h>
+#include <linux/string.h>
 
 #include "dvb_ringbuffer.h"
 
@@ -50,7 +52,6 @@
         init_waitqueue_head(&rbuf->queue);
 
         spin_lock_init(&(rbuf->lock));
-        rbuf->lock=SPIN_LOCK_UNLOCKED;
 }
 
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ringbuffer.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ringbuffer.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-03-21 16:09:55.000000000 +0100
@@ -32,6 +32,9 @@
 #ifndef _DVB_RINGBUFFER_H_
 #define _DVB_RINGBUFFER_H_
 
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
 
 typedef struct dvb_ringbuffer {
         u8               *data;
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.c linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvbdev.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvbdev.c	2003-05-06 16:59:46.000000000 +0200
@@ -21,30 +21,26 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/version.h>
+#include <asm/types.h>
+#include <asm/errno.h>
+#include <asm/semaphore.h>
+#include <linux/string.h>
 #include <linux/module.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <linux/kmod.h>
 #include <linux/slab.h>
+#include <linux/version.h>
 
 #include "dvbdev.h"
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#endif
+#include "dvb_functions.h"
 
 static int dvbdev_debug = 0;
 #define dprintk if (dvbdev_debug) printk
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+static devfs_handle_t dvb_devfs_handle;
+#endif
 static LIST_HEAD(dvb_adapter_list);
 static DECLARE_MUTEX(dvbdev_register_lock);
 
@@ -55,6 +51,13 @@
 };
 
 
+#ifdef CONFIG_DVB_DEVFS_ONLY
+
+	#define DVB_MAX_IDS              ~0
+	#define nums2minor(num,type,id)  0
+
+#else
+
 #define DVB_MAX_IDS              4
 #define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 
@@ -111,6 +114,8 @@
 	.owner =	THIS_MODULE,
 	.open =		dvb_device_open,
 };
+#endif /* CONFIG_DVB_DEVFS_ONLY */
+
 
 
 int dvb_generic_open(struct inode *inode, struct file *file)
@@ -188,9 +193,9 @@
 int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev, 
 			const struct dvb_device *template, void *priv, int type)
 {
-	u32 id;
-	char name [20];
 	struct dvb_device *dvbdev;
+	char name[64];
+	int id;
 
 	if (down_interruptible (&dvbdev_register_lock))
 		return -ERESTARTSYS;
@@ -219,10 +224,23 @@
 
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
 
-	sprintf(name, "dvb/adapter%d%s%d", adap->num, dnames[type], id);
-	devfs_register(NULL, name, 0, DVB_MAJOR, nums2minor(adap->num, type, id),
-			S_IFCHR | S_IRUSR | S_IWUSR, dvbdev->fops, dvbdev);
-
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	snprintf(name, sizeof(name), "%s%d", dnames[type], id);
+	dvbdev->devfs_handle = devfs_register(adap->devfs_handle, name,
+					      DEVFS_FL_DEFAULT,
+					      DVB_MAJOR,
+					      nums2minor(adap->num, type, id),
+					      S_IFCHR | S_IRUSR | S_IWUSR,
+					      dvbdev->fops, dvbdev);
+#else
+	snprintf(name, sizeof(name), "dvb/adapter%d/%s%d", adap->num, dnames[type], id);
+	dvbdev->devfs_handle = devfs_register(NULL, name,
+					      DEVFS_FL_DEFAULT,
+					      DVB_MAJOR,
+					      nums2minor(adap->num, type, id),
+					      S_IFCHR | S_IRUSR | S_IWUSR,
+					      dvbdev->fops, dvbdev);
+#endif
 	dprintk("DVB: register adapter%d/%s @ minor: %i (0x%02x)\n",
 		adap->num, name, nums2minor(adap->num, type, id),
 		nums2minor(adap->num, type, id));
@@ -233,13 +251,25 @@
 
 void dvb_unregister_device(struct dvb_device *dvbdev)
 {
-	if (dvbdev) {
-		devfs_remove("dvb/adapter%d%s%d", dvbdev->adapter->num,
-				dnames[dvbdev->type], dvbdev->id);
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0))
+	char name[64];
+	struct dvb_adapter *adap = dvbdev->adapter;
+#endif
+
+	if (!dvbdev)
+		return;
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	devfs_unregister(dvbdev->devfs_handle);
+#else
+	snprintf(name, sizeof(name), "dvb/adapter%d/%s%d", adap->num, dnames[dvbdev->type], dvbdev->id);
+	/* fixme */
+	printk("dvb_unregister_device: %s\n",name);
+	devfs_remove(name);
+#endif
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 	}
-}
 
 
 static
@@ -266,6 +296,7 @@
 
 int dvb_register_adapter(struct dvb_adapter **padap, const char *name)
 {
+	char dirname[64];
 	struct dvb_adapter *adap;
 	int num;
 
@@ -285,13 +316,15 @@
 	memset (adap, 0, sizeof(struct dvb_adapter));
 	INIT_LIST_HEAD (&adap->device_list);
 
- 	/* fixme: is this correct? */
-	/* No */
-	try_module_get(THIS_MODULE);
-
 	printk ("DVB: registering new adapter (%s).\n", name);
 	
-	devfs_mk_dir("dvb/adapter%d", num);
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	snprintf(dirname, sizeof(dirname), "adapter%d", num);
+	adap->devfs_handle = devfs_mk_dir(dvb_devfs_handle, dirname, NULL);
+#else
+	snprintf(dirname, sizeof(dirname), "dvb/adapter%d", num);
+	devfs_mk_dir(dirname);
+#endif
 	adap->num = num;
 	adap->name = name;
 
@@ -305,15 +338,18 @@
 
 int dvb_unregister_adapter(struct dvb_adapter *adap)
 {
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	devfs_unregister(adap->devfs_handle);
+#else
+	char dirname[64];	/* fixme */
+	snprintf(dirname, sizeof(dirname), "dvb/adapter%d", adap->num);
+        devfs_remove(dirname);
+#endif
 	if (down_interruptible (&dvbdev_register_lock))
 		return -ERESTARTSYS;
-        devfs_remove("dvb/adapter%d", adap->num);
 	list_del (&adap->list_head);
 	up (&dvbdev_register_lock);
 	kfree (adap);
-	/* fixme: is this correct? */
-	/* No. */
-	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -321,7 +357,11 @@
 static
 int __init init_dvbdev(void)
 {
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	dvb_devfs_handle = devfs_mk_dir (NULL, "dvb", NULL);
+#else
 	devfs_mk_dir("dvb");
+#endif
 #ifndef CONFIG_DVB_DEVFS_ONLY
 	if(register_chrdev(DVB_MAJOR,"DVB", &dvb_device_fops)) {
 		printk("video_dev: unable to get major %d\n", DVB_MAJOR);
@@ -338,7 +378,11 @@
 #ifndef CONFIG_DVB_DEVFS_ONLY
 	unregister_chrdev(DVB_MAJOR, "DVB");
 #endif
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+	devfs_unregister(dvb_devfs_handle);
+#else
         devfs_remove("dvb");
+#endif
 }
 
 module_init(init_dvbdev);
diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.h linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvbdev.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.h	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/dvb/dvb-core/dvbdev.h	2003-05-06 16:42:56.000000000 +0200
@@ -24,9 +24,9 @@
 #ifndef _DVBDEV_H_
 #define _DVBDEV_H_
 
-#include <linux/types.h>
-#include <linux/version.h>
+#include <asm/types.h>
 #include <linux/poll.h>
+#include <linux/fs.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/list.h>
 
@@ -45,6 +45,7 @@
 
 struct dvb_adapter {
 	int num;
+	devfs_handle_t devfs_handle;
 	struct list_head list_head;
 	struct list_head device_list;
 	const char *name;
@@ -54,6 +55,7 @@
 struct dvb_device {
 	struct list_head list_head;
 	struct file_operations *fops;
+	devfs_handle_t devfs_handle;
 	struct dvb_adapter *adapter;
 	int type;
 	u32 id;
@@ -84,9 +86,5 @@
 extern int dvb_generic_release (struct inode *inode, struct file *file);
 extern int dvb_generic_ioctl (struct inode *inode, struct file *file,
 			      unsigned int cmd, unsigned long arg);
-int dvb_usercopy(struct inode *inode, struct file *file,
-                     unsigned int cmd, unsigned long arg,
-                     int (*func)(struct inode *inode, struct file *file,
-                     unsigned int cmd, void *arg));
 #endif /* #ifndef _DVBDEV_H_ */
 

--------------010504070901060405020403--


