Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUBTOD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUBTOBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:01:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62428 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261234AbUBTOAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:00:30 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 20 Feb 2004 15:00:10 +0100 (MET)
Message-Id: <UTC200402201400.i1KE0AH09811.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hpa@transmeta.com
Subject: Re: kernel too big
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned yesterday: a (2.6.3) kernel with _end past 8MB
will crash silently at boot time.
There is a warning in build.c for "kernel too big", but it
tests the size of the compressed kernel, a random variable
only vaguely related to _end.

The below does three things:

1. In arch/i386/boot/Makefile: determine the value of _end
   and give build the parameter -e end.
2. In arch/i386/boot/tools/build.c: accept the parameter -e end
   and use that in the check for "too big".
   The right value to test against is today 0xc0800000.
3. Changes the initial page tables so that 12 MB instead of 8 MB
   is available. Now the value to check against in 2. is 0xc0c00000.

Note that I do not know anything about Makefiles or about page tables.

Andries


diff -uprN -X /linux/dontdiff a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	2003-12-18 03:58:46.000000000 +0100
+++ b/arch/i386/boot/Makefile	2004-02-20 14:44:36.000000000 +0100
@@ -37,7 +37,8 @@ $(obj)/zImage:  IMAGE_OFFSET := 0x1000
 $(obj)/zImage:  EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK)
 $(obj)/bzImage: IMAGE_OFFSET := 0x100000
 $(obj)/bzImage: EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
-$(obj)/bzImage: BUILDFLAGS   := -b
+$(obj)/bzImage:	END          := `$(NM) vmlinux | grep -w _end | sed 's/ .*//'`
+$(obj)/bzImage: BUILDFLAGS   := -b -e $(END)
 
 quiet_cmd_image = BUILD   $@
 cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/bootsect $(obj)/setup \
diff -uprN -X /linux/dontdiff a/arch/i386/boot/tools/build.c b/arch/i386/boot/tools/build.c
--- a/arch/i386/boot/tools/build.c	2003-12-18 03:58:49.000000000 +0100
+++ b/arch/i386/boot/tools/build.c	2004-02-20 14:48:12.000000000 +0100
@@ -66,23 +66,31 @@ void file_open(const char *name)
 
 void usage(void)
 {
-	die("Usage: build [-b] bootsect setup system [rootdev] [> image]");
+	die("Usage: build [-b] [-e end] bootsect setup system [rootdev] [> image]");
 }
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, c, sz, setup_sectors;
+	unsigned int i, c, sz, setup_sectors, end;
 	u32 sys_size;
 	byte major_root, minor_root;
 	struct stat sb;
 
-	if (argc > 2 && !strcmp(argv[1], "-b"))
-	  {
-	    is_big_kernel = 1;
-	    argc--, argv++;
-	  }
-	if ((argc < 4) || (argc > 5))
+	if (argc > 2 && !strcmp(argv[1], "-b")) {
+		is_big_kernel = 1;
+		argc--, argv++;
+	}
+
+	end = 0;
+	if (argc > 3 && !strcmp(argv[1], "-e")) {
+		end = strtoul(argv[2], 0, 16);
+		argc -= 2;
+		argv += 2;
+	}
+
+	if (argc < 4 || argc > 5)
 		usage();
+
 	if (argc > 4) {
 		if (!strcmp(argv[4], "CURRENT")) {
 			if (stat("/", &sb)) {
@@ -150,10 +158,13 @@ int main(int argc, char ** argv)
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
+
+	if ((is_big_kernel && end && end > 0xc0c00000) ||
+	    (!is_big_kernel && sys_size > DEF_SYSSIZE)) {
 		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
+		    is_big_kernel ? "" : "bzImage or ");
+	}
+
 	while (sz > 0) {
 		int l, n;
 
diff -uprN -X /linux/dontdiff a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2003-12-18 03:58:08.000000000 +0100
+++ b/arch/i386/kernel/head.S	2004-02-20 13:34:35.000000000 +0100
@@ -377,23 +377,25 @@ cpu_gdt_descr:
 	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
 /*
- * This is initialized to create an identity-mapping at 0-8M (for bootup
- * purposes) and another mapping of the 0-8M area at virtual address
+ * This is initialized to create an identity-mapping at 0-12M (for bootup
+ * purposes) and another mapping of the 0-12M area at virtual address
  * PAGE_OFFSET.
  */
 .org 0x1000
 ENTRY(swapper_pg_dir)
 	.long 0x00102007
 	.long 0x00103007
-	.fill BOOT_USER_PGD_PTRS-2,4,0
-	/* default: 766 entries */
+	.long 0x00104007
+	.fill BOOT_USER_PGD_PTRS-3,4,0
+	/* default: 765 entries */
 	.long 0x00102007
 	.long 0x00103007
-	/* default: 254 entries */
-	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
+	.long 0x00104007
+	/* default: 253 entries */
+	.fill BOOT_KERNEL_PGD_PTRS-3,4,0
 
 /*
- * The page tables are initialized to only 8MB here - the final page
+ * The page tables are initialized to only 12MB here - the final page
  * tables are set up later depending on memory size.
  */
 .org 0x2000
@@ -402,15 +404,18 @@ ENTRY(pg0)
 .org 0x3000
 ENTRY(pg1)
 
+.org 0x4000
+ENTRY(pg2)
+
 /*
  * empty_zero_page must immediately follow the page tables ! (The
  * initialization loop counts until empty_zero_page)
  */
 
-.org 0x4000
+.org 0x5000
 ENTRY(empty_zero_page)
 
-.org 0x5000
+.org 0x6000
 
 /*
  * Real beginning of normal "text" segment
