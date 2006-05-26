Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWEZQKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWEZQKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWEZQKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:10:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22153 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750977AbWEZQKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:10:54 -0400
Message-Id: <20060526161036.586358463@goodmis.org>
References: <20060526160651.870725515@goodmis.org>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 12:06:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: [PATCH -rt 1/2] Dont blindly turn on interrupts in boot_override_clocksource
Content-Disposition: inline; filename=clocksource-boot-irq-off.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boot_override_clocksource currently blindly turns on interrupts with
the releasing of the lock.  But if you have clocksource=xxx in the
command line, this function is called before interrupts are setup,
and causes early exception errors.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt23/kernel/time/clocksource.c
===================================================================
--- linux-2.6.16-rt23.orig/kernel/time/clocksource.c	2006-05-25 16:01:00.000000000 -0400
+++ linux-2.6.16-rt23/kernel/time/clocksource.c	2006-05-25 16:01:28.000000000 -0400
@@ -323,10 +323,11 @@ device_initcall(init_clocksource_sysfs);
  */
 static int __init boot_override_clocksource(char* str)
 {
-	spin_lock_irq(&clocksource_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&clocksource_lock, flags);
 	if (str)
 		strlcpy(override_name, str, sizeof(override_name));
-	spin_unlock_irq(&clocksource_lock);
+	spin_unlock_irqrestore(&clocksource_lock, flags);
 	return 1;
 }
 

--
