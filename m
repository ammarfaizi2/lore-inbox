Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423869AbWLBM4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423869AbWLBM4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423860AbWLBM4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:56:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:39075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423857AbWLBM4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:56:43 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19] struct seq_operations and struct file_operations constification
Date: Sat, 2 Dec 2006 13:55:47 +0100
User-Agent: KMail/1.9.5
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,7X
	?Bt1Wb:L7K6z-<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(e}
	`-QV{#%&[?^fAke6t8QbP;b'XB,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"
	["ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021355.47945.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this trivial patch 
- moves some file_operations structs into the .rodata section
- moves static strings from policy_types[] array into the .rodata section
- fixes generic seq_operations usages, so that those structs may be defined as "const" as well

tested on ia32
patch was already sent on 1006-10-08

Signed-off-by: Helge Deller <deller@gmx.de>



 fs/seq_file.c            |    4 ++--
 include/linux/mmzone.h   |    2 +-
 include/linux/relay.h    |    2 +-
 include/linux/seq_file.h |    4 ++--
 kernel/configs.c         |    2 +-
 kernel/cpuset.c          |    4 ++--
 kernel/dma.c             |    2 +-
 kernel/futex.c           |    2 +-
 kernel/kallsyms.c        |    4 ++--
 kernel/lockdep_proc.c    |    6 +++---
 kernel/module.c          |    2 +-
 kernel/power/user.c      |    2 +-
 kernel/profile.c         |    2 +-
 kernel/relay.c           |    2 +-
 kernel/resource.c        |    6 +++---
 kernel/sched.c           |    2 +-
 kernel/sysctl.c          |    2 +-
 mm/mempolicy.c           |    4 ++--
 mm/page_alloc.c          |    2 +-
 mm/shmem.c               |    4 ++--
 mm/slab.c                |    4 ++--
 mm/swapfile.c            |    4 ++--
 mm/vmstat.c              |    8 ++++----
 23 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 555b9ac..10690aa 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -26,7 +26,7 @@ #include <asm/page.h>
  *	ERR_PTR(error).  In the end of sequence they return %NULL. ->show()
  *	returns 0 in case of success and negative number in case of error.
  */
-int seq_open(struct file *file, struct seq_operations *op)
+int seq_open(struct file *file, const struct seq_operations *op)
 {
 	struct seq_file *p = file->private_data;
 
@@ -408,7 +408,7 @@ EXPORT_SYMBOL(single_open);
 
 int single_release(struct inode *inode, struct file *file)
 {
-	struct seq_operations *op = ((struct seq_file *)file->private_data)->op;
+	const struct seq_operations *op = ((struct seq_file *)file->private_data)->op;
 	int res = seq_release(inode, file);
 	kfree(op);
 	return res;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e06683e..9ba27f0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -278,7 +278,7 @@ #endif
 	/*
 	 * rarely used fields:
 	 */
-	char			*name;
+	const char		*name;
 } ____cacheline_internodealigned_in_smp;
 
 /*
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 24accb4..07c56e6 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -274,7 +274,7 @@ static inline void subbuf_start_reserve(
 /*
  * exported relay file operations, kernel/relay.c
  */
-extern struct file_operations relay_file_operations;
+extern const struct file_operations relay_file_operations;
 
 #endif /* _LINUX_RELAY_H */
 
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b95f6eb..3e3cccb 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -20,7 +20,7 @@ struct seq_file {
 	loff_t index;
 	loff_t version;
 	struct mutex lock;
-	struct seq_operations *op;
+	const struct seq_operations *op;
 	void *private;
 };
 
@@ -31,7 +31,7 @@ struct seq_operations {
 	int (*show) (struct seq_file *m, void *v);
 };
 
-int seq_open(struct file *, struct seq_operations *);
+int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
 loff_t seq_lseek(struct file *, loff_t, int);
 int seq_release(struct inode *, struct file *);
diff --git a/kernel/configs.c b/kernel/configs.c
index f9e3197..8fa1fb2 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -75,7 +75,7 @@ ikconfig_read_current(struct file *file,
 	return count;
 }
 
-static struct file_operations ikconfig_file_ops = {
+static const struct file_operations ikconfig_file_ops = {
 	.owner = THIS_MODULE,
 	.read = ikconfig_read_current,
 };
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index 6313c38..f1f586c 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -1532,7 +1532,7 @@ static int cpuset_rename(struct inode *o
 	return simple_rename(old_dir, old_dentry, new_dir, new_dentry);
 }
 
-static struct file_operations cpuset_file_operations = {
+static const struct file_operations cpuset_file_operations = {
 	.read = cpuset_file_read,
 	.write = cpuset_file_write,
 	.llseek = generic_file_llseek,
@@ -2610,7 +2610,7 @@ static int cpuset_open(struct inode *ino
 	return single_open(file, proc_cpuset_show, pid);
 }
 
-struct file_operations proc_cpuset_operations = {
+const struct file_operations proc_cpuset_operations = {
 	.open		= cpuset_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/dma.c b/kernel/dma.c
index 2020644..937b13c 100644
--- a/kernel/dma.c
+++ b/kernel/dma.c
@@ -140,7 +140,7 @@ static int proc_dma_open(struct inode *i
 	return single_open(file, proc_dma_show, NULL);
 }
 
-static struct file_operations proc_dma_operations = {
+static const struct file_operations proc_dma_operations = {
 	.open		= proc_dma_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/futex.c b/kernel/futex.c
index 93ef30b..90b2b19 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1493,7 +1493,7 @@ static unsigned int futex_poll(struct fi
 	return ret;
 }
 
-static struct file_operations futex_fops = {
+static const struct file_operations futex_fops = {
 	.release	= futex_close,
 	.poll		= futex_poll,
 };
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index eeac3e3..76e7681 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -401,7 +401,7 @@ static int s_show(struct seq_file *m, vo
 	return 0;
 }
 
-static struct seq_operations kallsyms_op = {
+static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
 	.stop = s_stop,
@@ -436,7 +436,7 @@ static int kallsyms_release(struct inode
 	return seq_release(inode, file);
 }
 
-static struct file_operations kallsyms_operations = {
+static const struct file_operations kallsyms_operations = {
 	.open = kallsyms_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/kernel/lockdep_proc.c b/kernel/lockdep_proc.c
index f6e72ea..b554b40 100644
--- a/kernel/lockdep_proc.c
+++ b/kernel/lockdep_proc.c
@@ -113,7 +113,7 @@ #endif
 	return 0;
 }
 
-static struct seq_operations lockdep_ops = {
+static const struct seq_operations lockdep_ops = {
 	.start	= l_start,
 	.next	= l_next,
 	.stop	= l_stop,
@@ -135,7 +135,7 @@ static int lockdep_open(struct inode *in
 	return res;
 }
 
-static struct file_operations proc_lockdep_operations = {
+static const struct file_operations proc_lockdep_operations = {
 	.open		= lockdep_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -319,7 +319,7 @@ static int lockdep_stats_open(struct ino
 	return single_open(file, lockdep_stats_show, NULL);
 }
 
-static struct file_operations proc_lockdep_stats_operations = {
+static const struct file_operations proc_lockdep_stats_operations = {
 	.open		= lockdep_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/module.c b/kernel/module.c
index f016656..dc10ba8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2182,7 +2182,7 @@ static int m_show(struct seq_file *m, vo
    Where refcount is a number or -, and deps is a comma-separated list
    of depends or -.
 */
-struct seq_operations modules_op = {
+const struct seq_operations modules_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d991d3b..6b5fc43 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -321,7 +321,7 @@ OutS3:
 	return error;
 }
 
-static struct file_operations snapshot_fops = {
+static const struct file_operations snapshot_fops = {
 	.open = snapshot_open,
 	.release = snapshot_release,
 	.read = snapshot_read,
diff --git a/kernel/profile.c b/kernel/profile.c
index f940b46..1a3681e 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -480,7 +480,7 @@ #endif
 	return count;
 }
 
-static struct file_operations proc_profile_operations = {
+static const struct file_operations proc_profile_operations = {
 	.read		= read_profile,
 	.write		= write_profile,
 };
diff --git a/kernel/relay.c b/kernel/relay.c
index f04bbdb..5d08ce8 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1011,7 +1011,7 @@ static ssize_t relay_file_sendfile(struc
 				       actor, &desc);
 }
 
-struct file_operations relay_file_operations = {
+const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
 	.mmap		= relay_file_mmap,
diff --git a/kernel/resource.c b/kernel/resource.c
index 6de60c1..7b9a497 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -88,7 +88,7 @@ static int r_show(struct seq_file *m, vo
 	return 0;
 }
 
-static struct seq_operations resource_op = {
+static const struct seq_operations resource_op = {
 	.start	= r_start,
 	.next	= r_next,
 	.stop	= r_stop,
@@ -115,14 +115,14 @@ static int iomem_open(struct inode *inod
 	return res;
 }
 
-static struct file_operations proc_ioports_operations = {
+static const struct file_operations proc_ioports_operations = {
 	.open		= ioports_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
-static struct file_operations proc_iomem_operations = {
+static const struct file_operations proc_iomem_operations = {
 	.open		= iomem_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..5980882 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -505,7 +505,7 @@ static int schedstat_open(struct inode *
 	return res;
 }
 
-struct file_operations proc_schedstat_operations = {
+const struct file_operations proc_schedstat_operations = {
 	.open    = schedstat_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 09e569f..a40aa14 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -170,7 +170,7 @@ static ssize_t proc_readsys(struct file 
 static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
 static int proc_opensys(struct inode *, struct file *);
 
-struct file_operations proc_sys_file_operations = {
+const struct file_operations proc_sys_file_operations = {
 	.open		= proc_opensys,
 	.read		= proc_readsys,
 	.write		= proc_writesys,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 617fb31..e5e6c59 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1705,8 +1705,8 @@ void mpol_rebind_mm(struct mm_struct *mm
  * Display pages allocated per node and memory policy via /proc.
  */
 
-static const char *policy_types[] = { "default", "prefer", "bind",
-				      "interleave" };
+static const char * const policy_types[] = 
+	{ "default", "prefer", "bind", "interleave" };
 
 /*
  * Convert a mempolicy into a string.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa6fcc7..4449c45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -90,7 +90,7 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = {
+static const char * const zone_names[MAX_NR_ZONES] = {
 	 "DMA",
 #ifdef CONFIG_ZONE_DMA32
 	 "DMA32",
diff --git a/mm/shmem.c b/mm/shmem.c
index 4959535..d67f4bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -177,7 +177,7 @@ static inline void shmem_unacct_blocks(u
 
 static struct super_operations shmem_ops;
 static const struct address_space_operations shmem_aops;
-static struct file_operations shmem_file_operations;
+static const struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct inode_operations shmem_special_inode_operations;
@@ -2319,7 +2319,7 @@ #endif
 	.migratepage	= migrate_page,
 };
 
-static struct file_operations shmem_file_operations = {
+static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 #ifdef CONFIG_TMPFS
 	.llseek		= generic_file_llseek,
diff --git a/mm/slab.c b/mm/slab.c
index 3c4a7e3..858070b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4038,7 +4038,7 @@ #endif
  * + further values on SMP and with statistics enabled
  */
 
-struct seq_operations slabinfo_op = {
+const struct seq_operations slabinfo_op = {
 	.start = s_start,
 	.next = s_next,
 	.stop = s_stop,
@@ -4236,7 +4236,7 @@ static int leaks_show(struct seq_file *m
 	return 0;
 }
 
-struct seq_operations slabstats_op = {
+const struct seq_operations slabstats_op = {
 	.start = leaks_start,
 	.next = s_next,
 	.stop = s_stop,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a15def6..fb1e34a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1325,7 +1325,7 @@ static int swap_show(struct seq_file *sw
 	return 0;
 }
 
-static struct seq_operations swaps_op = {
+static const struct seq_operations swaps_op = {
 	.start =	swap_start,
 	.next =		swap_next,
 	.stop =		swap_stop,
@@ -1337,7 +1337,7 @@ static int swaps_open(struct inode *inod
 	return seq_open(file, &swaps_op);
 }
 
-static struct file_operations proc_swaps_operations = {
+static const struct file_operations proc_swaps_operations = {
 	.open		= swaps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8614e8f..05ffe79 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -430,7 +430,7 @@ static int frag_show(struct seq_file *m,
 	return 0;
 }
 
-struct seq_operations fragmentation_op = {
+const struct seq_operations fragmentation_op = {
 	.start	= frag_start,
 	.next	= frag_next,
 	.stop	= frag_stop,
@@ -452,7 +452,7 @@ #endif
 #define TEXTS_FOR_ZONES(xx) xx "_dma", TEXT_FOR_DMA32(xx) xx "_normal", \
 					TEXT_FOR_HIGHMEM(xx)
 
-static char *vmstat_text[] = {
+static const char * const vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_anon_pages",
 	"nr_mapped",
@@ -597,7 +597,7 @@ #endif
 	return 0;
 }
 
-struct seq_operations zoneinfo_op = {
+const struct seq_operations zoneinfo_op = {
 	.start	= frag_start, /* iterate over all zones. The same as in
 			       * fragmentation. */
 	.next	= frag_next,
@@ -660,7 +660,7 @@ static void vmstat_stop(struct seq_file 
 	m->private = NULL;
 }
 
-struct seq_operations vmstat_op = {
+const struct seq_operations vmstat_op = {
 	.start	= vmstat_start,
 	.next	= vmstat_next,
 	.stop	= vmstat_stop,
