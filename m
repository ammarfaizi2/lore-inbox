Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGIDaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGIDaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUGIDaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:30:35 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:10157 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S263736AbUGIDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:30:27 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <mort@wildopensource.com>,
       <jes@wildopensource.com>
Subject: RE: [PATCH] PER_CPU [1/4] - PER_CPU-cpu_tlbstate
Date: Thu, 8 Jul 2004 20:30:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040708192127.05c07c65.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlW4wXuWsCl1qQSO2J6l9lTI42RgAB8/zw
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S263736AbUGIDa1/20040709033027Z+66@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Morton" <akpm@osdl.org> wrote:

> This is an `allmodconfig' build, gcc-3.4:
> 
> distcc[19912] ERROR: compile on vmm failed
> arch/i386/mm/fault.c: In function `get_segment_eip':
> arch/i386/mm/fault.c:110: error: `per_cpu__cpu_gdt_table' undeclared

> arch/i386/kernel/ioport.c: In function `sys_ioperm':
> arch/i386/kernel/ioport.c:86: error: `per_cpu__init_tss' undeclared (first
> use in this function)

> arch/i386/kernel/vm86.c: In function `save_v86_state':
> arch/i386/kernel/vm86.c:124: error: `per_cpu__init_tss' undeclared (first
> use in this function)

> arch/i386/kernel/vm86.c: In function `do_sys_vm86':
> arch/i386/kernel/vm86.c:306: error: `per_cpu__init_tss' undeclared (first
> use in this function)

> arch/i386/kernel/process.c: In function `exit_thread':
> arch/i386/kernel/process.c:301: error: `per_cpu__init_tss' undeclared
> (first use in this function)
 
> arch/i386/kernel/process.c: In function `__switch_to':
> arch/i386/kernel/process.c:510: error: `per_cpu__init_tss' undeclared
> (first use in this function)

I'm not getting any of those, using gcc-3.2.2 (just rebuilt it all).  I can
try with 3.4, it might be different.

The fix should be easy, it just missing couple of DECLARE_PER_CPU.  I don't
where this is coming from, and MORE IMPORTANT, how you haven't got these
errors before, since I made sure all replaced all declarations by the patch.

I find out that the following need to be added to PER_CPU-gdt_table, I'll
send updated patch once I find why you getting the errors above.

 arch/i386/kernel/apm.c          |   34 +++++++++++++++++-----------------
 drivers/pnp/pnpbios/bioscalls.c |   14 +++++++-------
 2 files changed, 24 insertions(+), 24 deletions(-)

===== arch/i386/kernel/apm.c 1.63 vs edited =====
--- 1.63/arch/i386/kernel/apm.c	2004-04-19 01:12:13 -07:00
+++ edited/arch/i386/kernel/apm.c	2004-07-08 20:08:03 -07:00
@@ -600,8 +600,8 @@
 	cpus = apm_save_cpus();
 	
 	cpu = get_cpu();
-	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+	save_desc_40 = per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -609,7 +609,7 @@
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	
@@ -643,8 +643,8 @@
 	cpus = apm_save_cpus();
 	
 	cpu = get_cpu();
-	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+	save_desc_40 = per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] = bad_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -652,7 +652,7 @@
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
+	per_cpu(cpu_gdt_table, smp_processor_id())[0x40 / 8] = save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	return error;
@@ -1976,35 +1976,35 @@
 	apm_bios_entry.segment = APM_CS;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		set_base(cpu_gdt_table[i][APM_CS >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(cpu_gdt_table[i][APM_DS >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
 		if (apm_info.bios.version == 0x100) {
 #endif
 			/* For ASUS motherboard, Award BIOS rev 110 (and
others?) */
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],
64 * 1024 - 1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS
>> 3], 64 * 1024 - 1);
 			/* For some unknown machine. */
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >>
3], 64 * 1024 - 1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table,
i)[APM_CS_16 >> 3], 64 * 1024 - 1);
 			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
64 * 1024 - 1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS
>> 3], 64 * 1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
 		} else {
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS
>> 3],
 				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >>
3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table,
i)[APM_CS_16 >> 3],
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS
>> 3],
 				(apm_info.bios.dseg_len - 1) & 0xffff);
 		      /* workaround for broken BIOSes */
 	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
-        	                _set_limit((char *)&cpu_gdt_table[i][APM_CS
>> 3], 64 * 1024 -1);
+        	                _set_limit((char *)&per_cpu(cpu_gdt_table,
i)[APM_CS >> 3], 64 * 1024 -1);
                        if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB
== 64kB */
                         	/* for the BIOS that assumes granularity = 1
*/
-                        	cpu_gdt_table[i][APM_DS >> 3].b |= 0x800000;
+                        	per_cpu(cpu_gdt_table, i)[APM_DS >> 3].b |=
0x800000;
                         	printk(KERN_NOTICE "apm: we set the
granularity of dseg.\n");
         	        }
 		}
===== drivers/pnp/pnpbios/bioscalls.c 1.4 vs edited =====
--- 1.4/drivers/pnp/pnpbios/bioscalls.c	2004-05-22 01:23:01 -07:00
+++ edited/drivers/pnp/pnpbios/bioscalls.c	2004-07-08 20:10:10 -07:00
@@ -69,14 +69,14 @@
 
 #define Q_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], __va((u32)(address)));
\
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
 } while(0)
 
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
 } while(0)
 
 static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
@@ -115,8 +115,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
 	cpu = get_cpu();
-	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+	save_desc_40 = per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = bad_bios_desc;
 
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -158,7 +158,7 @@
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 
-	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] = save_desc_40;
 	put_cpu();
 
 	/* If we get here and this is set then the PnP BIOS faulted on us.
*/




