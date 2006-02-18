Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWBRJFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWBRJFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWBRJFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:05:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751083AbWBRJFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:05:52 -0500
Date: Sat, 18 Feb 2006 01:04:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com
Subject: Re: [PATCH 2/2] fix file counting
Message-Id: <20060218010414.1f8d6782.akpm@osdl.org>
In-Reply-To: <20060217154626.GN29846@in.ibm.com>
References: <20060217154147.GL29846@in.ibm.com>
	<20060217154337.GM29846@in.ibm.com>
	<20060217154626.GN29846@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> I have benchmarked this on an x86_64 NUMA system and see no
>  significant performance difference on kernbench. Tested on
>  both x86_64 and powerpc.
> 
>  The way we do file struct accounting is not very suitable for batched
>  freeing. For scalability reasons, file accounting was constructor/destructor
>  based. This meant that nr_files was decremented only when
>  the object was removed from the slab cache. This is
>  susceptible to slab fragmentation. With RCU based file structure,
>  consequent batched freeing and a test program like Serge's,
>  we just speed this up and end up with a very fragmented slab -
> 
>  llm22:~ # cat /proc/sys/fs/file-nr
>  587730  0       758844
> 
>  At the same time, I see only a 2000+ objects in filp cache.
>  The following patch I fixes this problem. 
> 
>  This patch changes the file counting by removing the filp_count_lock.
>  Instead we use a separate percpu counter, nr_files, for now and all
>  accesses to it are through get_nr_files() api. In the sysctl
>  handler for nr_files, we populate files_stat.nr_files before returning
>  to user.
> 
>  Counting files as an when they are created and destroyed (as opposed
>  to inside slab) allows us to correctly count open files with RCU.

Fair enough.

What do you think of these changes?




From: Andrew Morton <akpm@osdl.org>

- Nuke the blank line between "}" and EXPORT_SYMBOL().  That's never seemed
  pointful to me.

- Make the get_max_files export use _GPL - only unix.ko uses it.

- Use `-1' in the arg to percpu_counter_mod() rather than `-1L'.  The
  compiler will dtrt and we shouldn't be peering inside percpu_counter
  internals here anyway.

- Scrub that - use percpu_counter_dec() and percpu_counter_inc().

- percpu_counters can be inaccurate on big SMP.  Before we actually fail a
  get_empty_filp() attempt, use the (new in -mm) expensive
  percpu_counter_sum() to check whether we're really over the limit.

- Make get_nr_files() static.  Which is just as well - any callers might
  want the percpu_counter_sum() treatment.  In which case we'd be better off
  exporting some

	bool are_files_over_limit(how_many_i_want);

  API.

Cc: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/file_table.c    |   21 +++++++++++++--------
 include/linux/fs.h |    1 -
 2 files changed, 13 insertions(+), 9 deletions(-)

diff -puN fs/file_table.c~fix-file-counting-fixes fs/file_table.c
--- devel/fs/file_table.c~fix-file-counting-fixes	2006-02-18 01:02:43.000000000 -0800
+++ devel-akpm/fs/file_table.c	2006-02-18 01:02:43.000000000 -0800
@@ -22,6 +22,7 @@
 #include <linux/fsnotify.h>
 #include <linux/sysctl.h>
 #include <linux/percpu_counter.h>
+
 #include <asm/atomic.h>
 
 /* sysctl tunables... */
@@ -42,14 +43,14 @@ static inline void file_free_rcu(struct 
 
 static inline void file_free(struct file *f)
 {
-	percpu_counter_mod(&nr_files, -1L);
+	percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
 /*
  * Return the total number of open files in the system
  */
-int get_nr_files(void)
+static int get_nr_files(void)
 {
 	return percpu_counter_read_positive(&nr_files);
 }
@@ -61,8 +62,7 @@ int get_max_files(void)
 {
 	return files_stat.max_files;
 }
-
-EXPORT_SYMBOL(get_max_files);
+EXPORT_SYMBOL_GPL(get_max_files);
 
 /*
  * Handle nr_files sysctl
@@ -95,15 +95,20 @@ struct file *get_empty_filp(void)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (get_nr_files() >= files_stat.max_files &&
-				!capable(CAP_SYS_ADMIN))
-		goto over;
+	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
+		/*
+		 * percpu_counters are inaccurate.  Do an expensive check before
+		 * we go and fail.
+		 */
+		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
+			goto over;
+	}
 
 	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
 	if (f == NULL)
 		goto fail;
 
-	percpu_counter_mod(&nr_files, 1L);
+	percpu_counter_inc(&nr_files);
 	memset(f, 0, sizeof(*f));
 	if (security_file_alloc(f))
 		goto fail_sec;
diff -puN include/linux/fs.h~fix-file-counting-fixes include/linux/fs.h
--- devel/include/linux/fs.h~fix-file-counting-fixes	2006-02-18 01:02:43.000000000 -0800
+++ devel-akpm/include/linux/fs.h	2006-02-18 01:02:43.000000000 -0800
@@ -35,7 +35,6 @@ struct files_stat_struct {
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
-extern int get_nr_files(void);
 extern int get_max_files(void);
 
 struct inodes_stat_t {
_

