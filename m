Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVKVO64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVKVO64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVKVO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:58:56 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:30937 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964958AbVKVO6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:58:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hFlQpMUAWSw6x7plwP3SgPqWuNIYLrgJDpe3X3sjKmVYtRUP1XllI6cG1Uln6NClcUWFhIoBFpADtLOEwiILvqzVCHZz62/g0vBcwgyWqQQ9tkDyGIXTq2vx4auh908Qr20wvz9+WWyfYC/XCPjBnrUeNrObwErJTwqmOY7Bycw=
Message-ID: <9268368b0511220658x548c05aendef781800c8277ad@mail.gmail.com>
Date: Tue, 22 Nov 2005 10:58:48 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No Idle Hz - aka Dynticks v051122-1
Cc: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, trenn@suse.de
In-Reply-To: <200511222226.40854.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_45906_8865619.1132671528393"
References: <200511222226.40854.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_45906_8865619.1132671528393
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Con,

I have a improved version of timertop and a C timertop user space
instead of perl, much improved. Tested against your last patch for
2.6.15-rc1.

The kernel patch I am sending in this email and the C utility I will
release very soon and post here. This new version of the patch is not
compatible with the perl script.

BTW I am testing the dyn-tick and it seems that the calculations get
much better this time around.

On 11/22/05, Con Kolivas <kernel@kolivas.org> wrote:
> Here is an updated version of the dynticks patch for i386 built on 2.6.15=
-rc2.
>

Thanks for the support,

Daniel
--
INdT - Manaus - Brazil

------=_Part_45906_8865619.1132671528393
Content-Type: text/x-patch; name=timer_top5-20051121.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="timer_top5-20051121.patch"

diff -uprN linux-2.6.15-rc2-orig/kernel/Makefile linux-2.6.15-rc2-tt/kernel/Makefile
--- linux-2.6.15-rc2-orig/kernel/Makefile	2005-11-21 11:08:49.000000000 -0400
+++ linux-2.6.15-rc2-tt/kernel/Makefile	2005-11-21 13:21:44.000000000 -0400
@@ -32,7 +32,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
-obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o timer_top.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uprN linux-2.6.15-rc2-orig/kernel/timer.c linux-2.6.15-rc2-tt/kernel/timer.c
--- linux-2.6.15-rc2-orig/kernel/timer.c	2005-11-21 11:08:50.000000000 -0400
+++ linux-2.6.15-rc2-tt/kernel/timer.c	2005-11-21 12:09:13.000000000 -0400
@@ -477,6 +477,10 @@ static inline void __run_timers(tvec_bas
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+extern struct timer_top_info top_info;
+extern int account_timer(unsigned long function,
+			 unsigned long data,
+	       		struct timer_top_info * top_info);
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
@@ -540,6 +544,7 @@ found:
 				expires = nte->expires;
 		}
 	}
+	account_timer((unsigned long)nte->function, nte->data, &top_info);
 	spin_unlock(&base->t_base.lock);
 	return expires;
 }
diff -uprN linux-2.6.15-rc2-orig/kernel/timer_top.c linux-2.6.15-rc2-tt/kernel/timer_top.c
--- linux-2.6.15-rc2-orig/kernel/timer_top.c	1969-12-31 20:00:00.000000000 -0400
+++ linux-2.6.15-rc2-tt/kernel/timer_top.c	2005-11-21 13:30:35.000000000 -0400
@@ -0,0 +1,207 @@
+/*
+ * kernel/timer_top.c
+ *
+ * Export Timers information to /proc/timer_info
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ * Written by Daniel Petrini <d.pensator@gmail.com>
+ *
+ * This utility should be used to get information from the system timers
+ * and maybe optimize the system once you know which timers are being used
+ * and the process which starts them.
+ * This is particular useful above dynamic tick implementation. One can 
+ * see who is starting timers and make the HZ value increase.
+ *
+ * We export the addresses and counting of timer functions being called,
+ * the pid and cmdline from the owner process if applicable.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+#define VERSION		"Timer Top v0.9.5"
+
+static LIST_HEAD(timer_list);
+
+struct timer_top_info {
+	unsigned int		func_pointer;
+	unsigned long		counter;
+	pid_t			pid;
+	char 			comm[TASK_COMM_LEN];
+	struct list_head 	list;      	
+};
+
+struct timer_top_info top_info;
+
+static spinlock_t timer_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long flags;
+static int start_flag = 0; 	/* signs if will collect data or not */
+
+int account_timer(unsigned long function, unsigned long data, struct timer_top_info * top_info)
+{
+	struct timer_top_info *top;
+	struct task_struct * task_info;
+	pid_t pid_info = 0;
+	char name[TASK_COMM_LEN] = "";
+	
+	if (start_flag == 0)
+		goto out;
+	
+	spin_lock_irqsave(&timer_lock, flags);
+
+	if (data) { 
+	       	task_info = (struct task_struct *) data;
+		/* little sanity ... not enough yet */
+		if ((task_info->pid > 0) && (task_info->pid < PID_MAX_LIMIT)) {
+			pid_info = task_info->pid;
+			strncpy(name, task_info->comm, sizeof(task_info->comm));
+		}
+	}
+	
+	list_for_each_entry(top, &timer_list, list) {
+		/* if it is in the list increment its count */
+		if (top->func_pointer == function && top->pid == pid_info) {
+			top->counter++;
+			//top->pid = pid_info;
+			//strncpy(top->comm, name, sizeof(name));
+			spin_unlock_irqrestore(&timer_lock, flags);
+			goto out;
+		}
+	}
+	
+	/* if you are here then it didnt find so inserts in the list */
+
+	top = kmalloc(sizeof(struct timer_top_info), GFP_ATOMIC);
+	if (!top) 
+		return -ENOMEM;
+	top->func_pointer = function;
+	top->counter = 1;
+	top->pid = pid_info;
+	strncpy(top->comm, name, sizeof(name));
+	list_add(&top->list, &timer_list);
+
+	spin_unlock_irqrestore(&timer_lock, flags);
+
+out:	
+	return 0;
+}
+
+EXPORT_SYMBOL(account_timer);
+
+int timer_list_del(void)
+{
+	struct list_head *aux1, *aux2;
+	struct timer_top_info *entry;
+
+	spin_lock_irqsave(&timer_lock, flags);
+	list_for_each_safe(aux1, aux2, &timer_list) {
+		entry = list_entry(aux1, struct timer_top_info, list);
+		//printk("Deleting: %d\n", entry->pid);
+		list_del(aux1);
+		kfree(entry);
+	}
+	spin_unlock_irqrestore(&timer_lock, flags);
+	return 0;
+}
+
+/* PROC_FS_SECTION  */
+
+static struct proc_dir_entry *top_info_file;
+static struct proc_dir_entry *top_info_file_out;
+
+static int proc_read_top_info(struct seq_file *m, void *v)
+{
+	struct timer_top_info *top;
+	
+	seq_printf(m, "Function counter - %s\n", VERSION);
+
+	list_for_each_entry(top, &timer_list, list) {
+		seq_printf(m, "%x %lu %d %s\n", top->func_pointer, top->counter, top->pid, top->comm);
+	}
+	
+	if (start_flag == 0) {
+		seq_printf(m, "Disabled\n");
+		//return 0;
+	}
+
+	return 0;
+} 
+
+static int proc_timertop_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_read_top_info, NULL);
+}
+
+static struct file_operations proc_timertop_operations = {
+	.open		= proc_timertop_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#define MAX_INPUT_TOP	10
+
+/* Receive some commands from user */
+static int proc_write_top_info(struct file *file, const char *page,
+                                 unsigned long count, void *data)
+{
+	int len;
+	char input_data[MAX_INPUT_TOP];
+
+	/* input size checking */
+	if(count > MAX_INPUT_TOP - 1)
+		len = MAX_INPUT_TOP - 1;
+	else
+		len = count;
+
+	if (copy_from_user(input_data, page, len)) 
+		return -EFAULT;
+
+	input_data[len] = '\0';
+
+	if(!strncmp(input_data, "clear", 5))
+		timer_list_del();
+	else if(!strncmp(input_data, "start", 5))
+		start_flag = 1;
+	else if(!strncmp(input_data, "stop", 4))
+		start_flag = 0;
+  
+	printk("\n %s", input_data);
+
+	return len;
+}
+
+static int __init init_top_info(void)
+{
+	top_info_file = create_proc_entry("timer_info", 0444, NULL);
+	if (top_info_file == NULL) {
+		return -ENOMEM;
+	}
+
+	top_info_file_out = create_proc_entry("timer_input", 0666, NULL);
+	if (top_info_file_out == NULL) {
+		return -ENOMEM;
+	}
+
+	/* Read support */
+	top_info_file->proc_fops = &proc_timertop_operations;
+	
+	/* Write support */	
+	top_info_file_out->write_proc = &proc_write_top_info;
+	top_info_file_out->owner = THIS_MODULE;
+	
+	return 0;
+}
+
+module_init(init_top_info);
+//module_exit();

------=_Part_45906_8865619.1132671528393--
