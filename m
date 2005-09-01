Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVIAKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVIAKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVIAKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:54:29 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:17568 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S964884AbVIAKy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:54:27 -0400
Message-ID: <2355.192.168.201.6.1125572050.squirrel@www.masroudeau.com>
Date: Thu, 1 Sep 2005 11:54:10 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@osdl.org>
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: [PATCH 2/4] rm -rf linux/arch/i386/boot  and Gujin bootloader
Content-Type: multipart/mixed;boundary="----=_20050901115410_11133"
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050901115410_11133
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

  This second part is the main thing, that is the real-mode C file and its
 include file, compiled by GCC and executed in real mode before the switch
 to protected mode for the first instruction usually residing at linear
 address 0x100000.

Signed-off-by: Etienne Lorrain <etienne_lorrain@gujin.org>

------=_20050901115410_11133
Content-Type: text/plain; name="patch2613-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch2613-2"

diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/arch/i386/kernel/Makefile linux-2.6.13-2/arch/i386/kernel/Makefile
--- linux-2.6.13-1/arch/i386/kernel/Makefile	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13-2/arch/i386/kernel/Makefile	2005-08-31 00:42:07.000000000 +0100
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o
+		doublefault.o quirks.o realmode.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/arch/i386/kernel/realmode.c linux-2.6.13-2/arch/i386/kernel/realmode.c
--- linux-2.6.13-1/arch/i386/kernel/realmode.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-2/arch/i386/kernel/realmode.c	2005-08-31 00:42:07.000000000 +0100
@@ -0,0 +1,1427 @@
+/*
+ *  This file "realmode.c" is licensed with the same license as the Linux
+ * kernel, and anyway the mapping of the data structure produced is owned
+ * by Linux kernel copyright owner(s) - for a long time.
+ *
+ *  The main use of this file is to produce a "Gujin native bootable file"
+ * i.e. a Linux kernel with a "kgz" extension, which is a standard ELF
+ * executable file translated to binary image by OBJCOPY and compressed
+ * by GZIP. This initial ELF file may contain an ia32 real mode section
+ * at its end (size in "realfct_size" parameter) to be copied in low memory
+ * by the bootloader and executed before switching to ia32 protected mode,
+ * so that the Linux kernel can interrogate the BIOS.
+ * If there is no real mode section in the ELF file, then "realfct_size"
+ * is set to zero or not given at all, and a default mapping is filled by
+ * Gujin - that shall boot nearly every Linux kernel since the old time (TM).
+ *
+ * Gujin homepage is at: http://gujin.org/ ; it is itself licensed
+ * under the terms of the GNU General Public License, version 2.
+ * Gujin is Copyright (C) 1999-2005 Etienne Lorrain, fingerprint (2D3AF3EA):
+ *   2471 DF64 9DEE 41D4 C8DB 9667 E448 FF8C 2D3A F3EA
+ * E-Mail: etienne dot lorrain at gujin dot org
+ *
+ *  First version has been written by Etienne Lorrain in December 2004.
+ * This patch cannot really be applied to Linux-2.11 and before without
+ * loosing the EDD and EDID infomation which moved in Linux-2.6.12
+ */
+
+/*
+ * Do not touch - used to generate real mode ia32 code and manage
+ * the inter-segment call transparently, after maximum 4 Kbytes
+ * of real mode rodata/data has been copied in %ds segment.
+ *
+ * Having constant/initialised variable in here is a bit tricky,
+ * it uses the fact that since Gujin-1.0, the segment ".fourKsegment"
+ * containning the only variable "fourKbuffer" (of size 4 Kbytes)
+ * is located at %ds:0 i.e. before the ".rodata" of Gujin.
+ * Note that here the code segment is local but the data segment
+ * (and the stack segment) is the one of Gujin for obvious reasons.
+ * The first person modifying data at address over %ds:0x1000
+ * get all the blame for any bug happening in Gujin, in between
+ * the last and the next big bang, and it is a pretty long time.
+ * <smile>You don't like my memory protection system?</smile>
+ */
+asm("	.psize 0				\n"
+    "	.code16gcc				\n"
+    "	.section .init.text16,\"ax\",@progbits	\n"
+    "	push	%di				\n"
+    "	push	%si				\n"
+    "	mov	$_sdata16,%si			\n"
+    "	mov	%si,%di				\n"
+    "	mov	$_edata16,%cx			\n"
+    "	and	$0xFFF,%cx			\n"
+    "	sub	%si,%cx				\n"
+    "	shr	$2,%cx				\n"
+    "	rep movsl %cs:(%si),%es:(%di)		\n"
+    "	pop	%si				\n"
+    "	pop	%di				\n"
+    "	calll	linux_set_params		\n"
+    "	lretw					\n"
+    "	.previous				\n"
+);
+
+#include "asm/realmode.h"
+
+/*
+ * Those need to be used because there is no way to set the default
+ * segment name used for ".text", ".data", ".rodata*" and ".bss"
+ * It would be nice to be able to do: asm(".equ .data, .data16");
+ * or shall that be managed by the compiler - and by compilation
+ * switch or by the attribute of functions?
+ * This file is pre-linked (section with same name grouped together)
+ * in "arch/i386/kernel/built-in.o" so no hope to manage it in
+ * the final linker file if it uses the same section names.
+ * Maybe if "arch/i386/kernel/built-in.o" could be an archive?
+ * Maybe it is "the right way (TM)" to use different section names
+ * so that those functions can be located in different source files.
+ * Maybe the section name shall be automatically changed using
+ * objcopy in the realmode.o file, just after compilation.
+ * Maybe the segment names shall be changed by sed in the
+ * assembler file.
+ *
+ * Unfortunately, I do not know how to use inline strings here,
+ * i.e. puts("hello world"); will not work due to the segment
+ * used to store the constant "hello world".
+ * Same for the implicit table generated by a big switch().
+ * This would generate a prohibited cross reference at linker time.
+ *
+ * I also need to add that using GCC to generate real-mode i386
+ * executable has a major limitation: no use of library compiled
+ * for protected mode. If your source make GCC to call memcpy(),
+ * memset(), strcpy()... then you have to provide them yourself.
+ * The same thing apply if you multiply or divide 64 bit numbers
+ * by non power of two. Adding and substracting of long long is OK.
+ */
+#define CONST		__attribute__ ((section (".rodata16"))) const
+#define VARIABLE	__attribute__ ((section (".data16")))
+#define BSS		__attribute__ ((section (".bss16")))
+#define CODE		__attribute__ ((section (".text16")))
+
+/*
+ * When compiling this file, some combination of GCC and options
+ * will call memset() in the assembly generated. You can check it
+ * by typing "make arch/i386/kernel/realmode.s".
+ * They cannot be inline because they are _called_ by the compiler.
+ * It is not possible to access the standard one because its
+ * hexadecimal coding is for protected mode, and not possible to
+ * code it in assembler because of we do not know the calling
+ * convension (GCC optimisations like "-mtrd", "-mregparm=3").
+ * We also cannot have two memcpy() nor memset() in the same
+ * final link, so we rename them in assembler.
+ */
+CODE void code16_memcpy (char *dest, const char *src, unsigned nb)
+{
+	while (nb--)
+		*dest++ = *src++;
+}
+CODE void code16_memset (char *dest, unsigned val, unsigned nb)
+{
+	while (nb--)
+		*dest++ = val;
+}
+asm (
+    "memcpy = code16_memcpy \n"
+    "memset = code16_memset \n"
+);
+
+/**
+ ** Few debug functions and how to use them, including how to declare
+ ** variables and constants. For complex debug, you may want to
+ ** check dbgload.exe of Gujin. The following debug uses the VIDEO BIOS
+ ** to display messages so will not work in VESA modes when the VESA
+ ** BIOS do not support printing characters in current video mode
+ ** (bit BIOS_output_supported of VESA_modeinfo_t / struct screen_info)
+ **/
+//#define TEST_VGAPRINT
+
+#ifdef TEST_VGAPRINT
+CONST char test_before[] = "test: 0x";
+VARIABLE unsigned test_val = 0x089ABC0;
+CONST char test_middle[] = ", test_val2 = 0x";
+BSS unsigned test_val2;
+VARIABLE char test_after[] = ".\r\n";
+
+#define PUSHALL "pushw %%ds; pushw %%es; pushw %%fs; pushw %%gs; pushal\n"
+#define POPALL  "popal; popw %%gs; popw %%fs; popw %%es; popw %%ds\n"
+
+CODE static void vgaputs (const char *string)
+{
+	while (*string != '\0')
+		asm(PUSHALL
+		    "	movw	$0x0007,%%bx\n	int	$0x10	\n"
+		    POPALL
+		    : : "a" (0x0E00 | (unsigned char)*string++));
+}
+
+CODE static void vgaputx (unsigned val)
+{
+	unsigned digit_shift = 7 * 4;
+
+	while (digit_shift && (val & (0xF << digit_shift)) == 0)
+		digit_shift -= 4;
+	for (;;) {
+		asm(PUSHALL
+		    "	movw	$0x0007,%%bx	\n"
+		    "	sahf	# clear AF	\n"
+		    "	aaa			\n"
+		    "	aad	$0x11		\n"
+		    "	add	$0x0E30,%%ax	\n"
+		    "	int	$0x10		\n"
+		    POPALL
+		    : : "a" ((val >> digit_shift) & 0x0F));
+		if (digit_shift == 0)
+			break;
+		digit_shift -= 4;
+	}
+}
+
+CODE static inline void vga_wait_seconds (unsigned seconds)
+{
+	unsigned nb_microsec = seconds * 1000 * 1000;
+	unsigned short status;
+
+	asm volatile ("	int	$0x15	# _BIOS_wait "
+	     : "=a" (status)
+	     : "a" ((unsigned short)0x8600), "d" (nb_microsec & 0xFFFF),
+		 "c" (nb_microsec >> 16));
+}
+
+extern inline void test_vgaprint (void)
+{
+	unsigned stackptr;
+	static CONST char stkmsg[] = ", sp = 0x";
+
+	asm (" mov	%%esp,%0 " : "=r" (stackptr));
+	test_val2 = 0x1234fedc;
+
+	vgaputs(test_before);
+	vgaputx(test_val);
+	vgaputs(test_middle);
+	vgaputx(test_val2);
+	vgaputs(stkmsg);
+	vgaputx(stackptr);
+	vgaputs(test_after);
+	vga_wait_seconds(7);
+}
+
+#define DBG(startstr, variable, endstr) { \
+	static CONST char before[]=startstr, after[] = endstr;	\
+	vgaputs(before); vgaputx(variable); vgaputs(after);	\
+	}
+#define DBG_WAIT()	vga_wait_seconds(7)
+#else
+#define test_vgaprint()	/*nothing*/
+#define DBG(startstr, variable, endstr)	/*nothing*/
+#define DBG_WAIT()	/*nothing*/
+#endif
+
+/**
+ ** All the non BIOS related, low level functions we use:
+ **/
+extern inline unsigned peekb (farptr adr)
+{
+	unsigned returned;
+	unsigned short scratch;
+	extern char memory[];
+
+      asm("	pushl	%2		\n"
+	  "	popw	%w0		\n"
+	  "	popw	%%fs		\n"
+	  "	movzbl	%%fs:(%w0),%1	\n"
+	  : "=bSDB" (scratch), "=r" (returned)
+	  : "g" (adr), "m" (*memory) );
+	return returned;
+}
+
+extern inline unsigned peekw (farptr adr)
+{
+	unsigned returned;
+	unsigned short scratch;
+	extern char memory[];
+
+      asm("	pushl	%2		\n"
+	  "	popw	%w0		\n"
+	  "	popw	%%fs		\n"
+	  "	movzwl	%%fs:(%w0),%1	\n"
+	  : "=bSDB" (scratch), "=r" (returned)
+	  : "g" (adr), "m" (*memory) );
+	return returned;
+}
+
+extern inline void outb (unsigned short port, unsigned char data)
+{
+	asm volatile (" outb %0,%1 " : : "a" (data), "dN" (port));
+}
+
+extern inline unsigned char inb (unsigned short port)
+{
+	unsigned char result;
+	asm volatile (" inb %1,%0 " : "=a" (result) : "dN" (port));
+	return result;
+}
+
+extern inline void short_delay (unsigned count)
+{
+	asm volatile (" loopl . \n" : "+c" (count));
+}
+
+extern inline unsigned char getnvram (unsigned char addr)
+{
+	outb(0x70, addr & ~0x80);	/* bit 7 cleared: NMI enabled */
+	short_delay(1000);	/* wait 1000 assembly instructions */
+	return inb(0x71);
+}
+
+__attribute__ ((const)) extern inline farptr
+stack_farptr (const void *data)
+{
+	unsigned stackseg_mask;  /* stack is max 64 K */
+
+	asm (" mov %%ss,%0 \n" : "=r" (stackseg_mask));
+	return (farptr)((stackseg_mask << 16) | (unsigned) data);
+}
+
+/**
+ ** Generic BIOS calls:
+ **/
+
+extern inline struct shift_flags_str {
+	unsigned char right_shift_key_pressed	: 1;
+	unsigned char left_shift_key_pressed	: 1;
+	unsigned char control_key_pressed	: 1;
+	unsigned char alternate_key_pressed	: 1;
+	unsigned char scroll_lock_active	: 1;
+	unsigned char num_lock_active		: 1;
+	unsigned char caps_lock_active		: 1;
+	unsigned char insert_active		: 1;
+} _BIOS_get_shift_flags (void)
+{
+	struct shift_flags_str flags;
+
+	asm (" int $0x16 # _BIOS_get_shift_flags"
+	     : "=a" (flags)
+	     : "a" ((unsigned short)0x0200) );
+	return flags;
+}
+
+extern inline farptr _BIOS_getConfiguration (void)
+{
+	unsigned char error;
+	farptr conf;
+
+	asm ("	pushl	%%es						\n"
+	     "	stc							\n"
+	     "	int	$0x15		# _BIOS_getConfiguration	\n"
+	     "	setc	%%al						\n"
+	     "	pushw	%%es						\n"
+	     "	pushw	%%bx						\n"
+	     "	popl	%%ebx						\n"
+	     "	popl	%%es						\n"
+	     : "=a" (error), "=b" (conf)
+	     : "a" ((unsigned short)0xC000) );
+	if (error)
+		return (farptr)0;
+	return conf;
+}
+
+/*
+ * Would be nice for gcc to accept "=D" (sys_desc_table) to remove
+ * this 'lea %1,%%edi'
+ * It is similar to function returning big structures.
+ */
+extern inline struct sys_desc_table_info __attribute__ ((const))
+get_bios_conf (farptr adr)
+{
+	struct sys_desc_table_info sys_desc_table;
+	unsigned nbbyte = sizeof(struct sys_desc_table_info), dummy;
+
+	asm ("	pushl	%%esi				\n"
+	     "	popw	%%si				\n"
+	     "	popw	%%fs				\n"
+	     "	lea	%1,%%edi			\n"
+	     "	cld					\n"
+	     "	rep movsb %%fs:(%%si),%%es:(%%di)	\n"
+	     : "+S" (adr), "=g" (sys_desc_table), "+c" (nbbyte), "=D" (dummy)
+	     );
+	return sys_desc_table;
+}
+
+extern inline unsigned char
+_BIOS_getExtendedMemory (unsigned short *sizeinKb)
+{
+	unsigned char error;
+
+	asm ("	int	$0x15	# _BIOS_getExtendedMemory	\n"
+	     "	setc	%0					\n"
+	     : "=qm" (error), "=a" (*sizeinKb)
+	     : "a" ((unsigned short)0x8800)
+	     );
+	return error;	/* 0 if no error */
+}
+
+struct MemoryMap_str {
+	unsigned long long base, length;
+	enum { MemAvailable = 1, MemSpecial = 2,
+		Mem_ACPI_reclaim = 3, Mem_ACPI_NVS = 4
+	} type:32;
+} __attribute__ ((packed));
+
+extern inline unsigned char
+_BIOS_QueryMemoryMap (unsigned *cont_val, unsigned *bufsize,
+		      unsigned char **buffer)
+{
+	/* inline */ const unsigned smapsig = 0x534D4150;	// 'SMAP' in big endian
+	unsigned smap_res, actual_len;
+
+	actual_len = *bufsize;
+	smap_res = 0xE820U;
+	asm volatile ("	int     $0x15   # _BIOS_QueryMemoryMap		\n"
+		      "	jnc	1f					\n"
+		      "	xorl	%%eax,%%eax				\n"
+		      "	1:						\n"
+		      : "+a" (smap_res), "+b" (*cont_val),
+			"+c" (actual_len), "=X" (**buffer)
+		      : "d" (smapsig), "D" (*buffer)	/* in fact %%es:%%di */
+		      );
+	if (smap_res != smapsig)
+		return 1;
+	*bufsize -= actual_len;
+	*buffer = *buffer + actual_len;
+	return 0;
+}
+
+extern inline unsigned char
+_APM_installation_check (unsigned short *BCD_version, unsigned short *flags)
+{
+	unsigned char error;
+	unsigned short sig;
+
+	asm ("	int     $0x15	# _APM_installation_check	\n"
+	     "	setc    %0					\n"
+	     : "=qm" (error), "=a" (*BCD_version), "=b" (sig), "=c" (*flags)
+	     : "a" ((unsigned short)0x5300), "b" (0)
+	     );
+	if (error) {
+		*BCD_version &= 0xFF00;	/* keep there error code */
+		*flags = 0;
+	}
+	return error || sig != 0x504D;	/* "PM" */
+}
+
+extern inline unsigned short _APM_disconnect (void)
+{
+	unsigned short error;
+
+	asm volatile ("	int     $0x15	# _APM_disconnect	\n"
+		      "	setc    %%al				\n"
+		      : "=a" (error)
+		      : "a" ((unsigned short)0x5304), "b" (0) );
+	if ((error & 0xFF) == 0)
+		return 0;
+	return error;
+}
+
+extern inline unsigned char
+_APM_connect_32bit (unsigned short *RM_segbase_32,
+		    unsigned *entry_point_offset_32,
+		    unsigned short *RM_segbase_code16,
+		    unsigned short *RM_segbase_data16,
+		    /* APM v1.1: */
+		    unsigned short *APM_BIOS_codeseg_len,
+		    unsigned short *APM_BIOS_dataseg_len)
+{
+	unsigned char error;
+
+	asm volatile ("	xorl	%%edi,%%edi			\n"
+		      "	xorl	%%esi,%%esi			\n"
+		      "	int     $0x15	# _APM_connect_32bit	\n"
+		      "	setc    %0				\n"
+		      : "=qm" (error),
+			"=a" (*RM_segbase_32), "=b" (*entry_point_offset_32),
+			"=c" (*RM_segbase_code16), "=d" (*RM_segbase_data16),
+			"=S" (*APM_BIOS_codeseg_len),
+			"=D" (*APM_BIOS_dataseg_len)
+		      : "a" ((unsigned short)0x5303), "b" (0)
+		      );
+	return error;
+}
+
+/**
+ ** Video BIOS: EGA, VGA, VESA and EDID.
+ **/
+union EGA_bx_union {
+	struct {
+		enum { EGA_64K, EGA_128K, EGA_192K, EGA_256K } memory:8;
+		enum { EGA_COLOR_3Dx, EGA_MONO_3Bx } IOaddr:8;
+	} enums;
+	unsigned short IOaddr_memory;
+} __attribute__ ((packed));
+
+struct EGA_cx_str {
+	unsigned short switch1off	: 1;
+	unsigned short switch2off	: 1;
+	unsigned short switch3off	: 1;
+	unsigned short switch4off	: 1;
+	unsigned short switch_unused	: 4;
+	unsigned short FEAT1line_state2	: 1;
+	unsigned short FEAT0line_state2	: 1;
+	unsigned short FEAT1line_state1	: 1;
+	unsigned short FEAT0line_state1	: 1;
+	unsigned short FEAT_unused	: 4;
+} __attribute__ ((packed));
+
+extern inline void
+_EGA_getdisplay (union EGA_bx_union *EGA_bx, struct EGA_cx_str *EGA_cx)
+{
+	unsigned short destroyed_tseng_ET4000_V8_00;
+	asm (" int $0x10	# _EGA_getdisplay "
+	     : "=b" (*EGA_bx), "=c" (*EGA_cx),
+		"=a" (destroyed_tseng_ET4000_V8_00)
+	     : "a" ((unsigned short)0x1200),
+		"b" ((unsigned short)0xFF10)	/* %bh = 0xFF to see if supported */
+	     );
+}
+
+extern inline void
+_VGA_getcursor (unsigned char page, unsigned char *row, unsigned char *col,
+	        unsigned char *cursorstart, unsigned char *cursorstop)
+{
+	unsigned short row_col, cstart_cstop;
+	unsigned short destroyed_Phoenix_BIOS;
+
+	asm (" int $0x10 # getcursor "
+	     : "=d" (row_col), "=c" (cstart_cstop),
+		"=a" (destroyed_Phoenix_BIOS)
+	     : "a" ((unsigned short)0x0300), "b" ((unsigned short)page << 8)
+	     );
+	*col = (unsigned char)row_col;
+	*row = row_col >> 8;
+	*cursorstart = cstart_cstop >> 8;	/* bug reported with mono displays */
+	*cursorstop = (unsigned char)cstart_cstop;
+}
+
+extern inline char
+_VGA_getmode (unsigned char *nbcol, unsigned char *page)
+{
+	unsigned short nbcol_mode;
+	unsigned short tmppage;
+
+	asm (" int $0x10 # getmode "
+	     : "=b" (tmppage), "=a" (nbcol_mode)
+	     : "a" ((unsigned short)0x0F00)
+	     );
+	*nbcol = nbcol_mode >> 8;
+	*page = tmppage >> 8;
+
+	return (char)nbcol_mode;	/* bit 7 set if last setmode had it */
+}
+
+extern inline unsigned
+_VGA_get_display_combination_code (unsigned char *active_dcc,
+				   unsigned char *alternate_dcc)
+{
+	unsigned char result;
+	unsigned short alternate_active;
+
+	asm (" int $0x10 # get_display_combination_code "
+	     : "=a" (result), "=b" (alternate_active)
+	     : "a" ((unsigned short)0x1A00)
+	     );
+	*active_dcc = (unsigned char)alternate_active;
+	*alternate_dcc = alternate_active >> 8;
+
+	return (result != 0x1A);
+}
+
+typedef struct {
+	char VbeSignature[4];	/* "VESA" but NOT zero terminated. */
+	unsigned short VbeVersion;
+	farptr OemStringPtr;
+	struct {
+		unsigned DAC8bit_present	: 1;
+		unsigned nonVGAcontroller	: 1;
+		unsigned DAC_needs_programmed_while_blanking	: 1;
+		unsigned VBE_AF_extension	: 1;
+		unsigned hardware_mouse_cursor	: 1;
+		unsigned hardware_clipping	: 1;
+		unsigned transparent_bitblt	: 1;
+		unsigned reserved		: 25;
+	} __attribute__ ((packed)) Capabilities;
+	farptr VideoModePtr;
+	unsigned short TotalMemory;	/* in 64K blocks */
+	/* if VBE 2.0+ (else structure is 256 bytes) : */
+	unsigned short OemSoftwareRev;
+	farptr OemVendorNamePtr;
+	farptr OemProductNamePtr;
+	farptr OemProductRevPtr;
+
+	unsigned char Reserved[222];	/* ONLY VESA version 1.2- info */
+	unsigned char OemData[256];	/* will not kill VESA1.2- */
+} __attribute__ ((packed)) VESA_VbeInfoBlock;
+
+typedef struct {
+	struct vesa_mode_attribute_str ModeAttributes;
+	struct {
+		unsigned char win_exist		: 1;
+		unsigned char win_readable	: 1;
+		unsigned char win_writable	: 1;
+		unsigned char padding		: 5;
+	} __attribute__ ((packed)) WinAAttributes, WinBAttributes;
+	unsigned short WinGranularity;	/* in Kb */
+	unsigned short WinSize;	/* in Kb */
+	unsigned short WinASegment;
+	unsigned short WinBSegment;
+	farptr WinFuncPtr;
+	unsigned short BytesPerScanLine;
+	/* optional part, see "attribute.optional_info_available": */
+	unsigned short XResolution;	/* char in text modes,
+					   pixel in graphic modes */
+	unsigned short YResolution;
+	unsigned char XCharSize;
+	unsigned char YCharSize;
+	unsigned char NumberOfPlanes;
+	unsigned char BitsPerPixel;
+	unsigned char NumberOfBanks;	/* unused here : no multipaged screen */
+	enum { mem_text = 0, mem_CGA, mem_HGC, mem_EGA, mem_packedpixel,
+		mem_seq256, mem_HiColor24, mem_YUV
+	} MemoryModel : 8;
+	/* mem_seq256 = non chain 4 */
+	unsigned char BankSize;	/* in Kb, unused here */
+	unsigned char NumberOfImagePages;
+	unsigned char Reserved;
+	/* VBE 1.2+: */
+	struct vesa_color_layout_str layout;
+	struct {
+		unsigned char color_ramp_programmable	: 1;
+		unsigned char reserved_space_usable	: 1;
+	} __attribute__ ((packed)) DirectColorModeInfo;
+	/* VBE 2.0: */
+	unsigned PhysBasePtr;
+	unsigned OffScreenMemOffset;
+	unsigned short OffScreenMemSize;	/* in Kb */
+	unsigned char Reserved2[206];
+} __attribute__ ((packed)) VESA_modeinfo_t;
+
+extern inline unsigned
+_VESA_getinfo (VESA_VbeInfoBlock *VESA_info)
+{
+	unsigned short cmd_status = 0x4F00;
+
+	if (sizeof(VESA_VbeInfoBlock) != 512)
+		__ERROR();
+
+	asm (" int $0x10 # _VESA_getinfo "
+	     : "+a"(cmd_status), "=X" (*VESA_info)
+	     : "D"(VESA_info)	/* in fact %es:%di */
+	     );
+	return (cmd_status != 0x004F);
+}
+
+extern inline unsigned
+_VESA_getmodeinfo (VESA_modeinfo_t *VESA_modeinfo, unsigned short mode)
+{
+	unsigned short cmd_status = 0x4F01;
+
+	if (sizeof(VESA_modeinfo_t) != 256)
+		__ERROR();
+
+	asm (" int $0x10 # _VESA_getmodeinfo "
+	     : "+a" (cmd_status), "=X" (*VESA_modeinfo)
+	     : "c" (mode), "D" (VESA_modeinfo) /* in fact %es:%di */
+	    );
+	return (cmd_status != 0x004F);
+}
+
+extern inline unsigned _VESA_getmode (unsigned short *mode)
+{
+	unsigned short cmd_status = 0x4F03;
+
+	asm (" int $0x10 # _VESA_getmode "
+	     : "+a" (cmd_status),
+		"=b" (*mode) /* *mode contains bits 13, 14 & 15 */
+	     );
+	return (cmd_status != 0x004F);
+}
+
+extern inline unsigned _VESA_setDACwidth (unsigned char depth)
+{
+	unsigned short cmd_status = 0x4F08;
+	unsigned short result = depth << 8; /* %bl = 0 */
+
+	asm volatile (" int $0x10 # _VESA_setDACwidth "       /* VESA 1.2+ */
+	    : "+a" (cmd_status), "+b" (result)
+	    );
+	return (cmd_status != 0x004F || (result >> 8) != depth);
+}
+
+/* VESA 2.0+ */
+extern inline unsigned
+_VESA_GetPMinterface (farptr *addr, unsigned short *len)
+{
+	unsigned short cmd_status = 0x4F0A;
+
+	asm ("	pushl	%%es						\n"
+	     "	xorw	%%di,%%di					\n"
+	     "	mov	%%di,%%es					\n"
+	     "	int	$0x10		# _VESA_GetPMinterface		\n"
+	     "	pushw	%%es						\n"
+	     "	pushw	%%di						\n"
+	     "	popl	%%edi						\n"
+	     "	popl	%%es						\n"
+	     : "+a" (cmd_status), "=D" (*addr), "=c" (*len)
+	     : "b" (0), "c" ((unsigned short)0)
+	     );
+
+	return (cmd_status != 0x004F);
+}
+
+extern inline unsigned _EDID_detect (void)
+{
+	unsigned short cmd_status = 0x4F15, unknown;
+
+	asm (" int $0x10 # _EDID_detect"
+	     : "+a" (cmd_status), "=b" (unknown)
+	     : "b"((unsigned char)0)
+	     );
+	return (cmd_status != 0x004F);
+}
+
+extern inline unsigned _EDID_read (VBE_EDID_t *info)
+{
+	unsigned short cmd_status = 0x4F15;
+
+	if (sizeof(VBE_EDID_t) != 0x80)
+		__ERROR();
+
+	asm (" int $0x10 # _EDID_read"
+	     : "+a" (cmd_status), "=X" (*info)
+	     : "b" ((unsigned char) 1), "D" (info),	/* in fact %es:%di */
+	       "c"(0), "d"(0)
+	     );
+	/* returns 0x014F if monitor non EDID */
+	return (cmd_status != 0x004F);
+}
+
+/**
+ ** Disk BIOS:
+ **/
+extern inline unsigned
+_BIOSDISK_getparam (unsigned char disk,
+	            unsigned short *tmpcx, unsigned short *tmpdx,
+	            farptr *DBTadr, unsigned char *CmosDriveType,
+	            unsigned char *status)
+{
+	unsigned char carry;
+
+	asm ("	pushl	%%es		\n"
+	     "	xorw	%%di,%%di	\n"
+	     "	mov	%%di,%%es	\n"
+	     "	int	$0x13		# _BIOSDISK_getparam	\n"
+	     "	pushw	%%es		\n"
+	     "	pushw	%%di		\n"
+	     "	popl	%%edi		\n"
+	     "	popl	%%es		\n"
+	     "	mov	%%ah,%1		\n"
+	     "	setc	%0		\n"
+	     : "=qm" (carry), "=qm" (*status), "=c" (*tmpcx), "=d" (*tmpdx),
+			"=b" (*CmosDriveType), "=D" (*DBTadr)
+	     : "a"((unsigned short)0x0800), "d" (disk), "b" (0)
+	     );
+
+	return carry;
+}
+
+extern inline unsigned char
+_BIOSDISK_gettype (unsigned char disk, unsigned *nbsect, unsigned char *status)
+{
+	unsigned char carry;
+	unsigned dummy;
+
+	asm ("	xor	%%dh,%%dh				\n"
+	     "	xor	%%cx,%%cx				\n"
+	     "	int	$0x13		# _BIOSDISK_gettype	\n"
+	     "	shll	$16,%%ecx				\n"
+	     "	movw	%%dx,%%cx				\n"
+	     "	movb	%%ah,%1					\n"
+	     "	setc	%0					\n"
+	     : "=qm" (carry), "=qm" (*status), "=c" (*nbsect), "=d" (dummy)
+	     : "a" ((unsigned short)0x1500),
+		"d" (disk)	/* disk = 0x80..0x8F else old Compaq bug */
+	     );
+
+	return carry;
+}
+
+/*
+ * Would be nice for gcc to accept '"=D" (diskinfo)' to remove
+ * this 'lea %1,%%edi'
+ * It is similar to function returning big structures.
+ */
+extern inline union drive_info __attribute__ ((const))
+get_drive_info (farptr indirect_ptr)
+{
+	union drive_info diskinfo;
+	unsigned nbbyte = sizeof(diskinfo), dummy;
+
+	asm ("	pushl	%%esi				\n"
+	     "	popw	%%si				\n"
+	     "	popw	%%fs				\n"
+	     "	pushl	%%fs:(%%si)			\n"
+	     "	popw	%%si				\n"
+	     "	popw	%%fs				\n"
+	     "	lea	%1,%%edi			\n"
+	     "	cld					\n"
+	     "	rep movsb %%fs:(%%si),%%es:(%%di)	\n"
+	     : "+S" (indirect_ptr), "=g" (diskinfo), "+c" (nbbyte), "=D" (dummy)
+	     );
+	return diskinfo;
+}
+
+extern inline unsigned char
+_BIOSDISK_RWsector (unsigned char drive,
+		    unsigned short cylinder, unsigned char head,
+		    unsigned char sector, unsigned char nbsector,
+		    farptr buffer, const unsigned read)
+{
+	unsigned short result, buggy_bios;
+
+	asm volatile ("	pushl	%%es				\n"
+		      "	pushl	%%ebx				\n"
+		      "	popw	%%bx				\n"
+		      "	popw	%%es				\n"
+		      "	stc		# buggy BIOSes		\n"
+		      "	int	$0x13   # _BIOSDISK_RWsector	\n"
+		      "	sti		# buggy BIOSes		\n"
+		      "	popl	%%es				\n"
+		      "	setc	%%al				\n"
+		      : "=a" (result), "=d" (buggy_bios)
+		      : "a" ((read? 0x0200 : 0x0300) | nbsector),
+			"b" (buffer),
+			"c" ((cylinder << 8) | ((cylinder >> 2) & 0xC0)
+					| (sector & 0x3F)),
+			"d" ((((unsigned short)head) << 8) | drive)
+		      );
+	if (result & 0x00FF)
+		return result >> 8;
+	return 0;
+}
+
+typedef struct {
+	unsigned short buffersize;
+	unsigned short infobit;
+	unsigned nbcylinder;
+	unsigned nbhead;
+	unsigned nbsectorpertrack;
+	unsigned long long nbtotalsector;
+	unsigned short bytepersector;
+	/* V2.0+ : */
+	farptr configptr;	/* for instance ebiosPhoenix realmode address */
+	/* V3.0+ : */
+	unsigned short signature0xBEDD;
+	unsigned char lendevicepath;	/* 0x24 for v3.0 */
+	unsigned char reserved[3];
+	unsigned char bustype[4];	/* exactly "ISA" or "PCI" */
+	unsigned char Interface[8];	/* exactly "ATA", "ATAPI",
+						 "SCSI", "USB"... */
+	union interface_path_u {
+		struct {
+			unsigned short addr;
+			unsigned char pad[6];
+		} __attribute__ ((packed)) isa;
+		struct {
+			unsigned char busnr;
+			unsigned char devicenr;
+			unsigned char functionnr;
+			unsigned char pad[5];
+		} __attribute__ ((packed)) pci;
+	} bus;
+	union device_path_u {
+		struct {
+			unsigned char slave;	/* 0 if master, 1 if slave */
+			unsigned char pad[7];
+			unsigned long long reserved;	// Not present in some docs...
+		} __attribute__ ((packed)) ata;
+		struct {
+			unsigned char slave;	/* 0 if master, 1 if slave */
+			unsigned char logical_unit_nr;
+			unsigned char pad[6];
+		} __attribute__ ((packed)) atapi;
+		struct {
+			unsigned char logical_unit_nr;
+			unsigned char pad[7];
+		} __attribute__ ((packed)) scsi;
+		struct {
+			unsigned char tobedefined;
+			unsigned char pad[7];
+		} __attribute__ ((packed)) usb;
+		struct {
+			unsigned long long FireWireGeneralUniqueID;
+		} __attribute__ ((packed)) ieee1394;
+		struct {
+			unsigned long long WorldWideNumber;
+		} __attribute__ ((packed)) FibreChannel;
+	} device;
+	unsigned char zero;
+	unsigned char bytechecksum;	/* byte sum [0x1E..0x49] = 0 */
+} __attribute__ ((packed)) ebiosinfo_t;
+
+typedef struct {
+	unsigned short extended_fct	: 1;
+	unsigned short removable	: 1;
+	unsigned short enhanced		: 1;
+	unsigned short reserved		: 13;
+} __attribute__ ((packed)) ebios_bitmap_t;
+
+extern inline unsigned char
+_EBIOSDISK_probe (unsigned char disk, unsigned char *version,
+		  unsigned char *extension, ebios_bitmap_t *bitmap)
+{
+	unsigned char carry;
+	unsigned short signat0xAA55;
+
+	asm ("       int     $0x13           # _EBIOSDISK_probe      \n"
+	     "       mov     %%ah,%1                                 \n"
+	     "       mov     %%dh,%2                                 \n"
+	     "       setc    %0                                      \n"
+	     : "=qm" (carry), "=qm" (*version), "=qm" (*extension),
+		"=b" (signat0xAA55), "=c" (*bitmap)
+	     : "a" ((unsigned short)0x4100), "b" ((unsigned short)0x55AA),
+		"d"(disk)
+	     );
+
+	return carry || (signat0xAA55 != 0xAA55);
+}
+
+extern inline unsigned char
+_EBIOSDISK_getparam (unsigned char disk, ebiosinfo_t *ebiosinfo,
+		     unsigned char *status)
+{
+	unsigned char carry;
+
+	asm ("       int     $0x13           # _EBIOSDISK_getparam   \n"
+	     "       mov     %%ah,%1                                 \n"
+	     "       setc    %0                                      \n"
+	     : "=qm" (carry), "=qm" (*status)
+	     : "a" ((unsigned short)0x4800), "d" (disk), "S" (ebiosinfo)
+	    );
+
+	return carry;
+}
+
+/*
+ * Well, I do not know what that does, but because it is included in Linux
+ * kernel it has to be GPL - source code given in its most readable form...
+ */
+extern inline struct X86SpeedStepSmi_s
+_X86SpeedStepSmi (void)
+{
+	struct X86SpeedStepSmi_s ret;
+
+	asm(" int  $0x15	# _X86SpeedStepSmi "
+	    : "=a" (ret.data1), "=b" (ret.data2),
+		"=c" (ret.data3), "=d" (ret.data4)
+	    : "a" (0x0000E980), "d" (0x47534943) );
+	return ret;
+}
+
+/**
+ ** Fill in each of the sub-structures:
+ **/
+CODE static inline void
+vmlinuz_EGA (struct screen_info *screen_info)
+{
+	union EGA_bx_union EGA_bx;
+	struct EGA_cx_str EGA_cx;
+
+	_EGA_getdisplay(&EGA_bx, &EGA_cx);
+	screen_info->orig_video_ega_bx = EGA_bx.IOaddr_memory;
+	screen_info->orig_video_isVGA = 0;
+	if (EGA_bx.enums.IOaddr == EGA_COLOR_3Dx
+	    || EGA_bx.enums.IOaddr == EGA_MONO_3Bx) {
+		unsigned char active_dcc, alternate_dcc;
+
+		if (_VGA_get_display_combination_code(&active_dcc,
+						      &alternate_dcc) == 0)
+			screen_info->orig_video_isVGA = 1;
+
+		screen_info->orig_video_lines = peekb((farptr)0x00400084) + 1;
+		screen_info->orig_font_height = peekw((farptr)0x00400085);
+	} else {	/* EGA_bx.enums.IOaddr unchanged => CGA/MDA/HGA */
+		screen_info->orig_video_lines = 25;
+		screen_info->orig_font_height = 0;	/* i.e. invalid */
+	}
+}
+
+CODE static inline void
+vmlinuz_getcursor (struct screen_info *screen_info)
+{
+#if 1		/* what is the best ? IHMO using the BIOS functions */
+	unsigned char row, col;
+	unsigned char cursorstart, cursorstop;
+
+	_VGA_getcursor(screen_info->orig_video_page,
+		       &row, &col, &cursorstart, &cursorstop);
+	screen_info->orig_x = col;
+	screen_info->orig_y = row;
+#else
+	farptr ptr = 0x00400050 + 2 * screen_info->orig_video_page;
+
+	screen_info->orig_x = peekb(ptr);
+	screen_info->orig_y = peekb(ptr + 1);
+#endif
+}
+
+CODE static inline void
+vmlinuz_VGA (struct screen_info *screen_info, int proposed_line)
+{
+	unsigned char mode, nbcol, page;
+
+	mode = _VGA_getmode(&nbcol, &page);
+	screen_info->orig_video_mode = mode & 0x7F;
+	screen_info->orig_video_cols = nbcol;
+	screen_info->orig_video_page = page;	/* not tested if != 0 */
+	if (proposed_line >= 0) {
+		screen_info->orig_y = proposed_line;
+		screen_info->orig_x = 0;
+	} else {
+		vmlinuz_getcursor(screen_info);
+		/* We try not to erase the text written later by Gujin: */
+		screen_info->orig_x = 0;
+		if (screen_info->orig_y + 4 < screen_info->orig_video_lines)
+			screen_info->orig_y += 4;
+		else
+			screen_info->orig_y = screen_info->orig_video_lines - 1;
+	}
+}
+
+CODE static inline void
+vmlinuz_VESA (struct screen_info *screen_info, unsigned mode)
+{
+	VESA_modeinfo_t modeinfo;
+
+	if (_VESA_getmodeinfo(&modeinfo, mode & 0x01FF) == 0) {
+		if (modeinfo.MemoryModel == mem_text
+			&& modeinfo.NumberOfPlanes == 4) {
+			/* correct some buggy video BIOS: */
+			modeinfo.BytesPerScanLine = 2 * modeinfo.XResolution;
+			modeinfo.BitsPerPixel = 4;
+		}
+		if (modeinfo.MemoryModel == mem_text)
+			screen_info->lfb_base = 0xB8000;
+		else if (modeinfo.ModeAttributes.linear_framebuffer_supported) {
+			/* no text modes with linear framebuffer */
+			screen_info->orig_video_isVGA = 0x23;
+			screen_info->lfb_base = modeinfo.PhysBasePtr;
+		} else
+			screen_info->lfb_base = 0xA0000;
+		screen_info->lfb_linelength = modeinfo.BytesPerScanLine;
+		screen_info->lfb_width = modeinfo.XResolution;
+		screen_info->lfb_height = modeinfo.YResolution;
+		screen_info->lfb_depth = modeinfo.BitsPerPixel;
+		screen_info->lfb_pages = modeinfo.NumberOfImagePages;
+		screen_info->vesa_attrib = modeinfo.ModeAttributes;
+		screen_info->layout = modeinfo.layout;
+	} else
+		screen_info->lfb_base = 0;
+}
+
+CODE static void
+vmlinuz_VIDEO (struct screen_info *screen_info, unsigned short *acpi_vidmode,
+	       int proposed_line)
+{
+	VESA_VbeInfoBlock infoblock;
+
+	vmlinuz_EGA(screen_info);
+	vmlinuz_VGA(screen_info, proposed_line);
+	*acpi_vidmode = screen_info->orig_video_mode;
+
+	/* normaly only for graphic modes: */
+	if (_VESA_getinfo(&infoblock) == 0) {
+		unsigned short mode, len;
+		farptr addr;
+
+		screen_info->lfb_size = infoblock.TotalMemory;
+		if (_VESA_getmode(&mode) == 0) {
+			vmlinuz_VESA(screen_info, mode);
+			*acpi_vidmode = mode;
+#if 0	/* After doing that, we should program again the DAC with the right values... */
+			/* Linux do not manage text modes and DAC 8 bits: */
+			if (screen_info->lfb_base != 0xB8000
+				 && screen_info->lfb_depth <= 8
+				 && infoblock.Capabilities.DAC8bit_present) {
+				if (_VESA_setDACwidth (8) == 0) {
+					screen_info->layout = (const struct vesa_color_layout_str){
+						{8, 0}, {8, 0}, {8, 0}, {8, 0}};
+				}
+				else {
+					screen_info->layout = (const struct vesa_color_layout_str){
+						{6, 0}, {6, 0}, {6, 0}, {6, 0}};
+				}
+			}
+#endif
+		}
+
+		/* Note: We can have a PM interface even if getmodeinfo
+		   failed, for instance if we are in text mode 3 */
+		if (_VESA_GetPMinterface(&addr, &len) == 0) {
+			screen_info->vesapm_seg = addr >> 16;
+			screen_info->vesapm_off = addr & 0xFFFF;
+		}
+	}
+}
+
+CODE static inline unsigned short vmlinuz_EXT_MEM_K (void)
+{
+	unsigned short EXT_MEM_K;
+
+	if (_BIOS_getExtendedMemory(&EXT_MEM_K) != 0 || EXT_MEM_K == 0)
+		EXT_MEM_K = (((unsigned short)getnvram(0x18)) << 8)
+				+ getnvram(0x17);
+	return EXT_MEM_K;
+}
+
+CODE static inline void
+vmlinuz_APM (struct apm_bios_info *apm_bios_info)
+{
+	if (_APM_installation_check(&apm_bios_info->version,
+				   &apm_bios_info->flags) == 0) {
+		_APM_disconnect();	/* ignore possible error */
+		if ((apm_bios_info->flags & 2) == 0) {
+			/* no 32 bits support, ignore APM */
+		} else if (_APM_connect_32bit(&apm_bios_info->cseg,
+					     &apm_bios_info->offset,
+					     &apm_bios_info->cseg_16,
+					     &apm_bios_info->dseg,
+					     &apm_bios_info->cseg_len,
+					     &apm_bios_info->dseg_len) != 0) {
+			apm_bios_info->flags &= ~2; /* remove 32bits support */
+		} else {
+			/* Redo the installation check as the 32 bit connect
+				modifies the flags returned on some BIOSs : */
+			if (_APM_installation_check(&apm_bios_info->version,
+						&apm_bios_info->flags) != 0) {
+				apm_bios_info->flags &= ~2;
+				_APM_disconnect();
+			}
+		}
+	}
+}
+
+CODE static inline void
+vmlinuz_CONFIG (struct sys_desc_table_info *sys_desc_table)
+{
+	farptr adr = _BIOS_getConfiguration();
+
+	if (adr != 0)
+		*sys_desc_table = get_bios_conf(adr);
+}
+
+CODE static inline void
+vmlinuz_EDID (VBE_EDID_t *edid_data)
+{
+	if (_EDID_detect() != 0 || _EDID_read(edid_data) != 0) {
+		unsigned char *ptr = (unsigned char *)edid_data;
+		unsigned cpt = sizeof(VBE_EDID_t);
+		/* failed, reset complete area: */
+		while (--cpt)
+			*ptr++ = 0x13;
+	}
+}
+
+CODE static inline unsigned
+vmlinuz_E820 (struct e820map_info *e820map, unsigned e820map_nb)
+{
+	unsigned cont_val = 0, bufsize = e820map_nb * sizeof(struct e820map_info);
+	unsigned char *ptr = (unsigned char *)e820map;
+
+	while (_BIOS_QueryMemoryMap(&cont_val, &bufsize, &ptr) == 0
+	       && cont_val != 0
+	       && bufsize >= sizeof(struct e820map_info))
+		continue;
+	return (e820map_nb * sizeof(struct e820map_info) - bufsize)
+		/ sizeof(struct e820map_info);
+}
+
+CODE static inline unsigned
+vmlinuz_MBRSIG (unsigned *MBRSIG, unsigned total_MBRSIG_entries)
+{
+	unsigned buffer[512 / sizeof(unsigned)], cpt;
+#define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
+
+	for (cpt = 0; cpt < total_MBRSIG_entries; cpt++) {
+		if (_BIOSDISK_RWsector(0x80 + cpt, 0, 0, 1, 1,
+					 stack_farptr(buffer), 1) != 0)
+			return cpt;
+		*MBRSIG++ = buffer[EDD_MBR_SIG_OFFSET / sizeof(unsigned)];
+	}
+	return cpt;
+}
+
+CODE static inline unsigned
+vmlinuz_EDD (struct edd_info *edd, unsigned total_EDD_entries)
+{
+	unsigned cpt, eddcpt;
+
+	for (cpt = eddcpt = 0; cpt < 16 && eddcpt < total_EDD_entries; cpt++) {
+		unsigned char extension, status;
+		unsigned short tmpcx, tmpdx;
+		farptr DBTadr;
+		unsigned char CmosDriveType, stat;
+		struct edd_info *eddptr = &edd[eddcpt];
+
+		if (_EBIOSDISK_probe(0x80 + cpt, &eddptr->version, &extension,
+			     (ebios_bitmap_t *) &eddptr->interface_support))
+			continue;
+		eddptr->device = 0x80 + cpt;
+		eddptr->params.length = sizeof(eddptr->params);
+		eddptr->params.info_flags = 0;	/* buggy BIOS ? */
+		/* Don't check for fail return, it doesn't matter: */
+		_EBIOSDISK_getparam(0x80 + cpt,
+				(ebiosinfo_t *) &eddptr->params, &status);
+		if (_BIOSDISK_getparam(0x80 + cpt, &tmpcx, &tmpdx,
+				&DBTadr, &CmosDriveType, &stat) != 0) {
+			eddptr->max_cyl = 0;
+			eddptr->max_sect = eddptr->max_head = 0;
+		} else {
+			eddptr->max_head = tmpdx >> 8;
+			eddptr->max_sect = tmpcx & 0x3F;
+			eddptr->max_cyl = ((tmpcx & 0xC0) << 2) | (tmpcx >> 8);
+		}
+		eddcpt++;
+	}
+	return eddcpt;
+}
+
+
+/**
+ ** Command line stuff:
+ **/
+CODE static inline void
+vmlinuz_CMDLINE (char *command_line, const unsigned char *proposed_cmdline,
+		 farptr extra_cmdline_farptr,
+		 const char *cmdline_name, const char *cmdline_extraparam)
+{
+	char *cmdptr = command_line;
+
+	/* insert at beginning the name of the uncompressed GZIP file: */
+	if (cmdline_name && *cmdline_name) {
+		do
+			*cmdptr++ = *cmdline_name++;
+		while (*cmdline_name);
+		*cmdptr++ = ' ';
+	}
+
+	/* insert then: console=ttyS?,9600,n,7 or video=vesa,
+		keyboard=??, NumLock=on/off, mouse=/dev/psaux,
+		COLS=, LINES= proposed by Gujin */
+	if (proposed_cmdline && *proposed_cmdline) {
+		do
+			*cmdptr++ = *proposed_cmdline++;
+		while (*proposed_cmdline);
+		*cmdptr++ = ' ';
+	}
+
+	/* Add nearby end the Gujin gujin_param.extra_cmdline field: */
+	/* We assume there gujin_param.extra_cmdline is correctly zero terminated */
+	/* Note: we will have "root=" parameter from Gujin setup screen first,
+	   so that if the one in the GZIP comment if erroneous, we can just
+	   overwrite it with the Gujin setup (TOCHECK: when two "root=" are
+	   given on the command line, only the first one is taken) */
+	if (extra_cmdline_farptr != 0 && peekb(extra_cmdline_farptr) != 0) {
+		*cmdptr++ = ' '; /* two spaces as separator */
+		for (;;) {
+			*cmdptr = peekb(extra_cmdline_farptr++);
+			if (*cmdptr < ' ') { /* stop at \0, \n, \r or \t */
+				*cmdptr = '\0';
+				break;
+			}
+			cmdptr++;
+		}
+	}
+
+	/* add at end the params in the comment part of the GZIP file: */
+	/* This may or may not stop at the first newline */
+	if (cmdline_extraparam && *cmdline_extraparam) {
+		*cmdptr++ = ' ';
+		do
+			*cmdptr++ = *cmdline_extraparam++;
+		while (*cmdline_extraparam != 0 && *cmdline_extraparam != '\n');
+	}
+	*cmdptr = '\0';
+}
+
+struct desc_str;
+struct gpl_compliant_str;
+
+CODE static inline void
+vmlinuz_DISKS (union drive_info *drive1, union drive_info *drive2)
+{
+	unsigned nbsect;
+	unsigned char status, disk = 0x80;
+	union drive_info *drive = drive1;
+	farptr vectoradr = (farptr)(0x41 * 4);
+
+	while (disk <= 0x81) {
+		if (_BIOSDISK_gettype (disk, &nbsect, &status) == 0)
+			*drive = get_drive_info (vectoradr);
+		disk++;
+		vectoradr = (farptr)(0x46 * 4);
+		drive = drive2;
+	}
+}
+
+/**
+ ** THE function:
+ **/
+struct LOADER_str {
+	unsigned short sizeof_loader_str, sizeof_fileload_str;
+	struct fileload_str {
+		/* input: */
+		unsigned load_address, max_size;
+		/* only for XMS use: */
+		unsigned short handle, KBalloced;
+		/* For reference: */
+		unsigned BOOTWAY_desc_index;
+		/* output: */
+		unsigned compressed_size, uncompressed_size;
+	} fileload[3], *curfileload;	/* kernel and initrd */
+	int initrd_index;
+	unsigned short minor_major_root;
+	unsigned short license_compliant;
+	unsigned vmlinuz_byte_treated; /* header + kernel GZIP */
+	unsigned base_real_fct; /* linear address inside uncompressed kernel */
+	unsigned handle_real_fct;
+	unsigned accept_uncompressed_initrd_filesize;
+	unsigned reserved[6];
+	/* Initialised from the "comment" line of the GZIP file */
+	union {
+		unsigned array[32];
+		struct {
+			unsigned NONGPL_productID;
+			unsigned NONGPL_productNB;
+			unsigned min_gujin_version;	/* 0x100 for 1.0 */
+			unsigned late_relocation_address;
+			unsigned runadr;
+			unsigned paramadr;	/* usually 0x00080000 */
+			unsigned realfct_size;	/* in bytes */
+			unsigned minram;	/* in kilobytes */
+			unsigned option;
+			unsigned maskcpu;
+			unsigned maskDflags; /* request those bits set,
+					cpuid 0x00000001 in edx (usual) */
+			unsigned maskCflags; /* request those bits set,
+					cpuid 0x00000001 in ecx (new) */
+			unsigned maskBflags; /* unused on PCs */
+			unsigned maskAflags; /* request those bits set,
+					cpuid 0x80000001 */
+			unsigned maskvesa; /* if bit (8-1) set,
+						VESA 8BPP supported */
+			unsigned maskresolution; /* bit set => exclude
+						those modes */
+		} elem;
+	} comment;
+	/* related to Linux version: */
+	char cmdline_extraparam[512];
+	char cmdline_name[128];
+};
+
+CODE __attribute__ ((cdecl, regparm(0))) unsigned
+linux_set_params (unsigned local_return_address,
+		  unsigned totalmem,
+		  struct loader_t bootloader_type,
+		  struct linux_param *LnxParam,
+		  const struct LOADER_str *loader,
+		  const struct gpl_compliant_str *togpl,
+		  const struct desc_str *system_desc,
+		  int proposed_row,
+		  char **stringptr,
+		  unsigned char *proposed_cmdline)
+{
+	unsigned char *ptr;
+	unsigned nb_slash_in_kernelname = 0;
+	test_linux_param_struct();
+
+	vmlinuz_VIDEO (&LnxParam->screen_info, &LnxParam->in_out.vid_mode,
+		      proposed_row);
+
+	/* Just needed for old kernels, before 2.2.x: */
+	LnxParam->screen_info.EXT_MEM_K = vmlinuz_EXT_MEM_K();
+
+	/* old Command Line magic for 2.2- kernels: */
+	LnxParam->screen_info.CL_MAGIC = 0xA33F;
+	LnxParam->screen_info.CL_OFFSET = offsetof(struct linux_param,
+						   command_line);
+	/* New Command Line magic for 2.4+ kernels: */
+	LnxParam->in_out.cmd_line_ptr = loader->comment.elem.paramadr
+	    + offsetof (struct linux_param, command_line);
+
+//  LnxParam->in_out.header_signature.longword = { { 'H', 'd', 'r', 'S' } };
+	LnxParam->in_out.header_version_number = 0x0202;
+	LnxParam->in_out.ramdisk_image = loader->fileload[1].load_address;
+	LnxParam->in_out.ramdisk_size = loader->fileload[1].uncompressed_size;
+	LnxParam->in_out.type_of_loader = bootloader_type;
+
+	LnxParam->ALT_MEM_K = totalmem;
+
+	vmlinuz_APM (&LnxParam->apm_bios_info);
+
+	LnxParam->X86SpeedStepSmi = _X86SpeedStepSmi();
+	vmlinuz_DISKS (&LnxParam->drive1, &LnxParam->drive2);
+	vmlinuz_CONFIG (&LnxParam->sys_desc_table);
+	/* do vmlinuz_EDID() before vmlinuz_E820() so that if the later
+	 function describes more than 18 (and less than 32) blocks of memory,
+	 the more important information erases the less important one.
+	 Since 2.6.12 there isn't any overwrite problem.*/
+	vmlinuz_EDID (&LnxParam->edid_data);
+	LnxParam->nb_E820_entries = vmlinuz_E820 (LnxParam->e820map,
+		sizeof(LnxParam->e820map) / sizeof(LnxParam->e820map[0]));
+
+	/* Now the command line stuff: */
+	vmlinuz_CMDLINE (LnxParam->command_line, proposed_cmdline,
+			*(farptr *)stringptr,
+			loader->cmdline_name, loader->cmdline_extraparam);
+
+	for (ptr = LnxParam->command_line; *ptr != '\0'; ptr++) {
+		// no .rodata.str1.1 section so cannot do:
+		// union { char c[4]; unsigned u; } prefix = { .c = "edd=" };
+		union { char c[4]; unsigned u; } prefix = {
+				 .c = {'e', 'd', 'd', '='} };
+		if (*(unsigned *)ptr == prefix.u)
+			break;
+		}
+	/* I do not know about edd=skipmbr, if there is a read error
+		Gujin will not even boot up to there... */
+	if (*ptr == '\0' || ptr[4] != 'o' || ptr[5] != 'f' || ptr[6] != 'f') {
+		LnxParam->nb_MBRSIG_entries = vmlinuz_MBRSIG (LnxParam->MBRSIG,
+			sizeof(LnxParam->MBRSIG)/sizeof(LnxParam->MBRSIG[0]));
+		LnxParam->nb_EDD_entries = vmlinuz_EDD (LnxParam->edd,
+			sizeof(LnxParam->edd)/sizeof(LnxParam->edd[0]));
+	}
+
+	for (ptr = LnxParam->command_line; *ptr != '\0'; ptr++) {
+#define endparam(c) ((c) == ' ' || (c) == '\n' || (c) == '\t' || (c) == '\0')
+		if (ptr[0] == 'r' && (ptr[1] == 'w' || ptr[1] == 'o')
+				  && endparam(ptr[2])) {
+			LnxParam->in_out.root_flags.read_only
+					= (ptr[1] == 'w')? 0 : 1;
+			break;
+		} else {
+			while (!endparam(*ptr))
+				ptr++;
+		}
+	}
+
+	if (loader->cmdline_name)
+		for (ptr = (unsigned char *)loader->cmdline_name;
+		     *ptr != '\0';
+		     ptr++)
+			if (*ptr == '/')
+				nb_slash_in_kernelname++;
+
+	test_vgaprint();
+
+	*stringptr = 0; /* Gujin will not print anything by default */
+//	*stringptr = LnxParam->command_line;
+
+	return 0;
+}
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/arch/i386/kernel/setup.c linux-2.6.13-2/arch/i386/kernel/setup.c
--- linux-2.6.13-1/arch/i386/kernel/setup.c	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13-2/arch/i386/kernel/setup.c	2005-08-31 00:44:45.000000000 +0100
@@ -701,6 +701,18 @@ static void __init parse_cmdline_early (
 	/* Save unparsed command line copy for /proc/cmdline */
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
+	/*
+	 * If the command line begin with '/', it is the filename of the
+	 * kernel file - like a shell command line. That can be used to
+	 * deduce where root was located when the kernel was compiled,
+	 * inside a directory of root named /boot, inside a small partition
+	 * mounted on a directory of root named /boot or in the root
+	 * directory itself.
+	 */
+	if (*from == '/')
+		while (*from != ' ' && *from != '\t' && *from != '\n' && *from != '\0')
+			from++;
+
 	for (;;) {
 		if (c != ' ')
 			goto next_char;
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/arch/i386/kernel/vmlinux.lds.S linux-2.6.13-2/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.13-1/arch/i386/kernel/vmlinux.lds.S	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13-2/arch/i386/kernel/vmlinux.lds.S	2005-08-31 00:45:24.000000000 +0100
@@ -11,9 +11,38 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(phys_startup_32)
+NOCROSSREFS(.realmode .text)
+NOCROSSREFS(.realmode .data)
+NOCROSSREFS(.realmode .rodata)
 jiffies = jiffies_64;
 SECTIONS
 {
+  /* realmode BIOS (initialisation only) boot code/data area.
+   * Here, segment .code16 is relocatable but .data16 is not.
+   * To see the assembler of compiled file realmode.c:
+   *   objdump -D -m i8086 arch/i386/kernel/realmode.o
+   *   objdump -d --section=.realmode -m i8086 vmlinux
+   */
+  .realmode 0 : AT (_end - LOAD_OFFSET) {
+	*(.init.text16)
+	. = ALIGN(16);
+	_sdata16 = .;
+	*(.rodata16* .data16 .bss16)
+	. = ALIGN(16);
+	_edata16 = .; /* maximum 0x1000 i.e. 4 Kb limit */
+	*(.text16)
+	. = ALIGN(16);
+	_end16 = .;
+	/* This may be used one day - keep a 16 bytes block at end of file: */
+	LONG(0)
+	LONG(SIZEOF (.realmode))
+	LONG(ADDR (.realmode))
+	BYTE(0x42) /* 'B' */
+	BYTE(0x49) /* 'I' */
+	BYTE(0x4F) /* 'O' */
+	BYTE(0x53) /* 'S' */
+	} = 0x9090
+
   . = __KERNEL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/include/asm-i386/realmode.h linux-2.6.13-2/include/asm-i386/realmode.h
--- linux-2.6.13-1/include/asm-i386/realmode.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-2/include/asm-i386/realmode.h	2005-08-31 00:42:07.000000000 +0100
@@ -0,0 +1,521 @@
+/*
+ *  This file "realmode.h" is licensed with the same license as the Linux
+ * kernel, and anyway the mapping of the data structure produced is owned
+ * by Linux kernel copyright owner(s) - for a long time.
+ *  More information in the "realmode.c" file.
+ *
+ *  First version has been written by Etienne Lorrain in December 2004.
+ * This patch cannot really be applied to Linux-2.11 and before without
+ * loosing the EDD and EDID infomation which moved in Linux-2.6.12
+ */
+
+/* 16 bits segment in MSB, 16 bits offset in LSB: */
+typedef unsigned farptr;
+
+#define offsetof(type, field)	((unsigned)(&(((type *)0)->field)))
+
+/*
+ * This shall always be optimised away because the test has to be false,
+ * it shall produce an error in the build process.
+ * Flag to add to the linker ld: --undefined=__ERROR
+ */
+void __ERROR(void);
+
+/**
+ ** Mapping of the total structure exchanged in between the BIOS
+ ** boot code (in real mode) and the Linux kernel (in protected mode):
+ **
+ ** Some of those structures have to be put back in their corresponding
+ ** file - they are here until the big cleaning process begin...
+ **/
+struct screen_info {	/* stolen^Wckeckout from linux/include/linux/tty.h */
+	unsigned char orig_x;
+	unsigned char orig_y;
+	unsigned short EXT_MEM_K;	/* general info */
+	unsigned char undefined;
+	unsigned char orig_video_page;
+	unsigned char orig_video_mode;
+	unsigned char orig_video_cols;
+	unsigned short unused2;
+	unsigned short orig_video_ega_bx;
+	unsigned short unused3;
+	unsigned char orig_video_lines;
+	unsigned char orig_video_isVGA;
+	unsigned short orig_font_height;
+	/* VESA graphic mode -- linear frame buffer */
+	unsigned short lfb_width;
+	unsigned short lfb_height;
+	unsigned short lfb_depth;
+	unsigned lfb_base;
+	unsigned lfb_size;
+	unsigned short CL_MAGIC;	/* 0xA33F, general info */
+	unsigned short CL_OFFSET;	/* general info */
+	unsigned short lfb_linelength;
+	struct vesa_color_layout_str {
+		struct {
+			unsigned char MaskSize;
+			unsigned char FieldPosition;
+		}  __attribute__ ((packed)) Red, Green, Blue, Rsvd;
+	} __attribute__ ((packed)) layout;
+	unsigned short vesapm_seg;
+	unsigned short vesapm_off;
+	unsigned short lfb_pages;
+	struct vesa_mode_attribute_str {
+		/* VESA: */
+		unsigned short mode_supported		: 1;	/* e.g. enought RAM for it */
+		unsigned short optional_info_available	: 1;
+		unsigned short BIOS_output_supported	: 1;
+		unsigned short color_mode		: 1;	/* else monochrome */
+		unsigned short graphic_mode		: 1;	/* else text mode */
+		/* VBE 2.0: */
+		unsigned short mode_not_VGA_compatible	: 1;
+		unsigned short no_VGA_compatible_window	: 1;
+		unsigned short linear_framebuffer_supported	: 1;
+		unsigned short reserved			: 8;
+	} __attribute__ ((packed)) vesa_attrib;
+	/* 0x36 -- 0x3f reserved for future expansion */
+	unsigned char reserved[10];
+} __attribute__ ((packed));
+
+struct apm_bios_info {
+	unsigned short version;
+	unsigned short cseg;
+	unsigned offset;
+	unsigned short cseg_16;
+	unsigned short dseg;
+	unsigned short flags;
+	unsigned short cseg_len;
+	unsigned short unused;	/* cseg_16_len */
+	unsigned short dseg_len;
+} __attribute__ ((packed));
+
+/* See probe_cmos_for_drives() in linux/drivers/ide/ide-geometry.c */
+/* rarely used, also check for CMOS address 0x12 (int 0x41, 0x46) */
+union drive_info {
+	struct FDPT_str {
+		unsigned short phy_cyl;
+		unsigned char phy_head;
+		unsigned short start_reduced_write_current_cyl;	/* PC XT only */
+		unsigned short start_write_precomp_cyl;
+		unsigned char max_ECC_burst_length;		/* PC XT only */
+		union drive_ctl_byte_u {
+			struct {
+				unsigned char drive_step_speed:3;
+				unsigned char unused:3;
+				unsigned char disable_ecc_retry:1;
+				unsigned char disable_access_retry:1;
+			} __attribute__ ((packed)) xt;
+			struct {
+				unsigned char unused:1;
+				unsigned char disable_irq:1;	/* 0 */
+				unsigned char no_reset:1;	/* 0 */
+				unsigned char more_than_8_heads:1;
+				unsigned char always_0:1;
+				unsigned char manuf_defect_map_on_maxcyl:1;	/* AT + */
+				unsigned char disable_ecc_retry:1;
+				unsigned char disable_access_retry:1;
+			} __attribute__ ((packed)) at;
+			unsigned char all;
+		} drive_ctl_byte;
+		unsigned char standard_timeout;		/* PC XT only */
+		unsigned char formating_timeout;	/* PC XT only */
+		unsigned char check_drive_timeout;	/* PC XT only */
+		unsigned short landing_zone_cylinder;	/* PC AT+ */
+		unsigned char phy_sect;			/* PC AT+ */
+		unsigned char reserved;
+	} __attribute__ ((packed)) fdpt;
+	/* For translating BIOSes: */
+	struct EDPT_str {
+		unsigned short log_cyl;			/* max 1024 */
+		unsigned char log_head;			/* max 256 */
+		unsigned char signature_0xA0;
+		unsigned char phy_sect;
+		unsigned short start_write_precomp_cyl;	/* obsolete */
+		unsigned char reserved;
+		union drive_ctl_byte_u drive_ctl_byte;
+		unsigned short phy_cyl;			/* max 65536 */
+		unsigned char phy_head;			/* max 16 */
+		unsigned short landing_zone_cylinder;	/* obsolete */
+		unsigned char log_sect;			/* max 63 */
+		unsigned char checksum;
+	} __attribute__ ((packed)) edpt;
+} __attribute__ ((packed));
+
+struct sys_desc_table_info {
+	unsigned short length;
+	unsigned char table[14];
+} __attribute__ ((packed));
+
+struct in_out_info {
+	unsigned char setup_sects;		/* default 4 */
+	struct {
+		unsigned short read_only:1;
+		unsigned short unused:15;
+	} __attribute__ ((packed)) root_flags;
+	unsigned short kernel_compressed_size;	/* 16 bytes unit, rounded up */
+	unsigned short swap_dev;		/* 0 */
+	struct {
+		unsigned short size:11;
+		unsigned short unused:3;
+		unsigned short load:1;		/* separate disk */
+		unsigned short prompt:1;
+	} __attribute__ ((packed)) ramdisk;	/* RAMDISK, default 0 */
+	unsigned short vid_mode;	/* Store mode for use in acpi_wakeup.S */
+	union {
+		struct {
+			unsigned char minor_root;	/* ROOT_DEV */
+			unsigned char major_root;	/* ROOT_DEV */
+		} __attribute__ ((packed)) fields;
+		unsigned short minor_major;
+	} __attribute__ ((packed)) root;
+	unsigned char AUX_DEVICE_INFO;		/* ignored */
+	unsigned char jmp_trampoline[3];
+	union {
+		unsigned char bytes[4];		/* "HdrS" */
+		unsigned longword;
+	} __attribute__ ((packed)) header_signature;
+	unsigned short header_version_number;	/* 0x0202 */
+	unsigned short realmode_swtch[2];	/* hook to plug in a A20-open func */
+	unsigned short start_sys_seg;		/* SYSSEG */
+	unsigned short kernel_version;		/* char pointer */
+	struct loader_t {
+		enum { LILO = 0, Loadlin, bootsect,
+			SYSLINUX, ETHERBOOT, ELILO, UNKNOWN,
+			GRUB, UBOOT, GUJIN
+		} type:4;
+		unsigned char version:4;
+	} __attribute__ ((packed)) type_of_loader;
+	struct {
+		unsigned char LOADED_HIGH:1;
+		unsigned char unused:6;
+		unsigned char CAN_USE_HEAP:1;	/* heap_end_ptr is set */
+	} __attribute__ ((packed)) loadflags;
+	unsigned short setup_move_size;		/* 0x8000 */
+	unsigned code32_start;
+	unsigned ramdisk_image;
+	unsigned ramdisk_size;			/* in bytes */
+	unsigned short bootsect_kludge[2];
+	unsigned short heap_end_ptr;	/* modelist+1024, version >= 0x0201 */
+	unsigned short pad1;
+	unsigned cmd_line_ptr;		/* default 0x90800, version >= 0x0202 */
+} __attribute__ ((packed));
+
+struct e820map_info {
+	long long addr;		/* start of memory segment */
+	long long size;		/* size of memory segment */
+	long type;		/* type of memory segment */
+} __attribute__ ((packed));
+
+struct edd_device_params {
+	unsigned short length;
+	unsigned short info_flags;
+	unsigned num_default_cylinders;
+	unsigned num_default_heads;
+	unsigned sectors_per_track;
+	unsigned long long number_of_sectors;
+	unsigned short bytes_per_sector;
+	unsigned dpte_ptr;	/* 0xFFFFFFFF for our purposes */
+	unsigned short key;	/* = 0xBEDD */
+	unsigned char device_path_info_length;	/* = 44 */
+	unsigned char reserved2;
+	unsigned short reserved3;
+	unsigned char host_bus_type[4];
+	unsigned char interface_type[8];
+	union {
+		struct {
+			unsigned short base_address;
+			unsigned short reserved1;
+			unsigned reserved2;
+		} __attribute__ ((packed)) isa;
+		struct {
+			unsigned char bus;
+			unsigned char slot;
+			unsigned char function;
+			unsigned char channel;
+			unsigned reserved;
+		} __attribute__ ((packed)) pci;
+		/* pcix is same as pci */
+		struct {
+			unsigned long long reserved;
+		} __attribute__ ((packed)) ibnd;
+		struct {
+			unsigned long long reserved;
+		} __attribute__ ((packed)) xprs;
+		struct {
+			unsigned long long reserved;
+		} __attribute__ ((packed)) htpt;
+		struct {
+			unsigned long long reserved;
+		} __attribute__ ((packed)) unknown;
+	} interface_path;
+	union {
+		struct {
+			unsigned char device;
+			unsigned char reserved1;
+			unsigned short reserved2;
+			unsigned reserved3;
+			unsigned long long reserved4;
+		} __attribute__ ((packed)) ata;
+		struct {
+			unsigned char device;
+			unsigned char lun;
+			unsigned char reserved1;
+			unsigned char reserved2;
+			unsigned reserved3;
+			unsigned long long reserved4;
+		} __attribute__ ((packed)) atapi;
+		struct {
+			unsigned short id;
+			unsigned long long lun;
+			unsigned short reserved1;
+			unsigned reserved2;
+		} __attribute__ ((packed)) scsi;
+		struct {
+			unsigned long long serial_number;
+			unsigned long long reserved;
+		} __attribute__ ((packed)) usb;
+		struct {
+			unsigned long long eui;
+			unsigned long long reserved;
+		} __attribute__ ((packed)) i1394;
+		struct {
+			unsigned long long wwid;
+			unsigned long long lun;
+		} __attribute__ ((packed)) fibre;
+		struct {
+			unsigned long long identity_tag;
+			unsigned long long reserved;
+		} __attribute__ ((packed)) i2o;
+		struct {
+			unsigned array_number;
+			unsigned reserved1;
+			unsigned long long reserved2;
+		} __attribute((packed)) raid;
+		struct {
+			unsigned char device;
+			unsigned char reserved1;
+			unsigned short reserved2;
+			unsigned reserved3;
+			unsigned long long reserved4;
+		} __attribute__ ((packed)) sata;
+		struct {
+			unsigned long long reserved1;
+			unsigned long long reserved2;
+		} __attribute__ ((packed)) unknown;
+	} device_path;
+	unsigned char reserved4;
+	unsigned char checksum;
+} __attribute__ ((packed));
+
+struct edd_info {
+	unsigned char device;
+	unsigned char version;
+	unsigned short interface_support;
+	unsigned short max_cyl;
+	unsigned char max_head;
+	unsigned char max_sect;
+	struct edd_device_params params;
+} __attribute__ ((packed));
+
+typedef struct {
+	unsigned char padding[8];
+	struct {
+		unsigned short padding:1;	/* mapping right ? */
+		unsigned short first_letter:5;
+		unsigned short second_letter:5;
+		unsigned short third_letter:5;
+	} __attribute__ ((packed)) manufacturer_id;
+	unsigned short monitor_model;
+	unsigned serial_number;
+	unsigned char manufacture_week;
+	unsigned char manufacture_year;		/* base: 1990 */
+	unsigned char version;
+	unsigned char revision;
+	unsigned char video_input_type;		/* bitfield */
+	unsigned char max_horizontal_size_cm;
+	unsigned char max_vertical_size_cm;
+	unsigned char gamma_factor;	/* gamma = 1.0 + gamma_factor/100 */
+	struct {
+		unsigned char unused:3;
+		unsigned char RBGcolor:1;
+		unsigned char unused2:1;
+		unsigned char active_off_supported:1;
+		unsigned char suspend_supported:1;
+		unsigned char standby_supported:1;
+	} __attribute__ ((packed)) DPMS;
+	unsigned char chroma_green_and_red;
+	unsigned char chroma_white_and_blue;
+	unsigned char chroma_red_Y;
+	unsigned char chroma_red_X;
+	unsigned char chroma_green_Y;
+	unsigned char chroma_green_X;
+	unsigned char chroma_blue_Y;
+	unsigned char chroma_blue_X;
+	unsigned char chroma_white_Y;
+	unsigned char chroma_white_X;
+	struct {
+		unsigned short _720_400_70Hz:1;
+		unsigned short _720_400_88Hz:1;
+		unsigned short _640_480_60Hz:1;
+		unsigned short _640_480_67Hz:1;
+		unsigned short _640_480_72Hz:1;
+		unsigned short _640_480_75Hz:1;
+		unsigned short _800_600_56Hz:1;
+		unsigned short _800_600_60Hz:1;
+
+		unsigned short _800_600_72Hz:1;
+		unsigned short _800_600_75Hz:1;
+		unsigned short _832_624_75Hz:1;
+		unsigned short _1024_768_i87Hz:1;
+		unsigned short _1024_768_60Hz:1;
+		unsigned short _1024_768_70Hz:1;
+		unsigned short _1024_768_75Hz:1;
+		unsigned short _1280_1024_75Hz:1;
+	} __attribute__ ((packed)) established_timming;
+	unsigned char manufacturer_timming;
+	struct {
+		unsigned short resolution:8;  /* X resolution = (field+31)*8 */
+		unsigned short vertical_refresh_freq:6;	/* add 60Hz */
+		unsigned short aspect_ratio:2;		/* 01: 0.75 */
+	} __attribute__ ((packed)) standard_timming[8];
+	union {
+		struct {
+			unsigned short wordmarker_0;
+			unsigned char bytemarker_0;
+			enum { serial_number = 0xFF,
+				vendor_name = 0xFE,
+				vertical_horizontal_frequency_range = 0xFD,
+				model_name = 0xFC
+// RB Interrupt List say that but I read something else...
+//              } str_type : 8;
+//          char                string[14];
+			} str_type:16;
+			char string[13];
+		} __attribute__ ((packed)) strings;
+		struct {
+			unsigned char horizontal_freq_Khz;	/* != 0 */
+			unsigned char vertical_freq_Hz;		/* != 0 */
+			unsigned char horizontal_active_time_pix; /* != 0 */
+			unsigned char horizontal_blanking_time_pix;
+			unsigned char horizontal_active2_time;
+			unsigned char vertical_active_time_line;
+			unsigned char vertical_blanking_time_line;
+			unsigned char vertical_active_time2;
+			unsigned char horizontal_sync_offset;
+			unsigned char horizontal_sync_pulsewidth_pix;
+			unsigned char vertical_sync_pulsewidth;
+			unsigned char horizontal_vertical_sync_offset2;
+			unsigned char horizontal_image_size_mm;
+			unsigned char vertical_image_size_mm;
+			unsigned char horizontal_image_size_2;
+			unsigned char horizontal_border_pix;
+			unsigned char vertical_border_pix;
+			struct {
+				unsigned char unused:1;
+				unsigned char horizontal_sync_pol:1;
+				unsigned char vertical_sync_pol:1;
+				unsigned char sync_type:2;
+				enum { no_sound, stereo_right,
+					stereo_left, undefined
+				} sound:2;
+				unsigned char interlaced:1;
+			} __attribute__ ((packed)) display_t;
+		} __attribute__ ((packed)) timmings;
+	} __attribute__ ((packed)) detailed_timming[4];
+	unsigned char unused;
+	unsigned char checksum;
+} __attribute__ ((packed)) VBE_EDID_t;
+
+struct X86SpeedStepSmi_s {
+	unsigned data1, data2, data3, data4;
+};
+
+struct EFI_s { /* still not initialised in Gujin-1.2! */
+	unsigned system_table_pointer;
+	unsigned memory_descriptor_size;
+	unsigned memory_descriptor_version;
+	unsigned memory_descriptor_map_pointer;
+	unsigned memory_descriptor_map_size;
+};
+
+/*
+ * The complete version - and its offset tester:
+ */
+struct linux_param {
+	struct screen_info screen_info;
+	struct apm_bios_info apm_bios_info;
+	unsigned char free1[12];
+	struct X86SpeedStepSmi_s X86SpeedStepSmi;
+	unsigned char free2[16];
+	union drive_info drive1, drive2;
+	struct sys_desc_table_info sys_desc_table;
+	unsigned char free3[144];
+	VBE_EDID_t edid_data;
+	unsigned unused;
+	struct EFI_s EFI;
+	unsigned char free4[8];
+	unsigned ALT_MEM_K;
+	unsigned char free5[4];
+	unsigned char nb_E820_entries;
+	unsigned char nb_EDD_entries;
+	unsigned char nb_MBRSIG_entries;
+	unsigned char free6[6];
+	/* 512 bytes bootsector limit */
+	/* "in_out" is mostly init'ed in vmlinuz file: */
+	struct in_out_info in_out;
+	unsigned char free7[100];
+	unsigned MBRSIG[16];
+	struct e820map_info e820map[64];	/* 20 bytes each */
+	unsigned char free8[48];
+	unsigned char command_line[1024];
+	unsigned char free9[256];
+	struct edd_info edd[6];
+	unsigned char free10[276];
+} __attribute__ ((packed));
+
+extern inline void test_linux_param_struct(void)
+{
+	if (offsetof(struct linux_param, screen_info.EXT_MEM_K) != 0x02)
+		 __ERROR();
+	if (offsetof(struct linux_param, apm_bios_info) != 0x40)
+		 __ERROR();
+	if (offsetof(struct linux_param, X86SpeedStepSmi) != 96)
+		 __ERROR();
+	if (offsetof(struct linux_param, drive1) != 0x80)
+		 __ERROR();
+	if (offsetof(struct linux_param, drive2) != 0x80 + 16)
+		 __ERROR();
+	if (offsetof(struct linux_param, sys_desc_table) != 0xA0)
+		 __ERROR();
+	if (offsetof(struct linux_param, edid_data) != 0x140)
+		__ERROR();
+	if (offsetof(struct linux_param, ALT_MEM_K) != 0x1E0)
+		 __ERROR();
+	if (offsetof(struct linux_param, nb_E820_entries) != 0x1E8)
+		 __ERROR();
+	if (offsetof(struct linux_param, nb_EDD_entries) != 0x1E9)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.setup_sects) != 0x1F1)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.root_flags) != 0x1F2)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.kernel_compressed_size) != 0x1F4)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.swap_dev) != 0x1F6)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.header_version_number) != 0x206)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.code32_start) != 0x214)
+		 __ERROR();
+	if (offsetof(struct linux_param, in_out.heap_end_ptr) != 0x224)
+		 __ERROR();
+	if (offsetof(struct linux_param, MBRSIG) != 0x290)
+		 __ERROR();
+	if (offsetof(struct linux_param, e820map) != 0x2D0)
+		 __ERROR();
+	if (offsetof(struct linux_param, command_line) != 0x800)
+		 __ERROR();
+	if (offsetof(struct linux_param, edd) != 0xd00)
+		 __ERROR();
+}
+
diff -uprN -X linux-2.6.13/Documentation/dontdiff -x '*.orig' -x '*.cmd' -x '.tmp*' -x '*.o' -x '*.ko' -x '*.a' -x '*.so' -x '.config*' -x asm-offsets.s -x asm_offsets.h -x vmlinux.lds -x vsyscall.lds -x '*.mod.c' -x Module.symvers -x consolemap_deftbl.c -x defkeymap.c -x classlist.h -x devlist.h -x asm -x md -x scsi -x logo -x config -x .version -x zconf.tab.h -x elfconfig.h -x System.map -x zconf.tab.c -x lex.zconf.c -x compile.h -x config_data.h -x version.h -x crc32table.h -x autoconf.h -x gen-devlist -x initramfs_list linux-2.6.13-1/Makefile linux-2.6.13-2/Makefile
--- linux-2.6.13-1/Makefile	2005-08-31 00:48:10.000000000 +0100
+++ linux-2.6.13-2/Makefile	2005-08-31 00:42:07.000000000 +0100
@@ -326,6 +326,7 @@ STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
+GZIP		= gzip
 GENKSYMS	= scripts/genksyms/genksyms
 DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
@@ -339,7 +340,23 @@ AFLAGS_MODULE   = $(MODFLAGS)
 LDFLAGS_MODULE  = -r
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
+OBJCOPYFLAGS   := -O binary -R .note -R .comment -S
+GZIPFLAGS	=
 
+# Pamareters to add to the GZIP comment of the %.kgz target:
+LINUX_PARAM = ro
+ifdef ROOT
+# ROOT is present on command line or in environment (unusual case),
+# do not autodetect it at boot time:
+ifeq ($(ROOT),auto)
+# Command line is like "make /boot/linux-2.6.10.kgz ROOT=auto",
+# get value from /proc/cmdline (which can be more than one line):
+LINUX_ROOT = `sed '/root=/s/.*\(root=[_/.a-z0-9A-Z]*\).*/\1/' /proc/cmdline`
+else
+# Command line is like "make /boot/linux-2.6.10.kgz ROOT=/dev/sda6"
+LINUX_ROOT = "root=$(ROOT)"
+endif
+endif
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
@@ -724,10 +741,53 @@ $(KALLSYMS): scripts ;
 
 endif # ifdef CONFIG_KALLSYMS
 
-# vmlinux image - including updated kernel symbols
+# vmlinux ELF image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
 
+# vmlinux binary image
+quiet_cmd_objcopy = OBJCOPY $@
+      cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+# compressed vmlinux binary image
+quiet_cmd_gzip = GZIP    $@
+      cmd_gzip = $(GZIP) $(GZIPFLAGS) $< -c > $@
+vmlinux.bin.gz: vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+# If you have a modified GPL kernel but are not redistributing
+# anything, use the two lines as gzcopy parameter:
+#     -c "This software is not used outside the copyright owner company." \
+#     -al "Copyright owner: " "<official name of owner of the patch>"
+# Gujin also accept one or more "Copyright owner: " line for GPL files,
+# take care of the space after the semicolon.
+#    For instance: -al="Copyright owner: Linus Torvalds" \
+#  Keep the license first, then Copyright/source location line(s),
+# the following line is copied to the Linux parameter line by the (provided)
+# linux_set_params function, so the (provided) function may or may not also
+# include last line (i.e. Gujin parameters) as kernel parameters.
+#  Note that the command line given to LINUX shall not be empty,
+# keep at least one space in the "-al=" of $(LINUX_ROOT).
+# USAGE gzcopy "-as=" check/add a space, "-al=" check/add a newline
+# in between the current and the appended comment.
+quiet_cmd_params = PARAMS  $@
+      cmd_params =  scripts/gzcopy -f $< $@ -n=$@ \
+    -c="This software is distributed under the GPL license." \
+    -al="Its source code is at: http://www.kernel.org" \
+    -al="$(LINUX_ROOT) " -as="$(LINUX_PARAM)" \
+    -al="`scripts/gzparam`" \
+    -as="realfct_size=`size -Ax vmlinux | $(AWK) '/.realmode/{printf \$$2}'`" \
+      && echo "" \
+      && echo "  `scripts/gzcopy -n0 $@` has been rebuilt with parameters:" \
+      && echo "`scripts/gzcopy -c0 $@`"
+
+# Gujin native bootable file: just type "make /boot/linux-2.6.13.kgz"
+# to get everything (but modules & initrd & initramfs) done.
+%.kgz : vmlinux.bin.gz scripts/gzparam scripts/gzcopy FORCE
+	$(call cmd,params) 
+
 # Utility to display the kernel compile time parameters
 quiet_cmd_gzparam = HOSTCC  $@
       cmd_gzparam = $(HOSTCC) $(HOSTCFLAGS) -Wl,"-u __ERROR" -o $@ $<
@@ -962,7 +1022,7 @@ endef
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map \
-                scripts/gzparam scripts/gzcopy \
+                vmlinux.bin vmlinux.bin.gz scripts/gzparam scripts/gzcopy \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
 
 # Directories & files removed with 'make mrproper'
@@ -1046,6 +1106,8 @@ help:
 	@echo  'Other generic targets:'
 	@echo  '  all		  - Build all targets marked with [*]'
 	@echo  '* vmlinux	  - Build the bare kernel'
+	@echo  '  /boot/linux.kgz ROOT=/dev/hda1   - replace "hda1" with your root filesystem'
+	@echo  '  /boot/linux.kgz ROOT=auto        - root filesystem from current /proc/cmdline'
 	@echo  '* modules	  - Build all modules'
 	@echo  '  modules_install - Install all modules'
 	@echo  '  dir/            - Build all files in dir and below'
------=_20050901115410_11133--


