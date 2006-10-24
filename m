Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWJXNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWJXNnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJXNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:43:40 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:37244 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S965138AbWJXNnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:43:39 -0400
Message-ID: <453E1886.8010608@qumranet.com>
Date: Tue, 24 Oct 2006 15:43:34 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Extract segment descriptor definitions for use outside
 of x86_64
References: <453CC390.9080508@qumranet.com> <200610232235.29287.arnd@arndb.de> <453E0108.3080502@qumranet.com> <200610232219.46369.ak@suse.de>
In-Reply-To: <200610232219.46369.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 13:43:38.0924 (UTC) FILETIME=[69289EC0:01C6F772]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code that wants to use struct desc_struct cannot do so on i386 because
desc.h contains other code that will only compile on x86_64.

So extract the structure definitions into a asm-x86_64/desc_defs.h.

Signed-off-by: Avi Kivity <avi@qumranet.com>

 include/asm-x86_64/desc.h      |   53 +------------------------------
 include/asm-x86_64/desc_defs.h |   69 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/include/asm-x86_64/desc.h b/include/asm-x86_64/desc.h
index eb7723a..913d6ac 100644
--- a/include/asm-x86_64/desc.h
+++ b/include/asm-x86_64/desc.h
@@ -9,64 +9,13 @@ #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
 #include <linux/smp.h>
+#include <asm/desc_defs.h>
 
 #include <asm/segment.h>
 #include <asm/mmu.h>
 
-// 8 byte segment descriptor
-struct desc_struct { 
-	u16 limit0;
-	u16 base0;
-	unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
-	unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 : 8;
-} __attribute__((packed)); 
-
-struct n_desc_struct { 
-	unsigned int a,b;
-}; 	
-
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 
-enum { 
-	GATE_INTERRUPT = 0xE, 
-	GATE_TRAP = 0xF, 	
-	GATE_CALL = 0xC,
-}; 	
-
-// 16byte gate
-struct gate_struct {          
-	u16 offset_low;
-	u16 segment; 
-	unsigned ist : 3, zero0 : 5, type : 5, dpl : 2, p : 1;
-	u16 offset_middle;
-	u32 offset_high;
-	u32 zero1; 
-} __attribute__((packed));
-
-#define PTR_LOW(x) ((unsigned long)(x) & 0xFFFF) 
-#define PTR_MIDDLE(x) (((unsigned long)(x) >> 16) & 0xFFFF)
-#define PTR_HIGH(x) ((unsigned long)(x) >> 32)
-
-enum { 
-	DESC_TSS = 0x9,
-	DESC_LDT = 0x2,
-}; 
-
-// LDT or TSS descriptor in the GDT. 16 bytes.
-struct ldttss_desc { 
-	u16 limit0;
-	u16 base0;
-	unsigned base1 : 8, type : 5, dpl : 2, p : 1;
-	unsigned limit1 : 4, zero0 : 3, g : 1, base2 : 8;
-	u32 base3;
-	u32 zero1; 
-} __attribute__((packed)); 
-
-struct desc_ptr {
-	unsigned short size;
-	unsigned long address;
-} __attribute__((packed)) ;
-
 #define load_TR_desc() asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() asm volatile("lldt %w0"::"r" (GDT_ENTRY_LDT*8))
 #define clear_LDT()  asm volatile("lldt %w0"::"r" (0))
diff --git a/include/asm-x86_64/desc_defs.h b/include/asm-x86_64/desc_defs.h
new file mode 100644
index 0000000..7408266
--- /dev/null
+++ b/include/asm-x86_64/desc_defs.h
@@ -0,0 +1,69 @@
+/* Written 2000 by Andi Kleen */ 
+#ifndef __ARCH_DESC_DEFS_H
+#define __ARCH_DESC_DEFS_H
+
+/*
+ * Segment descriptor structure definitions, usable from both x86_64 and i386
+ * archs.
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+// 8 byte segment descriptor
+struct desc_struct { 
+	u16 limit0;
+	u16 base0;
+	unsigned base1 : 8, type : 4, s : 1, dpl : 2, p : 1;
+	unsigned limit : 4, avl : 1, l : 1, d : 1, g : 1, base2 : 8;
+} __attribute__((packed)); 
+
+struct n_desc_struct { 
+	unsigned int a,b;
+}; 	
+
+enum { 
+	GATE_INTERRUPT = 0xE, 
+	GATE_TRAP = 0xF, 	
+	GATE_CALL = 0xC,
+}; 	
+
+// 16byte gate
+struct gate_struct {          
+	u16 offset_low;
+	u16 segment; 
+	unsigned ist : 3, zero0 : 5, type : 5, dpl : 2, p : 1;
+	u16 offset_middle;
+	u32 offset_high;
+	u32 zero1; 
+} __attribute__((packed));
+
+#define PTR_LOW(x) ((unsigned long)(x) & 0xFFFF) 
+#define PTR_MIDDLE(x) (((unsigned long)(x) >> 16) & 0xFFFF)
+#define PTR_HIGH(x) ((unsigned long)(x) >> 32)
+
+enum { 
+	DESC_TSS = 0x9,
+	DESC_LDT = 0x2,
+}; 
+
+// LDT or TSS descriptor in the GDT. 16 bytes.
+struct ldttss_desc { 
+	u16 limit0;
+	u16 base0;
+	unsigned base1 : 8, type : 5, dpl : 2, p : 1;
+	unsigned limit1 : 4, zero0 : 3, g : 1, base2 : 8;
+	u32 base3;
+	u32 zero1; 
+} __attribute__((packed)); 
+
+struct desc_ptr {
+	unsigned short size;
+	unsigned long address;
+} __attribute__((packed)) ;
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif



-- 
error compiling committee.c: too many arguments to function

