Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTA1Xe5>; Tue, 28 Jan 2003 18:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTA1Xdp>; Tue, 28 Jan 2003 18:33:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:17792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261900AbTA1XdX>;
	Tue, 28 Jan 2003 18:33:23 -0500
Subject: [PATCH] (3/4) 2.5.59 fast reader/writer lock for gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-7ZOiT9Efwy468kwWLXmo"
Organization: Open Source Devlopment Lab
Message-Id: <1043797360.10155.306.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 15:42:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7ZOiT9Efwy468kwWLXmo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the ia64 portion of lockless gettimeofday. It defines frlock
and changes locking of xtime_lock from rwlock to frlock.

--=-7ZOiT9Efwy468kwWLXmo
Content-Disposition: attachment; filename=frlock-xtime-ia64.patch
Content-Type: text/x-patch; name=frlock-xtime-ia64.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.5.59/arch/ia64/kernel/time.c linux-2.5-frlock/arch/ia64/kernel/time.c
--- linux-2.5.59/arch/ia64/kernel/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/ia64/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -24,7 +24,7 @@
 #include <asm/sal.h>
 #include <asm/system.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 extern unsigned long last_time_offset;
 
@@ -89,7 +89,7 @@
 void
 do_settimeofday (struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	{
 		/*
 		 * This is revolting. We need to set "xtime" correctly. However, the value
@@ -112,21 +112,21 @@
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_esterror = NTP_PHASE_LIMIT;
 	}
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 void
 do_gettimeofday (struct timeval *tv)
 {
-	unsigned long flags, usec, sec, old;
+	unsigned long seq, usec, sec, old;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	{
+	do {
+		seq = fr_read_begin(&xtime_lock);
 		usec = gettimeoffset();
 
 		/*
-		 * Ensure time never goes backwards, even when ITC on different CPUs are
-		 * not perfectly synchronized.
+		 * Ensure time never goes backwards, even when ITC on 
+		 * different CPUs are not perfectly synchronized.
 		 */
 		do {
 			old = last_time_offset;
@@ -138,8 +138,8 @@
 
 		sec = xtime.tv_sec;
 		usec += xtime.tv_nsec / 1000;
-	}
-	read_unlock_irqrestore(&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
+
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -182,10 +182,10 @@
 			 * another CPU. We need to avoid to SMP race by acquiring the
 			 * xtime_lock.
 			 */
-			write_lock(&xtime_lock);
+			fr_write_lock(&xtime_lock);
 			do_timer(regs);
 			local_cpu_data->itm_next = new_itm;
-			write_unlock(&xtime_lock);
+			fr_write_unlock(&xtime_lock);
 		} else
 			local_cpu_data->itm_next = new_itm;
 

--=-7ZOiT9Efwy468kwWLXmo--

