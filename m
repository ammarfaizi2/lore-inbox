Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbSLQUbL>; Tue, 17 Dec 2002 15:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbSLQUbL>; Tue, 17 Dec 2002 15:31:11 -0500
Received: from poup.poupinou.org ([195.101.94.96]:4872 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267209AbSLQUbG>;
	Tue, 17 Dec 2002 15:31:06 -0500
Date: Tue, 17 Dec 2002 21:39:03 +0100
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       acpi-devel@lists.sourceforge.net
Subject: [PATCH] S4bios for 2.5.52.
Message-ID: <20021217203903.GC1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch add s4bios support for 2.5.52.

S4bios is an alternative for the ACPI S4 system suspend state, but is a bit
more easy to implement.  It suppose though that the BIOS support this feature.
For some BIOS, creating a so-called suspend partition with the help
of lphdisk is OK.

Plus, it permit for Pavel to have a nice graphic display at suspend/resume. 

echo 4 > /proc/acpi/sleep is for swsusp;
echo 4b > /proc/acpi/sleep is for s4bios.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s4bios-2.5.52.diff"

 arch/i386/kernel/acpi_wakeup.S  |   33 +++++++++++++++++++--
 drivers/acpi/acpi_ksyms.c       |    1 
 drivers/acpi/hardware/hwsleep.c |   61 ++++++++++++++++++++++++++++++++++++----
 drivers/acpi/include/acpixf.h   |    4 ++
 drivers/acpi/sleep.c            |   28 +++++++++++++++---
 include/linux/suspend.h         |    2 +
 6 files changed, 117 insertions(+), 12 deletions(-)

arch/i386/kernel/acpi_wakeup.S
--- linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 19:15:12	1.1
+++ linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 19:20:34
@@ -272,7 +272,7 @@
 
 ENTRY(do_suspend_lowlevel)
 	cmpl $0,4(%esp)
-	jne .L1432
+	jne ret_point
 	call save_processor_state
 
 	movl %esp, saved_context_esp
@@ -285,7 +285,7 @@
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags
 
-	movl $.L1432,saved_eip
+	movl $ret_point,saved_eip
 	movl %esp,saved_esp
 	movl %ebp,saved_ebp
 	movl %ebx,saved_ebx
@@ -297,7 +297,7 @@
 	addl $4,%esp
 	ret
 	.p2align 4,,7
-.L1432:
+ret_point:
 	movl $__KERNEL_DS,%eax
 	movw %ax, %ds
 	movl saved_context_esp, %esp
@@ -310,6 +310,33 @@
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
+	pushl $3
+	call acpi_enter_sleep_state_s4bios
+	addl $4,%esp
 	ret
 
 ALIGN
drivers/acpi/include/acpixf.h
--- linux-2.5.52/drivers/acpi/include/acpixf.h	2002/12/17 19:15:16	1.1
+++ linux-2.5.52/drivers/acpi/include/acpixf.h	2002/12/17 19:17:11
@@ -380,6 +380,10 @@
 	u8                      sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                      sleep_state);
 
drivers/acpi/hardware/hwsleep.c
--- linux-2.5.52/drivers/acpi/hardware/hwsleep.c	2002/12/17 19:15:17	1.1
+++ linux-2.5.52/drivers/acpi/hardware/hwsleep.c	2002/12/17 19:39:30
@@ -184,6 +184,7 @@
 acpi_enter_sleep_state (
 	u8                      sleep_state)
 {
+	int                     i;
 	u32                     PM1Acontrol;
 	u32                     PM1Bcontrol;
 	ACPI_BIT_REGISTER_INFO  *sleep_type_reg_info;
@@ -298,16 +299,18 @@
 	}
 
 	/* Wait until we enter sleep state */
+	/* But gracefully fail if we wait too long. */
 
+	i = 10;
 	do {
 		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
-
+		acpi_os_stall (1000);
 		/* Spin until we wake */
 
-	} while (!in_value);
+	} while (!in_value && --i);
 
 	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 	if (ACPI_FAILURE (status)) {
@@ -319,6 +322,54 @@
 
 /******************************************************************************
  *
+ * FUNCTION:    Acpi_enter_sleep_state_s4bios
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
+acpi_enter_sleep_state_s4bios (void)
+{
+	u32                     in_value;
+	int                     i;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
+
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_hw_clear_acpi_status();
+
+	acpi_hw_disable_non_wakeup_gpes();
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	acpi_os_stall (10000);
+
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	i = 10;
+	do {
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+		acpi_os_stall (1000);
+	} while (!in_value && --i);
+
+	return_ACPI_STATUS (AE_OK);
+}
+
+
+/******************************************************************************
+ *
  * FUNCTION:    Acpi_leave_sleep_state
  *
  * PARAMETERS:  Sleep_state         - Which sleep state we just exited
@@ -341,6 +392,9 @@
 	ACPI_FUNCTION_TRACE ("Acpi_leave_sleep_state");
 
 
+	/* Be sure to have BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
+
 	/* Ensure Enter_sleep_state_prep -> Enter_sleep_state ordering */
 
 	acpi_gbl_sleep_type_a = ACPI_SLEEP_TYPE_INVALID;
@@ -371,9 +425,6 @@
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
-
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	return_ACPI_STATUS (status);
 }
drivers/acpi/sleep.c
--- linux-2.5.52/drivers/acpi/sleep.c	2002/12/17 19:15:18	1.1
+++ linux-2.5.52/drivers/acpi/sleep.c	2002/12/17 19:47:28
@@ -149,8 +149,15 @@
 		if (state > ACPI_STATE_S1) {
 			error = acpi_save_state_mem();
 
+			/*
+			 * Do not kill this #if 0 please.
+			 * If one day we get S4, we should be happy to remember
+			 * where to save to disk.
+			 */
+#if 0
 			if (!error && (state == ACPI_STATE_S4))
 				error = acpi_save_state_disk();
+#endif
 
 			if (error) {
 				device_resume(RESUME_RESTORE_STATE);
@@ -227,6 +234,8 @@
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel(0);
 #endif
+	case ACPI_STATE_S4:
+		do_suspend_lowlevel_s4bios(0);
 		break;
 	}
 	local_irq_restore(flags);
@@ -250,10 +259,14 @@
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
+	/* Since we handle S4 via a different path (swsusp), give up if no s4bios. */
+	if (state == ACPI_STATE_S4 && !acpi_gbl_FACS->S4bios_f)
+		return AE_ERROR;
+
 	freeze_processes();		/* device_suspend needs processes to be stopped */
 
 	/* do we have a wakeup address for S2 and S3? */
-	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || state == ACPI_STATE_S4) {
 		if (!acpi_wakeup_address)
 			return AE_ERROR;
 		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
@@ -296,8 +309,11 @@
 	ACPI_FUNCTION_TRACE("acpi_system_sleep_seq_show");
 
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
-		if (sleep_states[i])
+		if (sleep_states[i]) {
 			seq_printf(seq,"S%d ", i);
+			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f)
+				seq_printf(seq, "S4b ");
+		}
 	}
 
 	seq_puts(seq, "\n");
@@ -336,12 +352,12 @@
 	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
+	if (state == 4 && state_string[1] != 'b') {
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	if (state == 4) {
 		software_suspend();
 		return_VALUE(count);
-	}
 #endif
+	}
 	status = acpi_suspend(state);
 
 	if (ACPI_FAILURE(status))
@@ -660,6 +676,10 @@
 		if (ACPI_SUCCESS(status)) {
 			sleep_states[i] = 1;
 			printk(" S%d", i);
+		}
+		if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f) {
+			sleep_states[i] = 1;
+			printk(" S4b");
 		}
 	}
 	printk(")\n");
drivers/acpi/acpi_ksyms.c
--- linux-2.5.52/drivers/acpi/acpi_ksyms.c	2002/12/17 19:15:19	1.1
+++ linux-2.5.52/drivers/acpi/acpi_ksyms.c	2002/12/17 19:17:11
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(acpi_get_register);
 EXPORT_SYMBOL(acpi_set_register);
 EXPORT_SYMBOL(acpi_enter_sleep_state);
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
 EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_get_devices);
 
include/linux/suspend.h
--- linux-2.5.52/include/linux/suspend.h	2002/12/17 19:15:19	1.1
+++ linux-2.5.52/include/linux/suspend.h	2002/12/17 19:17:11
@@ -71,6 +71,8 @@
 
 extern void do_suspend_lowlevel(int resume);
 
+extern void do_suspend_lowlevel_s4bios(int resume);
+
 #else
 static inline void software_suspend(void)
 {

--pvezYHf7grwyp3Bc--
