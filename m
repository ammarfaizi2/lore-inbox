Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267657AbSLFW5d>; Fri, 6 Dec 2002 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbSLFW5d>; Fri, 6 Dec 2002 17:57:33 -0500
Received: from poup.poupinou.org ([195.101.94.96]:22283 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267657AbSLFW51>; Fri, 6 Dec 2002 17:57:27 -0500
Date: Sat, 7 Dec 2002 00:05:02 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       ducrot@poupinou.org
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021206230502.GA19083@poup.poupinou.org>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <20021206185702.GE17595@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20021206185702.GE17595@poup.poupinou.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Pavel.

On Fri, Dec 06, 2002 at 07:57:02PM +0100, Ducrot Bruno wrote:
> On Fri, Dec 06, 2002 at 01:06:18AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Doesn't that imply your fix is broken to begin with?
> > > > 
> > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > 
> > > You broke the design. S3 support was developed long before swsusp was in 
> > > the kernel, and completely indpendent of it. It should have remained that 
> > > way. 
> > > 
> > > S3 support is a subset of what is need for S4 support. 
> > 
> > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > but not for S4. Big part of driver support is only needed for S3.
> > 
> > > swsusp is an implementation of S4 support. In theory, there could be 
> > > multiple implementations that all use the same core (saving/restoring 
> > > state). 
> > 
> > There were patches for S4bios floating around, but it never really
> > worked, IIRC.
> 
> No.  It work.  I do not resubmmited patches because I think that
> swsusp is better.
> 

I attach also this patch, it is ughly, though, but if you are sure
that your laptop can support S4BIOS (I do not include basic checks for
that), it should survive (I need myself to reset at wakeup the keyboard controller,
though).

It is again acpi on sf.net of today, and some of your patches for S3 support.

echo 4b > /proc/acpi/sleep if you want to say goodbye to your data :)

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s4bios-2.5.50.diff"

--- linux-2.5.50/arch/i386/kernel/acpi_wakeup.S	2002/12/06 21:34:17	1.1
+++ linux-2.5.50/arch/i386/kernel/acpi_wakeup.S	2002/12/06 21:48:14
@@ -336,6 +336,48 @@
 	pushl saved_context_eflags ; popfl
 	ret
 
+ENTRY(do_suspend_lowlevel_s4bios)
+	cmpl $0,4(%esp)
+	jne .L1432
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
+	movl $.L1432,saved_eip
+	movl %esp,saved_esp
+	movl %ebp,saved_ebp
+	movl %ebx,saved_ebx
+	movl %edi,saved_edi
+	movl %esi,saved_esi
+
+	pushl $3
+	call acpi_enter_sleep_state_s4bios
+	addl $4,%esp
+	ret
+	.p2align 4,,7
+.L1433:
+	movl $__KERNEL_DS,%eax
+	movw %ax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+	call restore_processor_state
+	pushl saved_context_eflags ; popfl
+	ret
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
--- linux-2.5.50/drivers/acpi/include/acpixf.h	2002/12/06 21:56:49	1.1
+++ linux-2.5.50/drivers/acpi/include/acpixf.h	2002/12/06 22:02:42
@@ -380,6 +380,10 @@
 	u8                      sleep_state);
 
 acpi_status
+acpi_enter_sleep_state_s4bios (
+	void);
+
+acpi_status
 acpi_leave_sleep_state (
 	u8                      sleep_state);
 
--- linux-2.5.50/drivers/acpi/hardware/hwsleep.c	2002/12/06 21:39:07	1.1
+++ linux-2.5.50/drivers/acpi/hardware/hwsleep.c	2002/12/06 22:08:22
@@ -319,6 +319,51 @@
 
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
+	do {
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	} while (!in_value);
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
--- linux-2.5.50/drivers/acpi/sleep.c	2002/12/06 21:21:25	1.1
+++ linux-2.5.50/drivers/acpi/sleep.c	2002/12/06 22:29:28
@@ -149,8 +149,10 @@
 		if (state > ACPI_STATE_S1) {
 			error = acpi_save_state_mem();
 
+#if 0
 			if (!error && (state == ACPI_STATE_S4))
 				error = acpi_save_state_disk();
+#endif
 
 			if (error) {
 				device_resume(RESUME_RESTORE_STATE);
@@ -227,6 +229,8 @@
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel(0);
 #endif
+	case ACPI_STATE_S4:
+		do_suspend_lowlevel_s4bios(0);
 		break;
 	}
 	local_irq_restore(flags);
@@ -253,7 +257,7 @@
 	freeze_processes();		/* device_suspend needs processes to be stopped */
 
 	/* do we have a wakeup address for S2 and S3? */
-	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3 || state == ACPI_STATE_S4) {
 		if (!acpi_wakeup_address)
 			return AE_ERROR;
 		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
@@ -336,12 +340,14 @@
 	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
+	if (state == 4 && state_string[1] != 'b') {
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	if (state == 4) {
+	/* if (state == 4) { */
 		software_suspend();
 		return_VALUE(count);
-	}
+	/* } */
 #endif
+	}
 	status = acpi_suspend(state);
 
 	if (ACPI_FAILURE(status))
--- linux-2.5.50/drivers/acpi/acpi_ksyms.c	2002/12/06 21:58:48	1.1
+++ linux-2.5.50/drivers/acpi/acpi_ksyms.c	2002/12/06 21:59:12
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(acpi_get_register);
 EXPORT_SYMBOL(acpi_set_register);
 EXPORT_SYMBOL(acpi_enter_sleep_state);
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
 EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_get_devices);
 
--- linux-2.5.50/include/linux/suspend.h	2002/12/06 21:53:17	1.1
+++ linux-2.5.50/include/linux/suspend.h	2002/12/06 21:54:27
@@ -71,6 +71,8 @@
 
 extern void do_suspend_lowlevel(int resume);
 
+extern void do_suspend_lowlevel_s4bios(int resume);
+
 #else
 static inline void software_suspend(void)
 {

--RnlQjJ0d97Da+TV1--
