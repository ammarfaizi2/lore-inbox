Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272652AbRIKXri>; Tue, 11 Sep 2001 19:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272650AbRIKXr2>; Tue, 11 Sep 2001 19:47:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52484 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S272643AbRIKXrR>;
	Tue, 11 Sep 2001 19:47:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15262.41208.111676.456259@cargo.ozlabs.ibm.com>
Date: Wed, 12 Sep 2001 09:40:40 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        benh@kernel.crashing.org
Subject: [PATCH] PPC 64-bit get/put_user
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below adds support for 64-bit quantities in get_user,
put_user, etc. on PowerPC.  This is needed because of the addition of
the BLKGETSIZE64 ioctl.  Please apply to your tree.

Regards,
Paul.

--- linux/include/asm-ppc/uaccess.h	Sat May 26 12:39:54 2001
+++ linuxppc_2_4/include/asm-ppc/uaccess.h	Tue Sep 11 18:10:06 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.uaccess.h 1.5 05/17/01 18:14:26 cort
+ * BK Id: SCCS/s.uaccess.h 1.8 09/11/01 18:10:06 paulus
  */
 #ifdef __KERNEL__
 #ifndef _PPC_UACCESS_H
@@ -116,6 +116,7 @@
 	  case 1: __put_user_asm(x,ptr,retval,"stb"); break;	\
 	  case 2: __put_user_asm(x,ptr,retval,"sth"); break;	\
 	  case 4: __put_user_asm(x,ptr,retval,"stw"); break;	\
+	  case 8: __put_user_asm2(x,ptr,retval); break;		\
 	  default: __put_user_bad();				\
 	}							\
 } while (0)
@@ -143,6 +144,22 @@
 		: "=r"(err)					\
 		: "r"(x), "b"(addr), "i"(-EFAULT), "0"(err))
 
+#define __put_user_asm2(x, addr, err)				\
+	__asm__ __volatile__(					\
+		"1:	stw %1,0(%2)\n"				\
+		"2:	stw %1+1,4(%2)\n"				\
+		"3:\n"						\
+		".section .fixup,\"ax\"\n"			\
+		"4:	li %0,%3\n"				\
+		"	b 3b\n"					\
+		".previous\n"					\
+		".section __ex_table,\"a\"\n"			\
+		"	.align 2\n"				\
+		"	.long 1b,4b\n"				\
+		"	.long 2b,4b\n"				\
+		".previous"					\
+		: "=r"(err)					\
+		: "r"(x), "b"(addr), "i"(-EFAULT), "0"(err))
 
 #define __get_user_nocheck(x,ptr,size)				\
 ({								\
@@ -171,6 +188,7 @@
 	  case 1: __get_user_asm(x,ptr,retval,"lbz"); break;	\
 	  case 2: __get_user_asm(x,ptr,retval,"lhz"); break;	\
 	  case 4: __get_user_asm(x,ptr,retval,"lwz"); break;	\
+	  case 8: __get_user_asm2(x, ptr, retval);		\
 	  default: (x) = __get_user_bad();			\
 	}							\
 } while (0)
@@ -189,6 +207,25 @@
 		"	.long 1b,3b\n"			\
 		".previous"				\
 		: "=r"(err), "=r"(x)			\
+		: "b"(addr), "i"(-EFAULT), "0"(err))
+
+#define __get_user_asm2(x, addr, err)			\
+	__asm__ __volatile__(				\
+		"1:	lwz %1,0(%2)\n"			\
+		"2:	lwz %1+1,4(%2)\n"		\
+		"3:\n"					\
+		".section .fixup,\"ax\"\n"		\
+		"4:	li %0,%3\n"			\
+		"	li %1,0\n"			\
+		"	li %1+1,0\n"			\
+		"	b 3b\n"				\
+		".previous\n"				\
+		".section __ex_table,\"a\"\n"		\
+		"	.align 2\n"			\
+		"	.long 1b,4b\n"			\
+		"	.long 2b,4b\n"			\
+		".previous"				\
+		: "=r"(err), "=&r"(x)			\
 		: "b"(addr), "i"(-EFAULT), "0"(err))
 
 /* more complex routines */
