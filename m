Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBOTIk>; Sat, 15 Feb 2003 14:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbTBOTIk>; Sat, 15 Feb 2003 14:08:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264936AbTBOTIi>; Sat, 15 Feb 2003 14:08:38 -0500
Subject: PATCH: Add printk levels to mtrr, also clarify
To: davej@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:18:46 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7pm-0007HV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big thing here is actually turning 
'Your bios sucks'
into
'Your bios sucks, but we fixed it and life is good, don't panic'

Which with a vendor hat on is important. Its currently hard to tell whether
some Linux errors are things to worry about or merely spanking the
manufacturer. I'd urge people writing error messages to think about that btw
- does it tell the user if the problem is fixed ?

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/cpu/mtrr/generic.c linux-2.5.61-ac1/arch/i386/kernel/cpu/mtrr/generic.c
--- linux-2.5.61/arch/i386/kernel/cpu/mtrr/generic.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.61-ac1/arch/i386/kernel/cpu/mtrr/generic.c	2003-02-14 23:06:20.000000000 +0000
@@ -83,15 +83,13 @@
 	if (!mask)
 		return;
 	if (mask & MTRR_CHANGE_MASK_FIXED)
-		printk
-		    ("mtrr: your CPUs had inconsistent fixed MTRR settings\n");
+		printk(KERN_WARNING "mtrr: your CPUs had inconsistent fixed MTRR settings\n");
 	if (mask & MTRR_CHANGE_MASK_VARIABLE)
-		printk
-		    ("mtrr: your CPUs had inconsistent variable MTRR settings\n");
+		printk(KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR settings\n");
 	if (mask & MTRR_CHANGE_MASK_DEFTYPE)
-		printk
-		    ("mtrr: your CPUs had inconsistent MTRRdefType settings\n");
-	printk("mtrr: probably your BIOS does not setup all CPUs\n");
+		printk(KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType settings\n");
+	printk(KERN_INFO "mtrr: probably your BIOS does not setup all CPUs.\n");
+	printk(KERN_INFO "mtrr: corrected configuration.\n");
 }
 
 
@@ -338,23 +336,19 @@
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_mask <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
-			printk(KERN_WARNING
-			       "mtrr: base(0x%lx000) is not 4 MiB aligned\n",
-			       base);
+			printk(KERN_WARNING "mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);
 			return -EINVAL;
 		}
 		if (!(base + size < 0x70000000 || base > 0x7003FFFF) &&
 		    (type == MTRR_TYPE_WRCOMB
 		     || type == MTRR_TYPE_WRBACK)) {
-			printk(KERN_WARNING
-			       "mtrr: writable mtrr between 0x70000000 and 0x7003FFFF may hang the CPU.\n");
+			printk(KERN_WARNING "mtrr: writable mtrr between 0x70000000 and 0x7003FFFF may hang the CPU.\n");
 			return -EINVAL;
 		}
 	}
 
 	if (base + size < 0x100) {
-		printk(KERN_WARNING
-		       "mtrr: cannot set region below 1 MiB (0x%lx000,0x%lx000)\n",
+		printk(KERN_WARNING "mtrr: cannot set region below 1 MiB (0x%lx000,0x%lx000)\n",
 		       base, size);
 		return -EINVAL;
 	}
@@ -364,8 +358,7 @@
 	for (lbase = base; !(lbase & 1) && (last & 1);
 	     lbase = lbase >> 1, last = last >> 1) ;
 	if (lbase != last) {
-		printk(KERN_WARNING
-		       "mtrr: base(0x%lx000) is not aligned on a size(0x%lx000) boundary\n",
+		printk(KERN_WARNING "mtrr: base(0x%lx000) is not aligned on a size(0x%lx000) boundary\n",
 		       base, size);
 		return -EINVAL;
 	}
