Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317732AbSFLQYU>; Wed, 12 Jun 2002 12:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317735AbSFLQYT>; Wed, 12 Jun 2002 12:24:19 -0400
Received: from amdext2.amd.com ([163.181.251.1]:46056 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S317732AbSFLQYR>;
	Wed, 12 Jun 2002 12:24:17 -0400
From: richard.brunner@amd.com
X-Server-Uuid: 18a6aeba-11ae-11d5-983c-00508be33d6d
Message-ID: <39073472CFF4D111A5AB00805F9FE4B609BA66B8@txexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Cache-attribute conflict bug in the kernel exposed on newer
 . ..
Date: Wed, 12 Jun 2002 11:24:10 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1119AA2653565-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the short-term patch we have been testing.
In our testing so far across multiple cards and systems, 
it appears to remove the failures. As I said before, 
it theoretically leaves a small hole open
that we have not seen exploited in practice after much testing.

My gut feeling is that distributions looking to release a fix
very soon will be well served by the short-term patch.

Meanwhile, the community can hammer[1] out any lingering 
issues with the long-term solution -- which the distributions can
choose to pick up on their next update.


[1] Why is it every time some one from AMD uses the verb "to hammer", 
    we have to say "no pun intended" ? ;-)

-Rich ...
[richard.brunner@amd.com    -- (360)-867-0654]
[Senior Member, Technical Staff, SW R&D @ AMD]


--- linux/arch/i386/kernel/setup.c      Fri Jun  7 12:46:23 2002
+++ linux-2.4.19pre9work/arch/i386/kernel/setup.c       Mon Jun 10 18:08:56 2002
@@ -71,6 +71,11 @@
  *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
  *  Dave Jones <davej@suse.de>, September, October 2001.
  *
+ *  Short-term fix for a conflicting cache attribute bug in the kernel
+ *  that is exposed by advanced speculative caching on new AMD Athlon
+ *  processors.
+ *  Richard Brunner <richard.brunner@amd.com> and Mark Langsdorf
+ *  <mark.langsdorf@amd.com>, June 2002 
  */
 
 /*
@@ -169,7 +174,11 @@
 static int disable_x86_ht __initdata = 0;
 
 int enable_acpi_smp_table;
-
+#ifdef CONFIG_AGP
+int disable_adv_spec_cache __initdata = 1;
+#else
+int disable_adv_spec_cache __initdata = 0;
+#endif /* CONFIG_AGP */
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -727,6 +736,36 @@
        print_memory_map(who);
 } /* setup_memory_region */
 
+int __init amd_adv_spec_cache_feature(void)
+{
+        char vendor_id[16];
+        int ident;
+        int family, model;
+ 
+        /* Must have CPUID */
+        if(!have_cpuid_p())
+                return 0;
+        if(cpuid_eax(0)<1)
+                return 0;
+        
+        /* Must be x86 architecture */
+        cpuid(0, &ident,  
+                (int *)&vendor_id[0],
+                (int *)&vendor_id[8],
+                (int *)&vendor_id[4]);
+
+        if (memcmp(vendor_id, "AuthenticAMD", 12)) 
+               return 0;
+
+        ident = cpuid_eax(1);
+        family = (ident >> 8) & 0xf;
+        model  = (ident >> 4) & 0xf;
+        if (((family == 6)  && (model >= 6)) || (family == 15))
+               /* Feature present */
+               return 1;
+
+        return 0;
+}
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
@@ -793,6 +832,17 @@
                 */
                else if (!memcmp(from, "highmem=", 8))
                        highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
+               /*
+                * unsafe-gart-alias overrides the short-term fix for a
+                * conflicting cache attribute bug in the kernel that is
+                * exposed by advanced speculative caching in newer AMD
+                * Athlon processors.  Overriding the fix will allow
+                * higher performance but the kernel bug can cause system
+                * lock-ups if the system uses an AGP card.  unsafe-gart-alias
+                * can be turned on for higher performance in servers.
+                */
+               else if (!memcmp(from, "unsafe-gart-alias", 17))
+                       disable_adv_spec_cache = 0;
 nextchar:
                c = *(from++);
                if (!c)
@@ -1057,6 +1107,14 @@
 #ifdef CONFIG_SMP
        smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
+       /*
+        * short-term fix for a conflicting cache attribute bug in the 
+        * kernel that is exposed by advanced speculative caching on
+        * newer AMD Athlon processors.
+        */
+       if (disable_adv_spec_cache && amd_adv_spec_cache_feature() )
+               clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
+
        paging_init();
 #ifdef CONFIG_X86_LOCAL_APIC
        /*
@@ -1225,6 +1283,27 @@
               l2size, ecx & 0xFF);
 }
 
+/*=======================================================================
+ * amd_adv_spec_cache_disable
+ * Setting a special MSR bit that disables a small part of advanced
+ * speculative caching as part of a short-term fix for a conflicting cache
+ * attribute bug in the kernel that is exposed by advanced speculative
+ * caching in newer AMD Athlon processors.
+ =======================================================================*/
+static void amd_adv_spec_cache_disable(void)
+{
+         __asm__ __volatile__ (
+                " movl   $0x9c5a203a,%%edi   \n" /* msr enable */
+                " movl   $0xc0011022,%%ecx   \n" /* msr addr     */
+                " rdmsr                      \n" /* get reg val  */
+                " orl    $0x00010000,%%eax   \n" /* set bit 16   */
+                " wrmsr                      \n" /* put it back  */
+                " xorl  %%edi, %%edi         \n" /* clear msr enable */
+                : /* no outputs */
+                : /* no inputs, either */
+                : "%eax","%ecx","%edx","%edi" /* clobbered regs */ );
+}
+
 /*
  *     B step AMD K6 before B 9730xxxx have hardware bugs that can cause
  *     misexecution of code under Linux. Owners of such processors should
@@ -1353,13 +1432,19 @@
                        break;
 
                case 6: /* An Athlon/Duron */
- 
                        /* Bit 15 of Athlon specific MSR 15, needs to be 0
                         * to enable SSE on Palomino/Morgan CPU's.
                         * If the BIOS didn't enable it already, enable it
                         * here.
+                        *
+                        * Avoiding the use of 4MB/2MB pages along with
+                        * setting a special MSR bit that disables a small
+                        * part of advanced speculative caching as part of a
+                        * short-term fix for a conflicting cache attribute
+                        * bug in the kernel that is exposed by advanced
+                        * speculative caching in newer AMD Atlon processors.
                         */
-                       if (c->x86_model == 6 || c->x86_model == 7) {
+                       if (c->x86_model >= 6) {
                                if (!test_bit(X86_FEATURE_XMM,
                                              &c->x86_capability)) {
                                        printk(KERN_INFO
@@ -1370,9 +1455,20 @@
                                        set_bit(X86_FEATURE_XMM,
                                                 &c->x86_capability);
                                }
+                               if (!test_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability)) {
+                                       amd_adv_spec_cache_disable();
+                                       printk(KERN_INFO
+                                               "Disabling advanced speculative caching\n");
+                               }
+                       }
+                       break;
+               case 15: 
+                       if (!test_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability)) {
+                               amd_adv_spec_cache_disable();
+                               printk(KERN_INFO "Disabling advanced speculative caching\n");
                        }
                        break;
-
        }
 
        display_cacheinfo(c);
@@ -2634,6 +2730,12 @@
                              &c->x86_capability[0]);
                        c->x86 = (tfms >> 8) & 15;
                        c->x86_model = (tfms >> 4) & 15;
+                       if ( (c->x86_vendor == X86_VENDOR_AMD) &&
+                               (c->x86 == 0xf)) {
+                               /* AMD Extended Family and Model Values */
+                               c->x86 += (tfms >> 20) & 0xff;
+                               c->x86_model += (tfms >> 12) & 0xf0;
+                       }
                        c->x86_mask = tfms & 15;
                } else {
                        /* Have CPUID level 0 only - unheard of */

