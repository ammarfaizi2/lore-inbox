Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWAEA2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWAEA2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWAEA2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:28:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750842AbWAEA2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:28:22 -0500
Date: Wed, 4 Jan 2006 19:27:59 -0500
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
       Arjan van de Ven <arjan@infradead.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060105002759.GB30967@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Arjan van de Ven <arjan@infradead.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <1136406837.2839.67.camel@laptopd505.fenrus.org> <43BC40B5.90607@gorzow.mm.pl> <200601051112.52404.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051112.52404.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:12:51AM +1100, Con Kolivas wrote:
 > On Thursday 05 January 2006 08:40, Radoslaw Szkodzinski wrote:
 > > Arjan van de Ven wrote:
 > > > On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
 > > >
 > > > sounds like we need some sort of profiler or benchmarker or at least a
 > > > tool that helps finding out which timers are regularly firing, with the
 > > > aim at either grouping them or trying to reduce their disturbance in
 > > > some form.
 > >
 > > You mean something like a modification to timer debugging patch to
 > > record the last time the timer fired, right?
 > > Timertop could then detect the pattern and provide frequency, standard
 > > deviation and other statistical data.
 > > It would be much more expensive to test of course.
 > 
 > I don't think the timer debugging patch needs to give out any more info. The 
 > userspace tool should be able to do this with the amount of info the timer 
 > debugging patch is giving already.

In the absense of a pointer to a userspace tool, I found the following handy.
(It also fixes a bug where it was printing garbage as process names).

[this is just an opencoded print_address().  I would have used that but it
 printk's instead of sprintf's to a buffer which made it useless for use by seq_print]

With this, it prints output like..

cfq_idle_slice_timer+0x0/0xb3 4 0 <kthread>
...
process_timeout+0x0/0x5 1025 147 pdflush
process_timeout+0x0/0x5 1701 3 watchdog/0
it_real_fn+0x0/0x5a 1907 2309 Xorg
process_timeout+0x0/0x5 2896 2356 gdmgreeter
process_timeout+0x0/0x5 3634 1940 python
i8042_timer_func+0x0/0xb 8699 0 <no data>
rh_timer_func+0x0/0x5 16499 4

There's still 1 case though it seems where some timers get garbage printed as their ->comm
If I get motivation to hack on this some more, I'll look further into it, but
this gets me 99% of the way there.  (Actually, it's missing timers launched
on behalf of init it seems (they all have a pid of '1'.
Wonder why init hasn't got a sane ->comm though).

		Dave

diff -urpN --exclude-from=/home/davej/.exclude linux-2.6.15/kernel/timer_top.c timertop/kernel/timer_top.c
--- linux-2.6.15/kernel/timer_top.c	2006-01-04 19:20:41.000000000 -0500
+++ timertop/kernel/timer_top.c	2006-01-04 18:37:35.000000000 -0500
@@ -27,12 +27,13 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/kallsyms.h>
 #include <asm/uaccess.h>
 
 #define VERSION		"Timer Top v0.9.8"
 
 struct timer_top_info {
-	unsigned int		func_pointer;
+	unsigned long		func_pointer;
 	unsigned long		counter;
 	pid_t			pid;
 	char 			comm[TASK_COMM_LEN];
@@ -88,7 +89,11 @@ int account_timer(unsigned long function
 		if ((task_info->pid > 0) && (task_info->pid < PID_MAX_LIMIT)) {
 			pid_info = task_info->pid;
 			strncpy(name, task_info->comm, sizeof(task_info->comm));
+		} else {
+			strcpy(name, "<kthread>");
 		}
+	} else {
+		strcpy(name,"<no data>");
 	}
 
 	if (update_top_info(function, pid_info))
@@ -138,12 +143,30 @@ static struct proc_dir_entry *top_info_f
 static int proc_read_top_info(struct seq_file *m, void *v)
 {
 	struct timer_top_info *top;
+	char *modname;
+	const char *name;
+	unsigned long offset, size;
+	char namebuf[KSYM_NAME_LEN+1];
+	char buffer[sizeof("%s+%#lx/%#lx [%s]") + KSYM_NAME_LEN +
+            2*(BITS_PER_LONG*3/10) + MODULE_NAME_LEN + 1];
 
 	seq_printf(m, "Function counter - %s\n", VERSION);
 
 	list_for_each_entry(top, timer_list, list) {
-		seq_printf(m, "%x %lu %d %s\n", top->func_pointer,
-			top->counter, top->pid, top->comm);
+
+		name = kallsyms_lookup(top->func_pointer, &size, &offset, &modname, namebuf);
+		if (!name)
+			sprintf(buffer, "0x%lx", top->func_pointer);
+		else {
+			if (modname)
+				sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
+					size, modname);
+			else
+				sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+		}
+
+		seq_printf(m, "%s %lu %d %s\n",
+			buffer, top->counter, top->pid, top->comm ? top->comm : "<>");
 	}
 
 	if (!top_root.record)
