Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSDSKSK>; Fri, 19 Apr 2002 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSDSKSJ>; Fri, 19 Apr 2002 06:18:09 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:24169 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312141AbSDSKSH>; Fri, 19 Apr 2002 06:18:07 -0400
Subject: [2.5.9 patch] Fix bluesmoke/mce compiler warnings.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 19 Apr 2002 11:18:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yVSw-0001Iv-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider below patch for inclusion. It fixes compiler warnings
from arch/i386/kernel/bluesmoke.c which appear due to smp_call_function
expecting a function pointer taking an argument to a void * but
mce_checkregs takes an int argument...

This patch changes mce_checkregs to use void* and typecasts to/from
unsigned long as necessary.

Patch is tested and compilation of bluesmoke.c now proceeds without
warnings on both UP and SMP.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- mce.patch ---
--- tng/arch/i386/kernel/bluesmoke.c.old	Fri Apr 19 10:54:21 2002
+++ tng/arch/i386/kernel/bluesmoke.c	Fri Apr 19 10:53:04 2002
@@ -227,12 +227,12 @@ asmlinkage void do_machine_check(struct 
 #ifdef CONFIG_X86_MCE_NONFATAL
 struct timer_list mce_timer;
 
-static void mce_checkregs (unsigned int cpu)
+static void mce_checkregs (void *cpu)
 {
 	u32 low, high;
 	int i;
 
-	if (cpu!=smp_processor_id())
+	if ((unsigned long)cpu!=smp_processor_id())
 		BUG();
 
 	for (i=0; i<banks; i++) {
@@ -258,13 +258,13 @@ static void mce_checkregs (unsigned int 
 
 static void mce_timerfunc (unsigned long data)
 {
-	int i;
+	unsigned long i;
 
-	for (i=0; i<smp_num_cpus; i++) {
+	for (i = 0; i < smp_num_cpus; i++) {
 		if (i == smp_processor_id())
-			mce_checkregs(i);
+			mce_checkregs((void*)i);
 		else
-			smp_call_function (mce_checkregs, i, 1, 1);
+			smp_call_function(mce_checkregs, (void*)i, 1, 1);
 	}
 }
 #endif


