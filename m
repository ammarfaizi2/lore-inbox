Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUEML0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUEML0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbUEML0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:26:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:38862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264102AbUEML0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:26:10 -0400
Date: Thu, 13 May 2004 04:25:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-Id: <20040513042540.073478ea.akpm@osdl.org>
In-Reply-To: <20040513121206.A8620@infradead.org>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<20040513114520.A8442@infradead.org>
	<20040513035134.2e9013ea.akpm@osdl.org>
	<20040513121206.A8620@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 13, 2004 at 03:51:34AM -0700, Andrew Morton wrote:
> > Once I'm convinced that kernel.org kernels will be able to run applications
> > which vendor kernels will run, sure.
> > 
> > We're nowhere near that, and your continual whining gets us no closer.
> 
> Sorry, but this argumentation is utter bullshit.

Wim explained that any application changes now won't be widely deployed for
another year.  During that period the ability to run existing Oracle setups
requires that hugepage allocation be available to unprivileged
applications.

> If $VENDORKERNEL/freebsd/sco/windows2000 runs $APP and we don't, what
> does this mean?  Right, exactly nothing.


It means that if people install a kernel.org machine on their database
server, the database *just won't work*.  This is not good for those users,
for the kernel developers or for Linux's reputation in general.

It's worth a very small, extremely easily maintainable patch to fix all
this up.

And this is not just any old application.

> I've talked to three persons at Oracle and neither likes it at all, in
> fact en Oracle employee is working on doing quota for hugetlbfs which
> fixes this properly.

One year.

>  Merging some horrible hacks that completly change
> the authorization model (for a special case, that is)

If you need to exaggerate this much to make your point, it isn't a very
good point.

> in the middle of
> stable series doesn't get us anywhere, except into a horrible unmaintable
> mess.

Here's your "horrible unmaintainable mess":

diff -puN fs/hugetlbfs/inode.c~hugetlb_shm_group-sysctl-patch fs/hugetlbfs/inode.c
--- 25/fs/hugetlbfs/inode.c~hugetlb_shm_group-sysctl-patch	2004-05-10 04:48:58.627456560 -0700
+++ 25-akpm/fs/hugetlbfs/inode.c	2004-05-10 04:48:58.640454584 -0700
@@ -43,6 +43,8 @@ static struct backing_dev_info hugetlbfs
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
+int sysctl_hugetlb_shm_group;
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -718,6 +720,12 @@ static unsigned long hugetlbfs_counter(v
 	return ret;
 }
 
+static int can_do_hugetlb_shm(void)
+{
+	return likely(capable(CAP_IPC_LOCK) ||
+			in_group_p(sysctl_hugetlb_shm_group));
+}
+
 struct file *hugetlb_zero_setup(size_t size)
 {
 	int error;
@@ -727,7 +735,7 @@ struct file *hugetlb_zero_setup(size_t s
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_hugetlb_shm())
 		return ERR_PTR(-EPERM);
 
 	if (!is_hugepage_mem_enough(size))
diff -puN include/linux/hugetlb.h~hugetlb_shm_group-sysctl-patch include/linux/hugetlb.h
--- 25/include/linux/hugetlb.h~hugetlb_shm_group-sysctl-patch	2004-05-10 04:48:58.628456408 -0700
+++ 25-akpm/include/linux/hugetlb.h	2004-05-10 04:48:58.641454432 -0700
@@ -32,6 +32,7 @@ void free_huge_page(struct page *);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
+extern int sysctl_hugetlb_shm_group;
 
 static inline void
 mark_mm_hugetlb(struct mm_struct *mm, struct vm_area_struct *vma)
diff -puN include/linux/sysctl.h~hugetlb_shm_group-sysctl-patch include/linux/sysctl.h
--- 25/include/linux/sysctl.h~hugetlb_shm_group-sysctl-patch	2004-05-10 04:48:58.630456104 -0700
+++ 25-akpm/include/linux/sysctl.h	2004-05-10 04:48:58.643454128 -0700
@@ -163,6 +163,7 @@ enum
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
 	VM_BLOCK_DUMP=24,	/* block dump mode */
+	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 };
 
 
diff -puN kernel/sysctl.c~hugetlb_shm_group-sysctl-patch kernel/sysctl.c
--- 25/kernel/sysctl.c~hugetlb_shm_group-sysctl-patch	2004-05-10 04:48:58.632455800 -0700
+++ 25-akpm/kernel/sysctl.c	2004-05-10 04:48:58.645453824 -0700
@@ -738,6 +738,14 @@ static ctl_table vm_table[] = {
 		.extra1		= (void *)&hugetlb_zero,
 		.extra2		= (void *)&hugetlb_infinity,
 	 },
+	 {
+		.ctl_name	= VM_HUGETLB_GROUP,
+		.procname	= "hugetlb_shm_group",
+		.data		= &sysctl_hugetlb_shm_group,
+		.maxlen		= sizeof(gid_t),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	 },
 #endif
 	{
 		.ctl_name	= VM_LOWER_ZONE_PROTECTION,

_


Please, spare me the hyperbole.


