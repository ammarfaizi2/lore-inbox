Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUCHXDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUCHXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:03:52 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:42936 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261395AbUCHXDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:03:37 -0500
Date: Tue, 9 Mar 2004 00:03:27 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Arthur Corliss <corliss@digitalmages.com>
Subject: [PATCH][RFC] fix BSD accounting (w/ long-term perspective ;-)
Message-ID: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BSD accounting currently reports only the lower 16 bits of 32 bit uids,
reports times in units of 1/HZ seconds while it announces a unit of
1/100 seconds in the header file (which hurts especially on i386 where
HZ changed since 2.4) and cannot report times longer that 49 days.

We might want to fix that, but since we are in a stable kernel series
we need to insert some glue for binary compatibility.
This, of course, is nicer if we have a plot in place to zap such crap in 
the long term.
As only Arthur Corliss commented on my previous post (BSD accounting
dosn't seem that fancy these days...), I made up such a plot myself:

 - store the upper 16 bits of high uid/gids in the (currently zeroed)
   padding bytes of struct acct.

 - comp_t used for time values is actually able to hold up to 34 bit 
   values, so use that to allow times up to 194 days (with HZ=1024) to
   be reported. The GNU acct tools are able to deal with the extra bits.

 - units of time are the hard part. As userspace programs have no way 
   to determine which kernel version wrote the accounting file, and
   as the units of time have changed between 2.4 and 2.6, we have already
   messed up. It gets worse since we announce the constant (and thus 
   useless) value of AHZ=100 in <linux/acct.h> for all archs since ages.

   My proposed solution: keep backwards compatibility with 2.4 by using
   a unit of 1/USER_HZ, announce that correctly in the header file,
   and simply admit that BSD accounting on i386 is broken in 2.6.0-2.6.4.

 - store a version number in the last byte of struct acct, which allows
   for a smooth transition to a new binary format when 2.7 comes out.
   For 2.7, extend uid/gid fields to 32 bit, report times in terms
   of AHZ=100 on all platforms (thus allowing to report times up to 1988 
   days), and remove the compatibility stuff from the kernel.

 - introduce some compatibility glue into the userland tools, which can be 
   removed when 2.6 is history.

This would leave the user with two choices:

 - Don't mess with userland tools. Binary compatibility holds from 
   2.0 to 2.6, but breaks at the 2.6/2.7 border. For 2.7., userspace
   needs to be recompiled, but yields support for 32 bit uid/gids
   in return.

 - Install an updated userland accounting package. Immediately yields
   32 bit uid/gid support on kernels 2.6.5 and up.
   User may switch forth and back between kernels from 2.0 up to 2.7+,
   even within the same accounting file, without breaking compatibility.

Patch for 2.6 kernel is below. Proposed cleanup patch for 2.7 is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.7/acct-cleanup-01.patch
Compatibility glue for GNU acct package is still to be done.

Comments?
Any other suggestions for incompatible changes to struct acct in 2.7?

Tim


--- linux-2.6.4-rc1/include/linux/acct.h	2004-02-04 04:43:17.000000000 +0100
+++ linux-2.6.4-rc1-acct/include/linux/acct.h	2004-03-08 22:19:21.000000000 +0100
@@ -16,6 +16,8 @@
 #define _LINUX_ACCT_H
 
 #include <linux/types.h>
+#include <linux/version.h>
+#include <asm/param.h>
 
 /* 
  *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
@@ -34,12 +36,18 @@ typedef __u16	comp_t;
 
 #define ACCT_COMM	16
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,7,0)
+
+#define ACCT_VERSION    1
+#define AHZ		(USER_HZ)
+
+
 struct acct
 {
 	char		ac_flag;		/* Accounting Flags */
 /*
- *	No binary format break with 2.0 - but when we hit 32bit uid we'll
- *	have to bite one
+ *	No binary format break with 2.0 - but 32 bit uid/gid support is
+ *	a kludge.
  */
 	__u16		ac_uid;			/* Accounting Real User ID */
 	__u16		ac_gid;			/* Accounting Real Group ID */
@@ -56,9 +64,46 @@ struct acct
 	comp_t		ac_swaps;		/* Accounting Number of Swaps */
 	__u32		ac_exitcode;		/* Accounting Exitcode */
 	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
-	char		ac_pad[10];		/* Accounting Padding Bytes */
+	__u16		ac_uid_hi;		/* Accounting Real User ID */
+	__u16		ac_gid_hi;		/* Accounting Real Group ID */
+	char		ac_pad[5];		/* Accounting Padding Bytes */
+	char		ac_version;		/* Always set to ACCT_VERSION */
+};
+
+#else
+
+#define ACCT_VERSION    2
+#define AHZ		100
+
+/*
+ * New binary format with 32 bit uid/gid.
+ * Scheduled for 2.7.0
+ */
+
+struct acct
+{
+	__u32		ac_uid;			/* Accounting Real User ID */
+	__u32		ac_gid;			/* Accounting Real Group ID */
+	__u32		ac_exitcode;		/* Accounting Exitcode */
+	__u32		ac_btime;		/* Accounting Process Creation Time */
+	comp_t		ac_utime;		/* Accounting User Time */
+	comp_t		ac_stime;		/* Accounting System Time */
+	comp_t		ac_etime;		/* Accounting Elapsed Time */
+	comp_t		ac_mem;			/* Accounting Average Memory Usage */
+	comp_t		ac_io;			/* Accounting Chars Transferred */
+	comp_t		ac_rw;			/* Accounting Blocks Read or Written */
+	comp_t		ac_minflt;		/* Accounting Minor Pagefaults */
+	comp_t		ac_majflt;		/* Accounting Major Pagefaults */
+	comp_t		ac_swaps;		/* Accounting Number of Swaps */
+	__u16		ac_tty;			/* Accounting Control Terminal */
+	char		ac_pad[9];		/* Accounting Padding Bytes */
+	char		ac_flag;		/* Accounting Flags */
+	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
+	char		ac_version;		/* Always set to ACCT_VERSION */
 };
 
+#endif
+
 /*
  *  accounting flags
  */
@@ -69,8 +114,6 @@ struct acct
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
 
-#define AHZ		100
-
 #ifdef __KERNEL__
 
 #include <linux/config.h>
@@ -84,6 +127,28 @@ extern void acct_process(long exitcode);
 #define acct_process(x)		do { } while (0)
 #endif
 
+/*
+ * Yet another HZ to *HZ helper function.
+ * See <linux/timer.h> for the original.
+ */
+
+#if (HZ % AHZ)==0
+# define jiffies_to_AHZ(x) ((x) / (HZ / AHZ))
+#else
+# define jiffies_to_AHZ(x) ((clock_t) jiffies_64_to_AHZ((u64) x))
+#endif
+
+static inline u64 jiffies_64_to_AHZ(u64 x)
+{
+#if (HZ % AHZ)==0
+	do_div(x, HZ / AHZ);
+#else
+	x *= AHZ;
+	do_div(x, HZ);
+#endif
+	return x;
+}
+
 #endif	/* __KERNEL */
 
 #endif	/* _LINUX_ACCT_H */

--- linux-2.6.4-rc1/kernel/acct.c	2004-02-04 04:43:56.000000000 +0100
+++ linux-2.6.4-rc1-acct/kernel/acct.c	2004-03-08 22:31:26.000000000 +0100
@@ -265,13 +265,16 @@ void acct_auto_close(struct super_block 
  *  This routine has been adopted from the encode_comp_t() function in
  *  the kern_acct.c file of the FreeBSD operating system. The encoding
  *  is a 13-bit fraction with a 3-bit (base 8) exponent.
+ *
+ *  Bumped up to encode 64 bit values. Unfortunately the result may
+ *  overflow now.
  */
 
 #define	MANTSIZE	13			/* 13 bit mantissa. */
 #define	EXPSIZE		3			/* Base 8 (3 bit) exponent. */
 #define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
 
-static comp_t encode_comp_t(unsigned long value)
+static comp_t encode_comp_t(u64 value)
 {
 	int exp, rnd;
 
@@ -293,9 +296,14 @@ static comp_t encode_comp_t(unsigned lon
 	/*
          * Clean it up and polish it off.
          */
-	exp <<= MANTSIZE;		/* Shift the exponent into place */
-	exp += value;			/* and add on the mantissa. */
-	return exp;
+	if (exp >= (1 << EXPSIZE)) {
+		/* Overflow. Return largest representable number instead. */
+		return (1ul << (MANTSIZE + EXPSIZE)) - 1;
+	} else {
+		exp <<= MANTSIZE;	/* Shift the exponent into place */
+		exp += value;		/* and add on the mantissa. */
+		return exp;
+	}
 }
 
 /*
@@ -334,15 +342,21 @@ static void do_acct_process(long exitcod
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
 	elapsed = get_jiffies_64() - current->start_time;
-	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
-	                       (unsigned long) elapsed : (unsigned long) -1l);
+	ac.ac_etime = encode_comp_t(jiffies_64_to_AHZ(elapsed));
 	do_div(elapsed, HZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->utime);
 	ac.ac_stime = encode_comp_t(current->stime);
-	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
+#if ACCT_VERSION==1
+	/*
+	 * A change in layout to 32 bit uid/gid fields is scheduled for 2.7.
+	 * But let's keep it compatible for now.
+	 */
+	ac.ac_uid_hi = current->uid >> 16;
+	ac.ac_gid_hi = current->gid >> 16;
+#endif
 	ac.ac_tty = current->tty ? old_encode_dev(tty_devnum(current->tty)) : 0;
 
 	ac.ac_flag = 0;
@@ -374,6 +388,7 @@ static void do_acct_process(long exitcod
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(current->nswap);
 	ac.ac_exitcode = exitcode;
+	ac.ac_version = ACCT_VERSION;
 
 	/*
          * Kernel segment override to datasegment and write it
