Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbUCXRiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUCXRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:38:50 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:41480 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263794AbUCXRge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:36:34 -0500
Date: Wed, 24 Mar 2004 17:38:50 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory
 machines.......
Message-ID: <27410564.1080149929@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <26583785.1080063030@42.150.104.212.access.eclipse.net.uk>
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de>
 <20040313184547.6e127b51.akpm@osdl.org> <20040314040634.GC19737@krispykreme>
 <37640233.1079550324@42.150.104.212.access.eclipse.net.uk>
 <26583785.1080063030@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========60A328E7E347DFF585CE=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the next installment of HUGETLB memory accounting.  With the stack
applied (to 2.6.4) HUGETLB allocations are be handled separately to those
for normal pages.  The set has been tested lightly on i386.  Other
architectures have not yet been compiled (testers please).  Currently there
are no tunables for overcommit.  Again patches attached, ask if you need
them inline.

This patch has an interesting and I believe correct side effect.  Memory is
now committed when a hugetlb segment is initially requested, even before it
is attached.  Thus it is no longer possible to shmget many large segments
and have them fail to attach.

The patch list below ...  Comments??

-apw

010-overcommit_docs:		documentation changes
015-do_mremap_warning:		cleanup exit handling to prevent warning
050-mem_acctdom_core:		core changes to create two accounting domains
055-mem_acctdom_arch:		architecture specific changes for above
060-mem_acctdom_commitments:	splits vm_committed into a per domain count
070-mem_acctdom_hugetlb: 	use vm_committed to track HUGETLB usage
075-em_acctdom_hugetlb_arch:	architecture specific changes for above

The first two patches are cosmetic fixes, either in documentation or to
remove a warning later in the game.

The third and fourth patches patches set the scene.  These are the most
tested and it is these that I hope Anton can test for us with his "real
world" failure mode. These two patches introduce the concept of a split
between the default and hugetlb memory pools and stop the hugtlb pool being
accounted at all.  This is not as clean as I would like, particularly the
need to check against VM_AD_DEFAULT in a few places.

The fifth patch splits the vm_committed count into a per domain count and
exposes the domain in the interface.

The sixth and seventh patch converts hugetlb to use the vm_commitment
interfaces exposed above.

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1;
 name="075-mem_acctdom_hugetlb_arch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="075-mem_acctdom_hugetlb_arch.txt";
 size=6232

---
 i386/mm/hugetlbpage.c    |   16 +++++++++++++---
 ia64/mm/hugetlbpage.c    |   16 +++++++++++++---
 ppc64/mm/hugetlbpage.c   |   16 +++++++++++++---
 sparc64/mm/hugetlbpage.c |   16 +++++++++++++---
 4 files changed, 52 insertions(+), 12 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/hugetlbpage.c =
current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-01-09 07:00:02.000000000 =
+0000
+++ current/arch/i386/mm/hugetlbpage.c	2004-03-24 18:03:05.000000000 +0000
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -513,13 +513,17 @@ module_init(hugetlb_init);
=20
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed =3D atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
=20
 int is_hugepage_mem_enough(size_t size)
@@ -527,6 +531,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <=3D htlbpagemem;
 }
=20
+/* Return the number pages of memory we physically have, in PAGE_SIZE =
units. */
+int hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/ia64/mm/hugetlbpage.c =
current/arch/ia64/mm/hugetlbpage.c
--- reference/arch/ia64/mm/hugetlbpage.c	2004-03-11 20:47:12.000000000 =
+0000
+++ current/arch/ia64/mm/hugetlbpage.c	2004-03-24 18:07:31.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -576,13 +576,17 @@ __initcall(hugetlb_init);
=20
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed =3D atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
=20
 int is_hugepage_mem_enough(size_t size)
@@ -592,6 +596,12 @@ int is_hugepage_mem_enough(size_t size)
 	return 1;
 }
=20
+/* Return the number pages of memory we physically have, in PAGE_SIZE =
units. */
+unsigned long hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned =
long address, int *unused)
 {
 	BUG();
diff -X /home/apw/lib/vdiff.excl -rupN =
reference/arch/ppc64/mm/hugetlbpage.c current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-03-11 20:47:14.000000000 =
+0000
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-03-24 18:11:09.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -896,13 +896,17 @@ module_init(hugetlb_init);
=20
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed =3D atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5d\n"
 			"HugePages_Free:  %5d\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB",
 			htlbpage_total,
 			htlbpage_free,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(commited));
 }
=20
 /* This is advisory only, so we can get away with accesing
@@ -912,6 +916,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <=3D htlbpage_free;
 }
=20
+/* Return the number pages of memory we physically have, in PAGE_SIZE =
units. */
+int hugetlb_total_pages(void)
+{
+	return htlbpage_total * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -X /home/apw/lib/vdiff.excl -rupN =
reference/arch/sparc64/mm/hugetlbpage.c =
current/arch/sparc64/mm/hugetlbpage.c
--- reference/arch/sparc64/mm/hugetlbpage.c	2004-01-09 06:59:45.000000000 =
+0000
+++ current/arch/sparc64/mm/hugetlbpage.c	2004-03-24 18:12:11.000000000 =
+0000
@@ -13,8 +13,8 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/mman.h>
=20
-#include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -483,13 +483,17 @@ module_init(hugetlb_init);
=20
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed =3D atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
=20
 int is_hugepage_mem_enough(size_t size)
@@ -497,6 +501,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <=3D htlbpagemem;
 }
=20
+/* Return the number pages of memory we physically have, in PAGE_SIZE =
units. */
+int hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1; name="015-do_mremap_warning.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="015-do_mremap_warning.txt";
 size=1286

do_remap takes a memory commitment about half way though.  Error exits =
prior
to this check unnecessarily as to whether we need to release this memory
commitment.  This patch clarifies the exit requirements.

---
 mremap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -upN reference/mm/mremap.c current/mm/mremap.c
--- reference/mm/mremap.c	2004-02-23 18:15:13.000000000 +0000
+++ current/mm/mremap.c	2004-03-23 15:29:42.000000000 +0000
@@ -401,7 +401,7 @@ unsigned long do_mremap(unsigned long ad
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged =3D (new_len - old_len) >> PAGE_SHIFT;
 		if (security_vm_enough_memory(charged))
-			goto out_nc;
+			goto out;
 	}
=20
 	/* old_len exactly to the end of the area..
@@ -426,7 +426,7 @@ unsigned long do_mremap(unsigned long ad
 						   addr + new_len);
 			}
 			ret =3D addr;
-			goto out;
+			goto out_rc;
 		}
 	}
=20
@@ -445,14 +445,14 @@ unsigned long do_mremap(unsigned long ad
 						vma->vm_pgoff, map_flags);
 			ret =3D new_addr;
 			if (new_addr & ~PAGE_MASK)
-				goto out;
+				goto out_rc;
 		}
 		ret =3D move_vma(vma, addr, old_len, new_len, new_addr);
 	}
-out:
+out_rc:
 	if (ret & ~PAGE_MASK)
 		vm_unacct_memory(charged);
-out_nc:
+out:
 	return ret;
 }
=20

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1; name="050-mem_acctdom_core.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="050-mem_acctdom_core.txt";
 size=14853

When hugetlb memory is in user we effectivly split memory into to
two independent and non-overlapping 'page' pools from which we can
allocate pages and against which we wish to handle commitments.
Currently all allocations are accounted against the normal page pool
which can lead to false allocation failures.

This patch provides the framework to allow these pools to be treated
separatly, preventing allocation in the hugetlb pool from being accounted
against the small page pool.  The hugetlb page pool is not accounted at all
and effectibly is treated as in overcommit mode.

The patch creates the concept of an accounting domain, against which
pages are to be accounted.  In this implementation there are two
domains VM_AD_DEFAULT which is used to account normal small pages
in the normal way and VM_AD_HUGETLB which is used to select and
identify VM_HUGETLB pages.  I have not attempted to add any actual
accounting for VM_HUGETLB pages, as currently they are prefaulted and
thus there is always 0 outstanding commitment to track.  Obviously,
if hugetlb was also changed to support demand paging that would
need to be implemented.

---
 fs/exec.c                |    2 +-
 include/linux/mm.h       |    6 ++++++
 include/linux/security.h |   15 ++++++++-------
 kernel/fork.c            |    8 +++++---
 mm/memory.c              |    1 +
 mm/mmap.c                |   18 +++++++++++-------
 mm/mprotect.c            |    5 +++--
 mm/mremap.c              |    3 ++-
 mm/shmem.c               |   10 ++++++----
 mm/swapfile.c            |    2 +-
 security/commoncap.c     |    8 +++++++-
 security/dummy.c         |    8 +++++++-
 security/selinux/hooks.c |    8 +++++++-
 13 files changed, 65 insertions(+), 29 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/exec.c =
current/fs/exec.c
--- reference/fs/exec.c	2004-03-11 20:47:24.000000000 +0000
+++ current/fs/exec.c	2004-03-23 15:29:40.000000000 +0000
@@ -409,7 +409,7 @@ int setup_arg_pages(struct linux_binprm=20
 	if (!mpnt)
 		return -ENOMEM;
=20
-	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT, arg_size >> PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mm.h =
current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-11 20:47:28.000000000 +0000
+++ current/include/linux/mm.h	2004-03-23 15:29:40.000000000 +0000
@@ -112,6 +112,12 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
=20
+/* Memory accounting domains. */
+#define VM_ACCTDOM_NR	2
+#define VM_ACCTDOM(vma) (!!((vma)->vm_flags & VM_HUGETLB))
+#define VM_AD_DEFAULT	0
+#define VM_AD_HUGETLB	1
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/security.h =
current/include/linux/security.h
--- reference/include/linux/security.h	2004-03-11 20:47:28.000000000 +0000
+++ current/include/linux/security.h	2004-03-23 15:29:40.000000000 +0000
@@ -51,7 +51,7 @@ extern int cap_inode_removexattr(struct=20
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t =
old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
-extern int cap_vm_enough_memory (long pages);
+extern int cap_vm_enough_memory (int domain, long pages);
=20
 static inline int cap_netlink_send (struct sk_buff *skb)
 {
@@ -988,7 +988,8 @@ struct swap_info_struct;
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
  * @vm_enough_memory:
- *	Check permissions for allocating a new virtual mapping.
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
+	int (*vm_enough_memory) (int domain, long pages);
=20
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -1276,9 +1277,9 @@ static inline int security_syslog(int ty
 	return security_ops->syslog(type);
 }
=20
-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_memory(int domain, long pages)
 {
-	return security_ops->vm_enough_memory(pages);
+	return security_ops->vm_enough_memory(domain, pages);
 }
=20
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
@@ -1947,9 +1948,9 @@ static inline int security_syslog(int ty
 	return cap_syslog(type);
 }
=20
-static inline int security_vm_enough_memory(long pages)
+static inline int security_vm_enough_memory(int domain, long pages)
 {
-	return cap_vm_enough_memory(pages);
+	return cap_vm_enough_memory(domain, pages);
 }
=20
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/fork.c =
current/kernel/fork.c
--- reference/kernel/fork.c	2004-03-11 20:47:29.000000000 +0000
+++ current/kernel/fork.c	2004-03-23 16:29:48.000000000 +0000
@@ -301,9 +301,10 @@ static inline int dup_mmap(struct mm_str
 			continue;
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len =3D (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
-			if (security_vm_enough_memory(len))
+			if (security_vm_enough_memory(VM_ACCTDOM(mpnt), len))
 				goto fail_nomem;
-			charge +=3D len;
+			if (VM_ACCTDOM(mpnt) =3D=3D VM_AD_DEFAULT)
+				charge +=3D len;
 		}
 		tmp =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
@@ -358,7 +359,8 @@ out:
 fail_nomem:
 	retval =3D -ENOMEM;
 fail:
-	vm_unacct_memory(charge);
+	if (charge)
+		vm_unacct_memory(charge);
 	goto out;
 }
 static inline int mm_alloc_pgd(struct mm_struct * mm)
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/memory.c =
current/mm/memory.c
--- reference/mm/memory.c	2004-03-11 20:47:29.000000000 +0000
+++ current/mm/memory.c	2004-03-23 16:29:48.000000000 +0000
@@ -551,6 +551,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		if (end <=3D vma->vm_start)
 			continue;
=20
+		/* We assume that only accountable VMAs are VM_ACCOUNT. */
 		if (vma->vm_flags & VM_ACCOUNT)
 			*nr_accounted +=3D (end - start) >> PAGE_SHIFT;
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mmap.c =
current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-11 20:47:29.000000000 +0000
+++ current/mm/mmap.c	2004-03-23 16:29:48.000000000 +0000
@@ -473,8 +473,11 @@ unsigned long do_mmap_pgoff(struct file=20
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged =3D 0;
+	long acctdom =3D VM_AD_DEFAULT;
=20
 	if (file) {
+		if (is_file_hugepages(file))
+			acctdom =3D VM_AD_HUGETLB;
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
=20
@@ -591,7 +594,8 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
=20
-	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+	if (acctdom =3D=3D VM_AD_DEFAULT && (!(flags & MAP_NORESERVE) ||=20
+	    sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |=3D VM_ACCOUNT;
@@ -600,7 +604,7 @@ munmap_back:
 			 * Private writable mapping: check memory availability
 			 */
 			charged =3D len >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(acctdom, charged))
 				return -ENOMEM;
 			vm_flags |=3D VM_ACCOUNT;
 		}
@@ -909,8 +913,8 @@ int expand_stack(struct vm_area_struct *
  	spin_lock(&vma->vm_mm->page_table_lock);
 	grow =3D (address - vma->vm_end) >> PAGE_SHIFT;
=20
-	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	/* Overcommit ... assume stack is in normal memory */
+	if (security_vm_enough_memory(VM_AD_DEFAULT, grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -963,8 +967,8 @@ int expand_stack(struct vm_area_struct *
  	spin_lock(&vma->vm_mm->page_table_lock);
 	grow =3D (vma->vm_start - address) >> PAGE_SHIFT;
=20
-	/* Overcommit.. */
-	if (security_vm_enough_memory(grow)) {
+	/* Overcommit ... assume stack is in normal memory */
+	if (security_vm_enough_memory(VM_AD_DEFAULT, grow)) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
 	}
@@ -1361,7 +1365,7 @@ unsigned long do_brk(unsigned long addr,
 	if (mm->map_count > MAX_MAP_COUNT)
 		return -ENOMEM;
=20
-	if (security_vm_enough_memory(len >> PAGE_SHIFT))
+	if (security_vm_enough_memory(VM_AD_DEFAULT, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
 	flags =3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mprotect.c =
current/mm/mprotect.c
--- reference/mm/mprotect.c	2004-01-09 06:59:26.000000000 +0000
+++ current/mm/mprotect.c	2004-03-23 16:29:48.000000000 +0000
@@ -173,9 +173,10 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED)) &&
+				VM_ACCTDOM(vma) =3D=3D VM_AD_DEFAULT) {
 			charged =3D (end - start) >> PAGE_SHIFT;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 				return -ENOMEM;
 			newflags |=3D VM_ACCOUNT;
 		}
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mremap.c =
current/mm/mremap.c
--- reference/mm/mremap.c	2004-03-23 15:29:42.000000000 +0000
+++ current/mm/mremap.c	2004-03-23 16:29:48.000000000 +0000
@@ -398,9 +398,10 @@ unsigned long do_mremap(unsigned long ad
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
=20
+	/* We assume that only accountable VMAs are VM_ACCOUNT. */
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged =3D (new_len - old_len) >> PAGE_SHIFT;
-		if (security_vm_enough_memory(charged))
+ 		if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 			goto out;
 	}
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/shmem.c =
current/mm/shmem.c
--- reference/mm/shmem.c	2004-02-04 15:09:17.000000000 +0000
+++ current/mm/shmem.c	2004-03-23 15:29:40.000000000 +0000
@@ -526,7 +526,7 @@ static int shmem_notify_change(struct de
 	 	 */
 		change =3D VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
 		if (change > 0) {
-			if (security_vm_enough_memory(change))
+			if (security_vm_enough_memory(VM_AD_DEFAULT, change))
 				return -ENOMEM;
 		} else if (attr->ia_size < inode->i_size) {
 			vm_unacct_memory(-change);
@@ -1193,7 +1193,8 @@ shmem_file_write(struct file *file, cons
 	maxpos =3D inode->i_size;
 	if (maxpos < pos + count) {
 		maxpos =3D pos + count;
-		if (security_vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) =
{
+		if (security_vm_enough_memory(VM_AD_DEFAULT,
+				VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err =3D -ENOMEM;
 			goto out;
 		}
@@ -1554,7 +1555,7 @@ static int shmem_symlink(struct inode *d
 		memcpy(info, symname, len);
 		inode->i_op =3D &shmem_symlink_inline_operations;
 	} else {
-		if (security_vm_enough_memory(VM_ACCT(1))) {
+		if (security_vm_enough_memory(VM_AD_DEFAULT, VM_ACCT(1))) {
 			iput(inode);
 			return -ENOMEM;
 		}
@@ -1950,7 +1951,8 @@ struct file *shmem_file_setup(char *name
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
=20
-	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_ACCT(size)))
+	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_AD_DEFAULT,
+			VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
=20
 	error =3D -ENOMEM;
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/swapfile.c =
current/mm/swapfile.c
--- reference/mm/swapfile.c	2004-02-23 18:15:13.000000000 +0000
+++ current/mm/swapfile.c	2004-03-23 15:29:40.000000000 +0000
@@ -1048,7 +1048,7 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
-	if (!security_vm_enough_memory(p->pages))
+	if (!security_vm_enough_memory(VM_AD_DEFAULT, p->pages))
 		vm_unacct_memory(p->pages);
 	else {
 		err =3D -ENOMEM;
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c =
current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-23 15:29:41.000000000 +0000
+++ current/security/commoncap.c	2004-03-23 15:29:40.000000000 +0000
@@ -308,10 +308,16 @@ int cap_syslog (int type)
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-int cap_vm_enough_memory(long pages)
+int cap_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
=20
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain !=3D VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
=20
         /*
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c =
current/security/dummy.c
--- reference/security/dummy.c	2004-03-23 15:29:41.000000000 +0000
+++ current/security/dummy.c	2004-03-23 15:29:40.000000000 +0000
@@ -109,10 +109,16 @@ static int dummy_syslog (int type)
  * We currently support three overcommit policies, which are set via the
  * vm.overcommit_memory sysctl.  See =
Documentation/vm/overcommit-accounting
  */
-static int dummy_vm_enough_memory(long pages)
+static int dummy_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
=20
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain !=3D VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
=20
         /*
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c =
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-23 15:29:41.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-23 15:29:40.000000000 +0000
@@ -1497,12 +1497,18 @@ static int selinux_syslog(int type)
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
  */
-static int selinux_vm_enough_memory(long pages)
+static int selinux_vm_enough_memory(int domain, long pages)
 {
 	unsigned long free, allowed;
 	int rc;
 	struct task_security_struct *tsec =3D current->security;
=20
+	/* We only account for the default memory domain, assume overcommit
+	 * for all others.
+	 */
+	if (domain !=3D VM_AD_DEFAULT)
+		return 0;
+
 	vm_acct_memory(pages);
=20
         /*

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1; name="055-mem_acctdom_arch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="055-mem_acctdom_arch.txt";
 size=2703

---
 ia64/ia32/binfmt_elf32.c  |    3 ++-
 mips/kernel/sysirix.c     |    3 ++-
 s390/kernel/compat_exec.c |    3 ++-
 x86_64/ia32/ia32_binfmt.c |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff -upN reference/arch/ia64/ia32/binfmt_elf32.c =
current/arch/ia64/ia32/binfmt_elf32.c
--- reference/arch/ia64/ia32/binfmt_elf32.c	2004-03-11 20:47:12.000000000 =
+0000
+++ current/arch/ia64/ia32/binfmt_elf32.c	2004-03-23 15:29:42.000000000 =
+0000
@@ -168,7 +168,8 @@ ia32_setup_arg_pages (struct linux_binpr
 	if (!mpnt)
 		return -ENOMEM;
=20
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned =
long) bprm->p))>>PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT, (IA32_STACK_TOP -
+			(PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
diff -upN reference/arch/mips/kernel/sysirix.c =
current/arch/mips/kernel/sysirix.c
--- reference/arch/mips/kernel/sysirix.c	2004-03-11 20:47:13.000000000 =
+0000
+++ current/arch/mips/kernel/sysirix.c	2004-03-23 15:29:42.000000000 +0000
@@ -578,7 +578,8 @@ asmlinkage int irix_brk(unsigned long br
 	/*
 	 * Check if we have enough memory..
 	 */
-	if (security_vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT,
+			(newbrk-oldbrk) >> PAGE_SHIFT)) {
 		ret =3D -ENOMEM;
 		goto out;
 	}
diff -upN reference/arch/s390/kernel/compat_exec.c =
current/arch/s390/kernel/compat_exec.c
--- reference/arch/s390/kernel/compat_exec.c	2004-01-09 06:59:57.000000000 =
+0000
+++ current/arch/s390/kernel/compat_exec.c	2004-03-23 15:29:42.000000000 =
+0000
@@ -56,7 +56,8 @@ int setup_arg_pages32(struct linux_binpr
 	if (!mpnt)=20
 		return -ENOMEM;=20
 	
-	if (security_vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) =
bprm->p))>>PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT, (STACK_TOP -
+			(PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}
diff -upN reference/arch/x86_64/ia32/ia32_binfmt.c =
current/arch/x86_64/ia32/ia32_binfmt.c
--- reference/arch/x86_64/ia32/ia32_binfmt.c	2004-03-11 20:47:15.000000000 =
+0000
+++ current/arch/x86_64/ia32/ia32_binfmt.c	2004-03-23 15:29:42.000000000 =
+0000
@@ -345,7 +345,8 @@ int setup_arg_pages(struct linux_binprm=20
 	if (!mpnt)=20
 		return -ENOMEM;=20
 	
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned =
long) bprm->p))>>PAGE_SHIFT)) {
+	if (security_vm_enough_memory(VM_AD_DEFAULT, (IA32_STACK_TOP -
+			(PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1;
 name="060-mem_acctdom_commitments.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="060-mem_acctdom_commitments.txt";
 size=18940

Currently only normal page commitments are tracked.  This patch
provides a framework for tracking page commitments in multiple
independant domains.  With this patch vm_commited_space becomes a
per domain trackable.

---
 fs/proc/proc_misc.c      |    2 +-
 include/linux/mm.h       |   13 +++++++++++--
 include/linux/mman.h     |   12 ++++++------
 kernel/fork.c            |    8 +++-----
 mm/memory.c              |   12 +++++++++---
 mm/mmap.c                |   23 ++++++++++++-----------
 mm/mprotect.c            |    5 ++---
 mm/mremap.c              |    2 +-
 mm/nommu.c               |    3 ++-
 mm/shmem.c               |   13 +++++++------
 mm/swap.c                |   17 +++++++++++++----
 mm/swapfile.c            |    4 +++-
 security/commoncap.c     |   10 +++++-----
 security/dummy.c         |   10 +++++-----
 security/selinux/hooks.c |   10 +++++-----
 15 files changed, 85 insertions(+), 59 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/proc/proc_misc.c =
current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-03-11 20:47:27.000000000 +0000
+++ current/fs/proc/proc_misc.c	2004-03-24 16:09:07.000000000 +0000
@@ -174,7 +174,7 @@ static int meminfo_read_proc(char *page,
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	committed =3D atomic_read(&vm_committed_space);
+	committed =3D atomic_read(&vm_committed_space[VM_AD_DEFAULT]);
=20
 	vmtot =3D (VMALLOC_END-VMALLOC_START)>>10;
 	vmi =3D get_vmalloc_info();
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mman.h =
current/include/linux/mman.h
--- reference/include/linux/mman.h	2004-01-09 06:59:09.000000000 +0000
+++ current/include/linux/mman.h	2004-03-24 16:09:07.000000000 +0000
@@ -12,20 +12,20 @@
=20
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
-extern atomic_t vm_committed_space;
+extern atomic_t vm_committed_space[];
=20
 #ifdef CONFIG_SMP
-extern void vm_acct_memory(long pages);
+extern void vm_acct_memory(int domain, long pages);
 #else
-static inline void vm_acct_memory(long pages)
+static inline void vm_acct_memory(int domain, long pages)
 {
-	atomic_add(pages, &vm_committed_space);
+	atomic_add(pages, &vm_committed_space[domain]);
 }
 #endif
=20
-static inline void vm_unacct_memory(long pages)
+static inline void vm_unacct_memory(int domain, long pages)
 {
-	vm_acct_memory(-pages);
+	vm_acct_memory(domain, -pages);
 }
=20
 /*
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mm.h =
current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-23 16:30:13.000000000 +0000
+++ current/include/linux/mm.h	2004-03-24 16:09:07.000000000 +0000
@@ -117,7 +117,16 @@ struct vm_area_struct {
 #define VM_ACCTDOM(vma) (!!((vma)->vm_flags & VM_HUGETLB))
 #define VM_AD_DEFAULT	0
 #define VM_AD_HUGETLB	1
-
+typedef struct {
+	long vec[VM_ACCTDOM_NR];
+} madv_t;
+#define MADV_NONE { {[0 ... VM_ACCTDOM_NR-1] =3D  0UL} }
+static inline void madv_add(madv_t *madv, int domain, long size)
+{
+	madv->vec[domain] +=3D size;
+}
+void vm_unacct_memory_domains(madv_t *madv);
+ =20
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
@@ -440,7 +449,7 @@ void zap_page_range(struct vm_area_struc
 			unsigned long size);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted);
+		unsigned long end_addr, madv_t *nr_accounted);
 void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			unsigned long address, unsigned long size);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int =
nr);
diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/fork.c =
current/kernel/fork.c
--- reference/kernel/fork.c	2004-03-23 16:30:13.000000000 +0000
+++ current/kernel/fork.c	2004-03-24 16:09:07.000000000 +0000
@@ -267,7 +267,7 @@ static inline int dup_mmap(struct mm_str
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge =3D 0;
+	madv_t charge =3D MADV_NONE;
=20
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
@@ -303,8 +303,7 @@ static inline int dup_mmap(struct mm_str
 			unsigned int len =3D (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(VM_ACCTDOM(mpnt), len))
 				goto fail_nomem;
-			if (VM_ACCTDOM(mpnt) =3D=3D VM_AD_DEFAULT)
-				charge +=3D len;
+ 			madv_add(&charge, VM_ACCTDOM(mpnt), len);
 		}
 		tmp =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
@@ -359,8 +358,7 @@ out:
 fail_nomem:
 	retval =3D -ENOMEM;
 fail:
-	if (charge)
-		vm_unacct_memory(charge);
+	vm_unacct_memory_domains(&charge);
 	goto out;
 }
 static inline int mm_alloc_pgd(struct mm_struct * mm)
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/memory.c =
current/mm/memory.c
--- reference/mm/memory.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/memory.c	2004-03-24 16:09:07.000000000 +0000
@@ -524,7 +524,7 @@ void unmap_page_range(struct mmu_gather=20
  */
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted)
+		unsigned long end_addr, madv_t *nr_accounted)
 {
 	unsigned long zap_bytes =3D ZAP_BLOCK_SIZE;
 	unsigned long tlb_start =3D 0;	/* For tlb_finish_mmu */
@@ -553,7 +553,8 @@ int unmap_vmas(struct mmu_gather **tlbp,
=20
 		/* We assume that only accountable VMAs are VM_ACCOUNT. */
 		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted +=3D (end - start) >> PAGE_SHIFT;
+			madv_add(nr_accounted,
+				VM_ACCTDOM(vma), (end - start) >> PAGE_SHIFT);
=20
 		ret++;
 		while (start !=3D end) {
@@ -602,7 +603,12 @@ void zap_page_range(struct vm_area_struc
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct mmu_gather *tlb;
 	unsigned long end =3D address + size;
-	unsigned long nr_accounted =3D 0;
+	madv_t nr_accounted =3D MADV_NONE;
+
+	/* XXX: we seem to avoid thinking about the memory accounting
+	 * for both the hugepages where don't bother even tracking it and
+	 * in the normal path where we figure it out and do nothing with it??
+	 */
=20
 	might_sleep();
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mmap.c =
current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/mmap.c	2004-03-24 16:09:07.000000000 +0000
@@ -54,7 +54,8 @@ pgprot_t protection_map[16] =3D {
=20
 int sysctl_overcommit_memory =3D 0;	/* default is heuristic overcommit */
 int sysctl_overcommit_ratio =3D 50;	/* default is 50% */
-atomic_t vm_committed_space =3D ATOMIC_INIT(0);
+atomic_t vm_committed_space[VM_ACCTDOM_NR] =3D=20
+     { [ 0 ... VM_ACCTDOM_NR-1 ] =3D ATOMIC_INIT(0) };
=20
 EXPORT_SYMBOL(sysctl_overcommit_memory);
 EXPORT_SYMBOL(sysctl_overcommit_ratio);
@@ -594,8 +595,8 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
=20
-	if (acctdom =3D=3D VM_AD_DEFAULT && (!(flags & MAP_NORESERVE) ||=20
-	    sysctl_overcommit_memory > 1)) {
+	if (!(flags & MAP_NORESERVE) ||=20
+	    (acctdom =3D=3D VM_AD_DEFAULT && sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |=3D VM_ACCOUNT;
@@ -713,7 +714,7 @@ free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
 	if (charged)
-		vm_unacct_memory(charged);
+		vm_unacct_memory(acctdom, charged);
 	return error;
 }
=20
@@ -923,7 +924,7 @@ int expand_stack(struct vm_area_struct *
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
-		vm_unacct_memory(grow);
+		vm_unacct_memory(VM_AD_DEFAULT, grow);
 		return -ENOMEM;
 	}
 	vma->vm_end =3D address;
@@ -977,7 +978,7 @@ int expand_stack(struct vm_area_struct *
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
-		vm_unacct_memory(grow);
+		vm_unacct_memory(VM_AD_DEFAULT, grow);
 		return -ENOMEM;
 	}
 	vma->vm_start =3D address;
@@ -1135,12 +1136,12 @@ static void unmap_region(struct mm_struc
 	unsigned long end)
 {
 	struct mmu_gather *tlb;
-	unsigned long nr_accounted =3D 0;
+	madv_t nr_accounted =3D MADV_NONE;
=20
 	lru_add_drain();
 	tlb =3D tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted);
-	vm_unacct_memory(nr_accounted);
+	vm_unacct_memory_domains(&nr_accounted);
=20
 	if (is_hugepage_only_range(start, end - start))
 		hugetlb_free_pgtables(tlb, prev, start, end);
@@ -1380,7 +1381,7 @@ unsigned long do_brk(unsigned long addr,
 	 */
 	vma =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
+		vm_unacct_memory(VM_AD_DEFAULT, len >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
=20
@@ -1413,7 +1414,7 @@ void exit_mmap(struct mm_struct *mm)
 {
 	struct mmu_gather *tlb;
 	struct vm_area_struct *vma;
-	unsigned long nr_accounted =3D 0;
+	madv_t nr_accounted =3D MADV_NONE;
=20
 	profile_exit_mmap(mm);
 =20
@@ -1426,7 +1427,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use ~0UL here to ensure all VMAs in the mm are unmapped */
 	mm->map_count -=3D unmap_vmas(&tlb, mm, mm->mmap, 0,
 					~0UL, &nr_accounted);
-	vm_unacct_memory(nr_accounted);
+	vm_unacct_memory_domains(&nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mprotect.c =
current/mm/mprotect.c
--- reference/mm/mprotect.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/mprotect.c	2004-03-24 16:09:07.000000000 +0000
@@ -173,8 +173,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED)) &&
-				VM_ACCTDOM(vma) =3D=3D VM_AD_DEFAULT) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged =3D (end - start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 				return -ENOMEM;
@@ -218,7 +217,7 @@ success:
 	return 0;
=20
 fail:
-	vm_unacct_memory(charged);
+	vm_unacct_memory(VM_ACCTDOM(vma), charged);
 	return error;
 }
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mremap.c =
current/mm/mremap.c
--- reference/mm/mremap.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/mremap.c	2004-03-24 16:09:07.000000000 +0000
@@ -452,7 +452,7 @@ unsigned long do_mremap(unsigned long ad
 	}
 out_rc:
 	if (ret & ~PAGE_MASK)
-		vm_unacct_memory(charged);
+		vm_unacct_memory(VM_ACCTDOM(vma), charged);
 out:
 	return ret;
 }
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/nommu.c =
current/mm/nommu.c
--- reference/mm/nommu.c	2004-02-04 15:09:16.000000000 +0000
+++ current/mm/nommu.c	2004-03-24 16:09:07.000000000 +0000
@@ -29,7 +29,8 @@ struct page *mem_map;
 unsigned long max_mapnr;
 unsigned long num_physpages;
 unsigned long askedalloc, realalloc;
-atomic_t vm_committed_space =3D ATOMIC_INIT(0);
+atomic_t vm_committed_space[VM_ACCTDOM_NR] =3D=20
+     { [ 0 ... VM_ACCTDOM_NR-1 ] =3D ATOMIC_INIT(0) };
 int sysctl_overcommit_memory; /* default is heuristic overcommit */
 int sysctl_overcommit_ratio =3D 50; /* default is 50% */
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/shmem.c =
current/mm/shmem.c
--- reference/mm/shmem.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/shmem.c	2004-03-24 16:09:07.000000000 +0000
@@ -529,7 +529,7 @@ static int shmem_notify_change(struct de
 			if (security_vm_enough_memory(VM_AD_DEFAULT, change))
 				return -ENOMEM;
 		} else if (attr->ia_size < inode->i_size) {
-			vm_unacct_memory(-change);
+			vm_unacct_memory(VM_AD_DEFAULT, -change);
 			/*
 			 * If truncating down to a partial page, then
 			 * if that page is already allocated, hold it
@@ -564,7 +564,7 @@ static int shmem_notify_change(struct de
 	if (page)
 		page_cache_release(page);
 	if (error)
-		vm_unacct_memory(change);
+		vm_unacct_memory(VM_AD_DEFAULT, change);
 	return error;
 }
=20
@@ -578,7 +578,7 @@ static void shmem_delete_inode(struct in
 		list_del(&info->list);
 		spin_unlock(&shmem_ilock);
 		if (info->flags & VM_ACCOUNT)
-			vm_unacct_memory(VM_ACCT(inode->i_size));
+			vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(inode->i_size));
 		inode->i_size =3D 0;
 		shmem_truncate(inode);
 	}
@@ -1274,7 +1274,8 @@ shmem_file_write(struct file *file, cons
=20
 	/* Short writes give back address space */
 	if (inode->i_size !=3D maxpos)
-		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
+		vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(maxpos) -
+			VM_ACCT(inode->i_size));
 out:
 	up(&inode->i_sem);
 	return err;
@@ -1561,7 +1562,7 @@ static int shmem_symlink(struct inode *d
 		}
 		error =3D shmem_getpage(inode, 0, &page, SGP_WRITE, NULL);
 		if (error) {
-			vm_unacct_memory(VM_ACCT(1));
+			vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(1));
 			iput(inode);
 			return error;
 		}
@@ -1991,7 +1992,7 @@ put_dentry:
 	dput(dentry);
 put_memory:
 	if (flags & VM_ACCOUNT)
-		vm_unacct_memory(VM_ACCT(size));
+		vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(size));
 	return ERR_PTR(error);
 }
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/swap.c =
current/mm/swap.c
--- reference/mm/swap.c	2004-03-11 20:47:29.000000000 +0000
+++ current/mm/swap.c	2004-03-24 16:09:07.000000000 +0000
@@ -365,17 +365,18 @@ unsigned int pagevec_lookup(struct pagev
  */
 #define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
=20
-static DEFINE_PER_CPU(long, committed_space) =3D 0;
+/* XXX: zero this????? */
+static DEFINE_PER_CPU(long, committed_space[VM_ACCTDOM_NR]);
=20
-void vm_acct_memory(long pages)
+void vm_acct_memory(int domain, long pages)
 {
 	long *local;
=20
 	preempt_disable();
-	local =3D &__get_cpu_var(committed_space);
+	local =3D &__get_cpu_var(committed_space[domain]);
 	*local +=3D pages;
 	if (*local > ACCT_THRESHOLD || *local < -ACCT_THRESHOLD) {
-		atomic_add(*local, &vm_committed_space);
+		atomic_add(*local, &vm_committed_space[domain]);
 		*local =3D 0;
 	}
 	preempt_enable();
@@ -383,6 +384,14 @@ void vm_acct_memory(long pages)
 EXPORT_SYMBOL(vm_acct_memory);
 #endif
=20
+void vm_unacct_memory_domains(madv_t *adv)
+{
+	if (adv->vec[0])
+		vm_unacct_memory(VM_AD_DEFAULT, adv->vec[0]);
+	if (adv->vec[1])
+		vm_unacct_memory(VM_AD_DEFAULT, adv->vec[1]);
+}
+
 #ifdef CONFIG_SMP
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/swapfile.c =
current/mm/swapfile.c
--- reference/mm/swapfile.c	2004-03-23 16:30:13.000000000 +0000
+++ current/mm/swapfile.c	2004-03-24 16:09:07.000000000 +0000
@@ -1048,8 +1048,10 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
+	/* There is an assumption here that we only may have swapped things
+	 * from the default memory accounting domain to this device. */
 	if (!security_vm_enough_memory(VM_AD_DEFAULT, p->pages))
-		vm_unacct_memory(p->pages);
+		vm_unacct_memory(VM_AD_DEFAULT, p->pages);
 	else {
 		err =3D -ENOMEM;
 		swap_list_unlock();
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c =
current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-23 16:30:13.000000000 +0000
+++ current/security/commoncap.c	2004-03-24 16:09:07.000000000 +0000
@@ -312,14 +312,14 @@ int cap_vm_enough_memory(int domain, lon
 {
 	unsigned long free, allowed;
=20
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain !=3D VM_AD_DEFAULT)
 		return 0;
=20
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -360,17 +360,17 @@ int cap_vm_enough_memory(int domain, lon
=20
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
=20
 	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
=20
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
=20
 	return -ENOMEM;
 }
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c =
current/security/dummy.c
--- reference/security/dummy.c	2004-03-23 16:30:13.000000000 +0000
+++ current/security/dummy.c	2004-03-24 17:56:16.000000000 +0000
@@ -113,14 +113,14 @@ static int dummy_vm_enough_memory(int do
 {
 	unsigned long free, allowed;
=20
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain !=3D VM_AD_DEFAULT)
 		return 0;
=20
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -148,17 +148,17 @@ static int dummy_vm_enough_memory(int do
=20
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
=20
 	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
=20
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
=20
 	return -ENOMEM;
 }
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c =
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-23 16:30:13.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-24 17:56:28.000000000 +0000
@@ -1503,14 +1503,14 @@ static int selinux_vm_enough_memory(int=20
 	int rc;
 	struct task_security_struct *tsec =3D current->security;
=20
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain !=3D VM_AD_DEFAULT)
 		return 0;
=20
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -1547,17 +1547,17 @@ static int selinux_vm_enough_memory(int=20
=20
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
=20
 	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
=20
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
=20
 	return -ENOMEM;
 }

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1;
 name="070-mem_acctdom_hugetlb.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="070-mem_acctdom_hugetlb.txt";
 size=7437

---
 fs/hugetlbfs/inode.c     |   44 =
++++++++++++++++++++++++++++++++++++++------
 include/linux/hugetlb.h  |    5 +++++
 security/commoncap.c     |    8 ++++++++
 security/dummy.c         |    7 +++++++
 security/selinux/hooks.c |    7 +++++++
 5 files changed, 65 insertions(+), 6 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c =
current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-02-23 18:15:01.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-03-24 17:57:36.000000000 +0000
@@ -26,12 +26,15 @@
 #include <linux/dnotify.h>
 #include <linux/statfs.h>
 #include <linux/security.h>
+#include <linux/mman.h>
=20
 #include <asm/uaccess.h>
=20
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
=20
+#define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -191,6 +194,7 @@ void truncate_hugepages(struct address_s
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
 	struct hugetlbfs_sb_info *sbinfo =3D HUGETLBFS_SB(inode->i_sb);
+	long change;
=20
 	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
@@ -198,6 +202,9 @@ static void hugetlbfs_delete_inode(struc
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
=20
+	change =3D VM_ACCT(inode->i_size) - VM_ACCT(0);
+	if (change)
+		vm_unacct_memory(VM_AD_HUGETLB, change);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
=20
@@ -217,6 +224,7 @@ static void hugetlbfs_forget_inode(struc
 {
 	struct super_block *super_block =3D inode->i_sb;
 	struct hugetlbfs_sb_info *sbinfo =3D HUGETLBFS_SB(super_block);
+	long change;
=20
 	if (hlist_unhashed(&inode->i_hash))
 		goto out_truncate;
@@ -239,6 +247,9 @@ out_truncate:
 	inode->i_state |=3D I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
+	change =3D VM_ACCT(inode->i_size) - VM_ACCT(0);
+	if (change)
+		vm_unacct_memory(VM_AD_HUGETLB, change);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
=20
@@ -312,8 +323,10 @@ static int hugetlb_vmtruncate(struct ino
 	unsigned long pgoff;
 	struct address_space *mapping =3D inode->i_mapping;
=20
+	/*
 	if (offset > inode->i_size)
 		return -EINVAL;
+	*/
=20
 	BUG_ON(offset & ~HPAGE_MASK);
 	pgoff =3D offset >> HPAGE_SHIFT;
@@ -334,6 +347,8 @@ static int hugetlbfs_setattr(struct dent
 	struct inode *inode =3D dentry->d_inode;
 	int error;
 	unsigned int ia_valid =3D attr->ia_valid;
+	long change =3D 0;
+	loff_t csize;
=20
 	BUG_ON(!inode);
=20
@@ -345,15 +360,27 @@ static int hugetlbfs_setattr(struct dent
 	if (error)
 		goto out;
 	if (ia_valid & ATTR_SIZE) {
+		csize =3D i_size_read(inode);
 		error =3D -EINVAL;
-		if (!(attr->ia_size & ~HPAGE_MASK))
-			error =3D hugetlb_vmtruncate(inode, attr->ia_size);
-		if (error)
+		if (!(attr->ia_size & ~HPAGE_MASK))=20
+			goto out;
+		if (attr->ia_size > csize)
 			goto out;
+		change =3D VM_ACCT(csize) - VM_ACCT(attr->ia_size);
+		if (change)
+			vm_unacct_memory(VM_AD_HUGETLB, change);
+		/* XXX: here we commit to removing the mappings, should we do
+		 * this before we attmempt to write the inode or after.  What
+		 * should we do if it fails?
+		 */
+		hugetlb_vmtruncate(inode, attr->ia_size);
 		attr->ia_valid &=3D ~ATTR_SIZE;
 	}
 	error =3D inode_setattr(inode, attr);
 out:
+	if (error && change)
+		vm_acct_memory(VM_AD_HUGETLB, change);
+
 	return error;
 }
=20
@@ -697,8 +724,9 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);
=20
-	if (!is_hugepage_mem_enough(size))
+	if (security_vm_enough_memory(VM_AD_HUGETLB, VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
+
 	n =3D atomic_read(&hugetlbfs_counter);
 	atomic_inc(&hugetlbfs_counter);
=20
@@ -708,8 +736,10 @@ struct file *hugetlb_zero_setup(size_t s
 	quick_string.len =3D strlen(quick_string.name);
 	quick_string.hash =3D 0;
 	dentry =3D d_alloc(root, &quick_string);
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+	if (!dentry) {
+		error =3D -ENOMEM;
+		goto out_committed;
+	}
=20
 	error =3D -ENFILE;
 	file =3D get_empty_filp();
@@ -736,6 +766,8 @@ out_file:
 	put_filp(file);
 out_dentry:
 	dput(dentry);
+out_committed:
+	vm_unacct_memory(VM_AD_HUGETLB, VM_ACCT(size));
 	return ERR_PTR(error);
 }
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/hugetlb.h =
current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-02-23 18:15:09.000000000 +0000
+++ current/include/linux/hugetlb.h	2004-03-24 18:01:27.000000000 +0000
@@ -19,6 +19,7 @@ int hugetlb_prefault(struct address_spac
 void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
+unsigned long hugetbl_total_pages(void);
 struct page *follow_huge_addr(struct mm_struct *mm, struct vm_area_struct =
*vma,
 			unsigned long address, int write);
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
@@ -48,6 +49,10 @@ static inline int is_vm_hugetlb_page(str
 {
 	return 0;
 }
+static inline unsigned long hugetlb_total_pages(void)
+{
+	return 0;
+}
=20
 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, vma, addr, write)	0
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c =
current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-24 17:56:50.000000000 +0000
+++ current/security/commoncap.c	2004-03-24 17:57:36.000000000 +0000
@@ -314,6 +314,13 @@ int cap_vm_enough_memory(int domain, lon
=20
 	vm_acct_memory(domain, pages);
=20
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain =3D=3D VM_AD_HUGETLB) {
+		allowed =3D hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
@@ -367,6 +374,7 @@ int cap_vm_enough_memory(int domain, lon
 	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
+check:
 	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
=20
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c =
current/security/dummy.c
--- reference/security/dummy.c	2004-03-24 17:56:50.000000000 +0000
+++ current/security/dummy.c	2004-03-24 17:57:36.000000000 +0000
@@ -115,6 +115,13 @@ static int dummy_vm_enough_memory(int do
=20
 	vm_acct_memory(domain, pages);
=20
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain =3D=3D VM_AD_HUGETLB) {
+		allowed =3D hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c =
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-24 17:56:50.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-24 17:57:36.000000000 +0000
@@ -1505,6 +1505,13 @@ static int selinux_vm_enough_memory(int=20
=20
 	vm_acct_memory(domain, pages);
=20
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain =3D=3D VM_AD_HUGETLB) {
+		allowed =3D hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */

--==========60A328E7E347DFF585CE==========
Content-Type: text/plain; charset=iso-8859-1; name="010-overcommit_docs.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="010-overcommit_docs.txt"; size=2200

---
 commoncap.c     |    2 +-
 dummy.c         |    8 ++++++++
 selinux/hooks.c |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff -upN reference/security/commoncap.c current/security/commoncap.c
--- reference/security/commoncap.c	2004-02-23 18:15:19.000000000 +0000
+++ current/security/commoncap.c	2004-03-23 15:29:41.000000000 +0000
@@ -303,7 +303,7 @@ int cap_syslog (int type)
  * succeed and -ENOMEM implies there is not.
  *
  * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ * vm.overcommit_memory sysctl.  See =
Documentation/vm/overcommit-accounting
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.
diff -upN reference/security/dummy.c current/security/dummy.c
--- reference/security/dummy.c	2004-03-11 20:47:31.000000000 +0000
+++ current/security/dummy.c	2004-03-23 15:29:41.000000000 +0000
@@ -101,6 +101,14 @@ static int dummy_syslog (int type)
 	return 0;
 }
=20
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 0 means there is enough memory for the allocation to
+ * succeed and -ENOMEM implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See =
Documentation/vm/overcommit-accounting
+ */
 static int dummy_vm_enough_memory(long pages)
 {
 	unsigned long free, allowed;
diff -upN reference/security/selinux/hooks.c =
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-11 20:47:31.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-23 15:29:41.000000000 +0000
@@ -1492,7 +1492,7 @@ static int selinux_syslog(int type)
  * succeed and -ENOMEM implies there is not.
  *
  * We currently support three overcommit policies, which are set via the
- * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ * vm.overcommit_memory sysctl.  See =
Documentation/vm/overcommit-accounting
  *
  * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  * Additional code 2002 Jul 20 by Robert Love.

--==========60A328E7E347DFF585CE==========--

