Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWJFNfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWJFNfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWJFNfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:35:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422703AbWJFNfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:35:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Fri, 06 Oct 2006 14:34:14 +0100
To: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

This facility provides three entry points:

	ilog2()		Log base 2 of unsigned long
	ilog2_u32()	Log base 2 of u32
	ilog2_u64()	Log base 2 of u64

These facilities can either be used inside functions on dynamic data:

	int do_something(long q)
	{
		...;
		y = ilog2(x)
		...;
	}

Or can be used to statically initialise global variables with constant values:

	unsigned n = ilog2(27);

When performing static initialisation, the compiler will report "error:
initializer element is not constant" if asked to take a log of zero or of
something not reducible to a constant.  They treat negative numbers as
unsigned.


When not dealing with a constant, they fall back to using fls() which permits
them to use arch-specific log calculation instructions - such as BSR on
x86/x86_64 or SCAN on FRV - if available.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/alpha/Kconfig                           |    8 ++
 arch/arm/Kconfig                             |    8 ++
 arch/arm26/Kconfig                           |    8 ++
 arch/avr32/Kconfig                           |    8 ++
 arch/cris/Kconfig                            |    8 ++
 arch/frv/Kconfig                             |    8 ++
 arch/h8300/Kconfig                           |    8 ++
 arch/i386/Kconfig.cpu                        |    8 ++
 arch/ia64/Kconfig                            |    8 ++
 arch/m32r/Kconfig                            |    8 ++
 arch/m68k/Kconfig                            |    8 ++
 arch/m68knommu/Kconfig                       |    8 ++
 arch/mips/Kconfig                            |    8 ++
 arch/parisc/Kconfig                          |    8 ++
 arch/powerpc/Kconfig                         |    8 ++
 arch/ppc/Kconfig                             |    8 ++
 arch/s390/Kconfig                            |    8 ++
 arch/sh/Kconfig                              |    8 ++
 arch/sh64/Kconfig                            |    8 ++
 arch/sparc/Kconfig                           |    8 ++
 arch/sparc64/Kconfig                         |    8 ++
 arch/v850/Kconfig                            |    8 ++
 arch/x86_64/Kconfig                          |    8 ++
 arch/xtensa/Kconfig                          |    8 ++
 drivers/infiniband/hw/mthca/mthca_provider.c |    4 -
 drivers/infiniband/hw/mthca/mthca_qp.c       |    4 -
 drivers/infiniband/hw/mthca/mthca_srq.c      |    4 -
 drivers/infiniband/ulp/iser/iser_memory.c    |    4 -
 fs/ext2/super.c                              |    6 -
 fs/ext3/super.c                              |    6 -
 include/asm-frv/bitops.h                     |   44 +++++++++
 include/linux/kernel.h                       |    9 --
 include/linux/log2.h                         |  131 ++++++++++++++++++++++++++
 mm/page_alloc.c                              |    4 -
 34 files changed, 382 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7e55ea6..84caf50 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -25,6 +25,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index adb05de..0c3dab6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -74,6 +74,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/arm26/Kconfig b/arch/arm26/Kconfig
index c14fe91..74eba8b 100644
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -41,6 +41,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 5f1694e..bb059a4 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -45,6 +45,14 @@ config GENERIC_TIME
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 6a1238a..3474309 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -16,6 +16,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index cf1c446..7561d7b 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -41,6 +41,14 @@ config TIME_LOW_RES
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default y
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default y
+
 mainmenu "Fujitsu FR-V Kernel Configuration"
 
 source "init/Kconfig"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index cabf0bf..34a84bc 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -29,6 +29,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index 21c9a4e..99fa842 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -240,6 +240,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	depends on !M386
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 70f7eb9..ac23182 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -34,6 +34,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 41fd490..f383dab 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -214,6 +214,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 805b81f..0953145 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -17,6 +17,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
index 6d920d4..0e07597 100644
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -25,6 +25,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8a49884..8f10fe2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -789,6 +789,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d210123..0f9ff61 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -25,6 +25,14 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b69104..1cf67b7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -41,6 +41,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 077711e..55abcc9 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -19,6 +19,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 51c2dfe..a3f9550 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -22,6 +22,14 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f6a0c44..eaea396 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,14 @@ config GENERIC_IOMAP
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 source "init/Kconfig"
 
 menu "System type"
diff --git a/arch/sh64/Kconfig b/arch/sh64/Kconfig
index 58c678e..03778a1 100644
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -36,6 +36,14 @@ config GENERIC_CALIBRATE_DELAY
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config GENERIC_ISA_DMA
 	bool
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9431e96..44b79c2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -166,6 +166,14 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config SUN_PM
 	bool
 	default y
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index b627f8d..d391d11 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -34,6 +34,14 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 config AUDIT_ARCH
 	bool
 	default y
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index 37ec644..bcf8258 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -38,6 +38,14 @@ config TIME_LOW_RES
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 # Turn off some random 386 crap that can affect device config
 config ISA
 	bool
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 010d226..c007ab2 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -96,6 +96,14 @@ config AUDIT_ARCH
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 source "init/Kconfig"
 
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c1e69a1..9eccfbd 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -34,6 +34,14 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
 source "init/Kconfig"
 
 menu "Processor type and features"
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 981fe2e..20c0fc1 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -124,7 +124,7 @@ static int mthca_query_device(struct ib_
 		props->max_map_per_fmr = 255;
 	else
 		props->max_map_per_fmr =
-			(1 << (32 - long_log2(mdev->limits.num_mpts))) - 1;
+			(1 << (32 - ilog2(mdev->limits.num_mpts))) - 1;
 
 	err = 0;
  out:
@@ -814,7 +814,7 @@ static int mthca_resize_cq(struct ib_cq 
 		lkey = ucmd.lkey;
 	}
 
-	ret = mthca_RESIZE_CQ(dev, cq->cqn, lkey, long_log2(entries), &status);
+	ret = mthca_RESIZE_CQ(dev, cq->cqn, lkey, ilog2(entries), &status);
 	if (status)
 		ret = -EINVAL;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 5e5c58b..1bf0856 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -635,11 +635,11 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 
 	if (mthca_is_memfree(dev)) {
 		if (qp->rq.max)
-			qp_context->rq_size_stride = long_log2(qp->rq.max) << 3;
+			qp_context->rq_size_stride = ilog2(qp->rq.max) << 3;
 		qp_context->rq_size_stride |= qp->rq.wqe_shift - 4;
 
 		if (qp->sq.max)
-			qp_context->sq_size_stride = long_log2(qp->sq.max) << 3;
+			qp_context->sq_size_stride = ilog2(qp->sq.max) << 3;
 		qp_context->sq_size_stride |= qp->sq.wqe_shift - 4;
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 0f316c8..2af1b8e 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -118,7 +118,7 @@ static void mthca_arbel_init_srq_context
 
 	memset(context, 0, sizeof *context);
 
-	logsize = long_log2(srq->max) + srq->wqe_shift;
+	logsize = ilog2(srq->max) + srq->wqe_shift;
 	context->state_logsize_srqn = cpu_to_be32(logsize << 24 | srq->srqn);
 	context->lkey = cpu_to_be32(srq->mr.ibmr.lkey);
 	context->db_index = cpu_to_be32(srq->db_index);
@@ -209,7 +209,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 	if (!mthca_is_memfree(dev) && (ds > dev->limits.max_desc_sz))
 		return -EINVAL;
 
-	srq->wqe_shift = long_log2(ds);
+	srq->wqe_shift = ilog2(ds);
 
 	srq->srqn = mthca_alloc(&dev->srq_table.alloc);
 	if (srq->srqn == -1)
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 0606744..15de90e 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -113,7 +113,7 @@ int iser_start_rdma_unaligned_sg(struct 
 
 	if (cmd_data_len > ISER_KMALLOC_THRESHOLD)
 		mem = (void *)__get_free_pages(GFP_NOIO,
-		      long_log2(roundup_pow_of_two(cmd_data_len)) - PAGE_SHIFT);
+		      ilog2(roundup_pow_of_two(cmd_data_len)) - PAGE_SHIFT);
 	else
 		mem = kmalloc(cmd_data_len, GFP_NOIO);
 
@@ -210,7 +210,7 @@ void iser_finalize_rdma_unaligned_sg(str
 
 	if (cmd_data_len > ISER_KMALLOC_THRESHOLD)
 		free_pages((unsigned long)mem_copy->copy_buf,
-			   long_log2(roundup_pow_of_two(cmd_data_len)) - PAGE_SHIFT);
+			   ilog2(roundup_pow_of_two(cmd_data_len)) - PAGE_SHIFT);
 	else
 		kfree(mem_copy->copy_buf);
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 513cd42..4f0bd87 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -593,8 +593,6 @@ static int ext2_check_descriptors (struc
 	return 1;
 }
 
-#define log2(n) ffz(~(n))
- 
 /*
  * Maximal file size.  There is a direct, and {,double-,triple-}indirect
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
@@ -828,9 +826,9 @@ static int ext2_fill_super(struct super_
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =
-		log2 (EXT2_ADDR_PER_BLOCK(sb));
+		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits =
-		log2 (EXT2_DESC_PER_BLOCK(sb));
+		ilog2 (EXT2_DESC_PER_BLOCK(sb));
 
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 8bfd56e..b97119c 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -1341,8 +1341,6 @@ #endif
 	sb->s_flags = s_flags; /* Restore MS_RDONLY status */
 }
 
-#define log2(n) ffz(~(n))
-
 /*
  * Maximal file size.  There is a direct, and {,double-,triple-}indirect
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
@@ -1589,8 +1587,8 @@ static int ext3_fill_super (struct super
 	sbi->s_desc_per_block = blocksize / sizeof(struct ext3_group_desc);
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
-	sbi->s_addr_per_block_bits = log2(EXT3_ADDR_PER_BLOCK(sb));
-	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
+	sbi->s_addr_per_block_bits = ilog2(EXT3_ADDR_PER_BLOCK(sb));
+	sbi->s_desc_per_block_bits = ilog2(EXT3_DESC_PER_BLOCK(sb));
 	for (i=0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 	sbi->s_def_hash_version = es->s_def_hash_version;
diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 1f70d47..f8560ed 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -256,6 +256,50 @@ int __ffs(unsigned long x)
 	return 31 - bit;
 }
 
+/*
+ * special slimline version of fls() for calculating ilog2_u32()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_ILOG2_U32
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	int bit;
+	asm("scan %1,gr0,%0" : "=r"(bit) : "r"(n));
+	return 31 - bit;
+}
+
+/*
+ * special slimline version of fls64() for calculating ilog2_u64()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_ILOG2_U64
+static inline __attribute__((const))
+int __ilog2_u64(u64 n)
+{
+	union {
+		u64 ll;
+		struct { u32 h, l; };
+	} _;
+	int bit, x, y;
+
+	_.ll = n;
+
+	asm("	subcc		%3,gr0,gr0,icc0		\n"
+	    "	ckeq		icc0,cc4		\n"
+	    "	cscan.p		%3,gr0,%0	,cc4,0	\n"
+	    "   setlos		#63,%1			\n"
+	    "	cscan.p		%4,gr0,%0	,cc4,1	\n"
+	    "   setlos		#31,%2			\n"
+	    "	csub.p		%1,%0,%0	,cc4,0	\n"
+	    "	csub		%2,%0,%0	,cc4,1	\n"
+	    : "=&r"(bit), "=r"(x), "=r"(y)
+	    : "0r"(_.h), "r"(_.l)
+	    : "icc0", "cc4"
+	    );
+	return bit;
+}
+
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 80f39ca..473101a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@ #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/log2.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -155,14 +156,6 @@ #endif
 
 unsigned long int_sqrt(unsigned long);
 
-static inline int __attribute_pure__ long_log2(unsigned long x)
-{
-	int r = 0;
-	for (x >>= 1; x > 0; x >>= 1)
-		r++;
-	return r;
-}
-
 static inline unsigned long
 __attribute_const__ roundup_pow_of_two(unsigned long x)
 {
diff --git a/include/linux/log2.h b/include/linux/log2.h
new file mode 100644
index 0000000..3979c60
--- /dev/null
+++ b/include/linux/log2.h
@@ -0,0 +1,131 @@
+/* Integer base 2 logarithm calculation
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_LOG2_H
+#define _LINUX_LOG2_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+/*
+ * deal with unrepresentable constant logarithms
+ */
+extern __attribute__((const, noreturn))
+int ____ilog2_NaN(void);
+
+/*
+ * non-constant log of base 2 calculators
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using fls() and fls64()
+ * - the arch is not required to handle n==0 if implementing the fallback
+ */
+#ifndef CONFIG_ARCH_HAS_ILOG2_U32
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	return fls(n) - 1;
+}
+#endif
+
+#ifndef CONFIG_ARCH_HAS_ILOG2_U64
+static inline __attribute__((const))
+int __ilog2_u64(u64 n)
+{
+	return fls64(n) - 1;
+}
+#endif
+
+/**
+ * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
+ * @n - parameter
+ *
+ * constant-capable log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ *
+ * selects the appropriately-sized optimised version depending on sizeof(n)
+ */
+#define ilog2(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(n) < 1 ? ____ilog2_NaN() :	\
+		(n) & (1ULL << 63) ? 63 :	\
+		(n) & (1ULL << 62) ? 62 :	\
+		(n) & (1ULL << 61) ? 61 :	\
+		(n) & (1ULL << 60) ? 60 :	\
+		(n) & (1ULL << 59) ? 59 :	\
+		(n) & (1ULL << 58) ? 58 :	\
+		(n) & (1ULL << 57) ? 57 :	\
+		(n) & (1ULL << 56) ? 56 :	\
+		(n) & (1ULL << 55) ? 55 :	\
+		(n) & (1ULL << 54) ? 54 :	\
+		(n) & (1ULL << 53) ? 53 :	\
+		(n) & (1ULL << 52) ? 52 :	\
+		(n) & (1ULL << 51) ? 51 :	\
+		(n) & (1ULL << 50) ? 50 :	\
+		(n) & (1ULL << 49) ? 49 :	\
+		(n) & (1ULL << 48) ? 48 :	\
+		(n) & (1ULL << 47) ? 47 :	\
+		(n) & (1ULL << 46) ? 46 :	\
+		(n) & (1ULL << 45) ? 45 :	\
+		(n) & (1ULL << 44) ? 44 :	\
+		(n) & (1ULL << 43) ? 43 :	\
+		(n) & (1ULL << 42) ? 42 :	\
+		(n) & (1ULL << 41) ? 41 :	\
+		(n) & (1ULL << 40) ? 40 :	\
+		(n) & (1ULL << 39) ? 39 :	\
+		(n) & (1ULL << 38) ? 38 :	\
+		(n) & (1ULL << 37) ? 37 :	\
+		(n) & (1ULL << 36) ? 36 :	\
+		(n) & (1ULL << 35) ? 35 :	\
+		(n) & (1ULL << 34) ? 34 :	\
+		(n) & (1ULL << 33) ? 33 :	\
+		(n) & (1ULL << 32) ? 32 :	\
+		(n) & (1ULL << 31) ? 31 :	\
+		(n) & (1ULL << 30) ? 30 :	\
+		(n) & (1ULL << 29) ? 29 :	\
+		(n) & (1ULL << 28) ? 28 :	\
+		(n) & (1ULL << 27) ? 27 :	\
+		(n) & (1ULL << 26) ? 26 :	\
+		(n) & (1ULL << 25) ? 25 :	\
+		(n) & (1ULL << 24) ? 24 :	\
+		(n) & (1ULL << 23) ? 23 :	\
+		(n) & (1ULL << 22) ? 22 :	\
+		(n) & (1ULL << 21) ? 21 :	\
+		(n) & (1ULL << 20) ? 20 :	\
+		(n) & (1ULL << 19) ? 19 :	\
+		(n) & (1ULL << 18) ? 18 :	\
+		(n) & (1ULL << 17) ? 17 :	\
+		(n) & (1ULL << 16) ? 16 :	\
+		(n) & (1ULL << 15) ? 15 :	\
+		(n) & (1ULL << 14) ? 14 :	\
+		(n) & (1ULL << 13) ? 13 :	\
+		(n) & (1ULL << 12) ? 12 :	\
+		(n) & (1ULL << 11) ? 11 :	\
+		(n) & (1ULL << 10) ? 10 :	\
+		(n) & (1ULL <<  9) ?  9 :	\
+		(n) & (1ULL <<  8) ?  8 :	\
+		(n) & (1ULL <<  7) ?  7 :	\
+		(n) & (1ULL <<  6) ?  6 :	\
+		(n) & (1ULL <<  5) ?  5 :	\
+		(n) & (1ULL <<  4) ?  4 :	\
+		(n) & (1ULL <<  3) ?  3 :	\
+		(n) & (1ULL <<  2) ?  2 :	\
+		(n) & (1ULL <<  1) ?  1 :	\
+		(n) & (1ULL <<  0) ?  0 :	\
+		____ilog2_NaN()			\
+				   ) :		\
+	(sizeof(n) <= 4) ?			\
+	__ilog2_u32(n) :			\
+	__ilog2_u64(n)				\
+ )
+
+#endif /* _LINUX_LOG2_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8c003e..bd30dff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3091,7 +3091,7 @@ void *__init alloc_large_system_hash(con
 	if (numentries > max)
 		numentries = max;
 
-	log2qty = long_log2(numentries);
+	log2qty = ilog2(numentries);
 
 	do {
 		size = bucketsize << log2qty;
@@ -3113,7 +3113,7 @@ void *__init alloc_large_system_hash(con
 	printk("%s hash table entries: %d (order: %d, %lu bytes)\n",
 	       tablename,
 	       (1U << log2qty),
-	       long_log2(size) - PAGE_SHIFT,
+	       ilog2(size) - PAGE_SHIFT,
 	       size);
 
 	if (_hash_shift)
