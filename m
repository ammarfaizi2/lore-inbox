Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUFEBcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUFEBcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUFEBcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:32:16 -0400
Received: from holomorphy.com ([207.189.100.168]:19882 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266129AbUFEBcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:32:02 -0400
Date: Fri, 4 Jun 2004 18:31:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040605013139.GM21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604170542.576b4243.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604170542.576b4243.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This is patently ridiculous. Make a compat_sched_getaffinity(), and
>> likewise for whatever else is copying unsigned long arrays to userspace.

On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> My mind reading skills are failing me.  At the risk of opening myself to
> further ridicule, which part of what I wrote is patently ridiculous,
> why, and how does that differ from whatever you had in mind when you
> recommended doing "likewise"?

Ridiculous == some bizarre for_each_cpu() loop doing put put_user() once
for every bit of a cpumask_t.


On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> Putting your comments aside for a moment ...
> We have here a bit of suckage.  The kernel bitmaps/cpumasks are arrays
> of unsigned long, with the low order long in the low order array slot,
> and the bytes within the longs in natural byte-order for that arch. The
> sched_setaffinity/sched_getaffinity calls in the kernel copy this stuff
> directly to/from user space.  This doesn't work so well for 32 bit tasks
> on a 64 bit big-endian kernel.  [Begin off-topic alert] The glibc
> sched_setaffinity and sched_getaffinity calls forcibly truncate the size
> of masks to some constant hardcoded size -- you have to use
> __SYSCALL(__NR_set_mempolicy) and such to get the real syscall.  This
> doesn't work so well for kernels compiled with NR_CPUS larger than the
> hardcoded glibc size.  [End off-topic alert]  This also doesn't provide
> any help to other code needing to move binary masks across the
> kernel/user boundary, such as the perfctr kernel extension that Mikael
> Pettersson <mikpe@csd.uu.se> describes.

Sounds like a glibc bug. It should probably dynamically detect
sizeof(cpumask_t), except of course that the API it's stuck with for
all time won't allow for dynamic allocation of the things.

Except when I look at my glibc headers, it's 1024 bits. And they're not
particularly recent glibc versions. SGI may need to get that bumped up,
but I doubt many others do.


On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> I presume that it is too late to change the low level format of masks
> that the sched_setaffinity/sched_getaffinity API support.  I'd be
> delighted to be wrong on this presumption.  So there is need for a
> compat variant of these calls, for use by 32 bit apps on 64 bit kernels.
>  My first reaction to Milton Miller's compat_sched_getaffinity patch
> that Anton reminded us of is similar to Andrew's.  I haven't had the
> intestinal fortitude to study the matter closer yet.   Before actually
> reading the code, I would expect that all it had to handle was the
> swapping of 32 bit halves of 64 bit longs on 64 bit big endian kernels,
> such as I described in my discussion of a mythical BIT32X() macro,
> earlier in this thread.  I would not expect it to have to make such a
> big deal of the special case of one word masks, as distinct from n word
> masks, though I agree that a 32 bit app should be able to use a single
> 32 bit word mask on a 64 bit kernel compiled with NR_CPUS <= 32.

I thought something more like this would work, but haven't tried it.
This wants a real copy_bitmap_to_user() helper unlike compat_set_fd_set().

Index: irqaction-2.6.7-rc2/fs/compat.c
===================================================================
--- irqaction-2.6.7-rc2.orig/fs/compat.c	2004-06-01 03:11:30.000000000 -0700
+++ irqaction-2.6.7-rc2/fs/compat.c	2004-06-04 10:28:44.190035000 -0700
@@ -40,6 +40,7 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/syscall.h>
 #include <linux/personality.h>
+#include <linux/cpu.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -1394,6 +1395,31 @@
 	return ret;
 }
 
+asmlinkage long compat_sched_getaffinity(compat_pid_t pid,
+				compat_uint_t len, compat_ulong_t __user *cpus)
+{
+	cpumask_t affinity;
+	int ret = 0;
+	task_t *task;
+
+	if (len < sizeof(cpumask_t))
+		return -EINVAL;
+	if (!access_ok(VERIFY_WRITE, cpus, sizeof(cpumask_t)))
+		return -EFAULT;
+	lock_cpu_hotplug();
+	read_lock(&tasklist_lock);
+	if ((task = pid ? find_task_by_pid(pid) : current))
+		cpus_and(affinity, task->cpus_allowed, cpu_possible_map);
+	else
+		ret = -ESRCH;
+	read_unlock(&tasklist_lock);
+	unlock_cpu_hotplug();
+	if (ret)
+		return ret;
+	compat_set_fd_set(NR_CPUS, cpus, cpus_addr(affinity));
+	return sizeof(cpumask_t);
+}
+
 #if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 /* Stuff for NFS server syscalls... */
 struct compat_nfsctl_svc {


On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> A key question, since it seems the perfctr stuff Mikael Pettersson
> describes is on its way into the main stream kernel, is whether any
> other kernel binary bitmap/cpumask API should use the same format as
> used by the kernel sched_setaffinity and sched_getaffinity, or use a
> more easily portable format - say an array of 32 bit words rather than
> an array of unsigned longs.  One could make impassioned pleas either
> way.  Having one kernel represent the same type in two different binary
> formats is a bit of a botch.  But then again, arrays of 32 bit words are
> 'nicer'.  And in fact, we already _have_ two formats required, since 32
> bit apps on 64 bit end endian kernels necessarily see a different format
> than their kernel uses natively -- indeed they use a format that is
> essentially the same as perfctr is using now.

This is trivial. Just like we needed ASCII marshalling, we need endian-
correct 32/64-bit bitmap marshalling.


On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> My vote, already cast when I slid the 32 bit chunk ascii format past
> y'all (it's amazing now, that I managed to do that ...) would be to
> export the array of 32 bit words format from the kernel, in all calls
> except the set/get affinity calls, where we have already cast the die
> otherwise.  I like what I understand Mikael is trying to do here.

The only case where this is distinguished at all from copy_to_user() is
64-bit bigendian with 32-bit userspace.


On Fri, Jun 04, 2004 at 05:05:42PM -0700, Paul Jackson wrote:
> In any case, I'd hope that any big/little endian distinctions could be
> encapsulated in macros provided by include/linux/byteorder headers. I'd
> hope that whichever one or two formats the kernel exported were
> supported by conversion routines in bitmap.c and bitmap.h, and if
> useful, also made available via the cpumask_t API.  Once cpumask
> routines were available to convert the perfctr format, then that would
> be one less use of the infamous cpus_addr() macro.  We should minimize
> 'open coding' of the conversion routines outside of the bitmap routines,
> which means look for the opportunity to move codes from both perfctr and
> compat_sched_setaffinity into lib/bitmap.c.


Index: irqaction-2.6.7-rc2/include/asm-generic/cpumask_array.h
===================================================================
--- irqaction-2.6.7-rc2.orig/include/asm-generic/cpumask_array.h	2004-05-29 23:26:10.000000000 -0700
+++ irqaction-2.6.7-rc2/include/asm-generic/cpumask_array.h	2004-06-04 18:29:36.984743000 -0700
@@ -27,6 +27,8 @@
 #define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
 #define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu + 1)
 
+#define cpus_to_u32_array(d, s)	bitmap_to_u32_array(d, (s).mask, sizeof(cpumask_t))
+
 /* only ever use this for things that are _never_ used on large boxen */
 #define cpus_coerce(map)	((map).mask[0])
 #define cpus_promote(map)	({ cpumask_t __cpu_mask = CPU_MASK_NONE;\
Index: irqaction-2.6.7-rc2/include/asm-generic/cpumask_arith.h
===================================================================
--- irqaction-2.6.7-rc2.orig/include/asm-generic/cpumask_arith.h	2004-05-29 23:26:26.000000000 -0700
+++ irqaction-2.6.7-rc2/include/asm-generic/cpumask_arith.h	2004-06-04 18:29:41.238097000 -0700
@@ -38,6 +38,8 @@
 #define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
 #define CPU_MASK_NONE	((cpumask_t)0)
 
+#define cpus_to_u32_array(d, s)	bitmap_to_u32_array(d, &(s), sizeof(cpumask_t))
+
 /* only ever use this for things that are _never_ used on large boxen */
 #define cpus_coerce(map)		((unsigned long)(map))
 #define cpus_promote(map)		({ map; })
Index: irqaction-2.6.7-rc2/include/asm-generic/cpumask_up.h
===================================================================
--- irqaction-2.6.7-rc2.orig/include/asm-generic/cpumask_up.h	2004-05-29 23:25:55.000000000 -0700
+++ irqaction-2.6.7-rc2/include/asm-generic/cpumask_up.h	2004-06-04 18:29:46.573286000 -0700
@@ -40,6 +40,8 @@
 #define first_cpu(map)			(cpus_coerce(map) ? 0 : 1)
 #define next_cpu(cpu, map)		1
 
+#define cpus_to_u32_array(d, s)	bitmap_to_u32_array(d, &(s), sizeof(cpumask_t))
+
 /* only ever use this for things that are _never_ used on large boxen */
 #define cpus_promote(map)						\
 	({								\

-- wli
