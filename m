Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136747AbREIRLd>; Wed, 9 May 2001 13:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136758AbREIRLX>; Wed, 9 May 2001 13:11:23 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:50699 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S136747AbREIRLK>;
	Wed, 9 May 2001 13:11:10 -0400
Date: Wed, 9 May 2001 19:09:55 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __up_read and gcc-3.0
Message-ID: <20010509190955.A1526@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
  can you apply this patch to next 2.4.4-acX ? This fixes problem with
gcc3.0 (20010426) unable to compile this under some conditions. As
__up_write() uses same code ("i".... instead of tmp variable), I think
that you should apply this. It can cause slower code, as gcc cannot
move "movl -RWSEM_ACTIVE_READ_BIAS,%edx" away from "xadd" anymore,
but as "lock xadd" is slow anyway, it should not matter.

  I looked at generated code in cases where it originally failed, and
generated code looks OK to me.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/include/asm-i386/rwsem.h linux/include/asm-i386/rwsem.h
--- linux/include/asm-i386/rwsem.h	Fri Apr 27 22:48:24 2001
+++ linux/include/asm-i386/rwsem.h	Wed May  9 16:31:57 2001
@@ -148,9 +148,9 @@
  */
 static inline void __up_read(struct rw_semaphore *sem)
 {
-	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
+		"  movl      %2,%%edx\n\t"
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
@@ -164,9 +164,9 @@
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
-		: "a"(sem)
-		: "memory", "cc");
+		: "+m"(sem->count)
+		: "a"(sem), "i"(-RWSEM_ACTIVE_READ_BIAS)
+		: "memory", "cc", "edx");
 }
 
 /*
