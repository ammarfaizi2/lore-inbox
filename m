Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154977AbQD0DsL>; Wed, 26 Apr 2000 23:48:11 -0400
Received: by vger.rutgers.edu id <S154975AbQD0DsD>; Wed, 26 Apr 2000 23:48:03 -0400
Received: from kwanon.research.canon.com.au ([203.12.172.254]:14920 "HELO kwanon.research.canon.com.au") by vger.rutgers.edu with SMTP id <S154985AbQD0Drp>; Wed, 26 Apr 2000 23:47:45 -0400
Subject: [PATCH] Revised generic dead function optimisation
To: linux-kernel@vger.rutgers.edu (Linux kernel mailing list)
Date: Thu, 27 Apr 2000 13:53:24 +1000 (EST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000427035324.E46C6509B2@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linux-kernel@vger.rutgers.edu

Hello again,

Thanks to Andrew Morton's feedback, I've realised that my previous patch for
dead function optimisation on all architectures was patching a wrong file for
i386, causing a major linker slowdown. It's now fixed.

This is my current latest-and-greatest patch to 2.2.x, with updated rationale:

Dead Function Optimisation
--------------------------

The following patch allows gcc/ld to automatically optimise unused functions
and data out of the kernel. In particular they will now optimise away
functions which aren't ever called, even if other functions in the same object
are. I consider this less error prone than relying on other people to wrap all
combinations of their unused functions in #ifdef CONFIG_..., and it's
particularly good if you're building a kernel for embedded systems which don't
use stuff like /proc fs, support for which isn't always wrapped in #ifdefs.

Doing this has turned out to be distinctly non-trivial, so I've described the
changes in detail below. It's been tested on ppc and i386, but should work on
all architectures in the 2.2.x tree. I'm interested to hear from people who
can try it on other architectures too. Make sure your gcc and binutils support
the -ffunction-sections and --gc-sections flags, or you'll see no effect.

Here is the rational behind what I've done in the patch:

1. enable gcc's -ffunction-sections/-fdata-sections options, and ld's
   --gc-sections option in the top Makefile, which together work all the
   magic. You need a recent enough gcc and binutils to have these flags
   actually turn on.

   That causes a whole host of stuff to break, so fix the resulting damage:

2. The section namespace used by -ffunction-sections (.text.*) clashes with
   those used by all the include/asm/init.h's (e.g. .text.init), so I renamed
   all such sections from .text.x to .x.text. Similarly for .data.x.

3. The user space exception fixup __ex_table search uses a binary chop. This
   relies on references to instructions which may fault on user space accesses
   being in the table in ascending address order. Unfortunately, a bug in all
   previous versions of the linker reverses the order of the orphan .text.*
   sections generated using -ffunction-sections when an intermediate "ld -r"
   is done, causing the binary search to fail.

   I tried a number of approaches to workaround this, including using "ar"
   instead (as I did in the last patch), and asking the binutils folk to fix
   the linker bug, which they have graciously taken on.

   However, my prefered solution (used in this patch) is to put all the
   __ex_table entries from seperate functions into seperate sections named
   __ex_table.__FUNCTION__, mirroring what -ffunction-sections does with
   .text . Since the linker reorders both sets of sections consistently,
   this keeps the __ex_table sorted with respect to the output .text.* section
   ordering both with and without the linker bug fixed.

   Assembler code continues to lump everything in .text, with ex_table entries
   in __ex_table. Hence, the patch won't attempt to optimise away dead
   assembler functions. Not yet, anyway.

4. Mods to the vmlinux.lds files to keep the world in sync:

   Added entries for .text.*, .data.* and __ex_table.* to the .text, .data and
   __ex_table output sections respectively. My previous assertion that you
   could use .text* and .data* instead, and mix and match code compiled with
   and without -ffunction-sections turned out to be totally bogus, partly
   because the intermediate "ld -r" steps use the linker's default .lds file,
   where .text and .data are matched explicitly, but all the .text.* and
   .data.* sections end up as orphans. Sorry. I didn't want to change the
   kernel build procedure that much.

   Changed the .text/data.init et al to .init.text/data, as per init.h

   KEEP the __ex_table and __ksymtab, otherwise they get optimised away.

   Add an explicit ENTRY(_start) in the ppc .lds file to prevent
   everything getting optimised away(!) because no external references exist.
   The other architectures already had ENTRY.
   
   Added the __ksymtab section to arch/ppc/vmlinux.lds, where it was missing.

   Note that arch/i386/vmlinux.lds is generated from arch/i386/vmlinux.lds.S,
   so we patch that instead.

5. I've added a check_exception_table function to check_bugs in the ppc
   to ensure that the table really is in ascending order, since it's not real
   noticable when it's broken until a rogue program passes a bad pointer to
   the kernel. This may be temporary; I'm trying to save space, after all.

6. The __get/put_user_asm macros in include/asm-ppc/uaccess.h were making an
   explicit reference to ".text", rather than using ".previous" like other
   architectures do. This caused me much grief, and should be fixed for
   consistency anyway.

7. There is what looks like a gratuitous ".text" pseudo-op in
   include/asm-mips/semaphore-helper.h. It's likely to break things, so I
   removed it.

8. Updated the commentary in Documentation/exception.txt a tiny bit.

This mucks with the exception table somewhat, so if you want to try this out,
make sure you test that a program which generates a bad user space access
doesn't kernel panic. Something like:

    #include <unistd.h>

    int main()
    {
	printf("bad write returned %d\n", write(1, 0, 1));
	perror("write");
	return 0;
    }

Please let me know what you think!


Index: Makefile
===================================================================
retrieving revision 1.3
retrieving revision 1.3.2.1
diff -u -r1.3 -r1.3.2.1
--- Makefile	2000/03/10 02:01:14	1.3
+++ Makefile	2000/04/20 02:47:11	1.3.2.1
@@ -99,6 +99,12 @@
 # use '-fno-strict-aliasing', but only if the compiler can take it
 CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
 
+# use '-ffunction-sections -fdata-sections' and '--gc-sections' if they work
+ifeq ($(shell $(CC) -ffunction-sections -fdata-sections -S -o /dev/null -xc /dev/null && $(LD) --gc-sections -v >/dev/null && echo 1),1)
+CFLAGS += -ffunction-sections -fdata-sections -DFUNCTION_SECTIONS
+LINKAIFLAGS = --gc-sections
+endif
+
 ifdef CONFIG_SMP
 CFLAGS += -D__SMP__
 AFLAGS += -D__SMP__
@@ -223,7 +229,7 @@
 	@$(MAKE) -C arch/$(ARCH)/boot
 
 vmlinux: $(CONFIGURATION) init/main.o init/version.o linuxsubdirs
-	$(LD) $(LINKFLAGS) $(HEAD) init/main.o init/version.o \
+	$(LD) $(LINKAIFLAGS) $(LINKFLAGS) $(HEAD) init/main.o init/version.o \
 		--start-group \
 		$(CORE_FILES) \
 		$(FILESYSTEMS) \
Index: Documentation/exception.txt
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- Documentation/exception.txt	1999/12/30 05:55:26	1.1.1.1
+++ Documentation/exception.txt	2000/04/20 02:47:14	1.1.1.1.2.1
@@ -284,3 +284,19 @@
 successful, -EFAULT on failure. Our original code did not test this
 return value, however the inline assembly code in get_user tries to
 return -EFAULT. GCC selected EAX to return this value.
+
+The exception table search uses a binary chop, which requires the entries
+in the table pointing to the instructions which may fault on a user space
+access to be in listed in ascending instruction address order. This
+plays some havoc with -ffunction-sections, which puts each function in its
+own section named .text.__FUNCTION__, allowing the linker to perform dead
+function optimisation. The linker has the liberty to move these .text.*
+sections around, so to keep the output __ex_table in sync, the __ex_table
+entries are actually placed in sections named __ex_table.__FUNCTION__, which
+may get moved around in a corresponding manner by the linker.
+
+include/asm-*/uaccess.h use a macro __EX_TABLE rather than the explicitly
+naming __ex_table in the .section references as shown above, to allow this
+behaviour to be turned on and off according to whether -ffunction-sections
+is being used, since old compilers do not support it.
+
Index: arch/alpha/vmlinux.lds
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/alpha/vmlinux.lds	1999/12/30 05:55:38	1.1.1.1
+++ arch/alpha/vmlinux.lds	2000/04/20 02:47:17	1.1.1.1.2.1
@@ -4,28 +4,28 @@
 {
    . = 0xfffffc0000310000;
    _text = .;
-   .text : { *(.text) }
+   .text : { *(.text) *(.text.*) }
    .text2 : { *(.text2) }
    _etext = .;
 
   /* Exception table */
   . = ALIGN(16);
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
 
   /* Kernel symbol table */
   . = ALIGN(8);
   __start___ksymtab = .;
-  __ksymtab : { *(__ksymtab) }
+  __ksymtab : { KEEP(*(__ksymtab)) }
   __stop___ksymtab = .;
   .kstrtab : { *(.kstrtab) }
 
   /* Startup code */
   . = ALIGN(8192);
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(2*8192);	/* Align double page for init_task_union */
   __init_end = .;
 
@@ -35,7 +35,7 @@
   /* Global data */
   _data = .;
   .rodata : { *(.rodata) }
-  .data : { *(.data) CONSTRUCTORS }
+  .data : { *(.data) *(.data.*) CONSTRUCTORS }
   .got : { *(.got) }
   .sdata : { *(.sdata) }
   _edata = .;
Index: arch/i386/vmlinux.lds.S
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/i386/vmlinux.lds.S	1999/12/30 05:55:47	1.1.1.1
+++ arch/i386/vmlinux.lds.S	2000/04/26 02:28:37	1.1.1.1.2.1
@@ -10,46 +10,48 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	*(.text.*)
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
+  .lock.text : { *(.lock.text) }	/* out-of-line lock text */
   .rodata : { *(.rodata) }
   .kstrtab : { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
 
   __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
+  __ksymtab : { KEEP(*(__ksymtab)) }
   __stop___ksymtab = .;
 
   _etext = .;			/* End of text section */
 
   .data : {			/* Data */
 	*(.data)
+	*(.data.*)
 	CONSTRUCTORS
 	}
 
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .init_task.data : { *(.init_task.data) }
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(4096);
   __init_end = .;
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .page_aligned.data : { *(.idt.data) }
 
 
   __bss_start = .;		/* BSS */
Index: arch/m68k/vmlinux.lds
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/m68k/vmlinux.lds	1999/12/30 05:55:53	1.1.1.1
+++ arch/m68k/vmlinux.lds	2000/04/20 02:47:23	1.1.1.1.2.1
@@ -8,8 +8,9 @@
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.text)
+	*(.text.*)
 	*(.fixup)
-	*(.text.lock)		/* out-of-line lock text */
+	*(.lock.text)		/* out-of-line lock text */
 	*(.gnu.warning)
 	} = 0x4e75
   .rodata : { *(.rodata) }
@@ -17,17 +18,18 @@
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
 
   __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
+  __ksymtab : { KEEP(*(__ksymtab)) }
   __stop___ksymtab = .;
 
   _etext = .;			/* End of text section */
 
   .data : {			/* Data */
 	*(.data)
+	*(.data.*)
 	CONSTRUCTORS
 	}
 
@@ -36,12 +38,12 @@
   _edata = .;			/* End of data section */
 
   . = ALIGN(16);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(8192);
   __init_end = .;
 
Index: arch/ppc/vmlinux.lds
===================================================================
retrieving revision 1.1
retrieving revision 1.2.2.1
diff -u -r1.1 -r1.2.2.1
--- arch/ppc/vmlinux.lds	1999/12/30 05:56:15	1.1
+++ arch/ppc/vmlinux.lds	2000/04/20 02:47:27	1.2.2.1
@@ -1,4 +1,5 @@
 OUTPUT_ARCH(powerpc)
+ENTRY(_start)
 SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
@@ -31,6 +32,7 @@
   .text      :
   {
     *(.text)
+    *(.text.*)
     *(.fixup)
     *(.got1)
   }
@@ -49,6 +51,7 @@
   .data    :
   {
     *(.data)
+    *(.data.*)
     *(.data1)
     *(.sdata)
     *(.sdata2)
@@ -59,39 +62,42 @@
   _edata  =  .;
   PROVIDE (edata = .);
 
-  .fixup   : { *(.fixup) }
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
 
+  __start___ksymtab = .;        /* Kernel symbol table */
+  __ksymtab : { KEEP(*(__ksymtab)) }
+  __stop___ksymtab = .;
+
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   . = ALIGN(4096);
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(4096);
   __init_end = .;
 
   . = ALIGN(4096);
   __pmac_begin = .;
-  .text.pmac : { *(.text.pmac) }
-  .data.pmac : { *(.data.pmac) }
+  .pmac.text : { *(.pmac.text) }
+  .pmac.data : { *(.pmac.data) }
   . = ALIGN(4096);
   __pmac_end = .;
 
   . = ALIGN(4096);
   __prep_begin = .;
-  .text.prep : { *(.text.prep) }
-  .data.prep : { *(.data.prep) }
+  .prep.text : { *(.prep.text) }
+  .prep.data : { *(.prep.data) }
   . = ALIGN(4096);
   __prep_end = .;
 
   . = ALIGN(4096);
   __openfirmware_begin = .;
-  .text.openfirmware : { *(.text.openfirmware) }
-  .data.openfirmware : { *(.data.openfirmware) }
+  .openfirmware.text : { *(.openfirmware.text) }
+  .openfirmware.data : { *(.openfirmware.data) }
   . = ALIGN(4096);
   __openfirmware_end = .;
 
Index: arch/ppc/kernel/syscalls.c
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/ppc/kernel/syscalls.c	1999/12/30 05:56:22	1.1.1.1
+++ arch/ppc/kernel/syscalls.c	2000/04/20 02:47:27	1.1.1.1.2.1
@@ -40,6 +40,9 @@
 void
 check_bugs(void)
 {
+    extern void check_exception_table(void);
+
+    check_exception_table();
 }
 
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on)
Index: arch/ppc/mm/extable.c
===================================================================
retrieving revision 1.2
retrieving revision 1.2.2.1
diff -u -r1.2 -r1.2.2.1
--- arch/ppc/mm/extable.c	2000/04/13 01:10:18	1.2
+++ arch/ppc/mm/extable.c	2000/04/20 02:47:27	1.2.2.1
@@ -6,6 +6,7 @@
 
 #include <linux/module.h>
 #include <asm/uaccess.h>
+#include <asm/init.h>
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
@@ -53,4 +54,15 @@
 #endif
 
 	return 0;
+}
+
+void __init
+check_exception_table(void)
+{
+    const struct exception_table_entry *entry;
+
+    for (entry = __start___ex_table; entry < __stop___ex_table-1; entry++)
+	if (entry[1].insn <= entry[0].insn)
+	    panic("exception table entry for instr at %lx is out of order!",
+		entry[1].insn);
 }
Index: arch/sparc/vmlinux.lds
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/sparc/vmlinux.lds	1999/12/30 05:56:31	1.1.1.1
+++ arch/sparc/vmlinux.lds	2000/04/20 02:47:28	1.1.1.1.2.1
@@ -8,6 +8,7 @@
   .text 0xf0004000 :
   {
     *(.text)
+    *(.text.*)
     *(.gnu.warning)
   } =0
   _etext = .;
@@ -17,6 +18,7 @@
   .data    :
   {
     *(.data)
+    *(.data.*)
     CONSTRUCTORS
   }
   .data1   : { *(.data1) }
@@ -26,20 +28,20 @@
   .fixup   : { *(.fixup) }
   __stop___fixup = .;
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
   __start___ksymtab = .;
-  __ksymtab  : { *(__ksymtab) }
+  __ksymtab  : { KEEP(*(__ksymtab)) }
   __stop___ksymtab = .;
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .cacheline_aligned.data : { *(.cacheline_aligned.data) }
 
   . = ALIGN(4096);
   __init_begin = .;
-  .text.init : { *(.text.init) }
+  .init.text : { *(.init.text) }
   __init_text_end = .;
-  .data.init : { *(.data.init) }
+  .init.data : { *(.init.data) }
   . = ALIGN(4096);
   __init_end = .;
   __bss_start = .;
Index: arch/sparc64/vmlinux.lds
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- arch/sparc64/vmlinux.lds	1999/12/30 05:56:40	1.1.1.1
+++ arch/sparc64/vmlinux.lds	2000/04/20 02:47:28	1.1.1.1.2.1
@@ -12,6 +12,7 @@
   .text 0x0000000000404000 :
   {
     *(.text)
+    *(.text.*)
     *(.gnu.warning)
   } =0
   _etext = .;
@@ -21,6 +22,7 @@
   .data    :
   {
     *(.data)
+    *(.data.*)
     CONSTRUCTORS
   }
   .data1   : { *(.data1) }
@@ -29,16 +31,16 @@
   .fixup   : { *(.fixup) }
   . = ALIGN(16);
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : { KEEP(*(__ex_table)) KEEP(*(__ex_table.*)) }
   __stop___ex_table = .;
   __start___ksymtab = .;
-  __ksymtab  : { *(__ksymtab) }
+  __ksymtab  : { KEEP(*(__ksymtab)) }
   __stop___ksymtab = .;
   __kstrtab  : { *(.kstrtab) }
   . = ALIGN(8192);
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(8192);
   __init_end = .;
   __bss_start = .;
Index: include/asm-alpha/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-alpha/init.h	1999/12/30 06:00:05	1.1.1.1
+++ include/asm-alpha/init.h	2000/04/20 02:47:29	1.1.1.1.2.1
@@ -2,16 +2,16 @@
 #define _ALPHA_INIT_H
 
 #ifndef MODULE
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 
 /* For assembly routines */
-#define __INIT		.section	.text.init,"ax"
+#define __INIT		.section	.init.text,"ax"
 #define __FINIT		.previous
-#define __INITDATA	.section	.data.init,"a"
+#define __INITDATA	.section	.init.data,"a"
 #endif
 
 #define __cacheline_aligned __attribute__((__aligned__(32)))
Index: include/asm-alpha/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-alpha/uaccess.h	1999/12/30 06:00:07	1.1.1.1
+++ include/asm-alpha/uaccess.h	2000/04/20 02:47:29	1.1.1.1.2.1
@@ -4,6 +4,12 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -143,7 +149,7 @@
 #define __get_user_64(addr)				\
 	__asm__("1: ldq %0,%2\n"			\
 	"2:\n"						\
-	".section __ex_table,\"a\"\n"			\
+	".section " __EX_TABLE ",\"a\"\n"		\
 	"	.gprel32 1b\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
@@ -153,7 +159,7 @@
 #define __get_user_32(addr)				\
 	__asm__("1: ldl %0,%2\n"			\
 	"2:\n"						\
-	".section __ex_table,\"a\"\n"			\
+	".section " __EX_TABLE ",\"a\"\n"		\
 	"	.gprel32 1b\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
@@ -166,7 +172,7 @@
 #define __get_user_16(addr)				\
 	__asm__("1: ldwu %0,%2\n"			\
 	"2:\n"						\
-	".section __ex_table,\"a\"\n"			\
+	".section " __EX_TABLE ",\"a\"\n"		\
 	"	.gprel32 1b\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
@@ -176,7 +182,7 @@
 #define __get_user_8(addr)				\
 	__asm__("1: ldbu %0,%2\n"			\
 	"2:\n"						\
-	".section __ex_table,\"a\"\n"			\
+	".section " __EX_TABLE ",\"a\"\n"		\
 	"	.gprel32 1b\n"				\
 	"	lda %0, 2b-1b(%1)\n"			\
 	".previous"					\
@@ -195,7 +201,7 @@
 	"	extwh %1,%3,%1\n"					\
 	"	or %0,%1,%0\n"						\
 	"3:\n"								\
-	".section __ex_table,\"a\"\n"					\
+	".section " __EX_TABLE ",\"a\"\n"				\
 	"	.gprel32 1b\n"						\
 	"	lda %0, 3b-1b(%2)\n"					\
 	"	.gprel32 2b\n"						\
@@ -209,7 +215,7 @@
 	__asm__("1: ldq_u %0,0(%2)\n"					\
 	"	extbl %0,%2,%0\n"					\
 	"2:\n"								\
-	".section __ex_table,\"a\"\n"					\
+	".section " __EX_TABLE ",\"a\"\n"				\
 	"	.gprel32 1b\n"						\
 	"	lda %0, 2b-1b(%1)\n"					\
 	".previous"							\
@@ -257,7 +263,7 @@
 #define __put_user_64(x,addr)					\
 __asm__ __volatile__("1: stq %r2,%1\n"				\
 	"2:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
@@ -267,7 +273,7 @@
 #define __put_user_32(x,addr)					\
 __asm__ __volatile__("1: stl %r2,%1\n"				\
 	"2:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
@@ -280,7 +286,7 @@
 #define __put_user_16(x,addr)					\
 __asm__ __volatile__("1: stw %r2,%1\n"				\
 	"2:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
@@ -290,7 +296,7 @@
 #define __put_user_8(x,addr)					\
 __asm__ __volatile__("1: stb %r2,%1\n"				\
 	"2:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31,2b-1b(%0)\n"				\
 	".previous"						\
@@ -315,7 +321,7 @@
 	"3:	stq_u %2,1(%5)\n"				\
 	"4:	stq_u %1,0(%5)\n"				\
 	"5:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31, 5b-1b(%0)\n"				\
 	"	.gprel32 2b\n"					\
@@ -341,7 +347,7 @@
 	"	or %1,%2,%1\n"					\
 	"2:	stq_u %1,0(%4)\n"				\
 	"3:\n"							\
-	".section __ex_table,\"a\"\n"				\
+	".section " __EX_TABLE ",\"a\"\n"			\
 	"	.gprel32 1b\n"					\
 	"	lda $31, 3b-1b(%0)\n"				\
 	"	.gprel32 2b\n"					\
Index: include/asm-arm/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-arm/init.h	1999/12/30 06:00:08	1.1.1.1
+++ include/asm-arm/init.h	2000/04/20 02:47:29	1.1.1.1.2.1
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_TEXT_SECTIONS
 
-#define __init __attribute__ ((__section__ (".text.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
@@ -19,11 +19,11 @@
 
 #endif
 
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 
 /* Assembly routines */
-#define __INIT		.section	".text.init",@alloc,@execinstr
-#define __INITDATA	.section	".data.init",@alloc,@write
+#define __INIT		.section	".init.text",@alloc,@execinstr
+#define __INITDATA	.section	".init.data",@alloc,@write
 #define __FINIT	.previous
 
 #define __cacheline_aligned __attribute__ \
Index: include/asm-i386/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-i386/init.h	1999/12/30 06:00:17	1.1.1.1
+++ include/asm-i386/init.h	2000/04/20 02:47:29	1.1.1.1.2.1
@@ -1,17 +1,17 @@
 #ifndef _I386_INIT_H
 #define _I386_INIT_H
 
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 /* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT	.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 
 #define __cacheline_aligned __attribute__ \
-			 ((__section__ (".data.cacheline_aligned")))
+			 ((__section__ (".cacheline_aligned.data")))
 
 #endif
Index: include/asm-i386/semaphore.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-i386/semaphore.h	1999/12/30 06:00:18	1.1.1.1
+++ include/asm-i386/semaphore.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -70,7 +70,7 @@
 		"decl (%0)\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -92,7 +92,7 @@
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -115,7 +115,7 @@
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -141,7 +141,7 @@
 		"incl (%0)\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
 		".previous"
Index: include/asm-i386/spinlock.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-i386/spinlock.h	1999/12/30 06:00:18	1.1.1.1
+++ include/asm-i386/spinlock.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -146,7 +146,7 @@
 	"\n1:\t" \
 	"lock ; btsl $0,%0\n\t" \
 	"jc 2f\n" \
-	".section .text.lock,\"ax\"\n" \
+	".section .lock.text,\"ax\"\n" \
 	"2:\t" \
 	"testb $1,%0\n\t" \
 	"jne 2b\n\t" \
@@ -207,7 +207,7 @@
 	asm volatile("\n1:\t" \
 		     "lock ; incl %0\n\t" \
 		     "js 2f\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".section .lock.text,\"ax\"\n" \
 		     "2:\tlock ; decl %0\n" \
 		     "3:\tcmpl $0,%0\n\t" \
 		     "js 3b\n\t" \
@@ -225,7 +225,7 @@
 		     "jc 4f\n" \
 		     "2:\ttestl $0x7fffffff,%0\n\t" \
 		     "jne 3f\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".section .lock.text,\"ax\"\n" \
 		     "3:\tlock ; btrl $31,%0\n" \
 		     "4:\tcmp $0,%0\n\t" \
 		     "jne 4b\n\t" \
Index: include/asm-i386/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-i386/uaccess.h	1999/12/30 06:00:19	1.1.1.1
+++ include/asm-i386/uaccess.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -8,6 +8,13 @@
 #include <linux/sched.h>
 #include <asm/page.h>
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1
 
@@ -185,7 +192,7 @@
 		"3:	movl %3,%0\n"				\
 		"	jmp 2b\n"				\
 		".previous\n"					\
-		".section __ex_table,\"a\"\n"			\
+		".section " __EX_TABLE ",\"a\"\n"		\
 		"	.align 4\n"				\
 		"	.long 1b,3b\n"				\
 		".previous"					\
@@ -223,7 +230,7 @@
 		"	xor"itype" %"rtype"1,%"rtype"1\n"	\
 		"	jmp 2b\n"				\
 		".previous\n"					\
-		".section __ex_table,\"a\"\n"			\
+		".section " __EX_TABLE ",\"a\"\n"		\
 		"	.align 4\n"				\
 		"	.long 1b,3b\n"				\
 		".previous"					\
@@ -262,7 +269,7 @@
 		"3:	lea 0(%3,%0,4),%0\n"				\
 		"	jmp 2b\n"					\
 		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
+		".section " __EX_TABLE ",\"a\"\n"			\
 		"	.align 4\n"					\
 		"	.long 0b,3b\n"					\
 		"	.long 1b,2b\n"					\
@@ -290,7 +297,7 @@
 		"	popl %0\n"					\
 		"	jmp 2b\n"					\
 		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
+		".section " __EX_TABLE ",\"a\"\n"			\
 		"	.align 4\n"					\
 		"	.long 0b,3b\n"					\
 		"	.long 1b,4b\n"					\
@@ -331,7 +338,7 @@
 			"2:	shl $2,%0\n"			\
 			"	jmp 1b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,2b\n"			\
 			".previous"				\
@@ -349,7 +356,7 @@
 			"4:	incl %0\n"			\
 			"	jmp 2b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
@@ -368,7 +375,7 @@
 			"4:	addl $2,%0\n"			\
 			"	jmp 2b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
@@ -389,7 +396,7 @@
 			"6:	incl %0\n"			\
 			"	jmp 3b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,4b\n"			\
 			"	.long 1b,5b\n"			\
@@ -421,7 +428,7 @@
 			"	shl $2,%0\n"			\
 			"	jmp 1b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,2b\n"			\
 			".previous"				\
@@ -452,7 +459,7 @@
 			"	incl %0\n"			\
 			"	jmp 2b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
@@ -484,7 +491,7 @@
 			"	addl $2,%0\n"			\
 			"	jmp 2b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
@@ -525,7 +532,7 @@
 			"	incl %0\n"			\
 			"	jmp 2b\n"			\
 			".previous\n"				\
-			".section __ex_table,\"a\"\n"		\
+			".section " __EX_TABLE ",\"a\"\n"	\
 			"	.align 4\n"			\
 			"	.long 0b,4b\n"			\
 			"	.long 1b,5b\n"			\
Index: include/asm-m68k/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-m68k/init.h	1999/12/30 06:00:21	1.1.1.1
+++ include/asm-m68k/init.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -5,18 +5,18 @@
 
 #ifndef CONFIG_KGDB
 
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 /* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT		.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 
 #define __cacheline_aligned __attribute__ \
-		((__aligned__(16), __section__ (".data.cacheline_aligned")))
+		((__aligned__(16), __section__ (".cacheline_aligned.data")))
 
 #else
 
Index: include/asm-m68k/semaphore.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-m68k/semaphore.h	1999/12/30 06:00:23	1.1.1.1
+++ include/asm-m68k/semaphore.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -49,7 +49,7 @@
 		"subql #1,%0@\n\t"
 		"jmi 2f\n\t"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		".even\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed\n"
@@ -70,7 +70,7 @@
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		".even\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_interruptible\n"
@@ -92,7 +92,7 @@
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		".even\n"
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_trylock\n"
@@ -117,7 +117,7 @@
 		"addql #1,%0@\n\t"
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".section .lock.text,\"ax\"\n"
 		".even\n"
 		"2:\t"
 		"pea 1b\n\t"
Index: include/asm-m68k/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-m68k/uaccess.h	1999/12/30 06:00:24	1.1.1.1
+++ include/asm-m68k/uaccess.h	2000/04/20 02:47:30	1.1.1.1.2.1
@@ -7,6 +7,13 @@
 #include <linux/sched.h>
 #include <asm/segment.h>
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
 
@@ -83,7 +90,7 @@
      "2: movel %3,%0\n"					\
      "   jra 1b\n"					\
      ".previous\n"					\
-     ".section __ex_table,\"a\"\n"			\
+     ".section " __EX_TABLE ",\"a\"\n"			\
      "   .align 4\n"					\
      "   .long 21b,2b\n"				\
      "   .long 1b,2b\n"					\
@@ -127,7 +134,7 @@
      "   sub" #bwl " %1,%1\n"			\
      "   jra 2b\n"				\
      ".previous\n"				\
-     ".section __ex_table,\"a\"\n"		\
+     ".section " __EX_TABLE ",\"a\"\n"		\
      "   .align 4\n"				\
      "   .long 1b,3b\n"				\
      ".previous"				\
@@ -177,7 +184,7 @@
 	 "91:clrb (%0)+\n"
 	 "   jra 6b\n"
          ".previous\n"
-	 ".section __ex_table,\"a\"\n"
+	 ".section " __EX_TABLE ",\"a\"\n"
 	 "   .align 4\n"
 	 "   .long 1b,7b\n"
 	 "   .long 3b,8b\n"
@@ -221,7 +228,7 @@
 	 "8: addql #1,%2\n"
 	 "   jra 5b\n"
 	 ".previous\n"
-	 ".section __ex_table,\"a\"\n"
+	 ".section " __EX_TABLE ",\"a\"\n"
 	 "   .align 4\n"
 	 "   .long 1b,60b\n"
 	 "   .long 22b,6b\n"
@@ -254,7 +261,7 @@
 	 fixup "\n"					\
 	 "    jra 12f\n"				\
 	 ".previous\n"					\
-	 ".section __ex_table,\"a\"\n"			\
+	 ".section " __EX_TABLE ",\"a\"\n"		\
 	 "    .align 4\n"				\
 	 "    .long 10b,11b\n"				\
 	 ".previous\n"					\
@@ -281,7 +288,7 @@
 	     "   clrb (%0)+\n"
 	     "   jra 2b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,3b\n"
 	     ".previous"
@@ -300,7 +307,7 @@
 	     "   clrw (%0)+\n"
 	     "   jra 2b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,3b\n"
 	     ".previous"
@@ -323,7 +330,7 @@
 	     "   clrb (%0)+\n"
 	     "   jra 3b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,4b\n"
 	     "   .long 2b,5b\n"
@@ -343,7 +350,7 @@
 	     "   clrl (%0)+\n"
 	     "   jra 2b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,3b\n"
 	     ".previous"
@@ -366,7 +373,7 @@
 	     "   clrl (%0)+\n"
 	     "   jra 3b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,4b\n"
 	     "   .long 2b,5b\n"
@@ -394,7 +401,7 @@
 	     "   clrl (%0)+\n"
 	     "   jra 4b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,5b\n"
 	     "   .long 2b,6b\n"
@@ -427,7 +434,7 @@
 	     "   clrl (%0)+\n"
 	     "   jra 5b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 1b,6b\n"
 	     "   .long 2b,7b\n"
@@ -451,7 +458,7 @@
 				 /* copy */
 				 "2: movesb (%1)+,%%d0\n"
 				 "   moveb %%d0,(%0)+\n"
-				 ".section __ex_table,\"a\"\n"
+				 ".section " __EX_TABLE ",\"a\"\n"
 				 "   .long 2b,1b\n"
 				 ".previous");
 	    break;
@@ -463,7 +470,7 @@
 				 /* copy */
 				 "2: movesw (%1)+,%%d0\n"
 				 "   movew %%d0,(%0)+\n"
-				 ".section __ex_table,\"a\"\n"
+				 ".section " __EX_TABLE ",\"a\"\n"
 				 "   .long 2b,1b\n"
 				 ".previous");
 	    break;
@@ -479,7 +486,7 @@
 				 "   movew %%d0,(%0)+\n"
 				 "4: movesb (%1)+,%%d0\n"
 				 "   moveb %%d0,(%0)+\n"
-				 ".section __ex_table,\"a\"\n"
+				 ".section " __EX_TABLE ",\"a\"\n"
 				 "   .long 3b,1b\n"
 				 "   .long 4b,2b\n"
 				 ".previous");
@@ -504,7 +511,7 @@
 	 fixup "\n"					\
 	 "    jra 13f\n"				\
 	 ".previous\n"					\
-	 ".section __ex_table,\"a\"\n"			\
+	 ".section " __EX_TABLE ",\"a\"\n"		\
 	 "    .align 4\n"				\
 	 "    .long 10b,22b\n"				\
 	 "    .long 31b,12b\n"				\
@@ -533,7 +540,7 @@
 	     "2: addql #1,%2\n"
 	     "   jra 1b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n  "
 	     "   .long 21b,2b\n"
 	     "   .long 1b,2b\n"
@@ -552,7 +559,7 @@
 	     "2: addql #2,%2\n"
 	     "   jra 1b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,2b\n"
 	     "   .long 1b,2b\n"
@@ -574,7 +581,7 @@
 	     "4: addql #1,%2\n"
 	     "   jra 2b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,3b\n"
 	     "   .long 1b,3b\n"
@@ -595,7 +602,7 @@
 	     "2: addql #4,%2\n"
 	     "   jra 1b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,2b\n"
 	     "   .long 1b,2b\n"
@@ -617,7 +624,7 @@
 	     "4: addql #4,%2\n"
 	     "   jra 2b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,3b\n"
 	     "   .long 1b,3b\n"
@@ -644,7 +651,7 @@
 	     "6: addql #4,%2\n"
 	     "   jra 3b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,4b\n"
 	     "   .long 1b,4b\n"
@@ -676,7 +683,7 @@
 	     "8: addql #4,%2\n"
 	     "   jra 4b\n"
 	     ".previous\n"
-	     ".section __ex_table,\"a\"\n"
+	     ".section " __EX_TABLE ",\"a\"\n"
 	     "   .align 4\n"
 	     "   .long 21b,5b\n"
 	     "   .long 1b,5b\n"
@@ -704,7 +711,7 @@
 			       "   moveb (%1)+,%%d0\n"
 			       "22:movesb %%d0,(%0)+\n"
 			       "2:"
-			       ".section __ex_table,\"a\"\n"
+			       ".section " __EX_TABLE ",\"a\"\n"
 			       "   .long 22b,1b\n"
 			       "   .long 2b,1b\n"
 			       ".previous");
@@ -717,7 +724,7 @@
 			       "   movew (%1)+,%%d0\n"
 			       "22:movesw %%d0,(%0)+\n"
 			       "2:"
-			       ".section __ex_table,\"a\"\n"
+			       ".section " __EX_TABLE ",\"a\"\n"
 			       "   .long 22b,1b\n"
 			       "   .long 2b,1b\n"
 			       ".previous");
@@ -733,7 +740,7 @@
 			       "3: moveb (%1)+,%%d0\n"
 			       "24:movesb %%d0,(%0)+\n"
 			       "4:"
-			       ".section __ex_table,\"a\"\n"
+			       ".section " __EX_TABLE ",\"a\"\n"
 			       "   .long 23b,1b\n"
 			       "   .long 3b,1b\n"
 			       "   .long 24b,2b\n"
@@ -785,7 +792,7 @@
 	 "4: movel %4,%0\n"
 	 "   jra 3b\n"
 	 ".previous\n"
-	 ".section __ex_table,\"a\"\n"
+	 ".section " __EX_TABLE ",\"a\"\n"
 	 "   .align 4\n"
 	 "   .long 1b,4b\n"
 	 "   .long 12b,4b\n"
@@ -815,7 +822,7 @@
 	 "3: moveq %2,%0\n"
 	 "   jra 2b\n"
 	 ".previous\n"
-	 ".section __ex_table,\"a\"\n"
+	 ".section " __EX_TABLE ",\"a\"\n"
 	 "   .align 4\n"
 	 "   .long 1b,3b\n"
 	 "   .long 12b,3b\n"
@@ -858,7 +865,7 @@
 	 "8: addql #1,%1\n"
 	 "   jra 5b\n"
 	 ".previous\n"
-	 ".section __ex_table,\"a\"\n"
+	 ".section " __EX_TABLE ",\"a\"\n"
 	 "   .align 4\n"
 	 "   .long 1b,61b\n"
 	 "   .long 2b,6b\n"
Index: include/asm-mips/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-mips/init.h	1999/12/30 06:00:25	1.1.1.1
+++ include/asm-mips/init.h	2000/04/20 02:47:31	1.1.1.1.2.1
@@ -1,4 +1,4 @@
-/* $Id: init.h,v 1.1.1.1 1999/12/30 06:00:25 greyham Exp $
+/* $Id: init.h,v 1.1.1.1.2.1 2000/04/20 02:47:31 greyham Exp $
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -9,8 +9,8 @@
 #ifndef __MIPS_INIT_H
 #define __MIPS_INIT_H
 
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
@@ -22,9 +22,9 @@
 #endif
 
 /* For assembly routines */
-#define __INIT		.section	.text.init,"ax"
+#define __INIT		.section	.init.text,"ax"
 #define __FINIT		.previous
-#define __INITDATA	.section	.data.init,"a"
+#define __INITDATA	.section	.init.data,"a"
 #define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
 
 #endif /* __MIPS_INIT_H */
Index: include/asm-mips/semaphore-helper.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-mips/semaphore-helper.h	1999/12/30 06:00:27	1.1.1.1
+++ include/asm-mips/semaphore-helper.h	2000/04/20 02:47:31	1.1.1.1.2.1
@@ -1,4 +1,4 @@
-/* $Id: semaphore-helper.h,v 1.1.1.1 1999/12/30 06:00:27 greyham Exp $
+/* $Id: semaphore-helper.h,v 1.1.1.1.2.1 2000/04/20 02:47:31 greyham Exp $
  *
  * SMP- and interrupt-safe semaphores helper functions.
  *
@@ -29,7 +29,6 @@
 	"sc\t%0,%2\n\t"
 	"beqz\t%0,1b\n\t"
 	"2:"
-	".text"
 	: "=r"(ret), "=r"(tmp), "=m"(__atomic_fool_gcc(&sem->waking))
 	: "0"(0));
 
Index: include/asm-mips/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-mips/uaccess.h	1999/12/30 06:00:29	1.1.1.1
+++ include/asm-mips/uaccess.h	2000/04/20 02:47:31	1.1.1.1.2.1
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 1996, 1997, 1998 by Ralf Baechle
  *
- * $Id: uaccess.h,v 1.1.1.1 1999/12/30 06:00:29 greyham Exp $
+ * $Id: uaccess.h,v 1.1.1.1.2.1 2000/04/20 02:47:31 greyham Exp $
  */
 #ifndef __ASM_MIPS_UACCESS_H
 #define __ASM_MIPS_UACCESS_H
@@ -15,6 +15,13 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
@@ -156,7 +163,7 @@
 	"move\t%1,$0\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
-	".section\t__ex_table,\"a\"\n\t" \
+	".section\t" __EX_TABLE ",\"a\"\n\t" \
 	".word\t1b,3b\n\t" \
 	".previous" \
 	:"=r" (__gu_err), "=r" (__gu_val) \
@@ -177,7 +184,7 @@
 	"move\t%D1,$0\n\t" \
 	"j\t3b\n\t" \
 	".previous\n\t" \
-	".section\t__ex_table,\"a\"\n\t" \
+	".section\t" __EX_TABLE ",\"a\"\n\t" \
 	".word\t1b,4b\n\t" \
 	".word\t2b,4b\n\t" \
 	".previous" \
@@ -238,7 +245,7 @@
 	"3:\tli\t%0,%3\n\t" \
 	"j\t2b\n\t" \
 	".previous\n\t" \
-	".section\t__ex_table,\"a\"\n\t" \
+	".section\t" __EX_TABLE ",\"a\"\n\t" \
 	".word\t1b,3b\n\t" \
 	".previous" \
 	:"=r" (__pu_err) \
@@ -255,7 +262,7 @@
 	"4:\tli\t%0,%4\n\t" \
 	"j\t3b\n\t" \
 	".previous\n\t" \
-	".section\t__ex_table,\"a\"\n\t" \
+	".section\t" __EX_TABLE ",\"a\"\n\t" \
 	".word\t1b,4b\n\t" \
 	".word\t2b,4b\n\t" \
 	".previous" \
Index: include/asm-ppc/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-ppc/init.h	1999/12/30 06:00:31	1.1.1.1
+++ include/asm-ppc/init.h	2000/04/20 02:47:31	1.1.1.1.2.1
@@ -2,37 +2,37 @@
 #define _PPC_INIT_H
 
 #if __GNUC__ > 2 || __GNUC_MINOR__ >= 90 /* egcs */
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 
-#define __pmac __attribute__ ((__section__ (".text.pmac")))
-#define __pmacdata __attribute__ ((__section__ (".data.pmac")))
+#define __pmac __attribute__ ((__section__ (".pmac.text")))
+#define __pmacdata __attribute__ ((__section__ (".pmac.data")))
 #define __pmacfunc(__argpmac) \
 	__argpmac __pmac; \
 	__argpmac
 	
-#define __prep __attribute__ ((__section__ (".text.prep")))
-#define __prepdata __attribute__ ((__section__ (".data.prep")))
+#define __prep __attribute__ ((__section__ (".prep.text")))
+#define __prepdata __attribute__ ((__section__ (".prep.data")))
 #define __prepfunc(__argprep) \
 	__argprep __prep; \
 	__argprep
 
 /* this is actually just common chrp/pmac code, not OF code -- Cort */
-#define __openfirmware __attribute__ ((__section__ (".text.openfirmware")))
-#define __openfirmwaredata __attribute__ ((__section__ (".data.openfirmware")))
+#define __openfirmware __attribute__ ((__section__ (".openfirmware.text")))
+#define __openfirmwaredata __attribute__ ((__section__ (".openfirmware.data")))
 #define __openfirmwarefunc(__argopenfirmware) \
 	__argopenfirmware __openfirmware; \
 	__argopenfirmware
 	
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT	.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 
 #define __cacheline_aligned __attribute__ \
-			 ((__section__ (".data.cacheline_aligned")))
+			 ((__section__ (".cacheline_aligned.data")))
 
 #else /* not egcs */
 
Index: include/asm-ppc/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-ppc/uaccess.h	1999/12/30 06:00:34	1.1.1.1
+++ include/asm-ppc/uaccess.h	2000/04/20 02:47:31	1.1.1.1.2.1
@@ -6,6 +6,13 @@
 #include <linux/errno.h>
 #include <asm/processor.h>
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
 
@@ -150,10 +157,11 @@
 		".section .fixup,\"ax\"\n"			\
 		"3:	li %0,%3\n"				\
 		"	b 2b\n"					\
-		".section __ex_table,\"a\"\n"			\
+		".previous\n"					\
+		".section " __EX_TABLE ",\"a\"\n"		\
 		"	.align 2\n"				\
 		"	.long 1b,3b\n"				\
-		".text"						\
+		".previous\n"					\
 		: "=r"(err)					\
 		: "r"(x), "b"(addr), "i"(-EFAULT), "0"(err))
 
@@ -197,10 +205,11 @@
 		"3:	li %0,%3\n"			\
 		"	li %1,0\n"			\
 		"	b 2b\n"				\
-		".section __ex_table,\"a\"\n"		\
+		".previous\n"				\
+		".section " __EX_TABLE ",\"a\"\n"	\
 		"	.align 2\n"			\
 		"	.long 1b,3b\n"			\
-		".text"					\
+		".previous\n"				\
 		: "=r"(err), "=r"(x)			\
 		: "b"(addr), "i"(-EFAULT), "0"(err))
 
Index: include/asm-sparc/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-sparc/init.h	1999/12/30 06:00:36	1.1.1.1
+++ include/asm-sparc/init.h	2000/04/20 02:47:32	1.1.1.1.2.1
@@ -2,17 +2,17 @@
 #define _SPARC_INIT_H
 
 #if (defined (__svr4__) || defined (__ELF__))
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 #define __cacheline_aligned __attribute__ \
-			((__section__ (".data.cacheline_aligned")))
+			((__section__ (".cacheline_aligned.data")))
 /* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT	.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 #else
 #define	__init
 #define __initdata
Index: include/asm-sparc/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-sparc/uaccess.h	1999/12/30 06:00:39	1.1.1.1
+++ include/asm-sparc/uaccess.h	2000/04/20 02:47:32	1.1.1.1.2.1
@@ -1,4 +1,4 @@
-/* $Id: uaccess.h,v 1.1.1.1 1999/12/30 06:00:39 greyham Exp $
+/* $Id: uaccess.h,v 1.1.1.1.2.1 2000/04/20 02:47:32 greyham Exp $
  * uaccess.h: User space memore access functions.
  *
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
@@ -16,6 +16,13 @@
 
 #ifndef __ASSEMBLY__
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 /* Sparc is not segmented, however we need to be able to fool verify_area()
  * when doing system calls from kernel mode legitimately.
  *
@@ -169,7 +176,7 @@
 	"b	2b\n\t"							\
 	" mov	%3, %0\n\t"						\
         ".previous\n\n\t"						\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\t"						\
 	".previous\n\n\t"						\
@@ -181,7 +188,7 @@
 __asm__ __volatile__(							\
 	"/* Put user asm ret, inline. */\n"				\
 "1:\t"	"st"#size " %1, %2\n\n\t"					\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, __ret_efault\n\n\t"					\
 	".previous\n\n\t"						\
@@ -196,7 +203,7 @@
 	"ret\n\t"							\
 	" restore %%g0, %3, %%o0\n\t"					\
 	".previous\n\n\t"						\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\n\t"						\
@@ -257,7 +264,7 @@
 	"b	2b\n\t"							\
 	" mov	%3, %0\n\n\t"						\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\t"							\
@@ -269,7 +276,7 @@
 __asm__ __volatile__(							\
 	"/* Get user asm ret, inline. */\n"				\
 "1:\t"	"ld"#size " %1, %0\n\n\t"					\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b,__ret_efault\n\n\t"					\
 	".previous\n\t"							\
@@ -284,7 +291,7 @@
 	"ret\n\t"							\
 	" restore %%g0, %2, %%o0\n\n\t"					\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\t"							\
@@ -345,7 +352,7 @@
 {
   __kernel_size_t ret;
   __asm__ __volatile__ ("
-	.section __ex_table,#alloc
+	.section " __EX_TABLE ",#alloc
 	.align 4
 	.word 1f,3
 	.previous
Index: include/asm-sparc64/init.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-sparc64/init.h	1999/12/30 06:00:42	1.1.1.1
+++ include/asm-sparc64/init.h	2000/04/20 02:47:32	1.1.1.1.2.1
@@ -1,15 +1,15 @@
 #ifndef _SPARC_INIT_H
 #define _SPARC_INIT_H
 
-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
 #define __initfunc(__arginit) \
 	__arginit __init; \
 	__arginit
 /* For assembly routines */
-#define __INIT		.section	".text.init",#alloc,#execinstr
+#define __INIT		.section	".init.text",#alloc,#execinstr
 #define __FINIT	.previous
-#define __INITDATA	.section	".data.init",#alloc,#write
+#define __INITDATA	.section	".init.data",#alloc,#write
 
 #define __cacheline_aligned __attribute__ ((aligned (64)))
 
Index: include/asm-sparc64/uaccess.h
===================================================================
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/asm-sparc64/uaccess.h	1999/12/30 06:00:45	1.1.1.1
+++ include/asm-sparc64/uaccess.h	2000/04/20 02:47:33	1.1.1.1.2.1
@@ -1,4 +1,4 @@
-/* $Id: uaccess.h,v 1.1.1.1 1999/12/30 06:00:45 greyham Exp $ */
+/* $Id: uaccess.h,v 1.1.1.1.2.1 2000/04/20 02:47:33 greyham Exp $ */
 #ifndef _ASM_UACCESS_H
 #define _ASM_UACCESS_H
 
@@ -17,6 +17,13 @@
 
 #ifndef __ASSEMBLY__
 
+/* Keep __ex_table in order with C .text.* when using -ffunction-sections */
+#ifdef FUNCTION_SECTIONS
+#define __EX_TABLE	"__ex_table." __FUNCTION__
+#else
+#define __EX_TABLE	"__ex_table"
+#endif
+
 /*
  * Sparc64 is segmented, though more like the M68K than the I386. 
  * We use the secondary ASI to address user memory, which references a
@@ -163,7 +170,7 @@
 	"b	2b\n\t"							\
 	" mov	%3, %0\n\n\t"						\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\t"						\
 	".previous\n\n\t"						\
@@ -175,7 +182,7 @@
 __asm__ __volatile__(							\
 	"/* Put user asm ret, inline. */\n"				\
 "1:\t"	"st"#size "a %1, [%2] %3\n\n\t"					\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, __ret_efault\n\n\t"					\
 	".previous\n\n\t"						\
@@ -190,7 +197,7 @@
 	"ret\n\t"							\
 	" restore %%g0, %3, %%o0\n\n\t"					\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\n\t"						\
@@ -233,7 +240,7 @@
 	"b	2b\n\t"							\
 	" mov	%3, %0\n\n\t"						\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\t"							\
@@ -245,7 +252,7 @@
 __asm__ __volatile__(							\
 	"/* Get user asm ret, inline. */\n"				\
 "1:\t"	"ld"#size "a [%1] %2, %0\n\n\t"					\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b,__ret_efault\n\n\t"					\
 	".previous\n\t"							\
@@ -260,7 +267,7 @@
 	"ret\n\t"							\
 	" restore %%g0, %3, %%o0\n\n\t"					\
 	".previous\n\t"							\
-	".section __ex_table,#alloc\n\t"				\
+	".section " __EX_TABLE ",#alloc\n\t"				\
 	".align	4\n\t"							\
 	".word	1b, 3b\n\n\t"						\
 	".previous\n\t"							\

-- 
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
