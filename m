Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSFRNXr>; Tue, 18 Jun 2002 09:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSFRNXq>; Tue, 18 Jun 2002 09:23:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36110 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317402AbSFRNXo>;
	Tue, 18 Jun 2002 09:23:44 -0400
Date: Tue, 18 Jun 2002 14:23:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove tqueue.h from sched.h
Message-ID: <20020618142345.F9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is actually part of the work I've been doing to remove BHs, but it
stands by itself.

diff -urNX dontdiff linux-2.5.22/drivers/char/random.c linux-2.5.22-bh/drivers/char/random.c
--- linux-2.5.22/drivers/char/random.c	Sun Jun  2 18:44:41 2002
+++ linux-2.5.22-bh/drivers/char/random.c	Mon Jun 17 12:58:18 2002
@@ -252,6 +252,7 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/tqueue.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
diff -urNX dontdiff linux-2.5.22/drivers/pcmcia/pci_socket.c linux-2.5.22-bh/drivers/pcmcia/pci_socket.c
--- linux-2.5.22/drivers/pcmcia/pci_socket.c	Sun Jun  2 18:44:49 2002
+++ linux-2.5.22-bh/drivers/pcmcia/pci_socket.c	Mon Jun 17 13:10:15 2002
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 
 #include <pcmcia/ss.h>
diff -urNX dontdiff linux-2.5.22/drivers/pcmcia/yenta.c linux-2.5.22-bh/drivers/pcmcia/yenta.c
--- linux-2.5.22/drivers/pcmcia/yenta.c	Mon Jun 17 04:49:06 2002
+++ linux-2.5.22-bh/drivers/pcmcia/yenta.c	Mon Jun 17 13:11:16 2002
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/module.h>
diff -urNX dontdiff linux-2.5.22/include/linux/sched.h linux-2.5.22-bh/include/linux/sched.h
--- linux-2.5.22/include/linux/sched.h	Mon Jun 17 04:49:09 2002
+++ linux-2.5.22-bh/include/linux/sched.h	Mon Jun 17 12:49:29 2002
@@ -7,7 +7,6 @@
 
 #include <linux/config.h>
 #include <linux/capability.h>
-#include <linux/tqueue.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -160,7 +159,6 @@
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
 
-extern int schedule_task(struct tq_struct *task);
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
diff -urNX dontdiff linux-2.5.22/include/linux/tqueue.h linux-2.5.22-bh/include/linux/tqueue.h
--- linux-2.5.22/include/linux/tqueue.h	Thu Jun  6 06:57:51 2002
+++ linux-2.5.22-bh/include/linux/tqueue.h	Mon Jun 17 12:50:29 2002
@@ -109,6 +110,9 @@
 	}
 	return ret;
 }
+
+/* Schedule a tq to run in process context */
+extern int schedule_task(struct tq_struct *task);
 
 /*
  * Call all "bottom halfs" on a given list.
diff -urNX dontdiff linux-2.5.22/kernel/context.c linux-2.5.22-bh/kernel/context.c
--- linux-2.5.22/kernel/context.c	Sun Jun  2 18:44:47 2002
+++ linux-2.5.22-bh/kernel/context.c	Mon Jun 17 12:53:16 2002
@@ -20,6 +20,7 @@
 #include <linux/unistd.h>
 #include <linux/signal.h>
 #include <linux/completion.h>
+#include <linux/tqueue.h>
 
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
diff -urNX dontdiff linux-2.5.22/kernel/kmod.c linux-2.5.22-bh/kernel/kmod.c
--- linux-2.5.22/kernel/kmod.c	Sun Jun  2 18:44:45 2002
+++ linux-2.5.22-bh/kernel/kmod.c	Mon Jun 17 12:52:57 2002
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/completion.h>
 #include <linux/file.h>
+#include <linux/tqueue.h>
 
 #include <asm/uaccess.h>
 
diff -urNX dontdiff linux-2.5.22/kernel/sys.c linux-2.5.22-bh/kernel/sys.c
--- linux-2.5.22/kernel/sys.c	Sun Jun  2 18:44:41 2002
+++ linux-2.5.22-bh/kernel/sys.c	Mon Jun 17 12:52:35 2002
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
+#include <linux/tqueue.h>
 #include <linux/device.h>
 
 #include <asm/uaccess.h>
diff -urNX dontdiff linux-2.5.22/kernel/timer.c linux-2.5.22-bh/kernel/timer.c
--- linux-2.5.22/kernel/timer.c	Sun Jun  9 06:09:49 2002
+++ linux-2.5.22-bh/kernel/timer.c	Tue Jun 18 05:13:51 2002
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
 
 #include <asm/uaccess.h>

-- 
Revolutions do not require corporate support.
