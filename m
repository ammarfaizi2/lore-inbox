Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbRGJDpl>; Mon, 9 Jul 2001 23:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265411AbRGJDpW>; Mon, 9 Jul 2001 23:45:22 -0400
Received: from suntan.tandem.com ([192.216.221.8]:58362 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S265408AbRGJDpQ>; Mon, 9 Jul 2001 23:45:16 -0400
Message-ID: <3B4A773D.50632896@compaq.com>
Date: Mon, 09 Jul 2001 20:32:13 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bcrl@redhat.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] read/write semaphore trylock routines - 2.4.6
Content-Type: multipart/mixed;
 boundary="------------D29EE838BA57F3F1A4E8993C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D29EE838BA57F3F1A4E8993C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ben-

A few months ago, I sent you a couple of trylock routines for
read/write semaphores. Here's an updated version for 2.4.6. We use
them for deadlock avoidance in the clustering work we're doing. We
thought that others might be able to use them, as well.

A caveat for these trylock routines is that they use the cmpxchg
instruction, which limits their usefulness on x86 to 486 and above. I
noticed that the RISC architectures, however, have no problem rigging
up a cmpxchg() equivalent (at least Alpha and PPC don't).

Please let me know if you have any objections to folding them in with
the rest of the read/write semaphore implementation.

Thanks.

-- 
Brian Watson               | "The common people of England... so 
Linux Kernel Developer     |  jealous of their liberty, but like the 
SSI Clustering Laboratory  |  common people of most other countries 
Compaq Computer Corp       |  never rightly considering wherein it 
Los Angeles, CA            |  consists..."
                           |      -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
--------------D29EE838BA57F3F1A4E8993C
Content-Type: text/plain; charset=us-ascii;
 name="patch-rwsem-trylock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rwsem-trylock"

Index: include/asm-i386/rwsem.h
===================================================================
RCS file: /src/nsc_linux/src/kernel/include/asm-i386/rwsem.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rwsem.h
--- include/asm-i386/rwsem.h	2001/04/27 22:48:24	1.1.1.1
+++ include/asm-i386/rwsem.h	2001/07/06 20:54:13
@@ -222,5 +222,34 @@
 	return tmp+delta;
 }
 
+#if __HAVE_ARCH_CMPXCHG
+/* returns 1 if it successfully obtained the semaphore for write */
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	signed long ret = cmpxchg(&sem->count,
+				  RWSEM_UNLOCKED_VALUE, 
+				  RWSEM_ACTIVE_WRITE_BIAS);
+	if (ret == RWSEM_UNLOCKED_VALUE)
+		return 1;
+	return 0;
+}
+
+/* returns 1 if it successfully obtained the semaphore for read */
+static inline int down_read_trylock(struct rw_semaphore *sem)
+{
+	signed long old, new;
+
+repeat:
+	old = (volatile signed long)sem->count;
+	if (old < RWSEM_UNLOCKED_VALUE)
+		return 0;
+	new = old + RWSEM_ACTIVE_READ_BIAS;
+	if (cmpxchg(&sem->count, old, new) == old)
+		return 1;
+	else
+		goto repeat;
+}
+#endif /* __HAVE_ARCH_CMPXCHG */
+
 #endif /* __KERNEL__ */
 #endif /* _I386_RWSEM_H */

--------------D29EE838BA57F3F1A4E8993C--

