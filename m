Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLDKtt>; Mon, 4 Dec 2000 05:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQLDKtk>; Mon, 4 Dec 2000 05:49:40 -0500
Received: from [62.172.234.2] ([62.172.234.2]:45523 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129319AbQLDKtT>;
	Mon, 4 Dec 2000 05:49:19 -0500
Date: Mon, 4 Dec 2000 10:20:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12-pre4] microcode update for Pentium 4.
Message-ID: <Pine.LNX.4.21.0012041017020.1209-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch adds support for the latest member of Intel IA32 family -- the
Pentium 4 processor. Tested under 2.4.0-test12-pre4 -- still works.

Regards,
Tigran

diff -urN -X dontdiff linux/CREDITS ucode/CREDITS
--- linux/CREDITS	Mon Dec  4 08:43:33 2000
+++ ucode/CREDITS	Mon Dec  4 08:56:34 2000
@@ -41,7 +41,7 @@
 E: tigran@veritas.com
 W: http://www.ocston.org/~tigran
 D: BFS filesystem
-D: Intel P6 CPU microcode update support
+D: Intel IA32 CPU microcode update support
 D: Various kernel patches
 S: United Kingdom
 
diff -urN -X dontdiff linux/Documentation/Changes ucode/Documentation/Changes
--- linux/Documentation/Changes	Thu Oct 26 21:49:15 2000
+++ ucode/Documentation/Changes	Mon Dec  4 08:56:34 2000
@@ -185,10 +185,10 @@
 kernel source.  Pay attention when you recompile your kernel ;-).
 Also, be sure to upgrade to the latest pcmcia-cs release.
 
-Intel P6 microcode
-------------------
+Intel IA32 microcode
+--------------------
 
-A driver has been added to allow updating of Intel P6 microcode,
+A driver has been added to allow updating of Intel IA32 microcode,
 accessible as both a devfs regular file and as a normal (misc)
 character device.  If you are not using devfs you may need to:
 
@@ -198,6 +198,13 @@
 
 as root before you can use this.  You'll probably also want to
 get the user-space microcode_ctl utility to use with this.
+
+If you have compiled the driver as a module you may need to add
+the following line:
+
+alias char-major-10-184 microcode
+
+to your /etc/modules.conf file.
 
 Networking
 ==========
diff -urN -X dontdiff linux/Documentation/Configure.help ucode/Documentation/Configure.help
--- linux/Documentation/Configure.help	Mon Dec  4 08:43:33 2000
+++ ucode/Documentation/Configure.help	Mon Dec  4 08:56:34 2000
@@ -13427,13 +13427,13 @@
   Toshiba Linux utilities website at:
   http://www.buzzard.org.uk/toshiba/
 
-/dev/cpu/microcode - Intel P6 CPU microcode support
+/dev/cpu/microcode - Intel IA32 CPU microcode support
 CONFIG_MICROCODE
   If you say Y here and also to "/dev file system support" in the
   'File systems' section, you will be able to update the microcode on
-  Intel processors in the P6 family, e.g. Pentium Pro, Pentium II,
-  Pentium III, Xeon etc. You will obviously need the actual microcode
-  binary data itself which is not shipped with the Linux kernel.
+  Intel processors in the IA32 family, e.g. Pentium Pro, Pentium II,
+  Pentium III, Pentium 4, Xeon etc. You will obviously need the actual 
+  microcode binary data itself which is not shipped with the Linux kernel.
 
   For latest news and information on obtaining all the required
   ingredients for this driver, check:
@@ -13442,7 +13442,9 @@
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called microcode.o. If you want to compile it as
-  a module, say M here and read Documentation/modules.txt.
+  a module, say M here and read Documentation/modules.txt. If you use
+  modprobe or kmod you may also want to add the line
+  'alias char-major-10-184 microcode' to your /etc/modules.conf file.
 
 /dev/cpu/*/msr - Model-specific register support
 CONFIG_X86_MSR
diff -urN -X dontdiff linux/Documentation/ioctl-number.txt ucode/Documentation/ioctl-number.txt
--- linux/Documentation/ioctl-number.txt	Mon Jun 19 20:56:07 2000
+++ ucode/Documentation/ioctl-number.txt	Mon Dec  4 08:56:34 2000
@@ -74,8 +74,8 @@
 0x22	all	scsi/sg.h
 '1'	00-1F	<linux/timepps.h>	PPS kit from Ulrich Windl
 					<ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
-'6'	00-10	<asm-i386/processor.h>	Intel P6 microcode update driver
-					<tigran@veritas.com>
+'6'	00-10	<asm-i386/processor.h>	Intel IA32 microcode update driver
+					<mailto:tigran@veritas.com>
 '8'	all				SNP8023 advanced NIC card
 					<mailto:mcr@solidum.com>
 'A'	00-1F	linux/apm_bios.h
diff -urN -X dontdiff linux/MAINTAINERS ucode/MAINTAINERS
--- linux/MAINTAINERS	Mon Dec  4 08:43:33 2000
+++ ucode/MAINTAINERS	Mon Dec  4 08:56:34 2000
@@ -633,7 +633,7 @@
 W:	http://sourceforge.net/projects/gkernel/
 S:	Maintained
 
-INTEL P6 MICROCODE UPDATE SUPPORT
+INTEL IA32 MICROCODE UPDATE SUPPORT
 P:	Tigran Aivazian
 M:	tigran@veritas.com
 S:	Maintained
diff -urN -X dontdiff linux/arch/i386/kernel/microcode.c ucode/arch/i386/kernel/microcode.c
--- linux/arch/i386/kernel/microcode.c	Mon Oct 30 22:44:29 2000
+++ ucode/arch/i386/kernel/microcode.c	Mon Dec  4 09:01:00 2000
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
+ *	1.08	04 Dec 2000, Richard Schaal <richard.schaal@intel.com> and
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
@@ -81,6 +92,7 @@
 static char *mc_applied;            /* array of applied microcode blocks */
 static unsigned int mc_fsize;       /* file size of /dev/cpu/microcode */
 
+/* we share file_operations between misc and devfs mechanisms */
 static struct file_operations microcode_fops = {
 	owner:		THIS_MODULE,
 	read:		microcode_read,
@@ -99,23 +111,27 @@
 
 static int __init microcode_init(void)
 {
-	int error = 0;
+	int error;
 
-	if (misc_register(&microcode_dev) < 0) {
+	error = misc_register(&microcode_dev);
+	if (error)
 		printk(KERN_WARNING 
 			"microcode: can't misc_register on minor=%d\n",
 			MICROCODE_MINOR);
-		error = 1;
-	}
+
 	devfs_handle = devfs_register(NULL, "cpu/microcode",
 			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR, 
 			&microcode_fops, NULL);
 	if (devfs_handle == NULL && error) {
 		printk(KERN_ERR "microcode: failed to devfs_register()\n");
-		return -EINVAL;
+		goto out;
 	}
-	printk(KERN_INFO "P6 Microcode Update Driver v%s\n", MICROCODE_VERSION);
-	return 0;
+	printk(KERN_INFO 
+		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
+		MICROCODE_VERSION);
+
+out:
+	return error;
 }
 
 static void __exit microcode_exit(void)
@@ -124,12 +140,12 @@
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
@@ -175,18 +191,19 @@
 	unsigned int pf = 0, val[2], rev, sig;
 	int i,found=0;
 
-	req->err = 1; /* assume the worst */
+	req->err = 1; /* assume update failed on this cpu */
 
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
+	if ((c->x86_model >= 5) || (c->x86 > 6)) {
+		/* get processor flags from MSR 0x17 */
+		rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 		pf = 1 << ((val[1] >> 18) & 7);
 	}
 
@@ -195,9 +212,28 @@
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
+			wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 			__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
-			rdmsr(0x8B, val[0], rev);
+
+			/* get current (on-cpu) revision into rev (ignore val[0]) */
+			rdmsr(MSR_IA32_UCODE_REV, val[0], rev);
 			if (microcode[i].rev < rev) {
 				printk(KERN_ERR 
 					"microcode: CPU%d not 'upgrading' to earlier revision"
@@ -219,12 +255,19 @@
 					break;
 				}
 
-				wrmsr(0x79, (unsigned int)(m->bits), 0);
+				/* write microcode via MSR 0x79 */
+				wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(m->bits), 0);
+
+				/* serialize */
 				__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
-				rdmsr(0x8B, val[0], val[1]);
 
+				/* get the current revision from MSR 0x8B */
+				rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
+
+				/* notify the caller of success on this cpu */
 				req->err = 0;
 				req->slot = i;
+
 				printk(KERN_ERR "microcode: CPU%d updated from revision "
 						"%d to %d, date=%08x\n", 
 						cpu_num, rev, val[1], m->date);
@@ -267,8 +310,8 @@
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
+++ ucode/include/asm-i386/msr.h	Mon Dec  4 08:56:34 2000
@@ -30,3 +30,7 @@
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
 
+/* symbolic names for some interesting MSRs */
+#define MSR_IA32_PLATFORM_ID	0x17
+#define MSR_IA32_UCODE_WRITE	0x79
+#define MSR_IA32_UCODE_REV	0x8B
diff -urN -X dontdiff linux/include/asm-i386/processor.h ucode/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Sun Nov 19 04:56:59 2000
+++ ucode/include/asm-i386/processor.h	Mon Dec  4 09:02:59 2000
@@ -464,7 +464,8 @@
 	unsigned int bits[500];
 };
 
-#define MICROCODE_IOCFREE	_IO('6',0) /* because it is for P6 */
+/* '6' because it used to be for P6 only (but now covers P4 as well) */
+#define MICROCODE_IOCFREE	_IO('6',0)
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 extern inline void rep_nop(void)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
