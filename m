Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbTBZWVH>; Wed, 26 Feb 2003 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbTBZWUu>; Wed, 26 Feb 2003 17:20:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268957AbTBZWU2>;
	Wed, 26 Feb 2003 17:20:28 -0500
Date: Wed, 26 Feb 2003 22:13:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: S4bios support for 2.5.63
Message-ID: <20030226211347.GA14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is S4bios support for 2.5.63. I'd like to see it in since it is
easier to understand and more foolproof. Please apply,

							Pavel

--- clean/arch/i386/kernel/acpi/wakeup.S	2003-02-25 21:13:49.000000000 +0100
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-02-18 00:58:24.000000000 +0100
@@ -319,6 +319,31 @@
 	pushl saved_context_eflags ; popfl
 	ret
 
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
+	ret
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
--- clean/drivers/acpi/acpi_ksyms.c	2003-02-25 21:17:31.000000000 +0100
+++ linux/drivers/acpi/acpi_ksyms.c	2003-02-15 18:52:15.000000000 +0100
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(acpi_get_register);
 EXPORT_SYMBOL(acpi_set_register);
 EXPORT_SYMBOL(acpi_enter_sleep_state);
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
 EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_get_devices);
 
--- clean/drivers/acpi/hardware/hwsleep.c	2003-02-25 21:17:34.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2003-02-24 22:36:23.000000000 +0100
@@ -335,6 +335,51 @@
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
--- clean/drivers/acpi/sleep/main.c	2003-02-25 21:17:36.000000000 +0100
+++ linux/drivers/acpi/sleep/main.c	2003-02-18 22:36:39.000000000 +0100
@@ -183,14 +180,21 @@
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
+	printk(KERN_CRIT "Back to C!\n");
 
 	return status;
 }
@@ -211,10 +215,20 @@
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
@@ -268,6 +282,10 @@
 			sleep_states[i] = 1;
 			printk(" S%d", i);
 		}
+		if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f) {
+			sleep_states[i] = 1;
+			printk(" S4bios");
+		}
 	}
 	printk(")\n");
 
--- clean/drivers/acpi/sleep/proc.c	2003-02-25 21:17:37.000000000 +0100
+++ linux/drivers/acpi/sleep/proc.c	2003-02-15 18:57:55.000000000 +0100
@@ -27,8 +27,11 @@
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
--- clean/include/acpi/acpixf.h	2003-02-25 21:20:49.000000000 +0100
+++ linux/include/acpi/acpixf.h	2003-02-24 22:36:42.000000000 +0100
@@ -399,6 +399,10 @@
 	u8                              sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                              sleep_state);
 
--- clean/include/linux/suspend.h	2003-02-25 21:22:36.000000000 +0100
+++ linux/include/linux/suspend.h	2003-02-10 18:17:01.000000000 +0100
@@ -73,6 +73,7 @@
 /* Communication between acpi and arch/i386/suspend.c */
 
 extern void do_suspend_lowlevel(int resume);
+extern void do_suspend_lowlevel_s4bios(int resume);
 
 #else
 static inline void software_suspend(void)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
