Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317901AbSGKTze>; Thu, 11 Jul 2002 15:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317902AbSGKTzd>; Thu, 11 Jul 2002 15:55:33 -0400
Received: from stingr.net ([212.193.32.15]:33689 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S317901AbSGKTzb>;
	Thu, 11 Jul 2002 15:55:31 -0400
Date: Thu, 11 Jul 2002 23:58:16 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Small fixes for -rc1 kernel
Message-ID: <20020711195816.GA2280@stingr.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to repeat myself.

But Marcelo seems to ignore this from me so maybe from yours ...

1. (found using kbuild 2.5) when binfmt_elf is in module, it won't load due
   to unresolved symbols. Two solutions - remove M choice or export symbols.
   I dunno how much will be broken by making elf modular ...

2. Long lasting issue with wan/comx and proc_get_inode

3. disable_ide_dma in dmi_scan unused now

4. undeclared function

5. unused locals

6. unused label


Next will be -ac specific part ...

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.4.19-rc1 -> 1.558  
#	drivers/char/ip2/i2ellis.h	1.2     -> 1.3    
#	    fs/proc/Makefile	1.2     -> 1.3    
#	arch/i386/kernel/Makefile	1.3     -> 1.4    
#	        fs/dnotify.c	1.3     -> 1.4    
#	     fs/proc/inode.c	1.5     -> 1.6    
#	arch/i386/kernel/dmi_scan.c	1.21    -> 1.22   
#	arch/i386/kernel/smpboot.c	1.9     -> 1.10   
#	drivers/char/tpqic02.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/24	marcelo@plucky.distro.conectiva	1.552
# Makefile:
#   Changed EXTRAVERSION to -rc1
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.553
# Fix unresolved symbols in modular binfmt_elf
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.554
# Make drivers/net/wan/comx happy about proc_get_inode
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.555
# Disable disable_ide_dma - it is of no use for now and making gcc cry
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.556
# declare iiEllisCleanup before using and make gcc shut up about it
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.557
# Two unused local variables in tpqic02
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.558
# One unused local label in dnotify
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Thu Jul 11 23:38:30 2002
+++ b/arch/i386/kernel/Makefile	Thu Jul 11 23:38:30 2002
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o smpboot.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Thu Jul 11 23:38:30 2002
+++ b/arch/i386/kernel/dmi_scan.c	Thu Jul 11 23:38:30 2002
@@ -185,11 +185,15 @@
 #define NO_MATCH	{ NONE, NULL}
 #define MATCH(a,b)	{ a, b }
 
+#if 0
+
 /*
  *	We have problems with IDE DMA on some platforms. In paticular the
  *	KT7 series. On these it seems the newer BIOS has fixed them. The
  *	rule needs to be improved to match specific BIOS revisions with
  *	corruption problems
+ *
+ *	FIXME: Either remove or reenable (Stingray)
  */ 
  
 static __init int disable_ide_dma(struct dmi_blacklist *d)
@@ -204,6 +208,7 @@
 #endif	
 	return 0;
 }
+#endif
 
 /* 
  * Reboot options and system auto-detection code provided by
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Thu Jul 11 23:38:30 2002
+++ b/arch/i386/kernel/smpboot.c	Thu Jul 11 23:38:30 2002
@@ -33,6 +33,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/init.h>
 
 #include <linux/mm.h>
@@ -1222,3 +1223,5 @@
 smp_done:
 	zap_low_mappings();
 }
+
+EXPORT_SYMBOL(smp_num_siblings);
diff -Nru a/drivers/char/ip2/i2ellis.h b/drivers/char/ip2/i2ellis.h
--- a/drivers/char/ip2/i2ellis.h	Thu Jul 11 23:38:30 2002
+++ b/drivers/char/ip2/i2ellis.h	Thu Jul 11 23:38:30 2002
@@ -568,6 +568,7 @@
 // the board again (step 1 not needed).
 
 static void iiEllisInit(void);
+static void iiEllisCleanup(void);
 static int iiSetAddress(i2eBordStrPtr, int, delayFunc_t );
 static int iiReset(i2eBordStrPtr);
 static int iiResetDelay(i2eBordStrPtr);
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Thu Jul 11 23:38:30 2002
+++ b/drivers/char/tpqic02.c	Thu Jul 11 23:38:30 2002
@@ -1815,7 +1815,6 @@
 static ssize_t qic02_tape_read(struct file *filp, char *buf, size_t count,
 			       loff_t * ppos)
 {
-	int err;
 	kdev_t dev = filp->f_dentry->d_inode->i_rdev;
 	unsigned short flags = filp->f_flags;
 	unsigned long bytes_todo, bytes_done, total_bytes_done = 0;
@@ -2009,7 +2008,6 @@
 static ssize_t qic02_tape_write(struct file *filp, const char *buf,
 				size_t count, loff_t * ppos)
 {
-	int err;
 	kdev_t dev = filp->f_dentry->d_inode->i_rdev;
 	unsigned short flags = filp->f_flags;
 	unsigned long bytes_todo, bytes_done, total_bytes_done = 0;
diff -Nru a/fs/dnotify.c b/fs/dnotify.c
--- a/fs/dnotify.c	Thu Jul 11 23:38:30 2002
+++ b/fs/dnotify.c	Thu Jul 11 23:38:30 2002
@@ -135,7 +135,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
+
 	write_unlock(&dn_lock);
 }
 
diff -Nru a/fs/proc/Makefile b/fs/proc/Makefile
--- a/fs/proc/Makefile	Thu Jul 11 23:38:30 2002
+++ b/fs/proc/Makefile	Thu Jul 11 23:38:30 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := proc.o
 
-export-objs := root.o
+export-objs := root.o inode.o
 
 obj-y    := inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o kcore.o
diff -Nru a/fs/proc/inode.c b/fs/proc/inode.c
--- a/fs/proc/inode.c	Thu Jul 11 23:38:30 2002
+++ b/fs/proc/inode.c	Thu Jul 11 23:38:30 2002
@@ -14,6 +14,7 @@
 #include <linux/locks.h>
 #include <linux/limits.h>
 #define __NO_VERSION__
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 
@@ -174,7 +175,9 @@
 out_fail:
 	de_put(de);
 	goto out;
-}			
+}
+
+EXPORT_SYMBOL(proc_get_inode);
 
 struct super_block *proc_read_super(struct super_block *s,void *data, 
 				    int silent)



-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
