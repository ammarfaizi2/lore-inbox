Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWHCPwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWHCPwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHCPwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:52:21 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:50113 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932574AbWHCPwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:52:20 -0400
Date: Fri, 04 Aug 2006 00:53:52 +0900 (JST)
Message-Id: <20060804.005352.128616651.anemo@mba.ocn.ne.jp>
To: schwidefsky@googlemail.com
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
References: <6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
	<20060801.234422.25910237.anemo@mba.ocn.ne.jp>
	<6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 14:50:32 +0200, "Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:
> If you switch of the hz timer in idle you'll get lots of lost ticks.
> And if you are
> running a virtualized system you can loose you cpu for some ticks as well.
> Pass the number of ticks to do_timer.

I see.  Then how about this?


[PATCH] cleanup do_timer and update_times

Rename do_timer() to do_timer_ticks() and pass ticks.  Now do_timer()
is just wrapper of do_timer_ticks().

This also make a barrier added by
5aee405c662ca644980c184774277fc6d0769a84 needless.

Also adjust x86_64 timer interrupt handler with this change.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7a9b182..3dbe30e 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -421,16 +421,14 @@ #endif
 				(((long) offset << US_SCALE) / vxtime.tsc_quot) - 1;
 	}
 
-	if (lost > 0) {
+	if (lost > 0)
 		handle_lost_ticks(lost, regs);
-		jiffies += lost;
-	}
 
 /*
  * Do the timer stuff.
  */
 
-	do_timer(regs);
+	do_timer_ticks(lost + 1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6afa72e..5d7dfa1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,7 +1180,8 @@ extern void switch_uid(struct user_struc
 
 #include <asm/current.h>
 
-extern void do_timer(struct pt_regs *);
+extern void do_timer_ticks(unsigned long ticks);
+#define do_timer(regs)	do_timer_ticks(1)
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
diff --git a/kernel/timer.c b/kernel/timer.c
index b650f04..50ed235 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1218,7 +1218,7 @@ static inline void calc_load(unsigned lo
 	static int count = LOAD_FREQ;
 
 	count -= ticks;
-	if (count < 0) {
+	while (count < 0) {
 		count += LOAD_FREQ;
 		active_tasks = count_active_tasks();
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
@@ -1265,11 +1265,8 @@ void run_local_timers(void)
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
-static inline void update_times(void)
+static inline void update_times(unsigned long ticks)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
 	wall_jiffies += ticks;
 	update_wall_time();
 	calc_load(ticks);
@@ -1281,12 +1278,10 @@ static inline void update_times(void)
  * jiffies is defined in the linker script...
  */
 
-void do_timer(struct pt_regs *regs)
+void do_timer_ticks(unsigned long ticks)
 {
-	jiffies_64++;
-	/* prevent loading jiffies before storing new jiffies_64 value. */
-	barrier();
-	update_times();
+	jiffies_64 += ticks;
+	update_times(ticks);
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM
