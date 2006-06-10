Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWFJShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWFJShd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWFJShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:37:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16610 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030491AbWFJShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:37:32 -0400
Date: Sat, 10 Jun 2006 19:37:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       "Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
Message-ID: <20060610183703.GA1497@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@ubuntu.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Serge E. Hallyn" <serue@us.ibm.com>, weihs@ict.tuwien.ac.at,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de> <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson> <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149962931.4448.557.camel@grayson>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 02:08:50PM -0400, Ben Collins wrote:
> Most rescans are initiated by a bus reset (usually caused by a
> connect/disconnect of a device) that is detected in interrupt.
> Obviously, we cannot initiate these rescans in interrupt, so a tasklet
> or kthread is the only option.
> 
> The reason for handling user-initiated rescans (through some sysfs
> interface?) and hardware-initiated rescans in the same place is code
> simplicity, and synchronization.
> 
> I'm not sure what your implying about user-initiated rescans. The only
> thing I can think of is device/driver binding, which isn't handled in
> our kernel thread anyway (except where it's a new device being detected,
> as opposed to a new driver being loaded).

Sorry, I was confused when looking at the code.  There are two calls
to kernel_thread in drivers/ieee1394/nodemgr.c.  The first one is from
fw_set_rescan, which handles a writeable sysfs attribute.  For that all
my comments in this thread stand, and I think it should not start a
thread.

The second one is the actual, real daemon you talked about most of the
time.  That one should of course stay a kernel thread!

Below is a draft patch to convert it to the kthread API and replace the
reset_sem with a simple wake_up_process scheme.  I removed the down_trylock
loop there which I think should be fine because we get the wakeup again
ASAP, but please double-check.


Index: linux-2.6/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.orig/drivers/ieee1394/nodemgr.c	2006-06-10 20:25:14.000000000 +0200
+++ linux-2.6/drivers/ieee1394/nodemgr.c	2006-06-10 20:33:01.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/kthread.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -113,11 +114,7 @@
 struct host_info {
 	struct hpsb_host *host;
 	struct list_head list;
-	struct completion exited;
-	struct semaphore reset_sem;
-	int pid;
-	char daemon_name[15];
-	int kill_me;
+	struct task_struct *thread;
 };
 
 static int nodemgr_bus_match(struct device * dev, struct device_driver * drv);
@@ -1567,9 +1564,6 @@
 	struct hpsb_host *host = hi->host;
 	int reset_cycles = 0;
 
-	/* No userlevel access needed */
-	daemonize(hi->daemon_name);
-
 	/* Setup our device-model entries */
 	nodemgr_create_host_dev_files(host);
 
@@ -1579,15 +1573,14 @@
 		unsigned int generation = 0;
 		int i;
 
-		if (down_interruptible(&hi->reset_sem) ||
-		    down_interruptible(&nodemgr_serialize)) {
+		if (down_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
 			break;
 		}
 
-		if (hi->kill_me) {
+		if (kthread_should_stop()) {
 			up(&nodemgr_serialize);
 			break;
 		}
@@ -1608,13 +1601,8 @@
 			 * returning bogus data. */
 			generation = get_hpsb_generation(host);
 
-			/* If we get a reset before we are done waiting, then
-			 * start the the waiting over again */
-			while (!down_trylock(&hi->reset_sem))
-				i = 0;
-
-			/* Check the kill_me again */
-			if (hi->kill_me) {
+			/* Check the whether we should stop again */
+			if (kthread_should_stop()) {
 				up(&nodemgr_serialize);
 				goto caught_signal;
 			}
@@ -1647,7 +1635,7 @@
 caught_signal:
 	HPSB_VERBOSE("NodeMgr: Exiting thread");
 
-	complete_and_exit(&hi->exited, 0);
+	return 0;
 }
 
 int nodemgr_for_each_host(void *__data, int (*cb)(struct hpsb_host *, void *))
@@ -1714,16 +1702,11 @@
 	}
 
 	hi->host = host;
-	init_completion(&hi->exited);
-        sema_init(&hi->reset_sem, 0);
+	hi->thread = kthread_create(nodemgr_host_thread, hi, "knodemgrd_%d", host->id);
 
-	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
-
-	hi->pid = kernel_thread(nodemgr_host_thread, hi, CLONE_KERNEL);
-
-	if (hi->pid < 0) {
-		HPSB_ERR ("NodeMgr: failed to start %s thread for %s",
-			  hi->daemon_name, host->driver->name);
+	if (IS_ERR(hi->thread)) {
+		HPSB_ERR ("NodeMgr: failed to start thread for %s",
+			  host->driver->name);
 		hpsb_destroy_hostinfo(&nodemgr_highlevel, host);
 		return;
 	}
@@ -1736,8 +1719,7 @@
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi != NULL) {
-		HPSB_VERBOSE("NodeMgr: Processing host reset for %s", hi->daemon_name);
-		up(&hi->reset_sem);
+		wake_up_process(hi->thread);
 	} else
 		HPSB_ERR ("NodeMgr: could not process reset of unused host");
 
@@ -1749,13 +1731,8 @@
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi) {
-		if (hi->pid >= 0) {
-			hi->kill_me = 1;
-			mb();
-			up(&hi->reset_sem);
-			wait_for_completion(&hi->exited);
-			nodemgr_remove_host_dev(&host->device);
-		}
+		kthread_stop(hi->thread);
+		nodemgr_remove_host_dev(&host->device);
 	} else
 		HPSB_ERR("NodeMgr: host %s does not exist, cannot remove",
 			 host->driver->name);
