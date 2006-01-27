Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWA0Wyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWA0Wyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWA0Wyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:54:36 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:37584 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422665AbWA0Wx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:53:58 -0500
Date: Sat, 28 Jan 2006 00:53:57 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] sh: machine_halt()/machine_power_off() cleanups.
Message-ID: <20060127225357.GK30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

machine_halt() managed to trigger the soft lockup detection
due to not disabling interrupts before going to sleep, so
correct that.

machine_power_off() should be using pm_power_off, which
lets us drop the board-specific hacks from here.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/process.c |   54 ++++++++++++++++++++++------------------------
 1 files changed, 26 insertions(+), 28 deletions(-)

38550502f429e90b18c2d05cd976593b63d164f0
diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index a4dc2b5..9fd1723 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -15,21 +15,18 @@
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/elfcore.h>
-#include <linux/slab.h>
 #include <linux/a.out.h>
+#include <linux/slab.h>
+#include <linux/pm.h>
 #include <linux/ptrace.h>
 #include <linux/platform.h>
 #include <linux/kallsyms.h>
+#include <linux/kexec.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/elf.h>
-#if defined(CONFIG_SH_HS7751RVOIP)
-#include <asm/hs7751rvoip/hs7751rvoip.h>
-#elif defined(CONFIG_SH_RTS7751R2D)
-#include <asm/rts7751r2d/rts7751r2d.h>
-#endif
 
 static int hlt_counter=0;
 
@@ -37,6 +34,11 @@ int ubc_usercnt = 0;
 
 #define HARD_IDLE_TIMEOUT (HZ / 3)
 
+void (*pm_idle)(void);
+
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -51,17 +53,25 @@ void enable_hlt(void)
 
 EXPORT_SYMBOL(enable_hlt);
 
+void default_idle(void)
+{
+	if (!hlt_counter)
+		cpu_sleep();
+	else
+		cpu_relax();
+}
+
 void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		if (hlt_counter) {
-			while (!need_resched())
-				cpu_relax();
-		} else {
-			while (!need_resched())
-				cpu_sleep();
-		}
+		void (*idle)(void) = pm_idle;
+
+		if (!idle)
+			idle = default_idle;
+
+		while (!need_resched())
+			idle();
 
 		preempt_enable_no_resched();
 		schedule();
@@ -88,28 +98,16 @@ void machine_restart(char * __unused)
 
 void machine_halt(void)
 {
-#if defined(CONFIG_SH_HS7751RVOIP)
-	unsigned short value;
+	local_irq_disable();
 
-	value = ctrl_inw(PA_OUTPORTR);
-	ctrl_outw((value & 0xffdf), PA_OUTPORTR);
-#elif defined(CONFIG_SH_RTS7751R2D)
-	ctrl_outw(0x0001, PA_POWOFF);
-#endif
 	while (1)
 		cpu_sleep();
 }
 
 void machine_power_off(void)
 {
-#if defined(CONFIG_SH_HS7751RVOIP)
-	unsigned short value;
-
-	value = ctrl_inw(PA_OUTPORTR);
-	ctrl_outw((value & 0xffdf), PA_OUTPORTR);
-#elif defined(CONFIG_SH_RTS7751R2D)
-	ctrl_outw(0x0001, PA_POWOFF);
-#endif
+	if (pm_power_off)
+		pm_power_off();
 }
 
 void show_regs(struct pt_regs * regs)
