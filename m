Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293121AbSB1RBX>; Thu, 28 Feb 2002 12:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293504AbSB1Q6d>; Thu, 28 Feb 2002 11:58:33 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:45134 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S293490AbSB1Q4d>;
	Thu, 28 Feb 2002 11:56:33 -0500
Date: Thu, 28 Feb 2002 17:00:28 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: <marcelo@conectiva.com.br>
cc: <asit.k.mallick@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [patch-2.4.18] serialize microcode updates
Message-ID: <Pine.LNX.4.33.0202281653410.1220-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Marcelo,

The attached patch is against 2.4.18 and serializes the microcode update
because it has to be done like that in certain cases and it does no harm
to do it in all cases.

Also, it avoids the silly message "upgrading from N to M" where M==N,
which was confusing enough to generate lots of email in my inbox :)
Because now only one update can happen at a time the above workaround is
no longer needed so it was removed.

Regards,
Tigran

--- linux-2.4.18/arch/i386/kernel/microcode.c	Tue Oct 30 23:13:17 2001
+++ linux-2.4.18-mc/arch/i386/kernel/microcode.c	Thu Feb 28 16:52:45 2002
@@ -51,6 +51,10 @@
  *		Bugfix for HT (Hyper-Threading) enabled processors
  *		whereby processor resources are shared by all logical processors
  *		in a single CPU package.
+ *	1.10	28 Feb 2001 Asit K Mallick <asit.k.mallick@intel.com> and
+ *		Tigran Aivazian <tigran@veritas.com>,
+ *		Serialize updates as required on HT processors due to speculative
+ *		nature of implementation.
  */

 #include <linux/init.h>
@@ -60,12 +64,16 @@
 #include <linux/vmalloc.h>
 #include <linux/miscdevice.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/spinlock.h>

 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>

-#define MICROCODE_VERSION 	"1.09"
+
+static spinlock_t microcode_update_lock = SPIN_LOCK_UNLOCKED;
+
+#define MICROCODE_VERSION 	"1.10"

 MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
@@ -195,7 +203,8 @@
 	struct cpuinfo_x86 *c = cpu_data + cpu_num;
 	struct update_req *req = update_req + cpu_num;
 	unsigned int pf = 0, val[2], rev, sig;
-	int i,found=0;
+	unsigned long flags;
+	int i;

 	req->err = 1; /* assume update will fail on this cpu */

@@ -216,8 +225,9 @@
 	for (i=0; i<microcode_num; i++)
 		if (microcode[i].sig == sig && microcode[i].pf == pf &&
 		    microcode[i].ldrver == 1 && microcode[i].hdrver == 1) {
-
-			found=1;
+			int sum = 0;
+			struct microcode *m = &microcode[i];
+			unsigned int *sump = (unsigned int *)(m+1);

 			printf("Microcode\n");
 			printf("   Header Revision %d\n",microcode[i].hdrver);
@@ -234,53 +244,68 @@
 			printf("   Loader Revision %x\n",microcode[i].ldrver);
 			printf("   Processor Flags %x\n\n",microcode[i].pf);

+			req->slot = i;
+
+			/* serialize access to update decision */
+			spin_lock_irqsave(&microcode_update_lock, flags);
+
 			/* trick, to work even if there was no prior update by the BIOS */
 			wrmsr(MSR_IA32_UCODE_REV, 0, 0);
 			__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");

 			/* get current (on-cpu) revision into rev (ignore val[0]) */
 			rdmsr(MSR_IA32_UCODE_REV, val[0], rev);
+
 			if (microcode[i].rev < rev) {
+				spin_unlock_irqrestore(&microcode_update_lock, flags);
 				printk(KERN_ERR
-					"microcode: CPU%d not 'upgrading' to earlier revision"
+				       "microcode: CPU%d not 'upgrading' to earlier revision"
+				       " %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
+				return;
+			} else if (microcode[i].rev == rev) {
+				/* notify the caller of success on this cpu */
+				req->err = 0;
+				spin_unlock_irqrestore(&microcode_update_lock, flags);
+				printk(KERN_ERR
+					"microcode: CPU%d already at revision"
 					" %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
-			} else {
-				int sum = 0;
-				struct microcode *m = &microcode[i];
-				unsigned int *sump = (unsigned int *)(m+1);
-
-				while (--sump >= (unsigned int *)m)
-					sum += *sump;
-				if (sum != 0) {
-					printk(KERN_ERR "microcode: CPU%d aborting, "
-							"bad checksum\n", cpu_num);
-					break;
-				}
-
-				/* write microcode via MSR 0x79 */
-				wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(m->bits), 0);
+				return;
+			}

-				/* serialize */
-				__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+			/* Verify the checksum */
+			while (--sump >= (unsigned int *)m)
+				sum += *sump;
+			if (sum != 0) {
+				req->err = 1;
+				spin_unlock_irqrestore(&microcode_update_lock, flags);
+				printk(KERN_ERR "microcode: CPU%d aborting, "
+				       "bad checksum\n", cpu_num);
+				return;
+			}
+
+			/* write microcode via MSR 0x79 */
+			wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(m->bits), 0);

-				/* get the current revision from MSR 0x8B */
-				rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
+			/* serialize */
+			__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");

-				/* notify the caller of success on this cpu */
-				req->err = 0;
-				req->slot = i;
+			/* get the current revision from MSR 0x8B */
+			rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);

-				printk(KERN_INFO "microcode: CPU%d updated from revision "
-						"%d to %d, date=%08x\n",
-						cpu_num, rev, val[1], m->date);
-			}
-			break;
+			/* notify the caller of success on this cpu */
+			req->err = 0;
+			spin_unlock_irqrestore(&microcode_update_lock, flags);
+			printk(KERN_INFO "microcode: CPU%d updated from revision "
+			       "%d to %d, date=%08x\n",
+			       cpu_num, rev, val[1], microcode[i].date);
+			return;
 		}
-
-	if(!found)
-		printk(KERN_ERR "microcode: CPU%d no microcode found! (sig=%x, pflags=%d)\n",
-				cpu_num, sig, pf);
+
+	printk(KERN_ERR
+	       "microcode: CPU%d no microcode found! (sig=%x, pflags=%d)\n",
+	       cpu_num, sig, pf);
 }
+

 static ssize_t microcode_read(struct file *file, char *buf, size_t len, loff_t *ppos)
 {

