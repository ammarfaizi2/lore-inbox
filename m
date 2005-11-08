Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965374AbVKHE1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbVKHE1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbVKHE1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:27:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:55570 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965379AbVKHE1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:27:05 -0500
Date: Mon, 7 Nov 2005 20:27:03 -0800
Message-Id: <200511080427.jA84R3E9009884@zach-dev.vmware.com>
Subject: [PATCH 8/21] i386 Segment protect properly
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:27:03.0195 (UTC) FILETIME=[AB2C46B0:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is impossible to have a zero length segment in descriptor tables using
"normal" segments.  One of many ways to properly protect segments to zero
length is to map the base to an umapped page.  Create a nicer way to do
this, and stop subtracting 1 from the length passed to set_limit (note
calling set limit with a zero limit does something very bad! - not anymore).

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 17:45:02.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:08.000000000 -0800
@@ -158,6 +158,15 @@ static inline unsigned long get_desc_bas
 	return base;
 }
 
+static inline void prepare_protected_segment(int cpu, int gdt_entry, void *base, u32 size)
+{
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+
+	/* Forced zero-length segments to 1-byte access at unmapped page zero */
+	set_base(gdt[gdt_entry], size > 0 ? (u32)base : 0);
+	set_limit(gdt[gdt_entry], size > 0 ? size - 1 : 0);
+}
+
 struct bios_segment_save {
 	struct desc_struct save_desc_40;
 	struct desc_struct *gdt;
Index: linux-2.6.14-zach-work/include/asm-i386/system.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/system.h	2005-11-04 17:18:05.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/system.h	2005-11-05 00:28:10.000000000 -0800
@@ -54,7 +54,7 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
         ); } while(0)
 
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
-#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1) )
+#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , (limit) )
 
 static inline unsigned long _get_base(char * addr)
 {
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 17:45:02.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:08.000000000 -0800
@@ -103,10 +103,8 @@ static inline u16 call_pnp_bios(u16 func
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 
 	/* The lock prevents us bouncing CPU here */
-	if (ts1_size)
-		Q2_SET_SEL(smp_processor_id(), PNP_TS1, ts1_base, ts1_size);
-	if (ts2_size)
-		Q2_SET_SEL(smp_processor_id(), PNP_TS2, ts2_base, ts2_size);
+	prepare_protected_segment(smp_processor_id(), GDT_ENTRY_PNPBIOS_TS1, ts1_base, ts1_size);
+	prepare_protected_segment(smp_processor_id(), GDT_ENTRY_PNPBIOS_TS2, ts2_base, ts2_size);
 
 	__asm__ __volatile__(
 	        "pushl %%ebp\n\t"
