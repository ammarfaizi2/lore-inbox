Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbQLGRa6>; Thu, 7 Dec 2000 12:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQLGRas>; Thu, 7 Dec 2000 12:30:48 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:63494 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130607AbQLGRa3>;
	Thu, 7 Dec 2000 12:30:29 -0500
Date: Thu, 7 Dec 2000 17:01:45 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.2.18-pre24] microcode driver fixes
Message-ID: <Pine.LNX.4.21.0012071658400.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I have looked at the state of microcode driver in 2.2.18-pre24 and found
that it needs a lot of changes -- a bugfix for the case when
BIOS did not update, fix to work correctly on Pentium 4 and lots of
cleanups which are in 2.4 but not in 2.2.

Tested under 2.2.18-pre24. Please consider applying this patch.

Regards,
Tigran

diff -urN -X dontdiff linux/CREDITS ucode-2.2/CREDITS
--- linux/CREDITS	Thu Dec  7 14:27:51 2000
+++ ucode-2.2/CREDITS	Thu Dec  7 14:53:22 2000
@@ -23,6 +23,12 @@
 S: University of Limerick
 S: Ireland
 
+N: Tigran Aivazian
+E: tigran@veritas.com
+W: http://www.moses.uklinux.net/patches
+D: Intel IA32 microcode update driver
+S: United Kingdom
+
 N: Werner Almesberger
 E: werner.almesberger@lrc.di.epfl.ch
 D: dosfs, LILO, some fd features, various other hacks here and there
diff -urN -X dontdiff linux/Documentation/Changes ucode-2.2/Documentation/Changes
--- linux/Documentation/Changes	Thu Dec  7 14:27:51 2000
+++ ucode-2.2/Documentation/Changes	Thu Dec  7 14:56:37 2000
@@ -517,6 +517,28 @@
 Older isdn4k-utils versions don't support EXTRAVERSION into kernel version
 string. A upgrade to isdn4k-utils.v3.1beta7 or later is recomented.
 
+Intel IA32 microcode
+====================
+
+A driver has been added to allow updating of Intel IA32 microcode,
+accessible as both a devfs regular file and as a normal (misc)
+character device.  If you are not using devfs you may need to:
+
+mkdir /dev/cpu
+mknod /dev/cpu/microcode c 10 184
+chmod 0644 /dev/cpu/microcode
+
+as root before you can use this.  You'll probably also want to
+get the user-space microcode_ctl utility to use with this.
+
+If you have compiled the driver as a module you may need to add
+the following line:
+
+alias char-major-10-184 microcode
+
+to your /etc/modules.conf file.
+
+
 Where to get the files
 **********************
 
diff -urN -X dontdiff linux/Documentation/Configure.help ucode-2.2/Documentation/Configure.help
--- linux/Documentation/Configure.help	Thu Dec  7 14:27:51 2000
+++ ucode-2.2/Documentation/Configure.help	Thu Dec  7 14:58:04 2000
@@ -10408,12 +10408,12 @@
  it as a module.  The module will be called sbc60xxwdt.o.
 
 CONFIG_MICROCODE
-  /dev/cpu/microcode - Intel P6 CPU microcode support
+  /dev/cpu/microcode - Intel IA32 CPU microcode support
 
   If you say Y here you will be able to update the microcode on
-  Intel processors in the P6 family, e.g. Pentium Pro, Pentium II,
-  Pentium III, Xeon etc. You will obviously need the actual microcode
-  binary data itself which is not shipped with the Linux kernel.
+  Intel processors in the IA32 family, e.g. Pentium Pro, Pentium II,
+  Pentium III, Xeon, Pentium 4 etc. You will obviously need the actual
+  microcode binary data itself which is not shipped with the Linux kernel.
  
   For latest news and information on obtaining all the required
   ingredients for this driver, check:
@@ -10422,7 +10422,9 @@
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called microcode.o. If you want to compile it as
-  a module, say M here and read Documentation/modules.txt.
+  a module, say M here and read Documentation/modules.txt. If you use
+  modprobe or kmod you may also want to add the line
+  'alias char-major-10-184 microcode' to your /etc/modules.conf file.
 
 /dev/cpu/*/msr - Model-specific register support
 CONFIG_X86_MSR
diff -urN -X dontdiff linux/Documentation/ioctl-number.txt ucode-2.2/Documentation/ioctl-number.txt
--- linux/Documentation/ioctl-number.txt	Thu Dec  7 14:27:51 2000
+++ ucode-2.2/Documentation/ioctl-number.txt	Thu Dec  7 14:58:51 2000
@@ -113,6 +113,8 @@
 					<mailto:hdstich@connectu.ulm.circular.de>
 'z'	40-7F	CAN bas card		in development:
 					<mailto:oe@port.de>
+'6'	00-10	<asm-i386/processor.h>	Intel IA32 microcode update driver
+					<mailto:tigran@veritas.com>
 0x89	00-0F	asm-i386/sockios.h
 0x89	10-DF	linux/sockios.h
 0x89	E0-EF	linux/sockios.h		SIOCPROTOPRIVATE range
diff -urN -X dontdiff linux/MAINTAINERS ucode-2.2/MAINTAINERS
--- linux/MAINTAINERS	Thu Dec  7 14:27:51 2000
+++ ucode-2.2/MAINTAINERS	Thu Dec  7 14:55:03 2000
@@ -493,6 +493,13 @@
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+INTEL IA32 MICROCODE UPDATE DRIVER
+P:	Tigran Aivazian
+M:	Tigran Aivazian <tigran@veritas.com>
+W:      http://www.urbanmyth.org/microcode
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 IP FIREWALL
 P:	Paul Russell
 M:	Paul.Russell@rustcorp.com.au
diff -urN -X dontdiff linux/arch/i386/config.in ucode-2.2/arch/i386/config.in
--- linux/arch/i386/config.in	Thu Dec  7 14:27:52 2000
+++ ucode-2.2/arch/i386/config.in	Thu Dec  7 14:59:17 2000
@@ -33,7 +33,7 @@
   define_bool CONFIG_X86_GOOD_APIC y
 fi
 
-tristate '/dev/cpu/microcode - Intel P6 CPU microcode support' CONFIG_MICROCODE
+tristate '/dev/cpu/microcode - Intel IA32 CPU microcode support' CONFIG_MICROCODE
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
diff -urN -X dontdiff linux/arch/i386/kernel/microcode.c ucode-2.2/arch/i386/kernel/microcode.c
--- linux/arch/i386/kernel/microcode.c	Thu Dec  7 14:27:52 2000
+++ ucode-2.2/arch/i386/kernel/microcode.c	Thu Dec  7 15:48:50 2000
@@ -4,12 +4,13 @@
  *	Copyright (C) 2000 Tigran Aivazian
  *
  *	This driver allows to upgrade microcode on Intel processors
- *	belonging to P6 family - PentiumPro, Pentium II, Pentium III etc.
+ *	belonging to IA32 family - PentiumPro, Pentium II, Pentium III,
+ *	Pentium II Xeon, Pentium III Xeon, Pentium 4 etc.
  *
- *	Reference: Section 8.10 of Volume III, Intel Pentium III Manual, 
- *	Order Number 243192 or download from:
+ *	Reference: Section 8.10 of Volume III, Intel Pentium 4 Manual, 
+ *	Order Number 245472 or free download from:
  *		
- *	http://developer.intel.com/design/pentiumii/manuals/243192.htm
+ *	http://developer.intel.com/design/pentium4/manuals/245472.htm
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -30,6 +31,8 @@
  *		Added MICROCODE_IOCFREE ioctl to clear memory.
  *	1.05	09 June 2000, Simon Trimmer <simon@veritas.com>
  *		Messages for error cases (non intel & no suitable microcode).
+ *	1.06	07 Dec 2000, Tigran Aivazian <tigran@veritas.com>
+ *		Pentium 4 support + backported fixes from 2.4
  */
 
 #include <linux/init.h>
@@ -37,7 +40,6 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
-#include <linux/smp_lock.h>
 #include <linux/miscdevice.h>
 #include <linux/smp.h>
 
@@ -45,45 +47,25 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#define MICROCODE_MINOR 184
-#define MICROCODE_IOCFREE _IO('6',0)
-struct microcode {
-	unsigned int hdrver;
-	unsigned int rev;
-	unsigned int date;
-	unsigned int sig;
-	unsigned int cksum;
-	unsigned int ldrver;
-	unsigned int pf;
-	unsigned int reserved[5];
-	unsigned int bits[500];
-};
-
-#define MICROCODE_VERSION 	"1.05"
+#define MICROCODE_VERSION 	"1.06"
 
-MODULE_DESCRIPTION("Intel CPU (P6) microcode update driver");
+MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
 EXPORT_NO_SYMBOLS;
 
 /* VFS interface */
 static int microcode_open(struct inode *, struct file *);
-static int microcode_release(struct inode *, struct file *);
 static ssize_t microcode_read(struct file *, char *, size_t, loff_t *);
 static ssize_t microcode_write(struct file *, const char *, size_t, loff_t *);
 static int microcode_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 
+/* read()/write()/ioctl() are serialized on this */
+static struct semaphore microcode_sem = MUTEX;
 
 /* internal helpers to do the work */
 static int do_microcode_update(void);
 static void do_update_one(void *);
 
-/*
- *  Bits in microcode_status. (31 bits of room for future expansion)
- */
-#define MICROCODE_IS_OPEN	0	/* set if device is in use */
-
-static unsigned long microcode_status;
-
 /* the actual array of microcode blocks, each 2048 bytes */
 static struct microcode *microcode;
 static unsigned int microcode_num;
@@ -95,7 +77,6 @@
 	write:		microcode_write,
 	ioctl:		microcode_ioctl,
 	open:		microcode_open,
-	release:	microcode_release,
 };
 
 static struct miscdevice microcode_dev = {
@@ -114,18 +95,18 @@
 			MICROCODE_MINOR);
 		error = 1;
 	}
-	printk(KERN_INFO "P6 Microcode Update Driver v%s registered\n", 
+	printk(KERN_INFO "IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 			MICROCODE_VERSION);
 	return 0;
 }
 
 #ifdef MODULE
-static void microcode_exit(void)
+void cleanup_module(void)
 {
 	misc_deregister(&microcode_dev);
 	if (mc_applied)
 		kfree(mc_applied);
-	printk(KERN_INFO "P6 Microcode Update Driver v%s unregistered\n", 
+	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
 			MICROCODE_VERSION);
 }
 
@@ -133,34 +114,14 @@
 {
 	return microcode_init();
 }
-void cleanup_module(void)
-{
-	microcode_exit();
-}
 #endif
 
-/*
- * We enforce only one user at a time here with open/close.
- */
 static int microcode_open(struct inode *inode, struct file *file)
 {
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
-
-	/* one at a time, please */
-	if (test_and_set_bit(MICROCODE_IS_OPEN, &microcode_status))
-		return -EBUSY;
-
-	return 0;
-}
-
-static int microcode_release(struct inode *inode, struct file *file)
-{
-	clear_bit(MICROCODE_IS_OPEN, &microcode_status);
-	return 0;
+	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-/* a pointer to 'struct update_req' is passed to the IPI handler = do_update_one()
+/*
  * update_req[cpu].err is set to 1 if update failed on 'cpu', 0 otherwise
  * if err==0, microcode[update_req[cpu].slot] points to applied block of microcode
  */
@@ -174,10 +135,10 @@
 	int i, error = 0, err;
 	struct microcode *m;
 
-	if (smp_call_function(do_update_one, (void *)update_req, 1, 1) != 0)
+	if (smp_call_function(do_update_one, NULL, 1, 1) != 0)
 		panic("do_microcode_update(): timed out waiting for other CPUs\n");
 
-	do_update_one((void *)update_req);
+	do_update_one(NULL);
 
 	for (i=0; i<smp_num_cpus; i++) {
 		err = update_req[i].err;
@@ -194,22 +155,23 @@
 {
 	int cpu_num = smp_processor_id();
 	struct cpuinfo_x86 *c = cpu_data + cpu_num;
-	struct update_req *req = (struct update_req *)arg + cpu_num;
+	struct update_req *req = update_req + cpu_num;
 	unsigned int pf = 0, val[2], rev, sig;
 	int i,found=0;
 
 	req->err = 1; /* be pessimistic */
 
-	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6){
-		printk(KERN_ERR "microcode: CPU%d not an Intel P6\n", cpu_num );
+	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
+		test_bit(X86_FEATURE_30, &c->x86_capability)) { /* IA64 */
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
 
@@ -219,7 +181,12 @@
 
 			found=1;
 
-			rdmsr(0x8B, val[0], rev);
+			/* trick, to work even if there was no prior update by the BIOS */
+			wrmsr(MSR_IA32_UCODE_REV, 0, 0);
+			__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+
+			/* get current (on-cpu) revision into rev (ignore val[0]) */
+			rdmsr(MSR_IA32_UCODE_REV, val[0], rev);
 			if (microcode[i].rev < rev) {
 				printk(KERN_ERR 
 					"microcode: CPU%d not 'upgrading' to earlier revision"
@@ -241,10 +208,16 @@
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
 				printk(KERN_ERR "microcode: CPU%d updated from revision "
@@ -255,18 +228,23 @@
 		}
 
 	if(!found)
-		printk(KERN_ERR "microcode: found no data for CPU%d (sig=%x, pflags=%d)\n", cpu_num, sig, pf);
+		printk(KERN_ERR "microcode: CPU%d no microcode found! (sig=%x, pflags=%d)\n",
+				cpu_num, sig, pf);
 }
 
 static ssize_t microcode_read(struct file *file, char *buf, size_t len, loff_t *ppos)
 {
 	if (*ppos >= mc_fsize)
 		return 0;
+	down(&microcode_sem);
 	if (*ppos + len > mc_fsize)
 		len = mc_fsize - *ppos;
-	if (copy_to_user(buf, mc_applied + *ppos, len))
+	if (copy_to_user(buf, mc_applied + *ppos, len)) {
+		up(&microcode_sem);
 		return -EFAULT;
+	}
 	*ppos += len;
+	up(&microcode_sem);
 	return len;
 }
 
@@ -279,17 +257,18 @@
 			sizeof(struct microcode));
 		return -EINVAL;
 	}
+	down(&microcode_sem);
 	if (!mc_applied) {
 		mc_applied = kmalloc(smp_num_cpus*sizeof(struct microcode),
 				GFP_KERNEL);
 		if (!mc_applied) {
+			up(&microcode_sem);
 			printk(KERN_ERR "microcode: out of memory for saved microcode\n");
 			return -ENOMEM;
 		}
 		memset(mc_applied, 0, mc_fsize);
 	}
 	
-	lock_kernel();
 	microcode_num = len/sizeof(struct microcode);
 	microcode = vmalloc(len);
 	if (!microcode) {
@@ -310,7 +289,7 @@
 out_fsize:
 	vfree(microcode);
 out_unlock:
-	unlock_kernel();
+	up(&microcode_sem);
 	return ret;
 }
 
@@ -319,6 +298,7 @@
 {
 	switch(cmd) {
 		case MICROCODE_IOCFREE:
+			down(&microcode_sem);
 			if (mc_applied) {
 				memset(mc_applied, 0, mc_fsize);
 				kfree(mc_applied);
@@ -326,8 +306,10 @@
 				printk(KERN_WARNING 
 					"microcode: freed %d bytes\n", mc_fsize);
 				mc_fsize = 0;
+				up(&microcode_sem);
 				return 0;
 			}
+			up(&microcode_sem);
 			return -ENODATA;
 
 		default:
diff -urN -X dontdiff linux/include/asm-i386/msr.h ucode-2.2/include/asm-i386/msr.h
--- linux/include/asm-i386/msr.h	Thu Apr 29 19:53:41 1999
+++ ucode-2.2/include/asm-i386/msr.h	Thu Dec  7 15:18:21 2000
@@ -28,3 +28,7 @@
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
 
+/* symbolic names for some interesting MSRs */
+#define MSR_IA32_PLATFORM_ID	0x17
+#define MSR_IA32_UCODE_WRITE	0x79
+#define MSR_IA32_UCODE_REV	0x8B
diff -urN -X dontdiff linux/include/asm-i386/processor.h ucode-2.2/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Thu Dec  7 14:27:56 2000
+++ ucode-2.2/include/asm-i386/processor.h	Thu Dec  7 15:45:06 2000
@@ -327,6 +327,23 @@
 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
 
+/* '6' because it used to be for P6 only, now supports P15 too */
+#define MICROCODE_IOCFREE _IO('6',0)
+
+/* physical layour of IA32 microcode chunks */
+struct microcode {
+	unsigned int hdrver;
+	unsigned int rev;
+	unsigned int date;
+	unsigned int sig;
+	unsigned int cksum;
+	unsigned int ldrver;
+	unsigned int pf;
+	unsigned int reserved[5];
+	unsigned int bits[500];
+};
+
+
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 extern inline void rep_nop(void)
 {
diff -urN -X dontdiff linux/include/linux/miscdevice.h ucode-2.2/include/linux/miscdevice.h
--- linux/include/linux/miscdevice.h	Mon Aug  9 20:04:41 1999
+++ ucode-2.2/include/linux/miscdevice.h	Thu Dec  7 15:47:02 2000
@@ -17,6 +17,7 @@
 #define SUN_OPENPROM_MINOR 139
 #define NVRAM_MINOR 144
 #define I2O_MINOR 166
+#define MICROCODE_MINOR 184
 #define MISC_DYNAMIC_MINOR 255
 
 #define SGI_GRAPHICS_MINOR   146

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
