Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSGWPyG>; Tue, 23 Jul 2002 11:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318120AbSGWPxJ>; Tue, 23 Jul 2002 11:53:09 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:51657 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S318119AbSGWPvs>; Tue, 23 Jul 2002 11:51:48 -0400
Message-Id: <200207231554.g6NFshW30400@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] 2.5.27: s390 fixes.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Mail-Copies-To: arndb@de.ibm.com
Date: Tue, 23 Jul 2002 19:50:38 +0200
References: <200207221950.45748.schwidefsky@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated patch, part 5/6:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.4 -> 1.683.1.5
#	include/asm-s390x/param.h	1.2     -> 1.3    
#	include/asm-s390/debug.h	1.5     -> 1.6    
#	include/asm-s390/param.h	1.2     -> 1.3    
#	drivers/s390/net/lcs.c	1.1     -> 1.2    
#	include/asm-s390x/pgalloc.h	1.6     -> 1.7    
#	arch/s390x/kernel/linux32.c	1.15    -> 1.16   
#	drivers/s390/cio/blacklist.c	1.1     -> 1.2    
#	arch/s390x/mm/fault.c	1.9     -> 1.10   
#	drivers/s390/misc/chandev.c	1.9     -> 1.10   
#	drivers/s390/Makefile	1.8     -> 1.9    
#	include/asm-s390x/debug.h	1.5     -> 1.6    
#	include/asm-s390/pgalloc.h	1.7     -> 1.8    
#	arch/s390/mm/fault.c	1.8     -> 1.9    
#	drivers/s390/cio/s390io.c	1.1     -> 1.2    
#	include/asm-s390x/system.h	1.5     -> 1.6    
#	arch/s390x/kernel/linux32.h	1.2     -> 1.3    
#	drivers/s390/cio/cio.c	1.1     -> 1.2    
#	drivers/s390/char/ctrlchar.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	arnd@bergmann-dalldorf.de	1.683.1.5
# trivial fixes to keep s390 arch working
# --------------------------------------------
#
diff -Nru a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
--- a/arch/s390/mm/fault.c	Tue Jul 23 18:53:49 2002
+++ b/arch/s390/mm/fault.c	Tue Jul 23 18:53:49 2002
@@ -234,16 +234,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
+	default:
+		BUG();
 	}
 
         up_read(&mm->mmap_sem);
diff -Nru a/arch/s390x/kernel/linux32.c b/arch/s390x/kernel/linux32.c
--- a/arch/s390x/kernel/linux32.c	Tue Jul 23 18:53:49 2002
+++ b/arch/s390x/kernel/linux32.c	Tue Jul 23 18:53:49 2002
@@ -514,16 +514,15 @@
 	if (!p)
 		return -ENOMEM;
 
+	err = -EINVAL;
 	if (second > MSGMAX || first < 0 || second < 0)
-		return -EINVAL;
+		goto out;
 
 	err = -EFAULT;
 	if (!uptr)
 		goto out;
-
-	err = get_user (p->mtype, &up->mtype);
-	err |= __copy_from_user (p->mtext, &up->mtext, second);
-	if (err)
+        if (get_user (p->mtype, &up->mtype) ||
+	    __copy_from_user (p->mtext, &up->mtext, second))
 		goto out;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
diff -Nru a/arch/s390x/kernel/linux32.h b/arch/s390x/kernel/linux32.h
--- a/arch/s390x/kernel/linux32.h	Tue Jul 23 18:53:49 2002
+++ b/arch/s390x/kernel/linux32.h	Tue Jul 23 18:53:49 2002
@@ -8,8 +8,6 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/export.h>
 
-#ifdef CONFIG_S390_SUPPORT
-
 /* Macro that masks the high order bit of an 32 bit pointer and converts it*/
 /*       to a 64 bit pointer */
 #define A(__x) ((unsigned long)((__x) & 0x7FFFFFFFUL))
@@ -241,6 +239,4 @@
 	sigset_t32		uc_sigmask;	/* mask last for extensibility */
 };
 
-#endif /* !CONFIG_S390_SUPPORT */
- 
 #endif /* _ASM_S390X_S390_H */
diff -Nru a/arch/s390x/mm/fault.c b/arch/s390x/mm/fault.c
--- a/arch/s390x/mm/fault.c	Tue Jul 23 18:53:49 2002
+++ b/arch/s390x/mm/fault.c	Tue Jul 23 18:53:49 2002
@@ -234,16 +234,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
+	default:
+		BUG();
 	}
 
         up_read(&mm->mmap_sem);
diff -Nru a/drivers/s390/Makefile b/drivers/s390/Makefile
--- a/drivers/s390/Makefile	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/Makefile	Tue Jul 23 18:53:49 2002
@@ -7,6 +7,6 @@
 obj-$(CONFIG_QDIO) += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ cio/
+obj-y += cio/ block/ char/ misc/ net/
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
--- a/drivers/s390/char/ctrlchar.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/char/ctrlchar.c	Tue Jul 23 18:53:49 2002
@@ -26,7 +26,7 @@
 
 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif
 
diff -Nru a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
--- a/drivers/s390/cio/blacklist.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/cio/blacklist.c	Tue Jul 23 18:53:49 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.5 $
+ *   $Revision: 1.6 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -243,10 +243,10 @@
 		return -EFAULT;
 	}
 	buf[user_len] = '\0';
-
+#if 0
 	CIO_DEBUG(KERN_DEBUG, 2, 
 		  "/proc/cio_ignore: '%s'\n", buf);
-
+#endif
 	blacklist_parse_proc_parameters (buf);
 
 	vfree (buf);
diff -Nru a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
--- a/drivers/s390/cio/cio.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/cio/cio.c	Tue Jul 23 18:53:49 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.15 $
+ *   $Revision: 1.17 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *                            IBM Corporation
@@ -52,7 +52,7 @@
 	}
 	DBG ("%s\n", buffer);
 	if (cio_debug_initialized) 
-		debug_text_event (cio_debug_trace_id, level, buffer);
+		debug_text_event (cio_debug_msg_id, level, buffer);
 }
 
 
@@ -1448,7 +1448,7 @@
 	
 	ioinfo[irq]->devstat.intparm = 0;
 	
-	if (!ioinfo[irq]->ui.flags.s_pend) 
+	if (!(ioinfo[irq]->ui.flags.s_pend || ioinfo[irq]->ui.flags.repnone))
 		ioinfo[irq]->irq_desc.handler (irq, udp, NULL);
 	
 	return 1;
diff -Nru a/drivers/s390/cio/s390io.c b/drivers/s390/cio/s390io.c
--- a/drivers/s390/cio/s390io.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/cio/s390io.c	Tue Jul 23 18:53:49 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/s390io.c
  *   S/390 common I/O routines
- *   $Revision: 1.11 $
+ *   $Revision: 1.12 $
  *
  *  S390 version
  *    Copyright (C) 1999, 2000 IBM Deutschland Entwicklung GmbH,
@@ -1910,12 +1910,19 @@
 
 				ret = 0;
 
-			} else {
+			} else if (ret == -ENODEV) {
 
 				CIO_DEBUG(KERN_ERR, 2,
-					  "PathVerification(%04X) - "
-					  "Unexpected error on device %04X\n",
+					  "PathVerification(%04X) "
+					  "- Device %04X is no longer there?!?\n",
 					  irq, ioinfo[irq]->schib.pmcw.dev);
+
+			} else if (ret) {
+
+				CIO_DEBUG(KERN_ERR, 2,
+					  "PathVerification(%04X) - "
+					  "Unexpected error %d on device %04X\n",
+					  irq, ret, ioinfo[irq]->schib.pmcw.dev);
 				
 				ioinfo[irq]->ui.flags.pgid_supp = 0;
 			}
diff -Nru a/drivers/s390/misc/chandev.c b/drivers/s390/misc/chandev.c
--- a/drivers/s390/misc/chandev.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/misc/chandev.c	Tue Jul 23 18:53:49 2002
@@ -24,6 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
+#include <linux/tqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
diff -Nru a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c	Tue Jul 23 18:53:49 2002
+++ b/drivers/s390/net/lcs.c	Tue Jul 23 18:53:49 2002
@@ -124,6 +124,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <asm/system.h>
diff -Nru a/include/asm-s390/debug.h b/include/asm-s390/debug.h
--- a/include/asm-s390/debug.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390/debug.h	Tue Jul 23 18:53:49 2002
@@ -160,7 +160,8 @@
 }
 
 extern debug_entry_t *
-debug_sprintf_event(debug_info_t* id,int level,char *string,...);
+debug_sprintf_event(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 
 extern inline debug_entry_t* 
@@ -195,7 +196,8 @@
 
 
 extern debug_entry_t *
-debug_sprintf_exception(debug_info_t* id,int level,char *string,...);
+debug_sprintf_exception(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 int debug_register_view(debug_info_t* id, struct debug_view* view);
 int debug_unregister_view(debug_info_t* id, struct debug_view* view);
diff -Nru a/include/asm-s390/param.h b/include/asm-s390/param.h
--- a/include/asm-s390/param.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390/param.h	Tue Jul 23 18:53:49 2002
@@ -9,6 +9,12 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
+#ifdef __KERNEL__
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+#endif
+
 #ifndef HZ
 #define HZ 100
 #endif
@@ -24,9 +30,5 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
 
 #endif
diff -Nru a/include/asm-s390/pgalloc.h b/include/asm-s390/pgalloc.h
--- a/include/asm-s390/pgalloc.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390/pgalloc.h	Tue Jul 23 18:53:49 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -Nru a/include/asm-s390x/debug.h b/include/asm-s390x/debug.h
--- a/include/asm-s390x/debug.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390x/debug.h	Tue Jul 23 18:53:49 2002
@@ -160,7 +160,8 @@
 }
 
 extern debug_entry_t *
-debug_sprintf_event(debug_info_t* id,int level,char *string,...);
+debug_sprintf_event(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 
 extern inline debug_entry_t* 
@@ -195,7 +196,8 @@
 
 
 extern debug_entry_t *
-debug_sprintf_exception(debug_info_t* id,int level,char *string,...);
+debug_sprintf_exception(debug_info_t* id,int level,char *string,...)
+	__attribute__ ((format(printf, 3, 4)));
 
 int debug_register_view(debug_info_t* id, struct debug_view* view);
 int debug_unregister_view(debug_info_t* id, struct debug_view* view);
diff -Nru a/include/asm-s390x/param.h b/include/asm-s390x/param.h
--- a/include/asm-s390x/param.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390x/param.h	Tue Jul 23 18:53:49 2002
@@ -9,11 +9,14 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
-#ifndef HZ
-#define HZ 100
 #ifdef __KERNEL__
-#define hz_to_std(a) (a)
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
+
+#ifndef HZ
+#define HZ 100
 #endif
 
 #define EXEC_PAGESIZE	4096
@@ -28,8 +31,4 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
-                                 
 #endif
diff -Nru a/include/asm-s390x/pgalloc.h b/include/asm-s390x/pgalloc.h
--- a/include/asm-s390x/pgalloc.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390x/pgalloc.h	Tue Jul 23 18:53:49 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -Nru a/include/asm-s390x/system.h b/include/asm-s390x/system.h
--- a/include/asm-s390x/system.h	Tue Jul 23 18:53:49 2002
+++ b/include/asm-s390x/system.h	Tue Jul 23 18:53:49 2002
@@ -23,7 +23,7 @@
 #define prepare_arch_switch(rq)			do { } while (0)
 #define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next),last do {					     \
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
