Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317519AbSFRR1n>; Tue, 18 Jun 2002 13:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSFRR1m>; Tue, 18 Jun 2002 13:27:42 -0400
Received: from amdext.amd.com ([139.95.251.1]:44736 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S317519AbSFRR1k>;
	Tue, 18 Jun 2002 13:27:40 -0400
From: richard.brunner@amd.com
X-Server-Uuid: 18a6aeba-11ae-11d5-983c-00508be33d6d
Message-ID: <39073472CFF4D111A5AB00805F9FE4B609BA672A@txexmta9.amd.com>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br
Subject: RE: Cache-attribute conflict bug in the kernel exposed on newer
 A MD Athlon CPUs
Date: Tue, 18 Jun 2002 12:27:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1111B2F5582168-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were some issues with uniprocessor APIC
in the "short-term" patch. Many thanks to Bryan O'Sullivan
for pointing it out and generating the fixed patch.

We are testing it right now. But, so far
things look OK and the change is pretty simple.

-Rich [SW R&D @ AMD]

--- linux/arch/i386/kernel/setup.c-pre10	Sun Jun 16 21:34:48 2002
+++ linux/arch/i386/kernel/setup.c	Sun Jun 16 21:50:53 2002
@@ -71,6 +71,13 @@
  *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
  *  Dave Jones <davej@suse.de>, September, October 2001.
  *
+ *  Short-term fix for a conflicting cache attribute bug in the kernel
+ *  that is exposed by advanced speculative caching on new AMD Athlon
+ *  processors.
+ *  Richard Brunner <richard.brunner@amd.com> and Mark Langsdorf
+ *  <mark.langsdorf@amd.com>, June 2002 
+ *  Adapted to work with uniprocessor APIC by Bryan O'Sullivan
+ *  <bos@serpentine.com>, June 2002.
  */
 
 /*
@@ -170,6 +177,12 @@
 
 int enable_acpi_smp_table;
 
+#if defined(CONFIG_AGP) || defined(CONFIG_AGP_MODULE)
+int disable_adv_spec_cache __initdata = 1;
+#else
+int disable_adv_spec_cache __initdata = 0;
+#endif /* CONFIG_AGP */
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -728,6 +741,41 @@
 } /* setup_memory_region */
 
 
+int __init amd_adv_spec_cache_feature(void)
+{
+	char vendor_id[16];
+	int ident;
+	int family, model;
+ 
+	/* Must have CPUID */
+	if(!have_cpuid_p())
+		goto donthave;
+	if(cpuid_eax(0)<1)
+		goto donthave;
+	
+	/* Must be x86 architecture */
+	cpuid(0, &ident,  
+		(int *)&vendor_id[0],
+		(int *)&vendor_id[8],
+		(int *)&vendor_id[4]);
+
+	if (memcmp(vendor_id, "AuthenticAMD", 12)) 
+	       goto donthave;
+
+	ident = cpuid_eax(1);
+	family = (ident >> 8) & 0xf;
+	model  = (ident >> 4) & 0xf;
+	if (((family == 6)  && (model >= 6)) || (family == 15)) {
+		printk(KERN_INFO "Advanced speculative caching feature present\n");
+		return 1;
+	}
+
+donthave:
+	printk(KERN_INFO "Advanced speculative caching feature not present\n");
+	return 0;
+}
+
+
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
@@ -793,6 +841,17 @@
 		 */
 		else if (!memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
+		/*
+		 * unsafe-gart-alias overrides the short-term fix for a
+		 * conflicting cache attribute bug in the kernel that is
+		 * exposed by advanced speculative caching in newer AMD
+		 * Athlon processors.  Overriding the fix will allow
+		 * higher performance but the kernel bug can cause system
+		 * lock-ups if the system uses an AGP card.  unsafe-gart-alias
+		 * can be turned on for higher performance in servers.
+		 */
+		else if (!memcmp(from, "unsafe-gart-alias", 17))
+			disable_adv_spec_cache = 0;
 nextchar:
 		c = *(from++);
 		if (!c)
@@ -1057,6 +1116,14 @@
 #ifdef CONFIG_SMP
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
+	/*
+	 * short-term fix for a conflicting cache attribute bug in the 
+	 * kernel that is exposed by advanced speculative caching on
+	 * newer AMD Athlon processors.
+	 */
+	if (disable_adv_spec_cache && amd_adv_spec_cache_feature())
+		clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
+
 	paging_init();
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
@@ -1225,6 +1292,31 @@
 	       l2size, ecx & 0xFF);
 }
 
+
+/*=======================================================================
+ * amd_adv_spec_cache_disable
+ * Setting a special MSR big that disables a small part of advanced
+ * speculative caching as part of a short-term fix for a conflicting cache
+ * attribute bug in the kernel that is exposed by advanced speculative
+ * caching in newer AMD Athlon processors.
+ =======================================================================*/
+static void amd_adv_spec_cache_disable(void)
+{
+	printk(KERN_INFO "Disabling advanced speculative caching\n");
+
+	__asm__ __volatile__ (
+		" movl	 $0x9c5a203a,%%edi   \n" /* msr enable */
+		" movl	 $0xc0011022,%%ecx   \n" /* msr addr	 */
+		" rdmsr			     \n" /* get reg val	 */
+		" orl	 $0x00010000,%%eax   \n" /* set bit 16	 */
+		" wrmsr			     \n" /* put it back	 */
+		" xorl	%%edi, %%edi	     \n" /* clear msr enable */
+		: /* no outputs */
+		: /* no inputs, either */
+		: "%eax","%ecx","%edx","%edi" /* clobbered regs */ );
+}
+
+
 /*
  *	B step AMD K6 before B 9730xxxx have hardware bugs that can cause
  *	misexecution of code under Linux. Owners of such processors should
@@ -1358,10 +1450,21 @@
  			 * to enable SSE on Palomino/Morgan CPU's.
 			 * If the BIOS didn't enable it already, enable it
 			 * here.
+			 *
+			 * Avoiding the use of 4MB/2MB pages along with
+			 * setting a special MSR bit that disables a small
+			 * part of advanced speculative caching as part of a
+			 * short-term fix for a conflicting cache attribute
+			 * bug in the kernel that is exposed by advanced
+			 * speculative caching in newer AMD Atlon processors.
+			 *
+			 * If we cleared the PSE bit earlier as part
+			 * of the workaround for this problem, we need
+			 * to clear it again, as our caller may have
+			 * clobbered it if uniprocessor APIC is enabled.
 			 */
-			if (c->x86_model == 6 || c->x86_model == 7) {
-				if (!test_bit(X86_FEATURE_XMM,
-					      &c->x86_capability)) {
+			if (c->x86_model >= 6) {
+				if (!cpu_has_xmm) {
 					printk(KERN_INFO
 					       "Enabling Disabled K7/SSE Support...\n");
 					rdmsr(MSR_K7_HWCR, l, h);
@@ -1370,6 +1473,18 @@
 					set_bit(X86_FEATURE_XMM,
                                                 &c->x86_capability);
 				}
+				if (disable_adv_spec_cache &&
+				    amd_adv_spec_cache_feature()) {
+					clear_bit(X86_FEATURE_PSE,
+						  &c->x86_capability);
+					amd_adv_spec_cache_disable();
+				}
+			}
+			break;
+		case 15: 
+			if (disable_adv_spec_cache && amd_adv_spec_cache_feature()) {
+				clear_bit(X86_FEATURE_PSE, &c->x86_capability);
+				amd_adv_spec_cache_disable();
 			}
 			break;
 
@@ -2634,6 +2749,12 @@
 			      &c->x86_capability[0]);
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
+			if ( (c->x86_vendor == X86_VENDOR_AMD) &&
+				(c->x86 == 0xf)) {
+				/* AMD Extended Family and Model Values */
+				c->x86 += (tfms >> 20) & 0xff;
+				c->x86_model += (tfms >> 12) & 0xf0;
+			}
 			c->x86_mask = tfms & 15;
 		} else {
 			/* Have CPUID level 0 only - unheard of */

