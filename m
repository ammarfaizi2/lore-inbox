Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVHLNZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVHLNZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVHLNZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:25:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13997 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751175AbVHLNZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:25:00 -0400
Date: Fri, 12 Aug 2005 15:24:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Blaisorblade <blaisorblade@yahoo.it>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@lst.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch] Feature removal: ACPI S4bios support
Message-ID: <20050812132444.GH1826@elf.ucw.cz>
References: <200508111417.47499.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508111417.47499.blaisorblade@yahoo.it>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove S4BIOS support. It is pretty useless, and only ever worked for
_me_ once. (I do not think anyone else ever tried it). It was in
feature-removal for a long time, and it should have been removed before.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit a0c40c246460a82c6dcb4444d2da943484ffa6ed
tree 2378a5cdbc523736813d0ca358c820e0f61dbffc
parent 20bdabca2d11cc03d24fbb2b6e5b89ced19ccb09
author <pavel@amd.(none)> Fri, 12 Aug 2005 15:24:07 +0200
committer <pavel@amd.(none)> Fri, 12 Aug 2005 15:24:07 +0200

 arch/i386/kernel/acpi/wakeup.S |    6 ------
 drivers/acpi/sleep/main.c      |    8 --------
 drivers/acpi/sleep/poweroff.c  |    4 +---
 drivers/acpi/sleep/proc.c      |    2 --
 4 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
--- a/arch/i386/kernel/acpi/wakeup.S
+++ b/arch/i386/kernel/acpi/wakeup.S
@@ -320,12 +320,6 @@ ret_point:
 	call	restore_processor_state
 	ret
 
-ENTRY(do_suspend_lowlevel_s4bios)
-	call save_processor_state
-	call save_registers
-	call acpi_enter_sleep_state_s4bios
-	ret
-
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -23,7 +23,6 @@ u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
 
-extern void do_suspend_lowlevel_s4bios(void);
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
@@ -98,8 +97,6 @@ static int acpi_pm_enter(suspend_state_t
 	case PM_SUSPEND_DISK:
 		if (acpi_pm_ops.pm_disk_mode == PM_DISK_PLATFORM)
 			status = acpi_enter_sleep_state(acpi_state);
-		else
-			do_suspend_lowlevel_s4bios();
 		break;
 	case PM_SUSPEND_MAX:
 		acpi_power_off();
@@ -206,11 +203,6 @@ static int __init acpi_sleep_init(void)
 			printk(" S%d", i);
 		}
 		if (i == ACPI_STATE_S4) {
-			if (acpi_gbl_FACS->S4bios_f) {
-				sleep_states[i] = 1;
-				printk(" S4bios");
-				acpi_pm_ops.pm_disk_mode = PM_DISK_FIRMWARE;
-			}
 			if (sleep_states[i])
 				acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM;
 		}
diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -21,9 +21,7 @@ int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
-	/* Here, we support only S4BIOS, those we set the wakeup address */
-	/* S4OS is only supported for now via swsusp.. */
-	if (acpi_state == ACPI_STATE_S3 || acpi_state == ACPI_STATE_S4) {
+	if (acpi_state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address) {
 			return -EFAULT;
 		}
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -27,8 +27,6 @@ static int acpi_system_sleep_seq_show(st
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
 		if (sleep_states[i]) {
 			seq_printf(seq,"S%d ", i);
-			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f)
-				seq_printf(seq, "S4bios ");
 		}
 	}
 


-- 
if you have sharp zaurus hardware you don't need... you know my address
