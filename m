Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSHMQj4>; Tue, 13 Aug 2002 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSHMQj4>; Tue, 13 Aug 2002 12:39:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318249AbSHMQjz>;
	Tue, 13 Aug 2002 12:39:55 -0400
Subject: [PATCH] fast reader/writer lock for gettimeofday 2.5.30 - addendum
	apm.c
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1029195577.1978.22.camel@dell_ss3.pdx.osdl.net>
References: <1029195577.1978.22.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Aug 2002 09:43:46 -0700
Message-Id: <1029257026.6437.5.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missed this part which updated i386 apm.c
--- linux-2.5/arch/i386/kernel/apm.c	Mon Aug 12 10:17:59 2002
+++ linux-2.5.exp/arch/i386/kernel/apm.c	Mon Aug 12 17:25:57 2002
@@ -215,6 +215,7 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/frlock.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -222,7 +223,7 @@
 
 #include <linux/sysrq.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -1190,7 +1191,7 @@
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 	/* serialize with the timer interrupt */
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 
 	/* protect against access to timer chip registers */
 	spin_lock(&i8253_lock);
@@ -1202,7 +1203,7 @@
 	ignore_normal_resume = 1;
 
 	spin_unlock(&i8253_lock);
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
@@ -1227,10 +1228,10 @@
 	int	err;
 
 	/* serialize with the timer interrupt */
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
 	get_time_diff();
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
@@ -1319,9 +1320,9 @@
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				write_lock_irq(&xtime_lock);
+				fr_write_lock_irq(&xtime_lock);
 				set_time();
-				write_unlock_irq(&xtime_lock);
+				fr_write_unlock_irq(&xtime_lock);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
@@ -1336,9 +1337,9 @@
 			break;
 
 		case APM_UPDATE_TIME:
-			write_lock_irq(&xtime_lock);
+			fr_write_lock_irq(&xtime_lock);
 			set_time();
-			write_unlock_irq(&xtime_lock);
+			fr_write_unlock_irq(&xtime_lock);
 			break;
 
 		case APM_CRITICAL_SUSPEND:

