Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSIJTjz>; Tue, 10 Sep 2002 15:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIJTjy>; Tue, 10 Sep 2002 15:39:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15877
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318076AbSIJTjw>; Tue, 10 Sep 2002 15:39:52 -0400
Subject: [patch] Re: 2.5.3[3,4] Preemption problem
From: Robert Love <rml@tech9.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020909213137.28292.qmail@linuxmail.org>
References: <20020909213137.28292.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 15:44:38 -0400
Message-Id: <1031687078.1571.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 17:31, Paolo Ciarrocchi wrote:

> Halting system...
> Shutting down devices
> Power down.
> note: halt[15347] exited with preempt_count 1

I cooked up a patch... does this solve the problem (no more spurious
warning on reboot)?

Patch is against 2.5.34.

	Robert Love

diff -urN linux-2.5.34/kernel/sys.c linux/kernel/sys.c
--- linux-2.5.34/kernel/sys.c	Tue Sep 10 13:04:49 2002
+++ linux/kernel/sys.c	Tue Sep 10 15:40:35 2002
@@ -316,7 +316,7 @@
 
 	/* For safety, we require "magic" arguments. */
 	if (magic1 != LINUX_REBOOT_MAGIC1 ||
-	    (magic2 != LINUX_REBOOT_MAGIC2 && magic2 != LINUX_REBOOT_MAGIC2A &&
+	   (magic2 != LINUX_REBOOT_MAGIC2 && magic2 != LINUX_REBOOT_MAGIC2A &&
 			magic2 != LINUX_REBOOT_MAGIC2B))
 		return -EINVAL;
 
@@ -344,6 +344,7 @@
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
+		unlock_kernel();
 		do_exit(0);
 		break;
 
@@ -353,6 +354,7 @@
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
+		unlock_kernel();
 		do_exit(0);
 		break;
 

