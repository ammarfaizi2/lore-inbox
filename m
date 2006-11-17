Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755815AbWKQTWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbWKQTWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKQTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:22:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:1958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752807AbWKQTWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:22:17 -0500
Date: Fri, 17 Nov 2006 11:18:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>,
       Andreas Friedrich <andreas.friedrich@fujitsu-siemens.com>,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: [patch] i386/x86_64: ACPI cpu_idle_wait() fix
Message-Id: <20061117111844.a6dfd039.akpm@osdl.org>
In-Reply-To: <20061117133128.GA15404@elte.hu>
References: <20061116122820.GA2718@upset.pdb.fsc.net>
	<20061116123335.GA1392@elte.hu>
	<20061116124132.GA9048@upset.pdb.fsc.net>
	<20061116131842.GA12961@elte.hu>
	<20061116133019.GA14546@upset.pdb.fsc.net>
	<20061116144356.GA4891@elte.hu>
	<20061117090356.GA26013@upset.pdb.fsc.net>
	<20061117112237.GA26270@elte.hu>
	<20061117124913.GA24893@upset.pdb.fsc.net>
	<20061117132618.GA14411@elte.hu>
	<20061117133128.GA15404@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 14:31:28 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > The scheduler on Andreas Friedrich's hyperthreading system stopped 
> > working properly as of 2.6.18: the scheduler would never move tasks to 
> > another CPU!
> 
> correction: the last known working kernel was 2.6.8. The bug predates 
> our GIT history so it's older than 1.5 years.
> 

How come nobody noticed?  Maybe it improved things ;)

I spose it's 2.6.19 material, although it's a bit of a leap into the
unknown.

How many systems will this affect?


CPU#1: set_cpus_allowed(), swapper:1, 3 -> 2
 [<c0103bbe>] show_trace_log_lvl+0x34/0x4a
 [<c0103ceb>] show_trace+0x2c/0x2e
 [<c01045f8>] dump_stack+0x2b/0x2d
 [<c0116a77>] set_cpus_allowed+0x52/0xec
 [<c0101d86>] cpu_idle_wait+0x2e/0x100
 [<c0259c57>] acpi_processor_power_exit+0x45/0x58
 [<c0259752>] acpi_processor_remove+0x46/0xea
 [<c025c6fb>] acpi_start_single_object+0x47/0x54
 [<c025cee5>] acpi_bus_register_driver+0xa4/0xd3
 [<c04ab2d7>] acpi_processor_init+0x57/0x77
 [<c01004d7>] init+0x146/0x2fd
 [<c0103a87>] kernel_thread_helper+0x7/0x10

It seems strange that the kernel is calling acpi_processor_power_exit() at
this stage.  It'll have happened because acpi_start_single_object()'s call
to acpi_processor_start() returned non-zero.  Why did that happen?

> static int __cpuinit acpi_processor_start(struct acpi_device *device)
> {
> 	int result = 0;
> 	acpi_status status = AE_OK;
> 	struct acpi_processor *pr;
> 
> 
> 	pr = acpi_driver_data(device);
> 
> 	result = acpi_processor_get_info(pr);
> 	if (result) {
> 		/* Processor is physically not present */
> 		return 0;

Surely that should be either AE_OK (but why?) or -ESOMETHING.

> 	}
> 
> 	BUG_ON((pr->id >= NR_CPUS) || (pr->id < 0));
> 
> 	/*
> 	 * Buggy BIOS check
> 	 * ACPI id of processors can be reported wrongly by the BIOS.
> 	 * Don't trust it blindly
> 	 */
> 	if (processor_device_array[pr->id] != NULL &&
> 	    processor_device_array[pr->id] != device) {
> 		printk(KERN_WARNING "BIOS reported wrong ACPI id"
> 			"for the processor\n");
> 		return -ENODEV;

Andreas wasn't seeing that, right?

> 	}
> 	processor_device_array[pr->id] = device;
> 
> 	processors[pr->id] = pr;
> 
> 	result = acpi_processor_add_fs(device);
> 	if (result)
> 		goto end;

I'd assume that this is failing.  I wonder why?

> 	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
> 					     acpi_processor_notify, pr);

whoops, this return value gets lost.

> 	/* _PDC call should be done before doing anything else (if reqd.). */
> 	arch_acpi_processor_init_pdc(pr);
> 	acpi_processor_set_pdc(pr);
> 
> 	acpi_processor_power_init(pr, device);
> 
> 	if (pr->flags.throttling) {
> 		printk(KERN_INFO PREFIX "%s [%s] (supports",
> 		       acpi_device_name(device), acpi_device_bid(device));
> 		printk(" %d throttling states", pr->throttling.state_count);
> 		printk(")\n");
> 	}
> 
>       end:
> 
> 	return result;
> }
> 
> 
> 
> 
