Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbTDAFrs>; Tue, 1 Apr 2003 00:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbTDAFrs>; Tue, 1 Apr 2003 00:47:48 -0500
Received: from dp.samba.org ([66.70.73.150]:59324 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262059AbTDAFrk>;
	Tue, 1 Apr 2003 00:47:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put all functions in kallsyms 
In-reply-to: Your message of "Mon, 31 Mar 2003 17:40:27 CST."
             <Pine.LNX.4.44.0303311736440.10623-100000@chaos.physics.uiowa.edu> 
Date: Tue, 01 Apr 2003 15:40:24 +1000
Message-Id: <20030401055903.91C3C2C015@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0303311736440.10623-100000@chaos.physics.uiowa.edu> y
ou write:
> On Mon, 31 Mar 2003, Rusty Russell wrote:
> 
> > 	Simple, untested patch.  Any objections?
> 
> No objection, but you need to adapt the test in
> kernel/kallsyms.c:
> 
> 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
> 
> and in kernel/extable.c:
> 
> 	if (addr >= (unsigned long)_stext &&
> 	    addr <= (unsigned long)_etext)
> 
> Otherwise, you'd just add bloat with no gain at all ;)

Ick.  Yes, the extable.c one is the killer.  OK, let's do it the other
way.

How's this?  (Actually tested this time).
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Include All Functions in kallsyms
Author: Rusty Russell
Status: Tested on 2.5.66-bk6

D: Introduce _sinittext and _einittext (cf. _stext and _etext), so kallsyms
D: includes __init functions.
D:
D: TODO: Use huffman name compression and 16-bit offsets (see IDE
D: oopser patch)

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/alpha/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/alpha/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/alpha/vmlinux.lds.S	2003-03-18 12:21:30.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/alpha/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -32,7 +32,11 @@ SECTIONS
   /* Will be freed after init */
   . = ALIGN(8192);				/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
 
   . = ALIGN(16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/arm/vmlinux-armo.lds.in working-2.5.66-bk6-kallsyms-all/arch/arm/vmlinux-armo.lds.in
--- linux-2.5.66-bk6/arch/arm/vmlinux-armo.lds.in	2003-03-18 12:21:30.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/arm/vmlinux-armo.lds.in	2003-04-01 12:30:50.000000000 +1000
@@ -14,7 +14,9 @@ SECTIONS
 	.init : {			/* Init code and data		*/
 		_stext = .;
 		__init_begin = .;
+			_sinittext = .;
 			*(.init.text)
+			_einittext = .;
 		__proc_info_begin = .;
 			*(.proc.info)
 		__proc_info_end = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/arm/vmlinux-armv.lds.in working-2.5.66-bk6-kallsyms-all/arch/arm/vmlinux-armv.lds.in
--- linux-2.5.66-bk6/arch/arm/vmlinux-armv.lds.in	2003-03-18 12:21:30.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/arm/vmlinux-armv.lds.in	2003-04-01 12:30:50.000000000 +1000
@@ -18,7 +18,9 @@ SECTIONS
 	.init : {			/* Init code and data		*/
 		_stext = .;
 		__init_begin = .;
+			_sinittext = .;
 			*(.init.text)
+			_einittext = .;
 		__proc_info_begin = .;
 			*(.proc.info)
 		__proc_info_end = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/i386/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/i386/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/i386/vmlinux.lds.S	2003-03-18 12:21:31.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/i386/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -54,7 +54,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/ia64/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/ia64/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/ia64/vmlinux.lds.S	2003-03-18 12:21:31.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/ia64/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -96,7 +96,11 @@ SECTIONS
   . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   .init.text : AT(ADDR(.init.text) - PAGE_OFFSET)
-	{ *(.init.text) }
+	{
+	  _sinittext = .;
+	  *(.init.text)
+	  _einittext = .;
+	}
 
   .init.data : AT(ADDR(.init.data) - PAGE_OFFSET)
 	{ *(.init.data) }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/m68k/vmlinux-std.lds working-2.5.66-bk6-kallsyms-all/arch/m68k/vmlinux-std.lds
--- linux-2.5.66-bk6/arch/m68k/vmlinux-std.lds	2003-03-18 12:21:31.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/m68k/vmlinux-std.lds	2003-04-01 12:30:50.000000000 +1000
@@ -40,7 +40,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/m68k/vmlinux-sun3.lds working-2.5.66-bk6-kallsyms-all/arch/m68k/vmlinux-sun3.lds
--- linux-2.5.66-bk6/arch/m68k/vmlinux-sun3.lds	2003-03-25 12:16:57.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/m68k/vmlinux-sun3.lds	2003-04-01 12:30:50.000000000 +1000
@@ -34,7 +34,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(8192);	/* Init code and data */
 __init_begin = .;
-  	.init.text : { *(.init.text) }
+	.init.text : { 
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
   	.init.data : { *(.init.data) }
 	. = ALIGN(16);
 	__setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/m68knommu/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/m68knommu/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/m68knommu/vmlinux.lds.S	2003-03-18 12:21:31.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/m68knommu/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -282,7 +282,9 @@ SECTIONS {
 	.init : {
 		. = ALIGN(4096);
 		__init_begin = .;
+		_sinittext = .;
 		*(.init.text)
+		_einittext = .;
 		*(.init.data)
 		. = ALIGN(16);
 		__setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/parisc/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/parisc/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/parisc/vmlinux.lds.S	2003-03-18 12:21:32.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/parisc/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -53,7 +53,11 @@ SECTIONS
 
   . = ALIGN(16384);
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/ppc/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/ppc/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/ppc/vmlinux.lds.S	2003-03-18 12:21:32.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/ppc/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -78,7 +78,11 @@ SECTIONS
 
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { 
     *(.init.data);
     __vtop_table_begin = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/ppc64/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/ppc64/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/ppc64/vmlinux.lds.S	2003-03-18 12:21:32.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/ppc64/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -77,7 +77,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/s390/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/s390/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/s390/vmlinux.lds.S	2003-03-18 12:21:32.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/s390/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -58,7 +58,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(256);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/s390x/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/s390x/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/s390x/vmlinux.lds.S	2003-03-18 12:21:32.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/s390x/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -58,7 +58,11 @@ SECTIONS
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(256);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/sparc/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/sparc/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/sparc/vmlinux.lds.S	2003-03-18 12:21:33.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/sparc/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -34,7 +34,11 @@ SECTIONS
 
   . = ALIGN(4096);
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   __init_text_end = .;
   .init.data : { *(.init.data) }
   . = ALIGN(16);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/sparc64/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/sparc64/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/sparc64/vmlinux.lds.S	2003-03-18 12:21:33.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/sparc64/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -41,7 +41,11 @@ SECTIONS
 
   . = ALIGN(8192);
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/v850/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/v850/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/v850/vmlinux.lds.S	2003-02-25 10:10:52.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/v850/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -105,7 +105,9 @@
 #define RAMK_INIT_CONTENTS_NO_END					      \
 		. = ALIGN (4096) ;					      \
 		__init_start = . ;					      \
+			_sinittext = .;					      \
 			*(.init.text)	/* 2.5 convention */		      \
+			_einittext = .;					      \
 			*(.init.data)					      \
 			*(.text.init)	/* 2.4 convention */		      \
 			*(.data.init)					      \
@@ -125,7 +127,9 @@
 /* The contents of `init' section for a ROM-resident kernel which
    should go into ROM.  */	
 #define ROMK_INIT_ROM_CONTENTS						      \
+			_sinittext = .;					      \
 			*(.init.text)	/* 2.5 convention */		      \
+			_einittext = .;					      \
 			*(.text.init)	/* 2.4 convention */		      \
 		INITCALL_CONTENTS					      \
 		INITRAMFS_CONTENTS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/arch/x86_64/vmlinux.lds.S working-2.5.66-bk6-kallsyms-all/arch/x86_64/vmlinux.lds.S
--- linux-2.5.66-bk6/arch/x86_64/vmlinux.lds.S	2003-03-18 12:21:33.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/arch/x86_64/vmlinux.lds.S	2003-04-01 12:30:50.000000000 +1000
@@ -78,7 +78,11 @@ SECTIONS
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { *(.init.text) }
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
   .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/kernel/extable.c working-2.5.66-bk6-kallsyms-all/kernel/extable.c
--- linux-2.5.66-bk6/kernel/extable.c	2003-02-07 19:20:44.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/kernel/extable.c	2003-04-01 12:30:50.000000000 +1000
@@ -19,7 +19,7 @@
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
-extern char _stext[], _etext[];
+extern char _stext[], _etext[], _sinittext[], _einittext[];
 
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
@@ -38,5 +38,9 @@ int kernel_text_address(unsigned long ad
 	    addr <= (unsigned long)_etext)
 		return 1;
 
+	if (addr >= (unsigned long)_sinittext &&
+	    addr <= (unsigned long)_einittext)
+		return 1;
+
 	return module_text_address(addr);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/kernel/kallsyms.c working-2.5.66-bk6-kallsyms-all/kernel/kallsyms.c
--- linux-2.5.66-bk6/kernel/kallsyms.c	2003-02-07 19:22:28.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/kernel/kallsyms.c	2003-04-01 12:30:50.000000000 +1000
@@ -15,7 +15,22 @@ extern unsigned long kallsyms_num_syms _
 extern char kallsyms_names[] __attribute__((weak));
 
 /* Defined by the linker script. */
-extern char _stext[], _etext[];
+extern char _stext[], _etext[], _sinittext[], _einittext[];
+
+static inline int is_kernel_inittext(unsigned long addr)
+{
+	if (addr >= (unsigned long)_sinittext
+	    && addr <= (unsigned long)_einittext)
+		return 1;
+	return 0;
+}
+
+static inline int is_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext)
+		return 1;
+	return 0;
+}
 
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
@@ -31,7 +46,7 @@ const char *kallsyms_lookup(unsigned lon
 	namebuf[127] = 0;
 	namebuf[0] = 0;
 
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
+	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
 		unsigned long symbol_end;
 		char *name = kallsyms_names;
 
@@ -52,6 +67,8 @@ const char *kallsyms_lookup(unsigned lon
 		/* Base symbol size on next symbol. */
 		if (best + 1 < kallsyms_num_syms)
 			symbol_end = kallsyms_addresses[best + 1];
+		else if (is_kernel_inittext(addr))
+			symbol_end = (unsigned long)_einittext;
 		else
 			symbol_end = (unsigned long)_etext;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk6/scripts/kallsyms.c working-2.5.66-bk6-kallsyms-all/scripts/kallsyms.c
--- linux-2.5.66-bk6/scripts/kallsyms.c	2003-02-07 19:22:29.000000000 +1100
+++ working-2.5.66-bk6-kallsyms-all/scripts/kallsyms.c	2003-04-01 12:30:50.000000000 +1000
@@ -21,7 +21,7 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext;
+static unsigned long long _stext, _etext, _sinittext, _einittext;
 
 static void
 usage(void)
@@ -51,10 +51,8 @@ read_symbol(FILE *in, struct sym_entry *
 static int
 symbol_valid(struct sym_entry *s)
 {
-	if (s->addr < _stext)
-		return 0;
-
-	if (s->addr > _etext)
+	if ((s->addr < _stext || s->addr > _etext)
+	    && (s->addr < _sinittext || s->addr > _einittext))
 		return 0;
 
 	if (strstr(s->sym, "_compiled."))
@@ -85,6 +83,10 @@ read_map(FILE *in)
 			_stext = table[i].addr;
 		if (strcmp(table[i].sym, "_etext") == 0)
 			_etext = table[i].addr;
+		if (strcmp(table[i].sym, "_sinittext") == 0)
+			_sinittext = table[i].addr;
+		if (strcmp(table[i].sym, "_einittext") == 0)
+			_einittext = table[i].addr;
 	}
 }
 
