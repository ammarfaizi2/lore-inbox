Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWEPKqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWEPKqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWEPKqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:46:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:5848 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751759AbWEPKqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:46:42 -0400
To: linux-kernel@vger.kernel.org
Cc: levon@movementarian.org, phil.el@wanadoo.fr
Subject: [PATCH] oprofile: convert from semaphores to mutexes
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 May 2006 12:46:39 +0200
Message-ID: <87wtcmxn5c.fsf@pike.pond.sub.org>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from semaphores to mutexes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>

diff -rup a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
--- a/drivers/oprofile/buffer_sync.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/oprofile/buffer_sync.c	2006-05-16 10:42:22.000000000 +0200
@@ -108,10 +108,10 @@ static int module_load_notify(struct not
 		return 0;
 
 	/* FIXME: should we process all CPU buffers ? */
-	down(&buffer_sem);
+	mutex_lock(&buffer_mutex);
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(MODULE_LOADED_CODE);
-	up(&buffer_sem);
+	mutex_unlock(&buffer_mutex);
 #endif
 	return 0;
 }
@@ -501,7 +501,7 @@ void sync_buffer(int cpu)
 	sync_buffer_state state = sb_buffer_start;
 	unsigned long available;
 
-	down(&buffer_sem);
+	mutex_lock(&buffer_mutex);
  
 	add_cpu_switch(cpu);
 
@@ -550,5 +550,5 @@ void sync_buffer(int cpu)
 
 	mark_done(cpu);
 
-	up(&buffer_sem);
+	mutex_unlock(&buffer_mutex);
 }
diff -rup a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
--- a/drivers/oprofile/event_buffer.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/oprofile/event_buffer.c	2006-05-16 10:42:22.000000000 +0200
@@ -24,7 +24,7 @@
 #include "event_buffer.h"
 #include "oprofile_stats.h"
 
-DECLARE_MUTEX(buffer_sem);
+DEFINE_MUTEX(buffer_mutex);
  
 static unsigned long buffer_opened;
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
@@ -32,7 +32,7 @@ static unsigned long * event_buffer;
 static unsigned long buffer_size;
 static unsigned long buffer_watershed;
 static size_t buffer_pos;
-/* atomic_t because wait_event checks it outside of buffer_sem */
+/* atomic_t because wait_event checks it outside of buffer_mutex */
 static atomic_t buffer_ready = ATOMIC_INIT(0);
 
 /* Add an entry to the event buffer. When we
@@ -60,10 +60,10 @@ void add_event_entry(unsigned long value
  */
 void wake_up_buffer_waiter(void)
 {
-	down(&buffer_sem);
+	mutex_lock(&buffer_mutex);
 	atomic_set(&buffer_ready, 1);
 	wake_up(&buffer_wait);
-	up(&buffer_sem);
+	mutex_unlock(&buffer_mutex);
 }
 
  
@@ -162,7 +162,7 @@ static ssize_t event_buffer_read(struct 
 	if (!atomic_read(&buffer_ready))
 		return -EAGAIN;
 
-	down(&buffer_sem);
+	mutex_lock(&buffer_mutex);
 
 	atomic_set(&buffer_ready, 0);
 
@@ -177,7 +177,7 @@ static ssize_t event_buffer_read(struct 
 	buffer_pos = 0;
  
 out:
-	up(&buffer_sem);
+	mutex_unlock(&buffer_mutex);
 	return retval;
 }
  
diff -rup a/drivers/oprofile/event_buffer.h b/drivers/oprofile/event_buffer.h
--- a/drivers/oprofile/event_buffer.h	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/oprofile/event_buffer.h	2006-05-16 10:42:22.000000000 +0200
@@ -11,7 +11,7 @@
 #define EVENT_BUFFER_H
 
 #include <linux/types.h> 
-#include <asm/semaphore.h>
+#include <asm/mutex.h>
  
 int alloc_event_buffer(void);
 
@@ -46,6 +46,6 @@ extern struct file_operations event_buff
 /* mutex between sync_cpu_buffers() and the
  * file reading code.
  */
-extern struct semaphore buffer_sem;
+extern struct mutex buffer_mutex;
  
 #endif /* EVENT_BUFFER_H */
diff -rup a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
--- a/drivers/oprofile/oprof.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/oprofile/oprof.c	2006-05-16 10:42:22.000000000 +0200
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/oprofile.h>
 #include <linux/moduleparam.h>
-#include <asm/semaphore.h>
+#include <asm/mutex.h>
 
 #include "oprof.h"
 #include "event_buffer.h"
@@ -25,7 +25,7 @@ struct oprofile_operations oprofile_ops;
 unsigned long oprofile_started;
 unsigned long backtrace_depth;
 static unsigned long is_setup;
-static DECLARE_MUTEX(start_sem);
+static DEFINE_MUTEX(start_mutex);
 
 /* timer
    0 - use performance monitoring hardware if available
@@ -37,7 +37,7 @@ int oprofile_setup(void)
 {
 	int err;
  
-	down(&start_sem);
+	mutex_lock(&start_mutex);
 
 	if ((err = alloc_cpu_buffers()))
 		goto out;
@@ -57,7 +57,7 @@ int oprofile_setup(void)
 		goto out3;
 
 	is_setup = 1;
-	up(&start_sem);
+	mutex_unlock(&start_mutex);
 	return 0;
  
 out3:
@@ -68,7 +68,7 @@ out2:
 out1:
 	free_cpu_buffers();
 out:
-	up(&start_sem);
+	mutex_unlock(&start_mutex);
 	return err;
 }
 
@@ -78,7 +78,7 @@ int oprofile_start(void)
 {
 	int err = -EINVAL;
  
-	down(&start_sem);
+	mutex_lock(&start_mutex);
  
 	if (!is_setup)
 		goto out;
@@ -95,7 +95,7 @@ int oprofile_start(void)
 
 	oprofile_started = 1;
 out:
-	up(&start_sem); 
+	mutex_unlock(&start_mutex); 
 	return err;
 }
 
@@ -103,7 +103,7 @@ out:
 /* echo 0>/dev/oprofile/enable */
 void oprofile_stop(void)
 {
-	down(&start_sem);
+	mutex_lock(&start_mutex);
 	if (!oprofile_started)
 		goto out;
 	oprofile_ops.stop();
@@ -111,20 +111,20 @@ void oprofile_stop(void)
 	/* wake up the daemon to read what remains */
 	wake_up_buffer_waiter();
 out:
-	up(&start_sem);
+	mutex_unlock(&start_mutex);
 }
 
 
 void oprofile_shutdown(void)
 {
-	down(&start_sem);
+	mutex_lock(&start_mutex);
 	sync_stop();
 	if (oprofile_ops.shutdown)
 		oprofile_ops.shutdown();
 	is_setup = 0;
 	free_event_buffer();
 	free_cpu_buffers();
-	up(&start_sem);
+	mutex_unlock(&start_mutex);
 }
 
 
@@ -132,7 +132,7 @@ int oprofile_set_backtrace(unsigned long
 {
 	int err = 0;
 
-	down(&start_sem);
+	mutex_lock(&start_mutex);
 
 	if (oprofile_started) {
 		err = -EBUSY;
@@ -147,7 +147,7 @@ int oprofile_set_backtrace(unsigned long
 	backtrace_depth = val;
 
 out:
-	up(&start_sem);
+	mutex_unlock(&start_mutex);
 	return err;
 }
 
