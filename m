Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTEJH6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTEJH6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:58:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:10744 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263675AbTEJH6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:58:16 -0400
Date: Sat, 10 May 2003 03:59:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: CPU Freq ML <cpufreq@www.linux.org.uk>, "" <pmhahn@titan.lahn.de>
Subject: [PATCH][2.5] export cpufreq_driver to fix oops in proc interface
Message-ID: <Pine.LNX.4.50.0305100341000.11047-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The proc interface has no way of telling wether there is an active cpufreq 
driver or not. This means that if you don't have a cpufreq supported 
processor, this will oops in various possible places.

This hasn't been committed in case there is a cleaner way.

Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c013589f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013589f>]    Not tainted
EFLAGS: 00010246
EIP is at cpufreq_cpu_get+0x1f/0xe0
eax: 00000000   ebx: 00000000   ecx: cbbf3ba0   edx: cbc21eb0
esi: 00000001   edi: cbc21eb0   ebp: cbc21e68   esp: cbc21e5c
ds: 007b   es: 007b   ss: 0068
Process mc (pid: 300, threadinfo=cbc20000 task=c13ac780)
Stack: cbc21e74 00000000 00000000 cbc21e88 c01367e1 00000000 cbc21e88 c01b5a4f
       00000000 c59ce045 00000000 cbc21f1c c023434f cbc21eb0 00000000 c02dfaac
       cbc20000 c02dfaac cbc21ed0 c013d15c c10e0830 00000000 c02e0f30 00000000
Call Trace:
 [<c01367e1>] cpufreq_get_policy+0x21/0x90
 [<c01b5a4f>] sprintf+0x1f/0x30
 [<c023434f>] cpufreq_proc_read+0x8f/0x150
 [<c013d15c>] buffered_rmqueue+0xbc/0x160
 [<c013d28d>] __alloc_pages+0x8d/0x300
 [<c02342c0>] cpufreq_proc_read+0x0/0x150
 [<c017f2ee>] proc_file_read+0xbe/0x250
 [<c0153ae3>] vfs_read+0xd3/0x140
 [<c0164784>] do_fcntl+0xd4/0x1c0
 [<c0153d8c>] sys_read+0x3c/0x60
 [<c010a33b>] syscall_call+0x7/0xb

Code: 8b 50 20 85 d2 74 2b b8 00 e0 ff ff 21 e0 ff 40 14 83 3a 02

Index: linux-2.5.69/include/linux/cpufreq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/include/linux/cpufreq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpufreq.h
--- linux-2.5.69/include/linux/cpufreq.h	6 May 2003 12:20:41 -0000	1.1.1.1
+++ linux-2.5.69/include/linux/cpufreq.h	10 May 2003 07:33:01 -0000
@@ -310,5 +309,8 @@ void cpufreq_frequency_table_put_attr(un
 
 
 #endif /* CONFIG_CPU_FREQ_TABLE */
+
+/* Currently exported only for the proc interface, remove when that goes */
+extern struct cpufreq_driver *cpufreq_driver;
 
 #endif /* _LINUX_CPUFREQ_H */
Index: linux-2.5.69/kernel/cpufreq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/kernel/cpufreq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpufreq.c
--- linux-2.5.69/kernel/cpufreq.c	6 May 2003 12:21:33 -0000	1.1.1.1
+++ linux-2.5.69/kernel/cpufreq.c	10 May 2003 07:28:10 -0000
@@ -28,9 +28,11 @@
  * level driver of CPUFreq support, and its locking mutex. 
  * cpu_max_freq is in kHz.
  */
-static struct cpufreq_driver   	*cpufreq_driver;
+struct cpufreq_driver   	*cpufreq_driver;
 static DECLARE_MUTEX            (cpufreq_driver_sem);
 
+/* required for the proc interface, remove when that goes away */
+EXPORT_SYMBOL_GPL(cpufreq_driver);
 
 /**
  * Two notifier lists: the "policy" list is involved in the 
Index: linux-2.5.69/drivers/cpufreq/proc_intf.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/drivers/cpufreq/proc_intf.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc_intf.c
--- linux-2.5.69/drivers/cpufreq/proc_intf.c	6 May 2003 12:20:36 -0000	1.1.1.1
+++ linux-2.5.69/drivers/cpufreq/proc_intf.c	10 May 2003 07:15:33 -0000
@@ -209,6 +209,9 @@ static int __init cpufreq_proc_init (voi
 {
 	struct proc_dir_entry *entry = NULL;
 
+	if (!cpufreq_driver)
+		return -ENODEV;
+
         /* are these acceptable values? */
 	entry = create_proc_entry("cpufreq", S_IFREG|S_IRUGO|S_IWUSR, 
 				  &proc_root);
-- 
function.linuxpower.ca
