Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUFDTJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUFDTJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUFDTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:09:46 -0400
Received: from ozlabs.org ([203.10.76.45]:49375 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264159AbUFDTJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:09:40 -0400
Date: Sat, 5 Jun 2004 05:08:03 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Cc: miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604190803.GA6651@krispykreme>
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604165601.GC21007@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This is patently ridiculous. Make a compat_sched_getaffinity(), and
> likewise for whatever else is copying unsigned long arrays to userspace.

Did someone say compat_sched_getaffinity?

Anton

--

Patch from Milton Miller that adds the sched_affinity syscalls into the
compat layer. 

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Anton Blanchard <anton@samba.org>

--

 gr16b-anton/kernel/compat.c |   88 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 79 insertions(+), 9 deletions(-)

diff -purN linux-2.6.5/kernel/compat.c linux-2.6.5.sys_sched_setaffinity/kernel/compat.c
--- linux-2.6.5/kernel/compat.c	2004-04-04 03:37:07.000000000 +0000
+++ linux-2.6.5.sys_sched_setaffinity/kernel/compat.c	2004-05-10 11:13:20.000000000 +0000
@@ -372,22 +372,64 @@ compat_sys_wait4(compat_pid_t pid, compa
 	}
 }
 
+/* for maximum compatability, we allow programs to use a single (compat)
+ * unsigned long bitmask if all cpus will fit.  If not, you have to have
+ * at least the kernel size available.
+ */
+#define USE_COMPAT_ULONG_CPUMASK (NR_CPUS <= 8*sizeof(compat_ulong_t))
+
 asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid, 
 					     unsigned int len,
 					     compat_ulong_t *user_mask_ptr)
 {
-	unsigned long kernel_mask;
+	cpumask_t kernel_mask;
 	mm_segment_t old_fs;
 	int ret;
 
-	if (get_user(kernel_mask, user_mask_ptr))
-		return -EFAULT;
+	if (USE_COMPAT_ULONG_CPUMASK) {
+		compat_ulong_t user_mask;
+
+		if (len < sizeof(user_mask))
+			return -EINVAL;
+
+		if (get_user(user_mask, user_mask_ptr))
+			return -EFAULT;
+
+		kernel_mask = cpus_promote(user_mask);
+	} else {
+		if (len < sizeof(kernel_mask))
+			return -EINVAL;
+
+		if (!access_ok(VERIFY_READ, user_mask_ptr, sizeof(kernel_mask)))
+			return -EFAULT;
+		else {
+			int i, j;
+			unsigned long *k, m;
+			compat_ulong_t um;
+
+			k = &cpus_coerce(kernel_mask);
+
+			for (i=0; i < sizeof(kernel_mask)/sizeof(m); i++) {
+				m = 0;
+
+				for (j = 0; j < sizeof(m)/sizeof(um); j++ ) {
+					if (__get_user(um, user_mask_ptr))
+						return -EFAULT;
+					user_mask_ptr++;
+					m <<= 4*sizeof(um);
+					m <<= 4*sizeof(um);
+					m |= um;
+				}
+				*k++ = m;
+			}
+		}
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sched_setaffinity(pid,
 				    sizeof(kernel_mask),
-				    &kernel_mask);
+				    (unsigned long *)&kernel_mask);
 	set_fs(old_fs);
 
 	return ret;
@@ -396,21 +438,49 @@ asmlinkage long compat_sys_sched_setaffi
 asmlinkage int compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
 					    compat_ulong_t *user_mask_ptr)
 {
-	unsigned long kernel_mask;
+	cpumask_t kernel_mask;
 	mm_segment_t old_fs;
 	int ret;
 
+	if (len < (USE_COMPAT_ULONG_CPUMASK ? sizeof(compat_ulong_t)
+				: sizeof(kernel_mask)))
+		return -EINVAL;
+
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_sched_getaffinity(pid,
 				    sizeof(kernel_mask),
-				    &kernel_mask);
+				    (unsigned long *)&kernel_mask);
 	set_fs(old_fs);
 
 	if (ret > 0) {
-		ret = sizeof(compat_ulong_t);
-		if (put_user(kernel_mask, user_mask_ptr))
-			return -EFAULT;
+		if (USE_COMPAT_ULONG_CPUMASK) {
+			ret = sizeof(compat_ulong_t);
+			if (put_user(cpus_coerce(kernel_mask), user_mask_ptr))
+				return -EFAULT;
+		} else {
+			int i, j, err;
+			unsigned long *k, m;
+			compat_ulong_t um;
+
+			err = ! access_ok(VERIFY_WRITE, user_mask_ptr, ret);
+
+			k = &cpus_coerce(kernel_mask);
+
+			for (i=0; i < sizeof(kernel_mask)/sizeof(m) && !err; i++) {
+				m = *k++;
+
+				for (j = 0; j < sizeof(m)/sizeof(compat_ulong_t) && !err; j++ ) {
+					um = m;
+					err |= __put_user(um, user_mask_ptr);
+					user_mask_ptr++;
+					m >>= 4*sizeof(compat_ulong_t);
+					m >>= 4*sizeof(compat_ulong_t);
+				}
+			}
+			if (err)
+				ret = -EFAULT;
+		}
 	}
 
 	return ret;
