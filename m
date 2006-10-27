Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946157AbWJ0Dpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946157AbWJ0Dpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946158AbWJ0Dpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:45:31 -0400
Received: from ozlabs.org ([203.10.76.45]:3501 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946157AbWJ0Dpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:45:30 -0400
Subject: [PATCH 3/4] Prep for paravirt: desc.h clearer parameter names,
	some code motion
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <1161920622.17807.36.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920535.17807.33.camel@localhost.localdomain>
	 <1161920622.17807.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:45:27 +1000
Message-Id: <1161920728.17807.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge's patch to clarify arg names in asm/desc.h

"a" and "b" are better named "low" and "high"; Rusty mixed them up
once with amusing results.  Also change __u32 to u32 while there (this
must be kernel-only code, given the DECLARE_PER_CPU in the file
above).

Also moves set_ldt up higher in header, in preparation for paravirt.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -32,19 +32,19 @@ extern struct desc_struct idt_table[];
 extern struct desc_struct idt_table[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
-static inline void pack_descriptor(__u32 *a, __u32 *b,
+static inline void pack_descriptor(u32 *low, u32 *high,
 	unsigned long base, unsigned long limit, unsigned char type, unsigned char flags)
 {
-	*a = ((base & 0xffff) << 16) | (limit & 0xffff);
-	*b = (base & 0xff000000) | ((base & 0xff0000) >> 16) |
+	*low = ((base & 0xffff) << 16) | (limit & 0xffff);
+	*high = (base & 0xff000000) | ((base & 0xff0000) >> 16) |
 		(limit & 0x000f0000) | ((type & 0xff) << 8) | ((flags & 0xf) << 20);
 }
 
-static inline void pack_gate(__u32 *a, __u32 *b,
+static inline void pack_gate(u32 *low, u32 *high,
 	unsigned long base, unsigned short seg, unsigned char type, unsigned char flags)
 {
-	*a = (seg << 16) | (base & 0xffff);
-	*b = (base & 0xffff0000) | ((type & 0xff) << 8) | (flags & 0xff);
+	*low = (seg << 16) | (base & 0xffff);
+	*high = (base & 0xffff0000) | ((type & 0xff) << 8) | (flags & 0xff);
 }
 
 #define DESCTYPE_LDT 	0x82	/* present, system, DPL-0, LDT */
@@ -78,47 +78,47 @@ static inline void load_TLS(struct threa
 #undef C
 }
 
-static inline void write_dt_entry(void *dt, int entry, __u32 entry_a, __u32 entry_b)
-{
-	__u32 *lp = (__u32 *)((char *)dt + entry*8);
-	*lp = entry_a;
-	*(lp+1) = entry_b;
-}
-
-#define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-#define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-#define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-
-static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
-{
-	__u32 a, b;
-	pack_gate(&a, &b, (unsigned long)addr, seg, type, 0);
-	write_idt_entry(idt_table, gate, a, b);
-}
-
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, const void *addr)
-{
-	__u32 a, b;
-	pack_descriptor(&a, &b, (unsigned long)addr,
-			offsetof(struct tss_struct, __cacheline_filler) - 1,
-			DESCTYPE_TSS, 0);
-	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
-}
-
 static inline void set_ldt(void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
 		__asm__ __volatile__("lldt %w0"::"q" (0));
 	else {
 		unsigned cpu = smp_processor_id();
-		__u32 a, b;
-
-		pack_descriptor(&a, &b, (unsigned long)addr,
+		u32 low, high;
+
+		pack_descriptor(&low, &high, (unsigned long)addr,
 				entries * sizeof(struct desc_struct) - 1,
 				DESCTYPE_LDT, 0);
-		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
+		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);
 		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
 	}
+}
+
+#define write_ldt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_gdt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_idt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+
+static inline void write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
+{
+	u32 *lp = (u32 *)((char *)dt + entry*8);
+	lp[0] = entry_low;
+	lp[1] = entry_high;
+}
+
+static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
+{
+	u32 low, high;
+	pack_gate(&low, &high, (unsigned long)addr, seg, type, 0);
+	write_idt_entry(idt_table, gate, low, high);
+}
+
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, const void *addr)
+{
+	u32 low, high;
+	pack_descriptor(&low, &high, (unsigned long)addr,
+			offsetof(struct tss_struct, __cacheline_filler) - 1,
+			DESCTYPE_TSS, 0);
+	write_gdt_entry(get_cpu_gdt_table(cpu), entry, low, high);
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)


