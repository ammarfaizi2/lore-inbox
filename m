Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTAaR3v>; Fri, 31 Jan 2003 12:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAaR3v>; Fri, 31 Jan 2003 12:29:51 -0500
Received: from poup.poupinou.org ([195.101.94.96]:28173 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261660AbTAaR3n>; Fri, 31 Jan 2003 12:29:43 -0500
Date: Fri, 31 Jan 2003 18:39:04 +0100
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       ducrot@poupinou.org
Subject: [PATCH] s4bios for 2.5.59 + apci-20030123
Message-ID: <20030131173904.GA3240@poup.poupinou.org>
Reply-To: ducrot@poupinou.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

This patch is for s4bios support in 2.5.59 with acpi-20030123.

This is the 'minimal' requirement.  Some devices (especially the
IDE part) are not well resumed.  Handle with care..

Note also that the resuming part (I mean IDE) was more stable
with an equivalent patch when I tested with 2.5.54 (grumble grumble)...

I think also that it is a 'good' checker for devices power management
in general...




 arch/i386/kernel/acpi_wakeup.S  |   35 ++++++++++++++++++++++++++-----
 drivers/acpi/acpi_ksyms.c       |    1 
 drivers/acpi/hardware/hwsleep.c |   45 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c            |   39 ++++++++++++++++++++++++++++++----
 include/acpi/acpixf.h           |    4 +++
 include/linux/suspend.h         |    1 
 6 files changed, 115 insertions(+), 10 deletions(-)


--- linux-2.5.59-acpi-20030123/arch/i386/kernel/acpi_wakeup.S	2003/01/31 15:37:05	1.1
+++ linux-2.5.59-acpi-20030123/arch/i386/kernel/acpi_wakeup.S	2003/01/31 16:33:25
@@ -160,9 +160,9 @@
 	ALIGN
 
 
-.org	0x2000
+.org	0x800
 wakeup_stack:
-.org	0x3000
+.org	0x900
 ENTRY(wakeup_end)
 .org	0x4000
 
@@ -274,7 +274,7 @@
 
 ENTRY(do_suspend_lowlevel)
 	cmpl $0,4(%esp)
-	jne .L1432
+	jne ret_point
 	call save_processor_state
 
 	movl %esp, saved_context_esp
@@ -287,7 +287,7 @@
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags
 
-	movl $.L1432,saved_eip
+	movl $ret_point,saved_eip
 	movl %esp,saved_esp
 	movl %ebp,saved_ebp
 	movl %ebx,saved_ebx
@@ -299,7 +299,7 @@
 	addl $4,%esp
 	ret
 	.p2align 4,,7
-.L1432:
+ret_point:
 	movl $__KERNEL_DS,%eax
 	movw %ax, %ds
 	movl saved_context_esp, %esp
@@ -312,6 +312,31 @@
 	movl saved_context_edi, %edi
 	call restore_processor_state
 	pushl saved_context_eflags ; popfl
+	ret
+
+ENTRY(do_suspend_lowlevel_s4bios)
+	cmpl $0,4(%esp)
+	jne ret_point
+	call save_processor_state
+
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+
+	movl $ret_point,saved_eip
+	movl %esp,saved_esp
+	movl %ebp,saved_ebp
+	movl %ebx,saved_ebx
+	movl %edi,saved_edi
+	movl %esi,saved_esi
+
+	call acpi_enter_sleep_state_s4bios
 	ret
 
 ALIGN
--- linux-2.5.59-acpi-20030123/drivers/acpi/hardware/hwsleep.c	2003/01/31 15:37:10	1.1
+++ linux-2.5.59-acpi-20030123/drivers/acpi/hardware/hwsleep.c	2003/01/31 16:37:27
@@ -316,6 +316,51 @@
 	return_ACPI_STATUS (AE_OK);
 }
 
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enter_sleep_state_s4bios
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform a s4 bios request.
+ *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_enter_sleep_state_s4bios (
+	void)
+{
+	u32                     in_value;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_hw_clear_acpi_status();
+
+	acpi_hw_disable_non_wakeup_gpes();
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	do {
+		acpi_os_stall(1000);
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	} while (!in_value);
+ 
+ 	return_ACPI_STATUS (AE_OK);
+ }
+ 
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_leave_sleep_state
--- linux-2.5.59-acpi-20030123/drivers/acpi/sleep.c	2003/01/31 15:37:19	1.1
+++ linux-2.5.59-acpi-20030123/drivers/acpi/sleep.c	2003/01/31 16:29:13
@@ -150,8 +150,10 @@
 		if (state > ACPI_STATE_S1) {
 			error = acpi_save_state_mem();
 
+#if 0
 			if (!error && (state == ACPI_STATE_S4))
 				error = acpi_save_state_disk();
+#endif
 
 			if (error) {
 				device_resume(RESUME_RESTORE_STATE);
@@ -223,11 +225,17 @@
 		status = acpi_enter_sleep_state(state);
 		break;
 
-	case ACPI_STATE_S2:
 #ifdef CONFIG_SOFTWARE_SUSPEND
+	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel(0);
+		break;
 #endif
+	case ACPI_STATE_S4:
+		do_suspend_lowlevel_s4bios(0);
+		break;
+	default:
+		printk(KERN_WARNING PREFIX "don't know how to handle %d state.\n", state);
 		break;
 	}
 	local_irq_restore(flags);
@@ -251,10 +259,20 @@
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
+	/* Since we handle S4OS via a different path (swsusp), give up if no s4bios. */
+	if (state == ACPI_STATE_S4 && !acpi_gbl_FACS->S4bios_f)
+		return AE_ERROR;
+
+	/*
+	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
+	 * to handle however when S1 failed without device_suspend.
+	 */
 	freeze_processes();		/* device_suspend needs processes to be stopped */
 
 	/* do we have a wakeup address for S2 and S3? */
-	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
+	/* Here, we support only S4BIOS, those we set the wakeup address */
+	/* S4OS is only supported for now via swsusp.. */
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || ACPI_STATE_S4) {
 		if (!acpi_wakeup_address)
 			return AE_ERROR;
 		acpi_set_firmware_waking_vector((acpi_physical_address) acpi_wakeup_address);
@@ -297,8 +315,11 @@
 	ACPI_FUNCTION_TRACE("acpi_system_sleep_seq_show");
 
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
-		if (sleep_states[i])
+		if (sleep_states[i]) {
 			seq_printf(seq,"S%d ", i);
+			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f)
+				seq_printf(seq, "S4bios ");
+		}
 	}
 
 	seq_puts(seq, "\n");
@@ -337,12 +358,16 @@
 	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
+	if (state == 4 && state_string[1] != 'b') {
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	if (state == 4) {
 		software_suspend();
 		return_VALUE(count);
-	}
+#else
+		printk(KERN_WARNING PREFIX "no swsusp support!?\n");
+		printk(KERN_WARNING PREFIX "Trying S4bios instead\n");
 #endif
+	}
+
 	status = acpi_suspend(state);
 
 	if (ACPI_FAILURE(status))
@@ -661,6 +686,10 @@
 		if (ACPI_SUCCESS(status)) {
 			sleep_states[i] = 1;
 			printk(" S%d", i);
+		}
+		if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f) {
+			sleep_states[i] = 1;
+			printk(" S4bios");
 		}
 	}
 	printk(")\n");
--- linux-2.5.59-acpi-20030123/drivers/acpi/acpi_ksyms.c	2003/01/31 15:37:21	1.1
+++ linux-2.5.59-acpi-20030123/drivers/acpi/acpi_ksyms.c	2003/01/31 16:29:39
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(acpi_get_register);
 EXPORT_SYMBOL(acpi_set_register);
 EXPORT_SYMBOL(acpi_enter_sleep_state);
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
 EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_get_devices);
 
--- linux-2.5.59-acpi-20030123/include/acpi/acpixf.h	2003/01/31 15:38:22	1.1
+++ linux-2.5.59-acpi-20030123/include/acpi/acpixf.h	2003/01/31 16:31:57
@@ -380,6 +380,10 @@
 	u8                              sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                              sleep_state);
 
--- linux-2.5.59-acpi-20030123/include/linux/suspend.h	2003/01/31 15:37:22	1.1
+++ linux-2.5.59-acpi-20030123/include/linux/suspend.h	2003/01/31 16:30:28
@@ -73,6 +73,7 @@
 /* Communication between acpi and arch/i386/suspend.c */
 
 extern void do_suspend_lowlevel(int resume);
+extern void do_suspend_lowlevel_s4bios(int resume);
 
 #else
 static inline void software_suspend(void)




Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
