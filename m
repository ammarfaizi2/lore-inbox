Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319305AbSIEXIZ>; Thu, 5 Sep 2002 19:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319308AbSIEXIZ>; Thu, 5 Sep 2002 19:08:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319305AbSIEXH5>;
	Thu, 5 Sep 2002 19:07:57 -0400
Subject: [PATCH][2.4.20-pre5] non syscall gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-yPLDyyFyW+mJ8H7IWJjf"
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Sep 2002 16:12:33 -0700
Message-Id: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yPLDyyFyW+mJ8H7IWJjf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch implements a shared memory interface to allow
implementing gettimeofday (and other clock measurement) using the TSC
counter on i386.  On a 1.6G Xeon this reduces gettimeofday from 1.2 us
per call to .17 us per call.

The interface is through a /proc/tscinfo that is mmap'd by the library.
If the kernel doesn't have working TSC and/or has NUMA TSC problems then
the /proc file will not exist and the library should fall back to a
syscall.

Attachments:
	patch for 2.4.20-pre5
	sample library routine


--=-yPLDyyFyW+mJ8H7IWJjf
Content-Disposition: attachment; filename=ugettimeofday-2.4.20-pre5.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ugettimeofday-2.4.20-pre5.patch; charset=ISO-8859-1

diff -urN -X dontdiff linux-2.4/Documentation/magic-number.txt linux-2.4-vc=
lock/Documentation/magic-number.txt
--- linux-2.4/Documentation/magic-number.txt	Thu Aug 29 14:31:47 2002
+++ linux-2.4-vclock/Documentation/magic-number.txt	Fri Aug 30 13:37:35 200=
2
@@ -97,3 +97,4 @@
 SLAB_MAGIC_DESTROYED  0xb2f23c5a  kmem_slab_s       mm/slab.c
 STLI_PORTMAGIC        0xe671c7a1  stliport          include/linux/istallio=
n.h
 CCB_MAGIC             0xf2691ad2  ccb               drivers/scsi/ncr53c8xx=
.c
+TSCINFO_MAGIC         0x203854e0  tscinfo           include/linux/tscinfo.=
h
diff -urN -X dontdiff linux-2.4/arch/i386/kernel/Makefile linux-2.4-vclock/=
arch/i386/kernel/Makefile
--- linux-2.4/arch/i386/kernel/Makefile	Thu Aug 29 14:31:49 2002
+++ linux-2.4-vclock/arch/i386/kernel/Makefile	Fri Aug 30 14:55:50 2002
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+=3D mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+=3D io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+=3D visws_apic.o
+obj-$(CONFIG_X86_HAS_TSC)	+=3D tscinfo.o
=20
 include $(TOPDIR)/Rules.make
diff -urN -X dontdiff linux-2.4/arch/i386/kernel/time.c linux-2.4-vclock/ar=
ch/i386/kernel/time.c
--- linux-2.4/arch/i386/kernel/time.c	Thu Aug 29 14:31:49 2002
+++ linux-2.4-vclock/arch/i386/kernel/time.c	Tue Sep  3 13:52:22 2002
@@ -55,6 +55,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
 #include <linux/config.h>
+#include <linux/tscinfo.h>
=20
 #include <asm/fixmap.h>
 #include <asm/cobalt.h>
@@ -70,7 +71,7 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
=20
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
=20
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
@@ -84,6 +85,33 @@
=20
 spinlock_t rtc_lock =3D SPIN_LOCK_UNLOCKED;
=20
+extern struct timezone sys_tz;
+int use_tsc;
+
+static inline void update_tscinfo(unsigned long usec_delay,
+				  unsigned long lost,
+				  const struct timezone *tz)
+{
+#ifdef CONFIG_X86_HAS_TSC
+	extern struct tsc_info *tscinfo;
+
+	if (use_tsc && tscinfo) {
+		if (lost)
+			usec_delay +=3D lost * (1000000 / HZ);
+=09
+		tscinfo->pre_sequence++;=20
+		wmb();
+		tscinfo->last_tsc =3D last_tsc_low;
+		tscinfo->last_tv.tv_usec =3D usec_delay + xtime.tv_usec;
+		tscinfo->last_tv.tv_sec =3D xtime.tv_sec;
+		tscinfo->post_sequence++;
+		if (tz)
+			tscinfo->last_tz =3D *tz;
+		wmb();
+	}
+#endif
+}
+
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax, edx;
@@ -309,6 +337,11 @@
 	}
=20
 	xtime =3D *tv;
+
+	update_tscinfo(delay_at_last_interrupt,
+		       jiffies - wall_jiffies, &sys_tz);
+
+
 	time_adjust =3D 0;		/* stop active adjtime() */
 	time_status |=3D STA_UNSYNC;
 	time_maxerror =3D NTP_PHASE_LIMIT;
@@ -461,7 +494,6 @@
 #endif
 }
=20
-static int use_tsc;
=20
 /*
  * This is the same as the above, except we _also_ save the current
@@ -508,10 +540,18 @@
=20
 		count =3D ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt =3D (count + LATCH/2) / LATCH;
+
+
 	}
 =20
 	do_timer_interrupt(irq, NULL, regs);
=20
+	/*
+	 * Copy current time sample out to the mmap window
+	 */
+	update_tscinfo(delay_at_last_interrupt,
+		       jiffies - wall_jiffies, NULL);
+
 	write_unlock(&xtime_lock);
=20
 }
diff -urN -X dontdiff linux-2.4/arch/i386/kernel/tscinfo.c linux-2.4-vclock=
/arch/i386/kernel/tscinfo.c
--- linux-2.4/arch/i386/kernel/tscinfo.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4-vclock/arch/i386/kernel/tscinfo.c	Thu Sep  5 11:28:22 2002
@@ -0,0 +1,113 @@
+/*
+ *  linux/arch/i386/kernel/tscinfo.c
+ *
+ *  Copyright (C) 2002  by Stephen Hemminger <shemminger@osdl.org>
+ *  based on ideas by Andrea Arcangeli, and Ingo Molnar
+ *
+ *  Propogate kernel time of day and TSC information to allow constructing
+ *  gettimeofday and equivalent functions in user space without
+ *  a system call.
+ *
+ * Changes:
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/vmalloc.h>
+#include <linux/wrapper.h>
+
+#include <linux/tscinfo.h>
+
+struct tsc_info *tscinfo;
+
+extern unsigned long fast_gettimeoffset_quotient;
+extern unsigned long last_tsc_low;
+extern struct timezone sys_tz;
+extern rwlock_t xtime_lock;
+
+static inline unsigned long kvirt_to_pa(unsigned long adr)
+{
+	unsigned long kva, ret;
+
+	kva =3D (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |=3D adr & (PAGE_SIZE-1); /* restore the offset */
+	ret =3D __pa(kva);
+	return ret;
+}
+
+int tscinfo_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long len =3D vma->vm_end - vma->vm_start;
+	unsigned long pos =3D (unsigned long) tscinfo + offset;
+
+	if (!tscinfo)
+		return -ENODEV;
+
+	if ((offset + len) > PAGE_ALIGN(sizeof(*tscinfo)))
+		return -ENXIO;
+
+	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) =3D=3D (VM_SHARED|VM_WRITE)) {
+		printk("vsyscall: attempt to write to mapping\n");
+		return -EPERM;
+	}
+
+	if (remap_page_range(vma->vm_start, kvirt_to_pa(pos),
+			     len, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static struct file_operations tscinfo_operations =3D {
+	mmap:	tscinfo_mmap,
+};
+
+/* Initialize shared memory area and setup /proc entry  */
+void __init proc_tscinfo_init(void)
+{
+	struct proc_dir_entry *entry;
+	extern int use_tsc;
+	struct tsc_info *t;
+	unsigned long flags;
+=09
+	/* not using tsc's for time so don't create entry */
+	if (!use_tsc)
+		return;
+=09
+	/* NB: tsc_info will fit on single page */
+	t =3D (struct tsc_info *) vmalloc(sizeof(struct tsc_info));
+	if (!t)
+		return;
+=09
+	/* initial value can be off at first but corrected
+	   on next timer interrupt */
+	read_lock_irqsave(&xtime_lock, flags);
+	t->version_magic =3D TSCINFO_MAGIC;
+	t->cpu_khz =3D cpu_khz;
+	t->offset_quotient =3D fast_gettimeoffset_quotient;
+=09
+	t->last_tsc =3D last_tsc_low;
+	t->last_tv =3D xtime;
+	t->last_tz =3D sys_tz;
+	read_unlock_irqrestore(&xtime_lock, flags);
+
+	tscinfo =3D t;
+
+	entry =3D create_proc_entry("tscinfo", 0, NULL);
+	if (entry) {
+		entry->proc_fops =3D &tscinfo_operations;
+		entry->size =3D (size_t) sizeof(struct tsc_info);
+	}
+}
+
diff -urN -X dontdiff linux-2.4/fs/proc/root.c linux-2.4-vclock/fs/proc/roo=
t.c
--- linux-2.4/fs/proc/root.c	Thu Aug 29 14:32:08 2002
+++ linux-2.4-vclock/fs/proc/root.c	Fri Aug 30 14:59:10 2002
@@ -67,6 +67,9 @@
 #ifdef CONFIG_PPC_RTAS
 	proc_rtas_init();
 #endif
+#ifdef CONFIG_X86_HAS_TSC
+	proc_tscinfo_init();
+#endif
 	proc_bus =3D proc_mkdir("bus", 0);
 }
=20
diff -urN -X dontdiff linux-2.4/include/linux/proc_fs.h linux-2.4-vclock/in=
clude/linux/proc_fs.h
--- linux-2.4/include/linux/proc_fs.h	Fri Aug 30 09:35:48 2002
+++ linux-2.4-vclock/include/linux/proc_fs.h	Tue Sep  3 12:19:20 2002
@@ -133,6 +133,11 @@
 extern void proc_rtas_init(void);
=20
 /*
+ * i386/tscinfo.c
+ */
+extern void proc_tscinfo_init(void);
+
+/*
  * PPC64
  */=20
 extern void proc_ppc64_init(void);
diff -urN -X dontdiff linux-2.4/include/linux/tscinfo.h linux-2.4-vclock/in=
clude/linux/tscinfo.h
--- linux-2.4/include/linux/tscinfo.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4-vclock/include/linux/tscinfo.h	Tue Sep  3 13:48:37 2002
@@ -0,0 +1,23 @@
+#ifndef _LINUX_TSCINFO_H
+#define _LINUX_TSCINFO_H
+/*
+ * Export conversion information between current time and tsc values
+ */
+
+struct tsc_info {
+	unsigned long version_magic;	/* detect interface changes */
+	unsigned long pre_sequence;	/* detect changes while reading */
+	unsigned long post_sequence;
+
+	unsigned long cpu_khz;		/* for TSC calibration */
+	unsigned long offset_quotient;	/* conversion from tsc to usec */
+=09
+	unsigned long last_tsc;		/* lsb of TSC at last clock tick */
+
+	struct timeval last_tv;		/* time of day at last clock tick */
+	struct timezone last_tz;	/* timezone */
+};
+
+#define TSCINFO_MAGIC	0x203854e0
+
+#endif=20

--=-yPLDyyFyW+mJ8H7IWJjf
Content-Disposition: attachment; filename=ugettimeofday.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-csrc; name=ugettimeofday.c; charset=ISO-8859-1

/* ugettime.c -- userland alternative to gettimeofday


   This file is part of "ugettime", a userland alternative to
   gettimeofday and time system call.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or (at
   your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING.  If not, write to the
   Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
   MA 02111-1307, USA. =20
*/
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <sys/fcntl.h>
#include <sys/syscall.h>

#include <linux/tscinfo.h>


static void *mmap_base =3D NULL;

struct __xchg_dummy { unsigned long a[100]; };
#define __xg(x) ((struct __xchg_dummy *)(x))

static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old=
,
				      unsigned long new, int size)
{
	unsigned long prev;
	switch (size) {
	case 1:
		__asm__ __volatile__("lock; cmpxchgb %b1,%2"
				     : "=3Da"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	case 2:
		__asm__ __volatile__("lock; cmpxchgw %w1,%2"
				     : "=3Da"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	case 4:
		__asm__ __volatile__("lock; cmpxchgl %1,%2"
				     : "=3Da"(prev)
				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
				     : "memory");
		return prev;
	}
	return old;
}

#define cmpxchg(ptr,o,n)\
		((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
					(unsigned long)(n),sizeof(*(ptr))))


/*
 * Setup shared read-only map of tsc_info data structure
 * if kernel does not support it then leave mmap_base set to MAP_FAILED
 */
static void setup_mmap(void) {
	int fd;
	void *base;
	const long pgsz =3D sysconf(_SC_PAGE_SIZE);
	const long mapsz=20
		=3D (sizeof(struct tsc_info)+(pgsz-1)) &~ (pgsz-1);


	if ((fd =3D open("/proc/tscinfo", O_RDONLY)) < 0)=20
		base =3D MAP_FAILED;
	else {
		base =3D mmap(NULL, mapsz, PROT_READ, MAP_SHARED, fd, 0);
		close(fd);
	}

	/* Atomicaly update mmap,
	 * so if two threads try to setup
	 * at same time only one wins.
	 */
	if (cmpxchg(&mmap_base, 0, base) !=3D 0) {
		/* race detected, keep other threads map */
		if (base !=3D MAP_FAILED)=20
			munmap(base, mapsz);
	}
}

static inline const struct tsc_info *get_mmap(void)
{
	if (!mmap_base)=20
		setup_mmap();

	if (mmap_base =3D=3D MAP_FAILED ||
	    *(unsigned long *) mmap_base !=3D TSCINFO_MAGIC) {
		return NULL;
	}

	return (const struct tsc_info *) mmap_base;
}

/* Read TSC register */
#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=3Da" (low), "=3Dd" (high))

#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
#define rmb()	mb()


static inline unsigned long gettimeoffset(unsigned long last_tsc,
					  unsigned long fast_quotient)
{
	register unsigned long tsc_lo, tsc_hi;

	rdtsc(tsc_lo, tsc_hi);

	tsc_lo -=3D last_tsc;

	/*
	 * Time offset =3D (tsc_low delta) * fast_gettimeoffset_quotient
	 *             =3D (tsc_low delta) * (usecs_per_clock)
	 *             =3D (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
	 *
	 * Using a mull instead of a divl saves up to 31 clock cycles
	 * in the critical path.
	 */
		=09
	__asm__("mull %2"
		:"=3Da" (tsc_lo), "=3Dd" (tsc_hi)
		:"rm" (fast_quotient),
		"0" (tsc_lo));

	return tsc_hi;
}


int
gettimeofday (struct timeval *tv, struct timezone *tz)
{
	const struct tsc_info *	tsci =3D get_mmap();
=09
	if (!tsci)
		return syscall(SYS_gettimeofday,tv, tz);

	if (tv) {
		unsigned long seq, sec, usec;

		/* must check to see if clock ticked */
		do {
			seq =3D tsci->pre_sequence;

			usec =3D gettimeoffset(tsci->last_tsc,=20
					     tsci->offset_quotient);
			sec =3D tsci->last_tv.tv_sec;
			usec +=3D tsci->last_tv.tv_usec;
	=09
			rmb();
		} while (tsci->post_sequence !=3D seq);
	=09
		while (usec >=3D 1000000) {
			usec -=3D 1000000;
			sec++;
		}
		tv->tv_usec =3D usec;
		tv->tv_sec =3D sec;
	}

	if (tz) {
		*tz =3D tsci->last_tz;
	}
	=09
	return 0;
}

time_t
time (time_t *t)
{
	const struct tsc_info *	tsci =3D get_mmap();
	time_t now;

	if (!tsci)
		return syscall(SYS_time,t);

	now =3D tsci->last_tv.tv_sec;

	if (t)
		*t =3D now;

	return (time_t) now;
}

--=-yPLDyyFyW+mJ8H7IWJjf--

