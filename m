Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJ3MiY>; Tue, 30 Oct 2001 07:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJ3MiO>; Tue, 30 Oct 2001 07:38:14 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:59493 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S273783AbRJ3MiG>;
	Tue, 30 Oct 2001 07:38:06 -0500
Date: Tue, 30 Oct 2001 12:38:35 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.14-pre5] bugfix to microcode update driver
Message-ID: <Pine.LNX.4.21.0110301232210.1282-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Apparently, on a HT (hyper-threading) enabled processors the processor
resources (for microcode update) are shared by all logical processors in a
single CPU package, so if one logical processor accepted the update then
it (currently) will fail on all others. Removing that check is harmless
for other (non-HT) processors and required on HT, so please apply this
patch.

Regards,
Tigran


--- arch/i386/kernel/microcode.c.0	Tue Oct 30 12:29:00 2001
+++ arch/i386/kernel/microcode.c	Tue Oct 30 12:27:33 2001
@@ -47,6 +47,10 @@
  *	1.08	11 Dec 2000, Richard Schaal <richard.schaal@intel.com> and
  *			     Tigran Aivazian <tigran@veritas.com>
  *		Intel Pentium 4 processor support and bugfixes.
+ *	1.09	30 Oct 2001, Tigran Aivazian <tigran@veritas.com>
+ *		Bugfix for HT (Hyper-Threading) enabled processors
+ *		whereby processor resources are shared by all logical processors
+ *		in a single CPU package.
  */
 
 #include <linux/init.h>
@@ -61,7 +65,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#define MICROCODE_VERSION 	"1.08"
+#define MICROCODE_VERSION 	"1.09"
 
 MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver");
 MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
@@ -240,10 +244,6 @@
 				printk(KERN_ERR 
 					"microcode: CPU%d not 'upgrading' to earlier revision"
 					" %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
-			} else if (microcode[i].rev == rev) {
-				printk(KERN_ERR
-					"microcode: CPU%d already up-to-date (revision %d)\n",
-						cpu_num, rev);
 			} else {
 				int sum = 0;
 				struct microcode *m = &microcode[i];




