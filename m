Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279412AbRKFOKE>; Tue, 6 Nov 2001 09:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKFOJw>; Tue, 6 Nov 2001 09:09:52 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:41676 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S279418AbRKFOJe>; Tue, 6 Nov 2001 09:09:34 -0500
Date: Tue, 6 Nov 2001 14:09:53 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CFT] [PATCH] big resync x86 setup code for 2.2.20
Message-ID: <20011106140953.A1378@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I just backported a lot of stuff from 2.4's setup.c and friends.
Some of this stuff hasn't been updated since ~2.3.99 or so, which
was just before hpa's big cleanup in that area.

Summary of changes:
- updated bluesmoke.c
  - MSR number typo bugfix
  - extra non-Intel architecture support.
- setup.c
  - P4 right justified name string fixup
  - Fix up c->x86_cache_size on machines with 0K L2 cache
  - Fix up cache size on Cyrix MediaGx
  - Enable MMX extensions on MII (Alan)
  - Fix up misplaced brace in Cyrix setup path.
  - Add recognition of RiSE CPUs.
  - Update cpuid_level when disabling serial number (Hugh Dickins)
  - Initialise Centaur CPUs from the same codepath as the other vendors
    instead of in print_cpu_info()
  - Recognise all types of Celerons/Mobile PII's
  - boottime 'serialnumber' option to leave serial # enabled.
  - Improved Centaur Winchip handling.
  - Recognise 386/486 in c->x86_model_id (Cesar Barros)
  - Several bug workarounds moved from bugs.h to setup.c
  - Other small cleanups.
  - Overall source cleaning to bring in line with 2.4

The 2.4 stuff is still cleaner than 2.2's, but this at least
gets things a lot closer to each other making any future resyncs easier.
There's still some outstanding bits, such as PIII Tualatin fixups,
but I'll wait until they're in 2.4 for a while before merging.

Due to the huge size of this diff, there may be some breakage, so I'd
like to get some testing before sending this to Alan for 2.2.21pre
inclusion.  Let me know of any no-boot/strange output/cpuinfo cases,
and I'll see what goes.

Patch is against 2.2.20


diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/bluesmoke.c linux-dj/arch/i386/kernel/bluesmoke.c
--- linux/arch/i386/kernel/bluesmoke.c	Fri Nov  2 16:39:05 2001
+++ linux-dj/arch/i386/kernel/bluesmoke.c	Tue Nov  6 13:26:26 2001
@@ -1,17 +1,18 @@
-/*
- *	Machine Check Handler For PII/PIII
- */
 
-#include <linux/config.h>
+#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
 
-static int banks = 0;
+/*
+ *	Machine Check Handler For PII/PIII
+ */
+
+static int banks;
 
-void mcheck_fault(void)
+static void intel_machine_check(struct pt_regs * regs, long error_code)
 {
 	int recover=1;
 	u32 alow, ahigh, high, low;
@@ -37,7 +38,7 @@
 			high&=~(1<<31);
 			if(high&(1<<27))
 			{
-				rdmsr(0x403+i*4, alow, ahigh);
+				rdmsr(0x402+i*4, alow, ahigh);
 				printk("[%08x%08x]", alow, ahigh);
 			}
 			if(high&(1<<26))
@@ -50,7 +51,7 @@
 			/* Clear it */
 			wrmsr(0x401+i*4, 0UL, 0UL);
 			/* Serialize */
-			mb();
+			wmb();
 		}
 	}
 	
@@ -63,31 +64,101 @@
 	wrmsr(0x17a,mcgstl, mcgsth);
 }
 
+/*
+ *	Machine check handler for Pentium class Intel
+ */
+ 
+static void pentium_machine_check(struct pt_regs * regs, long error_code)
+{
+	u32 loaddr, hi, lotype;
+	rdmsr(0x0, loaddr, hi);
+	rdmsr(0x1, lotype, hi);
+	printk(KERN_EMERG "CPU#%d: Machine Check Exception:  0x%8X (type 0x%8X).\n", smp_processor_id(), loaddr, lotype);
+	if(lotype&(1<<5))
+		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU on fire ?).\n", smp_processor_id());
+}
 
 /*
- *	This has to be run for each processor
+ *	Machine check handler for WinChip C6
  */
  
-void mcheck_init(void)
+static void winchip_machine_check(struct pt_regs * regs, long error_code)
+{
+	printk(KERN_EMERG "CPU#%d: Machine Check Exception.\n", smp_processor_id());
+}
+
+/*
+ *	Handle unconfigured int18 (should never happen)
+ */
+
+static void unexpected_machine_check(struct pt_regs * regs, long error_code)
+{	
+	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
+}
+
+/*
+ *	Call the installed machine check handler for this CPU setup.
+ */ 
+ 
+static void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
+
+void do_machine_check(struct pt_regs * regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
+/*
+ *	Set up machine check reporting for Intel processors
+ */
+
+void __init intel_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
 	int i;
-	struct cpuinfo_x86 *c;
-	static int done=0;
+	static int done;
+	
+	/*
+	 *	Check for MCE support
+	 */
 
-	c=cpu_data+smp_processor_id();
+	if(!(c->x86_capability&X86_FEATURE_MCE))
+		return;	
 	
-	if(c->x86_vendor!=X86_VENDOR_INTEL)
-		return;
+	/*
+	 *	Pentium machine check
+	 */
 	
-	if(!(c->x86_capability&X86_FEATURE_MCE))
+	if(c->x86 == 5)
+	{
+		machine_check_vector = pentium_machine_check;
+		wmb();
+		/* Read registers before enabling */
+		rdmsr(0x0, l, h);
+		rdmsr(0x1, l, h);
+		if(done==0)
+			printk(KERN_INFO "Intel old style machine check architecture supported.\n");
+		/* Enable MCE */	
+		__asm__ __volatile__ (
+			"movl %%cr4, %%eax\n\t"
+			"orl $0x40, %%eax\n\t"
+			"movl %%eax, %%cr4\n\t" : : : "eax");
+		printk(KERN_INFO "Intel old style machine check reporting enabled on CPU#%d.\n", smp_processor_id());
 		return;
-		
+	}
+	
+
+	/*
+	 *	Check for PPro style MCA
+	 */
+	 		
 	if(!(c->x86_capability&X86_FEATURE_MCA))
 		return;
 		
 	/* Ok machine check is available */
 	
+	machine_check_vector = intel_machine_check;
+	wmb();
+	
 	if(done==0)
 		printk(KERN_INFO "Intel machine check architecture supported.\n");
 	rdmsr(0x179, l, h);
@@ -102,10 +173,69 @@
 	{
 		wrmsr(0x401+4*i, 0x0, 0x0); 
 	}
+	set_in_cr4(X86_CR4_MCE);
+	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+	done=1;
+}
+
+/*
+ *	Set up machine check reporting on the Winchip C6 series
+ */
+ 
+static void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
+{
+	u32 lo, hi;
+	/* Not supported on C3 */
+	if(c->x86 != 5)
+		return;
+	/* Winchip C6 */
+	machine_check_vector = winchip_machine_check;
+	wmb();
+	rdmsr(0x107, lo, hi);
+	lo|= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
+	lo&= ~(1<<4);	/* Enable MCE */
+	wrmsr(0x107, lo, hi);
 	__asm__ __volatile__ (
 		"movl %%cr4, %%eax\n\t"
 		"orl $0x40, %%eax\n\t"
 		"movl %%eax, %%cr4\n\t" : : : "eax");
-	printk(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n", smp_processor_id());
-	done=1;
+	printk(KERN_INFO "Winchip machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+}
+
+
+/*
+ *	This has to be run for each processor
+ */
+
+
+static int mce_disabled = 0;
+
+void __init mcheck_init(struct cpuinfo_x86 *c)
+{
+	if(mce_disabled)
+		return;
+		
+	switch(c->x86_vendor)
+	{
+		case X86_VENDOR_AMD:
+			/*
+			 *	AMD K7 machine check is Intel like
+			 */
+			if(c->x86 == 6)
+				intel_mcheck_init(c);
+			break;
+		case X86_VENDOR_INTEL:
+			intel_mcheck_init(c);
+			break;
+		case X86_VENDOR_CENTAUR:
+			winchip_mcheck_init(c);
+			break;
+	}
+}
+
+static int __init mcheck_disable(char *str, int *unused)
+{
+	mce_disabled = 1;
+	return 0;
 }
+__setup("nomce", mcheck_disable);
diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/entry.S linux-dj/arch/i386/kernel/entry.S
--- linux/arch/i386/kernel/entry.S	Fri Nov  2 16:39:05 2001
+++ linux-dj/arch/i386/kernel/entry.S	Tue Nov  6 13:26:26 2001
@@ -366,7 +366,7 @@
 
 ENTRY(machine_check)
 	pushl $0
-	pushl $ SYMBOL_NAME(mcheck_fault)
+	pushl $ SYMBOL_NAME(do_machine_check)
 	jmp error_code
 
 ENTRY(spurious_interrupt_bug)
diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/setup.c linux-dj/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Sun Mar 25 17:37:29 2001
+++ linux-dj/arch/i386/kernel/setup.c	Tue Nov  6 13:44:04 2001
@@ -36,9 +36,13 @@
  *	Added Cyrix III initial detection code
  *	Alan Cox <alan@redhat.com>, Septembr 2000
  *
- *      Improve cache size calculation
- *      Asit Mallick <asit.k.mallick@intel.com>, October 2000
- *      Andrew Ip <aip@turbolinux.com>, October 2000
+ *	Improve cache size calculation
+ *	Asit Mallick <asit.k.mallick@intel.com>, October 2000
+ *	Andrew Ip <aip@turbolinux.com>, October 2000
+ *
+ *	Backport various workarounds from 2.4.14
+ *	Dave Jones <davej@suse.de>, November 2001
+ *
  */
 
 /*
@@ -114,10 +118,13 @@
 extern int rd_image_start;	/* starting block # of image */
 #endif
 
+extern void mcheck_init(struct cpuinfo_x86 *c);
 extern int root_mountflags;
 extern int _etext, _edata, _end;
 extern unsigned long cpu_khz;
 
+static int disable_x86_serial_nr __initdata = 1;
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -386,8 +393,8 @@
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
        char saved_command_line[COMMAND_LINE_SIZE];
 
-__initfunc(void setup_arch(char **cmdline_p,
-	unsigned long * memory_start_p, unsigned long * memory_end_p))
+void __init setup_arch(char **cmdline_p,
+	unsigned long * memory_start_p, unsigned long * memory_end_p)
 {
 	unsigned long memory_start, memory_end = 0;
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
@@ -572,49 +579,52 @@
 }
 
 
-__initfunc(static int get_model_name(struct cpuinfo_x86 *c))
+static int __init get_model_name(struct cpuinfo_x86 *c)
 {
-	unsigned int n, dummy, *v;
-
-	/* 
-	 * Actually we must have cpuid or we could never have
-	 * figured out that this was AMD/Centaur/Cyrix/Transmeta
-	 * from the vendor info :-).
-	 */
+	unsigned int *v;
+	char *p, *q;
 
-	cpuid(0x80000000, &n, &dummy, &dummy, &dummy);
-	if (n < 0x80000004)
+	if (cpuid_eax(0x80000000) < 0x80000004)
 		return 0;
-	cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));
 	v = (unsigned int *) c->x86_model_id;
 	cpuid(0x80000002, &v[0], &v[1], &v[2], &v[3]);
 	cpuid(0x80000003, &v[4], &v[5], &v[6], &v[7]);
 	cpuid(0x80000004, &v[8], &v[9], &v[10], &v[11]);
 	c->x86_model_id[48] = 0;
-	
+
+	/* Intel chips right-justify this string for some dumb reason;
+	   undo that brain damage */
+	p = q = &c->x86_model_id[0];
+	while ( *p == ' ' )
+		p++;
+	if ( p != q ) {
+		while ( *p )
+			*q++ = *p++;
+		while ( q <= &c->x86_model_id[48] )
+			*q++ = '\0';  /* Zero-pad the rest */
+	}
 	return 1;
 }
 
 
-__initfunc (static void display_cacheinfo(struct cpuinfo_x86 *c))
+static void __init display_cacheinfo(struct cpuinfo_x86 *c)
 {
-	unsigned int n, dummy, ecx, edx;
+	unsigned int n, dummy, ecx, edx, l2size;
 
-	cpuid(0x80000000, &n, &dummy, &dummy, &dummy);
+	n = cpuid_eax(0x80000000);
 
 	if (n >= 0x80000005){
 		cpuid(0x80000005, &dummy, &dummy, &ecx, &edx);
-		printk("CPU: L1 I Cache: %dK  L1 D Cache: %dK\n",
-			ecx>>24, edx>>24);
+		printk("CPU: L1 I Cache: %dK (%d bytes/line), D cache %dK (%d bytes/line)\n",
+			edx>>24, edx&0xFF, ecx>>24, ecx&0xFF);
 		c->x86_cache_size=(ecx>>24)+(edx>>24);
 	}
 
-	/* Yes this can occur - the CyrixIII just has a large L1 */
-	if (n < 0x80000006)
-		return;	/* No function to get L2 info */
+	if (n < 0x80000006)	/* Some chips just has a large L1. */
+		return;
 
-	cpuid(0x80000006, &dummy, &dummy, &ecx, &edx);
-	c->x86_cache_size = ecx>>16;
+	ecx = cpuid_ecx(0x80000006);
+	l2size = ecx >> 16;
 
 	/* AMD errata T13 (order #21922) */
 	if(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
@@ -622,15 +632,20 @@
 		boot_cpu_data.x86_model== 3 &&
 		boot_cpu_data.x86_mask == 0)
 	{
-		c->x86_cache_size = 64;
+		l2size = 64;
 	}
 
-	printk("CPU: L2 Cache: %dK\n", c->x86_cache_size);
-}
+	if (l2size == 0)
+		return;		/* Again, no L2 cache is possible */
+
+	c->x86_cache_size = l2size;
 
+	printk("CPU: L2 Cache: %dK (%d bytes/line)\n",
+		l2size, ecx & 0xFF);
+}
 
 
-__initfunc(static int amd_model(struct cpuinfo_x86 *c))
+__initfunc(static int init_amd(struct cpuinfo_x86 *c))
 {
 	u32 l, h;
 	unsigned long flags;
@@ -714,16 +729,6 @@
 	return r;
 }
 
-__initfunc(static void intel_model(struct cpuinfo_x86 *c))
-{
-	unsigned int *v = (unsigned int *) c->x86_model_id;
-	cpuid(0x80000002, &v[0], &v[1], &v[2], &v[3]);
-	cpuid(0x80000003, &v[4], &v[5], &v[6], &v[7]);
-	cpuid(0x80000004, &v[8], &v[9], &v[10], &v[11]);
-	c->x86_model_id[48] = 0;
-	printk("CPU: %s\n", c->x86_model_id);
-}
-			
 
 /*
  * Read Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
@@ -784,7 +789,7 @@
 static char cyrix_model_mult1[] __initdata = "12??43";
 static char cyrix_model_mult2[] __initdata = "12233445";
 
-__initfunc(static void cyrix_model(struct cpuinfo_x86 *c))
+static void __init init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
@@ -860,6 +865,8 @@
                 isa_dma_bridge_buggy = 2;
                   	                                                                     	        
 #endif
+		c->x86_cache_size=16;   /* Yep 16K integrated cache thats it */
+
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			get_model_name(c);  /* get CPU marketing name */
@@ -875,8 +882,13 @@
 		break;
 
         case 5: /* 6x86MX/M II */
-		if (dir1 > 7) dir0_msn++;  /* M II */
-		else c->coma_bug = 1;      /* 6x86MX, it has the bug. */
+		if (dir1 > 7) {
+			dir0_msn++;  /* M II */
+			/* Enable MMX extensions (App note 108) */
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7)|1);
+		} else {
+			c->coma_bug = 1;      /* 6x86MX, it has the bug. */
+		}
 		tmp = (!(dir0_lsn & 7) || dir0_lsn & 1) ? 2 : 0;
 		Cx86_cb[tmp] = cyrix_model_mult2[dir0_lsn & 7];
 		p = Cx86_cb+tmp;
@@ -897,8 +909,8 @@
 			dir0_msn = 0;
 			p = Cx486S_name[0];
 			break;
-		break;
 		}
+		break;
 
 	default:  /* unknown (shouldn't happen, we know everyone ;-) */
 		dir0_msn = 7;
@@ -909,7 +921,7 @@
 	return;
 }
 
-__initfunc(static void transmeta_model(struct cpuinfo_x86 *c))
+static void __init init_transmeta(struct cpuinfo_x86 *c)
 {
 	unsigned int cap_mask, uk, max, dummy;
 	unsigned int cms_rev1, cms_rev2;
@@ -974,7 +986,31 @@
 }
 
 
-__initfunc(void get_cpu_vendor(struct cpuinfo_x86 *c))
+static void __init init_rise(struct cpuinfo_x86 *c)
+{
+	printk("CPU: Rise iDragon");
+	if (c->x86_model > 2)
+		printk(" II");
+	printk("\n");
+
+	/* Unhide possibly hidden capability flags
+	 * The mp6 iDragon family don't have MSRs
+	 * We switch on extra features with this cpuid weirdness: */
+	__asm__ (
+		"movl $0x6363452a, %%eax\n\t"
+		"movl $0x3231206c, %%ecx\n\t"
+		"movl $0x2a32313a, %%edx\n\t"
+		"cpuid\n\t"
+		"movl $0x63634523, %%eax\n\t"
+		"movl $0x32315f6c, %%ecx\n\t"
+		"movl $0x2333313a, %%edx\n\t"
+		"cpuid\n\t" : : : "eax", "ebx", "ecx", "edx"
+	);
+	c->x86_capability |= X86_FEATURE_CX8;
+}
+
+
+static void __init get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 
@@ -998,104 +1034,60 @@
 		c->x86_vendor = X86_VENDOR_UNKNOWN;
 }
 
-struct cpu_model_info {
-	int vendor;
-	int x86;
-	char *model_names[16];
-};
-
-static struct cpu_model_info cpu_models[] __initdata = {
-	{ X86_VENDOR_INTEL,	4,
-	  { "486 DX-25/33", "486 DX-50", "486 SX", "486 DX/2", "486 SL", 
-	    "486 SX/2", NULL, "486 DX/2-WB", "486 DX/4", "486 DX/4-WB", NULL, 
-	    NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_INTEL,	5,
-	  { "Pentium 60/66 A-step", "Pentium 60/66", "Pentium 75 - 200",
-	    "OverDrive PODP5V83", "Pentium MMX", NULL, NULL,
-	    "Mobile Pentium 75 - 200", "Mobile Pentium MMX", NULL, NULL, NULL,
-	    NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_INTEL,	6,
-	  { "Pentium Pro A-step", "Pentium Pro", NULL, "Pentium II (Klamath)", 
-	    NULL, "Pentium II (Deschutes)", "Mobile Pentium II", 
-	    "Pentium III (Katmai)", "Pentium III (Coppermine)", NULL,
-	    "Pentium III (Cascades)", NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_AMD,	4,
-	  { NULL, NULL, NULL, "486 DX/2", NULL, NULL, NULL, "486 DX/2-WB",
-	    "486 DX/4", "486 DX/4-WB", NULL, NULL, NULL, NULL, "Am5x86-WT",
-	    "Am5x86-WB" }},
-	{ X86_VENDOR_AMD,	5,
-	  { "K5/SSA5", "K5",
-	    "K5", "K5", NULL, NULL,
-	    "K6", "K6", "K6-2",
-	    "K6-3", NULL, NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_AMD,	6,
-	  { "Athlon", "Athlon",
-	    NULL, NULL, NULL, NULL,
-	    NULL, NULL, NULL,
-	    NULL, NULL, NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_UMC,	4,
-	  { NULL, "U5D", "U5S", NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	    NULL, NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_CENTAUR,	5,
-	  { NULL, NULL, NULL, NULL, "C6", NULL, NULL, NULL, "C6-2", NULL, NULL,
-	    NULL, NULL, NULL, NULL, NULL }},
-	{ X86_VENDOR_NEXGEN,	5,
-	  { "Nx586", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	    NULL, NULL, NULL, NULL, NULL, NULL, NULL }},
-};
 
-__initfunc(void identify_cpu(struct cpuinfo_x86 *c))
+static void __init init_centaur(struct cpuinfo_x86 *c)
 {
-	int i;
-	char *p = NULL;
-	extern void mcheck_init(void);
+	u32 hv,lv;
 	
-	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	/* Centaur C6 Series */
+	if(c->x86==5)
+	{
+		rdmsr(0x107, lv, hv);
+		printk("Centaur FSR was 0x%X ",lv);
+		lv|=(1<<1 | 1<<2 | 1<<7);
+		/* lv|=(1<<6);	- may help too if the board can cope */
+		printk("now 0x%X\n", lv);
+		wrmsr(0x107, lv, hv);
+		/* Emulate MTRRs using Centaur's MCR. */
+		c->x86_capability |= X86_FEATURE_MTRR;
 
-	get_cpu_vendor(c);
+		/* Disable TSC on C6 as per errata. */
+		if (c->x86_model ==4) {
+			printk ("Disabling bugged TSC.\n");
+			c->x86_capability &= ~X86_FEATURE_TSC;
+		}
 
-	if (c->x86_vendor == X86_VENDOR_UNKNOWN &&
-	    c->cpuid_level < 0)
-		return;
+		/* Set 3DNow! on Winchip 2 and above. */
+		if (c->x86_model >=8)
+		    c->x86_capability |= X86_FEATURE_AMD3D;
 
-	/* It should be possible for the user to override this. */
-	if(c->cpuid_level > 0 && 
-	   (c->x86_vendor == X86_VENDOR_INTEL || c->x86_vendor == X86_VENDOR_TRANSMETA) &&
-	   c->x86_capability&(1<<18)) {
-		/* Disable processor serial number */
-		unsigned long lo,hi;
-		rdmsr(0x119,lo,hi);
-		lo |= 0x200000;
-		wrmsr(0x119,lo,hi);
-		printk(KERN_INFO "CPU serial number disabled.\n");
+		c->x86_capability |=X86_FEATURE_CX8;
 	}
+	/* Cyrix III 'Samuel' CPU */
+	if(c->x86 == 6 && c->x86_model == 6)
+	{
+		rdmsr(0x1107, lv, hv);
+		lv|=(1<<1);	/* Report CX8 */
+		lv|=(1<<7);	/* PGE enable */
+		wrmsr(0x1107, lv, hv);
+		/* Cyrix III */
+		c->x86_capability |= X86_FEATURE_CX8;
+		
+		/* Check for 3dnow */
+		cpuid(0x80000001, &lv, &lv, &lv, &hv);
+		if(hv&(1<<31))
+			c->x86_capability |= X86_FEATURE_AMD3D;
+	}	
+}
 
-	mcheck_init();
-	
-	if (c->x86_vendor == X86_VENDOR_CYRIX) {
-		cyrix_model(c);
-		return;
-	}
 
-	if (c->x86_vendor == X86_VENDOR_AMD && amd_model(c))
-		return;
-		
-	if (c->x86_vendor == X86_VENDOR_TRANSMETA) {
-		transmeta_model(c);
-		return;
-	}
-	
-	if(c->x86_vendor == X86_VENDOR_CENTAUR && c->x86==6)
-	{
-		/* The Cyrix III supports model naming and cache queries */
-		get_model_name(c);
-		display_cacheinfo(c);
-		return;
-	}
+static void __init init_intel(struct cpuinfo_x86 *c)
+{
+	char *p;
 
 	if (c->cpuid_level > 1) {
 		/* supports eax=2  call */
+		int i;
 		int regs[4];
 		int l1c=0, l1d=0, l2=0, l3=0;	/* Cache sizes */
 
@@ -1185,46 +1177,192 @@
 	 *	stuff for the 'Pentium IV'
 	 */
 
-	if(c->x86_vendor ==X86_VENDOR_INTEL && c->x86 == 15)
-	{
-		intel_model(c);
+	if (c->x86 == 15) {
+		get_model_name(c);
+		printk("CPU: %s\n", c->x86_model_id);
 		return;
 	}
 
-	for (i = 0; i < sizeof(cpu_models)/sizeof(struct cpu_model_info); i++) {
-		if (cpu_models[i].vendor == c->x86_vendor &&
-		    cpu_models[i].x86 == c->x86) {
-			if (c->x86_model <= 16)
-				p = cpu_models[i].model_names[c->x86_model];
-
-			/* Names for the Pentium II Celeron processors
-			   detectable only by also checking the cache size */
-			if ((cpu_models[i].vendor == X86_VENDOR_INTEL)
-			    && (cpu_models[i].x86 == 6)){ 
-				if(c->x86_model == 6 && c->x86_cache_size == 128) {
-					p = "Celeron (Mendocino)"; 
-				} else { 
-					if (c->x86_model == 5 && c->x86_cache_size == 0) {
-						p = "Celeron (Covington)";
-					}
-				}
-			}
+	/* Names for the Pentium II Celeron processors
+	   detectable only by also checking the cache size */
+    if (c->x86 == 6) { 
+		switch (c->x86_model) {
+			case 5:
+				if (c->x86_cache_size == 0)
+					p = "Celeron (Covington)";
+				if (c->x86_cache_size == 256)
+					p = "Mobile Pentium II (Dixon)";
+				break;
+			case 6:
+				if (c->x86_cache_size == 128)
+					p = "Celeron (Mendocino)";
+				break;
+			case 8:
+				if (c->x86_cache_size == 128)
+					p = "Celeron (Coppermine)";
+				break;
 		}
 	}
+}
 
-	if (p) {
-		strcpy(c->x86_model_id, p);
-		return;
+struct cpu_model_info {
+	int vendor;
+	int family;
+	char *model_names[16];
+};
+
+static struct cpu_model_info cpu_models[] __initdata = {
+	{ X86_VENDOR_INTEL,	4,
+	  { "486 DX-25/33", "486 DX-50", "486 SX", "486 DX/2", "486 SL", 
+	    "486 SX/2", NULL, "486 DX/2-WB", "486 DX/4", "486 DX/4-WB", NULL, 
+	    NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_INTEL,	5,
+	  { "Pentium 60/66 A-step", "Pentium 60/66", "Pentium 75 - 200",
+	    "OverDrive PODP5V83", "Pentium MMX", NULL, NULL,
+	    "Mobile Pentium 75 - 200", "Mobile Pentium MMX", NULL, NULL, NULL,
+	    NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_INTEL,	6,
+	  { "Pentium Pro A-step", "Pentium Pro", NULL, "Pentium II (Klamath)", 
+	    NULL, "Pentium II (Deschutes)", "Mobile Pentium II", 
+	    "Pentium III (Katmai)", "Pentium III (Coppermine)", NULL,
+	    "Pentium III (Cascades)", NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_AMD,	4,
+	  { NULL, NULL, NULL, "486 DX/2", NULL, NULL, NULL, "486 DX/2-WB",
+	    "486 DX/4", "486 DX/4-WB", NULL, NULL, NULL, NULL, "Am5x86-WT",
+	    "Am5x86-WB" }},
+	{ X86_VENDOR_AMD,	5,
+	  { "K5/SSA5", "K5",
+	    "K5", "K5", NULL, NULL,
+	    "K6", "K6", "K6-2",
+	    "K6-3", NULL, NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_AMD,	6,
+	  { "Athlon", "Athlon",
+	    NULL, NULL, NULL, NULL,
+	    NULL, NULL, NULL,
+	    NULL, NULL, NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_UMC,	4,
+	  { NULL, "U5D", "U5S", NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	    NULL, NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_CENTAUR,	5,
+	  { NULL, NULL, NULL, NULL, "C6", NULL, NULL, NULL, "C6-2", NULL, NULL,
+	    NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_NEXGEN,	5,
+	  { "Nx586", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	    NULL, NULL, NULL, NULL, NULL, NULL, NULL }},
+	{ X86_VENDOR_RISE,  5,
+	  { "iDragon", NULL, "iDragon", NULL, NULL, NULL, NULL,
+	    NULL, "iDragon II", "iDragon II", NULL, NULL, NULL, NULL, NULL, NULL }},
+};
+
+
+static char __init *table_lookup_model(struct cpuinfo_x86 *c)
+{
+	struct cpu_model_info *info = cpu_models;
+	int i;
+
+	if ( c->x86_model >= 16 )
+		return NULL;	/* Range check */
+
+	for ( i = 0 ; i < sizeof(cpu_models)/sizeof(struct cpu_model_info) ; i++ ) {
+		if ( info->vendor == c->x86_vendor &&
+			info->family == c->x86 ) {
+			return info->model_names[c->x86_model];
+		}
+		info++;
 	}
+	return NULL;	/* Not found */
+}
 
-	sprintf(c->x86_model_id, "%02x/%02x", c->x86_vendor, c->x86_model);
+
+static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+{
+	if (c->x86_capability&(X86_FEATURE_PN) && disable_x86_serial_nr) {
+		/* Disable processor serial number */
+		unsigned long lo,hi;
+		rdmsr(0x119,lo,hi);
+		lo |= 0x200000;
+		wrmsr(0x119,lo,hi);
+		printk(KERN_NOTICE "CPU serial number disabled.\n");
+		c->x86_capability &= ~X86_FEATURE_PN;
+		c->cpuid_level = cpuid_eax(0);
+	}
+}
+int __init x86_serial_nr_setup(char *s)
+{
+	disable_x86_serial_nr = 0;
+	return 1;
+}
+__setup("serialnumber", x86_serial_nr_setup);
+
+
+__initfunc(void identify_cpu(struct cpuinfo_x86 *c))
+{
+	c->loops_per_jiffy = loops_per_jiffy;
+	c->x86_cache_size = -1;
+
+	get_cpu_vendor(c);
+
+	switch (c->x86_vendor) {
+		case X86_VENDOR_UNKNOWN:
+		default:
+			/* Not much we can do here... */
+			/* Check if at least it has cpuid */
+			if (c->cpuid_level == -1) {
+				/* No cpuid. It must be an ancient CPU */
+				if (c->x86 == 4)
+					strcpy(c->x86_model_id, "486");
+				else if (c->x86 == 3)
+					strcpy(c->x86_model_id, "386");
+			}
+			break;
+
+		case X86_VENDOR_CYRIX:
+			init_cyrix(c);
+			return;
+
+		case X86_VENDOR_AMD:
+			init_amd(c);
+			return;
+
+		case X86_VENDOR_CENTAUR:
+			init_centaur(c);
+			return;
+
+		case X86_VENDOR_TRANSMETA:
+			init_transmeta(c);
+			return;
+
+		case X86_VENDOR_RISE:
+			init_rise(c);
+			break;
+
+		case X86_VENDOR_INTEL:
+			init_intel(c);
+			break;
+	}
+	
+	squash_the_stupid_serial_number(c);
+
+	mcheck_init(c);
+	
+	/* If the model name is still unset, do table lookup. */
+	if ( !c->x86_model_id[0] ) {
+		char *p;
+		p = table_lookup_model(c);
+		if ( p )
+			strcpy(c->x86_model_id, p);
+		else
+			/* Last resort... */
+			sprintf(c->x86_model_id, "%02x/%02x",
+				c->x86_vendor, c->x86_model);
+	}
 }
 
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
  */
  
-__initfunc(void dodgy_tsc(void))
+void __init dodgy_tsc(void)
 {
 	get_cpu_vendor(&boot_cpu_data);
 	
@@ -1232,61 +1370,15 @@
 	{
 		return;
 	}
-	cyrix_model(&boot_cpu_data);
+	init_cyrix(&boot_cpu_data);
 }
 	
-	
 
 static char *cpu_vendor_names[] __initdata = {
 	"Intel", "Cyrix", "AMD", "UMC", "NexGen", "Centaur", "Rise", "Transmeta" };
 
 
-__initfunc(void setup_centaur(struct cpuinfo_x86 *c))
-{
-	u32 hv,lv;
-	
-	/* Centaur C6 Series */
-	if(c->x86==5)
-	{
-		rdmsr(0x107, lv, hv);
-		printk("Centaur FSR was 0x%X ",lv);
-		lv|=(1<<1 | 1<<2 | 1<<7);
-		/* lv|=(1<<6);	- may help too if the board can cope */
-		printk("now 0x%X\n", lv);
-		wrmsr(0x107, lv, hv);
-		/* Emulate MTRRs using Centaur's MCR. */
-		c->x86_capability |= X86_FEATURE_MTRR;
-
-		/* Disable TSC on C6 as per errata. */
-		if (c->x86_model ==4) {
-			printk ("Disabling bugged TSC.\n");
-			c->x86_capability &= ~X86_FEATURE_TSC;
-		}
-
-		/* Set 3DNow! on Winchip 2 and above. */
-		if (c->x86_model >=8)
-		    c->x86_capability |= X86_FEATURE_AMD3D;
-
-		c->x86_capability |=X86_FEATURE_CX8;
-	}
-	/* Cyrix III 'Samuel' CPU */
-	if(c->x86 == 6 && c->x86_model == 6)
-	{
-		rdmsr(0x1107, lv, hv);
-		lv|=(1<<1);	/* Report CX8 */
-		lv|=(1<<7);	/* PGE enable */
-		wrmsr(0x1107, lv, hv);
-		/* Cyrix III */
-		c->x86_capability |= X86_FEATURE_CX8;
-		
-		/* Check for 3dnow */
-		cpuid(0x80000001, &lv, &lv, &lv, &hv);
-		if(hv&(1<<31))
-			c->x86_capability |= X86_FEATURE_AMD3D;
-	}	
-}
-
-__initfunc(void print_cpu_info(struct cpuinfo_x86 *c))
+void __init print_cpu_info(struct cpuinfo_x86 *c)
 {
 	char *vendor = NULL;
 
@@ -1307,12 +1399,9 @@
 		printk(" stepping %02x\n", c->x86_mask);
 	else
 		printk("\n");
-
-	if(c->x86_vendor == X86_VENDOR_CENTAUR) {
-		setup_centaur(c);
-	}
 }
 
+
 /*
  *	Get CPU information for use by the procfs.
  */
@@ -1322,10 +1411,10 @@
 	char *p = buffer;
 	int sep_bug;
 	static char *x86_cap_flags[] = {
-	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
-	        "cx8", "apic", "10", "sep", "mtrr", "pge", "mca", "cmov",
-	        "16", "pse36", "psn", "19", "20", "21", "22", "mmx",
-	        "24", "xmm", "26", "27", "28", "29", "30", "31"
+		"fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
+		"cx8", "apic", "10", "sep", "mtrr", "pge", "mca", "cmov",
+		"pat", "pse36", "pn", "clflush", "20", "dts", "acpi", "mmx",
+		"fxsr", "sse", "sse2", "ss", "28", "tm", "ia64", "31"
 	};
 	struct cpuinfo_x86 *c = cpu_data;
 	int i, n;
diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/mm/init.c linux-dj/arch/i386/mm/init.c
--- linux/arch/i386/mm/init.c	Sun Mar 25 17:37:30 2001
+++ linux-dj/arch/i386/mm/init.c	Tue Nov  6 13:26:26 2001
@@ -185,33 +185,8 @@
 extern char _text, _etext, _edata, __bss_start, _end;
 extern char __init_begin, __init_end;
 
-#define X86_CR4_VME		0x0001		/* enable vm86 extensions */
-#define X86_CR4_PVI		0x0002		/* virtual interrupts flag enable */
-#define X86_CR4_TSD		0x0004		/* disable time stamp at ipl 3 */
-#define X86_CR4_DE		0x0008		/* enable debugging extensions */
-#define X86_CR4_PSE		0x0010		/* enable page size extensions */
-#define X86_CR4_PAE		0x0020		/* enable physical address extensions */
-#define X86_CR4_MCE		0x0040		/* Machine check enable */
-#define X86_CR4_PGE		0x0080		/* enable global pages */
-#define X86_CR4_PCE		0x0100		/* enable performance counters at ipl 3 */
-
-/*
- * Save the cr4 feature set we're using (ie
- * Pentium 4MB enable and PPro Global page
- * enable), so that any CPU's that boot up
- * after us can get the correct flags.
- */
 unsigned long mmu_cr4_features __initdata = 0;
 
-static inline void set_in_cr4(unsigned long mask)
-{
-	mmu_cr4_features |= mask;
-	__asm__("movl %%cr4,%%eax\n\t"
-		"orl %0,%%eax\n\t"
-		"movl %%eax,%%cr4\n"
-		: : "irg" (mask)
-		:"ax");
-}
 
 /*
  * allocate page table(s) for compile-time fixed mappings
diff -urN --exclude-from=/home/davej/.exclude linux/include/asm-i386/processor.h linux-dj/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Sun Mar 25 17:37:39 2001
+++ linux-dj/include/asm-i386/processor.h	Tue Nov  6 13:26:38 2001
@@ -74,7 +74,7 @@
 #define X86_FEATURE_CMOV	0x00008000	/* CMOV instruction (FCMOVCC and FCOMI too if FPU present) */
 #define X86_FEATURE_PAT	0x00010000	/* Page Attribute Table */
 #define X86_FEATURE_PSE36	0x00020000	/* 36-bit PSEs */
-#define X86_FEATURE_18		0x00040000
+#define X86_FEATURE_PN		0x00040000	/* Processor serial number */
 #define X86_FEATURE_19		0x00080000
 #define X86_FEATURE_20		0x00100000
 #define X86_FEATURE_21		0x00200000
@@ -106,6 +106,27 @@
 extern void dodgy_tsc(void);
 
 /*
+ * EFLAGS bits
+ */
+#define X86_EFLAGS_CF   0x00000001 /* Carry Flag */
+#define X86_EFLAGS_PF   0x00000004 /* Parity Flag */
+#define X86_EFLAGS_AF   0x00000010 /* Auxillary carry Flag */
+#define X86_EFLAGS_ZF   0x00000040 /* Zero Flag */
+#define X86_EFLAGS_SF   0x00000080 /* Sign Flag */
+#define X86_EFLAGS_TF   0x00000100 /* Trap Flag */
+#define X86_EFLAGS_IF   0x00000200 /* Interrupt Flag */
+#define X86_EFLAGS_DF   0x00000400 /* Direction Flag */
+#define X86_EFLAGS_OF   0x00000800 /* Overflow Flag */
+#define X86_EFLAGS_IOPL 0x00003000 /* IOPL mask */
+#define X86_EFLAGS_NT   0x00004000 /* Nested Task */
+#define X86_EFLAGS_RF   0x00010000 /* Resume Flag */
+#define X86_EFLAGS_VM   0x00020000 /* Virtual Mode */
+#define X86_EFLAGS_AC   0x00040000 /* Alignment Check */
+#define X86_EFLAGS_VIF  0x00080000 /* Virtual Interrupt Flag */
+#define X86_EFLAGS_VIP  0x00100000 /* Virtual Interrupt Pending */
+#define X86_EFLAGS_ID   0x00200000 /* CPUID detection flag */
+
+/*
  *	Generic CPUID function
  */
 extern inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
@@ -120,6 +141,47 @@
 }
 
 /*
+ *  * CPUID functions returning a single datum
+ *   */
+extern inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
+		: "a" (op));
+	return eax;
+}
+
+extern inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
+		: "a" (op));
+	return ebx;
+}
+extern inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
+		: "a" (op));
+	return ecx;
+}
+extern inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__asm__("cpuid"
+		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
+		: "a" (op));
+	return edx;
+}
+
+/*
  *      Cyrix CPU configuration register indexes
  */
 #define CX86_CCR0 0xc0
@@ -129,6 +191,7 @@
 #define CX86_CCR4 0xe8
 #define CX86_CCR5 0xe9
 #define CX86_CCR6 0xea
+#define CX86_CCR7 0xeb
 #define CX86_DIR0 0xfe
 #define CX86_DIR1 0xff
 #define CX86_ARR_BASE 0xc4
@@ -144,6 +207,39 @@
 	outb((reg), 0x22); \
 	outb((data), 0x23); \
 } while (0)
+
+/*
+ *  * Intel CPU features in CR4
+ *   */
+#define X86_CR4_VME     0x0001  /* enable vm86 extensions */
+#define X86_CR4_PVI     0x0002  /* virtual interrupts flag enable */
+#define X86_CR4_TSD     0x0004  /* disable time stamp at ipl 3 */
+#define X86_CR4_DE      0x0008  /* enable debugging extensions */
+#define X86_CR4_PSE     0x0010  /* enable page size extensions */
+#define X86_CR4_PAE     0x0020  /* enable physical address extensions */
+#define X86_CR4_MCE     0x0040  /* Machine check enable */
+#define X86_CR4_PGE     0x0080  /* enable global pages */
+#define X86_CR4_PCE     0x0100  /* enable performance counters at ipl 3 */
+#define X86_CR4_OSFXSR      0x0200  /* enable fast FPU save and restore */
+#define X86_CR4_OSXMMEXCPT  0x0400  /* enable unmasked SSE exceptions */
+
+/*
+ * Save the cr4 feature set we're using (ie
+ * Pentium 4MB enable and PPro Global page
+ * enable), so that any CPU's that boot up
+ * after us can get the correct flags.
+ */
+extern unsigned long mmu_cr4_features;
+
+static inline void set_in_cr4 (unsigned long mask)
+{
+	mmu_cr4_features |= mask;
+	__asm__("movl %%cr4,%%eax\n\t"
+		"orl %0,%%eax\n\t"
+		"movl %%eax,%%cr4\n"
+		: : "irg" (mask)
+		:"ax"); 
+}
 
 /*
  * Bus types (default is ISA, but people can check others with these..)

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
