Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284860AbRLXNxa>; Mon, 24 Dec 2001 08:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284868AbRLXNxU>; Mon, 24 Dec 2001 08:53:20 -0500
Received: from ldap.elis.rug.ac.be ([157.193.67.1]:15806 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S284860AbRLXNxO>; Mon, 24 Dec 2001 08:53:14 -0500
Date: Mon, 24 Dec 2001 14:53:08 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: Weird __put_user_asm behavior
Message-ID: <Pine.LNX.4.33.0112241436140.12067-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I already posted this question 2 times on this mailing list under the 
subject 'Help on __put_user_asm' but seems like the mailing software 
doesn't like such subjects (or the person behind it:).
So here it goes: when I patch the macro in include/asm-i386/uaccess.h 
named __put_user_asm using the patch below I cannot 'strace ls' anymore.
The ld.so runtime linker just stops when preparing the program displaying 
a nice message; the same message as '/lib/ld-linux.so.2' generates when 
ran without any parameters.
The kernel messages of __put_user_asm go to: 0xbffffb44; then the program 
stops on the ld.so message. 
But, 'strace'-ing of a static compiled program does the job as expected.
What am I doing wrong?

Thanks in advance,
Frank

--- linux-2.4.17/include/asm-i386/uaccess.h	Sat Dec 22 09:35:17 2001
+++ linux/include/asm-i386/uaccess.h	Mon Dec 24 12:43:22 2001
@@ -194,6 +194,10 @@
  * aliasing issues.
  */
 #define __put_user_asm(x, addr, err, itype, rtype, ltype)	\
+do {								\
+	if (current->ptrace & PT_PTRACED) {			\
+		printk(KERN_DEBUG "__put_user_asm: %#x\n", (unsigned long)(addr)); \
+	}							\
 	__asm__ __volatile__(					\
 		"1:	mov"itype" %"rtype"1,%2\n"		\
 		"2:\n"						\
@@ -206,7 +210,8 @@
 		"	.long 1b,3b\n"				\
 		".previous"					\
 		: "=r"(err)					\
-		: ltype (x), "m"(__m(addr)), "i"(-EFAULT), "0"(err))
+		: ltype (x), "m"(__m(addr)), "i"(-EFAULT), "0"(err)); \
+} while (0)
 
 
 #define __get_user_nocheck(x,ptr,size)				\

