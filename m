Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314555AbSEBPVT>; Thu, 2 May 2002 11:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEBPVS>; Thu, 2 May 2002 11:21:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18793 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314555AbSEBPVG>; Thu, 2 May 2002 11:21:06 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 Boot enhancements, LinuxBIOS support 10/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
	<m1sn5ay5ac.fsf_-_@frodo.biederman.org>
	<m1offyy55x.fsf_-_@frodo.biederman.org>
	<m1it66y4xz.fsf_-_@frodo.biederman.org>
	<m1elguy4pj.fsf_-_@frodo.biederman.org>
	<m1adriy4im.fsf_-_@frodo.biederman.org>
	<m16626y4et.fsf_-_@frodo.biederman.org>
	<m11ycuy48d.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 09:13:15 -0600
Message-ID: <m1wuumwpkk.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

This patch adds support for LinuxBIOS.

Eric

diff -uNr linux-2.5.12.boot.proto/arch/i386/Config.help linux-2.5.12.boot.linuxbios/arch/i386/Config.help
--- linux-2.5.12.boot.proto/arch/i386/Config.help	Wed May  1 09:41:19 2002
+++ linux-2.5.12.boot.linuxbios/arch/i386/Config.help	Wed May  1 09:41:27 2002
@@ -803,6 +803,22 @@
   a work-around for a number of buggy BIOSes. Switch this option on if
   your computer crashes instead of powering off properly.
 
+LinuxBIOS support
+CONFIG_LINUXBIOS
+  LinuxBIOS is an alternative GPL'd firmware initially for x86
+  compatible machines.  LinuxBIOS attempts to be a simple and as fast
+  as possible, and is initially optimized for linux.  The interface to
+  the OS is a table at the beginning of memory.  Which should make the
+  inevitable firmware bugs easier to work around, as should the source
+  code :)  A goal of this table is to provide enough information so
+  that any OS but especially linux does not need to have motherboard
+  specific knowledge.
+
+  This first release only provides LinuxBIOS detection (by detecting
+  it's table) and memory size detection. 
+
+  For more information on LinuxBIOS see http://www.linuxbios.org
+
 CONFIG_CMDLINE
   Generally it is best to pass command line parameters via the
   bootloader but there are times it is convinient not to do this.
diff -uNr linux-2.5.12.boot.proto/arch/i386/config.in linux-2.5.12.boot.linuxbios/arch/i386/config.in
--- linux-2.5.12.boot.proto/arch/i386/config.in	Wed May  1 09:41:19 2002
+++ linux-2.5.12.boot.linuxbios/arch/i386/config.in	Wed May  1 09:41:27 2002
@@ -206,6 +206,7 @@
    fi
 fi
 
+bool 'LinuxBIOS support' CONFIG_LINUXBIOS
 endmenu
 
 mainmenu_option next_comment
diff -uNr linux-2.5.12.boot.proto/arch/i386/defconfig linux-2.5.12.boot.linuxbios/arch/i386/defconfig
--- linux-2.5.12.boot.proto/arch/i386/defconfig	Tue Apr 30 22:55:21 2002
+++ linux-2.5.12.boot.linuxbios/arch/i386/defconfig	Wed May  1 09:41:27 2002
@@ -119,6 +119,7 @@
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 # CONFIG_APM is not set
+# CONFIG_LINUXBIOS is not set
 
 #
 # Memory Technology Devices (MTD)
diff -uNr linux-2.5.12.boot.proto/arch/i386/kernel/Makefile linux-2.5.12.boot.linuxbios/arch/i386/kernel/Makefile
--- linux-2.5.12.boot.proto/arch/i386/kernel/Makefile	Tue Apr 16 11:10:43 2002
+++ linux-2.5.12.boot.linuxbios/arch/i386/kernel/Makefile	Wed May  1 09:41:27 2002
@@ -42,6 +42,7 @@
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_LINUXBIOS)		+= linuxbios.o
 ifdef CONFIG_VISWS
 obj-y += setup-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
diff -uNr linux-2.5.12.boot.proto/arch/i386/kernel/linuxbios.c linux-2.5.12.boot.linuxbios/arch/i386/kernel/linuxbios.c
--- linux-2.5.12.boot.proto/arch/i386/kernel/linuxbios.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.12.boot.linuxbios/arch/i386/kernel/linuxbios.c	Wed May  1 09:41:27 2002
@@ -0,0 +1,103 @@
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <net/checksum.h>
+#include <asm/linuxbios.h>
+#include <asm/e820.h>
+#include "linuxbios_tables.h"
+
+#define for_each_lbrec(head, rec) \
+	for(rec = (struct lb_record *)(((char *)head) + sizeof(*head)); \
+		(((char *)rec) < (((char *)head) + sizeof(*head) + head->table_bytes))  && \
+		(rec->size >= 1) && \
+		((((char *)rec) + rec->size) <= (((char *)head) + sizeof(*head) + head->table_bytes)); \
+		rec = (struct lb_record *)(((char *)rec) + rec->size)) 
+		
+
+static int __init count_lb_records(struct lb_header *head)
+{
+	struct lb_record *rec;
+	int count;
+	count = 0;
+	for_each_lbrec(head, rec) {
+		count++;
+	}
+	return count;
+}
+
+static struct lb_header * __init __find_lb_table(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+	/* For now be stupid.... */
+	for(addr = start; addr < end; addr += 16) {
+		struct lb_header *head = phys_to_virt(addr);
+		struct lb_record *recs = phys_to_virt(addr + sizeof(*head));
+		if (memcmp(head->signature, "LBIO", 4) != 0)
+			continue;
+		if (head->header_bytes != sizeof(*head))
+			continue;
+		if (ip_compute_csum((unsigned char *)head, sizeof(*head)) != 0)
+			continue;
+		if (ip_compute_csum((unsigned char *)recs, head->table_bytes) 
+			!= head->table_checksum)
+			continue;
+		if (count_lb_records(head) != head->table_entries)
+			continue;
+		printk(KERN_DEBUG "Found LinuxBIOS table at: %p\n", head);
+		return head;
+	};
+	return 0;
+}
+
+static struct lb_header * __init find_lb_table(void)
+{
+	struct lb_header *head;
+	head = 0;
+	if (!head) {
+		/* First try at address 0 */
+		head = __find_lb_table(0x00000, 0x1000);
+	}
+	if (!head) {
+		/* Then try at address 0xf0000 */
+		head = __find_lb_table(0xf0000, 0x100000);
+	}
+	return head;
+}
+
+void __init read_linuxbios_params(void)
+{
+	struct lb_header *head;
+	struct lb_record *rec;
+	struct lb_memory *mem;
+	int i, entries;
+	head = find_lb_table();
+	if (!head) {
+		return;
+	}
+	mem = 0;
+	for_each_lbrec(head, rec) {
+		if (rec->tag == LB_TAG_MEMORY) {
+			mem = (struct lb_memory *)rec;
+			break;
+		}
+	}
+	if (!mem) {
+		return;
+	}
+	entries = (mem->size - sizeof(*mem))/sizeof(mem->map[0]);
+	if (entries == 0)
+		return;
+	e820.nr_map = 0;
+	for(i = 0; i < entries; i++) {
+		unsigned long long start;
+		unsigned long long size;
+		unsigned long type;
+		start = mem->map[i].start;
+		size = mem->map[i].size;
+		type = (mem->map[i].type == LB_MEM_RAM)?E820_RAM: E820_RESERVED;
+		add_memory_region(start, size, type);
+	}
+	print_memory_map("LinuxBIOS");
+	return;
+}
+
diff -uNr linux-2.5.12.boot.proto/arch/i386/kernel/linuxbios_tables.h linux-2.5.12.boot.linuxbios/arch/i386/kernel/linuxbios_tables.h
--- linux-2.5.12.boot.proto/arch/i386/kernel/linuxbios_tables.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.12.boot.linuxbios/arch/i386/kernel/linuxbios_tables.h	Wed May  1 09:41:27 2002
@@ -0,0 +1,82 @@
+#ifndef LINUXBIOS_TABLES_H
+#define LINUXBIOS_TABLES_H
+
+#include <linux/types.h>
+
+/* The linuxbios table information is for conveying information
+ * from the firmware to the loaded OS image.  Primarily this
+ * is expected to be information that cannot be discovered by
+ * other means, such as quering the hardware directly.
+ *
+ * All of the information should be Position Independent Data.  
+ * That is it should be safe to relocated any of the information
+ * without it's meaning/correctnes changing.   For table that
+ * can reasonably be used on multiple architectures the data
+ * size should be fixed.  This should ease the transition between
+ * 32 bit and 64 bit architectures etc.
+ *
+ * The completeness test for the information in this table is:
+ * - Can all of the hardware be detected?
+ * - Are the per motherboard constants available?
+ * - Is there enough to allow a kernel to run that was written before
+ *   a particular motherboard is constructed? (Assuming the kernel
+ *   has drivers for all of the hardware but it does not have
+ *   assumptions on how the hardware is connected together).
+ *
+ * With this test it should be straight forward to determine if a
+ * table entry is required or not.  This should remove much of the
+ * long term compatibility burden as table entries which are
+ * irrelevant or have been replaced by better alternatives may be
+ * dropped.  Of course it is polite and expidite to include extra
+ * table entries and be backwards compatible, but it is not required.
+ */
+
+
+struct lb_header
+{
+	uint8_t  signature[4]; /* LBIO */
+	uint32_t header_bytes;
+	uint32_t header_checksum;
+	uint32_t table_bytes;
+	uint32_t table_checksum;
+	uint32_t table_entries;
+};
+
+/* Every entry in the boot enviroment list will correspond to a boot
+ * info record.  Encoding both type and size.  The type is obviously
+ * so you can tell what it is.  The size allows you to skip that
+ * boot enviroment record if you don't know what it easy.  This allows
+ * forward compatibility with records not yet defined.
+ */
+struct lb_record {
+	uint32_t tag;		/* tag ID */
+	uint32_t size;		/* size of record (in bytes) */
+};
+
+#define LB_TAG_UNUSED	0x0000
+
+#define LB_TAG_MEMORY	0x0001
+
+struct lb_memory_range {
+	uint64_t start;
+	uint64_t size;
+	uint32_t type;
+#define LB_MEM_RAM      1
+#define LB_MEM_RESERVED 2
+	
+};
+
+struct lb_memory {
+	uint32_t tag;
+	uint32_t size;
+	struct lb_memory_range map[0];
+};
+
+#define LB_TAG_HWRPB	0x0002
+struct lb_hwrpb {
+	uint32_t tag;
+	uint32_t size;
+	uint64_t hwrpb;
+};
+
+#endif /* LINUXBIOS_TABLES_H */
diff -uNr linux-2.5.12.boot.proto/arch/i386/kernel/setup.c linux-2.5.12.boot.linuxbios/arch/i386/kernel/setup.c
--- linux-2.5.12.boot.proto/arch/i386/kernel/setup.c	Wed May  1 09:41:19 2002
+++ linux-2.5.12.boot.linuxbios/arch/i386/kernel/setup.c	Wed May  1 09:41:27 2002
@@ -119,6 +119,7 @@
 #include <asm/mmu_context.h>
 #include <asm/boot.h>
 #include <asm/boot_param.h>
+#include <asm/linuxbios.h>
 
 /*
  * Machine setup..
@@ -265,7 +266,7 @@
 	}
 }
 
-static void __init add_memory_region(unsigned long long start,
+void __init add_memory_region(unsigned long long start,
                                   unsigned long long size, int type)
 {
 	int x = e820.nr_map;
@@ -283,7 +284,7 @@
 
 #define E820_DEBUG	1
 
-static void __init print_memory_map(char *who)
+void __init print_memory_map(char *who)
 {
 	int i;
 
@@ -775,6 +776,9 @@
 	if (entry16) {
 		read_entry16_params(params);
 	}
+
+	/* Attempt to get the LinuxBIOS parameters */
+	read_linuxbios_params();
 
 	/* Read user specified params */
 	parse_mem_cmdline(cmdline_p);
diff -uNr linux-2.5.12.boot.proto/include/asm-i386/e820.h linux-2.5.12.boot.linuxbios/include/asm-i386/e820.h
--- linux-2.5.12.boot.proto/include/asm-i386/e820.h	Wed May  1 09:39:11 2002
+++ linux-2.5.12.boot.linuxbios/include/asm-i386/e820.h	Wed May  1 09:41:27 2002
@@ -36,6 +36,9 @@
 };
 
 extern struct e820map e820;
+extern void  add_memory_region(unsigned long long start,
+	unsigned long long size, int type);
+extern void print_memory_map(char *who);
 #endif/*!__ASSEMBLY__*/
 
 #endif/*__E820_HEADER*/
diff -uNr linux-2.5.12.boot.proto/include/asm-i386/linuxbios.h linux-2.5.12.boot.linuxbios/include/asm-i386/linuxbios.h
--- linux-2.5.12.boot.proto/include/asm-i386/linuxbios.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.12.boot.linuxbios/include/asm-i386/linuxbios.h	Wed May  1 09:41:27 2002
@@ -0,0 +1,10 @@
+#ifndef __ASMi386_LINUXBIOS_H
+#define __ASMi386_LINUXBIOS_H
+
+#ifdef CONFIG_LINUXBIOS
+void read_linuxbios_params(void);
+#else
+#define read_linuxbios_params()
+#endif /* CONFIG_LINUXBIOS */
+
+#endif
