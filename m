Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318004AbSFSUxH>; Wed, 19 Jun 2002 16:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSFSUxG>; Wed, 19 Jun 2002 16:53:06 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:19577 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S318004AbSFSUxD>; Wed, 19 Jun 2002 16:53:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "Wed, 19 Jun 2002 09:28:40 MST."
             <Pine.LNX.4.44.0206190907520.2053-100000@home.transmeta.com> 
Date: Thu, 20 Jun 2002 06:57:14 +1000
Message-Id: <E17KmVu-0002SR-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206190907520.2053-100000@home.transmeta.com> you wri
te:
> 
> 
> On Thu, 20 Jun 2002, Rusty Russell wrote:
> > > and then add a few simple operations like
> > >
> > > 	cpumask_and(cpu_mask_t * res, cpu_mask_t *a, cpu_mask_t *b);
> >
> > Sure... or just make all archs supply a "cpus_online_of(mask)" which
> > does that, unless there are other interesting cases.  Or we can go the
> > other way and have a general "and_region(void *res, void *a, void *b,
> > int len)".  Which one do you want?
> 
> There are definitely other "interesting" cases that already do the full
> bitwise and/or on bitmasks - see sigset_t and sigaddset/sigdelset/
> sigfillset. It's really the exact same code, and the exact same issues.
> 
> The problem with a generic "and_region" is that it's a slight amount of
> work to make sure that we optimize for the common cases (and since I'm not
> a huge believer in hundreds of nodes, I consider the common case to be a
> single word). And do things like just automatically get the UP case right:
> which we do right now by just virtue of having a constant cpu_online_mask,
> and letting the compiler just do the (obvious) optimizations.

Sure, completely agreed.

Normal tricks here: 1 long turns into equivalent to dst = a & b, the
other cases are handled with varying amount of suckiness.  Code and
optimization tested on 2.95.4 and 3.0.4 (both PPC), kernel compiled on
my x86 box back in .au.

> It would probably make sense to make a real <linux/bitmap.h>, move the
> bitmap_member() there (and rename to "bitmap_declare()" - it's called
> member because all the places I first looked at were structure members),
> and add some simple generic routines for handling these things.

I renamed it to DECLARE_BITMAP() to match list, mutex et al. and moved
it to linux/bitops.h.

PS. Please sort out merging with Paulus's stuff: I'd like to compile
    on PPC soon since I'm laptop-only for two more weeks 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/linux/bitops.h working-2.5.23-bitops/include/linux/bitops.h
--- linux-2.5.23/include/linux/bitops.h	Fri Jun  7 13:59:07 2002
+++ working-2.5.23-bitops/include/linux/bitops.h	Thu Jun 20 06:55:51 2002
@@ -2,6 +2,27 @@
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
 
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+
+#ifndef HAVE_ARCH_AND_REGION
+void __and_region(unsigned long num, unsigned char *dst,
+		  const unsigned char *a, const unsigned char *b);
+#endif
+
+/* For the moment, handle 1 long case fast, leave rest to __and_region. */
+#define and_region(num,dst,a,b)						     \
+do {									     \
+	if (__alignof__(*(a)) == __alignof__(long)			     \
+	    && __alignof__(*(b)) == __alignof__(long)			     \
+	    && __builtin_constant_p(num)				     \
+	    && (num) == sizeof(long)) {					     \
+		    *((unsigned long *)(dst)) =				     \
+			    (*(unsigned long *)(a) & *(unsigned long *)(b)); \
+	} else								     \
+		__and_region((num), (void*)(dst), (void*)(a), (void*)(b));   \
+} while(0)
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -106,8 +127,5 @@
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
-
-#include <asm/bitops.h>
-
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/linux/types.h working-2.5.23-bitops/include/linux/types.h
--- linux-2.5.23/include/linux/types.h	Mon Jun 17 23:19:25 2002
+++ working-2.5.23-bitops/include/linux/types.h	Thu Jun 20 06:14:39 2002
@@ -3,9 +3,6 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define bitmap_member(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 #endif
 
 #include <linux/posix_types.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/sound/ac97_codec.h working-2.5.23-bitops/include/sound/ac97_codec.h
--- linux-2.5.23/include/sound/ac97_codec.h	Mon Jun 17 23:19:25 2002
+++ working-2.5.23-bitops/include/sound/ac97_codec.h	Thu Jun 20 06:31:35 2002
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include "control.h"
 #include "info.h"
 
@@ -160,7 +161,7 @@
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
-	bitmap_member(reg_accessed, 0x80); /* bit flags */
+	DECLARE_BITMAP(reg_accessed, 0x80); /* bit flags */
 	union {			/* vendor specific code */
 		struct {
 			unsigned short unchained[3];	// 0 = C34, 1 = C79, 2 = C69
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/kernel/Makefile working-2.5.23-bitops/kernel/Makefile
--- linux-2.5.23/kernel/Makefile	Mon Jun 10 16:03:56 2002
+++ working-2.5.23-bitops/kernel/Makefile	Thu Jun 20 06:27:29 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o bitops.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o bitops.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/kernel/bitops.c working-2.5.23-bitops/kernel/bitops.c
--- linux-2.5.23/kernel/bitops.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.23-bitops/kernel/bitops.c	Thu Jun 20 06:52:29 2002
@@ -0,0 +1,32 @@
+#include <linux/config.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+
+#ifndef HAVE_ARCH_AND_REGION
+/* Generic is fairly stupid: archs should optimize properly. */
+void __and_region(unsigned long num, unsigned char *dst,
+		  const unsigned char *a, const unsigned char *b)
+{
+	unsigned long i;
+
+	/* Copy first bytes, until one is long aligned. */
+	for (i = 0; i < num && ((unsigned long)a+i) % __alignof__(long); i++)
+		dst[i] = (a[i] & b[i]);
+
+	/* If they are all aligned, do long-at-a-time copy */
+	if (((unsigned long)b+i)%__alignof__(long) == 0
+	    && ((unsigned long)dst+i)%__alignof__(long) == 0) {
+		for (; i + sizeof(long) <= num; i += sizeof(long)) {
+			*(unsigned long *)(dst+i)
+				= (*(unsigned long *)(a+i)
+				   & *(unsigned long *)(b+i));
+		}
+	}
+
+	/* Do whatever is left. */
+	for (; i < num; i++)
+		dst[i] = (a[i] & b[i]);
+}
+
+EXPORT_SYMBOL(__and_region);
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/sound/core/seq/seq_clientmgr.h working-2.5.23-bitops/sound/core/seq/seq_clientmgr.h
--- linux-2.5.23/sound/core/seq/seq_clientmgr.h	Mon Jun 17 23:19:26 2002
+++ working-2.5.23-bitops/sound/core/seq/seq_clientmgr.h	Thu Jun 20 06:34:16 2002
@@ -53,8 +53,8 @@
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
-	bitmap_member(client_filter, 256);
-	bitmap_member(event_filter, 256);
+	DECLARE_BITMAP(client_filter, 256);
+	DECLARE_BITMAP(event_filter, 256);
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/sound/core/seq/seq_queue.h working-2.5.23-bitops/sound/core/seq/seq_queue.h
--- linux-2.5.23/sound/core/seq/seq_queue.h	Mon Jun 17 23:19:26 2002
+++ working-2.5.23-bitops/sound/core/seq/seq_queue.h	Thu Jun 20 06:34:11 2002
@@ -26,6 +26,7 @@
 #include "seq_lock.h"
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 
 #define SEQ_QUEUE_NO_OWNER (-1)
 
@@ -51,7 +52,7 @@
 	spinlock_t check_lock;
 
 	/* clients which uses this queue (bitmap) */
-	bitmap_member(clients_bitmap,SNDRV_SEQ_MAX_CLIENTS);
+	DECLARE_BITMAP(clients_bitmap,SNDRV_SEQ_MAX_CLIENTS);
 	unsigned int clients;	/* users of this queue */
 	struct semaphore timer_mutex;
 
