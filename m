Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWCGVJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWCGVJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWCGVJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:09:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:26572 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751628AbWCGVJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:09:48 -0500
Subject: Re: 2.6.16-rc5 huge memory detection regression
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060307113631.36ac029d.akpm@osdl.org>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
	 <20060307041532.3ef45392.akpm@osdl.org>
	 <440D7BB8.40106@ribosome.natur.cuni.cz>
	 <20060307113631.36ac029d.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-M4EhnHNVVov2nRhCNlmw"
Date: Tue, 07 Mar 2006 13:08:42 -0800
Message-Id: <1141765722.9274.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M4EhnHNVVov2nRhCNlmw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-03-07 at 11:36 -0800, Andrew Morton wrote:
> Because there was a change which could have affected this.  But it was
> merged in late October and was present in 2.6.15.

It certainly is possible that my patch caused the bug.  However, my
patch only affects limit_regions(), which is only called when the user
specifies a mem= argument on the command-line.  When they do this, in
addition to the BIOS-e820 printout, they should also see a "user-defined
physical RAM map:", which I don't see in the diff.  Also, I'm pretty
sure that this e820 printout runs before parse_cmdline_early(), where
limit_regions() is called.

Martin, in any case, I have debugged things in that code recently, and
I'd be happy to help you fix your problem.  I've attached a patch that
does a ton of e820 debug printks.  If you could get me a full copy of
your dmesg with that applied, I should be able to locate the problem a
bit more quickly.

-- Dave



--=-M4EhnHNVVov2nRhCNlmw
Content-Disposition: attachment; filename=e820-debug.patch
Content-Type: text/x-patch; name=e820-debug.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 include/asm-i386/mach-visws/setup_arch_post.h |    0 
 work-dave/arch/i386/kernel/setup.c            |   27 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/setup.c~e820-debug arch/i386/kernel/setup.c
--- work/arch/i386/kernel/setup.c~e820-debug	2006-03-07 12:47:23.000000000 -0800
+++ work-dave/arch/i386/kernel/setup.c	2006-03-07 13:07:49.000000000 -0800
@@ -363,11 +363,13 @@ static void __init probe_roms(void)
 	}
 }
 
+static void __init print_memory_map(char *who);
 static void __init limit_regions(unsigned long long size)
 {
 	unsigned long long current_addr = 0;
 	int i;
 
+	print_memory_map("limit_regions start");
 	if (efi_enabled) {
 		efi_memory_desc_t *md;
 		void *p;
@@ -404,8 +406,10 @@ static void __init limit_regions(unsigne
 			e820.nr_map = i + 1;
 			e820.map[i].size -= current_addr - size;
 		}
+		print_memory_map("limit_regions endfor");
 		return;
 	}
+	print_memory_map("limit_regions endfunc");
 }
 
 static void __init add_memory_region(unsigned long long start,
@@ -413,6 +417,7 @@ static void __init add_memory_region(uns
 {
 	int x;
 
+	printk("add_memory_region(%016Lx, %016Lx, %d)\n", start, size, type);
 	if (!efi_enabled) {
        		x = e820.nr_map;
 
@@ -518,17 +523,21 @@ static int __init sanitize_e820_map(stru
 		   ____________________33__
 		   ______________________4_
 	*/
-
+	printk("sanitize start\n");
 	/* if there's only one memory region, don't bother */
-	if (*pnr_map < 2)
+	if (*pnr_map < 2) {
+		printk("sanitize bail 0\n");
 		return -1;
+	}
 
 	old_nr = *pnr_map;
 
 	/* bail out if we find any unreasonable addresses in bios map */
 	for (i=0; i<old_nr; i++)
-		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr)
+		if (biosmap[i].addr + biosmap[i].size < biosmap[i].addr) {
+			printk("sanitize bail 1\n");
 			return -1;
+		}
 
 	/* create pointers for initial change-point information (for sorting) */
 	for (i=0; i < 2*old_nr; i++)
@@ -622,6 +631,7 @@ static int __init sanitize_e820_map(stru
 	memcpy(biosmap, new_bios, new_nr*sizeof(struct e820entry));
 	*pnr_map = new_nr;
 
+	printk("sanitize end\n");
 	return 0;
 }
 
@@ -652,6 +662,7 @@ static int __init copy_e820_map(struct e
 		unsigned long long size = biosmap->size;
 		unsigned long long end = start + size;
 		unsigned long type = biosmap->type;
+		printk("copy_e820_map() start: %016Lx size: %016Lx end: %016Lx type: %ld\n", start, size, end, type);
 
 		/* Overflow in 64 bits? Ignore the memory map. */
 		if (start > end)
@@ -662,11 +673,17 @@ static int __init copy_e820_map(struct e
 		 * Not right. Fix it up.
 		 */
 		if (type == E820_RAM) {
+			printk("copy_e820_map() type is E820_RAM\n");
 			if (start < 0x100000ULL && end > 0xA0000ULL) {
-				if (start < 0xA0000ULL)
+				printk("copy_e820_map() lies in range...\n");
+				if (start < 0xA0000ULL) {
+					printk("copy_e820_map() start < 0xA0000ULL\n");
 					add_memory_region(start, 0xA0000ULL-start, type);
-				if (end <= 0x100000ULL)
+				}
+				if (end <= 0x100000ULL) {
+					printk("copy_e820_map() end <= 0x100000ULL\n");
 					continue;
+				}
 				start = 0x100000ULL;
 				size = end - start;
 			}
diff -puN include/asm-i386/mach-default/setup_arch_post.h~e820-debug include/asm-i386/mach-default/setup_arch_post.h
diff -puN include/asm-i386/mach-visws/setup_arch_post.h~e820-debug include/asm-i386/mach-visws/setup_arch_post.h
_

--=-M4EhnHNVVov2nRhCNlmw--

