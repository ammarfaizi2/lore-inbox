Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSJMTSs>; Sun, 13 Oct 2002 15:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJMTSs>; Sun, 13 Oct 2002 15:18:48 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:37760 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261588AbSJMTSl>; Sun, 13 Oct 2002 15:18:41 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 13 Oct 2002 12:24:26 -0700
Message-Id: <200210131924.MAA00308@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.42 had an annoying new behavior.  When I would
try to do a warm reboot, it would spin down the hard drives, which
just made the reboot take longer and gave the impression that a
halt or poweroff was in progress.

	At first, I suspected IDE, but I think the new behavior in IDE
of spinning down the hard drives on suspend is correct.  The problem
is that the warm reboot system call is trying to suspend all of the
devices before a warm reboot for no reason.  We already have a reboot
notifier chain that drivers can use to register code that has to be
run in order to safely reboot or halt.  I am not talking about
eliminating that.  I am only talking about the soft reboot putting
devices into a power saving mode that is allowed to take a long
recovery time, especially given that the reboot is likely to want to
talk to every hardware device connected to the system.

	Anyhow, here is the patch.  As far as I can tell, there is no
delegated mainainer for kernel/sys.c, so I am sending this to
linux-kernel and I will resend it to Linus later if nobody points me
to another maintainer to go through and there are no complaints.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.42/kernel/sys.c	2002-10-11 21:21:31.000000000 -0700
+++ linux/kernel/sys.c	2002-10-13 11:57:45.000000000 -0700
@@ -365,7 +365,6 @@
 	case LINUX_REBOOT_CMD_RESTART:
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_running = 0;
-		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
 		break;
