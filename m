Return-Path: <linux-kernel-owner+w=401wt.eu-S965005AbWLMPzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWLMPzV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWLMPzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:55:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:32914 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005AbWLMPzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:55:19 -0500
Message-ID: <45802260.1070201@fr.ibm.com>
Date: Wed, 13 Dec 2006 16:55:12 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Cedric Le Goater <clg@fr.ibm.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Devel] Re: [PATCH/RFC] kthread API conversion for dvb_frontend
 and	av7110
References: <45019CC3.2030709@fr.ibm.com> <4509C4A5.5030600@fr.ibm.com>	<20060914221024.GB26916@MAIL.13thfloor.at>	<200611170150.02207.adq_dvb@lidskialf.net>	<m1ejr4rabb.fsf@ebiederm.dsl.xmission.com> <20061212231315.GA32222@MAIL.13thfloor.at>
In-Reply-To: <20061212231315.GA32222@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Tue, Dec 12, 2006 at 03:58:16PM -0700, Eric W. Biederman wrote:
>> Andrew de Quincey <adq_dvb@lidskialf.net> writes:
>>
>>> [snip]
>>>
>>>> correct, will fix that up in the next round
>>>>
>>>> thanks for the feedback,
>>>> Herbert
>>> Hi - the conversion looks good to me.. I can't really offer any more
>>> constructive suggestions beyond what Cedric has already said.
>>>
>>> Theres another thread in dvb_ca_en50221.c that could be converted as well
>>> though, hint hint ;)
>>>
>>> Apologies for the delay in this reply - I've been hibernating for a bit.
>> Guys where are we at on this conversion?

I said I would but I didn't have much time yet? 

however, I didn't see any big issue. no semaphore like in dvb_frontend.c. 
just some kill(0) that looks harmless. 
 
> I can take a look at it in the next few days, but
> I have no hardware to test that, so it would be
> good to get in contact with somebody who does

neither do I.

below is an updated version of herbert's dvb_frontend.c patch for 2.6.19-mm1
  
thanks,

C.

From: Herbert Poetzl <herbert@13thfloor.at>

Okay, as I promised, I had a first shot at the
dvb kernel_thread to kthread API port, and here
is the result, which is running fine here since
yesterday, including module load/unload and
software suspend (which doesn't work as expected
with or without this patch :), I didn't convert
the dvb_ca_en50221 as I do not have such an
interface, but if the conversion process is fine
with the v4l-dvb maintainers, it should not be
a problem to send a patch for that too ...

best,
Herbert

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>

---
 drivers/media/dvb/dvb-core/dvb_frontend.c |   69 ++++++++++--------------------
 drivers/media/dvb/ttpci/av7110.c          |   29 +++++-------
 drivers/media/dvb/ttpci/av7110.h          |    1 
 3 files changed, 37 insertions(+), 62 deletions(-)

Index: 2.6.19-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- 2.6.19-mm1.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ 2.6.19-mm1/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/freezer.h>
 #include <linux/jiffies.h>
+#include <linux/kthread.h>
 #include <asm/processor.h>
 
 #include "dvb_frontend.h"
@@ -100,7 +101,7 @@ struct dvb_frontend_private {
 	struct semaphore sem;
 	struct list_head list_head;
 	wait_queue_head_t wait_queue;
-	pid_t thread_pid;
+	struct task_struct *thread;
 	unsigned long release_jiffies;
 	unsigned int exit;
 	unsigned int wakeup;
@@ -508,19 +509,11 @@ static int dvb_frontend_thread(void *dat
 	struct dvb_frontend *fe = data;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	unsigned long timeout;
-	char name [15];
 	fe_status_t s;
 	struct dvb_frontend_parameters *params;
 
 	dprintk("%s\n", __FUNCTION__);
 
-	snprintf (name, sizeof(name), "kdvb-fe-%i", fe->dvb->num);
-
-	lock_kernel();
-	daemonize(name);
-	sigfillset(&current->blocked);
-	unlock_kernel();
-
 	fepriv->check_wrapped = 0;
 	fepriv->quality = 0;
 	fepriv->delay = 3*HZ;
@@ -534,14 +527,16 @@ static int dvb_frontend_thread(void *dat
 		up(&fepriv->sem);	    /* is locked when we enter the thread... */
 
 		timeout = wait_event_interruptible_timeout(fepriv->wait_queue,
-							   dvb_frontend_should_wakeup(fe),
-							   fepriv->delay);
-		if (0 != dvb_frontend_is_exiting(fe)) {
+			dvb_frontend_should_wakeup(fe) || kthread_should_stop(),
+			fepriv->delay);
+
+		if (kthread_should_stop() || dvb_frontend_is_exiting(fe)) {
 			/* got signal or quitting */
 			break;
 		}
 
-		try_to_freeze();
+		if (try_to_freeze())
+			continue;
 
 		if (down_interruptible(&fepriv->sem))
 			break;
@@ -591,7 +586,7 @@ static int dvb_frontend_thread(void *dat
 			fe->ops.sleep(fe);
 	}
 
-	fepriv->thread_pid = 0;
+	fepriv->thread = NULL;
 	mb();
 
 	dvb_frontend_wakeup(fe);
@@ -600,7 +595,6 @@ static int dvb_frontend_thread(void *dat
 
 static void dvb_frontend_stop(struct dvb_frontend *fe)
 {
-	unsigned long ret;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -608,33 +602,17 @@ static void dvb_frontend_stop(struct dvb
 	fepriv->exit = 1;
 	mb();
 
-	if (!fepriv->thread_pid)
+	if (!fepriv->thread)
 		return;
 
-	/* check if the thread is really alive */
-	if (kill_proc(fepriv->thread_pid, 0, 1) == -ESRCH) {
-		printk("dvb_frontend_stop: thread PID %d already died\n",
-				fepriv->thread_pid);
-		/* make sure the mutex was not held by the thread */
-		init_MUTEX (&fepriv->sem);
-		return;
-	}
-
-	/* wake up the frontend thread, so it notices that fe->exit == 1 */
-	dvb_frontend_wakeup(fe);
-
-	/* wait until the frontend thread has exited */
-	ret = wait_event_interruptible(fepriv->wait_queue,0 == fepriv->thread_pid);
-	if (-ERESTARTSYS != ret) {
-		fepriv->state = FESTATE_IDLE;
-		return;
-	}
+	kthread_stop(fepriv->thread);
+	init_MUTEX (&fepriv->sem);
 	fepriv->state = FESTATE_IDLE;
 
 	/* paranoia check in case a signal arrived */
-	if (fepriv->thread_pid)
-		printk("dvb_frontend_stop: warning: thread PID %d won't exit\n",
-				fepriv->thread_pid);
+	if (fepriv->thread)
+		printk("dvb_frontend_stop: warning: thread %p won't exit\n",
+				fepriv->thread);
 }
 
 s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime)
@@ -684,10 +662,11 @@ static int dvb_frontend_start(struct dvb
 {
 	int ret;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
+	struct task_struct *fe_thread;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (fepriv->thread_pid) {
+	if (fepriv->thread) {
 		if (!fepriv->exit)
 			return 0;
 		else
@@ -701,18 +680,18 @@ static int dvb_frontend_start(struct dvb
 
 	fepriv->state = FESTATE_IDLE;
 	fepriv->exit = 0;
-	fepriv->thread_pid = 0;
+	fepriv->thread = NULL;
 	mb();
 
-	ret = kernel_thread (dvb_frontend_thread, fe, 0);
-
-	if (ret < 0) {
-		printk("dvb_frontend_start: failed to start kernel_thread (%d)\n", ret);
+	fe_thread = kthread_run(dvb_frontend_thread, fe,
+		"kdvb-fe-%i", fe->dvb->num);
+	if (IS_ERR(fe_thread)) {
+		ret = PTR_ERR(fe_thread);
+		printk("dvb_frontend_start: failed to start kthread (%d)\n", ret);
 		up(&fepriv->sem);
 		return ret;
 	}
-	fepriv->thread_pid = ret;
-
+	fepriv->thread = fe_thread;
 	return 0;
 }
 
Index: 2.6.19-mm1/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- 2.6.19-mm1.orig/drivers/media/dvb/ttpci/av7110.c
+++ 2.6.19-mm1/drivers/media/dvb/ttpci/av7110.c
@@ -51,6 +51,7 @@
 #include <linux/firmware.h>
 #include <linux/crc32.h>
 #include <linux/i2c.h>
+#include <linux/kthread.h>
 
 #include <asm/system.h>
 
@@ -223,11 +224,10 @@ static void recover_arm(struct av7110 *a
 
 static void av7110_arm_sync(struct av7110 *av7110)
 {
-	av7110->arm_rmmod = 1;
-	wake_up_interruptible(&av7110->arm_wait);
+	if (av7110->arm_thread)
+		kthread_stop(av7110->arm_thread);
 
-	while (av7110->arm_thread)
-		msleep(1);
+	av7110->arm_thread = NULL;
 }
 
 static int arm_thread(void *data)
@@ -238,17 +238,11 @@ static int arm_thread(void *data)
 
 	dprintk(4, "%p\n",av7110);
 
-	lock_kernel();
-	daemonize("arm_mon");
-	sigfillset(&current->blocked);
-	unlock_kernel();
-
-	av7110->arm_thread = current;
-
 	for (;;) {
 		timeout = wait_event_interruptible_timeout(av7110->arm_wait,
-							   av7110->arm_rmmod, 5 * HZ);
-		if (-ERESTARTSYS == timeout || av7110->arm_rmmod) {
+			kthread_should_stop(), 5 * HZ);
+
+		if (-ERESTARTSYS == timeout || kthread_should_stop()) {
 			/* got signal or told to quit*/
 			break;
 		}
@@ -276,7 +270,6 @@ static int arm_thread(void *data)
 		av7110->arm_errors = 0;
 	}
 
-	av7110->arm_thread = NULL;
 	return 0;
 }
 
@@ -2338,6 +2331,7 @@ static int __devinit av7110_attach(struc
 	const int length = TS_WIDTH * TS_HEIGHT;
 	struct pci_dev *pdev = dev->pci;
 	struct av7110 *av7110;
+	struct task_struct *thread;
 	int ret, count = 0;
 
 	dprintk(4, "dev: %p\n", dev);
@@ -2622,9 +2616,12 @@ static int __devinit av7110_attach(struc
 		printk ("dvb-ttpci: Warning, firmware version 0x%04x is too old. "
 			"System might be unstable!\n", FW_VERSION(av7110->arm_app));
 
-	ret = kernel_thread(arm_thread, (void *) av7110, 0);
-	if (ret < 0)
+	thread = kthread_run(arm_thread, (void *) av7110, "arm_mon");
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
 		goto err_stop_arm_9;
+	}
+	av7110->arm_thread = thread;
 
 	/* set initial volume in mixer struct */
 	av7110->mixer.volume_left  = volume;
Index: 2.6.19-mm1/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- 2.6.19-mm1.orig/drivers/media/dvb/ttpci/av7110.h
+++ 2.6.19-mm1/drivers/media/dvb/ttpci/av7110.h
@@ -205,7 +205,6 @@ struct av7110 {
 	struct task_struct *arm_thread;
 	wait_queue_head_t   arm_wait;
 	u16		    arm_loops;
-	int		    arm_rmmod;
 
 	void		   *debi_virt;
 	dma_addr_t	    debi_bus;

