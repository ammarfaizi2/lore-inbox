Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJYOdX>; Fri, 25 Oct 2002 10:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJYOdX>; Fri, 25 Oct 2002 10:33:23 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50961 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261437AbSJYOdU>; Fri, 25 Oct 2002 10:33:20 -0400
Date: Fri, 25 Oct 2002 16:39:01 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac3
Message-ID: <20021025143901.GA14098@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@redhat.com>
Date: Fri, Oct 25, 2002 at 06:19:08AM -0400
> 
>    This one builds, its not yet had any measurable testing

I disagree :-)

> 
> Linux 2.5.44-ac3
> o	Fix APM BUG() on SMP boxes, port forward 2.4	(me)
> 	changes

I have such a box. 2.5.44-ac3 introduces cpu_logical_map() in apm.c,
which isn't defined for i386 anywhere. It is in other architectures; I
don't know what's going on with it.

I used this patch from Manfred Spraul up till now, which works fine.

Kind regards,
Jurriaan

--- a/arch/i386/kernel/apm.c	2002-10-12 06:21:05.000000000 +0200
+++ b/arch/i386/kernel/apm.new	2002-10-20 19:48:30.000000000 +0200
@@ -912,10 +911,10 @@
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
 	if (smp_processor_id() != 0) {
-		current->cpus_allowed = 1;
-		schedule();
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
+		if (cpu_online(0))
+			set_cpus_allowed(current, 1);
+		else
+			printk(KERN_INFO "apm: CPU 0 is offline, trying apm shutdown from cpu %d\n", smp_processor_id());
 	}
 #endif
 	if (apm_info.realmode_power_off)
@@ -1693,10 +1692,10 @@
 	 * Method suggested by Ingo Molnar.
 	 */
 	if (smp_processor_id() != 0) {
-		current->cpus_allowed = 1;
-		schedule();
-		if (unlikely(smp_processor_id() != 0))
-			BUG();
+		if (cpu_online(0))
+			set_cpus_allowed(current, 1);
+		else
+			printk(KERN_INFO "apm: CPU 0 is offline, trying apm shutdown from cpu %d\n", smp_processor_id());
 	}
 #endif
 
-- 
Endora is where we are, and you need to know that describing this place is
like dancing to no music.
	Peter Hedges - What's eating Gilbert Grape
GNU/Linux 2.5.44-ac2 SMP/ReiserFS 2x1380 bogomips load av: 7.31 2.92 1.19
