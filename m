Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSLCAJC>; Mon, 2 Dec 2002 19:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSLCAJC>; Mon, 2 Dec 2002 19:09:02 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34002 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265732AbSLCAI4>;
	Mon, 2 Dec 2002 19:08:56 -0500
Message-ID: <3DEBF78F.5030007@us.ibm.com>
Date: Mon, 02 Dec 2002 16:15:11 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@redhat.com>
Subject: Re: [PATCH] (2/3) do early command line parsing for 386
References: <3DEBF6BB.7000901@us.ibm.com>
In-Reply-To: <3DEBF6BB.7000901@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010108090102060708090409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010108090102060708090409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This actually implements the early command-line parsing for i386.  It 
actually decreases the amount of code in setup.c, and makes it a lot 
more readable.

setup.c |  138 
+++++++++++++++++++++++++++++++---------------------------------
1 files changed, 68 insertions(+), 70 deletions(-)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010108090102060708090409
Content-Type: text/plain;
 name="B-ordered-setup-i386-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="B-ordered-setup-i386-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.969   -> 1.970  
#	arch/i386/kernel/setup.c	1.63    -> 1.64   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/02	haveblue@elm3b96.(none)	1.970
# 1-2
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Dec  2 15:59:44 2002
+++ b/arch/i386/kernel/setup.c	Mon Dec  2 15:59:44 2002
@@ -498,82 +498,68 @@
 	print_memory_map(who);
 } /* setup_memory_region */
 
-
-static void __init parse_cmdline_early (char ** cmdline_p)
+/*
+ * "mem=nopentium" disables the 4MB page tables.
+ */
+static int arch_setup_mem_nopentium(char* arg)
 {
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
-	int len = 0;
-	int userdef = 0;
-
-	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
-	for (;;) {
-		/*
-		 * "mem=nopentium" disables the 4MB page tables.
-		 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
-		 * to <mem>, overriding the bios size.
-		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
-		 * <start> to <start>+<mem>, overriding the bios size.
-		 */
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
-			if (to != command_line)
-				to--;
-			if (!memcmp(from+4, "nopentium", 9)) {
-				from += 9+4;
-				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
-			} else if (!memcmp(from+4, "exactmap", 8)) {
-				from += 8+4;
-				e820.nr_map = 0;
-				userdef = 1;
-			} else {
-				/* If the user specifies memory size, we
-				 * limit the BIOS-provided memory map to
-				 * that size. exactmap can be used to specify
-				 * the exact map. mem=number can be used to
-				 * trim the existing memory map.
-				 */
-				unsigned long long start_at, mem_size;
- 
-				mem_size = memparse(from+4, &from);
-				if (*from == '@') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RAM);
-				} else {
-					limit_regions(mem_size);
-					userdef=1;
-				}
-			}
-		}
+	clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
+	return 1;
+}
 
-		/* "acpi=off" disables both ACPI table parsing and interpreter init */
-		if (c == ' ' && !memcmp(from, "acpi=off", 8))
-			acpi_disabled = 1;
+static int arch_setup_mem_exactmap(char* arg)
+{
+	e820.nr_map = 0;
+	printk(KERN_INFO "user-defined physical RAM map:\n");
+	print_memory_map("user");
+	
+	return 1;
+}
 
-		/*
-		 * highmem=size forces highmem to be exactly 'size' bytes.
-		 * This works even on boxes that have no highmem otherwise.
-		 * This also works to reduce highmem size on bigger boxes.
-		 */
-		if (c == ' ' && !memcmp(from, "highmem=", 8))
-			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
+/*
+ * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
+ * to <mem>, overriding the bios size.
+ * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
+ * <start> to <start>+<mem>, overriding the bios size.
+ */
+static int arch_setup_mem(char* arg)
+{
+	unsigned long long start_at, mem_size;
+	char* next;
 	
-		c = *(from++);
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-	*to = '\0';
-	*cmdline_p = command_line;
-	if (userdef) {
-		printk(KERN_INFO "user-defined physical RAM map:\n");
+	mem_size = memparse(arg, &next);
+	if( arg == next )
+		return 0;
+	if (*next == '@') {
+		start_at = memparse(next+1, &next);
+	add_memory_region(start_at, mem_size, E820_RAM);
+	} else {
+		limit_regions(mem_size);
+		printk(KERN_INFO "user-defined physical RAM size:\n");
 		print_memory_map("user");
 	}
+	return 1;
+}
+
+static int arch_setup_acpi_off(char* arg)
+{
+	acpi_disabled = 1;
+	return 1;
+}
+
+
+static int arch_setup_highmem(char* arg)
+{
+	highmem_pages = memparse(arg, &arg) >> PAGE_SHIFT;
+	return 1;
 }
 
+__ordered_setup(SETUP_ARCH_LATE, "mem=nopentium", arch_setup_mem_nopentium);
+__ordered_setup(SETUP_ARCH_LATE, "mem=exactmap", arch_setup_mem_exactmap);
+__ordered_setup(SETUP_ARCH_LATE, "mem=", arch_setup_mem);
+__ordered_setup(SETUP_ARCH_LATE, "acpi=off", arch_setup_acpi_off);
+__ordered_setup(SETUP_ARCH_LATE, "highmem=", arch_setup_highmem);
+
 /*
  * Find the highest page frame number we have available
  */
@@ -833,10 +819,22 @@
 		pci_mem_start = low_mem_size;
 }
 
+extern void __init parse_options(char *line);
+extern void __init run_setup(int setup_level);
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
 
+	/* Save unparsed command line copy for /proc/cmdline */
+	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	strncpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
+	parse_options(command_line);
+	run_setup(SETUP_ARCH_BEGIN);
+	
 	pre_setup_arch_hook();
 	early_cpu_init();
 
@@ -875,8 +873,8 @@
 	data_resource.start = virt_to_phys(&_etext);
 	data_resource.end = virt_to_phys(&_edata)-1;
 
-	parse_cmdline_early(cmdline_p);
-
+	run_setup(SETUP_ARCH_LATE);
+	
 	max_low_pfn = setup_memory();
 
 	/*

--------------010108090102060708090409--

