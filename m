Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbQL1LLm>; Thu, 28 Dec 2000 06:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbQL1LLd>; Thu, 28 Dec 2000 06:11:33 -0500
Received: from 212-140-94-163.btopenworld.com ([212.140.94.163]:45829 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130138AbQL1LLY>;
	Thu, 28 Dec 2000 06:11:24 -0500
Date: Thu, 28 Dec 2000 10:43:19 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
cc: dr@bofh.de
Subject: [patch-2.2.19-pre3] fix to the oops in microcode driver
Message-ID: <Pine.LNX.4.21.0012281041390.861-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have already sent this to Alan but some people on #kernelnewbies on irc
complained about this Oops so I decided to send to all. (on the first
round I cc'd:linux-kernel@vger.rutgers.edu)

Regards,
Tigran

diff -urN -X dontdiff linux/Documentation/Changes ucode-2.2/Documentation/Changes
--- linux/Documentation/Changes	Wed Dec 27 07:32:10 2000
+++ ucode-2.2/Documentation/Changes	Wed Dec 27 07:46:42 2000
@@ -529,8 +529,8 @@
 chmod 0644 /dev/cpu/microcode
 
 as root before you can use this.  You'll probably also want to
-get the user-space microcode_ctl utility to use with this.  The utility is
-available at:
+get the user-space microcode_ctl utility (and, obviously, the microcode
+data itself) to use with this.  Both are available at:
 
 http://www.urbanmyth.org/microcode
 
@@ -539,29 +539,8 @@
 
 alias char-major-10-184 microcode
 
-to your /etc/modules.conf file.
-
-
-Intel IA32 microcode
-====================
-
-A driver has been added to allow updating of Intel IA32 microcode,
-accessible as both a devfs regular file and as a normal (misc)
-character device.  If you are not using devfs you may need to:
-
-mkdir /dev/cpu
-mknod /dev/cpu/microcode c 10 184
-chmod 0644 /dev/cpu/microcode
-
-as root before you can use this.  You'll probably also want to
-get the user-space microcode_ctl utility to use with this.
-
-If you have compiled the driver as a module you may need to add
-the following line:
-
-alias char-major-10-184 microcode
-
-to your /etc/modules.conf file.
+to your /etc/modules.conf file, unless you are using recent enough
version
+of modutils which knows about this by default.
 
 
 Where to get the files
diff -urN -X dontdiff linux/arch/i386/kernel/microcode.c ucode-2.2/arch/i386/kernel/microcode.c
--- linux/arch/i386/kernel/microcode.c	Wed Dec 27 07:32:10 2000
+++ ucode-2.2/arch/i386/kernel/microcode.c	Wed Dec 27 07:52:07 2000
@@ -35,6 +35,8 @@
  *		Pentium 4 support + backported fixes from 2.4
  *	1.07	13 Dec 2000, Tigran Aivazian <tigran@veritas.com>
  *		More bugfixes backported from 2.4
+ *	1.08	27 Dec 2000, Tigran Aivazian <tigran@veritas.com>
+ *		Fix: X86_FEATURE_30 was used incorrectly (in a 2.4 manner)
  */
 
 #include <linux/init.h>
@@ -49,7 +51,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#define MICROCODE_VERSION 	"1.07"
+#define MICROCODE_VERSION 	"1.08"
 
 MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
@@ -161,7 +163,7 @@
 	req->err = 1; /* be pessimistic */
 
 	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
-		test_bit(X86_FEATURE_30, &c->x86_capability)) { /* IA64 */
+		(c->x86_capability & X86_FEATURE_30) ) { /* IA64 */
 		printk(KERN_ERR "microcode: CPU%d not a capable Intel processor\n", cpu_num);
 		return;
 	}
@@ -307,8 +309,8 @@
 				memset(mc_applied, 0, mc_fsize);
 				kfree(mc_applied);
 				mc_applied = NULL;
-				printk(KERN_WARNING "microcode: freed %d bytes\n", bytes);
 				mc_fsize = 0;
+				printk(KERN_WARNING "microcode: freed %d bytes\n", bytes);
 				up(&microcode_sem);
 				return 0;
 			}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
