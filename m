Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAMVm>; Fri, 1 Dec 2000 07:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAMVc>; Fri, 1 Dec 2000 07:21:32 -0500
Received: from [62.172.234.2] ([62.172.234.2]:65078 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129183AbQLAMVW>;
	Fri, 1 Dec 2000 07:21:22 -0500
Date: Fri, 1 Dec 2000 11:51:35 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
Message-ID: <Pine.LNX.4.21.0012011150490.877-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt -- the first one got lost due to some local mail client
problems...

---------- Forwarded message ----------
Date: Fri, 1 Dec 2000 11:43:10 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12-pre3] microcode update for P4

Hi Linus,

Here is the patch to microcode update driver to support the new P4
CPU.

Regards,
Tigran

diff -urN -X dontdiff linux/arch/i386/kernel/microcode.c ucode/arch/i386/kernel/microcode.c
--- linux/arch/i386/kernel/microcode.c	Mon Oct 30 22:44:29 2000
+++ ucode/arch/i386/kernel/microcode.c	Fri Dec  1 09:45:47 2000
@@ -4,13 +4,13 @@
  *	Copyright (C) 2000 Tigran Aivazian
  *
  *	This driver allows to upgrade microcode on Intel processors
- *	belonging to P6 family - PentiumPro, Pentium II, 
- *	Pentium III, Xeon etc.
+ *	belonging to IA-32 family - PentiumPro, Pentium II, 
+ *	Pentium III, Xeon, Pentium 4, etc.
  *
- *	Reference: Section 8.10 of Volume III, Intel Pentium III Manual, 
- *	Order Number 243192 or free download from:
+ *	Reference: Section 8.10 of Volume III, Intel Pentium 4 Manual, 
+ *	Order Number 245472 or free download from:
  *		
- *	http://developer.intel.com/design/pentiumii/manuals/243192.htm
+ *	http://developer.intel.com/design/pentium4/manuals/245472.htm
  *
  *	For more information, go to http://www.urbanmyth.org/microcode
  *
@@ -44,6 +44,9 @@
  *		to be 0 on my machine which is why it worked even when I
  *		disabled update by the BIOS)
  *		Thanks to Eric W. Biederman <ebiederman@lnxi.com> for the fix.
+ *	1.08	01 Dec 2000, Richard Schaal <richard.schaal@intel.com> and
+ *			     Tigran Aivazian <tigran@veritas.com>
+ *		Intel P4 processor support.
  */
 
 #include <linux/init.h>
@@ -58,12 +61,20 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#define MICROCODE_VERSION 	"1.07"
+#define MICROCODE_VERSION 	"1.08"
 
-MODULE_DESCRIPTION("Intel CPU (P6) microcode update driver");
+MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 EXPORT_NO_SYMBOLS;
 
+#define MICRO_DEBUG 0
+
+#if MICRO_DEBUG
+#define Dprintk(x...) printk(##x)
+#else
+#define Dprintk(x...)
+#endif
+
 /* VFS interface */
 static int microcode_open(struct inode *, struct file *);
 static ssize_t microcode_read(struct file *, char *, size_t, loff_t *);
@@ -114,7 +125,10 @@
 		printk(KERN_ERR "microcode: failed to devfs_register()\n");
 		return -EINVAL;
 	}
-	printk(KERN_INFO "P6 Microcode Update Driver v%s\n", MICROCODE_VERSION);
+	printk(KERN_INFO 
+		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
+		MICROCODE_VERSION);
+
 	return 0;
 }
 
@@ -124,12 +138,12 @@
 	devfs_unregister(devfs_handle);
 	if (mc_applied)
 		kfree(mc_applied);
-	printk(KERN_INFO "P6 Microcode Update Driver v%s unregistered\n", 
+	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
 			MICROCODE_VERSION);
 }
 
-module_init(microcode_init);
-module_exit(microcode_exit);
+module_init(microcode_init)
+module_exit(microcode_exit)
 
 static int microcode_open(struct inode *unused1, struct file *unused2)
 {
@@ -177,16 +191,18 @@
 
 	req->err = 1; /* assume the worst */
 
-	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 != 6){
-		printk(KERN_ERR "microcode: CPU%d not an Intel P6\n", cpu_num);
+	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
+		test_bit(X86_FEATURE_IA64, &c->x86_capability)){
+		printk(KERN_ERR "microcode: CPU%d not a capable Intel processor\n", cpu_num);
 		return;
 	}
 
 	sig = c->x86_mask + (c->x86_model<<4) + (c->x86<<8);
 
-	if (c->x86_model >= 5) {
-		/* get processor flags from BBL_CR_OVRD MSR (0x17) */
-		rdmsr(0x17, val[0], val[1]);
+	if ((c->x86_model >= 5) || (c->x86 > 6))
+		{
+		/* get processor flags from MSR 0x17 */
+		rdmsr(IA32_PLATFORM_ID, val[0], val[1]);
 		pf = 1 << ((val[1] >> 18) & 7);
 	}
 
@@ -195,13 +211,32 @@
 		    microcode[i].ldrver == 1 && microcode[i].hdrver == 1) {
 
 			found=1;
-			wrmsr(0x8B, 0, 0);
+
+			Dprintk("Microcode\n");
+			Dprintk("   Header Revision %d\n",microcode[i].hdrver);
+			Dprintk("   Date %x/%x/%x\n",
+				((microcode[i].date >> 24 ) & 0xff),
+				((microcode[i].date >> 16 ) & 0xff),
+				(microcode[i].date & 0xFFFF));
+			Dprintk("   Type %x Family %x Model %x Stepping %x\n",
+				((microcode[i].sig >> 12) & 0x3),
+				((microcode[i].sig >> 8) & 0xf),
+				((microcode[i].sig >> 4) & 0xf),
+				((microcode[i].sig & 0xf)));
+			Dprintk("   Checksum %x\n",microcode[i].cksum);
+			Dprintk("   Loader Revision %x\n",microcode[i].ldrver);
+			Dprintk("   Processor Flags %x\n\n",microcode[i].pf);
+
+			/* trick, to work even if there was no prior update by the BIOS */
+			wrmsr(IA32_UCODE_REV, 0, 0);
 			__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
-			rdmsr(0x8B, val[0], rev);
+
+			/* get current (on-cpu) revision into rev (ignore val[0]) */
+			rdmsr(IA32_UCODE_REV, val[0], rev);
 			if (microcode[i].rev < rev) {
 				printk(KERN_ERR 
 					"microcode: CPU%d not 'upgrading' to earlier revision"
-					" %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
+					" %x (current=%x)\n", cpu_num, microcode[i].rev, rev);
 			} else if (microcode[i].rev == rev) {
 				printk(KERN_ERR
 					"microcode: CPU%d already up-to-date (revision %d)\n",
@@ -219,9 +254,14 @@
 					break;
 				}
 
-				wrmsr(0x79, (unsigned int)(m->bits), 0);
+				/* write microcode via MSR 0x79 */
+				wrmsr(IA32_UCODE_WRITE, (unsigned int)(m->bits), 0);
+
+				/* serialize */
 				__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
-				rdmsr(0x8B, val[0], val[1]);
+
+				/* get the current revision from MSR 0x8B */
+				rdmsr(IA32_UCODE_REV, val[0], val[1]);
 
 				req->err = 0;
 				req->slot = i;
@@ -267,8 +307,8 @@
 		mc_applied = kmalloc(smp_num_cpus*sizeof(struct microcode),
 				GFP_KERNEL);
 		if (!mc_applied) {
-			printk(KERN_ERR "microcode: out of memory for saved microcode\n");
 			up_write(&microcode_rwsem);
+			printk(KERN_ERR "microcode: out of memory for saved microcode\n");
 			return -ENOMEM;
 		}
 	}
diff -urN -X dontdiff linux/include/asm-i386/msr.h ucode/include/asm-i386/msr.h
--- linux/include/asm-i386/msr.h	Thu Oct  7 18:17:09 1999
+++ ucode/include/asm-i386/msr.h	Fri Dec  1 09:38:59 2000
@@ -30,3 +30,7 @@
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
 
+/* symbolic names for some interesting MSRs */
+#define IA32_PLATFORM_ID	0x17
+#define IA32_UCODE_WRITE	0x79
+#define IA32_UCODE_REV		0x8B


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
