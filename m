Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318872AbSG1A5h>; Sat, 27 Jul 2002 20:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSG1A5h>; Sat, 27 Jul 2002 20:57:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19974 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S318872AbSG1A5f>; Sat, 27 Jul 2002 20:57:35 -0400
Subject: PATCH: 2.5.29 Fix pnpbios
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 28 Jul 2002 01:47:30 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17YcDa-0002Mf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should do the trick for pnpbios - we load the initial gdt into each
gdt, and we load the parameters into the gdt of the cpu making the call 
relying on the spinlock to avoid bouncing cpu due to pre-empt

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux-2.5.29/drivers/pnp/pnpbios_core.c linux-2.5.29-ac1/drivers/pnp/pnpbios_core.c
--- linux-2.5.29/drivers/pnp/pnpbios_core.c	2002-07-20 20:11:06.000000000 +0100
+++ linux-2.5.29-ac1/drivers/pnp/pnpbios_core.c	2002-07-28 00:35:17.000000000 +0100
@@ -124,13 +124,13 @@
 	".previous		\n"
 );
 
-#define Q_SET_SEL(selname, address, size) \
-set_base (gdt [(selname) >> 3], __va((u32)(address))); \
-set_limit (gdt [(selname) >> 3], size)
-
-#define Q2_SET_SEL(selname, address, size) \
-set_base (gdt [(selname) >> 3], (u32)(address)); \
-set_limit (gdt [(selname) >> 3], size)
+#define Q_SET_SEL(cpu, selname, address, size) \
+set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
+_set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+
+#define Q2_SET_SEL(cpu, selname, address, size) \
+set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
+_set_limit((char *)&cpu_gdt_table[cpu][(selname) >> 3], size)
 
 /*
  * At some point we want to use this stack frame pointer to unwind
@@ -161,10 +161,11 @@
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 
+	/* The lock prevents us bouncing CPU here */
 	if (ts1_size)
-		Q2_SET_SEL(PNP_TS1, ts1_base, ts1_size);
+		Q2_SET_SEL(smp_processor_id(), PNP_TS1, ts1_base, ts1_size);
 	if (ts2_size)
-		Q2_SET_SEL(PNP_TS2, ts2_base, ts2_size);
+		Q2_SET_SEL(smp_processor_id(), PNP_TS2, ts2_base, ts2_size);
 
 	__asm__ __volatile__(
 	        "pushl %%ebp\n\t"
@@ -1265,12 +1266,16 @@
                        check->fields.version >> 4, check->fields.version & 15,
 		       check->fields.pm16cseg, check->fields.pm16offset,
 		       check->fields.pm16dseg);
-		Q2_SET_SEL(PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-		Q_SET_SEL(PNP_CS16, check->fields.pm16cseg, 64 * 1024);
-		Q_SET_SEL(PNP_DS, check->fields.pm16dseg, 64 * 1024);
 		pnp_bios_callpoint.offset = check->fields.pm16offset;
 		pnp_bios_callpoint.segment = PNP_CS16;
 		pnp_bios_hdr = check;
+
+		for(i=0; i < NR_CPUS; i++)
+		{
+			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
+			Q_SET_SEL(i, PNP_CS16, check->fields.pm16cseg, 64 * 1024);
+			Q_SET_SEL(i, PNP_DS, check->fields.pm16dseg, 64 * 1024);
+		}
 		break;
 	}
 	if (!pnp_bios_present())
