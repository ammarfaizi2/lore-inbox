Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVHEELu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVHEELu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 00:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVHEELk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 00:11:40 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:13450 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262854AbVHEEJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 00:09:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Petrini <d.pensator@gmail.com>
Subject: [PATCH] Timer Top tweaks
Date: Fri, 5 Aug 2005 14:05:50 +1000
User-Agent: KMail/1.8.1
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, ilias.biris@indt.org.br
References: <200508031559.24704.kernel@kolivas.org> <9268368b050804141525539666@mail.gmail.com>
In-Reply-To: <9268368b050804141525539666@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eWu8CigMjtFRGXl"
Message-Id: <200508051405.50529.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eWu8CigMjtFRGXl
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 5 Aug 2005 07:15 am, Daniel Petrini wrote:
> Hi,
>
> Here we have some support to have more tests on Dynamic Tick.
> We have some functions that exports timers information to a proc entry
> (/proc/top_info), in a kernel patch and a script that handles this
> info and give some output to analyse. We tried to make it less
> intrusive as possible.
>
> It is based in suggestions from Tony Lindgren.
>
> It is experimental and should evolve.
>
> Must be applied after 2.6.13-rc5-dtck-3.patch and 2.6.13-rc5.
>
> Usage: with kernel compiled with attached patch: "perl timer_top.pl
> 5", to have refresh time of 5s.

Yes that's very nice.

It's probably premature but here's a small patch to your timer_top patch. 

Cheers,
Con
---



--Boundary-00=_eWu8CigMjtFRGXl
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="timer_top_tweaks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="timer_top_tweaks.patch"

Index: linux-2.6.13-rc5-ck2/kernel/Makefile
===================================================================
--- linux-2.6.13-rc5-ck2.orig/kernel/Makefile	2005-08-05 13:41:26.000000000 +1000
+++ linux-2.6.13-rc5-ck2/kernel/Makefile	2005-08-05 13:49:23.000000000 +1000
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o timer_top.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
@@ -30,7 +30,7 @@ obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
-obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o timer_top.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.13-rc5-ck2/kernel/timer.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/kernel/timer.c	2005-08-05 13:41:26.000000000 +1000
+++ linux-2.6.13-rc5-ck2/kernel/timer.c	2005-08-05 13:57:23.000000000 +1000
@@ -509,7 +509,9 @@ static inline void __run_timers(tvec_bas
 
 #ifdef CONFIG_NO_IDLE_HZ
 extern struct timer_top_info top_info;
-extern int account_timer(unsigned int function, struct timer_top_info * top_info);
+extern int account_timer(unsigned int function,
+			struct timer_top_info *top_info);
+
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
Index: linux-2.6.13-rc5-ck2/kernel/timer_top.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/kernel/timer_top.c	2005-08-05 13:41:26.000000000 +1000
+++ linux-2.6.13-rc5-ck2/kernel/timer_top.c	2005-08-05 13:54:50.000000000 +1000
@@ -11,7 +11,6 @@
  * published by the Free Software Foundation.
  */
 
-
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/module.h>
@@ -20,8 +19,8 @@ static LIST_HEAD(timer_list);
 
 struct timer_top_info {
 	unsigned int		func_pointer;
-	unsigned int long	counter;
-	struct list_head 	list;      	
+	unsigned long		counter;
+	struct list_head 	list;
 };
 
 struct timer_top_info top_info;
@@ -30,37 +29,38 @@ int account_timer(unsigned int function,
 {
 	struct timer_top_info *top;
 
-	list_for_each_entry (top, &timer_list, list) {
+	list_for_each_entry(top, &timer_list, list) {
 		/* if it is in the list increment its count */
 		if (top->func_pointer == function) {
-			top->counter += 1;
-			return 0;
+			top->counter++;
+			goto out;
 		}
 	}
-	
+
 	/* if you are here then it didnt find so inserts in the list */
 
 	top = kmalloc(sizeof(struct timer_top_info), GFP_KERNEL);
-	if (!top) 
+	if (!top)
 		return -ENOMEM;
 	top->func_pointer = function;
 	top->counter = 1;
 	list_add(&top->list, &timer_list);
 
+out:
 	return 0;
 }
 
 EXPORT_SYMBOL(account_timer);
 
 struct top_info_poll {
-  char value[18];
+	char value[18];
 };
 
 struct top_info_poll top_info_poll_dt;
 struct proc_dir_entry *top_info_file;
 
 static int proc_read_top_info(char *page, char **start, off_t off,
-                                int count, int *eof, void *data)
+				int count, int *eof, void *data)
 {
 	char aux[18];
 	struct timer_top_info *top;
@@ -69,21 +69,19 @@ static int proc_read_top_info(char *page
 
 	sprintf(page, "Function counter - %s\n", info_poll_data->value);
 
-	list_for_each_entry (top, &timer_list, list) {
+	list_for_each_entry(top, &timer_list, list) {
 		sprintf(aux, "%x %lu\n", top->func_pointer, top->counter);
 		strcat(page, aux);
 	}
 
 	return strlen(page);
- 
-} 
+}
 
 static int init_top_info(void)
 {
 	top_info_file = create_proc_entry("top_info", 0666, NULL);
-	if(top_info_file == NULL) {
-	  return -ENOMEM;
-	}
+	if (top_info_file == NULL)
+		return -ENOMEM;
 
 	strcpy(top_info_poll_dt.value, "Timer Top v0.9.1");
 
@@ -96,6 +94,3 @@ static int init_top_info(void)
 
 module_init(init_top_info);
 //module_exit();
-
-
-

--Boundary-00=_eWu8CigMjtFRGXl--
