Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbTGFAWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbTGFAWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:22:39 -0400
Received: from colino.net ([62.212.100.143]:53240 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S266570AbTGFAWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:22:37 -0400
Date: Sun, 6 Jul 2003 02:39:22 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] two PPC patches for 2.5.73
Message-Id: <20030706023922.52c2806a.colin@colino.net>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__6_Jul_2003_02:39:22_+0200_10864a20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__6_Jul_2003_02:39:22_+0200_10864a20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

here are two patches for kernel 2.5.73.
compile.diff is needed for the kernel to compile.
time.diff fixes uptime being wrong; I hope it's correct.

-- 
 \|/ ____ \|/   Colin
 "@'/ ,. \`@"   http://www.geekounet.org/
 /_| \__/ |_\
    \__U_/

--Multipart_Sun__6_Jul_2003_02:39:22_+0200_10864a20
Content-Type: text/plain;
 name="compile.diff"
Content-Disposition: attachment;
 filename="compile.diff"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/traps.c.orig	Sun Jul  6 02:36:56 2003
+++ arch/ppc/kernel/traps.c	Sun Jul  6 02:36:49 2003
@@ -346,6 +346,12 @@
 	return 0;
 }
 
+void 
+show_stack(struct task_struct *task, unsigned long * sp)
+{
+	printk(KERN_CRIT "arch/ppc/kernel/traps.c::show_stack() called but not implemented!\n");
+}
+
 void
 ProgramCheckException(struct pt_regs *regs)
 {

--Multipart_Sun__6_Jul_2003_02:39:22_+0200_10864a20
Content-Type: text/plain;
 name="time.diff"
Content-Disposition: attachment;
 filename="time.diff"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/time.c.orig	Sun Jul  6 02:35:18 2003
+++ arch/ppc/kernel/time.c	Sun Jul  6 02:20:27 2003
@@ -277,6 +277,18 @@
 	xtime.tv_nsec = new_nsec;
 	xtime.tv_sec = new_sec;
 
+	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
+	wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
+
+	if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
+		wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
+		wall_to_monotonic.tv_sec++;
+	}
+	if (wall_to_monotonic.tv_nsec < 0) {
+		wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
+		wall_to_monotonic.tv_sec--;
+	}
+
 	/* In case of a large backwards jump in time with NTP, we want the 
 	 * clock to be updated as soon as the PLL is again in lock.
 	 */
@@ -347,6 +359,8 @@
 		sys_tz.tz_dsttime = 0;
 		xtime.tv_sec -= time_offset;
         }
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
 }
 
 #define FEBRUARY		2
@@ -427,4 +441,14 @@
 	if (err <= inscale/2) mlt++;
 	return mlt;
 }
+
+/* monotonic_clock(): returns # of nanoseconds passed since time_init()
+ *		Note: This function is required to return accurate
+ *		time even in the absence of multiple timer ticks.
+ */
+unsigned long long monotonic_clock(void)
+{
+	return xtime.tv_sec * NSEC_PER_SEC + xtime.tv_nsec;
+}
+EXPORT_SYMBOL(monotonic_clock);
 

--Multipart_Sun__6_Jul_2003_02:39:22_+0200_10864a20--
