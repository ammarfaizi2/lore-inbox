Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTJ0CYB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTJ0CYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:24:01 -0500
Received: from mailhub.hp.com ([192.151.27.10]:1995 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S263734AbTJ0CX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:23:56 -0500
Subject: [BUG] test9 ACPI bad: scheduling while atomic!
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067221433.32755.136.camel@echo3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 26 Oct 2003 19:23:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   On an Omnibook 500 running test9, removing AC power causes an
immediate hang.  This laptop is getting a little old and I have to force
on ACPI support, but this did not happen with test8.  The bug and panic
are shown below.  It looks like the AML associated with the AC event is
trying to do an AML_SLEEP_OP.  Since this is called while in the
interrupt handler, and the eventual call to acpi_os_sleep() sets the
current state to interruptible... boom.  One simple, but terribly ugly,
workaround is to make acpi_os_sleep() call acpi_os_stall() if
in_atomic() is true (patch below).  Hopefully there's a better way to
fix this.  Somehow the interpreter really needs to drop interrupt
context before it starts making calls like this.  Thanks,

	Alex

bad: scheduling while atomic!
Call Trace:
 [<c011b9c5>] schedule+0x5a5/0x5b0
 [<c01cd1f6>] acpi_ut_acquire_from_cache+0x48/0xa2
 [<c0126d53>] __mod_timer+0x123/0x170
 [<c01278a3>] schedule_timeout+0x63/0xc0
 [<c0127830>] process_timeout+0x0/0x10
 [<c01c2b40>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c01c1b84>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c01bbd16>] acpi_ds_exec_end_op+0xa2/0x228
 [<c01c8b95>] acpi_ps_parse_loop+0x518/0x823
 [<c01ce042>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c01cd155>] acpi_ut_release_to_cache+0x31/0x8a
 [<c01ce0bf>] acpi_ut_release_mutex+0x67/0x6c
 [<c01ce1f1>] acpi_ut_delete_generic_state+0xb/0xe
 [<c01ceef3>] acpi_ut_update_object_reference+0x1d0/0x20e
 [<c01cef6e>] acpi_ut_remove_reference+0x21/0x27
 [<c01bc1fb>] acpi_ds_call_control_method+0x146/0x181
 [<c01c8eee>] acpi_ps_parse_aml+0x4e/0x17c
 [<c01c979d>] acpi_psx_execute+0x155/0x1a0
 [<c01c6b2d>] acpi_ns_execute_control_method+0x43/0x52
 [<c01c6ac6>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c01c69b9>] acpi_ns_evaluate_relative+0x9d/0xb4
 [<c01c531c>] acpi_hw_low_level_read+0x5e/0xa3
 [<c01c531c>] acpi_hw_low_level_read+0x5e/0xa3
 [<c01c62b8>] acpi_evaluate_object+0x10f/0x1be
 [<c01d21ce>] acpi_ec_gpe_query+0xdd/0xf4
 [<c01bf3aa>] acpi_ev_gpe_dispatch+0x33/0x105
 [<c01bf273>] acpi_ev_gpe_detect+0xc7/0x118
 [<c01bdea1>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c01b9fef>] acpi_irq+0xc/0x16
 [<c010b6b9>] handle_IRQ_event+0x49/0x80
 [<c01b9fe3>] acpi_irq+0x0/0x16
 [<c010ba5f>] do_IRQ+0x8f/0x130
 [<c0109d98>] common_interrupt+0x18/0x20
 [<c01230ce>] do_softirq+0x3e/0xa0
 [<c010bacb>] do_IRQ+0xfb/0x130
 [<c0109d98>] common_interrupt+0x18/0x20
 [<c01d441b>] acpi_processor_idle+0x126/0x1c5
 [<c0105000>] _stext+0x0/0x60
 [<c01070e4>] cpu_idle+0x34/0x40
 [<c035475d>] start_kernel+0x14d/0x160
 [<c03544b0>] unknown_bootoption+0x0/0x120

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011b519
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011b519>]    Not tainted
EFLAGS: 00010097
EIP is at schedule+0xf9/0x5b0
eax: 00000001   ebx: c02e4b00   ecx: c02e4b20   edx: c53d5f5a
esi: 00000000   edi: dfe06cc0   ebp: c0353c48   esp: c0353c04
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0352000 task=c02e4b00)
Stack: c02b75a0 0000003c c01cd1f6 00000009 00000000 0000000a 00000001 00000040 
       c0352000 00000246 c0126d53 17b03c66 dced9bc0 0000000b fffca45e c0353c5c 
       dfe06cc0 00000000 c01278a3 c0353c5c fffca45e 00000000 c039ec38 c039ec38 
Call Trace:
 [<c01cd1f6>] acpi_ut_acquire_from_cache+0x48/0xa2
 [<c0126d53>] __mod_timer+0x123/0x170
 [<c01278a3>] schedule_timeout+0x63/0xc0
 [<c0127830>] process_timeout+0x0/0x10
 [<c01c2b40>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c01c1b84>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c01bbd16>] acpi_ds_exec_end_op+0xa2/0x228
 [<c01c8b95>] acpi_ps_parse_loop+0x518/0x823
 [<c01ce042>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c01cd155>] acpi_ut_release_to_cache+0x31/0x8a
 [<c01ce0bf>] acpi_ut_release_mutex+0x67/0x6c
 [<c01ce1f1>] acpi_ut_delete_generic_state+0xb/0xe
 [<c01ceef3>] acpi_ut_update_object_reference+0x1d0/0x20e
 [<c01cef6e>] acpi_ut_remove_reference+0x21/0x27
 [<c01bc1fb>] acpi_ds_call_control_method+0x146/0x181
 [<c01c8eee>] acpi_ps_parse_aml+0x4e/0x17c
 [<c01c979d>] acpi_psx_execute+0x155/0x1a0
 [<c01c6b2d>] acpi_ns_execute_control_method+0x43/0x52
 [<c01c6ac6>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c01c69b9>] acpi_ns_evaluate_relative+0x9d/0xb4
 [<c01c531c>] acpi_hw_low_level_read+0x5e/0xa3
 [<c01c531c>] acpi_hw_low_level_read+0x5e/0xa3
 [<c01c62b8>] acpi_evaluate_object+0x10f/0x1be
 [<c01d21ce>] acpi_ec_gpe_query+0xdd/0xf4
 [<c01bf3aa>] acpi_ev_gpe_dispatch+0x33/0x105
 [<c01bf273>] acpi_ev_gpe_detect+0xc7/0x118
 [<c01bdea1>] acpi_ev_sci_xrupt_handler+0x11/0x18
 [<c01b9fef>] acpi_irq+0xc/0x16
 [<c010b6b9>] handle_IRQ_event+0x49/0x80
 [<c01b9fe3>] acpi_irq+0x0/0x16
 [<c010ba5f>] do_IRQ+0x8f/0x130
 [<c0109d98>] common_interrupt+0x18/0x20
 [<c01230ce>] do_softirq+0x3e/0xa0
 [<c010bacb>] do_IRQ+0xfb/0x130
 [<c0109d98>] common_interrupt+0x18/0x20
 [<c01d441b>] acpi_processor_idle+0x126/0x1c5
 [<c0105000>] _stext+0x0/0x60
 [<c01070e4>] cpu_idle+0x34/0x40
 [<c035475d>] start_kernel+0x14d/0x160
 [<c03544b0>] unknown_bootoption+0x0/0x120

Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

--- linux/drivers/acpi/osl.c~	2003-10-26 20:14:19.000000000 -0700
+++ linux/drivers/acpi/osl.c	2003-10-26 19:53:33.000000000 -0700
@@ -40,6 +40,7 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
+#include <asm/hardirq.h>
 
 #ifdef CONFIG_ACPI_EFI
 #include <linux/efi.h>
@@ -290,8 +291,12 @@
 void
 acpi_os_sleep(u32 sec, u32 ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ * sec + (ms * HZ) / 1000);
+	if (!in_atomic()) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ * sec + (ms * HZ) / 1000);
+	} else {
+		acpi_os_stall(sec * 1000000 + ms * 1000);
+	}
 }
 
 void


