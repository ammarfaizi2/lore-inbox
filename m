Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWB0Wfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWB0Wfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWB0WcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27265 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932403AbWB0Wb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:58 -0500
Message-Id: <20060227223344.160102000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ashok Raj <ashok.raj@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/39] [PATCH] i386/x86-64: Dont IPI to offline cpus on shutdown
Content-Disposition: inline; filename=i386-x86-64-don-t-ipi-to-offline-cpus-on-shutdown.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

So why are we calling smp_send_stop from machine_halt?

We don't.

Looking more closely at the bug report the problem here
is that halt -p is called which triggers not a halt but
an attempt to power off.

machine_power_off calls machine_shutdown which calls smp_send_stop.

If pm_power_off is set we should never make it out machine_power_off
to the call of do_exit.  So pm_power_off must not be set in this case.
When pm_power_off is not set we expect machine_power_off to devolve
into machine_halt.

So how do we fix this?

Playing too much with smp_send_stop is dangerous because it
must also be safe to be called from panic.

It looks like the obviously correct fix is to only call
machine_shutdown when pm_power_off is defined.  Doing
that will make Andi's assumption about not scheduling
true and generally simplify what must be supported.

This turns machine_power_off into a noop like machine_halt
when pm_power_off is not defined.

If the expected behavior is that sys_reboot(LINUX_REBOOT_CMD_POWER_OFF)
becomes sys_reboot(LINUX_REBOOT_CMD_HALT) if pm_power_off is NULL
this is not quite a comprehensive fix as we pass a different parameter
to the reboot notifier and we set system_state to a different value
before calling device_shutdown().

Unfortunately any fix more comprehensive I can think of is not
obviously correct.  The core problem is that there is no architecture
independent way to detect if machine_power will become a noop, without
calling it.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/i386/kernel/reboot.c   |    7 ++++---
 arch/x86_64/kernel/reboot.c |   10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
index 2fa5803..d207242 100644
--- linux-2.6.15.4.orig/arch/i386/kernel/reboot.c
+++ linux-2.6.15.4/arch/i386/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
+#include <linux/pm.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
@@ -355,10 +356,10 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	machine_shutdown();
-
-	if (pm_power_off)
+	if (pm_power_off) {
+		machine_shutdown();
 		pm_power_off();
+	}
 }
 
 
--- linux-2.6.15.4.orig/arch/x86_64/kernel/reboot.c
+++ linux-2.6.15.4/arch/x86_64/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 #include <asm/kdebug.h>
 #include <asm/delay.h>
@@ -154,10 +155,11 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
-	if (!reboot_force) {
-		machine_shutdown();
-	}
-	if (pm_power_off)
+	if (pm_power_off) {
+		if (!reboot_force) {
+			machine_shutdown();
+		}
 		pm_power_off();
+	}
 }
 

--
