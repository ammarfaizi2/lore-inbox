Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUESPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUESPbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUESPbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:31:45 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:46596 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264228AbUESPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:31:30 -0400
Date: Wed, 19 May 2004 16:29:40 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       agl@us.ibm.com, david@gibson.dropbear.id.au, mbligh@aracnet.com
Subject: Re: do_page_fault() mm->mmap_sem deadlocks
Message-ID: <255460000.1084980580@[192.168.100.2]>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========9A59EB708DDD873BD32C=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========9A59EB708DDD873BD32C==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--On Monday, May 17, 2004 11:07:45 -0700 Andrew Morton <akpm@osdl.org> 
wrote:

> Yes.  The "oops deadlocks when mmap_sem is held" problem is rather
> irritating, and would be nice to fix.

Ok.

> These kernel-mode faults are by no means uncommon - probably the most
> frequent scenario is:
>
> 	p = malloc(...);
> 	read(fd, p, n);
>
> Here, generic_file_read() will take a copy_to_user() fault for each page
> to COW it.
>
> Which makes one wonder why we aren't caching the result of the previous
> exception table search.  I bet that would get a nice hit rate, and would
> fix up any overhead which your change introduces.
[...]
> Please.  Also please consider (and instrument) a last-hit cache in
> search_exception_tables().  Maybe it should be per-task.

Ok.  As you suggested I tried out a cache for this, per system and per cpu 
versions.  I found that if you are using it on all kernel faults you get 
about a 75% hit ratio.  However, with the instrumentation in it is clear 
that without my additional usage the exception table is rarely used, once 
on a large i386 machine and about 11 times on my smaller i386 machine even 
through a kernbench run.  Indeed, its pretty obvious when you look at it, 
good faults such as the read scenario above match against the address space 
and are handled.  We don't need to look them up in the exceptions table 
unless we cannot fix the fault.

So attempt #2. With the current code as long as we are able to get the 
mmap_sem we will detect the bad pointer and oops as required.  Only if we 
find mmap_sem locked might we be heading for deadlock and is the extra 
'source' check of value.  So I now down_read_trylock mmap_sem and only if 
that fails do I apply the 'source' exception checks.

>From the i386 version:

+       if (!down_read_trylock(&mm->mmap_sem)) {
+               if ((error_code & 4) == 0 && !check_exception(regs))
+                       goto bad_area_nosemaphore;
+               down_read(&mm->mmap_sem);
+       }

This will catch the deadlock case and catches nearly all of the failures 
that full source validation would catch.  Invalid accesses to valid user 
space addresses will succeed as they would currently.  It should add _no_ 
additional overhead for the vast majority of faults.

i386 and ppc64 versions attached.  Testing with kernbench shows no 
performance impact.

-apw
--==========9A59EB708DDD873BD32C==========
Content-Type: text/plain; charset=iso-8859-1;
 name="010-fault_deadlock_ppc64.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="010-fault_deadlock_ppc64.txt";
 size=2680

If a fault in the kernel leads to an unexpected protection fault whilst in
a code path which holds mmap_sem we will deadlock in do_page_fault() while
trying to classify the fault.  By carefully testing the source of the fault
we can detect and OOPS on the vast majority of these, greatly enhancing
diagnosis of such bugs.

---
 fault.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletion(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/ppc64/mm/fault.c =
current/arch/ppc64/mm/fault.c
--- reference/arch/ppc64/mm/fault.c	2004-05-10 14:55:08.000000000 +0100
+++ current/arch/ppc64/mm/fault.c	2004-05-19 14:37:15.000000000 +0100
@@ -75,6 +75,8 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
=20
+int check_exception(struct pt_regs *regs);
+
 /*
  * The error_code parameter is
  *  - DSISR for a non-SLB data access fault,
@@ -110,7 +112,29 @@ void do_page_fault(struct pt_regs *regs,
 		bad_page_fault(regs, address, SIGSEGV);
 		return;
 	}
-	down_read(&mm->mmap_sem);
+
+	/* When running in the kernel we expect faults to occur only to
+	 * addresses in user space.  All other faults represent errors in the
+	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
+	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * we will deadlock attempting to validate the fault against the
+	 * address space.  Luckily the kernel only validly references user
+	 * space from well defined areas of code, which are listed in the
+	 * exceptions table. =20
+	 *
+	 * As the vast majority of faults will be valid we will only perform
+	 * the source reference check when there is a possibilty of a deadlock.
+	 * Attempt to lock the address space, if we cannot we then validate the
+	 * source.  If this is invalid we can skip the address space check,
+	 * thus avoiding the deadlock.
+	 */
+	if (!down_read_trylock(&mm->mmap_sem)) {
+		if (!user_mode(regs) && !check_exception(regs))
+			goto bad_area_nosemaphore;
+
+		down_read(&mm->mmap_sem);
+	}
+
 	vma =3D find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -200,6 +224,7 @@ good_area:
 bad_area:
 	up_read(&mm->mmap_sem);
=20
+bad_area_nosemaphore:
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
 		info.si_signo =3D SIGSEGV;
@@ -259,3 +284,15 @@ void bad_page_fault(struct pt_regs *regs
 	/* kernel has accessed a bad area */
 	die("Kernel access of bad area", regs, sig);
 }
+
+int check_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *entry;
+
+	/* Are we prepared to handle this fault?  */
+	if ((entry =3D search_exception_tables(regs->nip)) !=3D NULL) {
+		return 1;
+	}
+
+	return 0;
+}

--==========9A59EB708DDD873BD32C==========
Content-Type: text/plain; charset=us-ascii; name="015-fault_deadlock_i386.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="015-fault_deadlock_i386.txt";
 size=2597

If a fault in the kernel leads to an unexpected protection fault whilst in
a code path which holds mmap_sem we will deadlock in do_page_fault() while
trying to classify the fault.  By carefully testing the source of the fault
we can detect and OOPS on the vast majority of these, greatly enhancing
diagnosis of such bugs.

---
 extable.c |   12 ++++++++++++
 fault.c   |   22 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff -upN reference/arch/i386/mm/extable.c current/arch/i386/mm/extable.c
--- reference/arch/i386/mm/extable.c	2004-03-11 20:47:12.000000000 +0000
+++ current/arch/i386/mm/extable.c	2004-05-19 12:58:14.000000000 +0100
@@ -34,3 +34,15 @@ int fixup_exception(struct pt_regs *regs
 
 	return 0;
 }
+
+int check_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(regs->eip);
+	if (fixup) {
+		return 1;
+	}
+
+	return 0;
+}
diff -upN reference/arch/i386/mm/fault.c current/arch/i386/mm/fault.c
--- reference/arch/i386/mm/fault.c	2004-01-09 06:59:02.000000000 +0000
+++ current/arch/i386/mm/fault.c	2004-05-19 12:58:14.000000000 +0100
@@ -198,6 +198,7 @@ static inline int is_prefetch(struct pt_
 } 
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
+int check_exception(struct pt_regs *regs);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -262,7 +263,26 @@ asmlinkage void do_page_fault(struct pt_
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
-	down_read(&mm->mmap_sem);
+	/* When running in the kernel we expect faults to occur only to
+	 * addresses in user space.  All other faults represent errors in the
+	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
+	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * we will deadlock attempting to validate the fault against the
+	 * address space.  Luckily the kernel only validly references user
+	 * space from well defined areas of code, which are listed in the
+	 * exceptions table.  
+	 *
+	 * As the vast majority of faults will be valid we will only perform
+	 * the source reference check when there is a possibilty of a deadlock.
+	 * Attempt to lock the address space, if we cannot we then validate the
+	 * source.  If this is invalid we can skip the address space check,
+	 * thus avoiding the deadlock.
+	 */
+	if (!down_read_trylock(&mm->mmap_sem)) {
+		if ((error_code & 4) == 0 && !check_exception(regs))
+			goto bad_area_nosemaphore;
+		down_read(&mm->mmap_sem);
+	}
 
 	vma = find_vma(mm, address);
 	if (!vma)

--==========9A59EB708DDD873BD32C==========--

