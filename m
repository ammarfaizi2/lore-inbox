Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbTCJTvE>; Mon, 10 Mar 2003 14:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTCJTvD>; Mon, 10 Mar 2003 14:51:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261455AbTCJTu1>;
	Mon, 10 Mar 2003 14:50:27 -0500
Date: Mon, 10 Mar 2003 11:58:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Fix mem= options
Message-Id: <20030310115858.67288474.rddunlap@osdl.org>
In-Reply-To: <20030309221624.GA26517@elf.ucw.cz>
References: <20030309221624.GA26517@elf.ucw.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Your patch didn't quite work for me.  Did it work for you?

a.  Needs similar changes to Documentation/kernel-parameters.txt (below)
b.  The specified mem= (mem_size) wasn't saved anywhere.  I added a call
    to limit_regions() and set userdef to 1 and now ItWorksForMe.

Linus or Andrew, please apply so that the mem= boot parameter doesn't
stay damaged.

Thanks,
--
~Randy


patch_name:	memmap_ndocs.patch
patch_version:	2003-03-10.11:28:32
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	add docs for mem= and memmap=; fix mem= to remember mem_size;
product:	Linux
product_versions: linux-2564
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 Documentation/kernel-parameters.txt |   32 +++++++++++++++++---------------
 arch/i386/kernel/setup.c            |   29 +++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 19 deletions(-)


diff -Naur ./arch/i386/kernel/setup.c%MMCL ./arch/i386/kernel/setup.c
--- ./arch/i386/kernel/setup.c%MMCL	Tue Mar  4 19:29:18 2003
+++ ./arch/i386/kernel/setup.c	Mon Mar 10 11:06:34 2003
@@ -525,8 +525,11 @@
 		 * "mem=nopentium" disables the 4MB page tables.
 		 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
 		 * to <mem>, overriding the bios size.
-		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
+		 * "memmap=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
+		 *
+		 * HPA tells me bootloaders need to parse mem=, so no new
+		 * option should be mem=  [also see Documentation/i386/boot.txt]
 		 */
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
 			if (to != command_line)
@@ -535,8 +538,26 @@
 				from += 9+4;
 				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
 				disable_pse = 1;
-			} else if (!memcmp(from+4, "exactmap", 8)) {
-				from += 8+4;
+			} else {
+				/* If the user specifies memory size, we
+				 * limit the BIOS-provided memory map to
+				 * that size. exactmap can be used to specify
+				 * the exact map. mem=number can be used to
+				 * trim the existing memory map.
+				 */
+				unsigned long long mem_size;
+ 
+				mem_size = memparse(from+4, &from);
+				limit_regions(mem_size);
+				userdef=1;
+			}
+		}
+
+		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
+			if (to != command_line)
+				to--;
+			if (!memcmp(from+7, "exactmap", 8)) {
+				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
 			} else {
@@ -548,7 +569,7 @@
 				 */
 				unsigned long long start_at, mem_size;
  
-				mem_size = memparse(from+4, &from);
+				mem_size = memparse(from+7, &from);
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);
diff -Naur ./Documentation/kernel-parameters.txt%MMCL ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt%MMCL	Tue Mar  4 19:29:57 2003
+++ ./Documentation/kernel-parameters.txt	Mon Mar 10 10:21:22 2003
@@ -71,6 +71,8 @@
 
 Parameters denoted with BOOT are actually interpreted by the boot
 loader, and have no meaning to the kernel directly.
+Do not modify the syntax of boot loader parameters without extreme
+need or coordination with <Documentation/i386/boot.txt>.
 
 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
 a trailing = on the name of any parameter states that that parameter will
@@ -502,30 +504,30 @@
 			Format: <first>,<last>
 			Specifies range of consoles to be captured by the MDA.
  
-	mem=exactmap	[KNL,BOOT,IA-32] Enable setting of an exact
-			E820 memory map, as specified by the user.
-			Such mem=exactmap lines can be constructed based on
-			BIOS output or other requirements. See the mem=nn@ss
-			option description.
-
 	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
 			Amount of memory to be used when the kernel is not able
 			to see the whole system memory or for test.
 
-	mem=nn[KMG]@ss[KMG]
-			[KNL,BOOT] Force usage of a specific region of memory
-			Region of memory to be used, from ss to ss+nn.
+	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
+			memory.
 
-	mem=nn[KMG]#ss[KMG]
-			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
+	memmap=exactmap	[KNL,IA-32] Enable setting of an exact
+			E820 memory map, as specified by the user.
+			Such memmap=exactmap lines can be constructed based on
+			BIOS output or other requirements. See the memmap=nn@ss
+			option description.
+
+	memmap=nn[KMG]@ss[KMG]
+			[KNL] Force usage of a specific region of memory
 			Region of memory to be used, from ss to ss+nn.
 
-	mem=nn[KMG]$ss[KMG]
-			[KNL,BOOT,ACPI] Mark specific memory as reserved.
+	memmap=nn[KMG]#ss[KMG]
+			[KNL,ACPI] Mark specific memory as ACPI data.
 			Region of memory to be used, from ss to ss+nn.
 
-	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
-			memory.
+	memmap=nn[KMG]$ss[KMG]
+			[KNL,ACPI] Mark specific memory as reserved.
+			Region of memory to be used, from ss to ss+nn.
 
 	memfrac=	[KNL]
 
