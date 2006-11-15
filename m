Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966547AbWKOGaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966547AbWKOGaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 01:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966548AbWKOGaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 01:30:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966547AbWKOGaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 01:30:18 -0500
Date: Tue, 14 Nov 2006 22:30:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: sleeping functions called in invalid context during resume
Message-ID: <20061114223002.10c231bd@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of sleeping while atomic warnings on 2.6.19-rc5
During resume I see the following:


platform floppy.0: EARLY resume
APIC error on CPU0: 00(00)
PM: Finishing wakeup.
BUG: sleeping function called from invalid context at drivers/base/power/resume.c:99
in_atomic():1, irqs_disabled():0

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff803734e5>] device_resume+0x19/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


acpi acpi: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a8b8>] acpi_thermal_resume+0x30/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff803374e4>] acpi_ex_system_do_suspend+0x11/0x17
 [<ffffffff8032edaa>] acpi_ds_exec_end_op+0xd9/0x407
 [<ffffffff8033dfdf>] acpi_ps_parse_loop+0x602/0x95b
 [<ffffffff8033d566>] acpi_ps_parse_aml+0x7b/0x24f
 [<ffffffff8033e7fb>] acpi_ps_execute_pass+0x85/0x9b
 [<ffffffff8033e928>] acpi_ps_execute_method+0xdd/0x172
 [<ffffffff8033b9bb>] acpi_ns_evaluate+0xa8/0x10a
 [<ffffffff8033b5b9>] acpi_evaluate_object+0x12d/0x1dc
 [<ffffffff8032d310>] acpi_evaluate_integer+0x92/0xcd
 [<ffffffff8034a340>] acpi_thermal_get_temperature+0x2e/0x3a
 [<ffffffff8034a56a>] acpi_thermal_check+0x61/0x37f
 [<ffffffff8034a910>] acpi_thermal_resume+0x88/0x99
 [<ffffffff8034bbfc>] acpi_device_resume+0x65/0xb9
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


agpgart-amd64 0000:00:00.0: resuming
pci 0000:00:00.1: resuming
pci 0000:00:00.2: resuming
pci 0000:00:00.3: resuming
pci 0000:00:00.4: resuming
pci 0000:00:00.7: resuming
pci 0000:00:01.0: resuming
PCI: Setting latency timer of device 0000:00:01.0 to 64
skge 0000:00:09.0: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff880217d9>] :skge:skge_resume+0x1c/0x9f
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


PM: Writing back config space on device 0000:00:09.0 at offset f (was 1f170100, writing 1f17010b)
PM: Writing back config space on device 0000:00:09.0 at offset 5 (was 1, writing b001)
PM: Writing back config space on device 0000:00:09.0 at offset 4 (was 0, writing ea020000)
PM: Writing back config space on device 0000:00:09.0 at offset 3 (was 0, writing 2008)
PM: Writing back config space on device 0000:00:09.0 at offset 1 (was 2b00000, writing 2b00007)
skge eth0: enabling interface
sata_via 0000:00:0f.0: resuming
VIA_IDE 0000:00:0f.1: resuming
uhci_hcd 0000:00:10.0: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff80315844>] pci_enable_device_bars+0x12/0x34
 [<ffffffff80315884>] pci_enable_device+0x1e/0x3e
 [<ffffffff803b1af7>] usb_hcd_pci_resume+0x43/0xe8
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff80315844>] pci_enable_device_bars+0x12/0x34
 [<ffffffff80315884>] pci_enable_device+0x1e/0x3e
 [<ffffffff803b1af7>] usb_hcd_pci_resume+0x43/0xe8
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff80315844>] pci_enable_device_bars+0x12/0x34
 [<ffffffff80315884>] pci_enable_device+0x1e/0x3e
 [<ffffffff803b1af7>] usb_hcd_pci_resume+0x43/0xe8
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff80315844>] pci_enable_device_bars+0x12/0x34
 [<ffffffff80315884>] pci_enable_device+0x1e/0x3e
 [<ffffffff803b1af7>] usb_hcd_pci_resume+0x43/0xe8
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff80315844>] pci_enable_device_bars+0x12/0x34
 [<ffffffff80315884>] pci_enable_device+0x1e/0x3e
 [<ffffffff803b1af7>] usb_hcd_pci_resume+0x43/0xe8
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 21
pci 0000:00:11.0: resuming
VIA 82xx Audio 0000:00:11.5: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803157e5>] pci_set_power_state+0x188/0x1d5
 [<ffffffff880de445>] :snd_via82xx:snd_via82xx_resume+0x22/0x14c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
pci 0000:00:18.0: resuming
pci 0000:00:18.1: resuming
pci 0000:00:18.2: resuming
pci 0000:00:18.3: resuming
pci 0000:01:00.0: resuming
system 00:00: resuming
pnp 00:01: resuming
system 00:02: resuming
system 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
pnp 00:07: resuming
pnp 00:08: resuming
serial 00:09: resuming
pnp: Device 00:09 activated.
pcspkr pcspkr: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
ide-cdrom 0.0: resuming
sd 0:0:0:0: resuming
i8042 i8042: resuming
serio serio0: resuming
serio serio1: resuming
usb usb1: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff8800225d>] :uhci_hcd:wakeup_rh+0x49/0xc8
 [<ffffffff88004636>] :uhci_hcd:uhci_rh_resume+0x6b/0x7d
 [<ffffffff803a883b>] hcd_bus_resume+0x3a/0x5a
 [<ffffffff803a6993>] hub_resume+0x2f/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803a69a1>] hub_resume+0x3d/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


hub 1-0:1.0: resuming
usb usb2: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff8800225d>] :uhci_hcd:wakeup_rh+0x49/0xc8
 [<ffffffff88004636>] :uhci_hcd:uhci_rh_resume+0x6b/0x7d
 [<ffffffff803a883b>] hcd_bus_resume+0x3a/0x5a
 [<ffffffff803a6993>] hub_resume+0x2f/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803a69a1>] hub_resume+0x3d/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


hub 2-0:1.0: resuming
usb usb3: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff8800225d>] :uhci_hcd:wakeup_rh+0x49/0xc8
 [<ffffffff88004636>] :uhci_hcd:uhci_rh_resume+0x6b/0x7d
 [<ffffffff803a883b>] hcd_bus_resume+0x3a/0x5a
 [<ffffffff803a6993>] hub_resume+0x2f/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803a69a1>] hub_resume+0x3d/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


hub 3-0:1.0: resuming
usb usb4: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff8800225d>] :uhci_hcd:wakeup_rh+0x49/0xc8
 [<ffffffff88004636>] :uhci_hcd:uhci_rh_resume+0x6b/0x7d
 [<ffffffff803a883b>] hcd_bus_resume+0x3a/0x5a
 [<ffffffff803a6993>] hub_resume+0x2f/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803a69a1>] hub_resume+0x3d/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


hub 4-0:1.0: resuming
usb usb5: resuming
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff8025dc36>] schedule_timeout+0x99/0xbc
 [<ffffffff80281380>] msleep+0x28/0x32
 [<ffffffff803a69a1>] hub_resume+0x3d/0x49
 [<ffffffff803aba5c>] resume_interface+0x53/0xc3
 [<ffffffff803abb8c>] usb_resume_both+0xc0/0xd7
 [<ffffffff803abbde>] usb_resume+0x3b/0x4c
 [<ffffffff8037335e>] resume_device+0xc5/0x125
 [<ffffffff80373473>] dpm_resume+0x85/0xde
 [<ffffffff8037350b>] device_resume+0x3f/0x51
 [<ffffffff80292157>] enter_state+0x19b/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


hub 5-0:1.0: resuming
usb 2-1: resuming
hub 2-1:1.0: resuming
usb 2-1.1: resuming
usbhid 2-1.1:1.0: resuming
usb 2-1.2: resuming
usbhid 2-1.2:1.0: resuming
ac97 0-0:ALC655: resuming
platform floppy.0: resuming
Restarting tasks...<3>BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff802922f8>] thaw_processes+0xb2/0xe2
 [<ffffffff8029215c>] enter_state+0x1a0/0x1b5
 [<ffffffff802921cf>] state_store+0x5e/0x79
 [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
 [<ffffffff80215059>] vfs_write+0xce/0x174
 [<ffffffff802159a5>] sys_write+0x45/0x6e
 [<ffffffff802593de>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


 done
BUG: scheduling while atomic: s2ram/0x00000001/2667

Call Trace:
 [<ffffffff80266117>] show_trace+0x34/0x47
 [<ffffffff8026613c>] dump_stack+0x12/0x17
 [<ffffffff8025ccbb>] __sched_text_start+0x5b/0x54f
 [<ffffffff80259448>] sysret_careful+0xd/0x10
DWARF2 unwinder stuck at sysret_careful+0xd/0x10

Leftover inexact backtrace:


s2ram[2667]: segfault at 00000034584720f0 rip 00000034584720f0 rsp 00007ffff251dc08 error 14
note: s2ram[2667] exited with preempt_count 1
skge eth0: Link is up at 1000 Mbps, full duplex, flow control both


The kernel config is:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.19-rc5
# Tue Nov 14 21:21:30 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_TASK_XACCT is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTERNODE_CACHE_BYTES=128
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_IOMMU=y
CONFIG_CALGARY_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x200000
CONFIG_SECCOMP=y
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_REORDER=y
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PM_DEBUG=y
CONFIG_DISABLE_CONSOLE_SUSPEND=y
# CONFIG_PM_SYSFS_DEPRECATED is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_IBM_DOCK is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_ASK_IP_FIB_HASH is not set
CONFIG_IP_FIB_TRIE=y
# CONFIG_IP_FIB_HASH is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=y
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CONNTRACK_EVENTS=y
CONFIG_IP_NF_CONNTRACK_NETLINK=m
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_NETBIOS_NS=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_PPTP=m
# CONFIG_IP_NF_H323 is not set
# CONFIG_IP_NF_SIP is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_PPTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_TCPPROBE=m
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set
CONFIG_FIB_RULES=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_MSI_LAPTOP is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=y
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
# CONFIG_SATA_SVW is not set
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=y
# CONFIG_SATA_VITESSE is not set
CONFIG_SATA_INTEL_COMBINED=y
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
CONFIG_PATA_VIA=y
# CONFIG_PATA_WINBOND is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_RHINE_NAPI=y

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
# CONFIG_R8169_NAPI is not set
# CONFIG_R8169_VLAN is not set
# CONFIG_SIS190 is not set
CONFIG_SKGE=m
CONFIG_SKY2=m
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
CONFIG_NETPOLL_RX=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_SIS is not set
CONFIG_AGP_VIA=y
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AC97_POWER_SAVE is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_SL811_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_AIRPRIME=m
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_FUNSOFT=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_E752X is not set
CONFIG_EDAC_POLL=y

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_UNWIND_INFO=y
CONFIG_STACK_UNWIND=y
# CONFIG_FORCED_INLINING is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_DEBUG_RODATA is not set
CONFIG_IOMMU_DEBUG=y
CONFIG_IOMMU_LEAK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y

