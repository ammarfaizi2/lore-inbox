Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUCSOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUCSOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:10:29 -0500
Received: from [139.30.44.16] ([139.30.44.16]:61326 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262527AbUCSOJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:09:35 -0500
Date: Fri, 19 Mar 2004 15:09:20 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Subject: [patch,rfc] BSD accounting format rework
In-Reply-To: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what came out of my BSD accounting format rework.

I've used up all explicit and implicit padding in struct acct to
 - correctly report 32 bit uid/gid,
 - correctly report jobs (e.g., daemons) running longer than 497 days,
 - increase the precision of ac_etime from 2^-13 to 2^-20
   (i.e., from ~6 hours to ~1 min. after a year)
 - allow cross-platform processing of the accounting file
   (except for some platforms (m68k, arm?) which already have incompatible
   padding)
 - smoothen transition to incompatible formats in the future.
All this is accomplished without breaking binary compatibility. 32 bit 
uid/gid support is compatible with the previously floating patch used e.g. 
by Red Hat.

I also made a config option for a new, binary incompatible format. By 
getting rid of the compatibility stuff, I could also
 - store pid and ppid of the process
 - further increase the precision of ac_etime to 2^-24
   (i.e., to ~1sec after a year)
 - have a uniform format on all platforms
 - use AHZ==100 on all platforms (allows to report longer times)
This new "version 2" format is source compatible with current GNU acct 
tools. However, current GNU acct tools can be compiled for only one
format. As there is no way to pass the kernel configuration to userspace,
with my patch it will still only support the old v1 format. Only if
v1 support is removed from the kernel, recompiling GNU acct tools will
yield v2 support.

Most of the compatibility glue will go away if v1 support is removed from 
the kernel. Such a patch is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.7/acct-cleanup-02.patch
and might be applied in the 2.7 timeframe.

Todo:
 - spot the platforms that align u32 on a two-byte boundary instad of a 
   4-byte boundary. (m68k, arm?)
 - Userland support still needs to be implemented. I'll look at it when 
   there are no more objections to the in-kernel stuff.

Thanks to Arthur Corliss, Albert Cahalan and Ragnar Kjørstad for their
comments, and to Albert Cahalan for the u64->IEEE float conversion code.

Tim


--- linux-2.6.5-rc1/include/linux/acct.h	2004-02-04 04:43:17.000000000 +0100
+++ linux-2.6.5-rc1-acct/include/linux/acct.h	2004-03-19 13:08:12.000000000 +0100
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
@@ -36,27 +40,60 @@ typedef __u16	comp_t;
 
 struct acct
 {
-	char		ac_flag;		/* Accounting Flags */
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
 /*
- *	No binary format break with 2.0 - but when we hit 32bit uid we'll
- *	have to bite one
+ * We still need to identify the platforms that used to have no padding
+ * before ac_exitcode
  */
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
+	__u16		ac_ahz;			/* AHZ */
+	__u32		ac_exitcode;		/* Exitcode */
+	char		ac_comm[ACCT_COMM + 1];	/* Command Name */
+	__u8		ac_etime_hi;		/* Elapsed Time MSB */
+	__u16		ac_etime_lo;		/* Elapsed Time LSB */
+	__u32		ac_uid;			/* Real User ID */
+	__u32		ac_gid;			/* Real Group ID */
+};
+
+struct acct_v2
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
@@ -68,8 +105,7 @@ struct acct
 #define ACOMPAT		0x04	/* ... used compatibility mode (VAX only not used) */
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
-
-#define AHZ		100
+#define ABYTESEX	0x80	/* always set, allows to detect byteorder */
 
 #ifdef __KERNEL__
 
@@ -84,6 +120,44 @@ extern void acct_process(long exitcode);
 #define acct_process(x)		do { } while (0)
 #endif
 
+#ifdef CONFIG_BSD_PROCESS_ACCT_V2
+#define ACCT_VERSION	2
+#define AHZ		100
+typedef struct acct_v2 acct_t;
+#else
+#define ACCT_VERSION	1
+#define AHZ		(USER_HZ)
+typedef struct acct acct_t;
+#endif
+
+#else
+#define ACCT_VERSION	1
+#define AHZ		(USER_HZ)
 #endif	/* __KERNEL */
 
+#ifdef __KERNEL__
+/*
+ * Yet another HZ to *HZ helper function.
+ * See <linux/timer.h> for the original.
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

--- linux-2.6.5-rc1/init/Kconfig	2004-03-19 13:06:10.000000000 +0100
+++ linux-2.6.5-rc1-acct/init/Kconfig	2004-03-19 13:08:12.000000000 +0100
@@ -104,6 +104,17 @@ config BSD_PROCESS_ACCT
 	  up to the user level program to do useful things with this
 	  information.  This is generally a good idea, so say Y.
 
+config BSD_PROCESS_ACCT_V2
+	bool "BSD Process Accounting version 2 file format"
+	depends on BSD_PROCESS_ACCT
+	default n
+	help
+	  If you say Y here, the process accounting information is written
+	  in a new file format that also logs the process IDs of each
+	  process and it's parent. Note that this file format is incompatible
+	  with previous v0/v1 file formats, so you will need updated tools
+	  for processing it. If unsure say N.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---

--- linux-2.6.5-rc1/kernel/acct.c	2004-03-19 13:06:10.000000000 +0100
+++ linux-2.6.5-rc1-acct/kernel/acct.c	2004-03-19 13:59:21.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/jiffies.h>
+#include <linux/times.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
@@ -301,6 +302,69 @@ static comp_t encode_comp_t(unsigned lon
 	return exp;
 }
 
+#if ACCT_VERSION==1
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
+#if ACCT_VERSION==2
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
@@ -315,11 +379,12 @@ static comp_t encode_comp_t(unsigned lon
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
@@ -332,23 +397,44 @@ static void do_acct_process(long exitcod
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
 	 */
-	memset((caddr_t)&ac, 0, sizeof(struct acct));
+	memset((caddr_t)&ac, 0, sizeof(acct_t));
 
+	ac.ac_version = ACCT_VERSION;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
-	elapsed = get_jiffies_64() - current->start_time;
+	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
+#if ACCT_VERSION==2
+	ac.ac_etime = encode_float(elapsed);
+#else
 	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
 	                       (unsigned long) elapsed : (unsigned long) -1l);
-	do_div(elapsed, HZ);
+#endif
+#if ACCT_VERSION==1
+	/* new enlarged etime field */
+	etime = encode_comp2_t(elapsed);
+	ac.ac_etime_hi = etime >> 16;
+	ac.ac_etime_lo = (u16) etime;
+#endif
+	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(current->utime);
-	ac.ac_stime = encode_comp_t(current->stime);
-	/* we really need to bite the bullet and change layout */
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
+#if ACCT_VERSION==1
+	ac.ac_ahz = AHZ;
+	/* backward-compatible 16 bit fields */
+	ac.ac_uid16 = current->uid;
+	ac.ac_gid16 = current->gid;
+#endif
+#if ACCT_VERSION==2
+	ac.ac_pid = current->pid;
+	ac.ac_ppid = current->parent->pid;
+#endif
 	ac.ac_tty = current->tty ? old_encode_dev(tty_devnum(current->tty)) : 0;
 
-	ac.ac_flag = 0;
+	/* ABYTESEX is always set to allow byte order detection */
+	ac.ac_flag = ABYTESEX;
 	if (current->flags & PF_FORKNOEXEC)
 		ac.ac_flag |= AFORK;
 	if (current->flags & PF_SUPERPRIV)
@@ -390,7 +476,7 @@ static void do_acct_process(long exitcod
 	flim = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	file->f_op->write(file, (char *)&ac,
-			       sizeof(struct acct), &file->f_pos);
+			       sizeof(acct_t), &file->f_pos);
 	current->rlim[RLIMIT_FSIZE].rlim_cur = flim;
 	set_fs(fs);
 }
