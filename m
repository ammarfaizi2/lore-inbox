Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133076AbRECTvq>; Thu, 3 May 2001 15:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRECTv3>; Thu, 3 May 2001 15:51:29 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:12036 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S133071AbRECTvN>;
	Thu, 3 May 2001 15:51:13 -0400
Message-ID: <20010503215101.A15134@bug.ucw.cz>
Date: Thu, 3 May 2001 21:51:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Cleanup of ptrace / ptregs.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Magic constant like 17 is always bad... This gets rid of it.

Please apply,
								Pavel
Index: arch/i386/kernel/ptrace.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/kernel/ptrace.c,v
retrieving revision 1.1.1.2
diff -u -u -r1.1.1.2 ptrace.c
--- arch/i386/kernel/ptrace.c	2001/04/19 20:02:44	1.1.1.2
+++ arch/i386/kernel/ptrace.c	2001/05/03 18:50:15
@@ -229,7 +229,7 @@
 			break;
 
 		tmp = 0;  /* Default return condition */
-		if(addr < 17*sizeof(long))
+		if(addr < FRAME_SIZE*sizeof(long))
 			tmp = getreg(child, addr);
 		if(addr >= (long) &dummy->u_debugreg[0] &&
 		   addr <= (long) &dummy->u_debugreg[7]){
@@ -256,7 +256,7 @@
 		    addr > sizeof(struct user) - 3)
 			break;
 
-		if (addr < 17*sizeof(long)) {
+		if (addr < FRAME_SIZE*sizeof(long)) {
 			ret = putreg(child, addr, data);
 			break;
 		}
@@ -369,11 +369,11 @@
 	}
 
 	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-	  	if (!access_ok(VERIFY_WRITE, (unsigned *)data, 17*sizeof(long))) {
+	  	if (!access_ok(VERIFY_WRITE, (unsigned *)data, FRAME_SIZE*sizeof(long))) {
 			ret = -EIO;
 			break;
 		}
-		for ( i = 0; i < 17*sizeof(long); i += sizeof(long) ) {
+		for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
 			__put_user(getreg(child, i),(unsigned long *) data);
 			data += sizeof(long);
 		}
@@ -383,11 +383,11 @@
 
 	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
 		unsigned long tmp;
-	  	if (!access_ok(VERIFY_READ, (unsigned *)data, 17*sizeof(long))) {
+	  	if (!access_ok(VERIFY_READ, (unsigned *)data, FRAME_SIZE*sizeof(long))) {
 			ret = -EIO;
 			break;
 		}
-		for ( i = 0; i < 17*sizeof(long); i += sizeof(long) ) {
+		for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
 			__get_user(tmp, (unsigned long *) data);
 			putreg(child, i, tmp);
 			data += sizeof(long);
Index: include/asm-i386/ptrace.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/asm-i386/ptrace.h,v
retrieving revision 1.1.1.2
diff -u -u -r1.1.1.2 ptrace.h
--- include/asm-i386/ptrace.h	2001/04/19 20:00:50	1.1.1.2
+++ include/asm-i386/ptrace.h	2001/05/03 18:50:15
@@ -18,7 +18,7 @@
 #define EFL 14
 #define UESP 15
 #define SS   16
-
+#define FRAME_SIZE 17
 
 /* this struct defines the way the registers are stored on the 
    stack during a system call. */

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
