Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUCQTGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUCQTGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:06:39 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:37902 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261939AbUCQTFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:05:53 -0500
Date: Wed, 17 Mar 2004 19:05:24 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory
 machines.......
Message-ID: <37640233.1079550324@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <20040314040634.GC19737@krispykreme>
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de>
 <20040313184547.6e127b51.akpm@osdl.org> <20040314040634.GC19737@krispykreme>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 14 March 2004 15:06 +1100 Anton Blanchard <anton@samba.org> wrote:

> Hmm what a coincidence, I was chasing a problem where large page
> allocations would fail even though I clearly had enough large page memory
> free.
>
> It turns out we were tripping the overcommit logic in do_mmap. I had
> 30GB of large page and 2GB of small pages and of course
> cap_vm_enough_memory was looking at the small page pool. Setting
> overcommit to 1 fixed it.
>
> It seems we can solve both problems by having a separate hugetlb
> overcommit policy. Make it strict and you wont have OOM problems on large
> pages and I wont hit my 30GB / 2GB problem.

Been following this thread and it seems that fixing this overcommit
miss-handling problem would logically be the first step.  From my reading
it seems that once we have initialised hugetlb we have two independent and
non-overlapping 'page' pools from which we can allocate pages and against
which we wish to handle commitments.  Looking at the current code base we
effectivly have only a single 'accounting domain' and so when we attempt to
allocate hugetlb pages we incorrectly account them against the small page
pool.

I believe we need to add support for more than one page 'accounting domain'
each with its own policy and with its own commitments.  The attached patch
is my attempt at this first step.  I have created the concept of an
accounting domain, against which pages are to be accounted.  In this
implementation there are two domains VM_AD_DEFAULT which is used to account
normal small pages in the normal way and VM_AD_HUGETLB which is used to
select and identify VM_HUGETLB pages.  I have not attempted to add any
actual accounting for VM_HUGETLB pages, as currently they are prefaulted
and thus there is always 0 outstanding commitment to track.  Obviously, if
hugetlb was also changed to support demand paging that would need to be
implemented.

The patch below implements the basic domain split and provides a default
overcommit policy only for VM_AD_HUGETLB.  Anton, with it installed I
believe that you should not need to change the global overcommit policy to
1 to allow 30GB of hugetlb pages to work.  It was made against 2.6.4.  It
contains a couple of comment changes which I intend to split off and submit
separatly (so ignore them).

I have compiled and booted with security on and off, but have not had a 
chance to test the hugetlb side as yet.  What do people think?  The right 
direction?

Cheers.

-apw

diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mm.h 
current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-11 20:47:28.000000000 +0000
+++ current/include/linux/mm.h	2004-03-17 19:10:23.000000000 +0000
@@ -112,6 +112,11 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */

+/* Memory accounting domains.  These may not be consecutive bits. */
+#define VM_ACCTDOM(vma) (vma)->vm_flags & VM_HUGETLB)
+#define VM_AD_DEFAULT	0x00000000
+#define VM_AD_HUGETLB	VM_HUGETLB
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/security.h 
current/include/linux/security.h
--- reference/include/linux/security.h	2004-03-11 20:47:28.000000000 +0000
+++ current/include/linux/security.h	2004-03-17 19:10:23.000000000 +0000
@@ -51,7 +51,7 @@ extern int cap_inode_removexattr(struct
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t 
old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
-extern int cap_vm_enough_memory (long pages);
+extern int cap_vm_enough_acctdom (int domain, long pages);

 static inline int cap_netlink_send (struct sk_buff *skb)
 {
@@ -987,8 +987,9 @@ struct swap_info_struct;
  *	See the syslog(2) manual page for an explanation of the @type values.
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
- * @vm_enough_memory:
- *	Check permissions for allocating a new virtual mapping.
+ * @vm_enough_acctdom:
+ *      Check permissions for allocating a new virtual mapping.
+ *      @domain contains the accounting domain.
  *      @pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
@@ -1022,7 +1023,7 @@ struct security_operations {
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 	int (*syslog) (int type);
-	int (*vm_enough_memory) (long pages);
+	int (*vm_enough_acctdom) (int domain, long pages);

 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1276,9 +1277,9 @@ static inline int security_syslog(int ty
 	return security_ops->syslog(type);
 }

-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_acctdom(int domain, long pages)
 {
-	return security_ops->vm_enough_memory(pages);
+	return security_ops->vm_enough_acctdom(domain, pages);
 }

 static inline int security_bprm_alloc (struct linux_binprm *bprm)
@@ -1947,9 +1948,9 @@ static inline int security_syslog(int ty
 	return cap_syslog(type);
 }

-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_acctdom(int domain, long pages)
 {
-	return cap_vm_enough_memory(pages);
+	return cap_vm_enough_acctdom(domain, pages);
 }

 static inline int security_bprm_alloc (struct linux_binprm *bprm)
@@ -2738,5 +2739,10 @@ static inline void security_sk_free(stru
 }
 #endif	/* CONFIG_SECURITY_NETWORK */

+static inline int security_vm_enough_memory(long pages)
+{
+	return security_vm_enough_acctdom(VM_AD_DEFAULT, pages);
+}
+
 #endif /* ! __LINUX_SECURITY_H */

diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-11 20:47:29.000000000 +0000
+++ current/mm/mmap.c	2004-03-17 19:10:23.000000000 +0000
@@ -473,6 +473,7 @@ unsigned long do_mmap_pgoff(struct file
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged = 0;
+	int acctdom = VM_AD_DEFAULT;

 	if (file) {
 		if (!file->f_op || !file->f_op->mmap)
@@ -591,7 +592,10 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;

-	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+	if (is_file_hugepages(file))
+		acctdom = VM_AD_HUGETLB;
+	if (!(flags & MAP_NORESERVE) ||
+	    (acctdom == VM_AD_DEFAULT && sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |= VM_ACCOUNT;
@@ -600,7 +604,7 @@ munmap_back:
 			 * Private writable mapping: check memory availability
 			 */
 			charged = len >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_acctdom(acctdom, charged))
 				return -ENOMEM;
 			vm_flags |= VM_ACCOUNT;
 		}
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/capability.c 
current/security/capability.c
--- reference/security/capability.c	2004-02-04 15:09:21.000000000 +0000
+++ current/security/capability.c	2004-03-17 19:10:23.000000000 +0000
@@ -47,7 +47,7 @@ static struct security_operations capabi

 	.syslog =                       cap_syslog,

-	.vm_enough_memory =             cap_vm_enough_memory,
+	.vm_enough_acctdom =            cap_vm_enough_acctdom,
 };

 #if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c 
current/security/commoncap.c
--- reference/security/commoncap.c	2004-02-23 18:15:19.000000000 +0000
+++ current/security/commoncap.c	2004-03-17 19:10:23.000000000 +0000
@@ -303,15 +303,21 @@ int cap_syslog (int type)
  * succeed and -ENOMEM implies there is not.
  *
  * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-int cap_vm_enough_memory(long pages)
+int cap_vm_enough_acctdom(int domain, long pages)
 {
 	unsigned long free, allowed;

+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);

         /*
@@ -382,7 +388,7 @@ EXPORT_SYMBOL(cap_inode_removexattr);
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
-EXPORT_SYMBOL(cap_vm_enough_memory);
+EXPORT_SYMBOL(cap_vm_enough_acctdom);

 MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
 MODULE_LICENSE("GPL");
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c 
current/security/dummy.c
--- reference/security/dummy.c	2004-03-11 20:47:31.000000000 +0000
+++ current/security/dummy.c	2004-03-17 19:10:23.000000000 +0000
@@ -101,10 +101,24 @@ static int dummy_syslog (int type)
 	return 0;
 }

-static int dummy_vm_enough_memory(long pages)
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 0 means there is enough memory for the allocation to
+ * succeed and -ENOMEM implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
+ */
+static int dummy_vm_enough_acctdom(int domain, long pages)
 {
 	unsigned long free, allowed;

+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);

         /*
@@ -873,7 +887,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, syslog);
-	set_to_dummy_if_null(ops, vm_enough_memory);
+	set_to_dummy_if_null(ops, vm_enough_acctdom);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_compute_creds);
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c 
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-11 20:47:31.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-17 19:10:23.000000000 +0000
@@ -1492,17 +1492,23 @@ static int selinux_syslog(int type)
  * succeed and -ENOMEM implies there is not.
  *
  * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-accounting
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-static int selinux_vm_enough_memory(long pages)
+static int selinux_vm_enough_acctdom(int domain, long pages)
 {
 	unsigned long free, allowed;
 	int rc;
 	struct task_security_struct *tsec = current->security;

+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain != VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);

         /*
@@ -3817,7 +3823,7 @@ struct security_operations selinux_ops =
 	.quotactl =			selinux_quotactl,
 	.quota_on =			selinux_quota_on,
 	.syslog =			selinux_syslog,
-	.vm_enough_memory =		selinux_vm_enough_memory,
+	.vm_enough_acctdom =		selinux_vm_enough_acctdom,

 	.netlink_send =			selinux_netlink_send,
         .netlink_recv =			selinux_netlink_recv,


