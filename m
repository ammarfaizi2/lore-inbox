Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWHGNcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWHGNcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWHGNcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:32:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57357 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932096AbWHGNcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:32:45 -0400
Date: Mon, 7 Aug 2006 15:32:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Reuther <mreuther@umich.edu>, LKML <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>
Subject: [-mm patch] add timespec_to_us() and use it in kernel/tsacct.c
Message-ID: <20060807133240.GB3691@stusta.de>
References: <200608062330.19628.mreuther@umich.edu> <20060806222129.f1cfffb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806222129.f1cfffb9.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 10:21:29PM -0700, Andrew Morton wrote:
> On Sun, 6 Aug 2006 23:30:19 -0400
> Matt Reuther <mreuther@umich.edu> wrote:
> 
> > I got an Error while compiling 2.6.18-rc3-mm2:
> > 
> >   AR      arch/i386/lib/lib.a
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o(.text+0x45667): In function `bacct_add_tsk':
> > include/linux/time.h:130: undefined reference to `__divdi3'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > I attached the .config file.
> > 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/csa-basic-accounting-over-taskstats-fix.patch
> should fix this, thanks.  

This doesn't look correct since do_div() does not guarantee to return 
more than 32bit.

What about the patch below that adds a timespec_to_us() to time.h and 
uses this function in kernel/tsacct.c?


<--  snip  -->


This patch adds a timespec_to_us() to include/linux/time.h and uses it 
to fix a compile error in kernel/tsacct.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/time.h |   12 ++++++++++++
 kernel/tsacct.c      |    2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc3-mm2-full/include/linux/time.h.old	2006-08-06 19:56:50.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/include/linux/time.h	2006-08-06 20:00:51.000000000 +0200
@@ -132,6 +132,18 @@
 }
 
 /**
+ * timespec_to_us - Convert timespec to microseconds
+ * @ts:		pointer to the timespec variable to be converted
+ *
+ * Returns the scalar microsecond representation of the timespec
+ * parameter.
+ */
+static inline s64 timespec_to_us(const struct timespec *ts)
+{
+	return ((s64) ts->tv_sec * USEC_PER_SEC) + ts->tv_nsec / NSEC_PER_USEC;
+}
+
+/**
  * timeval_to_ns - Convert timeval to nanoseconds
  * @ts:		pointer to the timeval variable to be converted
  *
--- linux-2.6.18-rc3-mm2-full/kernel/tsacct.c.old	2006-08-06 19:54:45.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/kernel/tsacct.c	2006-08-06 19:56:44.000000000 +0200
@@ -36,7 +36,7 @@
 	do_posix_clock_monotonic_gettime(&uptime);
 	ts = timespec_sub(uptime, current->group_leader->start_time);
 	/* rebase elapsed time to usec */
-	stats->ac_etime = (timespec_to_ns(&ts))/NSEC_PER_USEC;
+	stats->ac_etime = timespec_to_us(&ts);
 	stats->ac_btime = xtime.tv_sec - ts.tv_sec;
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;


