Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUEQQAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUEQQAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEQQAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:00:30 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:43280 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261746AbUEQQAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:00:08 -0400
Date: Mon, 17 May 2004 16:58:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
cc: Adam Litke <agl@us.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: do_page_fault() mm->mmap_sem deadlocks
Message-ID: <247360000.1084809527@[192.168.100.2]>
X-Mailer: Mulberry/3.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========527AFBAE1A1046FE7653=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========527AFBAE1A1046FE7653==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Whilst trying to debug a bug in PPC64 unmap handling we noticed that it is  relatively easy for a kernel bug to lead to a deadlock trying to down(mm->mmap_sem) when trying to categorise a fault for handling.  The fault handlers grab the mmap_sem lock to scan the VMA list to see if this fault is against a valid segment of the task address space.  This deadlocks if this task is in a system call which also manipulates the virtual address, such as munmap().  This is very undesirable as it prevents the kernel from detecting the fault and reporting it as an oops severely hampering debug.

Most kernel code should not access any area which leads to a fault.  Indeed the only code which should trigger faults from kernel space are routines dealing with copying data to and from user space.  Fault originating outside of these specific routines are not valid and could be 'failed' without the need to reference current->mm, thereby preventing deadlock and ensuring the failure is reported.

Looking at ppc64 and i386 it seems that all faults from legitimate sources will correspond to accesses from IP's on the exceptions list.  By validating the access against this list we should be able to distinguish the 'good' from the 'bad'.

I have put together patches for both ppc64 and i386 to validate the faults against this list.  Testing on these patches seems to validate this assumption.  I have assumed that faults triggered by kernel space are going to be rare relative to user space as most pointers will have been recently referenced by the calling application, but this search is of concern for performance.  Another option might be to employ a scheme similar to that proposed by wli for detecting scheduler routines, marking all routines using getuser/putuser for contiguous layout in the kernel image, allowing for a simple range comparison to provide this check.  A quick kernbench run on the patched kernels seems to indicate minimal impact (details below).

Do people think this is something which is worth pursuing.  The patches attached are  minimal and there are definatly optimisations to be made (such as sharing the result of the exception lookup).  I guess this might even be something which is worth having as a config option for when hangs is there is deemed to be any degradation?  If people think this is something worth looking at I'll come back with cleaner, better tested and benchmarked patches.

-apw


i386 266:
837.27user 74.38system 1:00.58elapsed 1504%CPU (0avgtext+0avgdata 0maxresident)k
828.96user 73.89system 1:00.76elapsed 1485%CPU (0avgtext+0avgdata 0maxresident)k
837.46user 74.39system 1:01.02elapsed 1494%CPU (0avgtext+0avgdata 0maxresident)k
834.82user 73.73system 1:00.74elapsed 1495%CPU (0avgtext+0avgdata 0maxresident)k
837.39user 75.05system 1:00.53elapsed 1507%CPU (0avgtext+0avgdata 0maxresident)k

i386 266+patch:
833.67user 73.43system 0:58.52elapsed 1550%CPU (0avgtext+0avgdata 0maxresident)k
839.90user 73.67system 0:58.48elapsed 1562%CPU (0avgtext+0avgdata 0maxresident)k
843.59user 75.17system 0:58.79elapsed 1562%CPU (0avgtext+0avgdata 0maxresident)k
842.79user 75.37system 1:00.90elapsed 1507%CPU (0avgtext+0avgdata 0maxresident)k
838.55user 74.27system 1:00.53elapsed 1507%CPU (0avgtext+0avgdata 0maxresident)k

ppc64 266:
293.06user 26.90system 0:41.45elapsed 771%CPU (0avgtext+0avgdata 0maxresident)k
293.07user 26.91system 0:41.53elapsed 770%CPU (0avgtext+0avgdata 0maxresident)k
293.15user 26.83system 0:41.10elapsed 778%CPU (0avgtext+0avgdata 0maxresident)k
293.27user 26.55system 0:41.18elapsed 776%CPU (0avgtext+0avgdata 0maxresident)k
293.03user 26.84system 0:41.09elapsed 778%CPU (0avgtext+0avgdata 0maxresident)k

ppc64 266+patch:
293.16user 26.84system 0:41.12elapsed 778%CPU (0avgtext+0avgdata 0maxresident)k
292.85user 27.03system 0:41.25elapsed 775%CPU (0avgtext+0avgdata 0maxresident)k
293.07user 26.89system 0:41.32elapsed 774%CPU (0avgtext+0avgdata 0maxresident)k
293.25user 26.80system 0:41.22elapsed 776%CPU (0avgtext+0avgdata 0maxresident)k
292.71user 27.24system 0:41.48elapsed 771%CPU (0avgtext+0avgdata 0maxresident)k


--==========527AFBAE1A1046FE7653==========
Content-Type: text/plain; charset=us-ascii; name="010-kernel_fault_ppc64.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="010-kernel_fault_ppc64.txt";
 size=1876

---
 fault.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/ppc64/mm/fault.c current/arch/ppc64/mm/fault.c
--- reference/arch/ppc64/mm/fault.c	2004-05-10 14:55:08.000000000 +0100
+++ current/arch/ppc64/mm/fault.c	2004-05-17 17:50:41.000000000 +0100
@@ -75,6 +75,8 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
 
+int check_page_fault(struct pt_regs *regs, unsigned long address, int sig);
+
 /*
  * The error_code parameter is
  *  - DSISR for a non-SLB data access fault,
@@ -93,12 +95,18 @@ void do_page_fault(struct pt_regs *regs,
 	if (regs->trap == 0x300 || regs->trap == 0x380) {
 		if (debugger_fault_handler(regs))
 			return;
-	}
 
-	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (regs->trap == 0x380)) {
-		bad_page_fault(regs, address, SIGSEGV);
-		return;
+		/* On a kernel SLB miss we can only check for a valid exception entry,
+		 * on a regular miss we had better be actually in one of the routines
+		 * which are permitted to access userland. */
+		if (!user_mode(regs)) {
+			if (regs->trap == 0x380) {
+				bad_page_fault(regs, address, SIGSEGV);
+				return;
+			}
+			check_page_fault(regs, address, SIGSEGV);
+		}
+
 	}
 
 	if (error_code & 0x00400000) {
@@ -259,3 +267,18 @@ void bad_page_fault(struct pt_regs *regs
 	/* kernel has accessed a bad area */
 	die("Kernel access of bad area", regs, sig);
 }
+
+int
+check_page_fault(struct pt_regs *regs, unsigned long address, int sig)
+{
+	const struct exception_table_entry *entry;
+
+	/* Are we prepared to handle this fault?  */
+	if ((entry = search_exception_tables(regs->nip)) != NULL) {
+		/* regs->nip = entry->fixup; */
+		return 1;
+	}
+
+	/* kernel has accessed a bad area */
+	die("Kernel access of bad area", regs, sig);
+}

--==========527AFBAE1A1046FE7653==========
Content-Type: text/plain; charset=us-ascii; name="015-kernel_fault_i386.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="015-kernel_fault_i386.txt";
 size=1541

---
 extable.c |   12 ++++++++++++
 fault.c   |    7 +++++++
 2 files changed, 19 insertions(+)

diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/extable.c current/arch/i386/mm/extable.c
--- reference/arch/i386/mm/extable.c	2004-03-11 20:47:12.000000000 +0000
+++ current/arch/i386/mm/extable.c	2004-05-17 15:22:54.000000000 +0100
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
diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/fault.c current/arch/i386/mm/fault.c
--- reference/arch/i386/mm/fault.c	2004-01-09 06:59:02.000000000 +0000
+++ current/arch/i386/mm/fault.c	2004-05-17 15:51:22.000000000 +0100
@@ -198,6 +198,7 @@ static inline int is_prefetch(struct pt_
 } 
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
+int check_exception(struct pt_regs *regs);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -262,6 +263,12 @@ asmlinkage void do_page_fault(struct pt_
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
+	/* If we are in the kernel we should expect faults to user space to
+	 * occur only from instructions designated as user access.  These
+	 * all have exception handlers. */
+	if ((error_code & 4) == 0 && !check_exception(regs))
+		goto bad_area_nosemaphore;
+
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, address);

--==========527AFBAE1A1046FE7653==========--

