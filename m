Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWAHFvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWAHFvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbWAHFvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:51:10 -0500
Received: from xenotime.net ([66.160.160.81]:30922 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751162AbWAHFvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:51:09 -0500
Date: Sat, 7 Jan 2006 21:51:06 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Michael Buesch <mbuesch@freenet.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 1/4] move capable() to capability.h
Message-Id: <20060107215106.38d58bb9.rdunlap@xenotime.net>
In-Reply-To: <200601061226.42416.mbuesch@freenet.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<200601061218.17369.mbuesch@freenet.de>
	<1136546539.2940.28.camel@laptopd505.fenrus.org>
	<200601061226.42416.mbuesch@freenet.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > BTW, is there a special reason why this is declared in sched.h
> > > instead of capability.h?
> > 
> > probably a lot of historic bagage... anyway not something that should be
> > cleaned up as part of this series, could maybe be done in another patch
> > if you feel so inclined :)

(nothing to do with inlining here)

From: Randy Dunlap <rdunlap@xenotime.net>

headers + core:
- Move capable() from sched.h to capability.h;
- Use <linux/capability.h> where capable() is used
	(in include/, block/, ipc/, kernel/, a few drivers/,
	mm/, security/, & sound/;
	many more drivers/ to go)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 block/ioctl.c                   |    2 +-
 block/scsi_ioctl.c              |    1 +
 drivers/acorn/char/i2c.c        |    1 +
 drivers/base/firmware_class.c   |    1 +
 drivers/base/memory.c           |    2 +-
 drivers/firmware/efivars.c      |    2 +-
 drivers/oprofile/event_buffer.c |    1 +
 drivers/parisc/led.c            |    1 +
 drivers/parisc/pdc_stable.c     |    2 +-
 fs/xfs/linux-2.6/xfs_cred.h     |    4 +++-
 include/linux/capability.h      |   15 +++++++++++++++
 include/linux/mm.h              |    1 +
 include/linux/sched.h           |   14 --------------
 ipc/mqueue.c                    |    1 +
 ipc/msg.c                       |    1 +
 ipc/sem.c                       |    1 +
 ipc/shm.c                       |    1 +
 ipc/util.c                      |    1 +
 kernel/acct.c                   |    1 +
 kernel/capability.c             |    1 +
 kernel/exit.c                   |    1 +
 kernel/fork.c                   |    1 +
 kernel/kexec.c                  |    1 +
 kernel/module.c                 |    1 +
 kernel/ptrace.c                 |    1 +
 kernel/sched.c                  |    1 +
 kernel/signal.c                 |    1 +
 kernel/sys.c                    |    1 +
 kernel/sysctl.c                 |    1 +
 kernel/time.c                   |    1 +
 kernel/uid16.c                  |    1 +
 mm/filemap.c                    |    1 +
 mm/mlock.c                      |    1 +
 mm/mmap.c                       |    1 +
 mm/mremap.c                     |    1 +
 mm/swapfile.c                   |    1 +
 security/commoncap.c            |    1 +
 security/dummy.c                |    1 +
 security/keys/keyctl.c          |    1 +
 security/security.c             |    1 +
 sound/pci/emu10k1/emufx.c       |    1 +
 41 files changed, 56 insertions(+), 19 deletions(-)

--- linux-2615-g3.orig/include/linux/capability.h
+++ linux-2615-g3/include/linux/capability.h
@@ -43,6 +43,7 @@ typedef struct __user_cap_data_struct {
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 /* #define STRICT_CAP_T_TYPECHECKS */
 
@@ -356,6 +357,20 @@ static inline kernel_cap_t cap_invert(ke
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
+#ifdef CONFIG_SECURITY
+/* code is in security.c */
+extern int capable(int cap);
+#else
+static inline int capable(int cap)
+{
+	if (cap_raised(current->cap_effective, cap)) {
+		current->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+	return 0;
+}
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* !_LINUX_CAPABILITY_H */
--- linux-2615-g3.orig/include/linux/mm.h
+++ linux-2615-g3/include/linux/mm.h
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/capability.h>
 
 #ifdef __KERNEL__
 
--- linux-2615-g3.orig/include/linux/sched.h
+++ linux-2615-g3/include/linux/sched.h
@@ -1089,20 +1089,6 @@ static inline int sas_ss_flags(unsigned 
 }
 
 
-#ifdef CONFIG_SECURITY
-/* code is in security.c */
-extern int capable(int cap);
-#else
-static inline int capable(int cap)
-{
-	if (cap_raised(current->cap_effective, cap)) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-#endif
-
 /*
  * Routines for handling mm_structs
  */
--- linux-2615-g3.orig/fs/xfs/linux-2.6/xfs_cred.h
+++ linux-2615-g3/fs/xfs/linux-2.6/xfs_cred.h
@@ -18,6 +18,8 @@
 #ifndef __XFS_CRED_H__
 #define __XFS_CRED_H__
 
+#include <linux/capability.h>
+
 /*
  * Credentials
  */
@@ -27,7 +29,7 @@ typedef struct cred {
 
 extern struct cred *sys_cred;
 
-/* this is a hack.. (assums sys_cred is the only cred_t in the system) */
+/* this is a hack.. (assumes sys_cred is the only cred_t in the system) */
 static __inline int capable_cred(cred_t *cr, int cid)
 {
 	return (cr == sys_cred) ? 1 : capable(cid);
--- linux-2615-g3.orig/block/ioctl.c
+++ linux-2615-g3/block/ioctl.c
@@ -1,4 +1,4 @@
-#include <linux/sched.h>		/* for capable() */
+#include <linux/capability.h>
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/backing-dev.h>
--- linux-2615-g3.orig/block/scsi_ioctl.c
+++ linux-2615-g3/block/scsi_ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/cdrom.h>
 #include <linux/slab.h>
--- linux-2615-g3.orig/drivers/acorn/char/i2c.c
+++ linux-2615-g3/drivers/acorn/char/i2c.c
@@ -12,6 +12,7 @@
  *  On Acorn machines, the following i2c devices are on the bus:
  *	- PCF8583 real time clock & static RAM
  */
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/time.h>
--- linux-2615-g3.orig/drivers/base/firmware_class.c
+++ linux-2615-g3/drivers/base/firmware_class.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/drivers/base/memory.c
+++ linux-2615-g3/drivers/base/memory.c
@@ -13,8 +13,8 @@
 #include <linux/sysdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>	/* capable() */
 #include <linux/topology.h>
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/memory.h>
 #include <linux/kobject.h>
--- linux-2615-g3.orig/drivers/firmware/efivars.c
+++ linux-2615-g3/drivers/firmware/efivars.c
@@ -65,11 +65,11 @@
  *   v0.01 release to linux-ia64@linuxia64.org
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/sched.h>		/* for capable() */
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/string.h>
--- linux-2615-g3.orig/drivers/parisc/led.c
+++ linux-2615-g3/drivers/parisc/led.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/utsname.h>
+#include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
--- linux-2615-g3.orig/drivers/parisc/pdc_stable.c
+++ linux-2615-g3/drivers/parisc/pdc_stable.c
@@ -42,9 +42,9 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>		/* for capable() */
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
--- linux-2615-g3.orig/drivers/oprofile/event_buffer.c
+++ linux-2615-g3/drivers/oprofile/event_buffer.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/oprofile.h>
 #include <linux/sched.h>
+#include <linux/capability.h>
 #include <linux/dcookies.h>
 #include <linux/fs.h>
 #include <asm/uaccess.h>
--- linux-2615-g3.orig/ipc/mqueue.c
+++ linux-2615-g3/ipc/mqueue.c
@@ -11,6 +11,7 @@
  * This file is released under the GPL.
  */
 
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
--- linux-2615-g3.orig/ipc/msg.c
+++ linux-2615-g3/ipc/msg.c
@@ -15,6 +15,7 @@
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/msg.h>
--- linux-2615-g3.orig/ipc/sem.c
+++ linux-2615-g3/ipc/sem.c
@@ -73,6 +73,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/capability.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include "util.h"
--- linux-2615-g3.orig/ipc/shm.c
+++ linux-2615-g3/ipc/shm.c
@@ -27,6 +27,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/audit.h>
+#include <linux/capability.h>
 #include <linux/ptrace.h>
 #include <linux/seq_file.h>
 
--- linux-2615-g3.orig/ipc/util.c
+++ linux-2615-g3/ipc/util.c
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/capability.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
 #include <linux/rcupdate.h>
--- linux-2615-g3.orig/sound/pci/emu10k1/emufx.c
+++ linux-2615-g3/sound/pci/emu10k1/emufx.c
@@ -27,6 +27,7 @@
 
 #include <sound/driver.h>
 #include <linux/pci.h>
+#include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
--- linux-2615-g3.orig/mm/filemap.c
+++ linux-2615-g3/mm/filemap.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/aio.h>
+#include <linux/capability.h>
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
--- linux-2615-g3.orig/mm/mlock.c
+++ linux-2615-g3/mm/mlock.c
@@ -5,6 +5,7 @@
  *  (C) Copyright 2002 Christoph Hellwig
  */
 
+#include <linux/capability.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/mempolicy.h>
--- linux-2615-g3.orig/mm/mmap.c
+++ linux-2615-g3/mm/mmap.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/fs.h>
--- linux-2615-g3.orig/mm/mremap.c
+++ linux-2615-g3/mm/mremap.c
@@ -13,6 +13,7 @@
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/mm/swapfile.c
+++ linux-2615-g3/mm/swapfile.c
@@ -25,6 +25,7 @@
 #include <linux/rmap.h>
 #include <linux/security.h>
 #include <linux/backing-dev.h>
+#include <linux/capability.h>
 #include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
--- linux-2615-g3.orig/kernel/acct.c
+++ linux-2615-g3/kernel/acct.c
@@ -47,6 +47,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acct.h>
+#include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/kernel/capability.c
+++ linux-2615-g3/kernel/capability.c
@@ -7,6 +7,7 @@
  * 30 May 2002:	Cleanup, Robert M. Love <rml@tech9.net>
  */ 
 
+#include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/kernel/exit.c
+++ linux-2615-g3/kernel/exit.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
--- linux-2615-g3.orig/kernel/fork.c
+++ linux-2615-g3/kernel/fork.c
@@ -28,6 +28,7 @@
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/fs.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/kernel/kexec.c
+++ linux-2615-g3/kernel/kexec.c
@@ -6,6 +6,7 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/slab.h>
--- linux-2615-g3.orig/kernel/module.c
+++ linux-2615-g3/kernel/module.c
@@ -28,6 +28,7 @@
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <linux/rcupdate.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
 #include <linux/errno.h>
--- linux-2615-g3.orig/kernel/ptrace.c
+++ linux-2615-g3/kernel/ptrace.c
@@ -7,6 +7,7 @@
  * to continually duplicate across every architecture.
  */
 
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
--- linux-2615-g3.orig/kernel/sched.c
+++ linux-2615-g3/kernel/sched.c
@@ -27,6 +27,7 @@
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
+#include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/kernel/signal.c
+++ linux-2615-g3/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/posix-timers.h>
 #include <linux/signal.h>
 #include <linux/audit.h>
+#include <linux/capability.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
--- linux-2615-g3.orig/kernel/sys.c
+++ linux-2615-g3/kernel/sys.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/workqueue.h>
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/key.h>
 #include <linux/times.h>
--- linux-2615-g3.orig/kernel/sysctl.c
+++ linux-2615-g3/kernel/sysctl.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
+#include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
 #include <linux/capability.h>
--- linux-2615-g3.orig/kernel/time.c
+++ linux-2615-g3/kernel/time.c
@@ -29,6 +29,7 @@
 
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
--- linux-2615-g3.orig/kernel/uid16.c
+++ linux-2615-g3/kernel/uid16.c
@@ -10,6 +10,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/prctl.h>
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/security/commoncap.c
+++ linux-2615-g3/security/commoncap.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2615-g3.orig/security/dummy.c
+++ linux-2615-g3/security/dummy.c
@@ -14,6 +14,7 @@
 
 #undef DEBUG
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
--- linux-2615-g3.orig/security/keys/keyctl.c
+++ linux-2615-g3/security/keys/keyctl.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/keyctl.h>
 #include <linux/fs.h>
+#include <linux/capability.h>
 #include <linux/err.h>
 #include <asm/uaccess.h>
 #include "internal.h"
--- linux-2615-g3.orig/security/security.c
+++ linux-2615-g3/security/security.c
@@ -11,6 +11,7 @@
  *	(at your option) any later version.
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>



---
