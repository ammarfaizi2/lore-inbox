Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbRLBPJq>; Sun, 2 Dec 2001 10:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282898AbRLBPJi>; Sun, 2 Dec 2001 10:09:38 -0500
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:58613 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282895AbRLBPJ2>; Sun, 2 Dec 2001 10:09:28 -0500
Message-ID: <3C0A4422.E1578205@mandrakesoft.com>
Date: Sun, 02 Dec 2001 10:09:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.17.2: CONFIG_FINAL, a different take
Content-Type: multipart/mixed;
 boundary="------------BE19C7C593B8F2D7B76F086E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BE19C7C593B8F2D7B76F086E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

With no code changes but unrelated bugfixes, this patch shaves 18882
bytes off my vmlinux on-disk image size.

> [jgarzik@rum linux-final]$ ls -l vmlinux* arch/i386/boot/bzImage*
> -rw-r--r--    1 jgarzik  jgarzik   1030274 Dec  2 09:56 arch/i386/boot/bzImage
> -rw-r--r--    1 jgarzik  jgarzik   1032676 Dec  2 09:51 arch/i386/boot/bzImage.cfgfinal
> -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 09:56 vmlinux*
> -rwxr-xr-x    1 jgarzik  jgarzik   2796884 Dec  2 09:51 vmlinux.cfgfinal*

subsystems convert: linux/arch/i386/kernel, tulip, ext2, reiserfs,
linux/kernel, ipv4 and ipv6.

Unlike the previous version of this patch, there is no 'KSTATIC' or
similar.  This is extremely minimal impact patch.  There would be no
code changes at all, except for the fact that existing code bugs, which
only show up when built this way, need to be fixed.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------BE19C7C593B8F2D7B76F086E
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/arch/i386/config.in linux-final/arch/i386/config.in
--- linux-2.4.17-pre2/arch/i386/config.in	Sat Dec  1 04:15:59 2001
+++ linux-final/arch/i386/config.in	Sun Dec  2 13:41:55 2001
@@ -409,4 +409,6 @@
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
+bool 'Memory-intensive final production compile' CONFIG_FINAL
+
 endmenu
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/arch/i386/kernel/Makefile linux-final/arch/i386/kernel/Makefile
--- linux-2.4.17-pre2/arch/i386/kernel/Makefile	Fri Nov  9 22:21:21 2001
+++ linux-final/arch/i386/kernel/Makefile	Sun Dec  2 14:45:29 2001
@@ -14,12 +14,18 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o
+
+ifdef CONFIG_FINAL
+obj-y		:= i386_all.o entry.o
+export-objs     += i386_all.o
+else
+export-objs     += i386_ksyms.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
-
+endif
 
 ifdef CONFIG_PCI
 obj-y			+= pci-i386.o
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/arch/i386/kernel/i386_all.c linux-final/arch/i386/kernel/i386_all.c
--- linux-2.4.17-pre2/arch/i386/kernel/i386_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/arch/i386/kernel/i386_all.c	Sun Dec  2 14:45:33 2001
@@ -0,0 +1,18 @@
+#include "bluesmoke.c"
+#include "dmi_scan.c"
+#include "i386_ksyms.c"
+#include "i387.c"
+#include "i8259.c"
+#include "ioport.c"
+#include "irq.c"
+#include "ldt.c"
+#include "pci-dma.c"
+#include "process.c"
+#include "ptrace.c"
+#include "semaphore.c"
+#include "setup.c"
+#include "signal.c"
+#include "sys_i386.c"
+#include "time.c"
+#include "traps.c"
+#include "vm86.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/drivers/net/tulip/Makefile linux-final/drivers/net/tulip/Makefile
--- linux-2.4.17-pre2/drivers/net/tulip/Makefile	Fri Nov  9 21:45:35 2001
+++ linux-final/drivers/net/tulip/Makefile	Sun Dec  2 14:06:37 2001
@@ -9,9 +9,14 @@
 
 O_TARGET := tulip.o
 
+ifdef CONFIG_FINAL
+obj-y := tulip_all.o
+else
 obj-y   := eeprom.o interrupt.o media.o \
 	   timer.o tulip_core.o		\
 	   21142.o pnic.o pnic2.o
+endif
+
 obj-m   := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/drivers/net/tulip/tulip_all.c linux-final/drivers/net/tulip/tulip_all.c
--- linux-2.4.17-pre2/drivers/net/tulip/tulip_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/drivers/net/tulip/tulip_all.c	Sun Dec  2 14:06:20 2001
@@ -0,0 +1,8 @@
+#include "21142.c"
+#include "eeprom.c"
+#include "interrupt.c"
+#include "media.c"
+#include "pnic2.c"
+#include "pnic.c"
+#include "timer.c"
+#include "tulip_core.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/Makefile linux-final/fs/ext2/Makefile
--- linux-2.4.17-pre2/fs/ext2/Makefile	Thu Oct 11 15:05:18 2001
+++ linux-final/fs/ext2/Makefile	Sun Dec  2 13:56:02 2001
@@ -9,8 +9,13 @@
 
 O_TARGET := ext2.o
 
+ifdef CONFIG_FINAL
+obj-y := ext2_all.o
+else
 obj-y    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 		ioctl.o namei.o super.o symlink.o
+endif
+
 obj-m    := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/ext2/ext2_all.c linux-final/fs/ext2/ext2_all.c
--- linux-2.4.17-pre2/fs/ext2/ext2_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/fs/ext2/ext2_all.c	Sun Dec  2 13:55:36 2001
@@ -0,0 +1,11 @@
+#include "balloc.c"
+#include "bitmap.c"
+#include "dir.c"
+#include "file.c"
+#include "fsync.c"
+#include "ialloc.c"
+#include "inode.c"
+#include "ioctl.c"
+#include "namei.c"
+#include "super.c"
+#include "symlink.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/reiserfs/Makefile linux-final/fs/reiserfs/Makefile
--- linux-2.4.17-pre2/fs/reiserfs/Makefile	Wed Nov 21 17:56:28 2001
+++ linux-final/fs/reiserfs/Makefile	Sun Dec  2 14:03:43 2001
@@ -8,8 +8,13 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := reiserfs.o
+
+ifdef CONFIG_FINAL
+obj-y := reiserfs_all.o
+else
 obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
 lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o version.o item_ops.o ioctl.o procfs.o
+endif
 
 obj-m   := $(O_TARGET)
 
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/reiserfs/reiserfs_all.c linux-final/fs/reiserfs/reiserfs_all.c
--- linux-2.4.17-pre2/fs/reiserfs/reiserfs_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/fs/reiserfs/reiserfs_all.c	Sun Dec  2 14:13:02 2001
@@ -0,0 +1,22 @@
+#include "bitmap.c"
+#include "buffer2.c"
+#include "dir.c"
+#include "do_balan.c"
+#include "file.c"
+#include "fix_node.c"
+#include "hashes.c"
+#include "ibalance.c"
+#include "inode.c"
+#include "ioctl.c"
+#include "item_ops.c"
+#include "journal.c"
+#include "lbalance.c"
+#include "namei.c"
+#include "objectid.c"
+#include "prints.c"
+#include "procfs.c"
+#include "resize.c"
+#include "stree.c"
+#include "super.c"
+#include "tail_conversion.c"
+#include "version.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/fs/reiserfs/version.c linux-final/fs/reiserfs/version.c
--- linux-2.4.17-pre2/fs/reiserfs/version.c	Mon Jan 15 20:42:32 2001
+++ linux-final/fs/reiserfs/version.c	Sun Dec  2 14:19:33 2001
@@ -2,6 +2,6 @@
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  */
 
-char *reiserfs_get_version_string(void) {
+const char *reiserfs_get_version_string(void) {
   return "ReiserFS version 3.6.25" ;
 }
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/include/linux/reiserfs_fs.h linux-final/include/linux/reiserfs_fs.h
--- linux-2.4.17-pre2/include/linux/reiserfs_fs.h	Fri Nov  9 22:18:25 2001
+++ linux-final/include/linux/reiserfs_fs.h	Sun Dec  2 14:19:28 2001
@@ -2089,7 +2089,7 @@
 __u32 r5_hash (const signed char *msg, int len);
 
 /* version.c */
-const char *reiserfs_get_version_string(void) CONSTF;
+const char *reiserfs_get_version_string(void);
 
 /* the ext2 bit routines adjust for big or little endian as
 ** appropriate for the arch, so in our laziness we use them rather
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/include/linux/sched.h linux-final/include/linux/sched.h
--- linux-2.4.17-pre2/include/linux/sched.h	Thu Nov 22 19:46:19 2001
+++ linux-final/include/linux/sched.h	Sun Dec  2 13:54:25 2001
@@ -589,7 +589,7 @@
 extern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
 						    signed long timeout));
-extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern inline int FASTCALL(wake_up_process(struct task_struct * tsk));
 
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/include/linux/sysrq.h linux-final/include/linux/sysrq.h
--- linux-2.4.17-pre2/include/linux/sysrq.h	Sun Sep 30 19:26:42 2001
+++ linux-final/include/linux/sysrq.h	Sun Dec  2 14:02:32 2001
@@ -10,6 +10,8 @@
  *	overhauled to use key registration
  *	based upon discusions in irc://irc.openprojects.net/#kernelnewbies
  */
+#ifndef __LINUX_SYSRQ_H__
+#define __LINUX_SYSRQ_H__
 
 #include <linux/config.h>
 
@@ -117,3 +119,5 @@
 #else
 #define CHECK_EMERGENCY_SYNC
 #endif
+
+#endif /* __LINUX_SYSRQ_H__ */
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/kernel/Makefile linux-final/kernel/Makefile
--- linux-2.4.17-pre2/kernel/Makefile	Mon Sep 17 04:22:40 2001
+++ linux-final/kernel/Makefile	Sun Dec  2 13:51:51 2001
@@ -9,12 +9,17 @@
 
 O_TARGET := kernel.o
 
+ifdef CONFIG_FINAL
+export-objs = kernel_all.o ksyms.o pm.o
+obj-y = kernel_all.o
+else
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o
+endif
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/kernel/kernel_all.c linux-final/kernel/kernel_all.c
--- linux-2.4.17-pre2/kernel/kernel_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/kernel/kernel_all.c	Sun Dec  2 13:54:37 2001
@@ -0,0 +1,23 @@
+#include "acct.c"
+#include "capability.c"
+#include "context.c"
+#include "dma.c"
+#include "exec_domain.c"
+#include "exit.c"
+#include "fork.c"
+#include "info.c"
+#include "itimer.c"
+#include "kmod.c"
+#include "module.c"
+#include "panic.c"
+#include "printk.c"
+#include "ptrace.c"
+#include "resource.c"
+#include "sched.c"
+#include "signal.c"
+#include "softirq.c"
+#include "sys.c"
+#include "sysctl.c"
+#include "time.c"
+#include "timer.c"
+#include "user.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/kernel/sysctl.c linux-final/kernel/sysctl.c
--- linux-2.4.17-pre2/kernel/sysctl.c	Mon Nov 26 13:29:17 2001
+++ linux-final/kernel/sysctl.c	Sun Dec  2 13:43:55 2001
@@ -45,7 +45,8 @@
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
 extern int max_threads;
-extern int nr_queued_signals, max_queued_signals;
+extern atomic_t nr_queued_signals;
+extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv4/Makefile linux-final/net/ipv4/Makefile
--- linux-2.4.17-pre2/net/ipv4/Makefile	Tue Oct 30 23:08:12 2001
+++ linux-final/net/ipv4/Makefile	Sun Dec  2 14:22:51 2001
@@ -11,12 +11,16 @@
 
 export-objs = ipip.o ip_gre.o
 
+ifdef CONFIG_FINAL
+obj-y := ipv4_all.o
+else
 obj-y     := utils.o route.o inetpeer.o proc.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
 	     raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o
+endif
 
 obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
 obj-$(CONFIG_IP_ROUTE_NAT) += ip_nat_dumb.o
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv4/ip_output.c linux-final/net/ipv4/ip_output.c
--- linux-2.4.17-pre2/net/ipv4/ip_output.c	Wed Oct 17 21:16:39 2001
+++ linux-final/net/ipv4/ip_output.c	Sun Dec  2 14:27:07 2001
@@ -40,6 +40,7 @@
  *		Detlev Wengorz	:	Copy protocol for fragments.
  */
 
+#include <linux/config.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/types.h>
@@ -110,11 +111,13 @@
 
 /* Don't just hand NF_HOOK skb->dst->output, in case netfilter hook
    changes route */
+#ifndef CONFIG_FINAL
 static inline int
 output_maybe_reroute(struct sk_buff *skb)
 {
 	return skb->dst->output(skb);
 }
+#endif
 
 /* 
  *		Add an ip header to a skbuff and send it out.
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv4/ipv4_all.c linux-final/net/ipv4/ipv4_all.c
--- linux-2.4.17-pre2/net/ipv4/ipv4_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/net/ipv4/ipv4_all.c	Sun Dec  2 14:24:39 2001
@@ -0,0 +1,28 @@
+#include "af_inet.c"
+#include "arp.c"
+#include "devinet.c"
+#include "fib_frontend.c"
+#include "fib_hash.c"
+#include "fib_semantics.c"
+#include "icmp.c"
+#include "igmp.c"
+#include "inetpeer.c"
+#include "ip_forward.c"
+#include "ip_fragment.c"
+#include "ip_input.c"
+#include "ip_options.c"
+#include "ip_output.c"
+#include "ip_sockglue.c"
+#include "proc.c"
+#include "protocol.c"
+#include "raw.c"
+#include "route.c"
+#include "sysctl_net_ipv4.c"
+#include "tcp.c"
+#include "tcp_input.c"
+#include "tcp_ipv4.c"
+#include "tcp_minisocks.c"
+#include "tcp_output.c"
+#include "tcp_timer.c"
+#include "udp.c"
+#include "utils.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv6/Makefile linux-final/net/ipv6/Makefile
--- linux-2.4.17-pre2/net/ipv6/Makefile	Fri Dec 29 22:07:24 2000
+++ linux-final/net/ipv6/Makefile	Sun Dec  2 14:29:07 2001
@@ -9,11 +9,15 @@
 
 O_TARGET := ipv6.o
 
+ifdef CONFIG_FINAL
+obj-y := ipv6_all.o
+else
 obj-y :=	af_inet6.o ip6_output.o ip6_input.o addrconf.o sit.o \
 		route.o ip6_fib.o ipv6_sockglue.o ndisc.o udp.o raw.o \
 		protocol.o icmp.o mcast.o reassembly.o tcp_ipv6.o \
 		exthdrs.o sysctl_net_ipv6.o datagram.o proc.o \
 		ip6_flowlabel.o
+endif
 
 obj-m  := $(O_TARGET)
 
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv6/ipv6_all.c linux-final/net/ipv6/ipv6_all.c
--- linux-2.4.17-pre2/net/ipv6/ipv6_all.c	Thu Jan  1 00:00:00 1970
+++ linux-final/net/ipv6/ipv6_all.c	Sun Dec  2 14:30:43 2001
@@ -0,0 +1,21 @@
+#include "addrconf.c"
+#include "af_inet6.c"
+#include "datagram.c"
+#include "exthdrs.c"
+#include "icmp.c"
+#include "ip6_fib.c"
+#include "ip6_flowlabel.c"
+#include "ip6_input.c"
+#include "ip6_output.c"
+#include "ipv6_sockglue.c"
+#include "mcast.c"
+#include "ndisc.c"
+#include "proc.c"
+#include "protocol.c"
+#include "raw.c"
+#include "reassembly.c"
+#include "route.c"
+#include "sit.c"
+#include "sysctl_net_ipv6.c"
+#include "tcp_ipv6.c"
+#include "udp.c"
diff -Naur -X /g/g/lib/dontdiff linux-2.4.17-pre2/net/ipv6/proc.c linux-final/net/ipv6/proc.c
--- linux-2.4.17-pre2/net/ipv6/proc.c	Mon Jul 10 05:30:41 2000
+++ linux-final/net/ipv6/proc.c	Sun Dec  2 14:33:35 2001
@@ -37,7 +37,7 @@
 	return res;
 }
 
-int afinet6_get_info(char *buffer, char **start, off_t offset, int length, int dummy)
+int afinet6_get_info(char *buffer, char **start, off_t offset, int length)
 {
 	int len = 0;
 	len += sprintf(buffer+len, "TCP6: inuse %d\n",

--------------BE19C7C593B8F2D7B76F086E--


