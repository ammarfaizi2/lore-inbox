Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTHYUyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTHYUyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:54:11 -0400
Received: from rj.SGI.COM ([192.82.208.96]:41648 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262327AbTHYUyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:54:02 -0400
Date: Mon, 25 Aug 2003 13:53:48 -0700
From: Nick Pollitt <npollitt@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 avenrun values
Message-ID: <20030825135348.A22939@serapis.engr.sgi.com>
Reply-To: npollitt@engr.sgi.com
Mail-Followup-To: Nick Pollitt <npollitt@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sysinfo there is a cli/sti around the reading of the avenrun
values.  On a UP system, this will prevent a timer tick/timer bh
from coming in and updating the values while they're being read.

However, on an SMP system, using the cli on some cpu other than
cpu0 will not stop the timer bh on cpu0 from updating the avenrun 
values while they're being read by sysinfo.  Also, loadavg_read_proc 
does no locking whatsoever.

Below is a patch that uses the xtime_lock around the writer and
both readers of the avenrun values.  Please apply.

--- 1.21/fs/proc/proc_misc.c	Mon Jul 14 13:10:30 2003
+++ edited/fs/proc/proc_misc.c	Fri Aug 22 16:28:37 2003
@@ -65,6 +65,7 @@
 #ifdef CONFIG_SGI_DS1286
 extern int get_ds1286_status(char *);
 #endif
+extern rwlock_t xtime_lock;
 
 void proc_sprintf(char *page, off_t *off, int *lenp, const char *format, ...)
 {
@@ -101,17 +102,22 @@
 static int loadavg_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	int a, b, c;
+	int a, b, c, d, e;
 	int len;
 
+	read_lock(&xtime_lock);
 	a = avenrun[0] + (FIXED_1/200);
 	b = avenrun[1] + (FIXED_1/200);
 	c = avenrun[2] + (FIXED_1/200);
+	d = nr_running;
+	e = nr_threads;
+	read_unlock(&xtime_lock);
+
 	len = sprintf(page,"%d.%02d %d.%02d %d.%02d %d/%d %d\n",
 		LOAD_INT(a), LOAD_FRAC(a),
 		LOAD_INT(b), LOAD_FRAC(b),
 		LOAD_INT(c), LOAD_FRAC(c),
-		nr_running, nr_threads, last_pid);
+		d, e, last_pid);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
--- 1.2/kernel/info.c	Mon Feb  4 23:39:30 2002
+++ edited/kernel/info.c	Fri Aug 22 16:19:12 2003
@@ -13,13 +13,15 @@
 
 #include <asm/uaccess.h>
 
+extern rwlock_t xtime_lock;
+
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
-	cli();
+	read_lock(&xtime_lock);
 	val.uptime = jiffies / HZ;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
@@ -27,7 +29,7 @@
 	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
 	val.procs = nr_threads-1;
-	sti();
+	read_unlock(&xtime_lock);
 
 	si_meminfo(&val);
 	si_swapinfo(&val);
--- 1.7/kernel/timer.c	Sun Oct  6 12:03:31 2002
+++ edited/kernel/timer.c	Fri Aug 22 15:20:27 2003
@@ -686,8 +686,8 @@
 		update_wall_time(ticks);
 	}
 	vxtime_unlock();
-	write_unlock_irq(&xtime_lock);
 	calc_load(ticks);
+	write_unlock_irq(&xtime_lock);
 }
 
 void timer_bh(void)
