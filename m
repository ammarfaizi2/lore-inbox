Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUB0BQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUB0BQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:16:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:57012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbUB0BMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:12:46 -0500
Date: Thu, 26 Feb 2004 17:14:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: gluk@php4.ru, linux-kernel@vger.kernel.org, rathamahata@php4.ru
Subject: Re: 2.6.3 Oops when power-off via sys-rq
Message-Id: <20040226171437.031226d0.akpm@osdl.org>
In-Reply-To: <1077836027.22401.85.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F3396@hdsmsx402.hd.intel.com>
	<1077836027.22401.85.camel@dhcppc4>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> Alexander,
> Please file an bug at bugzilla.kernel.org
> category: power management
> component: ACPI

We'll need this fix (at least).  But I haven't tested it yet.





sysrq-o is supposed to power off the machine.  But if it calls into ACPI (at
least) it does lots of sleepy things, so we best not do this from interrupt
context.


---

 kernel/power/poweroff.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -puN kernel/power/poweroff.c~poweroff-atomicity-fix kernel/power/poweroff.c
--- 25/kernel/power/poweroff.c~poweroff-atomicity-fix	2004-02-26 05:13:59.000000000 -0800
+++ 25-akpm/kernel/power/poweroff.c	2004-02-26 05:18:31.000000000 -0800
@@ -8,33 +8,33 @@
 #include <linux/sysrq.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/workqueue.h>
 
-
-/**
- * handle_poweroff	-	sysrq callback for power down
- * @key: key pressed (unused)
- * @pt_regs: register state (unused)
- * @kbd: keyboard state (unused)
- * @tty: tty involved (unused)
- *
+/*
  * When the user hits Sys-Rq o to power down the machine this is the
  * callback we use.
  */
 
-static void handle_poweroff (int key, struct pt_regs *pt_regs,
-			     struct tty_struct *tty)
+static void do_poweroff(void *dummy)
 {
 	if (pm_power_off)
 		pm_power_off();
 }
 
+static DECLARE_WORK(poweroff_work, do_poweroff, 0);
+
+static void handle_poweroff(int key, struct pt_regs *pt_regs,
+				struct tty_struct *tty)
+{
+	schedule_work(&poweroff_work);
+}
+
 static struct sysrq_key_op	sysrq_poweroff_op = {
 	.handler        = handle_poweroff,
 	.help_msg       = "powerOff",
 	.action_msg     = "Power Off\n"
 };
 
-
 static int pm_sysrq_init(void)
 {
 	register_sysrq_key('o', &sysrq_poweroff_op);

_

