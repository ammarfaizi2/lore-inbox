Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRIFJkV>; Thu, 6 Sep 2001 05:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272441AbRIFJkM>; Thu, 6 Sep 2001 05:40:12 -0400
Received: from smtp3.libero.it ([193.70.192.53]:47232 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S270178AbRIFJkA>;
	Thu, 6 Sep 2001 05:40:00 -0400
From: "Delio Brignoli" <nordkyn@tin.it>
Date: Thu, 6 Sep 2001 11:42:24 +0200
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kapmd improvent?
Message-ID: <20010906114224.A1468@argo.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem:

After a burst of heavy load my system (a laptop) returns idle,
but kapmd isn't scheduled anymore so if I 'top' I can see the system nearly 
100% idle but kampd is consuming 0.0% CPU time.

The explanation:

when kapmd returns from schedule_timeout it checks if system_idle(), 
at this point if there is more than one task running we double 
timeout (clamp it to APM_CHECK_TIMEOUT) and go to sleep;
Q: what if there are tasks that are always 
running when we try to call apm_do_idle ? 
A: we never enter the kapmd inner loop.

the ?solution?:
make the timeout short if we find that the system is busy, 
some tries later if the system is idle enough we will enter 
the kapmd inner loop and do some power mgt.

Alternative solution instead of setting timeout to 1 we could

timeout >>= 2; /divide by 4
and clamp the value to 1 if it becomes 0

So the timeout changes smoothly.

On my system this makes kapmd come back fast.(without evil side effects, I hope ;) )

Let me know if this is useful somehow.

the patch is against vanilla 2.4.9

Regards

--
Delio

--- arch/i386/kernel/apm.c.orig	Tue Aug 14 01:39:28 2001
+++ arch/i386/kernel/apm.c	Tue Sep  4 11:02:24 2001
@@ -1136,8 +1136,10 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		apm_event_handler();
 #ifdef CONFIG_APM_CPU_IDLE
-		if (!system_idle())
+		if (!system_idle()) {
+			timeout = 1;
 			continue;
+		}
 		if (apm_do_idle()) {
 			unsigned long start = jiffies;
 			while ((!exit_kapmd) && system_idle()) {
