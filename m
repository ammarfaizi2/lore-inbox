Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319218AbSHNGCh>; Wed, 14 Aug 2002 02:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSHNGCh>; Wed, 14 Aug 2002 02:02:37 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:61094 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S319218AbSHNGC3>;
	Wed, 14 Aug 2002 02:02:29 -0400
Date: Wed, 14 Aug 2002 16:05:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][2.5.31-BK] apm post TLS cleanup
Message-Id: <20020814160505.0dfa1202.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This just makes the apm driver a bit nicer given Alan's liking
for APM on SMP ...

This applies after Ingo's patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.31-1.503/arch/i386/kernel/apm.c 2.5.31-1.503-apm.1/arch/i386/kernel/apm.c
--- 2.5.31-1.503/arch/i386/kernel/apm.c	2002-08-14 15:37:51.000000000 +1000
+++ 2.5.31-1.503-apm.1/arch/i386/kernel/apm.c	2002-08-14 15:45:42.000000000 +1000
@@ -571,9 +571,10 @@
 {
 	APM_DECL_SEGS
 	unsigned long		flags;
-	int			cpu = smp_processor_id();
+	int			cpu;
 	struct desc_struct	save_desc_40;
 
+	cpu = get_cpu();
 	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
 	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 
@@ -599,6 +600,7 @@
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
 	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	put_cpu();
 	return *eax & 0xff;
 }
 
@@ -618,12 +620,13 @@
 
 static u8 apm_bios_call_simple(u32 func, u32 ebx_in, u32 ecx_in, u32 *eax)
 {
-	u8		error;
+	u8			error;
 	APM_DECL_SEGS
-	unsigned long	flags;
-	int			cpu = smp_processor_id();
+	unsigned long		flags;
+	int			cpu;
 	struct desc_struct	save_desc_40;
 
+	cpu = get_cpu();
 	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
 	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
 
@@ -653,6 +656,7 @@
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
 	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
+	put_cpu();
 	return error;
 }
 
@@ -1937,9 +1941,6 @@
 	 * that extends up to the end of page zero (that we have reserved).
 	 * This is for buggy BIOS's that refer to (real mode) segment 0x40
 	 * even though they are called in protected mode.
-	 *
-	 * NOTE: on SMP we call into the APM BIOS only on CPU#0, so it's
-	 * enough to modify CPU#0's GDT.
 	 */
 	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
 	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
