Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbTHZUfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTHZUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:35:32 -0400
Received: from rj.SGI.COM ([192.82.208.96]:56516 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262915AbTHZUfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:35:04 -0400
Date: Tue, 26 Aug 2003 13:34:53 -0700
From: Nick Pollitt <npollitt@engr.sgi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 avenrun values
Message-ID: <20030826133453.A28534@serapis.engr.sgi.com>
Reply-To: npollitt@engr.sgi.com
Mail-Followup-To: Nick Pollitt <npollitt@engr.sgi.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55L.0308261557190.18109@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55L.0308261557190.18109@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Aug 26, 2003 at 04:07:34PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:07:34PM -0300, Marcelo Tosatti wrote:
> -       cli();
> +       read_lock(&xtime_lock);
> 
> Shouldnt this be read_lock_irq() to avoid interrupts?

Yes it should - here's a new patch.

Thanks.

--- 1.21/fs/proc/proc_misc.c	Mon Jul 14 13:10:30 2003
+++ edited/fs/proc/proc_misc.c	Tue Aug 26 13:21:48 2003
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
 
+	read_lock_irq(&xtime_lock);
 	a = avenrun[0] + (FIXED_1/200);
 	b = avenrun[1] + (FIXED_1/200);
 	c = avenrun[2] + (FIXED_1/200);
+	d = nr_running;
+	e = nr_threads;
+	read_unlock_irq(&xtime_lock);
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
+++ edited/kernel/info.c	Tue Aug 26 13:21:48 2003
@@ -13,13 +13,15 @@
 
 #include <asm/uaccess.h>
 
+extern rwlock_t xtime_lock;
+
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
-	cli();
+	read_lock_irq(&xtime_lock);
 	val.uptime = jiffies / HZ;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
@@ -27,7 +29,7 @@
 	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
 	val.procs = nr_threads-1;
-	sti();
+	read_unlock_irq(&xtime_lock);
 
 	si_meminfo(&val);
 	si_swapinfo(&val);
--- 1.7/kernel/timer.c	Sun Oct  6 12:03:31 2002
+++ edited/kernel/timer.c	Tue Aug 26 13:21:48 2003
@@ -686,8 +686,8 @@
 		update_wall_time(ticks);
 	}
 	vxtime_unlock();
-	write_unlock_irq(&xtime_lock);
 	calc_load(ticks);
+	write_unlock_irq(&xtime_lock);
 }
 
 void timer_bh(void)
