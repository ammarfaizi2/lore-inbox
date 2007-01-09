Return-Path: <linux-kernel-owner+w=401wt.eu-S1751233AbXAIJ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbXAIJ04 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXAIJ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:26:56 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:45569 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbXAIJ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:26:55 -0500
Date: Tue, 9 Jan 2007 10:26:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20070109092650.GB767@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/kernel/head31.S   |   12 +++++++++++-
 arch/s390/kernel/head64.S   |   12 +++++++++++-
 arch/s390/kernel/setup.c    |    2 +-
 arch/s390/kernel/smp.c      |    5 ++++-
 arch/s390/lib/uaccess_pt.c  |    3 +++
 arch/s390/lib/uaccess_std.c |    3 ---
 drivers/s390/char/vmcp.c    |    2 +-
 drivers/s390/cio/cio.c      |   12 ++++--------
 include/asm-s390/futex.h    |    4 +++-
 9 files changed, 38 insertions(+), 17 deletions(-)

Christian Borntraeger (1):
      [S390] locking problem with __cpcmd.

Heiko Carstens (4):
      [S390] cio: use barrier() in stsch_reset.
      [S390] Fix cpu hotplug (missing 'online' attribute).
      [S390] Fix vmalloc area size calculation.
      [S390] don't call handle_mm_fault() if in an atomic context.

Hongjie Yang (1):
      [S390] memory detection misses 128k.

diff --git a/arch/s390/kernel/head31.S b/arch/s390/kernel/head31.S
index 4388b33..eca5070 100644
--- a/arch/s390/kernel/head31.S
+++ b/arch/s390/kernel/head31.S
@@ -164,11 +164,14 @@ startup_continue:
 	srl	%r7,28
 	clr	%r6,%r7			# compare cc with last access code
 	be	.Lsame-.LPG1(%r13)
-	b	.Lchkmem-.LPG1(%r13)
+	lhi	%r8,0			# no program checks
+	b	.Lsavchk-.LPG1(%r13)
 .Lsame:
 	ar	%r5,%r1			# add 128KB to end of chunk
 	bno	.Lloop-.LPG1(%r13)	# r1 < 0x80000000 -> loop
 .Lchkmem:				# > 2GB or tprot got a program check
+	lhi	%r8,1			# set program check flag
+.Lsavchk:
 	clr	%r4,%r5			# chunk size > 0?
 	be	.Lchkloop-.LPG1(%r13)
 	st	%r4,0(%r3)		# store start address of chunk
@@ -190,8 +193,15 @@ startup_continue:
 	je	.Ldonemem		# if not, leave
 	chi	%r10,0			# do we have chunks left?
 	je	.Ldonemem
+	chi	%r8,1			# program check ?
+	je	.Lpgmchk
+	lr	%r4,%r5			# potential new chunk
+	alr	%r5,%r1			# add 128KB to end of chunk
+	j	.Llpcnt
+.Lpgmchk:
 	alr	%r5,%r1			# add 128KB to end of chunk
 	lr	%r4,%r5			# potential new chunk
+.Llpcnt:
 	clr	%r5,%r9			# should we go on?
 	jl	.Lloop
 .Ldonemem:
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index c526279..6ba3f45 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -172,12 +172,15 @@ startup_continue:
 	srl	%r7,28
 	clr	%r6,%r7			# compare cc with last access code
 	je	.Lsame
-	j	.Lchkmem
+	lghi	%r8,0			# no program checks
+	j	.Lsavchk
 .Lsame:
 	algr	%r5,%r1			# add 128KB to end of chunk
 					# no need to check here,
 	brc	12,.Lloop		# this is the same chunk
 .Lchkmem:				# > 16EB or tprot got a program check
+	lghi	%r8,1			# set program check flag
+.Lsavchk:
 	clgr	%r4,%r5			# chunk size > 0?
 	je	.Lchkloop
 	stg	%r4,0(%r3)		# store start address of chunk
@@ -204,8 +207,15 @@ startup_continue:
 	chi	%r10, 0			# do we have chunks left?
 	je	.Ldonemem
 .Lhsaskip:
+	chi	%r8,1			# program check ?
+	je	.Lpgmchk
+	lgr	%r4,%r5			# potential new chunk
+	algr	%r5,%r1			# add 128KB to end of chunk
+	j	.Llpcnt
+.Lpgmchk:
 	algr	%r5,%r1			# add 128KB to end of chunk
 	lgr	%r4,%r5			# potential new chunk
+.Llpcnt:
 	clgr	%r5,%r9			# should we go on?
 	jl	.Lloop
 .Ldonemem:
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 49ef206..5d8ee3b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -476,7 +476,7 @@ static void __init setup_memory_end(void)
 	int i;
 
 	memory_size = real_size = 0;
-	max_phys = VMALLOC_END - VMALLOC_MIN_SIZE;
+	max_phys = VMALLOC_END_INIT - VMALLOC_MIN_SIZE;
 	memory_end &= PAGE_MASK;
 
 	max_mem = memory_end ? min(max_phys, memory_end) : max_phys;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 19090f7..c0cd255 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -794,7 +794,10 @@ static int __init topology_init(void)
 	int ret;
 
 	for_each_possible_cpu(cpu) {
-		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+		struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+		c->hotpluggable = 1;
+		ret = register_cpu(c, cpu);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
 			       "failed (%d)\n", cpu, ret);
diff --git a/arch/s390/lib/uaccess_pt.c b/arch/s390/lib/uaccess_pt.c
index 633249c..49c3e46 100644
--- a/arch/s390/lib/uaccess_pt.c
+++ b/arch/s390/lib/uaccess_pt.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/hardirq.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/futex.h>
@@ -18,6 +19,8 @@ static inline int __handle_fault(struct mm_struct *mm, unsigned long address,
 	struct vm_area_struct *vma;
 	int ret = -EFAULT;
 
+	if (in_atomic())
+		return ret;
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (unlikely(!vma))
diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
index bbaca66..56a0214 100644
--- a/arch/s390/lib/uaccess_std.c
+++ b/arch/s390/lib/uaccess_std.c
@@ -258,8 +258,6 @@ int futex_atomic_op(int op, int __user *uaddr, int oparg, int *old)
 {
 	int oldval = 0, newval, ret;
 
-	pagefault_disable();
-
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -284,7 +282,6 @@ int futex_atomic_op(int op, int __user *uaddr, int oparg, int *old)
 	default:
 		ret = -ENOSYS;
 	}
-	pagefault_enable();
 	*old = oldval;
 	return ret;
 }
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 1678b6c..a420cd0 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -117,7 +117,7 @@ vmcp_write(struct file *file, const char __user * buff, size_t count,
 		return -ENOMEM;
 	}
 	debug_text_event(vmcp_debug, 1, cmd);
-	session->resp_size = __cpcmd(cmd, session->response,
+	session->resp_size = cpcmd(cmd, session->response,
 				     session->bufsize,
 				     &session->resp_code);
 	up(&session->mutex);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index b471ac4..ae1bf23 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -880,19 +880,15 @@ static void cio_reset_pgm_check_handler(void)
 static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
 {
 	int rc;
-	register struct subchannel_id reg1 asm ("1") = schid;
 
 	pgm_check_occured = 0;
 	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
+	rc = stsch(schid, addr);
+	s390_reset_pgm_handler = NULL;
 
-	asm volatile(
-		"       stsch   0(%2)\n"
-		"       ipm     %0\n"
-		"       srl     %0,28"
-		: "=d" (rc)
-		: "d" (reg1), "a" (addr), "m" (*addr) : "memory", "cc");
+	/* The program check handler could have changed pgm_check_occured */
+	barrier();
 
-	s390_reset_pgm_handler = NULL;
 	if (pgm_check_occured)
 		return -EIO;
 	else
diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
index 5e261e1..5c5d02d 100644
--- a/include/asm-s390/futex.h
+++ b/include/asm-s390/futex.h
@@ -4,8 +4,8 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 
 static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
 {
@@ -21,7 +21,9 @@ static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
+	pagefault_disable();
 	ret = uaccess.futex_atomic_op(op, uaddr, oparg, &oldval);
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
