Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318967AbSHMQmP>; Tue, 13 Aug 2002 12:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMQmO>; Tue, 13 Aug 2002 12:42:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318967AbSHMQmL>;
	Tue, 13 Aug 2002 12:42:11 -0400
Subject: [PATCH] fast reader/writer lock for gettimeofday 2.5.30 - ia64
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1029195577.1978.22.camel@dell_ss3.pdx.osdl.net>
References: <1029195577.1978.22.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Aug 2002 09:46:03 -0700
Message-Id: <1029257163.6480.9.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is an example of how to use frlock with other
architectures.  Don't have a ia64 machine handy to test it

diff -urN -X dontdiff linux-2.5/arch/ia64/kernel/time.c linux-2.5.exp/arch/ia64/kernel/time.c
--- linux-2.5/arch/ia64/kernel/time.c	Mon Aug 12 10:18:00 2002
+++ linux-2.5.exp/arch/ia64/kernel/time.c	Mon Aug 12 17:35:26 2002
@@ -23,7 +23,7 @@
 #include <asm/sal.h>
 #include <asm/system.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 extern unsigned long last_time_offset;
 
@@ -87,7 +87,7 @@
 void
 do_settimeofday (struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	{
 		/*
 		 * This is revolting. We need to set "xtime" correctly. However, the value
@@ -109,16 +109,16 @@
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
@@ -135,8 +135,7 @@
 
 		sec = xtime.tv_sec;
 		usec += xtime.tv_usec;
-	}
-	read_unlock_irqrestore(&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -179,10 +178,10 @@
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
 

