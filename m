Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbTAMUBq>; Mon, 13 Jan 2003 15:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTAMUBq>; Mon, 13 Jan 2003 15:01:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:47059 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267526AbTAMUBo> convert rfc822-to-8bit;
	Mon, 13 Jan 2003 15:01:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86 arch
Date: Mon, 13 Jan 2003 12:10:47 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20030113122835.GC2714@in.ibm.com>
In-Reply-To: <20030113122835.GC2714@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131210.47318.akpm@digeo.com>
X-OriginalArrivalTime: 13 Jan 2003 20:10:28.0959 (UTC) FILETIME=[D15BE6F0:01C2BB3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 January 2003 04:28 am, Ravikiran G Thirumalai wrote:
>
> Hi,
> Here's  a patchset to make prof_counter use percpu area infrastructure.
> ...
>  	/* initialize the CPU structures (moved from smp_boot_cpus) */
>  	for(i=0; i<NR_CPUS; i++) {
> -		prof_counter[i] = 1;
> +		per_cpu(prof_counter, i) = 1;

Please always use the cpu_online() test here.

Yes, it's a bit awkward and yes, we should have a for_each_online_cpu()
helper, but that didn't happen.

The reason (apart from increased efficiency) is that at some time we may
make the per-cpu data areas only exist on online CPUs.  We allocate the
area from the CPU's node-local memory when it is coming online.

Code such as the above will oops with that change in place.

We did have all of this running, but I never submitted the patch for reasons
of general scariness and lack of expressed interest from NUMA people.

<dig, dig>

Here it is:



The current per-cpu memory areas are allocated at startup for NR_CPUS,
so we're really not saving much memory from them.

This is a problem for kernel/timer.c (128 kbytes), kernel/sched.c (78
kbytes) and presumably other places.

The patch from Rutsy allocates per-cpu areas only for those CPUs which
may actually exist, before each one comes online.

So the per-cpu storage for not-possible CPUs does not exist, and
accessing them will oops.


 init/main.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

--- 2.5.43/init/main.c~per-cpu-allocation	Fri Oct 18 01:19:56 2002
+++ 2.5.43-akpm/init/main.c	Fri Oct 18 01:22:32 2002
@@ -304,32 +304,39 @@ static void __init smp_init(void)
 #define smp_init()	do { } while (0)
 #endif
 
-static inline void setup_per_cpu_areas(void) { }
+static inline void setup_per_cpu_area(unsigned int cpu) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 
 #else
 
 #ifdef __GENERIC_PER_CPU
+/* Created by linker magic */
+extern char __per_cpu_start[], __per_cpu_end[];
+
 unsigned long __per_cpu_offset[NR_CPUS];
 
-static void __init setup_per_cpu_areas(void)
+/* Sets up per-cpu area for boot CPU. */
+static void __init setup_per_cpu_area(unsigned int cpu)
 {
-	unsigned long size, i;
+	unsigned long size;
 	char *ptr;
-	/* Created by linker magic */
-	extern char __per_cpu_start[], __per_cpu_end[];
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
 	if (!size)
 		return;
 
-	ptr = alloc_bootmem(size * NR_CPUS);
+	/* First CPU happens really early... */
+	if (cpu == smp_processor_id())
+		ptr = alloc_bootmem(size);
+	else
+		ptr = kmalloc(size, GFP_ATOMIC);
 
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
-		__per_cpu_offset[i] = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, size);
-	}
+	if (ptr == NULL)
+		panic("failed to allocate per-cpu area for cpu %d\n", cpu);
+
+	__per_cpu_offset[cpu] = ptr - __per_cpu_start;
+	memcpy(ptr, __per_cpu_start, size);
 }
 #endif /* !__GENERIC_PER_CPU */
 
@@ -338,7 +345,16 @@ static void __init smp_init(void)
 {
 	unsigned int i;
 
-	/* FIXME: This should be done in userspace --RR */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i)) {
+			if (i != smp_processor_id())
+				setup_per_cpu_area(i);
+		} else {
+			/* Force a NULL deref on use */
+			__per_cpu_offset[i] = (char *)0 - __per_cpu_start;
+		}
+	}
+
 	for (i = 0; i < NR_CPUS; i++) {
 		if (num_online_cpus() >= max_cpus)
 			break;
@@ -390,7 +406,7 @@ asmlinkage void __init start_kernel(void
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
-	setup_per_cpu_areas();
+	setup_per_cpu_area(smp_processor_id());
 	build_all_zonelists();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);

.


