Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVJUOpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVJUOpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVJUOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:45:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29612 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964963AbVJUOpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:45:38 -0400
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<20051021133306.GC3799@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 21 Oct 2005 08:45:12 -0600
In-Reply-To: <20051021133306.GC3799@in.ibm.com> (Vivek Goyal's message of
 "Fri, 21 Oct 2005 19:03:06 +0530")
Message-ID: <m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Eric,
>
> I had a couple of observations.
>
> [..]
>>  #ifdef CONFIG_X86_IO_APIC
>>  	{
>> @@ -1046,9 +1050,11 @@ static unsigned int calibration_result;
>>  
>>  void __init setup_boot_APIC_clock(void)
>>  {
>> +	unsigned long flags;
>>  	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
>>  	using_apic_timer = 1;
>>  
>> +	local_irq_save(flags);
>>  	local_irq_disable();
>>  
>
> Should the local_irq_disable() call go away onece local_irq_save() got
> introduced.

Nope.  The irqs need to be disabled.  The save just allows this
to be called in a context where irqs start out disabled.  It is
just a save.

>> +	/*
>> +	 * Should not be necessary because the MP table should list the boot
>> +	 * CPU too, but we do it for the sake of robustness anyway.
>> +	 * Makes no sense to do this check in clustered apic mode, so skip it
>> +	 */
>> +	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
>> +		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
>> +				boot_cpu_physical_apicid);
>
>
> I am testing kdump on i386 and I am hitting this message while second kernel
> is booting. I am doing testing with 2.6.14-rc4-mm1. Logs are pasted below.

The check has been there for a while.  All it is saying is that
our boot cpu has apicid #1.   So I suspect you are either on
an Opteron system or a hyperthreaded Xeon system.

> Also kdump testing fails almost 50% of the time on my machine with
> 2.6.14-rc4-mm1.  It works fine with 2.6.14-rc4 though.

Is the failure that happens 50% represented by the bootlog below?

The problem bootlog appears to be a glitch in the handling
of apicids on the boot cpu that the BIOS does not report to the
kernel.

> Second kernel is unable to come up. earlyprintk on serial console showed
> a kernel BUG in setup_local_APIC(). Details are included in the logs below.

> Second kernel boot log.

The BUG is weird.  I don't think apic.c even goes to line 1479.
Unless the BUG is inline in one of the other functions called
by setup_local_APIC() .

	/*
	 * Double-check whether this APIC is really registered.
	 */
	if (!apic_id_registered())
		BUG();


apic_id_registered expands to:
static inline int apic_id_registered(void)
{
	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
}

Which indicates to me that the code that, there is something
wrong in the logic of:
	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
				boot_cpu_physical_apicid);
		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
	}

Currently we are refering to the boot cpus apicid with 3 different expressions
one of them appears to be wrong.

That is as far as I can get at the moment.

Eric


>
> # SysRq : Trigger a crashdump
> I'm in purgatory
> Linux version 2.6.14-rc4-mm1-16M (root@llm01.in.ibm.com) (gcc version 3.4.3
> 20041212 (Red Hat 3.4.3-9.EL4)) #1 PREEMPT Wed Oct 19 13:55:24 IST 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000100 - 000000000009d000 (usable)
>  BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000002fffa480 (usable)
>  BIOS-e820: 000000002fffa480 - 0000000030000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> user-defined physical RAM map:
>  user: 0000000000000000 - 00000000000a0000 (usable)
>  user: 0000000001000000 - 000000000142d000 (usable)
>  user: 00000000014cd400 - 0000000004000000 (usable)
> 0MB HIGHMEM available.
> 64MB LOWMEM available.
> found SMP MP-table at 0009e140
> early console enabled
> DMI 2.1 present.
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
> Processor #3 6:10 APIC version 17
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
> Processor #2 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
> ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
> IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Enabling APIC mode:  Flat.  Using 2 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 10000000 (gap: 04000000:fc000000)
> Built 1 zonelists
> Initializing CPU#0
> Kernel command line: ro root=/dev/sda7 rhgb console=ttyS0,38400 irqpoll init 3
> earlyprintk=ttyS0,38400 memmap=exactmap memmap=640K@0K memmap=4276K@16384K
> memmap=44235K@21301K elfcorehdr=21300K
> Misrouted IRQ fixup and polling support enabled
> This may significantly impact system performance
> weird, boot CPU (#1) not listed by the BIOS.
> ------------[ cut here ]------------
> kernel BUG at ÿÿÿÿ:1479!
> invalid operand: 0000 [#1]
> PREEMPT
> last sysfs file:
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c1012b17>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.14-rc4-mm1-16M)
> EIP is at setup_local_APIC+0x26/0x18c
> eax: 00000000   ebx: 00040011   ecx: 00000c06   edx: 00000000
> esi: 00000011   edi: c13a9800   ebp: 01445007   esp: c13b5fbc
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c13b4000 task=c133faa0)
> Stack: c13a9800 01445007 c101ac30 00000000 01429900 c13c1c49 c12e8a4c 00000001
>        00000003 c13b66cf c12e5d5d c13eddc0 c133b9fc 00000078 c13b6342 c13eddc0
>        c1000199
> Call Trace:
>  [<c101ac30>] printk+0x17/0x1b
>  [<c13c1c49>] APIC_init+0x5a/0xf6
>  [<c13b66cf>] start_kernel+0xb3/0x1cd
>  [<c13b6342>] unknown_bootoption+0x0/0x1b6
> Code: e4 f7 0f 30 c3 56 53 83 ec 0c 8b 1d 30 d0 ff ff a1 20 d0 ff ff c1 e8 18 0f
> b6 f3 83 e0 0f 0f a3 05 e0 03 3f c1 19 c0 85 c0 75 02 <0f> 0b c7 05 e0 d0 ff ff
> ff ff ff ff 8b 0d c4 03 3f c1 a1 d0 d0
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>
>
> Thanks
> Vivek
