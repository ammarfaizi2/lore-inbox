Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVJOS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVJOS0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVJOS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:26:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15073 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751137AbVJOS0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:26:13 -0400
Subject: PATCH: EDAC atomic scrub operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Oct 2005 19:55:28 +0100
Message-Id: <1129402528.17923.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDAC requires a way to scrub memory if an ECC error is found and the
chipset does not do the work automatically. That means rewriting memory
locations atomically with respect to all CPUs _and_ bus masters. That
means we can't use atomic_add(foo, 0) as it gets optimised for non-SMP

This adds a function to include/asm-foo/atomic.h for the platforms
currently supported which implements a scrub of a mapped block.

It also adjusts a few other files include order where atomic.h is
included before types.h as this now causes an error as atomic_scrub uses
u32.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/md/kcopyd.c linux-2.6.14-rc2-mm1/drivers/md/kcopyd.c
--- linux.vanilla-2.6.14-rc2-mm1/drivers/md/kcopyd.c	2005-09-22 15:21:40.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/md/kcopyd.c	2005-10-14 18:54:22.000000000 +0100
@@ -8,6 +8,7 @@
  * completion notification.
  */
 
+#include <asm/types.h>
 #include <asm/atomic.h>
 
 #include <linux/blkdev.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/w1/matrox_w1.c linux-2.6.14-rc2-mm1/drivers/w1/matrox_w1.c
--- linux.vanilla-2.6.14-rc2-mm1/drivers/w1/matrox_w1.c	2005-09-22 15:21:55.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/w1/matrox_w1.c	2005-10-14 19:04:55.000000000 +0100
@@ -19,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
-#include <asm/atomic.h>
 #include <asm/types.h>
+#include <asm/atomic.h>
 #include <asm/io.h>
 
 #include <linux/delay.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/fs/nfsctl.c linux-2.6.14-rc2-mm1/fs/nfsctl.c
--- linux.vanilla-2.6.14-rc2-mm1/fs/nfsctl.c	2005-09-22 15:22:00.000000000 +0100
+++ linux-2.6.14-rc2-mm1/fs/nfsctl.c	2005-10-14 18:39:22.000000000 +0100
@@ -5,6 +5,7 @@
  *
  */
 #include <linux/config.h>
+#include <linux/types.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sunrpc/svc.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/include/asm-i386/atomic.h linux-2.6.14-rc2-mm1/include/asm-i386/atomic.h
--- linux.vanilla-2.6.14-rc2-mm1/include/asm-i386/atomic.h	2005-09-22 15:22:55.000000000 +0100
+++ linux-2.6.14-rc2-mm1/include/asm-i386/atomic.h	2005-10-14 18:30:03.000000000 +0100
@@ -237,4 +237,15 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
+
+static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
+{
+	u32 i;
+	for (i = 0; i < size / 4; i++, virt_addr++)
+		/* Very carefully read and write to memory atomically
+		 * so we are interrupt, DMA and SMP safe.
+		 */
+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
+}
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h linux-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h
--- linux.vanilla-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h	2005-09-22 15:22:11.000000000 +0100
+++ linux-2.6.14-rc2-mm1/include/asm-x86_64/atomic.h	2005-10-14 18:29:47.000000000 +0100
@@ -378,4 +378,16 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
+
+static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
+{
+	u32 i;
+	for (i = 0; i < size / 4; i++, virt_addr++)
+		/* Very carefully read and write to memory atomically
+		 * so we are interrupt, DMA and SMP safe.
+		 */
+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
+}
+
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/kernel/audit.c linux-2.6.14-rc2-mm1/kernel/audit.c
--- linux.vanilla-2.6.14-rc2-mm1/kernel/audit.c	2005-09-22 15:22:45.000000000 +0100
+++ linux-2.6.14-rc2-mm1/kernel/audit.c	2005-10-14 18:31:38.000000000 +0100
@@ -42,8 +42,8 @@
  */
 
 #include <linux/init.h>
-#include <asm/atomic.h>
 #include <asm/types.h>
+#include <asm/atomic.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/err.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/kernel/auditsc.c linux-2.6.14-rc2-mm1/kernel/auditsc.c
--- linux.vanilla-2.6.14-rc2-mm1/kernel/auditsc.c	2005-09-22 15:22:45.000000000 +0100
+++ linux-2.6.14-rc2-mm1/kernel/auditsc.c	2005-10-14 18:31:51.000000000 +0100
@@ -30,8 +30,8 @@
  */
 
 #include <linux/init.h>
-#include <asm/atomic.h>
 #include <asm/types.h>
+#include <asm/atomic.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mount.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/net/ipv4/raw.c linux-2.6.14-rc2-mm1/net/ipv4/raw.c
--- linux.vanilla-2.6.14-rc2-mm1/net/ipv4/raw.c	2005-09-22 15:22:45.000000000 +0100
+++ linux-2.6.14-rc2-mm1/net/ipv4/raw.c	2005-10-14 19:09:41.000000000 +0100
@@ -40,12 +40,12 @@
  */
  
 #include <linux/config.h> 
+#include <linux/types.h>
 #include <asm/atomic.h>
 #include <asm/byteorder.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
-#include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/slab.h>
 #include <linux/errno.h>




