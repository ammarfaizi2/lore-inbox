Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSAQIMZ>; Thu, 17 Jan 2002 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288297AbSAQIMP>; Thu, 17 Jan 2002 03:12:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:4247 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S288283AbSAQIMI>;
	Thu, 17 Jan 2002 03:12:08 -0500
Date: Thu, 17 Jan 2002 09:12:03 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] getting rid of suser/fsuser for good, first part
Message-ID: <20020117091203.N5235@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is after all 2.5-time, and hence time for a spring-cleaning.

This patch removes suser/fsuser, and while at it,
fixes ufs/balloc.c to use capable instead.

I figured that the only way to get people to fix their files was
to break them ;-P

These files are still naughty (feel free to fix!):

arch/i386/kernel/mtrr.c
arch/sparc64/kernel/ioctl32.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/fealnx.c
drivers/block/cciss.c
drivers/block/cpqarray.c
drivers/block/swim3.c
drivers/block/swim_iop.c
drivers/char/tty_io.c
drivers/char/vt.c
drivers/char/mxser.c
drivers/char/serial167.c
drivers/char/ip2main.c
drivers/char/rio/rio_linux.c
drivers/char/moxa.c
drivers/scsi/cpqfcTSinit.c
drivers/pcmcia/ds.c
drivers/s390/char/tubtty.c

I hope I didn't miss anything.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

--- linux-2.5.3-pre1/fs/ufs/balloc.c.old	Thu Jan 17 08:44:17 2002
+++ linux-2.5.3-pre1/fs/ufs/balloc.c	Thu Jan 17 08:45:37 2002
@@ -284,16 +284,16 @@
 			return 0;
 		}
 	}
-	
+
 	/*
 	 * There is not enough space for user on the device
 	 */
-	if (!fsuser() && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
+	if (!capable(CAP_SYS_RESOURCE) && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
 		unlock_super (sb);
 		UFSD(("EXIT (FAILED)\n"))
 		return 0;
-	} 
-	
+	}
+
 	if (goal >= uspi->s_size) 
 		goal = 0;
 	if (goal == 0) 
--- linux-2.5.3-pre1/include/linux/sched.h.old	Thu Jan 17 08:35:21 2002
+++ linux-2.5.3-pre1/include/linux/sched.h	Thu Jan 17 08:37:53 2002
@@ -727,52 +727,15 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
-/*
- * This has now become a routine instead of a macro, it sets a flag if
- * it returns true (to do BSD-style accounting where the process is flagged
- * if it uses root privs). The implication of this is that you should do
- * normal permissions checks first, and check suser() last.
- *
- * [Dec 1997 -- Chris Evans]
- * For correctness, the above considerations need to be extended to
- * fsuser(). This is done, along with moving fsuser() checks to be
- * last.
- *
- * These will be removed, but in the mean time, when the SECURE_NOROOT 
- * flag is set, uids don't grant privilege.
- */
-static inline int suser(void)
-{
-	if (!issecure(SECURE_NOROOT) && current->euid == 0) { 
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-
-static inline int fsuser(void)
-{
-	if (!issecure(SECURE_NOROOT) && current->fsuid == 0) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
 
 /*
- * capable() checks for a particular capability.  
- * New privilege checks should use this interface, rather than suser() or
- * fsuser(). See include/linux/capability.h for defined capabilities.
+ * capable() checks for a particular capability.
+ * See include/linux/capability.h for defined capabilities.
  */
 
 static inline int capable(int cap)
 {
-#if 1 /* ok now */
-	if (cap_raised(current->cap_effective, cap))
-#else
-	if (cap_is_fs_cap(cap) ? current->fsuid == 0 : current->euid == 0)
-#endif
-	{
+	if (cap_raised(current->cap_effective, cap)) {
 		current->flags |= PF_SUPERPRIV;
 		return 1;
 	}
--- linux-2.5.3-pre1/include/linux/capability.h.old	Thu Jan 17 08:40:59 2002
+++ linux-2.5.3-pre1/include/linux/capability.h	Thu Jan 17 08:41:05 2002
@@ -99,10 +99,6 @@
 
 #define CAP_FSETID           4
 
-/* Used to decide between falling back on the old suser() or fsuser(). */
-
-#define CAP_FS_MASK          0x1f
-
 /* Overrides the restriction that the real or effective user ID of a
    process sending a signal must match the real or effective user ID
    of the process receiving the signal. */
@@ -345,8 +341,6 @@
 #define cap_clear(c)         do { cap_t(c) =  0; } while(0)
 #define cap_set_full(c)      do { cap_t(c) = ~0; } while(0)
 #define cap_mask(c,mask)     do { cap_t(c) &= cap_t(mask); } while(0)
-
-#define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
 #endif /* __KERNEL__ */
 
