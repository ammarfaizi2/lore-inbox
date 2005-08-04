Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVHDJlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVHDJlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 05:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVHDJlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 05:41:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:15544 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262457AbVHDJk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 05:40:56 -0400
Subject: [PATCH] Remove suspend() calls from shutdown path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 11:36:26 +0200
Message-Id: <1123148187.30257.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This patch remove the calls to device_suspend() from the shutdown path
that were added sometime during 2.6.13-rc*. They aren't working properly
on a number of configs (I got reports from both ppc powerbook users and
x86 users) causing the system to not shutdown anymore.

I think it isn't the right approach at the moment anyway. We have
already a shutdown() callback for the drivers that actually care about
shutdown and the suspend() code isn't yet in a good enough shape to be
so much generalized. Also, the semantics of suspend and shutdown are
slightly different on a number of setups and the way this was patched in
provides little way for drivers to cleanly differenciate. It should have
been at least a different message.

For 2.6.13, I think we should revert to 2.6.12 behaviour and have a
working suspend back.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/sys.c
===================================================================
--- linux-work.orig/kernel/sys.c	2005-08-01 14:03:46.000000000 +0200
+++ linux-work/kernel/sys.c	2005-08-04 11:32:51.000000000 +0200
@@ -404,7 +404,6 @@
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 	system_state = SYSTEM_HALT;
-	device_suspend(PMSG_SUSPEND);
 	device_shutdown();
 	printk(KERN_EMERG "System halted.\n");
 	machine_halt();
@@ -415,7 +414,6 @@
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 	system_state = SYSTEM_POWER_OFF;
-	device_suspend(PMSG_SUSPEND);
 	device_shutdown();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();


