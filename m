Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVEAWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEAWbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEAWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:31:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:23244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261186AbVEAWbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:31:25 -0400
Date: Sun, 1 May 2005 15:30:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Message-Id: <20050501153051.2471294e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
References: <200505012021.56649.arvidjaar@mail.ru>
	<Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, 1 May 2005, Andrey Borzenkov wrote:
> 
> > Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number of 
> > distributions switching init levels implicitly does "killall -9", killing 
> > khubd. The only way to restart it is to reload USB subsystem.
> > 
> > Is signal usage in this case really needed? What about replacing it with 
> > simple flag (i.e. will patch be accepted)?
> 
> IMO the problem lies in those distributions.  They should not
> indiscrimately kill processes when switching init levels.

Nevertheless it's better that kernel internals not be exposed to userspace
actions in this manner, and using signals for in-kernel IPC is crufty, IMO.

It's pretty simple to convert khubd to use the kthread API.  Something like
this (untested):

 drivers/usb/core/hub.c |   40 +++++++++++-----------------------------
 1 files changed, 11 insertions(+), 29 deletions(-)

diff -puN drivers/usb/core/hub.c~hub-use-kthread drivers/usb/core/hub.c
--- 25/drivers/usb/core/hub.c~hub-use-kthread	2005-05-01 15:22:24.634539928 -0700
+++ 25-akpm/drivers/usb/core/hub.c	2005-05-01 15:29:55.739961480 -0700
@@ -26,6 +26,7 @@
 #include <linux/ioctl.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
+#include <linux/kthread.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -47,8 +48,7 @@ static LIST_HEAD(hub_event_list);	/* Lis
 /* Wakes up khubd */
 static DECLARE_WAIT_QUEUE_HEAD(khubd_wait);
 
-static pid_t khubd_pid = 0;			/* PID of khubd */
-static DECLARE_COMPLETION(khubd_exited);
+static struct task_struct *khubd_task;
 
 /* cycle leds on hubs that aren't blinking for attention */
 static int blinkenlights = 0;
@@ -2807,23 +2807,16 @@ loop:
 
 static int hub_thread(void *__unused)
 {
-	/*
-	 * This thread doesn't need any user-level access,
-	 * so get rid of all our resources
-	 */
-
-	daemonize("khubd");
-	allow_signal(SIGKILL);
-
-	/* Send me a signal to get me die (for debugging) */
 	do {
 		hub_events();
-		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
+		wait_event_interruptible(khubd_wait,
+				!list_empty(&hub_event_list) ||
+				kthread_should_stop());
 		try_to_freeze(PF_FREEZE);
-	} while (!signal_pending(current));
+	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
-	pr_debug ("%s: khubd exiting\n", usbcore_name);
-	complete_and_exit(&khubd_exited, 0);
+	pr_debug("%s: khubd exiting\n", usbcore_name);
+	return 0;
 }
 
 static struct usb_device_id hub_id_table [] = {
@@ -2849,20 +2842,15 @@ static struct usb_driver hub_driver = {
 
 int usb_hub_init(void)
 {
-	pid_t pid;
-
 	if (usb_register(&hub_driver) < 0) {
 		printk(KERN_ERR "%s: can't register hub driver\n",
 			usbcore_name);
 		return -1;
 	}
 
-	pid = kernel_thread(hub_thread, NULL, CLONE_KERNEL);
-	if (pid >= 0) {
-		khubd_pid = pid;
-
+	khubd_task = kthread_run(hub_thread, NULL, "khubd");
+	if (!IS_ERR(khubd_task))
 		return 0;
-	}
 
 	/* Fall through if kernel_thread failed */
 	usb_deregister(&hub_driver);
@@ -2873,12 +2861,7 @@ int usb_hub_init(void)
 
 void usb_hub_cleanup(void)
 {
-	int ret;
-
-	/* Kill the thread */
-	ret = kill_proc(khubd_pid, SIGKILL, 1);
-
-	wait_for_completion(&khubd_exited);
+	kthread_stop(khubd_task);
 
 	/*
 	 * Hub resources are freed for us by usb_deregister. It calls
@@ -2890,7 +2873,6 @@ void usb_hub_cleanup(void)
 	usb_deregister(&hub_driver);
 } /* usb_hub_cleanup() */
 
-
 static int config_descriptors_changed(struct usb_device *udev)
 {
 	unsigned			index;
_

