Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWJQPrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWJQPrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWJQPrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:47:18 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36639
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751154AbWJQPrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:47:17 -0400
Message-Id: <45351782.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 17 Oct 2006 16:48:50 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: UNWIND_INFO slowdown in -mm1
References: <20060928192048.GA17436@elte.hu>
In-Reply-To: <20060928192048.GA17436@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>in 2.6.18-mm1 we are seeing _really_ long delays in the unwind code. 
>(full trace attached) On an Athlon64 3800+ CPU:

Below patch should help, can you try it out? Short of the linker
supporting building a binary lookup table at build time, it creates
one as soon as the bootmem allocator is usable (so you'll continue
using the linear lookup for the first [hopefully] few calls).
The code should be ready to utilize a build-time created table once
a fixed linker becomes available.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc2/Makefile	2006-10-17 17:10:59.000000000 +0200
+++ 2.6.19-rc2-unwind-eh_frame_hdr/Makefile	2006-10-17 08:37:42.000000000 +0200
@@ -499,6 +499,7 @@ endif
 
 ifdef CONFIG_UNWIND_INFO
 CFLAGS		+= -fasynchronous-unwind-tables
+LDFLAGS_vmlinux	+= --eh-frame-hdr
 endif
 
 ifdef CONFIG_DEBUG_INFO
--- linux-2.6.19-rc2/include/asm-generic/vmlinux.lds.h	2006-10-17 17:11:44.000000000 +0200
+++ 2.6.19-rc2-unwind-eh_frame_hdr/include/asm-generic/vmlinux.lds.h	2006-10-17 10:02:44.000000000 +0200
@@ -125,6 +125,10 @@
 		*(__param)						\
 		VMLINUX_SYMBOL(__stop___param) = .;			\
 	}								\
+									\
+	/* Unwind data binary search table */				\
+	EH_FRAME_HDR							\
+									\
 	__end_rodata = .;						\
 	. = ALIGN(4096);
 
@@ -157,6 +161,18 @@
 		*(.kprobes.text)					\
 		VMLINUX_SYMBOL(__kprobes_text_end) = .;
 
+#ifdef CONFIG_STACK_UNWIND
+		/* Unwind data binary search table */
+#define EH_FRAME_HDR							\
+        	.eh_frame_hdr : AT(ADDR(.eh_frame_hdr) - LOAD_OFFSET) {	\
+			VMLINUX_SYMBOL(__start_unwind_hdr) = .;		\
+			*(.eh_frame_hdr)				\
+			VMLINUX_SYMBOL(__end_unwind_hdr) = .;		\
+		}
+#else
+#define EH_FRAME_HDR
+#endif
+
 		/* DWARF debug sections.
 		Symbols in the DWARF debugging sections are relative to
 		the beginning of the section so we begin them at 0.  */
--- linux-2.6.19-rc2/include/linux/unwind.h	2006-10-17 17:11:55.000000000 +0200
+++ 2.6.19-rc2-unwind-eh_frame_hdr/include/linux/unwind.h	2006-10-17 10:00:08.000000000 +0200
@@ -26,6 +26,7 @@ struct module;
  * Initialize unwind support.
  */
 extern void unwind_init(void);
+extern void unwind_setup(void);
 
 #ifdef CONFIG_MODULES
 
@@ -73,6 +74,7 @@ extern int unwind_to_user(struct unwind_
 struct unwind_frame_info {};
 
 static inline void unwind_init(void) {}
+static inline void unwind_setup(void) {}
 
 #ifdef CONFIG_MODULES
 
--- linux-2.6.19-rc2/init/main.c	2006-10-17 17:11:56.000000000 +0200
+++ 2.6.19-rc2-unwind-eh_frame_hdr/init/main.c	2006-10-17 09:57:54.000000000 +0200
@@ -503,6 +503,7 @@ asmlinkage void __init start_kernel(void
 	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
+	unwind_setup();
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
--- linux-2.6.19-rc2/kernel/unwind.c	2006-10-17 17:11:56.000000000 +0200
+++ 2.6.19-rc2-unwind-eh_frame_hdr/kernel/unwind.c	2006-10-17 17:07:52.000000000 +0200
@@ -11,13 +11,15 @@
 
 #include <linux/unwind.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/bootmem.h>
+#include <linux/sort.h>
 #include <linux/stop_machine.h>
 #include <asm/sections.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
 extern char __start_unwind[], __end_unwind[];
+extern const u8 __start_unwind_hdr[], __end_unwind_hdr[];
 
 #define MAX_STACK_DEPTH 8
 
@@ -100,6 +102,8 @@ static struct unwind_table {
 	} core, init;
 	const void *address;
 	unsigned long size;
+	const unsigned char *header;
+	unsigned long hdrsz;
 	struct unwind_table *link;
 	const char *name;
 } root_table;
@@ -145,6 +149,10 @@ static struct unwind_table *find_table(u
 	return table;
 }
 
+static unsigned long read_pointer(const u8 **pLoc,
+                                  const void *end,
+                                  signed ptrType);
+
 static void init_unwind_table(struct unwind_table *table,
                               const char *name,
                               const void *core_start,
@@ -152,14 +160,30 @@ static void init_unwind_table(struct unw
                               const void *init_start,
                               unsigned long init_size,
                               const void *table_start,
-                              unsigned long table_size)
+                              unsigned long table_size,
+                              const u8 *header_start,
+                              unsigned long header_size)
 {
+	const u8 *ptr = header_start + 4;
+	const u8 *end = header_start + header_size;
+
 	table->core.pc = (unsigned long)core_start;
 	table->core.range = core_size;
 	table->init.pc = (unsigned long)init_start;
 	table->init.range = init_size;
 	table->address = table_start;
 	table->size = table_size;
+	/* See if the linker provided table looks valid. */
+	if (header_size <= 4
+	    || header_start[0] != 1
+	    || (void *)read_pointer(&ptr, end, header_start[1]) != table_start
+	    || header_start[2] == DW_EH_PE_omit
+	    || read_pointer(&ptr, end, header_start[2]) <= 0
+	    || header_start[3] == DW_EH_PE_omit)
+		header_start = NULL;
+	table->hdrsz = header_size;
+	smp_wmb();
+	table->header = header_start;
 	table->link = NULL;
 	table->name = name;
 }
@@ -169,7 +193,143 @@ void __init unwind_init(void)
 	init_unwind_table(&root_table, "kernel",
 	                  _text, _end - _text,
 	                  NULL, 0,
-	                  __start_unwind, __end_unwind - __start_unwind);
+	                  __start_unwind, __end_unwind - __start_unwind,
+	                  __start_unwind_hdr, __end_unwind_hdr - __start_unwind_hdr);
+}
+
+static const u32 bad_cie, not_fde;
+static const u32 *cie_for_fde(const u32 *fde, const struct unwind_table *);
+static signed fde_pointer_type(const u32 *cie);
+
+struct eh_frame_hdr_table_entry {
+	unsigned long start, fde;
+};
+
+static int cmp_eh_frame_hdr_table_entries(const void *p1, const void *p2)
+{
+	const struct eh_frame_hdr_table_entry *e1 = p1;
+	const struct eh_frame_hdr_table_entry *e2 = p2;
+
+	return (e1->start > e2->start) - (e1->start < e2->start);
+}
+
+static void swap_eh_frame_hdr_table_entries(void *p1, void *p2, int size)
+{
+	struct eh_frame_hdr_table_entry *e1 = p1;
+	struct eh_frame_hdr_table_entry *e2 = p2;
+	unsigned long v;
+
+	v = e1->start;
+	e1->start = e2->start;
+	e2->start = v;
+	v = e1->fde;
+	e1->fde = e2->fde;
+	e2->fde = v;
+}
+
+static void setup_unwind_table(struct unwind_table *table,
+                               void *(*alloc)(unsigned long))
+{
+	const u8 *ptr;
+	unsigned long tableSize = table->size, hdrSize;
+	unsigned n;
+	const u32 *fde;
+	struct {
+		u8 version;
+		u8 eh_frame_ptr_enc;
+		u8 fde_count_enc;
+		u8 table_enc;
+		unsigned long eh_frame_ptr;
+		unsigned int fde_count;
+		struct eh_frame_hdr_table_entry table[];
+	} __attribute__((__packed__)) *header;
+
+	if (table->header)
+		return;
+
+	if (table->hdrsz)
+		printk(KERN_WARNING ".eh_frame_hdr for '%s' present but unusable\n",
+		       table->name);
+
+	if (tableSize & (sizeof(*fde) - 1))
+		return;
+
+	for (fde = table->address, n = 0;
+	     tableSize > sizeof(*fde) && tableSize - sizeof(*fde) >= *fde;
+	     tableSize -= sizeof(*fde) + *fde, fde += 1 + *fde / sizeof(*fde)) {
+		const u32 *cie = cie_for_fde(fde, table);
+		signed ptrType;
+
+		if (cie == &not_fde)
+			continue;
+		if (cie == NULL
+		    || cie == &bad_cie
+		    || (ptrType = fde_pointer_type(cie)) < 0)
+			return;
+		ptr = (const u8 *)(fde + 2);
+		if (!read_pointer(&ptr,
+		                  (const u8 *)(fde + 1) + *fde,
+		                  ptrType))
+			return;
+		++n;
+	}
+
+	if (tableSize || !n)
+		return;
+
+	hdrSize = 4 + sizeof(unsigned long) + sizeof(unsigned int)
+	        + 2 * n * sizeof(unsigned long);
+	header = alloc(hdrSize);
+	if (!header)
+		return;
+	header->version          = 1;
+	header->eh_frame_ptr_enc = DW_EH_PE_abs|DW_EH_PE_native;
+	header->fde_count_enc    = DW_EH_PE_abs|DW_EH_PE_data4;
+	header->table_enc        = DW_EH_PE_abs|DW_EH_PE_native;
+	put_unaligned((unsigned long)table->address, &header->eh_frame_ptr);
+	BUILD_BUG_ON(offsetof(typeof(*header), fde_count)
+	             % __alignof(typeof(header->fde_count)));
+	header->fde_count        = n;
+
+	BUILD_BUG_ON(offsetof(typeof(*header), table)
+	             % __alignof(typeof(*header->table)));
+	for (fde = table->address, tableSize = table->size, n = 0;
+	     tableSize;
+	     tableSize -= sizeof(*fde) + *fde, fde += 1 + *fde / sizeof(*fde)) {
+		const u32 *cie = fde + 1 - fde[1] / sizeof(*fde);
+
+		if (!fde[1])
+			continue; /* this is a CIE */
+		ptr = (const u8 *)(fde + 2);
+		header->table[n].start = read_pointer(&ptr,
+		                                      (const u8 *)(fde + 1) + *fde,
+		                                      fde_pointer_type(cie));
+		header->table[n].fde = (unsigned long)fde;
+		++n;
+	}
+	WARN_ON(n != header->fde_count);
+
+	sort(header->table,
+	     n,
+	     sizeof(*header->table),
+	     cmp_eh_frame_hdr_table_entries,
+	     swap_eh_frame_hdr_table_entries);
+
+	table->hdrsz = hdrSize;
+	smp_wmb();
+	table->header = (const void *)header;
+}
+
+static void *__init balloc(unsigned long sz)
+{
+	return __alloc_bootmem_nopanic(sz,
+	                               sizeof(unsigned int),
+	                               __pa(MAX_DMA_ADDRESS));
+}
+
+void __init unwind_setup(void)
+{
+	setup_unwind_table(&root_table, balloc);
 }
 
 #ifdef CONFIG_MODULES
@@ -193,7 +353,8 @@ void *unwind_add_table(struct module *mo
 	init_unwind_table(table, module->name,
 	                  module->module_core, module->core_size,
 	                  module->module_init, module->init_size,
-	                  table_start, table_size);
+	                  table_start, table_size,
+	                  NULL, 0);
 
 	if (last_table)
 		last_table->link = table;
@@ -303,6 +464,26 @@ static sleb128_t get_sleb128(const u8 **
 	return value;
 }
 
+static const u32 *cie_for_fde(const u32 *fde, const struct unwind_table *table)
+{
+	const u32 *cie;
+
+	if (!*fde || (*fde & (sizeof(*fde) - 1)))
+		return &bad_cie;
+	if (!fde[1])
+		return &not_fde; /* this is a CIE */
+	if ((fde[1] & (sizeof(*fde) - 1))
+	    || fde[1] > (unsigned long)(fde + 1) - (unsigned long)table->address)
+		return NULL; /* this is not a valid FDE */
+	cie = fde + 1 - fde[1] / sizeof(*fde);
+	if (*cie <= sizeof(*cie) + 4
+	    || *cie >= fde[1] - sizeof(*fde)
+	    || (*cie & (sizeof(*cie) - 1))
+	    || cie[1])
+		return NULL; /* this is not a (valid) CIE */
+	return cie;
+}
+
 static unsigned long read_pointer(const u8 **pLoc,
                                   const void *end,
                                   signed ptrType)
@@ -610,49 +791,108 @@ int unwind(struct unwind_frame_info *fra
 	unsigned i;
 	signed ptrType = -1;
 	uleb128_t retAddrReg = 0;
-	struct unwind_table *table;
+	const struct unwind_table *table;
 	struct unwind_state state;
 
 	if (UNW_PC(frame) == 0)
 		return -EINVAL;
 	if ((table = find_table(pc)) != NULL
 	    && !(table->size & (sizeof(*fde) - 1))) {
-		unsigned long tableSize = table->size;
+		const u8 *hdr = table->header;
+		unsigned long tableSize;
 
-		for (fde = table->address;
-		     tableSize > sizeof(*fde) && tableSize - sizeof(*fde) >= *fde;
-		     tableSize -= sizeof(*fde) + *fde,
-		     fde += 1 + *fde / sizeof(*fde)) {
-			if (!*fde || (*fde & (sizeof(*fde) - 1)))
-				break;
-			if (!fde[1])
-				continue; /* this is a CIE */
-			if ((fde[1] & (sizeof(*fde) - 1))
-			    || fde[1] > (unsigned long)(fde + 1)
-			                - (unsigned long)table->address)
-				continue; /* this is not a valid FDE */
-			cie = fde + 1 - fde[1] / sizeof(*fde);
-			if (*cie <= sizeof(*cie) + 4
-			    || *cie >= fde[1] - sizeof(*fde)
-			    || (*cie & (sizeof(*cie) - 1))
-			    || cie[1]
-			    || (ptrType = fde_pointer_type(cie)) < 0) {
-				cie = NULL; /* this is not a (valid) CIE */
-				continue;
+		smp_rmb();
+		if (hdr && hdr[0] == 1) {
+			switch(hdr[3] & DW_EH_PE_FORM) {
+			case DW_EH_PE_native: tableSize = sizeof(unsigned long); break;
+			case DW_EH_PE_data2: tableSize = 2; break;
+			case DW_EH_PE_data4: tableSize = 4; break;
+			case DW_EH_PE_data8: tableSize = 8; break;
+			default: tableSize = 0; break;
+			}
+			ptr = hdr + 4;
+			end = hdr + table->hdrsz;
+			if (tableSize
+			    && read_pointer(&ptr, end, hdr[1])
+			       == (unsigned long)table->address
+			    && (i = read_pointer(&ptr, end, hdr[2])) > 0
+			    && i == (end - ptr) / (2 * tableSize)
+			    && !((end - ptr) % (2 * tableSize))) {
+				do {
+					const u8 *cur = ptr + (i / 2) * (2 * tableSize);
+
+					startLoc = read_pointer(&cur,
+					                        cur + tableSize,
+					                        hdr[3]);
+					if (pc < startLoc)
+						i /= 2;
+					else {
+						ptr = cur - tableSize;
+						i = (i + 1) / 2;
+					}
+				} while (startLoc && i > 1);
+				if (i == 1
+				    && (startLoc = read_pointer(&ptr,
+				                                ptr + tableSize,
+				                                hdr[3])) != 0
+				    && pc >= startLoc)
+					fde = (void *)read_pointer(&ptr,
+					                           ptr + tableSize,
+					                           hdr[3]);
 			}
+		}
+
+		if (fde != NULL) {
+			cie = cie_for_fde(fde, table);
 			ptr = (const u8 *)(fde + 2);
-			startLoc = read_pointer(&ptr,
-			                        (const u8 *)(fde + 1) + *fde,
-			                        ptrType);
-			endLoc = startLoc
-			         + read_pointer(&ptr,
-			                        (const u8 *)(fde + 1) + *fde,
-			                        ptrType & DW_EH_PE_indirect
-			                        ? ptrType
-			                        : ptrType & (DW_EH_PE_FORM|DW_EH_PE_signed));
-			if (pc >= startLoc && pc < endLoc)
-				break;
-			cie = NULL;
+			if(cie != NULL
+			   && cie != &bad_cie
+			   && cie != &not_fde
+			   && (ptrType = fde_pointer_type(cie)) >= 0
+			   && read_pointer(&ptr,
+			                   (const u8 *)(fde + 1) + *fde,
+			                   ptrType) == startLoc) {
+				if (!(ptrType & DW_EH_PE_indirect))
+					ptrType &= DW_EH_PE_FORM|DW_EH_PE_signed;
+				endLoc = startLoc
+				         + read_pointer(&ptr,
+				                        (const u8 *)(fde + 1) + *fde,
+				                        ptrType);
+				if(pc >= endLoc)
+					fde = NULL;
+			} else
+				fde = NULL;
+		}
+		if (fde == NULL) {
+			for (fde = table->address, tableSize = table->size;
+			     cie = NULL, tableSize > sizeof(*fde)
+			     && tableSize - sizeof(*fde) >= *fde;
+			     tableSize -= sizeof(*fde) + *fde,
+			     fde += 1 + *fde / sizeof(*fde)) {
+				cie = cie_for_fde(fde, table);
+				if (cie == &bad_cie) {
+					cie = NULL;
+					break;
+				}
+				if (cie == NULL
+				    || cie == &not_fde
+				    || (ptrType = fde_pointer_type(cie)) < 0)
+					continue;
+				ptr = (const u8 *)(fde + 2);
+				startLoc = read_pointer(&ptr,
+				                        (const u8 *)(fde + 1) + *fde,
+				                        ptrType);
+				if (!startLoc)
+					continue;
+				if (!(ptrType & DW_EH_PE_indirect))
+					ptrType &= DW_EH_PE_FORM|DW_EH_PE_signed;
+				endLoc = startLoc
+				         + read_pointer(&ptr,
+				                        (const u8 *)(fde + 1) + *fde,
+				                        ptrType);
+				if (pc >= startLoc && pc < endLoc)
+					break;
+			}
 		}
 	}
 	if (cie != NULL) {


