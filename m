Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130803AbRAODCa>; Sun, 14 Jan 2001 22:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbRAODCU>; Sun, 14 Jan 2001 22:02:20 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:22547 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S130803AbRAODCG>; Sun, 14 Jan 2001 22:02:06 -0500
Date: Mon, 15 Jan 2001 04:00:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, alan@redhat.com
Subject: Re: [PATCH] enable K7 nmi watchdog
Message-ID: <20010115040029.A8496@platan.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 04:16:59PM +0100, Mikael Pettersson wrote:
> This patch (against 2.4.0-ac8) _may_ enable the NMI watchdog on
> some K7 systems. It won't help if you have an old K7 without a
> local APIC, or if your BIOS disables it.
> 
> This is a quick hack to test the mechanism -- I'll submit a
> cleaner patch later if this one works.
> 
> If you try this, please cc: me the result (positive or negative)
> and a copy of the kernel's boot log.

Hi,
  I had to change couple of things in your patch:
(1) You missed some zeros in MSR_K7_ definitions
(2) AMD's MSR are real 64bit (well, 47bit) values, so high
    MSR dword must be set to -1, not to 0
(3) on my CPU performance register 0x76 counts who knows what...
    This causes that when machine is idle, there is exactly one
    NMI per second. When machine is loaded, NMI count/sec climbs
    up to 100 NMIs per sec. I have no idea whether someone slows
    clock down to 10MHz on hlt, or what happens. Maybe that they
    removed this from documentation due to this. This also means
    that on bootup check for NMI stuck probably passed only
    due to pure luck - because of mdelay()/udelay() is implemented
    as tight loop.

Otherwise it works - I did not checked vmware yet, and I expect
that vmmon die painfull death because of it disables NMI only
on SMP kernels... But it is easily fixable.

I did not checked what happens if I'll do cli; hlt;, but as
nmi count clibms up, I believe that it will work.

BTW, it was really painful to find which of AMD documents documents
these MSRs (it is 22007). Their search engined did not found them...

BTW#2: Should not intel code use -1 for high dword too? I have no
documentation handy, but as MSRs are 64bit registers...

Patch:

diff -urdN linux/arch/i386/kernel/nmi.c linux/arch/i386/kernel/nmi.c
--- linux/arch/i386/kernel/nmi.c	Sun Jan 14 05:02:42 2001
+++ linux/arch/i386/kernel/nmi.c	Mon Jan 15 03:26:15 2001
@@ -64,6 +64,10 @@
 			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
 			(boot_cpu_data.x86 == 6))
 		nmi_watchdog = nmi;
+	if ((nmi == NMI_LOCAL_APIC) &&
+			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+			(boot_cpu_data.x86 == 6))
+		nmi_watchdog = nmi;
 	/*
 	 * We can enable the IO-APIC watchdog
 	 * unconditionally.
@@ -80,10 +84,34 @@
  * Original code written by Keith Owens.
  */
 
+#define MSR_K7_EVNTSEL0 0xC0010000
+#define MSR_K7_PERFCTR0 0xC0010004
+
 void setup_apic_nmi_watchdog (void)
 {
 	int value;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 == 6) {
+		unsigned evntsel = (1<<20)|(3<<16);	/* INT, OS, USR */
+#if 1	/* listed in old docs */
+		evntsel |= 0x76;	/* CYCLES_PROCESSOR_IS_RUNNING */
+#else	/* try this if the above doesn't work */
+		evntsel |= 0xC0;	/* RETIRED_INSTRUCTIONS */
+#endif
+		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
+		wrmsr(MSR_K7_PERFCTR0, 0, 0);
+		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+		printk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/HZ*1000));
+		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
+		printk("setting K7 LVTPC to DM_NMI\n");
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		evntsel |= (1<<22);	/* ENable */
+		printk("setting K7_EVNTSEL0 to %08x\n", evntsel);
+		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+		return;
+	}
+
 	/* clear performance counters 0, 1 */
 
 	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
@@ -162,7 +190,14 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC))
-		wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
+	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC)) {
+		/* XXX: nmi_watchdog should carry this info */
+		unsigned msr;
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+			wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
+		} else {
+			wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
+		}
+	}
 }
 
diff -urdN linux/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Sun Jan 14 05:02:42 2001
+++ linux/arch/i386/kernel/setup.c	Sun Jan 14 05:04:24 2001
@@ -1926,14 +1926,6 @@
 			c->x86 = 4;
 		}
 
-		/*
-		 * Athlons have an APIC, but the APIC-programming
-		 * MSRs are in different places. If you want NMI-watchdog
-		 * on Athlons, please fix setup_apic_nmi_watchdog().
-		 */
-		if (c->x86_vendor == X86_VENDOR_AMD)
-			clear_bit(X86_FEATURE_APIC, &c->x86_capability);
-
 		/* AMD-defined flags: level 0x80000001 */
 		xlvl = cpuid_eax(0x80000000);
 		if ( (xlvl & 0xffff0000) == 0x80000000 ) {


Linux version 2.4.0-ac9-smp (root@ppc) (gcc version 2.95.3 20010111 (prerelease)) #5 Mon Jan 15 03:26:44 CET 2001
[snip]
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: BOOT_IMAGE=Linux ro root=2105 video=matrox:vesa:0x105,left:184,right:32 devfs=nomount
Initializing CPU#0
Detected 1009.011 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2011.95 BogoMIPS
Memory: 255580k/262064k available (922k kernel code, 6092k reserved, 365k data, 200k init, 0k highmem)
[snip]
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
setting K7_PERFCTR0 to ff6609f0
setting K7 LVTPC to DM_NMI
setting K7_EVNTSEL0 to 00530076
testing NMI watchdog ... OK.
calibrating APIC timer ...
..... CPU clock speed is 1009.0567 MHz.
..... host bus clock speed is 201.8113 MHz.
cpu: 0, clocks: 2018113, slice: 1009056
CPU0<T0:2018112,T1:1009056,D:0,S:1009056,C:2018113>
[snip]
DMI 2.3 present.
49 structures occupying 1372 bytes.
DMI table at 0x000F28B0.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS A7V ACPI BIOS Revision 1004D
BIOS Release: 09/26/2000
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: <A7V>.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
[snip]


cat /proc/interrupts:

           CPU0       
  0:     113469          XT-PIC  timer
  1:       6777          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        735          XT-PIC  serial
  4:         34          XT-PIC  serial
  5:         36          XT-PIC  usb-uhci, usb-uhci
  7:         28          XT-PIC  parport0
  8:          1          XT-PIC  rtc
 10:      39522          XT-PIC  ide2, ide3
 12:          0          XT-PIC  es1371
 14:         23          XT-PIC  ide0
NMI:       4710 
LOC:     113416 
ERR:          1

cat /proc/cpuinfo:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1009.011
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2011.95


						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
