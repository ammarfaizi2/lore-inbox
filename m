Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUEaO5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUEaO5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUEaO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:56:39 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:24007 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264660AbUEaOz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:55:56 -0400
Date: Mon, 31 May 2004 16:55:11 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       "Y.Ishikawa" <y.ishikawa@soft.fujitsu.com>
Subject: [patch] BSD accounting format rework
Message-ID: <Pine.LNX.4.53.0405311532360.17130@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'd like to see this included in -mm for more widespread testing.
I'm especially interested in reports from cross-platform or m68k 
users (if there are any of the latter).

Userspace still has a way to go, but the kernel side should be mature by 
now.

Thanks,
Tim

==========================================================================

BSD accounting format rework:

Use all explicit and implicit padding in struct acct to

 - correctly report 32 bit uid/gid,
 - correctly report jobs (e.g., daemons) running longer than 497 days,
 - increase the precision of ac_etime from 2^-13 to 2^-20
   (i.e., from ~6 hours to ~1 min. after a year)
 - store the current AHZ value.
 - allow cross-platform processing of the accounting file
   (limited for m68k which has a different size struct acct).
 - introduce versioning for smooth transition to incompatible formats in 
   the future. Currently the following version numbers are defined:
     0: old format (until 2.6.7) with 16 bit uid/gid
     1: extended variant (binary compatible to v0 on M68K)
     2: extended variant (binary compatible to v0 on everything except M68K)
     3: a new binary incompatible format (64 bytes)
     4: new binary incompatible format (128 bytes).
        layout of its first 64 bytes is the same as for v3.
     5: marks second half of new binary incompatible format (128 bytes)
        (layout is not yet defined)

All this is accomplished without breaking binary compatibility. 32 bit
uid/gid support is compatible with the patch previously floating around
and used e.g. by Red Hat.


This patch also introduces a config option for a new, binary incompatible 
"version 3" format that

 - is uniform across and properly aligned on all platforms
 - stores pid and ppid
 - uses AHZ==100 on all platforms (allows to report longer times)

Much of the compatibility glue goes away when v1/v2 support is removed 
from the kernel. Such a patch is at
<http://www.physik3.uni-rostock.de/tim/kernel/2.7/acct-cleanup-03.patch>
and might be applied in the 2.7 timeframe.

The new v3 format is source compatible with current GNU acct tools.
However, current GNU acct tools can be compiled for only one
format. As there is no way to pass the kernel configuration to userspace,
with my patch it will still only support the old v2 format. Only if
v1/v2 support is removed from the kernel, recompiling GNU acct tools will
yield v3 support.

A preliminary take at the corresponding work on cross-platform userspace
tools (GNU acct package) is at
<http://www.physik3.uni-rostock.de/tim/kernel/utils/acct-6.3.5-ts01-05.tar.gz>
This version of the package is able to read any of the v0/v2/v3 formats,
even within the same file. Cross-platform compatibility with m68k (v1
format) is not yet implemented, but native use on m68k should work
(untested). pid and ppid are currently only shown by the dump-acct
utility.

Thanks to Arthur Corliss, Albert Cahalan and Ragnar Kjørstad for their
comments, and to Albert Cahalan for the u64->IEEE float conversion code.


Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>


diff -urpP linux-2.6.7-rc2/include/linux/acct.h linux-2.6.7-rc2-acc1/include/linux/acct.h
--- linux-2.6.7-rc2/include/linux/acct.h	2004-04-04 05:36:26.000000000 +0200
+++ linux-2.6.7-rc2-acc1/include/linux/acct.h	2004-05-31 14:28:13.000000000 +0200
@@ -16,14 +16,18 @@
 #define _LINUX_ACCT_H
 
 #include <linux/types.h>
+#include <asm/param.h>
 
 /* 
  *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
- *  exponent and a 13-bit fraction. See linux/kernel/acct.c for the
- *  specific encoding system used.
+ *  exponent and a 13-bit fraction.
+ *  comp2_t is 24-bit with 5-bit base 2 exponent and 20 bit fraction
+ *  (leading 1 not stored).
+ *  See linux/kernel/acct.c for the specific encoding systems used.
  */
 
 typedef __u16	comp_t;
+typedef __u32	comp2_t;
 
 /*
  *   accounting file record
@@ -36,27 +40,59 @@ typedef __u16	comp_t;
 
 struct acct
 {
-	char		ac_flag;		/* Accounting Flags */
-/*
- *	No binary format break with 2.0 - but when we hit 32bit uid we'll
- *	have to bite one
- */
-	__u16		ac_uid;			/* Accounting Real User ID */
-	__u16		ac_gid;			/* Accounting Real Group ID */
-	__u16		ac_tty;			/* Accounting Control Terminal */
-	__u32		ac_btime;		/* Accounting Process Creation Time */
-	comp_t		ac_utime;		/* Accounting User Time */
-	comp_t		ac_stime;		/* Accounting System Time */
-	comp_t		ac_etime;		/* Accounting Elapsed Time */
-	comp_t		ac_mem;			/* Accounting Average Memory Usage */
-	comp_t		ac_io;			/* Accounting Chars Transferred */
-	comp_t		ac_rw;			/* Accounting Blocks Read or Written */
-	comp_t		ac_minflt;		/* Accounting Minor Pagefaults */
-	comp_t		ac_majflt;		/* Accounting Major Pagefaults */
-	comp_t		ac_swaps;		/* Accounting Number of Swaps */
-	__u32		ac_exitcode;		/* Accounting Exitcode */
-	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
-	char		ac_pad[10];		/* Accounting Padding Bytes */
+	char		ac_flag;		/* Flags */
+	char		ac_version;		/* Always set to ACCT_VERSION */
+	/* for binary compatibility back until 2.0 */
+	__u16		ac_uid16;		/* LSB of Real User ID */
+	__u16		ac_gid16;		/* LSB of Real Group ID */
+	__u16		ac_tty;			/* Control Terminal */
+	__u32		ac_btime;		/* Process Creation Time */
+	comp_t		ac_utime;		/* User Time */
+	comp_t		ac_stime;		/* System Time */
+	comp_t		ac_etime;		/* Elapsed Time */
+	comp_t		ac_mem;			/* Average Memory Usage */
+	comp_t		ac_io;			/* Chars Transferred */
+	comp_t		ac_rw;			/* Blocks Read or Written */
+	comp_t		ac_minflt;		/* Minor Pagefaults */
+	comp_t		ac_majflt;		/* Major Pagefaults */
+	comp_t		ac_swaps;		/* Number of Swaps */
+/* m68k had no padding here. */
+#if !defined(CONFIG_M68K) || !defined(__KERNEL__)
+	__u16		ac_ahz;			/* AHZ */
+#endif
+	__u32		ac_exitcode;		/* Exitcode */
+	char		ac_comm[ACCT_COMM + 1];	/* Command Name */
+	__u8		ac_etime_hi;		/* Elapsed Time MSB */
+	__u16		ac_etime_lo;		/* Elapsed Time LSB */
+	__u32		ac_uid;			/* Real User ID */
+	__u32		ac_gid;			/* Real Group ID */
+};
+
+struct acct_v3
+{
+	char		ac_flag;		/* Flags */
+	char		ac_version;		/* Always set to ACCT_VERSION */
+	__u16		ac_tty;			/* Control Terminal */
+	__u32		ac_exitcode;		/* Exitcode */
+	__u32		ac_uid;			/* Real User ID */
+	__u32		ac_gid;			/* Real Group ID */
+	__u32		ac_pid;			/* Process ID */
+	__u32		ac_ppid;		/* Parent Process ID */
+	__u32		ac_btime;		/* Process Creation Time */
+#ifdef __KERNEL__
+	__u32		ac_etime;		/* Elapsed Time */
+#else
+	float		ac_etime;		/* Elapsed Time */
+#endif
+	comp_t		ac_utime;		/* User Time */
+	comp_t		ac_stime;		/* System Time */
+	comp_t		ac_mem;			/* Average Memory Usage */
+	comp_t		ac_io;			/* Chars Transferred */
+	comp_t		ac_rw;			/* Blocks Read or Written */
+	comp_t		ac_minflt;		/* Minor Pagefaults */
+	comp_t		ac_majflt;		/* Major Pagefaults */
+	comp_t		ac_swaps;		/* Number of Swaps */
+	char		ac_comm[ACCT_COMM];	/* Command Name */
 };
 
 /*
@@ -68,8 +104,7 @@ struct acct
 #define ACOMPAT		0x04	/* ... used compatibility mode (VAX only not used) */
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
-
-#define AHZ		100
+#define ABYTESEX	0x80	/* always set, allows to detect byteorder */
 
 #ifdef __KERNEL__
 
@@ -84,6 +119,60 @@ extern void acct_process(long exitcode);
 #define acct_process(x)		do { } while (0)
 #endif
 
+/*
+ * ACCT_VERSION numbers as yet defined:
+ * 0: old format (until 2.6.7) with 16 bit uid/gid
+ * 1: extended variant (binary compatible on M68K)
+ * 2: extended variant (binary compatible on everything except M68K)
+ * 3: new binary incompatible format (64 bytes)
+ * 4: new binary incompatible format (128 bytes)
+ * 5: new binary incompatible format (128 bytes, second half)
+ *
+ */
+ 
+#ifdef CONFIG_BSD_PROCESS_ACCT_V3
+#define ACCT_VERSION	3
+#define AHZ		100
+typedef struct acct_v3 acct_t;
+#else
+#ifdef CONFIG_M68K
+#define ACCT_VERSION	1
+#else
+#define ACCT_VERSION	2
+#endif
+#define AHZ		(USER_HZ)
+typedef struct acct acct_t;
+#endif
+
+#else
+#define ACCT_VERSION	2
+#define AHZ		(USER_HZ)
 #endif	/* __KERNEL */
 
+#ifdef __KERNEL__
+/*
+ * Yet another HZ to *HZ helper function.
+ * See <linux/times.h> for the original.
+ * TODO: Not exactly precise on i386.
+ */
+#if (HZ % AHZ)==0
+# define jiffies_to_AHZ(x) ((x) / (HZ / AHZ))
+#else
+# define jiffies_to_AHZ(x) ((clock_t) jiffies_64_to_AHZ((u64) x))
+#endif
+
+static inline u64 jiffies_64_to_AHZ(u64 x)
+{
+#if HZ == AHZ
+	/* do nothing */
+#elseif (HZ % AHZ)==0
+	do_div(x, HZ / AHZ);
+#else
+	x *= AHZ;
+	do_div(x, HZ);
+#endif
+       return x;
+}
+#endif  /* __KERNEL */
+
 #endif	/* _LINUX_ACCT_H */
diff -urpP linux-2.6.7-rc2/init/Kconfig linux-2.6.7-rc2-acc1/init/Kconfig
--- linux-2.6.7-rc2/init/Kconfig	2004-05-30 21:59:30.000000000 +0200
+++ linux-2.6.7-rc2-acc1/init/Kconfig	2004-05-31 14:12:46.000000000 +0200
@@ -121,6 +121,18 @@ config BSD_PROCESS_ACCT
 	  up to the user level program to do useful things with this
 	  information.  This is generally a good idea, so say Y.
 
+config BSD_PROCESS_ACCT_V3
+	bool "BSD Process Accounting version 3 file format"
+	depends on BSD_PROCESS_ACCT
+	default n
+	help
+	  If you say Y here, the process accounting information is written
+	  in a new file format that also logs the process IDs of each
+	  process and it's parent. Note that this file format is incompatible
+	  with previous v0/v1/v2 file formats, so you will need updated tools
+	  for processing it. A preliminary version of these tools is available
+	  at <http://http://www.de.kernel.org/pub/linux/utils/>.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
diff -urpP linux-2.6.7-rc2/kernel/acct.c linux-2.6.7-rc2-acc1/kernel/acct.c
--- linux-2.6.7-rc2/kernel/acct.c	2004-05-30 21:59:30.000000000 +0200
+++ linux-2.6.7-rc2-acc1/kernel/acct.c	2004-05-31 14:27:17.000000000 +0200
@@ -302,6 +302,69 @@ static comp_t encode_comp_t(unsigned lon
 	return exp;
 }
 
+#if ACCT_VERSION==1 || ACCT_VERSION==2
+/*
+ * encode an u64 into a comp2_t (24 bits)
+ *
+ * Format: 5 bit base 2 exponent, 20 bits mantissa.
+ * The leading bit of the mantissa is not stored, but implied for
+ * non-zero exponents.
+ * Largest encodable value is 50 bits.
+ */
+
+#define MANTSIZE2       20                      /* 20 bit mantissa. */
+#define EXPSIZE2        5                       /* 5 bit base 2 exponent. */
+#define MAXFRACT2       ((1ul << MANTSIZE2) - 1) /* Maximum fractional value. */
+#define MAXEXP2         ((1 <<EXPSIZE2) - 1)    /* Maximum exponent. */
+
+static comp2_t encode_comp2_t(u64 value)
+{
+        int exp, rnd;
+
+        exp = (value > (MAXFRACT2>>1));
+        rnd = 0;
+        while (value > MAXFRACT2) {
+                rnd = value & 1;
+                value >>= 1;
+                exp++;
+        }
+
+        /*
+         * If we need to round up, do it (and handle overflow correctly).
+         */
+        if (rnd && (++value > MAXFRACT2)) {
+                value >>= 1;
+                exp++;
+        }
+
+        if (exp > MAXEXP2) {
+                /* Overflow. Return largest representable number instead. */
+                return (1ul << (MANTSIZE2+EXPSIZE2-1)) - 1;
+        } else {
+                return (value & (MAXFRACT2>>1)) | (exp << (MANTSIZE2-1));
+        }
+}
+#endif
+
+#if ACCT_VERSION==3
+/*
+ * encode an u64 into a 32 bit IEEE float
+ */
+static u32 encode_float(u64 value)
+{
+	unsigned exp = 190;
+	unsigned u;
+
+	if (value==0) return 0;
+	while ((s64)value > 0){
+		value <<= 1;
+		exp--;
+	}
+	u = (u32)(value >> 40) & 0x7fffffu;
+	return u | (exp << 23);
+} 
+#endif
+
 /*
  *  Write an accounting entry for an exiting process
  *
@@ -316,11 +379,12 @@ static comp_t encode_comp_t(unsigned lon
  */
 static void do_acct_process(long exitcode, struct file *file)
 {
-	struct acct ac;
+	acct_t ac;
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
 	u64 elapsed;
+	comp2_t etime;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -333,27 +397,51 @@ static void do_acct_process(long exitcod
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
 	 */
-	memset((caddr_t)&ac, 0, sizeof(struct acct));
+	memset((caddr_t)&ac, 0, sizeof(acct_t));
 
+	ac.ac_version = ACCT_VERSION;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = jiffies_64_to_clock_t(get_jiffies_64() - current->start_time);
+	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
+#if ACCT_VERSION==3
+	ac.ac_etime = encode_float(elapsed);
+#else
 	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
 	                       (unsigned long) elapsed : (unsigned long) -1l);
-	do_div(elapsed, USER_HZ);
+#endif
+#if ACCT_VERSION==1 || ACCT_VERSION==2
+	/* new enlarged etime field */
+	etime = encode_comp2_t(elapsed);
+	ac.ac_etime_hi = etime >> 16;
+	ac.ac_etime_lo = (u16) etime;
+#endif
+	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(jiffies_to_clock_t(current->utime));
-	ac.ac_stime = encode_comp_t(jiffies_to_clock_t(current->stime));
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
+#if ACCT_VERSION==2
+	ac.ac_ahz = AHZ;
+#endif
+#if ACCT_VERSION==1 || ACCT_VERSION==2
+	/* backward-compatible 16 bit fields */
+	ac.ac_uid16 = current->uid;
+	ac.ac_gid16 = current->gid;
+#endif
+#if ACCT_VERSION==3
+	ac.ac_pid = current->pid;
+	ac.ac_ppid = current->parent->pid;
+#endif
 
 	read_lock(&tasklist_lock);	/* pin current->signal */
 	ac.ac_tty = current->signal->tty ?
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
 	read_unlock(&tasklist_lock);
 
-	ac.ac_flag = 0;
+	/* ABYTESEX is always set to allow byte order detection */
+	ac.ac_flag = ABYTESEX;
 	if (current->flags & PF_FORKNOEXEC)
 		ac.ac_flag |= AFORK;
 	if (current->flags & PF_SUPERPRIV)
@@ -395,7 +483,7 @@ static void do_acct_process(long exitcod
 	flim = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	file->f_op->write(file, (char *)&ac,
-			       sizeof(struct acct), &file->f_pos);
+			       sizeof(acct_t), &file->f_pos);
 	current->rlim[RLIMIT_FSIZE].rlim_cur = flim;
 	set_fs(fs);
 }
