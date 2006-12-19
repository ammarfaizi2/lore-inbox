Return-Path: <linux-kernel-owner+w=401wt.eu-S932919AbWLSTib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbWLSTib (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbWLSTib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:38:31 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46157 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbWLSTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:38:29 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 14:34:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Transform kmem_cache_alloc()+memset(0) -> kmem_cache_zalloc().
Message-ID: <Pine.LNX.4.64.0612191429480.11124@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.469, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, TW_GF 0.08, TW_PF 0.08, TW_PN 0.08,
	TW_UH 0.08, TW_VP 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Replace appropriate pairs of "kmem_cache_alloc()" + "memset(0)" with
the corresponding "kmem_cache_zalloc()" call.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  Someone might want to check this carefully -- it's been a long day
and I might have pooched something here.  Based on what I've read, the
transformation should have been fairly straightforward.


 arch/ia64/ia32/binfmt_elf32.c          |   13 ++++---------
 arch/ia64/kernel/perfmon.c             |    3 +--
 arch/ia64/mm/init.c                    |    6 ++----
 arch/x86_64/ia32/ia32_binfmt.c         |    4 +---
 arch/x86_64/ia32/syscall32.c           |    3 +--
 drivers/infiniband/hw/ehca/ehca_cq.c   |    3 +--
 drivers/infiniband/hw/ehca/ehca_mrmw.c |    6 ++----
 drivers/infiniband/hw/ehca/ehca_pd.c   |    3 +--
 drivers/infiniband/hw/ehca/ehca_qp.c   |    3 +--
 drivers/scsi/aic94xx/aic94xx_hwi.c     |    3 +--
 drivers/scsi/scsi_lib.c                |    3 +--
 drivers/usb/host/hc_crisv10.c          |    3 +--
 drivers/usb/host/uhci-q.c              |    4 +---
 fs/aio.c                               |    3 +--
 fs/configfs/dir.c                      |    3 +--
 fs/dlm/memory.c                        |    4 +---
 fs/dquot.c                             |    3 +--
 fs/ecryptfs/crypto.c                   |    4 ++--
 fs/ecryptfs/file.c                     |    3 +--
 fs/ecryptfs/inode.c                    |    5 ++---
 fs/ecryptfs/keystore.c                 |    4 +---
 fs/ecryptfs/main.c                     |    8 ++------
 fs/exec.c                              |    4 +---
 fs/gfs2/meta_io.c                      |    3 +--
 fs/namespace.c                         |    3 +--
 fs/smbfs/request.c                     |    3 +--
 fs/sysfs/dir.c                         |    3 +--
 include/scsi/libsas.h                  |    3 +--
 kernel/posix-timers.c                  |    3 +--
 net/core/dst.c                         |    3 +--
 net/core/neighbour.c                   |    4 +---
 net/decnet/dn_table.c                  |    4 +---
 net/ipv4/ipmr.c                        |    6 ++----
 net/ipv4/ipvs/ip_vs_conn.c             |    3 +--
 net/ipv4/netfilter/ip_conntrack_core.c |    3 +--
 net/ipv6/ip6_fib.c                     |    3 +--
 net/sctp/sm_make_chunk.c               |    3 +--
 security/selinux/avc.c                 |    3 +--
 security/selinux/hooks.c               |    3 +--
 security/selinux/ss/avtab.c            |    3 +--
 40 files changed, 49 insertions(+), 105 deletions(-)


diff --git a/arch/ia64/ia32/binfmt_elf32.c b/arch/ia64/ia32/binfmt_elf32.c
index 578737e..c05bda6 100644
--- a/arch/ia64/ia32/binfmt_elf32.c
+++ b/arch/ia64/ia32/binfmt_elf32.c
@@ -91,9 +91,8 @@ ia64_elf32_init (struct pt_regs *regs)
 	 * it with privilege level 3 because the IVE uses non-privileged accesses to these
 	 * tables.  IA-32 segmentation is used to protect against IA-32 accesses to them.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
-		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_GDT_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
@@ -117,9 +116,8 @@ ia64_elf32_init (struct pt_regs *regs)
 	 * code is locked in specific gate page, which is pointed by pretcode
 	 * when setup_frame_ia32
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
-		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_GATE_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
@@ -142,9 +140,8 @@ ia64_elf32_init (struct pt_regs *regs)
 	 * Install LDT as anonymous memory.  This gives us all-zero segment descriptors
 	 * until a task modifies them via modify_ldt().
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
-		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_LDT_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_ALIGN(IA32_LDT_ENTRIES*IA32_LDT_ENTRY_SIZE);
@@ -214,12 +211,10 @@ ia32_setup_arg_pages (struct linux_binprm *bprm, int executable_stack)
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;

-	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	mpnt = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt)
 		return -ENOMEM;

-	memset(mpnt, 0, sizeof(*mpnt));
-
 	down_write(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm = current->mm;
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index aa94f60..86e144f 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2301,12 +2301,11 @@ pfm_smpl_buffer_alloc(struct task_struct *task, pfm_context_t *ctx, unsigned lon
 	DPRINT(("smpl_buf @%p\n", smpl_buf));

 	/* allocate vma */
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma) {
 		DPRINT(("Cannot allocate vma\n"));
 		goto error_kmem;
 	}
-	memset(vma, 0, sizeof(*vma));

 	/*
 	 * partially initialize the vma for the sampling buffer
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 1a3d8a2..fa71307 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -156,9 +156,8 @@ ia64_init_addr_space (void)
 	 * the problem.  When the process attempts to write to the register backing store
 	 * for the first time, it will get a SEGFAULT in this case.
 	 */
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (vma) {
-		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = current->thread.rbs_bot & PAGE_MASK;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
@@ -175,9 +174,8 @@ ia64_init_addr_space (void)

 	/* map NaT-page at address zero to speed up speculative dereferencing of NULL: */
 	if (!(current->personality & MMAP_PAGE_ZERO)) {
-		vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+		vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 		if (vma) {
-			memset(vma, 0, sizeof(*vma));
 			vma->vm_mm = current->mm;
 			vma->vm_end = PAGE_SIZE;
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 543ef4f..1294606 100644
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -349,12 +349,10 @@ int ia32_setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top,
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;

-	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	mpnt = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt)
 		return -ENOMEM;

-	memset(mpnt, 0, sizeof(*mpnt));
-
 	down_write(&mm->mmap_sem);
 	{
 		mpnt->vm_mm = mm;
diff --git a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
index 3e5ed20..a0378d0 100644
--- a/arch/x86_64/ia32/syscall32.c
+++ b/arch/x86_64/ia32/syscall32.c
@@ -49,11 +49,10 @@ int syscall32_setup_pages(struct linux_binprm *bprm, int exstack)
 	struct mm_struct *mm = current->mm;
 	int ret;

-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!vma)
 		return -ENOMEM;

-	memset(vma, 0, sizeof(struct vm_area_struct));
 	/* Could randomize here */
 	vma->vm_start = VSYSCALL32_BASE;
 	vma->vm_end = VSYSCALL32_END;
diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index 93995b6..5fac0a6 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -134,14 +134,13 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe,
 	if (cqe >= 0xFFFFFFFF - 64 - additional_cqe)
 		return ERR_PTR(-EINVAL);

-	my_cq = kmem_cache_alloc(cq_cache, GFP_KERNEL);
+	my_cq = kmem_cache_zalloc(cq_cache, GFP_KERNEL);
 	if (!my_cq) {
 		ehca_err(device, "Out of memory for ehca_cq struct device=%p",
 			 device);
 		return ERR_PTR(-ENOMEM);
 	}

-	memset(my_cq, 0, sizeof(struct ehca_cq));
 	memset(&param, 0, sizeof(struct ehca_alloc_cq_parms));

 	spin_lock_init(&my_cq->spinlock);
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 0a5e221..077b6ea 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -53,9 +53,8 @@ static struct ehca_mr *ehca_mr_new(void)
 {
 	struct ehca_mr *me;

-	me = kmem_cache_alloc(mr_cache, GFP_KERNEL);
+	me = kmem_cache_zalloc(mr_cache, GFP_KERNEL);
 	if (me) {
-		memset(me, 0, sizeof(struct ehca_mr));
 		spin_lock_init(&me->mrlock);
 	} else
 		ehca_gen_err("alloc failed");
@@ -72,9 +71,8 @@ static struct ehca_mw *ehca_mw_new(void)
 {
 	struct ehca_mw *me;

-	me = kmem_cache_alloc(mw_cache, GFP_KERNEL);
+	me = kmem_cache_zalloc(mw_cache, GFP_KERNEL);
 	if (me) {
-		memset(me, 0, sizeof(struct ehca_mw));
 		spin_lock_init(&me->mwlock);
 	} else
 		ehca_gen_err("alloc failed");
diff --git a/drivers/infiniband/hw/ehca/ehca_pd.c b/drivers/infiniband/hw/ehca/ehca_pd.c
index d5345e5..79d0591 100644
--- a/drivers/infiniband/hw/ehca/ehca_pd.c
+++ b/drivers/infiniband/hw/ehca/ehca_pd.c
@@ -50,14 +50,13 @@ struct ib_pd *ehca_alloc_pd(struct ib_device *device,
 {
 	struct ehca_pd *pd;

-	pd = kmem_cache_alloc(pd_cache, GFP_KERNEL);
+	pd = kmem_cache_zalloc(pd_cache, GFP_KERNEL);
 	if (!pd) {
 		ehca_err(device, "device=%p context=%p out of memory",
 			 device, context);
 		return ERR_PTR(-ENOMEM);
 	}

-	memset(pd, 0, sizeof(struct ehca_pd));
 	pd->ownpid = current->tgid;

 	/*
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index c6c9cef..2121978 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -450,13 +450,12 @@ struct ib_qp *ehca_create_qp(struct ib_pd *pd,
 	if (pd->uobject && udata)
 		context = pd->uobject->context;

-	my_qp = kmem_cache_alloc(qp_cache, GFP_KERNEL);
+	my_qp = kmem_cache_zalloc(qp_cache, GFP_KERNEL);
 	if (!my_qp) {
 		ehca_err(pd->device, "pd=%p not enough memory to alloc qp", pd);
 		return ERR_PTR(-ENOMEM);
 	}

-	memset(my_qp, 0, sizeof(struct ehca_qp));
 	memset (&parms, 0, sizeof(struct ehca_alloc_qp_parms));
 	spin_lock_init(&my_qp->spinlock_s);
 	spin_lock_init(&my_qp->spinlock_r);
diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index da94e12..0cd7eed 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -1052,10 +1052,9 @@ static inline struct asd_ascb *asd_ascb_alloc(struct asd_ha_struct *asd_ha,
 	struct asd_ascb *ascb;
 	unsigned long flags;

-	ascb = kmem_cache_alloc(asd_ascb_cache, gfp_flags);
+	ascb = kmem_cache_zalloc(asd_ascb_cache, gfp_flags);

 	if (ascb) {
-		memset(ascb, 0, sizeof(*ascb));
 		ascb->dma_scb.size = sizeof(struct scb);
 		ascb->dma_scb.vaddr = dma_pool_alloc(asd_ha->scb_pool,
 						     gfp_flags,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1748e27..c969a84 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -390,10 +390,9 @@ int scsi_execute_async(struct scsi_device *sdev, const unsigned char *cmd,
 	int err = 0;
 	int write = (data_direction == DMA_TO_DEVICE);

-	sioc = kmem_cache_alloc(scsi_io_context_cache, gfp);
+	sioc = kmem_cache_zalloc(scsi_io_context_cache, gfp);
 	if (!sioc)
 		return DRIVER_ERROR << 24;
-	memset(sioc, 0, sizeof(*sioc));

 	req = blk_get_request(sdev->request_queue, write, gfp);
 	if (!req)
diff --git a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
index 282d82e..f0ffb89 100644
--- a/drivers/usb/host/hc_crisv10.c
+++ b/drivers/usb/host/hc_crisv10.c
@@ -2163,9 +2163,8 @@ static void etrax_usb_add_to_bulk_sb_list(struct urb *urb, int epid)

 	maxlen = usb_maxpacket(urb->dev, urb->pipe, usb_pipeout(urb->pipe));

-	sb_desc = (USB_SB_Desc_t*)kmem_cache_alloc(usb_desc_cache, SLAB_FLAG);
+	sb_desc = kmem_cache_zalloc(usb_desc_cache, SLAB_FLAG);
 	assert(sb_desc != NULL);
-	memset(sb_desc, 0, sizeof(USB_SB_Desc_t));


 	if (usb_pipeout(urb->pipe)) {
diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
index 30b8845..e663fe4 100644
--- a/drivers/usb/host/uhci-q.c
+++ b/drivers/usb/host/uhci-q.c
@@ -498,12 +498,10 @@ static inline struct urb_priv *uhci_alloc_urb_priv(struct uhci_hcd *uhci,
 {
 	struct urb_priv *urbp;

-	urbp = kmem_cache_alloc(uhci_up_cachep, GFP_ATOMIC);
+	urbp = kmem_cache_zalloc(uhci_up_cachep, GFP_ATOMIC);
 	if (!urbp)
 		return NULL;

-	memset((void *)urbp, 0, sizeof(*urbp));
-
 	urbp->urb = urb;
 	urb->hcpriv = urbp;

diff --git a/fs/aio.c b/fs/aio.c
index 5f577a6..43f6cdf 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -211,11 +211,10 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if ((unsigned long)nr_events > aio_max_nr)
 		return ERR_PTR(-EAGAIN);

-	ctx = kmem_cache_alloc(kioctx_cachep, GFP_KERNEL);
+	ctx = kmem_cache_zalloc(kioctx_cachep, GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);

-	memset(ctx, 0, sizeof(*ctx));
 	ctx->max_reqs = nr_events;
 	mm = ctx->mm = current->mm;
 	atomic_inc(&mm->mm_count);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 1814ba4..9371ee2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -72,11 +72,10 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent * pare
 {
 	struct configfs_dirent * sd;

-	sd = kmem_cache_alloc(configfs_dir_cachep, GFP_KERNEL);
+	sd = kmem_cache_zalloc(configfs_dir_cachep, GFP_KERNEL);
 	if (!sd)
 		return NULL;

-	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
 	INIT_LIST_HEAD(&sd->s_links);
 	INIT_LIST_HEAD(&sd->s_children);
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 5352b03..f858fef 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -76,9 +76,7 @@ struct dlm_lkb *allocate_lkb(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb;

-	lkb = kmem_cache_alloc(lkb_cache, GFP_KERNEL);
-	if (lkb)
-		memset(lkb, 0, sizeof(*lkb));
+	lkb = kmem_cache_zalloc(lkb_cache, GFP_KERNEL);
 	return lkb;
 }

diff --git a/fs/dquot.c b/fs/dquot.c
index 0952cc4..a561fb2 100644
--- a/fs/dquot.c
+++ b/fs/dquot.c
@@ -600,11 +600,10 @@ static struct dquot *get_empty_dquot(struct super_block *sb, int type)
 {
 	struct dquot *dquot;

-	dquot = kmem_cache_alloc(dquot_cachep, GFP_NOFS);
+	dquot = kmem_cache_zalloc(dquot_cachep, GFP_NOFS);
 	if(!dquot)
 		return NODQUOT;

-	memset((caddr_t)dquot, 0, sizeof(struct dquot));
 	mutex_init(&dquot->dq_lock);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 7196f50..33f92d7 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1334,13 +1334,13 @@ int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
 		goto out;
 	}
 	/* Released in this function */
-	page_virt = kmem_cache_alloc(ecryptfs_header_cache_0, GFP_USER);
+	page_virt = kmem_cache_zalloc(ecryptfs_header_cache_0, GFP_USER);
 	if (!page_virt) {
 		ecryptfs_printk(KERN_ERR, "Out of memory\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(page_virt, 0, PAGE_CACHE_SIZE);
+
 	rc = ecryptfs_write_headers_virt(page_virt, crypt_stat,
 					 ecryptfs_dentry);
 	if (unlikely(rc)) {
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c5a2e52..779c347 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -251,7 +251,7 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
 	int lower_flags;

 	/* Released in ecryptfs_release or end of function if failure */
-	file_info = kmem_cache_alloc(ecryptfs_file_info_cache, GFP_KERNEL);
+	file_info = kmem_cache_zalloc(ecryptfs_file_info_cache, GFP_KERNEL);
 	ecryptfs_set_file_private(file, file_info);
 	if (!file_info) {
 		ecryptfs_printk(KERN_ERR,
@@ -259,7 +259,6 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(file_info, 0, sizeof(*file_info));
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 11f5e50..d4f02f3 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -361,8 +361,7 @@ static struct dentry *ecryptfs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 	/* Released in this function */
-	page_virt =
-	    (char *)kmem_cache_alloc(ecryptfs_header_cache_2,
+	page_virt = kmem_cache_zalloc(ecryptfs_header_cache_2,
 				     GFP_USER);
 	if (!page_virt) {
 		rc = -ENOMEM;
@@ -370,7 +369,7 @@ static struct dentry *ecryptfs_lookup(struct inode *dir, struct dentry *dentry,
 				"Cannot ecryptfs_kmalloc a page\n");
 		goto out_dput;
 	}
-	memset(page_virt, 0, PAGE_CACHE_SIZE);
+
 	rc = ecryptfs_read_header_region(page_virt, lower_dentry, nd->mnt);
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED))
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 745c0f1..80bccd5 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -207,14 +207,12 @@ parse_tag_3_packet(struct ecryptfs_crypt_stat *crypt_stat,
 	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
 	 * at end of function upon failure */
 	auth_tok_list_item =
-	    kmem_cache_alloc(ecryptfs_auth_tok_list_item_cache, GFP_KERNEL);
+	    kmem_cache_zalloc(ecryptfs_auth_tok_list_item_cache, GFP_KERNEL);
 	if (!auth_tok_list_item) {
 		ecryptfs_printk(KERN_ERR, "Unable to allocate memory\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(auth_tok_list_item, 0,
-	       sizeof(struct ecryptfs_auth_tok_list_item));
 	(*new_auth_tok) = &auth_tok_list_item->auth_tok;

 	/* check for body size - one to two bytes */
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d0541ae..fe41ab1 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -378,15 +378,13 @@ ecryptfs_fill_super(struct super_block *sb, void *raw_data, int silent)

 	/* Released in ecryptfs_put_super() */
 	ecryptfs_set_superblock_private(sb,
-					kmem_cache_alloc(ecryptfs_sb_info_cache,
+					kmem_cache_zalloc(ecryptfs_sb_info_cache,
 							 GFP_KERNEL));
 	if (!ecryptfs_superblock_to_private(sb)) {
 		ecryptfs_printk(KERN_WARNING, "Out of memory\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(ecryptfs_superblock_to_private(sb), 0,
-	       sizeof(struct ecryptfs_sb_info));
 	sb->s_op = &ecryptfs_sops;
 	/* Released through deactivate_super(sb) from get_sb_nodev */
 	sb->s_root = d_alloc(NULL, &(const struct qstr) {
@@ -402,7 +400,7 @@ ecryptfs_fill_super(struct super_block *sb, void *raw_data, int silent)
 	/* Released in d_release when dput(sb->s_root) is called */
 	/* through deactivate_super(sb) from get_sb_nodev() */
 	ecryptfs_set_dentry_private(sb->s_root,
-				    kmem_cache_alloc(ecryptfs_dentry_info_cache,
+				    kmem_cache_zalloc(ecryptfs_dentry_info_cache,
 						     GFP_KERNEL));
 	if (!ecryptfs_dentry_to_private(sb->s_root)) {
 		ecryptfs_printk(KERN_ERR,
@@ -410,8 +408,6 @@ ecryptfs_fill_super(struct super_block *sb, void *raw_data, int silent)
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(ecryptfs_dentry_to_private(sb->s_root), 0,
-	       sizeof(struct ecryptfs_dentry_info));
 	rc = 0;
 out:
 	/* Should be able to rely on deactivate_super called from
diff --git a/fs/exec.c b/fs/exec.c
index 11fe93f..7e36c6f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -405,12 +405,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;

-	mpnt = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	mpnt = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
 	if (!mpnt)
 		return -ENOMEM;

-	memset(mpnt, 0, sizeof(*mpnt));
-
 	down_write(&mm->mmap_sem);
 	{
 		mpnt->vm_mm = mm;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 0e34d99..e62d4f6 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -282,8 +282,7 @@ void gfs2_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh,
 		return;
 	}

-	bd = kmem_cache_alloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL),
-	memset(bd, 0, sizeof(struct gfs2_bufdata));
+	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL),
 	bd->bd_bh = bh;
 	bd->bd_gl = gl;

diff --git a/fs/namespace.c b/fs/namespace.c
index 5ef336c..fd999ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -53,9 +53,8 @@ static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)

 struct vfsmount *alloc_vfsmnt(const char *name)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
+	struct vfsmount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
-		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count, 1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
diff --git a/fs/smbfs/request.c b/fs/smbfs/request.c
index a4bcae8..42261db 100644
--- a/fs/smbfs/request.c
+++ b/fs/smbfs/request.c
@@ -61,7 +61,7 @@ static struct smb_request *smb_do_alloc_request(struct smb_sb_info *server,
 	struct smb_request *req;
 	unsigned char *buf = NULL;

-	req = kmem_cache_alloc(req_cachep, GFP_KERNEL);
+	req = kmem_cache_zalloc(req_cachep, GFP_KERNEL);
 	VERBOSE("allocating request: %p\n", req);
 	if (!req)
 		goto out;
@@ -74,7 +74,6 @@ static struct smb_request *smb_do_alloc_request(struct smb_sb_info *server,
 		}
 	}

-	memset(req, 0, sizeof(struct smb_request));
 	req->rq_buffer = buf;
 	req->rq_bufsize = bufsize;
 	req->rq_server = server;
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 511edef..d216a87 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -37,11 +37,10 @@ static struct sysfs_dirent * sysfs_new_dirent(struct sysfs_dirent * parent_sd,
 {
 	struct sysfs_dirent * sd;

-	sd = kmem_cache_alloc(sysfs_dir_cachep, GFP_KERNEL);
+	sd = kmem_cache_zalloc(sysfs_dir_cachep, GFP_KERNEL);
 	if (!sd)
 		return NULL;

-	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
 	atomic_set(&sd->s_event, 1);
 	INIT_LIST_HEAD(&sd->s_children);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 0c775fc..0689e00 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -558,10 +558,9 @@ struct sas_task {
 static inline struct sas_task *sas_alloc_task(gfp_t flags)
 {
 	extern struct kmem_cache *sas_task_cache;
-	struct sas_task *task = kmem_cache_alloc(sas_task_cache, flags);
+	struct sas_task *task = kmem_cache_zalloc(sas_task_cache, flags);

 	if (task) {
-		memset(task, 0, sizeof(*task));
 		INIT_LIST_HEAD(&task->list);
 		spin_lock_init(&task->task_state_lock);
 		task->task_state_flags = SAS_TASK_STATE_PENDING;
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 5fe87de..a1bf616 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -399,10 +399,9 @@ EXPORT_SYMBOL_GPL(register_posix_clock);
 static struct k_itimer * alloc_posix_timer(void)
 {
 	struct k_itimer *tmr;
-	tmr = kmem_cache_alloc(posix_timers_cache, GFP_KERNEL);
+	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 	if (!tmr)
 		return tmr;
-	memset(tmr, 0, sizeof (struct k_itimer));
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = NULL;
diff --git a/net/core/dst.c b/net/core/dst.c
index 836ec66..1aa89a2 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -125,10 +125,9 @@ void * dst_alloc(struct dst_ops * ops)
 		if (ops->gc())
 			return NULL;
 	}
-	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
+	dst = kmem_cache_zalloc(ops->kmem_cachep, GFP_ATOMIC);
 	if (!dst)
 		return NULL;
-	memset(dst, 0, ops->entry_size);
 	atomic_set(&dst->__refcnt, 0);
 	dst->ops = ops;
 	dst->lastuse = jiffies;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e7300b6..0fbacd2 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -251,12 +251,10 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl)
 			goto out_entries;
 	}

-	n = kmem_cache_alloc(tbl->kmem_cachep, GFP_ATOMIC);
+	n = kmem_cache_zalloc(tbl->kmem_cachep, GFP_ATOMIC);
 	if (!n)
 		goto out_entries;

-	memset(n, 0, tbl->entry_size);
-
 	skb_queue_head_init(&n->arp_queue);
 	rwlock_init(&n->lock);
 	n->updated	  = n->used = now;
diff --git a/net/decnet/dn_table.c b/net/decnet/dn_table.c
index 13b2421..1f702cd 100644
--- a/net/decnet/dn_table.c
+++ b/net/decnet/dn_table.c
@@ -590,12 +590,10 @@ create:

 replace:
 	err = -ENOBUFS;
-	new_f = kmem_cache_alloc(dn_hash_kmem, GFP_KERNEL);
+	new_f = kmem_cache_zalloc(dn_hash_kmem, GFP_KERNEL);
 	if (new_f == NULL)
 		goto out;

-	memset(new_f, 0, sizeof(struct dn_fib_node));
-
 	new_f->fn_key = key;
 	new_f->fn_type = type;
 	new_f->fn_scope = r->rtm_scope;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ecb5422..d7e1e60 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -479,20 +479,18 @@ static struct mfc_cache *ipmr_cache_find(__be32 origin, __be32 mcastgrp)
  */
 static struct mfc_cache *ipmr_cache_alloc(void)
 {
-	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, GFP_KERNEL);
+	struct mfc_cache *c=kmem_cache_zalloc(mrt_cachep, GFP_KERNEL);
 	if(c==NULL)
 		return NULL;
-	memset(c, 0, sizeof(*c));
 	c->mfc_un.res.minvif = MAXVIFS;
 	return c;
 }

 static struct mfc_cache *ipmr_cache_alloc_unres(void)
 {
-	struct mfc_cache *c=kmem_cache_alloc(mrt_cachep, GFP_ATOMIC);
+	struct mfc_cache *c=kmem_cache_zalloc(mrt_cachep, GFP_ATOMIC);
 	if(c==NULL)
 		return NULL;
-	memset(c, 0, sizeof(*c));
 	skb_queue_head_init(&c->mfc_un.unres.unresolved);
 	c->mfc_un.unres.expires = jiffies + 10*HZ;
 	return c;
diff --git a/net/ipv4/ipvs/ip_vs_conn.c b/net/ipv4/ipvs/ip_vs_conn.c
index 8086787..3aec4ac 100644
--- a/net/ipv4/ipvs/ip_vs_conn.c
+++ b/net/ipv4/ipvs/ip_vs_conn.c
@@ -603,13 +603,12 @@ ip_vs_conn_new(int proto, __be32 caddr, __be16 cport, __be32 vaddr, __be16 vport
 	struct ip_vs_conn *cp;
 	struct ip_vs_protocol *pp = ip_vs_proto_get(proto);

-	cp = kmem_cache_alloc(ip_vs_conn_cachep, GFP_ATOMIC);
+	cp = kmem_cache_zalloc(ip_vs_conn_cachep, GFP_ATOMIC);
 	if (cp == NULL) {
 		IP_VS_ERR_RL("ip_vs_conn_new: no memory available.\n");
 		return NULL;
 	}

-	memset(cp, 0, sizeof(*cp));
 	INIT_LIST_HEAD(&cp->c_list);
 	init_timer(&cp->timer);
 	cp->timer.data     = (unsigned long)cp;
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
index 8556a4f..62be2eb 100644
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -638,14 +638,13 @@ struct ip_conntrack *ip_conntrack_alloc(struct ip_conntrack_tuple *orig,
 		}
 	}

-	conntrack = kmem_cache_alloc(ip_conntrack_cachep, GFP_ATOMIC);
+	conntrack = kmem_cache_zalloc(ip_conntrack_cachep, GFP_ATOMIC);
 	if (!conntrack) {
 		DEBUGP("Can't allocate conntrack.\n");
 		atomic_dec(&ip_conntrack_count);
 		return ERR_PTR(-ENOMEM);
 	}

-	memset(conntrack, 0, sizeof(*conntrack));
 	atomic_set(&conntrack->ct_general.use, 1);
 	conntrack->ct_general.destroy = destroy_conntrack;
 	conntrack->tuplehash[IP_CT_DIR_ORIGINAL].tuple = *orig;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 96d8310..827f884 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -150,8 +150,7 @@ static __inline__ struct fib6_node * node_alloc(void)
 {
 	struct fib6_node *fn;

-	if ((fn = kmem_cache_alloc(fib6_node_kmem, GFP_ATOMIC)) != NULL)
-		memset(fn, 0, sizeof(struct fib6_node));
+	fn = kmem_cache_zalloc(fib6_node_kmem, GFP_ATOMIC);

 	return fn;
 }
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 30927d3..3424c5d 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -979,11 +979,10 @@ struct sctp_chunk *sctp_chunkify(struct sk_buff *skb,
 {
 	struct sctp_chunk *retval;

-	retval = kmem_cache_alloc(sctp_chunk_cachep, GFP_ATOMIC);
+	retval = kmem_cache_zalloc(sctp_chunk_cachep, GFP_ATOMIC);

 	if (!retval)
 		goto nodata;
-	memset(retval, 0, sizeof(struct sctp_chunk));

 	if (!sk) {
 		SCTP_DEBUG_PRINTK("chunkifying skb %p w/o an sk\n", skb);
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index e7c0b5e..da8caf1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -332,11 +332,10 @@ static struct avc_node *avc_alloc_node(void)
 {
 	struct avc_node *node;

-	node = kmem_cache_alloc(avc_node_cachep, GFP_ATOMIC);
+	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC);
 	if (!node)
 		goto out;

-	memset(node, 0, sizeof(*node));
 	INIT_RCU_HEAD(&node->rhead);
 	INIT_LIST_HEAD(&node->list);
 	atomic_set(&node->ae.used, 1);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65fb5e8..9eeab82 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -181,11 +181,10 @@ static int inode_alloc_security(struct inode *inode)
 	struct task_security_struct *tsec = current->security;
 	struct inode_security_struct *isec;

-	isec = kmem_cache_alloc(sel_inode_cache, GFP_KERNEL);
+	isec = kmem_cache_zalloc(sel_inode_cache, GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;

-	memset(isec, 0, sizeof(*isec));
 	mutex_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index ebb993c..9142073 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -36,10 +36,9 @@ avtab_insert_node(struct avtab *h, int hvalue,
 		  struct avtab_key *key, struct avtab_datum *datum)
 {
 	struct avtab_node * newnode;
-	newnode = kmem_cache_alloc(avtab_node_cachep, GFP_KERNEL);
+	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
 	if (newnode == NULL)
 		return NULL;
-	memset(newnode, 0, sizeof(struct avtab_node));
 	newnode->key = *key;
 	newnode->datum = *datum;
 	if (prev) {

