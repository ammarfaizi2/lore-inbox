Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVIHQh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVIHQh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVIHQh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:37:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24730 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbVIHQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:37:58 -0400
Date: Thu, 8 Sep 2005 09:37:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Bob Picco <bob.picco@hp.com>
Subject: [PATCH 2.6.13] x86_64: Make trap_init() happen earlier
Message-ID: <20050908163757.GQ3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It can be handy in some situations to have run trap_init() sooner than the
generic code does.  In order to do this on x86_64 we need to add a custom
early_setup_per_cpu_areas() call as well.

---

 linux-2.6.13-trini/arch/x86_64/kernel/setup.c   |    3 +++
 linux-2.6.13-trini/arch/x86_64/kernel/setup64.c |   16 +++++++++++++++-
 linux-2.6.13-trini/arch/x86_64/kernel/traps.c   |    4 ++++
 linux-2.6.13-trini/include/asm-x86_64/proto.h   |    2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/setup.c~x86_64-early_funcs arch/x86_64/kernel/setup.c
--- linux-2.6.13/arch/x86_64/kernel/setup.c~x86_64-early_funcs	2005-09-01 12:00:44.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/setup.c	2005-09-01 12:00:44.000000000 -0700
@@ -525,6 +525,9 @@ void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
 
+	early_setup_per_cpu_areas();
+	early_trap_init();
+
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
diff -puN arch/x86_64/kernel/setup64.c~x86_64-early_funcs arch/x86_64/kernel/setup64.c
--- linux-2.6.13/arch/x86_64/kernel/setup64.c~x86_64-early_funcs	2005-09-01 12:00:44.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/setup64.c	2005-09-01 12:00:44.000000000 -0700
@@ -77,7 +77,19 @@ static int __init nonx32_setup(char *str
 }
 __setup("noexec32=", nonx32_setup);
 
+void __init early_setup_per_cpu_areas(void)
+{
+	static char cpu0[PERCPU_ENOUGH_ROOM] __cacheline_aligned
+		__attribute__ ((aligned (SMP_CACHE_BYTES)));
+	char *ptr = cpu0;
+
+	cpu_pda[0].data_offset = ptr - __per_cpu_start;
+	memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+}
+
 /*
+ * We run this a bit sooner than the normal code, so provide a dummy
+ * function as well.
  * Great future plan:
  * Declare PDA itself and support (irqstack,tss,pgd) as per cpu data.
  * Always point %gs to its beginning
@@ -97,7 +109,9 @@ void __init setup_per_cpu_areas(void)
 	for (i = 0; i < NR_CPUS; i++) { 
 		char *ptr;
 
-		if (!NODE_DATA(cpu_to_node(i))) {
+		if (cpu_pda[i].data_offset)
+			continue;
+		else if (!NODE_DATA(cpu_to_node(i))) {
 			printk("cpu with no node %d, num_online_nodes %d\n",
 			       i, num_online_nodes());
 			ptr = alloc_bootmem(size);
diff -puN arch/x86_64/kernel/traps.c~x86_64-early_funcs arch/x86_64/kernel/traps.c
--- linux-2.6.13/arch/x86_64/kernel/traps.c~x86_64-early_funcs	2005-09-01 12:00:44.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/kernel/traps.c	2005-09-01 12:00:44.000000000 -0700
@@ -904,6 +904,10 @@ void do_call_debug(struct pt_regs *regs)
 
 void __init trap_init(void)
 {
+}
+
+void __init early_trap_init(void)
+{
 	set_intr_gate(0,&divide_error);
 	set_intr_gate_ist(1,&debug,DEBUG_STACK);
 	set_intr_gate_ist(2,&nmi,NMI_STACK);
diff -puN include/asm-x86_64/proto.h~x86_64-early_funcs include/asm-x86_64/proto.h
--- linux-2.6.13/include/asm-x86_64/proto.h~x86_64-early_funcs	2005-09-01 12:00:44.000000000 -0700
+++ linux-2.6.13-trini/include/asm-x86_64/proto.h	2005-09-01 12:00:44.000000000 -0700
@@ -10,6 +10,8 @@ struct pt_regs;
 
 extern void get_cpu_vendor(struct cpuinfo_x86*);
 extern void start_kernel(void);
+extern void early_trap_init(void);
+extern void early_setup_per_cpu_areas(void);
 extern void pda_init(int); 
 
 extern void early_idt_handler(void);

-- 
Tom Rini
http://gate.crashing.org/~trini/
