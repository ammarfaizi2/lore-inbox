Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTDXO0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDXO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:26:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47359 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263732AbTDXO0n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:26:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Date: Thu, 24 Apr 2003 09:23:15 -0500
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
References: <200304240843.h3O8h4902765@owlet.beaverton.ibm.com>
In-Reply-To: <200304240843.h3O8h4902765@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304240923.18754.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, I am getting an oops on boot with the A9 version in wake_up_cpu:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c011910f
*pde = 00104001
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011910f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: f23f4d40   ecx: 00000000   edx: 424614f0
esi: c03f8f80   edi: c03f9938   ebp: f2d87f2c   esp: f2d87f0c
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000000 00000000 00000001 00000000 f23f4d40 c03f8f80 c03f9938
       f2d87f78 c01195e1 c03f8f80 c03f9938 f23f5330 f2d87f58 f2d8d628 00000000
       c03f8f80 00000002 00000000 00000086 00000020 f23f5330 f2d8d330 c0396fc0
Call Trace: [<c01195e1>]  [<c011af50>]  [<c011b025>]  [<c011c5aa>]  
[<c010a9ba>]
  [<c011c300>]  [<c0108b25>]
code: 8b 41 04 ba 03 00 00 00 8b 58 08 c1 eb 10 83 e3 01 f0 0f ab

>>EIP; c011910f <wake_up_cpu+3f/310>   <=====
Trace; c01195e1 <try_to_wake_up+201/310>
Trace; c011af50 <__wake_up_common+40/60>
Trace; c011b025 <complete+25/40>
Trace; c011c5aa <migration_task+2aa/2b0>
Trace; c010a9ba <work_resched+5/16>
Trace; c011c300 <migration_task+0/2b0>
Trace; c0108b25 <kernel_thread_helper+5/10>
Code;  c011910f <wake_up_cpu+3f/310>
00000000 <_EIP>:
Code;  c011910f <wake_up_cpu+3f/310>   <=====
   0:   8b 41 04                  mov    0x4(%ecx),%eax   <=====
Code;  c0119112 <wake_up_cpu+42/310>
   3:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c0119117 <wake_up_cpu+47/310>
   8:   8b 58 08                  mov    0x8(%eax),%ebx
Code;  c011911a <wake_up_cpu+4a/310>
   b:   c1 eb 10                  shr    $0x10,%ebx
Code;  c011911d <wake_up_cpu+4d/310>
   e:   83 e3 01                  and    $0x1,%ebx
Code;  c0119120 <wake_up_cpu+50/310>
  11:   f0 0f ab 00               lock bts %eax,(%eax)


One thing to note, I am using a patch to skip cpus on boot by specifying their 
apicid.  I have used this patch without any problems for quite a while, but 
for some reason with the HT patch I get the oops.  I am using this patch so I 
can boot only the processors in the first node on an x440:

boot param used: skip_apicids=32,33,34,35,48,49,50,51
(all of the apicids in the 2nd node)

patch:
diff -Naur linux-2.5.65/arch/i386/kernel/smpboot.c 
linux-2.5.65-skip-apic/arch/i386/kernel/smpboot.c
--- linux-2.5.65/arch/i386/kernel/smpboot.c	Mon Mar 17 13:44:05 2003
+++ linux-2.5.65-skip-apic/arch/i386/kernel/smpboot.c	Fri Mar 21 09:04:03 2003
@@ -82,6 +82,10 @@
 extern unsigned char trampoline_end  [];
 static unsigned char *trampoline_base;
 
+/* used to selectively not boot certain CPUs with apicids */
+extern int skip_apic_ids[NR_CPUS];
+
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -939,6 +943,16 @@
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
+static int skip_this_apicid(int apicid)
+{
+	int i;
+
+	for (i = 1; i < (skip_apic_ids[0] + 1); i++) 
+		if (apicid == skip_apic_ids[i]) 
+			return 1;
+	return 0;
+}
+
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
@@ -1036,6 +1050,8 @@
 			continue;
 		if (max_cpus <= cpucount+1)
 			continue;
+		if (skip_this_apicid(apicid))
+			continue;
 
 		if (do_boot_cpu(apicid))
 			printk("CPU #%d not responding - cannot use it.\n",
diff -Naur linux-2.5.65/init/main.c linux-2.5.65-skip-apic/init/main.c
--- linux-2.5.65/init/main.c	Mon Mar 17 13:43:44 2003
+++ linux-2.5.65-skip-apic/init/main.c	Fri Mar 21 09:04:18 2003
@@ -113,6 +113,8 @@
 
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
+/* Don't boot apicids in this list */
+int skip_apic_ids[NR_CPUS];
 
 /*
  * Setup routine for controlling SMP activation
@@ -140,6 +142,18 @@
 
 __setup("maxcpus=", maxcpus);
 
+static int __init skip_apicids(char *str)
+{
+	int i;
+
+	get_options(str, NR_CPUS, skip_apic_ids);
+	for (i = 1; i < (skip_apic_ids[0]+1); i++)
+		printk( "CPU with apicid %i will not be booted\n", skip_apic_ids[i]);
+	return 1;
+}
+
+__setup("skip_apicids=", skip_apicids);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 

