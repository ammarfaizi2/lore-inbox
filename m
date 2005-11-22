Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVKVF06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVKVF06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKVF06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:26:58 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:42375 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932329AbVKVF06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:26:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Tue, 22 Nov 2005 00:26:55 -0500
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, Bj?rn Mork <bjorn@mork.no>,
       linux-kernel@vger.kernel.org
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com> <20051119234850.GC1952@spitz.ucw.cz>
In-Reply-To: <20051119234850.GC1952@spitz.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2512
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511220026.55589.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 18:48, Pavel Machek wrote:
> Hi!
> 
> > > > >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
> > > > >
> > > > > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > > > > know if 30 seconds timeout helps.
> > > >
> > > > It does.
> > >
> > > Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
> > > guess it gets wrong timing by design. Question is what to do with
> > > that. Could we make keyboard driver pause the boot until it is done
> > > resetting hardware? Or we can increase the timeout... would 10 seconds
> > > be enough?
> > 
> > Well, I think 10 seconds when suspending is a nice and resonable
> > number. For resume though I think we should wait much longer, maybe
> > even indefinitely - the only thing that timeout achieves is makes
> > people fsck because the system can't recover from that state.
> 
> I see your point, but it does not seem we need that changes this far. Your
> patch is better, because we *could* hit that during suspend, just after 
> keyboard hotplug... right? And it will make resume faster for affected people.
> 

Pavel,

I disagree here. While my patch is a right thing to do (and as you
know is already merged in mainline) it is not "better". Swsusp should
not rely on the other subsystems being "nice" to it. Even with my
patch there still could be moments when some thread is not suspended
in 6 seconds when resuming causing unneeded resume failure and
subsequent fsck. 

Please consider merging the patch below.

-- 
Dmitry

Swsusp: do not time-out when stopping tasks while resuming

When stopping tasks during esume process there is no point of
eastablishing a timeout because teh process is past the point
of no return; there is no possible recovery from failure. If
stopping tasks fails resume is aborted and user is forced to
do fsck anyway.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 include/linux/sched.h  |    4 ----
 kernel/power/power.h   |    2 +-
 kernel/power/process.c |    6 ++++--
 3 files changed, 5 insertions(+), 7 deletions(-)

Index: work/include/linux/sched.h
===================================================================
--- work.orig/include/linux/sched.h
+++ work/include/linux/sched.h
@@ -1434,8 +1434,6 @@ static inline void frozen_process(struct
 }
 
 extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 static inline int try_to_freeze(void)
 {
@@ -1453,8 +1451,6 @@ static inline int thaw_process(struct ta
 static inline void frozen_process(struct task_struct *p) { BUG(); }
 
 static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
 
 static inline int try_to_freeze(void) { return 0; }
 
Index: work/kernel/power/power.h
===================================================================
--- work.orig/kernel/power/power.h
+++ work/kernel/power/power.h
@@ -48,7 +48,7 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-extern int freeze_processes(void);
+extern int freeze_processes(suspend_state_t state);
 extern void thaw_processes(void);
 
 extern int pm_prepare_console(void);
Index: work/kernel/power/process.c
===================================================================
--- work.orig/kernel/power/process.c
+++ work/kernel/power/process.c
@@ -55,15 +55,17 @@ void refrigerator(void)
 }
 
 /* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
+int freeze_processes(suspend_state_t state)
 {
 	int todo;
 	unsigned long start_time;
+	unsigned int timeout;
 	struct task_struct *g, *p;
 	unsigned long flags;
 
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
+	timeout = state == PM_SUSPEND_ON ? 0 : 6 * HZ;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
@@ -81,7 +83,7 @@ int freeze_processes(void)
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
+		if (todo && timeout && time_after(jiffies, start_time + timeout)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
 			break;

