Return-Path: <linux-kernel-owner+w=401wt.eu-S1161147AbXAMAsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbXAMAsE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbXAMAsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:48:04 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55616 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161147AbXAMAsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:48:01 -0500
Message-ID: <45A82BED.4000608@us.ibm.com>
Date: Fri, 12 Jan 2007 16:46:37 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] NMI watchdog lockups caused by mwait_idle
References: <EB12A50964762B4D8111D55B764A8454011D61F7@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454011D61F7@scsmsx413.amr.corp.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
> Darrick,
> 
> I tried 2.6.20-rc4 on a Dempsey system here in my lab and it worked
> fine. No watchdog lockups.
> Can you try idle routine with hlt instead of mwait. There is no boot
> option for this in x86_64, but you can change
> arch/x86_64/kernel/process.c:select_idle_routine() not to enable mwait.
> With that default kernel should use hlt based idle.
> 
> Also, worth seeing will be, what happens when nmi_watchdog=0,
> nmi_watchdog=1, and nmi_watchdog=2 boot options. That should tell us
> whether nmi_watchdog is raising some false alarm or the CPUs are indeed
> getting locked up here..
> 

Locks up with hlt-based idle too. :(

Here's what I get with nmi_watchdog=0:

[  206.088703] BUG: soft lockup detected on CPU#0!
[  206.093284] 
[  206.093286] Call Trace:
[  206.097324]  <IRQ>  [<ffffffff801b1f89>] softlockup_tick+0xd4/0xe9
[  206.103618]  [<ffffffff80173c55>] do_flush_tlb_all+0x0/0x68
[  206.109238]  [<ffffffff8014d8f8>] run_local_timers+0x13/0x15
[  206.114949]  [<ffffffff80192844>] update_process_times+0x4c/0x78
[  206.121008]  [<ffffffff80174fcd>] smp_local_timer_interrupt+0x34/0x51
[  206.127498]  [<ffffffff801756b1>] smp_apic_timer_interrupt+0x49/0x60
[  206.133901]  [<ffffffff8015cd16>] apic_timer_interrupt+0x66/0x70
[  206.139956]  <EOI>  [<ffffffff80173baa>] __smp_call_function+0x66/0x87
[  206.146594]  [<ffffffff80173ba6>] __smp_call_function+0x62/0x87
[  206.152564]  [<ffffffff80173c55>] do_flush_tlb_all+0x0/0x68
[  206.158188]  [<ffffffff80173c55>] do_flush_tlb_all+0x0/0x68
[  206.163813]  [<ffffffff80173cef>] smp_call_function+0x32/0x49
[  206.169611]  [<ffffffff80173c55>] do_flush_tlb_all+0x0/0x68
[  206.175236]  [<ffffffff8018e117>] on_each_cpu+0x30/0x67
[  206.180514]  [<ffffffff80173d46>] flush_tlb_all+0x1c/0x1e
[  206.185965]  [<ffffffff80150f2a>] unmap_vm_area+0x1c3/0x265
[  206.191590]  [<ffffffff80101c20>] init_level4_pgt+0xc20/0x1000
[  206.197474]  [<ffffffff801bfc47>] remove_vm_area+0x41/0x67
[  206.203010]  [<ffffffff8017c33c>] iounmap+0x8e/0xc8
[  206.207933]  [<ffffffff80230032>] acpi_os_unmap_memory+0x9/0xb
[  206.213810]  [<ffffffff8023aaff>] acpi_ev_system_memory_region_setup+0x52/0x105
[  206.221174]  [<ffffffff80259465>] acpi_ut_delete_internal_obj+0x2c4/0x3b2
[  206.228012]  [<ffffffff802596d3>] acpi_ut_update_ref_count+0x180/0x1d2
[  206.234587]  [<ffffffff80259885>] acpi_ut_update_object_reference+0x160/0x207
[  206.241770]  [<ffffffff802599e1>] acpi_ut_remove_reference+0xb5/0xd5
[  206.248173]  [<ffffffff8024da8a>] acpi_ns_detach_object+0xca/0xee
[  206.254318]  [<ffffffff8024b08a>] acpi_ns_delete_namespace_by_owner+0xcf/0x154
[  206.261597]  [<ffffffff80234481>] acpi_ds_terminate_control_method+0xb5/0x14f
[  206.268779]  [<ffffffff8024ef7c>] acpi_ps_parse_aml+0x242/0x3a0
[  206.274750]  [<ffffffff80250a00>] acpi_ps_execute_pass+0xd5/0x10b
[  206.280895]  [<ffffffff80250c3c>] acpi_ps_execute_method+0x1bf/0x2cb
[  206.287298]  [<ffffffff8024b4da>] acpi_ns_evaluate+0x1f8/0x315
[  206.293180]  [<ffffffff8024abf1>] acpi_evaluate_object+0x1d9/0x2fa
[  206.299411]  [<ffffffff8010ab03>] kmem_cache_alloc+0xce/0xda
[  206.305125]  [<ffffffff880146a9>] :processor:acpi_processor_start+0x656/0x6fd
[  206.312307]  [<ffffffff801cc2a0>] kmem_cache_zalloc+0xce/0xf4
[  206.318103]  [<ffffffff80261097>] acpi_start_single_object+0x2a/0x54
[  206.324509]  [<ffffffff8026192d>] acpi_bus_register_driver+0xcd/0x14c
[  206.331001]  [<ffffffff88022061>] :processor:acpi_processor_init+0x61/0xb7
[  206.337923]  [<ffffffff801a4d6e>] sys_init_module+0xac/0x16c
[  206.343630]  [<ffffffff8015c11e>] system_call+0x7e/0x83

nmi_watchdog={1,2} produce the same errors.

--D
