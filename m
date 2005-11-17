Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVKQNYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVKQNYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVKQNYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:24:43 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32433 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750791AbVKQNYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:24:42 -0500
Date: Thu, 17 Nov 2005 18:54:37 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/10] kdump:  x86_64 add memmmap command line option
Message-ID: <20051117132437.GI3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132315.GH3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch introduces the memmap option for x86_64 similar to i386.

o memmap=exactmap enables setting of an exact E820 memory map, as 
  specified by the user.

Changes in this version:

o Used e820_end_of_ram() to find the max_pfn as suggested by
  Andi kleen.

o removed PFN_UP & PFN_DOWN macros

o Printing the user defined map also.

Signed-off-by:Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by:Hariprasad Nellitheertha<nharipra@gmail.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/Documentation/kernel-parameters.txt |    2 
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/e820.c           |   21 +++++++
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/setup.c          |   27 ++++++++++
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/e820.h           |    1 
 4 files changed, 50 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/e820.c~x86_64-memmap-command-line-option arch/x86_64/kernel/e820.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/e820.c~x86_64-memmap-command-line-option	2005-11-17 11:10:58.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/e820.c	2005-11-17 11:10:58.000000000 +0530
@@ -560,6 +560,27 @@ void __init parse_memopt(char *p, char *
 	end_user_pfn >>= PAGE_SHIFT;	
 } 
 
+void __init parse_memmapopt(char *p, char **from)
+{
+	unsigned long long start_at, mem_size;
+
+	mem_size = memparse(p, from);
+	p = *from;
+	if (*p == '@') {
+		start_at = memparse(p+1, from);
+		add_memory_region(start_at, mem_size, E820_RAM);
+	} else if (*p == '#') {
+		start_at = memparse(p+1, from);
+		add_memory_region(start_at, mem_size, E820_ACPI);
+	} else if (*p == '$') {
+		start_at = memparse(p+1, from);
+		add_memory_region(start_at, mem_size, E820_RESERVED);
+	} else {
+		end_user_pfn = (mem_size >> PAGE_SHIFT);
+	}
+	p = *from;
+}
+
 unsigned long pci_mem_start = 0xaeedbabe;
 
 /*
diff -puN arch/x86_64/kernel/setup.c~x86_64-memmap-command-line-option arch/x86_64/kernel/setup.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/setup.c~x86_64-memmap-command-line-option	2005-11-17 11:10:58.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/setup.c	2005-11-17 12:00:35.000000000 +0530
@@ -274,6 +274,7 @@ static __init void parse_cmdline_early (
 {
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
+	int userdef = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
@@ -356,6 +357,28 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from, "mem=", 4))
 			parse_memopt(from+4, &from); 
 
+		if (!memcmp(from, "memmap=", 7)) {
+			/* exactmap option is for used defined memory */
+			if (!memcmp(from+7, "exactmap", 8)) {
+#ifdef CONFIG_CRASH_DUMP
+				/* If we are doing a crash dump, we
+				 * still need to know the real mem
+				 * size before original memory map is
+				 * reset.
+				 */
+				saved_max_pfn = e820_end_of_ram();
+#endif
+				from += 8+7;
+				end_pfn_map = 0;
+				e820.nr_map = 0;
+				userdef = 1;
+			}
+			else {
+				parse_memmapopt(from+7, &from);
+				userdef = 1;
+			}
+		}
+
 #ifdef CONFIG_NUMA
 		if (!memcmp(from, "numa=", 5))
 			numa_setup(from+5); 
@@ -402,6 +425,10 @@ static __init void parse_cmdline_early (
 			break;
 		*(to++) = c;
 	}
+	if (userdef) {
+		printk(KERN_INFO "user-defined physical RAM map:\n");
+		e820_print_map("user");
+	}
 	*to = '\0';
 	*cmdline_p = command_line;
 }
diff -puN Documentation/kernel-parameters.txt~x86_64-memmap-command-line-option Documentation/kernel-parameters.txt
--- linux-2.6.15-rc1-1M-dynamic/Documentation/kernel-parameters.txt~x86_64-memmap-command-line-option	2005-11-17 11:10:58.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/Documentation/kernel-parameters.txt	2005-11-17 12:00:35.000000000 +0530
@@ -824,7 +824,7 @@ running once the system is up.
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
-	memmap=exactmap	[KNL,IA-32] Enable setting of an exact
+	memmap=exactmap	[KNL,IA-32,X86_64] Enable setting of an exact
 			E820 memory map, as specified by the user.
 			Such memmap=exactmap lines can be constructed based on
 			BIOS output or other requirements. See the memmap=nn@ss
diff -puN include/asm-x86_64/e820.h~x86_64-memmap-command-line-option include/asm-x86_64/e820.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-x86_64/e820.h~x86_64-memmap-command-line-option	2005-11-17 11:10:58.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-x86_64/e820.h	2005-11-17 11:10:58.000000000 +0530
@@ -55,6 +55,7 @@ extern unsigned long e820_hole_size(unsi
 				    unsigned long end_pfn);
 
 extern void __init parse_memopt(char *p, char **end);
+extern void __init parse_memmapopt(char *p, char **end);
 
 extern struct e820map e820;
 #endif/*!__ASSEMBLY__*/
_
