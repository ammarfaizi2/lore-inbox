Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSEEQlK>; Sun, 5 May 2002 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSEEQlJ>; Sun, 5 May 2002 12:41:09 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38107 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S313183AbSEEQlG>; Sun, 5 May 2002 12:41:06 -0400
Message-ID: <3CD55FF0.2030909@didntduck.org>
Date: Sun, 05 May 2002 12:38:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org> <3CD4B042.A4355FD3@zip.com.au>
Content-Type: multipart/mixed;
 boundary="------------050306000007050207020307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050306000007050207020307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Brian Gerst wrote:
> 
>>These patches convert some of the existing arrays based on NR_CPUS to
>>use the new per cpu code.
>>
> 
> 
> Brian, I tested this patch (rediffed against 2.5.13, below)
> on the quad Xeon and it failed.
> 
> The machine died when bringing up the secondary CPUs
> ("CPU#3 already started!" and "Unable to handle kernel...")
> 
> I backed out the sched.c part and the machine booted.  So
> I guess the secondary CPU bringup code uses the scheduler
> somehow.
> 
> And again, the numbers in /proc/meminfo are whacko:
> 
> LowFree:         94724 kB
> SwapTotal:     4000040 kB
> SwapFree:      3999700 kB
> Dirty:            7232 kB
> Writeback:    4294967264 kB
> 
> Which never happens with the open-coded per-cpu accumulators.
> After a normal boot I see:
> 
> LowFree:         95804 kB
> SwapTotal:     4000040 kB
> SwapFree:      3999940 kB
> Dirty:            1356 kB
> Writeback:           0 kB
> 
> 
> Now, it may be that some pages are being marked dirty before
> the per-cpu areas are set up, but there's no way in which
> any pages will have been marked for writeback by that time, so
> that "-32" value is definitely wrong.
> 
> 'fraid I have to do a whine-and-run on this problem, but
> it does still appear that there is something fishy with
> the percpu infrastructure.
>

Andrew, could you try this patch?  I suspect something in setup_arch() 
is touching the per cpu area before it gets copied for the other cpus. 
This patch makes certain the boot cpu area is setup ASAP.
-- 

						Brian Gerst

--------------050306000007050207020307
Content-Type: text/plain;
 name="percpu-boot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-boot"

diff -urN linux-2.5.13/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
--- linux-2.5.13/arch/i386/vmlinux.lds	Thu Mar  7 21:18:16 2002
+++ linux/arch/i386/vmlinux.lds	Sun May  5 11:46:26 2002
@@ -57,10 +57,13 @@
 	*(.initcall7.init)
   }
   __initcall_end = .;
+
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
+  . = ALIGN(32);
   __per_cpu_end = .;
+
   . = ALIGN(4096);
   __init_end = .;
 
@@ -70,6 +73,10 @@
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
+  . = ALIGN(32);
+  __cpu0_data = .;
+  .data.cpu0 : { . += SIZEOF(.data.percpu); }
+
   __bss_start = .;		/* BSS */
   .bss : {
 	*(.bss)
diff -urN linux-2.5.13/init/main.c linux/init/main.c
--- linux-2.5.13/init/main.c	Wed May  1 08:40:14 2002
+++ linux/init/main.c	Sun May  5 12:27:38 2002
@@ -272,28 +272,40 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_boot_cpu_area(void) { }
 static inline void setup_per_cpu_areas(void) { }
 
 #else
 
 #ifdef __GENERIC_PER_CPU
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[], __cpu0_data[];
 unsigned long __per_cpu_offset[NR_CPUS];
 
+static void __init setup_boot_cpu_area(void)
+{
+	unsigned long size;
+
+	size = __per_cpu_end - __per_cpu_start;
+	if (!size)
+		return;
+	__per_cpu_offset[0] = __cpu0_data - __per_cpu_start;
+	memcpy(__cpu0_data, __per_cpu_start, size);
+}
+
 static void __init setup_per_cpu_areas(void)
 {
 	unsigned long size, i;
 	char *ptr;
-	/* Created by linker magic */
-	extern char __per_cpu_start[], __per_cpu_end[];
 
 	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	size = __per_cpu_end - __per_cpu_start;
 	if (!size)
 		return;
 
 	ptr = alloc_bootmem(size * NR_CPUS);
 
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+	for (i = 1; i < NR_CPUS; i++, ptr += size) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, size);
 	}
@@ -340,6 +352,7 @@
  * enable them
  */
 	lock_kernel();
+	setup_boot_cpu_area();
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();

--------------050306000007050207020307--

