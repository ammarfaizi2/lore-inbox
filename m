Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCQX2e>; Sat, 17 Mar 2001 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRCQX2Y>; Sat, 17 Mar 2001 18:28:24 -0500
Received: from siemens.ikp.physik.tu-darmstadt.de ([130.83.24.90]:128 "EHLO
	siemens.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S129066AbRCQX2L>; Sat, 17 Mar 2001 18:28:11 -0500
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15027.62364.751528.388435@siemens.ikp.physik.tu-darmstadt.de>
Date: Sun, 18 Mar 2001 00:30:36 +0100
To: linux-kernel@vger.kernel.org
CC: bon@elektron.ikp.physik.tu-darmstadt.de
Subject: [PATCH] /proc/uptime on SMP machines
X-Mailer: VM 6.91 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I didn't see a maintainer for the /proc filesystem, to I send this mail to
linux-kernel for discussion. 

At present the idle value in /proc/uptime is only the idle time for the first
processor. With 2.4, processes seam "stickier" for my, and e.g "yes
>/dev/null" on an otherwise idle machine can stay for a long time on one
processor of my (intel) SMP machine. That way, the present output of
/proc/uptime can lead to a wrong conclusion.

Appended patch returns the average of all idle processes an all
processors. 

If I don't hear back, I will send to Linus and Alan for inclusion.

Bye

Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Free Software: If you contribute nothing, expect nothing
--

--- linux-2.4.2.SuSE/fs/proc/proc_misc.c	Thu Mar 15 16:48:04 2001
+++ linux-2.4.2.SuSE-5/fs/proc/proc_misc.c	Sat Mar 17 23:11:47 2001
@@ -105,11 +105,15 @@
 {
 	unsigned long uptime;
 	unsigned long idle;
-	int len;
+	int len,i;
 
 	uptime = jiffies;
+#ifdef CONFIG_SMP
+	for (idle =0,i = 0; i < smp_num_cpus; i++)
+	    idle += (init_tasks[i]->times.tms_utime + init_tasks[i]->times.tms_stime)/smp_num_cpus;
+#else
 	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
-
+#endif
 	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
 	   that would overflow about every five days at HZ == 100.
 	   Therefore the identity a = (a / b) * b + a % b is used so that it is
