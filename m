Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVJVOwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVJVOwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 10:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJVOwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 10:52:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56493 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932234AbVJVOwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 10:52:15 -0400
Date: Sat, 22 Oct 2005 20:22:08 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
Message-ID: <20051022145207.GA4501@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com> <20051021133306.GC3799@in.ibm.com> <m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 08:45:12AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 

[..]

> >> +	/*
> >> +	 * Should not be necessary because the MP table should list the boot
> >> +	 * CPU too, but we do it for the sake of robustness anyway.
> >> +	 * Makes no sense to do this check in clustered apic mode, so skip it
> >> +	 */
> >> +	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
> >> +		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
> >> +				boot_cpu_physical_apicid);
> >
> >
> > I am testing kdump on i386 and I am hitting this message while second kernel
> > is booting. I am doing testing with 2.6.14-rc4-mm1. Logs are pasted below.
> 
> The check has been there for a while.  All it is saying is that
> our boot cpu has apicid #1.   So I suspect you are either on
> an Opteron system or a hyperthreaded Xeon system.
> 

I am using Pentium. No hyperthreading.

> > Also kdump testing fails almost 50% of the time on my machine with
> > 2.6.14-rc4-mm1.  It works fine with 2.6.14-rc4 though.
> 
> Is the failure that happens 50% represented by the bootlog below?
> 

Yes. But this problem is not happening all the time. Now in 4 trials
I got it once again. The message in all the failures remains the same. 

 
> The problem bootlog appears to be a glitch in the handling
> of apicids on the boot cpu that the BIOS does not report to the
> kernel.
> 
> > Second kernel is unable to come up. earlyprintk on serial console showed
> > a kernel BUG in setup_local_APIC(). Details are included in the logs below.
> 
> > Second kernel boot log.
> 
> The BUG is weird.  I don't think apic.c even goes to line 1479.
> Unless the BUG is inline in one of the other functions called
> by setup_local_APIC() .
> 
> 	/*
> 	 * Double-check whether this APIC is really registered.
> 	 */
> 	if (!apic_id_registered())
> 		BUG();
> 
> 
> apic_id_registered expands to:
> static inline int apic_id_registered(void)
> {
> 	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
> }
> 
> Which indicates to me that the code that, there is something
> wrong in the logic of:
> 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
> 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
> 				boot_cpu_physical_apicid);
> 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
> 	}
> 
> Currently we are refering to the boot cpus apicid with 3 different expressions
> one of them appears to be wrong.
> 

Looks like apic_id_registered() is failing. I had put two debug printk()
statements and to my surprise hard_smp_processor_id() is returning different
value then GET_APIC_ID(apic_read(APIC_ID)).

source code of hard_smp_processor_id() shows that it is also reading APIC_ID
register only. Then how can two values be different. (Until and unless
somebody modified the value in between two reads).

I am pasting another failure log with my debug messages(prefixed with "Debug:").
My debug patch is also attached with the mail.

Second kernel boot log
---------------------

I'm in purgatory
Linux version 2.6.14-rc4-mm1-16M (root@llm01.in.ibm.com) (gcc version 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)) #2 PREEMPT Sat Oct 22 18:44:25 IST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009d000 (usable)
 BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffa480 (usable)
 BIOS-e820: 000000002fffa480 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000142d000 (usable)
 user: 00000000014cd400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
found SMP MP-table at 0009e140
early console enabled
DMI 2.1 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:10 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 17
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:10 APIC version 17
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 6:10 APIC version 17
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 05000000:fb000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/sda7 rhgb console=ttyS0,38400 irqpoll init 3 earlyprintk=ttyS0,38400 memmap=exactmap memmap=640K@0K memmap=4276K@16384K memmap=60619K@21301K elfcorehdr=21300K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
weird, boot CPU (#1) not listed by the BIOS.
Debug:Harsetting cpu apic id 0 to be present
Debug: APIC id being queried is 1
------------[ cut here ]------------
kernel BUG at ÿÿÿÿ:1479!
invalid operand: 0000 [#1]
PREEMPT
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c1012b32>]    Not tainted VLI
EFLAGS: 00010046   (2.6.14-rc4-mm1-16M)
EIP is at setup_local_APIC+0x41/0x1a7
eax: 00000000   ebx: 00040011   ecx: 00000c5b   edx: c1344201
esi: 00000011   edi: c13a9800   ebp: 01445007   esp: c13b5fbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c13b4000 task=c133faa0)
Stack: c12e8774 00000001 c101ac40 00000000 01429900 c13c1c49 c12e8ac0 00000000
       00000003 c13b66cf c12e5d7d c13eddc0 c133ba5c 00000078 c13b6342 c13eddc0
       c1000199
Call Trace:
 [<c101ac40>] printk+0x17/0x1b
 [<c13c1c49>] APIC_init+0x5a/0x10a
 [<c13b66cf>] start_kernel+0xb3/0x1cd
 [<c13b6342>] unknown_bootoption+0x0/0x1b6
Code: c1 c1 e8 18 0f b6 f3 83 e0 0f 89 44 24 04 e8 0f 81 00 00 a1 20 d0 ff ff c1 e8 18 83 e0 0f 0f a3 05 e0 03 3f c1 19 c0 85 c0 75 02 <0f> 0b c7 05 e0 d0 ff ff ff ff ff ff 8b 0d c4 03 3f c1 a1 d0 d0
 <0>Kernel panic - not syncing: Attempted to kill the idle task!


Debug Patch
----------


 linux-2.6.14-rc4-mm1-16M-root/arch/i386/kernel/apic.c                   |    2 ++
 linux-2.6.14-rc4-mm1-16M-root/include/asm-i386/mach-default/mach_apic.h |    1 +
 2 files changed, 3 insertions(+)

diff -puN arch/i386/kernel/apic.c~apic-debug arch/i386/kernel/apic.c
--- linux-2.6.14-rc4-mm1-16M/arch/i386/kernel/apic.c~apic-debug	2005-10-22 18:37:28.000000000 +0530
+++ linux-2.6.14-rc4-mm1-16M-root/arch/i386/kernel/apic.c	2005-10-22 18:42:50.000000000 +0530
@@ -1299,6 +1299,8 @@ int __init APIC_init(void)
 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 				boot_cpu_physical_apicid);
+		printk("Debug:Harsetting cpu apic id %d to be present\n",
+				hard_smp_processor_id());
 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
diff -puN include/asm-i386/mach-default/mach_apic.h~apic-debug include/asm-i386/mach-default/mach_apic.h
--- linux-2.6.14-rc4-mm1-16M/include/asm-i386/mach-default/mach_apic.h~apic-debug	2005-10-22 18:38:42.000000000 +0530
+++ linux-2.6.14-rc4-mm1-16M-root/include/asm-i386/mach-default/mach_apic.h	2005-10-22 18:44:10.000000000 +0530
@@ -111,6 +111,7 @@ static inline int check_phys_apicid_pres
 
 static inline int apic_id_registered(void)
 {
+	printk("Debug: APIC id being queried is %d\n", GET_APIC_ID(apic_read(APIC_ID)));
 	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
 }
 
_

/proc/cpuinfo output
--------------------

[root@llm01 ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.365
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1400.68

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.365
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1398.47

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.365
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1398.47

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 699.365
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1398.48


Thanks
Vivek
