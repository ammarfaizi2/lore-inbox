Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbTCUTRs>; Fri, 21 Mar 2003 14:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263734AbTCUTQ7>; Fri, 21 Mar 2003 14:16:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43396
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263384AbTCUTPV>; Fri, 21 Mar 2003 14:15:21 -0500
Date: Fri, 21 Mar 2003 20:30:36 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212030.h2LKUa2B026365@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: arch pre/post setup for pc9800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/mach-pc9800/setup_arch_post.h linux-2.5.65-ac2/include/asm-i386/mach-pc9800/setup_arch_post.h
--- linux-2.5.65/include/asm-i386/mach-pc9800/setup_arch_post.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/include/asm-i386/mach-pc9800/setup_arch_post.h	2003-02-14 23:00:56.000000000 +0000
@@ -0,0 +1,29 @@
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+	unsigned long low_mem_size, lower_high, higher_high;
+
+
+	who = "BIOS (common area)";
+
+	low_mem_size = ((*(unsigned char *)__va(PC9800SCA_BIOS_FLAG) & 7) + 1) << 17;
+	add_memory_region(0, low_mem_size, 1);
+	lower_high = (__u32) *(__u8 *) bus_to_virt(PC9800SCA_EXPMMSZ) << 17;
+	higher_high = (__u32) *(__u16 *) bus_to_virt(PC9800SCA_MMSZ16M) << 20;
+	if (lower_high != 0x00f00000UL) {
+		add_memory_region(HIGH_MEMORY, lower_high, 1);
+		add_memory_region(0x01000000UL, higher_high, 1);
+	}
+	else
+		add_memory_region(HIGH_MEMORY, lower_high + higher_high, 1);
+
+	return who;
+}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/mach-pc9800/setup_arch_pre.h linux-2.5.65-ac2/include/asm-i386/mach-pc9800/setup_arch_pre.h
--- linux-2.5.65/include/asm-i386/mach-pc9800/setup_arch_pre.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/include/asm-i386/mach-pc9800/setup_arch_pre.h	2003-03-14 01:21:57.000000000 +0000
@@ -0,0 +1,36 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP arch_setup_pc9800();
+
+#include <linux/timex.h>
+#include <asm/io.h>
+#include <asm/pc9800.h>
+#include <asm/pc9800_sca.h>
+
+int CLOCK_TICK_RATE;
+extern unsigned long tick_usec;	/* ACTHZ          period (usec) */
+extern unsigned long tick_nsec;	/* USER_HZ period (nsec) */
+unsigned char pc9800_misc_flags;
+/* (bit 0) 1:High Address Video ram exists 0:otherwise */
+
+#ifdef CONFIG_SMP
+#define MPC_TABLE_SIZE 512
+#define MPC_TABLE ((char *) (PARAM+0x400))
+char mpc_table[MPC_TABLE_SIZE];
+#endif
+
+static  inline void arch_setup_pc9800(void)
+{
+	CLOCK_TICK_RATE = PC9800_8MHz_P() ? 1996800 : 2457600;
+	printk(KERN_DEBUG "CLOCK_TICK_RATE = %d\n", CLOCK_TICK_RATE);
+	tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
+	tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+
+	pc9800_misc_flags = PC9800_MISC_FLAGS;
+#ifdef CONFIG_SMP
+	if ((*(u32 *)(MPC_TABLE)) == 0x504d4350)
+		memcpy(mpc_table, MPC_TABLE, *(u16 *)(MPC_TABLE + 4));
+#endif /* CONFIG_SMP */
+}
