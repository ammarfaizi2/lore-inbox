Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWHaBCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWHaBCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHaBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:02:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10436 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932286AbWHaBCs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:02:48 -0400
Date: Wed, 30 Aug 2006 18:02:49 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       video4linux-list@redhat.com, kraxel@bytesex.org, haveblue@us.ibm.com,
       serue@us.ibm.com, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
Message-ID: <20060831010249.GA2198@us.ibm.com>
References: <20060829211555.GB1945@us.ibm.com> <20060829143902.a6aa2712.akpm@osdl.org> <44F5BD23.3000209@fr.ibm.com> <20060830094943.bad0d618.akpm@osdl.org> <1156959402.3852.82.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1156959402.3852.82.camel@praia>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab [mchehab@infradead.org] wrote:
| Em Qua, 2006-08-30 às 09:49 -0700, Andrew Morton escreveu:
| > On Wed, 30 Aug 2006 18:30:27 +0200
| > Cedric Le Goater <clg@fr.ibm.com> wrote:
| > 
| 
| It is likely to work if we remove allow_signal and replacing the
| signal_pending() by kthread_should_stop() as above.
| 
| The better is to check the real patch on a saa7134 hardware before
| submiting to mainstream. You may submit the final patch for us to test
| at the proper hardware.
| 

Thanks for all the input. Mauro, thanks for help with testing.
Here is an updated patch that removes the signal code and the race.

---

Replace kernel_thread() with kthread_run() since kernel_thread()
is deprecated in drivers/modules. Also remove signalling code
as it is not needed in the driver.

Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Serge Hallyn <serue@us.ibm.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Containers@lists.osdl.org
Cc: video4linux-list@redhat.com
Cc: v4l-dvb-maintainer@linuxtv.org

 drivers/media/video/saa7134/saa7134-tvaudio.c |   45 +++++++++++++-------------
 drivers/media/video/saa7134/saa7134.h         |    4 --
 2 files changed, 24 insertions(+), 25 deletions(-)

Index: lx26-18-rc5/drivers/media/video/saa7134/saa7134.h
===================================================================
--- lx26-18-rc5.orig/drivers/media/video/saa7134/saa7134.h	2006-08-29 18:35:53.000000000 -0700
+++ lx26-18-rc5/drivers/media/video/saa7134/saa7134.h	2006-08-29 18:35:56.000000000 -0700
@@ -311,10 +311,8 @@ struct saa7134_pgtable {
 
 /* tvaudio thread status */
 struct saa7134_thread {
-	pid_t                      pid;
-	struct completion          exit;
+	struct task_struct *       task;
 	wait_queue_head_t          wq;
-	unsigned int               shutdown;
 	unsigned int               scan1;
 	unsigned int               scan2;
 	unsigned int               mode;
Index: lx26-18-rc5/drivers/media/video/saa7134/saa7134-tvaudio.c
===================================================================
--- lx26-18-rc5.orig/drivers/media/video/saa7134/saa7134-tvaudio.c	2006-08-29 18:35:53.000000000 -0700
+++ lx26-18-rc5/drivers/media/video/saa7134/saa7134-tvaudio.c	2006-08-30 14:09:00.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
+#include <linux/kthread.h>
 #include <asm/div64.h>
 
 #include "saa7134-reg.h"
@@ -357,16 +358,22 @@ static int tvaudio_sleep(struct saa7134_
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(&dev->thread.wq, &wait);
-	if (dev->thread.scan1 == dev->thread.scan2 && !dev->thread.shutdown) {
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	if (dev->thread.scan1 == dev->thread.scan2 && !kthread_should_stop()) {
 		if (timeout < 0) {
-			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 		} else {
 			schedule_timeout_interruptible
 						(msecs_to_jiffies(timeout));
 		}
 	}
+
+	set_current_state(TASK_RUNNING);
+
 	remove_wait_queue(&dev->thread.wq, &wait);
+
 	return dev->thread.scan1 != dev->thread.scan2;
 }
 
@@ -521,11 +528,9 @@ static int tvaudio_thread(void *data)
 	unsigned int i, audio, nscan;
 	int max1,max2,carrier,rx,mode,lastmode,default_carrier;
 
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
 	for (;;) {
 		tvaudio_sleep(dev,-1);
-		if (dev->thread.shutdown || signal_pending(current))
+		if (kthread_should_stop())
 			goto done;
 
 	restart:
@@ -633,7 +638,7 @@ static int tvaudio_thread(void *data)
 		for (;;) {
 			if (tvaudio_sleep(dev,5000))
 				goto restart;
-			if (dev->thread.shutdown || signal_pending(current))
+			if (kthread_should_stop())
 				break;
 			if (UNSET == dev->thread.mode) {
 				rx = tvaudio_getstereo(dev,&tvaudio[i]);
@@ -649,7 +654,6 @@ static int tvaudio_thread(void *data)
 	}
 
  done:
-	complete_and_exit(&dev->thread.exit, 0);
 	return 0;
 }
 
@@ -798,9 +802,6 @@ static int tvaudio_thread_ddep(void *dat
 	struct saa7134_dev *dev = data;
 	u32 value, norms, clock;
 
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
-
 	clock = saa7134_boards[dev->board].audio_clock;
 	if (UNSET != audio_clock_override)
 		clock = audio_clock_override;
@@ -812,7 +813,7 @@ static int tvaudio_thread_ddep(void *dat
 
 	for (;;) {
 		tvaudio_sleep(dev,-1);
-		if (dev->thread.shutdown || signal_pending(current))
+		if (kthread_should_stop())
 			goto done;
 
 	restart:
@@ -894,7 +895,6 @@ static int tvaudio_thread_ddep(void *dat
 	}
 
  done:
-	complete_and_exit(&dev->thread.exit, 0);
 	return 0;
 }
 
@@ -1004,15 +1004,16 @@ int saa7134_tvaudio_init2(struct saa7134
 		break;
 	}
 
-	dev->thread.pid = -1;
+	dev->thread.task = NULL;
 	if (my_thread) {
 		/* start tvaudio thread */
 		init_waitqueue_head(&dev->thread.wq);
-		init_completion(&dev->thread.exit);
-		dev->thread.pid = kernel_thread(my_thread,dev,0);
-		if (dev->thread.pid < 0)
-			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+		dev->thread.task = kthread_run(my_thread, dev, dev->name);
+		if (IS_ERR(dev->thread.task)) {
+			printk(KERN_WARNING "%s: failed to create kthread\n",
 			       dev->name);
+			dev->thread.task = NULL;
+		}
 		saa7134_tvaudio_do_scan(dev);
 	}
 
@@ -1023,10 +1024,10 @@ int saa7134_tvaudio_init2(struct saa7134
 int saa7134_tvaudio_fini(struct saa7134_dev *dev)
 {
 	/* shutdown tvaudio thread */
-	if (dev->thread.pid >= 0) {
-		dev->thread.shutdown = 1;
-		wake_up_interruptible(&dev->thread.wq);
-		wait_for_completion(&dev->thread.exit);
+	if (dev->thread.task) {
+		/* kthread_stop() wakes up the thread */
+		kthread_stop(dev->thread.task);
+		dev->thread.task = NULL;
 	}
 	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x07, 0x00); /* LINE1 */
 	return 0;
@@ -1034,7 +1035,7 @@ int saa7134_tvaudio_fini(struct saa7134_
 
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev)
 {
-	if (dev->thread.pid >= 0) {
+	if (dev->thread.task) {
 		dev->thread.mode = UNSET;
 		dev->thread.scan2++;
 		wake_up_interruptible(&dev->thread.wq);
