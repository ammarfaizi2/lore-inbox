Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266872AbUBGLxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266873AbUBGLxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:53:40 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53632 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266872AbUBGLwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:52:38 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] 2.4.25-rc1: Add user friendliness to highmem= option
Date: Sat, 7 Feb 2004 19:50:53 +0800
User-Agent: KMail/1.5.4
Cc: axboe@suse.de, <rddunlap@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402071950.53386.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Enclosed is a patch for x86 to make highmem= option easier to use.

- Automates alignment of highmem zone
- Fixes invalid highmem settings whether too small or to large
- Adds entry in kernel-parameters.txt

Highmem emulation can be used on any machine with at least 68MB RAM.

The patch does not add to bloat as it part of __init code.

Please consider applying it as it makes this option quite usable

Regards
Michael

Examples on a machine with 495MB available RAM:

highmem=1m

Warning highmem=1MB is too small and has been adjusted to: 4MB.
Warning bad highmem zone alignment 0x1f0000, highmem size will be adjusted.
Warning lowmem size adjusted  for zone alignment to: 492MB.
Warning highmem size adjusted for zone alignment to: 3MB.
3MB HIGHMEM available.
492MB LOWMEM available.

highmem=300m

Warning bad highmem zone alignment 0x1f0000, highmem size will be adjusted.
Warning lowmem size adjusted  for zone alignment to: 196MB.
Warning highmem size adjusted for zone alignment to: 299MB.
299MB HIGHMEM available.
196MB LOWMEM available.

highmem=450m

Warning highmem size adjusted for a minimum of 64MB lowmem to: 431MB.
431MB HIGHMEM available.
64MB LOWMEM available.

highmem=5000m

Warning highmem=5000MB is bigger than available 495MB and will be adjusted.
Warning highmem size adjusted for a minimum of 64MB lowmem to: 431MB.
431MB HIGHMEM available.
64MB LOWMEM available.

mem=70m highmem=300m

user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000004600000 (usable)
Warning highmem=300MB is bigger than available 70MB and will be adjusted.
Warning highmem size adjusted for a minimum of 64MB lowmem to: 6MB.
6MB HIGHMEM available.
64MB LOWMEM available.

mem=66m highmem=1m

user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000004200000 (usable)
Error highmem support requires at least 68MB but only 66MB are available.
0MB HIGHMEM available.
66MB LOWMEM available.

mem=68m highmem=10m

user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000004400000 (usable)
Warning highmem size adjusted for a minimum of 64MB lowmem to: 4MB.
4MB HIGHMEM available.
64MB LOWMEM available.

diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.25-rc1-Vanilla/arch/i386/kernel/setup.c linux-2.4.25-rc1-mhf176/arch/i386/kernel/setup.c
--- linux-2.4.25-rc1-Vanilla/arch/i386/kernel/setup.c	2004-02-07 02:52:37.000000000 +0800
+++ linux-2.4.25-rc1-mhf176/arch/i386/kernel/setup.c	2004-02-07 18:53:47.000000000 +0800
@@ -861,9 +861,12 @@
                         disable_ioapic_setup();
 #endif
 		/*
-		 * highmem=size forces highmem to be exactly 'size' bytes.
+		 * highmem=size forces highmem to be at most 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
 		 * This also works to reduce highmem size on bigger boxes.
+		 *
+		 * Note: highmem sise is adjusted downward for proper zone
+		 *       alignment of the highmem physical start address.
 		 */
 		else if (!memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
@@ -918,25 +921,31 @@
 /*
  * Determine low and high memory ranges:
  */
+
+#define ZONE_REQUIRED_PAGE_ALIGNMENT (1UL << (MAX_ORDER-1))
+#define ZONE_REQUIRED_PAGE_ALIGNMENT_MASK (ZONE_REQUIRED_PAGE_ALIGNMENT-1)
+#define PAGES_FOR_64MB (64*1024*1024/PAGE_SIZE)
+
 static unsigned long __init find_max_low_pfn(void)
 {
 	unsigned long max_low_pfn;
 
 	max_low_pfn = max_pfn;
+
 	if (max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
 			highmem_pages = max_pfn - MAXMEM_PFN;
 		if (highmem_pages + MAXMEM_PFN < max_pfn)
 			max_pfn = MAXMEM_PFN + highmem_pages;
 		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
-			highmem_pages = 0;
+			printk("Warning reducing highmem=%luMB to: %luMB.\n",
+			       pages_to_mb(highmem_pages), pages_to_mb(max_pfn - MAXMEM_PFN));
+			highmem_pages = max_pfn - MAXMEM_PFN;
 		}
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-					MAXMEM>>20);
+		printk(KERN_WARNING "Warning only %ldMB will be used.\n",MAXMEM>>20);
 		if (max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
@@ -950,27 +959,53 @@
 		}
 #endif /* !CONFIG_X86_PAE */
 #endif /* !CONFIG_HIGHMEM */
-	} else {
-		if (highmem_pages == -1)
-			highmem_pages = 0;
+	} else if (highmem_pages == -1)
+		highmem_pages = 0;
 #if CONFIG_HIGHMEM
-		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
-			highmem_pages = 0;
-		}
-		if (highmem_pages) {
-			if (max_low_pfn-highmem_pages < 64*1024*1024/PAGE_SIZE){
-				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, ignoring it.\n", pages_to_mb(highmem_pages));
-				highmem_pages = 0;
-			}
-			max_low_pfn -= highmem_pages;
-		}
+	if (!highmem_pages)
+		goto out;
+	if (max_pfn < PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT * 2) {
+		printk(KERN_ERR
+		       "Error highmem support requires at least %uMB but only %uMB are available.\n",
+		       pages_to_mb(PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT * 2),pages_to_mb(max_pfn));
+		highmem_pages = 0;
+		goto out;
+	}
+	if (highmem_pages > max_pfn) {
+		printk(KERN_WARNING
+		       "Warning highmem=%uMB is bigger than available %luMB and will be adjusted.\n",
+		       pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+	}
+	if (highmem_pages <= ZONE_REQUIRED_PAGE_ALIGNMENT) {
+		printk(KERN_WARNING
+		       "Warning highmem=%uMB is too small and has been adjusted to: %uMB.\n",
+		       pages_to_mb(highmem_pages),pages_to_mb(ZONE_REQUIRED_PAGE_ALIGNMENT * 2));
+		highmem_pages = ZONE_REQUIRED_PAGE_ALIGNMENT * 2;
+	}
+	if (max_low_pfn < highmem_pages || max_low_pfn-highmem_pages < PAGES_FOR_64MB){
+		highmem_pages = max_low_pfn - PAGES_FOR_64MB;
+		printk(KERN_WARNING
+		       "Warning highmem size adjusted for a minimum of 64MB lowmem to: %uMB.\n",
+		       pages_to_mb(highmem_pages));
+	}
+	max_low_pfn -= highmem_pages;
+	if (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) {
+		printk("Warning bad highmem zone alignment 0x%lx, highmem size will be adjusted.\n",(max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) << PAGE_SHIFT);
+		highmem_pages -= ZONE_REQUIRED_PAGE_ALIGNMENT - (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK);
+		max_low_pfn &= ~ZONE_REQUIRED_PAGE_ALIGNMENT_MASK;
+		max_low_pfn += ZONE_REQUIRED_PAGE_ALIGNMENT;
+		printk(KERN_WARNING
+		       "Warning lowmem size adjusted  for zone alignment to: %uMB.\n",
+		       pages_to_mb(max_low_pfn));
+		printk(KERN_WARNING
+		       "Warning highmem size adjusted for zone alignment to: %uMB.\n",
+		       pages_to_mb(highmem_pages));
+	}
 #else
-		if (highmem_pages)
-			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
+	if (highmem_pages)
+		printk(KERN_ERR "Error highmem size on non-highmem kernel ignored\n");
 #endif
-	}
-
+out:
 	return max_low_pfn;
 }
 
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.25-rc1-Vanilla/Documentation/kernel-parameters.txt linux-2.4.25-rc1-mhf176/Documentation/kernel-parameters.txt
--- linux-2.4.25-rc1-Vanilla/Documentation/kernel-parameters.txt	2004-02-06 17:06:14.000000000 +0800
+++ linux-2.4.25-rc1-mhf176/Documentation/kernel-parameters.txt	2004-02-07 19:10:39.000000000 +0800
@@ -241,6 +241,12 @@
 
 	hfmodem=	[HW,AX25]
 
+	highmem=size[KMG]	[IA32,KNL,BOOT] forces highmem to be at most 'size' bytes.
+	This works even on boxes with at least 68MB RAM that have no highmem
+	otherwise. This also works to reduce highmem size on bigger boxes. 
+	Note: highmem is adjusted downward for proper zone alignment of the
+	highmem physical start address
+
 	hisax=		[HW,ISDN]
 
 	i810=		[HW,DRM]

