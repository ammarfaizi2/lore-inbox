Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSFDVPU>; Tue, 4 Jun 2002 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSFDVPT>; Tue, 4 Jun 2002 17:15:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63983 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316786AbSFDVPM>; Tue, 4 Jun 2002 17:15:12 -0400
Subject: [PATCH] remove suser()
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 14:15:10 -0700
Message-Id: <1023225311.3904.142.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch replaces the lone remaining suser() call with capable()
and then removes suser() itself in a triumphant celebration of the glory
of capable().  Or something. ;-)

Small cleanup of capable() and some comments, too.

Patch is against 2.5.20, please apply.

	Robert Love

diff -urN linux-2.5.20/drivers/net/wan/pc300_drv.c linux/drivers/net/wan/pc300_drv.c
--- linux-2.5.20/drivers/net/wan/pc300_drv.c	Sun Jun  2 18:44:53 2002
+++ linux/drivers/net/wan/pc300_drv.c	Tue Jun  4 13:56:54 2002
@@ -2564,7 +2564,7 @@
 				return -EINVAL;
 			return 0;
 		case SIOCSPC300CONF:
-			if (!suser())
+			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
 			if (!arg || 
 				copy_from_user(&conf_aux.conf, arg, sizeof(pc300chconf_t)))
diff -urN linux-2.5.20/include/linux/compatmac.h linux/include/linux/compatmac.h
--- linux-2.5.20/include/linux/compatmac.h	Sun Jun  2 18:44:41 2002
+++ linux/include/linux/compatmac.h	Tue Jun  4 13:57:33 2002
@@ -102,8 +102,6 @@
 
 #define my_iounmap(x, b)             (((long)x<0x100000)?0:vfree ((void*)x))
 
-#define capable(x)                   suser()
-
 #define tty_flip_buffer_push(tty)    queue_task(&tty->flip.tqueue, &tq_timer)
 #define signal_pending(current)      (current->signal & ~current->blocked)
 #define schedule_timeout(to)         do {current->timeout = jiffies + (to);schedule ();} while (0)
diff -urN linux-2.5.20/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.20/include/linux/sched.h	Sun Jun  2 18:44:41 2002
+++ linux/include/linux/sched.h	Tue Jun  4 14:03:35 2002
@@ -588,24 +588,10 @@
  * This has now become a routine instead of a macro, it sets a flag if
  * it returns true (to do BSD-style accounting where the process is flagged
  * if it uses root privs). The implication of this is that you should do
- * normal permissions checks first, and check suser() last.
+ * normal permissions checks first, and check fsuser() last.
  *
- * [Dec 1997 -- Chris Evans]
- * For correctness, the above considerations need to be extended to
- * fsuser(). This is done, along with moving fsuser() checks to be
- * last.
- *
- * These will be removed, but in the mean time, when the SECURE_NOROOT 
- * flag is set, uids don't grant privilege.
+ * suser() is gone, fsuser() should go soon too...
  */
-static inline int suser(void)
-{
-	if (!issecure(SECURE_NOROOT) && current->euid == 0) { 
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
 
 static inline int fsuser(void)
 {
@@ -617,19 +603,12 @@
 }
 
 /*
- * capable() checks for a particular capability.  
- * New privilege checks should use this interface, rather than suser() or
- * fsuser(). See include/linux/capability.h for defined capabilities.
+ * capable() checks for a particular capability.
+ * See include/linux/capability.h for defined capabilities.
  */
-
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



