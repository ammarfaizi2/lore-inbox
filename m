Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUILHSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUILHSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268506AbUILHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:18:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:58519 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268505AbUILHSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:18:30 -0400
Date: Sun, 12 Sep 2004 00:16:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: Possible dcache BUG
Message-Id: <20040912001626.759e2d17.akpm@osdl.org>
In-Reply-To: <20040912000354.7243a328@laptop.delusion.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040912000354.7243a328@laptop.delusion.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
>
>  However, then as slab usage went skyrocket after 3 days, I started logging
>  these:
> 
>   [<c013e98f>] __kmalloc+0x6f/0x80
>   [<c0217af9>] acpi_os_allocate+0xa/0xb
>   [<c022b9b6>] acpi_ut_callocate+0x30/0x7a
>   [<c022b840>] acpi_ut_acquire_from_cache+0x9d/0xaa
>   [<c022c7d8>] acpi_ut_create_generic_state+0xa/0x12
>   [<c021b0b2>] acpi_ds_result_stack_push+0x8/0x25
>   [<c021b268>] acpi_ds_create_walk_state+0x53/0x70
>   [<c0227913>] acpi_ps_delete_parse_tree+0x20/0x89
>   [<c0227238>] acpi_ps_parse_loop+0x550/0x7bb
>   [<c02274f0>] acpi_ps_parse_aml+0x4d/0x1a1
>   [<c0219dd4>] acpi_ds_call_control_method+0xd3/0x1b3
>   [<c0227505>] acpi_ps_parse_aml+0x62/0x1a1
>   [<c0227d1f>] acpi_psx_execute+0x13b/0x194
>   [<c0225212>] acpi_ns_execute_control_method+0x3b/0x47
>   [<c02251c0>] acpi_ns_evaluate_by_handle+0x6f/0x86
>   [<c02250cd>] acpi_ns_evaluate_relative+0xa9/0xc3
>   [<c02249c3>] acpi_evaluate_object+0xf3/0x1a0
>   [<c0160f56>] link_path_walk+0xbe6/0xe70
>   [<c022f496>] acpi_battery_get_status+0x68/0x102
>   [<c022f9b6>] acpi_battery_read_state+0x88/0x275
>   [<c018124b>] proc_file_read+0xbb/0x250
>   [<c0152ea1>] vfs_read+0xd1/0x130
>   [<c0153171>] sys_read+0x41/0x70
>   [<c01040db>] syscall_call+0x7/0xb

great, thanks for working that out.

Random guess: acpi_evaluate_object() is returning an error but is
allocating memory anyway.

In acpi_battery_get_status():

	status = acpi_evaluate_object(battery->handle, "_BST", NULL, &buffer);
	if (ACPI_FAILURE(status)) {
		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BST\n"));
		return_VALUE(-ENODEV);
	}

Is that failure path being taken?
