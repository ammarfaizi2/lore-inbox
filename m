Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVHAQPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVHAQPD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVHAQMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:12:43 -0400
Received: from ns.suse.de ([195.135.220.2]:3553 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262169AbVHAQKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:10:41 -0400
Date: Mon, 1 Aug 2005 18:10:39 +0200
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: [PATCH] remove device_suspend calls in sys_reboot path
Message-ID: <20050801161039.GA29705@suse.de>
References: <200506260105.j5Q15eBj021334@hera.kernel.org> <20050801151956.GA29448@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050801151956.GA29448@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent change for 'case LINUX_REBOOT_CMD_POWER_OFF' causes an endless
hang after 'halt -p' on my Macs with USB keyboard.
It went into rc1, but the hang in an usb device (1-1.3) shows up only
with rc3. Why is device_suspend() called anyway if the
system will go down anyway in a few milliseconds?

power down works again with this patch.

Signed-off-by: Olaf Hering <olh@suse.de>

 kernel/sys.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.13-rc4-git4/kernel/sys.c
===================================================================
--- linux-2.6.13-rc4-git4.orig/kernel/sys.c
+++ linux-2.6.13-rc4-git4/kernel/sys.c
@@ -392,7 +392,6 @@ void kernel_kexec(void)
 	}
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 	system_state = SYSTEM_RESTART;
-	device_suspend(PMSG_FREEZE);
 	device_shutdown();
 	printk(KERN_EMERG "Starting new kernel\n");
 	machine_shutdown();
@@ -405,7 +404,7 @@ void kernel_halt(void)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 	system_state = SYSTEM_HALT;
-	device_suspend(PMSG_SUSPEND);
+	device_suspend(PMSG_SUSPEND); /* FIXME */
 	device_shutdown();
 	printk(KERN_EMERG "System halted.\n");
 	machine_halt();
@@ -416,7 +415,6 @@ void kernel_power_off(void)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 	system_state = SYSTEM_POWER_OFF;
-	device_suspend(PMSG_SUSPEND);
 	device_shutdown();
 	printk(KERN_EMERG "Power down.\n");
 	machine_power_off();
