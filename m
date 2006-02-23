Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWBWC0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBWC0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWBWC0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:26:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbWBWC0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:26:36 -0500
Date: Wed, 22 Feb 2006 18:26:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
Message-Id: <20060222182601.1d628a01.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602221041490.5164-100000@iolanthe.rowland.org>
References: <20060221152811.1b065752.akpm@osdl.org>
	<Pine.LNX.4.44L0.0602221041490.5164-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 21 Feb 2006, Andrew Morton wrote:
> 
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Some atomic notifier chains require registrations to take place in atomic
> > >  context.  An example is the die_notifier, which on some architectures may
> > >  be accessed very early during the boot-up procedure, before task-switching
> > >  is legal.  To accomodate these chains, this patch (as655) replaces the
> > >  mutex in the atomic_notifier_head structure with a spinlock.
> > 
> > I think that's a good change, however x86_64 still crashes.
> > 
> > At great personal expense (ie: using winxp hyperterminal (I now understand
> > why some of the traces we get are so crappy)) I have a trace.  It's still
> > bugging out in the BUG_ON(!irqs_disabled());
> 
> I hate to keep asking you to test this since you're so busy.  If you know
> anyone else with an x86_64 who could investigate instead, don't hesitate
> to pass this on.

dood, I spend probably half my time weeding out bugs people sent me and
another 25% finding bugs we already merged...

> The diagnostic patch below is a heavy-handed approach, but it ought to
> indicate the source of the problem.  Doing anything to a blocking notifier
> chain at a time when task switching is not legal should be a no-no.  
> Maybe this means that a chain got misclassified as blocking when it
> really should be atomic -- or maybe it means there has always been a more
> serious problem that has never been detected before.

heh, it fixed the bug.

> Index: usb-2.6/kernel/sys.c
> ===================================================================
> --- usb-2.6.orig/kernel/sys.c
> +++ usb-2.6/kernel/sys.c
> @@ -249,7 +249,11 @@ int blocking_notifier_chain_register(str
>  {
>  	int ret;
>  
> -	down_write(&nh->rwsem);
> +	if (!down_write_trylock(&nh->rwsem)) {
> +		printk(KERN_WARNING "%s\n", __FUNCTION__);
> +		dump_stack();
> +		down_write(&nh->rwsem);
> +	}

See, we avoid doing down_write() if the lock is uncontended.  And x86_64's
uncontended down_write() unconditionally enables interrupts.  This evaded
notice because might_sleep() warnings are disabled early in boot due to
various horrid things.

Maybe we should enable the might_sleep() warnings because of this nasty
rwsem trap.  We tried to do that a couple of weeks ago but we needed a pile
of nasty workarounds to avoid false positives.


Applying this:

--- 25/kernel/sys.c~notifier-sleep-debug-update	2006-02-22 18:23:26.000000000 -0800
+++ 25-akpm/kernel/sys.c	2006-02-22 18:25:45.000000000 -0800
@@ -249,6 +249,8 @@ int blocking_notifier_chain_register(str
 {
 	int ret;
 
+	if (irqs_disabled())
+		dump_stack();
 	if (!down_write_trylock(&nh->rwsem)) {
 		printk(KERN_WARNING "%s\n", __FUNCTION__);
 		dump_stack();
@@ -276,6 +278,8 @@ int blocking_notifier_chain_unregister(s
 {
 	int ret;
 
+	if (irqs_disabled())
+		dump_stack();
 	if (!down_write_trylock(&nh->rwsem)) {
 		printk(KERN_WARNING "%s\n", __FUNCTION__);
 		dump_stack();
@@ -310,6 +314,8 @@ int blocking_notifier_call_chain(struct 
 {
 	int ret;
 
+	if (irqs_disabled())
+		dump_stack();
 	if (!down_read_trylock(&nh->rwsem)) {
 		printk(KERN_WARNING "%s\n", __FUNCTION__);
 		dump_stack();
_

Gives:

Bootdata ok (command line is root=/dev/sda3 profile=1 ro rhgb earlyprintk=serial,ttyS0,9600 console=ttyS0)
Linux version 2.6.16-rc4-mm1 (akpm@x) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #151 SMP PREEMPT Wed Feb 22 18:25:50 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
kernel direct mapping tables up to 180000000 @ 8000-8000
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=/dev/sda3 profile=1 ro rhgb earlyprintk=serial,ttyS0,9600 console=ttyS0
kernel profiling enabled (shift: 1)
Initializing CPU#0

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639482>{rcu_init+40}
       <ffffffff806296f8>{start_kernel+217} <ffffffff80629286>{_sinittext+646}
PID hash table entries: 4096 (order: 12, 131072 bytes)

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639259>{init_timers+40}
       <ffffffff80629707>{start_kernel+232} <ffffffff80629286>{_sinittext+646}

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639821>{hrtimers_init+40}
       <ffffffff8062970c>{start_kernel+237} <ffffffff80629286>{_sinittext+646}
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3400.166 MHz processor.
disabling early console
Bootdata ok (command line is root=/dev/sda3 profile=1 ro rhgb earlyprintk=serial,ttyS0,9600 console=ttyS0)
Linux version 2.6.16-rc4-mm1 (akpm@x) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #151 SMP PREEMPT Wed Feb 22 18:25:50 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=/dev/sda3 profile=1 ro rhgb earlyprintk=serial,ttyS0,9600 console=ttyS0
kernel profiling enabled (shift: 1)
Initializing CPU#0

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639482>{rcu_init+40}
       <ffffffff806296f8>{start_kernel+217} <ffffffff80629286>{_sinittext+646}
PID hash table entries: 4096 (order: 12, 131072 bytes)

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639259>{init_timers+40}
       <ffffffff80629707>{start_kernel+232} <ffffffff80629286>{_sinittext+646}

Call Trace: <ffffffff80137eda>{blocking_notifier_chain_register+30}
       <ffffffff80143b9b>{register_cpu_notifier+19} <ffffffff80639821>{hrtimers_init+40}
       <ffffffff8062970c>{start_kernel+237} <ffffffff80629286>{_sinittext+646}
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3400.166 MHz processor.
disabling early console
Console: colour VGA+ 80x25

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8063b983>{vfs_caches_init_early+0} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8063a155>{__alloc_bootmem_core+773} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063aeae>{alloc_large_system_hash+220}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}

Call Trace: <IRQ> <ffffffff80137fd8>{blocking_notifier_call_chain+35}
       <ffffffff80107caf>{__exit_idle+46} <ffffffff80107cd3>{exit_idle+34}
       <ffffffff8010c055>{do_IRQ+20} <ffffffff80109e36>{ret_from_intr+0} <EOI>
       <ffffffff8012b3f0>{release_console_sem+320} <ffffffff8012b793>{vprintk+811}
       <ffffffff8012b7bc>{vprintk+852} <ffffffff8012b7bc>{vprintk+852}
       <ffffffff8012b88b>{printk+162} <ffffffff8012b0fa>{__call_console_drivers+75}
       <ffffffff8063a466>{__alloc_bootmem+56} <ffffffff8063af69>{alloc_large_system_hash+407}
       <ffffffff8063b9c1>{vfs_caches_init_early+62} <ffffffff80629740>{start_kernel+289}
       <ffffffff80629286>{_sinittext+646}


We're using blocking notifier chains in places where it's really risky, such as
__exit_idle().  Time for a rethink, methinks.

I'd suggest that in further development, you enable might_sleep() in early
boot - that would have caught such things..
