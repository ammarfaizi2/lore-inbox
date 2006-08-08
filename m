Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWHHSih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWHHSih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWHHSih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:38:37 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:14984 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S964924AbWHHSig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:38:36 -0400
Message-ID: <44D8DA28.1030005@oracle.com>
Date: Tue, 08 Aug 2006 11:38:32 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Voyager, tty locking
References: <1155060469.5729.109.camel@localhost.localdomain>	 <44D8D073.5080505@oracle.com> <1155060288.26517.43.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1155060288.26517.43.camel@mulgrave.il.steeleye.com>
Content-Type: multipart/mixed;
 boundary="------------070601070700080603080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601070700080603080702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> I'll add the kthread conversion to my list ... unless the suggestor also
> wants to become the implementor?

Well, here's a start that builds.  I didn't want to get too close to the
nutty sem and timeout logic.

- z
[ apologies for the attachment ]

--------------070601070700080603080702
Content-Type: text/x-patch;
 name="voyager-thread-to-kthread.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="voyager-thread-to-kthread.patch"

Index: 2.6.18-rc4-removing-foot-from-mouth/arch/i386/mach-voyager/voyager_thread.c
===================================================================
--- 2.6.18-rc4-removing-foot-from-mouth.orig/arch/i386/mach-voyager/voyager_thread.c
+++ 2.6.18-rc4-removing-foot-from-mouth/arch/i386/mach-voyager/voyager_thread.c
@@ -24,34 +24,21 @@
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <asm/desc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 
-#define THREAD_NAME "kvoyagerd"
-
 /* external variables */
 int kvoyagerd_running = 0;
 DECLARE_MUTEX_LOCKED(kvoyagerd_sem);
 
-static int thread(void *);
+static struct task_struct *voyager_task;
 
 static __u8 set_timeout = 0;
 
-/* Start the machine monitor thread.  Return 1 if OK, 0 if fail */
-static int __init
-voyager_thread_start(void)
-{
-	if(kernel_thread(thread, NULL, CLONE_KERNEL) < 0) {
-		/* This is serious, but not fatal */
-		printk(KERN_ERR "Voyager: Failed to create system monitor thread!!!\n");
-		return 1;
-	}
-	return 0;
-}
-
 static int
 execute(const char *string)
 {
@@ -116,25 +103,19 @@ wakeup(unsigned long unused)
 	up(&kvoyagerd_sem);
 }
 
-static int
-thread(void *unused)
+static int voyager_thread(void *unused)
 {
 	struct timer_list wakeup_timer;
 
 	kvoyagerd_running = 1;
 
-	daemonize(THREAD_NAME);
-
 	set_timeout = 0;
 
 	init_timer(&wakeup_timer);
 
-	sigfillset(&current->blocked);
-	current->signal->tty = NULL;
-
 	printk(KERN_NOTICE "Voyager starting monitor thread\n");
 
-	for(;;) {
+	while(!kthread_should_stop()) {
 		down_interruptible(&kvoyagerd_sem);
 		VDEBUG(("Voyager Daemon awoken\n"));
 		if(voyager_status.request_from_kernel == 0) {
@@ -151,13 +132,28 @@ thread(void *unused)
 			add_timer(&wakeup_timer);
 		}
 	}
+
+	return 0;
+}
+
+/* Start the machine monitor thread.  Return 1 if OK, 0 if fail */
+static int __init voyager_thread_init(void)
+{
+	voyager_task = kthread_run(voyager_thread, NULL, "kvoyagerd");
+	if (IS_ERR(voyager_task)) {
+		/* This is serious, but not fatal */
+		printk(KERN_ERR "Voyager: Failed to create system monitor thread! error %ld\n", PTR_ERR(voyager_task));
+		return PTR_ERR(voyager_task);
+	}
+
+	return 0;
 }
+module_init(voyager_thread_init);
 
-static void __exit
-voyager_thread_stop(void)
+static void __exit voyager_thread_exit(void)
 {
-	/* FIXME: do nothing at the moment */
+	if (voyager_task && !IS_ERR(voyager_task))
+		kthread_stop(voyager_task);
 }
+module_exit(voyager_thread_exit);
 
-module_init(voyager_thread_start);
-//module_exit(voyager_thread_stop);

--------------070601070700080603080702--
