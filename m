Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUBWVHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUBWVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:05:28 -0500
Received: from mail.convergence.de ([212.84.236.4]:44778 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261261AbUBWVE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:04:56 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 4/9] DVB core update
In-Reply-To: <1077570282137@convergence.de>
Message-Id: <107757028289@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:04:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] - dvb-core: replace usage of sleep_on_...() with wait_event_interruptible_timeout()
- [DVB] - dvb-core: fix dvb_ringbuffer_read/write() buffer pointer bug
- [DVB] video: added VIDEO_EVENT_FRAME_RATE_CHANGED and VIDEO_GET_FRAME_RATE ioctl
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.3.p/drivers/media/dvb/dvb-core/dvb_frontend.c
--- xx-linux-2.6.3/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-02-23 12:34:27.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-02-09 18:30:22.000000000 +0100
@@ -426,6 +426,7 @@
 static int dvb_frontend_thread (void *data)
 {
 	struct dvb_frontend_data *fe = (struct dvb_frontend_data *) data;
+	unsigned long timeout;
 	char name [15];
 	int quality = 0, delay = 3*HZ;
 	fe_status_t s;
@@ -442,12 +443,14 @@
 	dvb_call_frontend_notifiers (fe, 0);
 	dvb_frontend_init (fe);
 
-	while (!dvb_frontend_is_exiting (fe)) {
+	while (1) {
 		up (&fe->sem);      /* is locked when we enter the thread... */
 
-		interruptible_sleep_on_timeout (&fe->wait_queue, delay);
-		if (signal_pending(current))
+		timeout = wait_event_interruptible_timeout(fe->wait_queue,0 != dvb_frontend_is_exiting (fe), delay);
+		if (-ERESTARTSYS == timeout || 0 != dvb_frontend_is_exiting (fe)) {
+			/* got signal or quitting */
 			break;
+		}
 
 		if (down_interruptible (&fe->sem))
 			break;
@@ -455,9 +458,6 @@
 		if (fe->lost_sync_count == -1)
 			continue;
 
-		if (dvb_frontend_is_exiting (fe))
-			break;
-
 		dvb_frontend_internal_ioctl (&fe->frontend, FE_READ_STATUS, &s);
 
 		update_delay (&quality, &delay, s & FE_HAS_LOCK);
@@ -509,6 +509,8 @@
 
 static void dvb_frontend_stop (struct dvb_frontend_data *fe)
 {
+	unsigned long ret;
+	
 	dprintk ("%s\n", __FUNCTION__);
 
 		fe->exit = 1;
@@ -526,10 +528,16 @@
 		return;
 	}
 
+	/* wake up the frontend thread, so it notices that fe->exit == 1 */
 		wake_up_interruptible (&fe->wait_queue);
-	interruptible_sleep_on(&fe->wait_queue);
 
-	/* paranoia check */
+	/* wait until the frontend thread has exited */
+	ret = wait_event_interruptible(fe->wait_queue,0 == fe->thread_pid);
+	if (-ERESTARTSYS != ret) {
+		return;
+	}
+
+	/* paranoia check in case a signal arrived */
 	if (fe->thread_pid)
 		printk("dvb_frontend_stop: warning: thread PID %d won't exit\n",
 				fe->thread_pid);
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/dvb-core/dvb_ringbuffer.c linux-2.6.3.p/drivers/media/dvb/dvb-core/dvb_ringbuffer.c
--- xx-linux-2.6.3/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2004-01-09 09:22:39.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2004-02-23 12:52:31.000000000 +0100
@@ -123,7 +123,7 @@
                 if (copy_to_user(buf, rbuf->data+rbuf->pread, todo))
                         return -EFAULT;
 
-        rbuf->pread = (rbuf->pread + len) % rbuf->size;
+        rbuf->pread = (rbuf->pread + todo) % rbuf->size;
 
         return len;
 }
@@ -155,7 +155,7 @@
                 if (copy_from_user(rbuf->data+rbuf->pwrite, buf, todo)) 
                         return -EFAULT;
 
-        rbuf->pwrite = (rbuf->pwrite + len) % rbuf->size;
+        rbuf->pwrite = (rbuf->pwrite + todo) % rbuf->size;
 
 	return len;
 }
diff -uNrwB --new-file xx-linux-2.6.3/include/linux/dvb/video.h linux-2.6.3.p/include/linux/dvb/video.h
--- xx-linux-2.6.3/include/linux/dvb/video.h	2003-12-18 12:55:30.000000000 +0100
+++ linux-2.6.3.p/include/linux/dvb/video.h	2004-02-02 19:28:30.000000000 +0100
@@ -81,9 +81,11 @@
 struct video_event { 
         int32_t type; 
 #define VIDEO_EVENT_SIZE_CHANGED 1
+#define VIDEO_EVENT_FRAME_RATE_CHANGED	2
         time_t timestamp;
 	union { 
 	        video_size_t size;
+		unsigned int frame_rate;	/* in frames per 1000sec */
 	} u; 
 };
 
@@ -194,6 +196,7 @@
 #define VIDEO_GET_NAVI             _IOR('o', 52, video_navi_pack_t)
 #define VIDEO_SET_ATTRIBUTES       _IO('o', 53)
 #define VIDEO_GET_SIZE             _IOR('o', 55, video_size_t)
+#define VIDEO_GET_FRAME_RATE       _IOR('o', 56, unsigned int)
 
 #endif /*_DVBVIDEO_H_*/
 


