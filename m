Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263899AbUCZCDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUCZCDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:03:00 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:51722 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263838AbUCZCC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:02:27 -0500
Date: Fri, 26 Mar 2004 02:01:10 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <9049478.1080266470@[192.168.0.89]>
In-Reply-To: <1739144.1080259161@[192.168.0.89]>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
 	<20040325130433.0a61d7ef.akpm@osdl.org>
 	<41997489.1080257240@42.150.104.212.access.eclipse.net.uk>
 <20040325155117.60dbc0e1.akpm@osdl.org> <1739144.1080259161@[192.168.0.89]>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========25B626811AA323F535B2=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========25B626811AA323F535B2==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On 25 March 2004 23:59 +0000 Andy Whitcroft <apw@shadowen.org> wrote:

> --On 25 March 2004 15:51 -0800 Andrew Morton <akpm@osdl.org> wrote:
>
>> I think it's simply:
>>
>> - Make normal overcommit logic skip hugepages completely
>>
>> - Teach the overcommit_memory=2 logic that hugepages are basically
>>   "pinned", so subtract them from the arithmetic.
>>
>> And that's it.  The hugepages are semantically quite different from
>> normal memory (prefaulted, preallocated, unswappable) and we've
>> deliberately avoided pretending otherwise.

Attached is a ground up patch, trying just to cure the overcommit bug.  The 
main thrust is to ensure that VM_ACCOUNT actually only gets set on vma's 
which are indeed accountable.  With that ensured much of the rest comes out 
in the wash.  It also removes the hugetlb memory for the 
overcommit_memory=2 case.

Attached are two patches, core and arch changes.  They have been compile 
tested on i386 and appear to work.  Is that more what you had in mind?

-apw
--==========25B626811AA323F535B2==========
Content-Type: text/plain; charset=iso-8859-1;
 name="055-hugetlb_commit_arch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="055-hugetlb_commit_arch.txt";
 size=2941

---
 i386/mm/hugetlbpage.c    |    6 ++++++
 ia64/mm/hugetlbpage.c    |    6 ++++++
 ppc64/mm/hugetlbpage.c   |    6 ++++++
 sparc64/mm/hugetlbpage.c |    6 ++++++
 4 files changed, 24 insertions(+)

diff -upN reference/arch/i386/mm/hugetlbpage.c =
current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-01-09 07:00:02.000000000 =
+0000
+++ current/arch/i386/mm/hugetlbpage.c	2004-03-26 02:08:46.000000000 +0000
@@ -527,6 +527,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <=3D htlbpagemem;
 }
=20
+/* Return the number pages of memory we physically have, in PAGE_SIZE =
units. */
+unsigned long hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -upN reference/arch/ia64/mm/hugetlbpage.c =
current/arch/ia64/mm/hugetlbpage.c
--- reference/arch/ia64/mm/hugetlbpage.c	2004-03-11 20:47:12.000000000 =
+0000
+++ current/arch/ia64/mm/hugetlbpage.c	2004-03-26 02:08:46.000000000 +0000
@@ -592,6 +592,12 @@ int is_hugepage_mem_enough(size_t size)
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
diff -upN reference/arch/ppc64/mm/hugetlbpage.c =
current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-03-11 20:47:14.000000000 =
+0000
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-03-26 02:08:46.000000000 +0000
@@ -912,6 +912,12 @@ int is_hugepage_mem_enough(size_t size)
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
diff -upN reference/arch/sparc64/mm/hugetlbpage.c =
current/arch/sparc64/mm/hugetlbpage.c
--- reference/arch/sparc64/mm/hugetlbpage.c	2004-01-09 06:59:45.000000000 =
+0000
+++ current/arch/sparc64/mm/hugetlbpage.c	2004-03-26 02:08:46.000000000 =
+0000
@@ -497,6 +497,12 @@ int is_hugepage_mem_enough(size_t size)
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

--==========25B626811AA323F535B2==========
Content-Type: text/plain; charset=iso-8859-1; name="050-hugetlb_commit.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="050-hugetlb_commit.txt"; size=5811

---
 include/linux/hugetlb.h  |    5 +++++
 include/linux/mm.h       |    3 +++
 mm/mmap.c                |    7 ++++++-
 mm/mprotect.c            |    3 ++-
 security/commoncap.c     |    4 +++-
 security/dummy.c         |    4 +++-
 security/selinux/hooks.c |    4 +++-
 7 files changed, 25 insertions(+), 5 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/hugetlb.h =
current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-02-23 18:15:09.000000000 +0000
+++ current/include/linux/hugetlb.h	2004-03-26 02:08:46.000000000 +0000
@@ -19,6 +19,7 @@ int hugetlb_prefault(struct address_spac
 void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
+unsigned long hugetlb_total_pages(void);
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
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mm.h =
current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-25 02:43:39.000000000 +0000
+++ current/include/linux/mm.h	2004-03-26 02:08:46.000000000 +0000
@@ -112,6 +112,9 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
=20
+/* It makes sense to apply VM_ACCOUNT to this vma. */
+#define VM_MAYACCT(vma) (!!((vma)->vm_flags & VM_HUGETLB))
+
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mmap.c =
current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/mmap.c	2004-03-26 02:08:46.000000000 +0000
@@ -489,9 +489,13 @@ unsigned long do_mmap_pgoff(struct file=20
 	int correct_wcount =3D 0;
 	int error;
 	struct rb_node ** rb_link, * rb_parent;
+	int accountable =3D 1;
 	unsigned long charged =3D 0;
=20
 	if (file) {
+		if (is_file_hugepages(file))
+			accountable =3D 0;
+
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
=20
@@ -608,7 +612,8 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
=20
-	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+	if (accountable && (!(flags & MAP_NORESERVE) ||
+			sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |=3D VM_ACCOUNT;
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mprotect.c =
current/mm/mprotect.c
--- reference/mm/mprotect.c	2004-03-26 02:08:48.000000000 +0000
+++ current/mm/mprotect.c	2004-03-26 02:08:46.000000000 +0000
@@ -173,7 +173,8 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))=20
+				&& VM_MAYACCT(vma)) {
 			charged =3D (end - start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(charged))
 				return -ENOMEM;
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c =
current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/commoncap.c	2004-03-26 02:22:03.000000000 +0000
@@ -22,6 +22,7 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
+#include <linux/hugetlb.h>
=20
 int cap_capable (struct task_struct *tsk, int cap)
 {
@@ -358,7 +359,8 @@ int cap_vm_enough_memory(long pages)
 		return -ENOMEM;
 	}
=20
-	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed =3D (totalram_pages - hugetlb_total_pages())
+	       	* sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
 	if (atomic_read(&vm_committed_space) < allowed)
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c =
current/security/dummy.c
--- reference/security/dummy.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/dummy.c	2004-03-26 02:22:12.000000000 +0000
@@ -25,6 +25,7 @@
 #include <linux/netlink.h>
 #include <net/sock.h>
 #include <linux/xattr.h>
+#include <linux/hugetlb.h>
=20
 static int dummy_ptrace (struct task_struct *parent, struct task_struct =
*child)
 {
@@ -146,7 +147,8 @@ static int dummy_vm_enough_memory(long p
 		return -ENOMEM;
 	}
=20
-	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed =3D (totalram_pages - hugetlb_total_pages())
+		* sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
 	if (atomic_read(&vm_committed_space) < allowed)
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c =
current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-25 02:43:44.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-26 02:22:24.000000000 +0000
@@ -59,6 +59,7 @@
 #include <net/af_unix.h>	/* for Unix socket types */
 #include <linux/parser.h>
 #include <linux/nfs_mount.h>
+#include <linux/hugetlb.h>
=20
 #include "avc.h"
 #include "objsec.h"
@@ -1544,7 +1545,8 @@ static int selinux_vm_enough_memory(long
 		return -ENOMEM;
 	}
=20
-	allowed =3D totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed =3D (totalram_pages - hugetlb_total_pages())
+		* sysctl_overcommit_ratio / 100;
 	allowed +=3D total_swap_pages;
=20
 	if (atomic_read(&vm_committed_space) < allowed)

--==========25B626811AA323F535B2==========--

