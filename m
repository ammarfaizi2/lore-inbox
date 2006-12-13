Return-Path: <linux-kernel-owner+w=401wt.eu-S1751202AbWLMVye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWLMVye (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWLMVye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:54:34 -0500
Received: from ms.trustica.cz ([82.208.32.68]:47150 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbWLMVyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:54:33 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 16:54:33 EST
Message-ID: <45807469.6040609@assembler.cz>
Date: Wed, 13 Dec 2006 22:45:13 +0100
From: Rudolf Marek <r.marek@assembler.cz>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: hpa@zytor.com, norsk5@xmission.com
CC: lkml <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       bluesmoke-devel@lists.sourceforge.net
Subject: [RFC] new MSR r/w functions per CPU
Content-Type: multipart/mixed;
 boundary="------------000601050702070101080303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000601050702070101080303
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

For my new coretemp driver[1], I need to execute the rdmsr on particular 
processor.  There is no such "global" function for that in the kernel so far.

The per CPU msr_read and msr_write are used in following drivers:

msr.c (it is static there now)
k8-edac.c  (duplicated right now -> driver in -mm)
coretemp.c (my new Core temperature sensor -> driver [1])

Question is how make an access to that functions. Enclosed patch does simple 
EXPORT_SYMBOL_GPL for them, but then both drivers (k8-edac.c and coretemp.c) 
would depend on the MSR driver. The ultimate solution would be to move this type
of function to separate module, but perhaps this is just bit overkill?

Any ideas what would be the best solution?

I would like to make sure that module refcounting is done in module.c, so I 
don't need to handle this in my patch.

Thanks,
Rudolf

Please CC me, I'm not on all lists.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018420.html

--------------000601050702070101080303
Content-Type: text/x-patch;
 name="merge-msr-funcs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="merge-msr-funcs.patch"

Index: linux-2.6.19-rc2/arch/i386/kernel/msr.c
===================================================================
--- linux-2.6.19-rc2.orig/arch/i386/kernel/msr.c	2006-10-17 23:10:39.470361250 +0200
+++ linux-2.6.19-rc2/arch/i386/kernel/msr.c	2006-10-17 23:15:54.470047500 +0200
@@ -90,7 +90,7 @@
 		cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
 }
 
-static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
+int msr_write(int cpu, u32 reg, u32 eax, u32 edx)
 {
 	struct msr_command cmd;
 	int ret;
@@ -111,7 +111,7 @@
 	return ret;
 }
 
-static inline int do_rdmsr(int cpu, u32 reg, u32 * eax, u32 * edx)
+int msr_read(int cpu, u32 reg, u32 * eax, u32 * edx)
 {
 	struct msr_command cmd;
 	int ret;
@@ -136,19 +136,22 @@
 
 #else				/* ! CONFIG_SMP */
 
-static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
+int msr_write(int cpu, u32 reg, u32 eax, u32 edx)
 {
 	return wrmsr_eio(reg, eax, edx);
 }
 
-static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
+int msr_read(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
 	return rdmsr_eio(reg, eax, edx);
 }
 
 #endif				/* ! CONFIG_SMP */
 
-static loff_t msr_seek(struct file *file, loff_t offset, int orig)
+EXPORT_SYMBOL_GPL(msr_write);
+EXPORT_SYMBOL_GPL(msr_read);
+
+static loff_t msr_fseek(struct file *file, loff_t offset, int orig)
 {
 	loff_t ret = -EINVAL;
 
@@ -166,7 +169,7 @@
 	return ret;
 }
 
-static ssize_t msr_read(struct file *file, char __user * buf,
+static ssize_t msr_fread(struct file *file, char __user * buf,
 			size_t count, loff_t * ppos)
 {
 	u32 __user *tmp = (u32 __user *) buf;
@@ -179,7 +182,7 @@
 		return -EINVAL;	/* Invalid chunk size */
 
 	for (; count; count -= 8) {
-		err = do_rdmsr(cpu, reg, &data[0], &data[1]);
+		err = msr_read(cpu, reg, &data[0], &data[1]);
 		if (err)
 			return err;
 		if (copy_to_user(tmp, &data, 8))
@@ -190,7 +193,7 @@
 	return ((char __user *)tmp) - buf;
 }
 
-static ssize_t msr_write(struct file *file, const char __user *buf,
+static ssize_t msr_fwrite(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	const u32 __user *tmp = (const u32 __user *)buf;
@@ -206,7 +209,7 @@
 	for (rv = 0; count; count -= 8) {
 		if (copy_from_user(&data, tmp, 8))
 			return -EFAULT;
-		err = do_wrmsr(cpu, reg, data[0], data[1]);
+		err = msr_write(cpu, reg, data[0], data[1]);
 		if (err)
 			return err;
 		tmp += 2;
@@ -215,7 +218,7 @@
 	return ((char __user *)tmp) - buf;
 }
 
-static int msr_open(struct inode *inode, struct file *file)
+static int msr_fopen(struct inode *inode, struct file *file)
 {
 	unsigned int cpu = iminor(file->f_dentry->d_inode);
 	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
@@ -233,10 +236,10 @@
  */
 static struct file_operations msr_fops = {
 	.owner = THIS_MODULE,
-	.llseek = msr_seek,
-	.read = msr_read,
-	.write = msr_write,
-	.open = msr_open,
+	.llseek = msr_fseek,
+	.read = msr_fread,
+	.write = msr_fwrite,
+	.open = msr_fopen,
 };
 
 static int msr_class_device_create(int i)
Index: linux-2.6.19-rc2/include/asm-i386/msr.h
===================================================================
--- linux-2.6.19-rc2.orig/include/asm-i386/msr.h	2006-10-17 23:10:39.446359750 +0200
+++ linux-2.6.19-rc2/include/asm-i386/msr.h	2006-10-17 23:10:52.211157500 +0200
@@ -78,6 +78,9 @@
 			  : "=a" (low), "=d" (high) \
 			  : "c" (counter))
 
+int msr_write(int cpu, u32 reg, u32 eax, u32 edx);
+int msr_read(int cpu, u32 reg, u32 *eax, u32 *edx);
+
 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
 #define MSR_IA32_P5_MC_ADDR		0
Index: linux-2.6.19-rc2/include/asm-x86_64/msr.h
===================================================================
--- linux-2.6.19-rc2.orig/include/asm-x86_64/msr.h	2006-10-17 23:10:39.382355750 +0200
+++ linux-2.6.19-rc2/include/asm-x86_64/msr.h	2006-10-17 23:18:29.347726750 +0200
@@ -160,7 +160,8 @@
 #define MSR_IA32_UCODE_WRITE		0x79
 #define MSR_IA32_UCODE_REV		0x8b
 
-
+int msr_write(int cpu, u32 reg, u32 eax, u32 edx);
+int msr_read(int cpu, u32 reg, u32 *eax, u32 *edx);
 #endif
 
 /* AMD/K8 specific MSRs */ 

--------------000601050702070101080303--
