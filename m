Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSAQAUD>; Wed, 16 Jan 2002 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSAQATq>; Wed, 16 Jan 2002 19:19:46 -0500
Received: from air-1.osdl.org ([65.201.151.5]:14600 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S289113AbSAQATb>;
	Wed, 16 Jan 2002 19:19:31 -0500
Date: Wed, 16 Jan 2002 16:17:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] Alt-SysRq loglevel on cheapo keyboards
Message-ID: <Pine.LNX.4.33L2.0201161604450.13155-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In using some cheapo keyboards, I've run across a few that
don't generate a keycode on Alt-SysRq-N (for changing
console loglevel).  Actually, some values of N work and
some values don't work in the cases that I have seen.

I've been using this patch for the last 3 months or so.
It adds Alt-SysRq-Y to increase the loglevel and
Alt-SysRq-V to decrease the loglevel.

Enjoy.
-- 
~Randy


patch_name:	sysrq-logupdown.dif
patch_version:	2002.01.16
author:		Randy Dunlap (rddunlap@osdl.org)
description:	adds Alt-Sysrq-Y and Alt-Sysrq-V to increase/decrease
		console loglevel for keyboards on which some combo keys
		(like Alt-SysRq-9) don't work.
product:	Linux kernel
product_versions: 2.4.16, 2.5.0, 2.5.1
changelog:
URL:		http://www.osdl.org/archive/rddunlap/patches/
requires:	none
conflicts:	none

diffstat:
 sysrq.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)


--- linux/drivers/char/sysrq.c.org	Tue Oct  2 09:20:37 2001
+++ linux/drivers/char/sysrq.c	Tue Jan 15 14:07:52 2002
@@ -56,6 +56,38 @@
 	action_msg:	"Changing Loglevel",
 };

+/* Loglevel Up sysrq handler */
+static void sysrq_handle_loglevel_up(int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty) {
+	int i = console_loglevel;
+	if (i < 9)
+		i++;
+	printk("%d\n", i);
+	console_loglevel = i;
+}
+
+/* Loglevel Down sysrq handler */
+static void sysrq_handle_loglevel_down(int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty) {
+	int i = console_loglevel;
+	if (i > 0)
+		i--;
+	printk("%d\n", i);
+	console_loglevel = i;
+}
+
+static struct sysrq_key_op sysrq_loglevel_up = {
+	handler:	sysrq_handle_loglevel_up,
+	help_msg:	"loglevelYup",
+	action_msg:	"Loglevel set to ",
+};
+
+static struct sysrq_key_op sysrq_loglevel_down = {
+	handler:	sysrq_handle_loglevel_down,
+	help_msg:	"loglevelVdown",
+ 	action_msg:	"Loglevel set to ",
+ };
+

 /* SAK sysrq handler */
 #ifdef CONFIG_VT
@@ -377,10 +409,10 @@
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,
-/* v */	NULL,
+/* v */	&sysrq_loglevel_down,
 /* w */	NULL,
 /* x */	NULL,
-/* w */	NULL,
+/* y */	&sysrq_loglevel_up,
 /* z */	NULL
 };



