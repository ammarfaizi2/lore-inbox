Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291253AbSBLXOQ>; Tue, 12 Feb 2002 18:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291252AbSBLXOA>; Tue, 12 Feb 2002 18:14:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291243AbSBLXNg>;
	Tue, 12 Feb 2002 18:13:36 -0500
Message-ID: <3C69A16C.1536FFDF@zip.com.au>
Date: Tue, 12 Feb 2002 15:12:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: [patch] BUG unpigginess
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to the new BUG code.  Shrinks the kernel
by 100 to 200 kbytes, while providing proper file-n-line
info.

This addresses most of Hugh's recent comments.   It
got simpler.


--- linux-2.4.18-pre9/include/asm-i386/mmu_context.h	Tue Oct 23 21:59:06 2001
+++ linux-akpm/include/asm-i386/mmu_context.h	Tue Feb 12 14:56:32 2002
@@ -48,7 +48,7 @@ static inline void switch_mm(struct mm_s
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
 		if(cpu_tlbstate[cpu].active_mm != next)
-			BUG();
+			out_of_line_bug();
 		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must flush our tlb.
--- linux-2.4.18-pre9/include/linux/kernel.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/linux/kernel.h	Tue Feb 12 14:56:32 2002
@@ -181,4 +181,6 @@ struct sysinfo {
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+extern void out_of_line_bug(void) ATTRIB_NORET;
+
 #endif
--- linux-2.4.18-pre9/include/asm-i386/pci.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/asm-i386/pci.h	Tue Feb 12 14:56:32 2002
@@ -73,7 +73,7 @@ static inline dma_addr_t pci_map_single(
 					size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	flush_write_buffers();
 	return virt_to_bus(ptr);
 }
@@ -89,7 +89,7 @@ static inline void pci_unmap_single(stru
 				    size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	/* Nothing to do */
 }
 
@@ -101,7 +101,7 @@ static inline dma_addr_t pci_map_page(st
 				      unsigned long offset, size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 
 	return (page - mem_map) * PAGE_SIZE + offset;
 }
@@ -110,7 +110,7 @@ static inline void pci_unmap_page(struct
 				  size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	/* Nothing to do */
 }
 
@@ -143,16 +143,16 @@ static inline int pci_map_sg(struct pci_
 	int i;
 
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
  
  	/*
  	 * temporary 2.4 hack
  	 */
  	for (i = 0; i < nents; i++ ) {
  		if (sg[i].address && sg[i].page)
- 			BUG();
+ 			out_of_line_bug();
  		else if (!sg[i].address && !sg[i].page)
- 			BUG();
+ 			out_of_line_bug();
  
  		if (sg[i].address)
  			sg[i].dma_address = virt_to_bus(sg[i].address);
@@ -172,7 +172,7 @@ static inline void pci_unmap_sg(struct p
 				int nents, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	/* Nothing to do */
 }
 
@@ -190,7 +190,7 @@ static inline void pci_dma_sync_single(s
 				       size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	flush_write_buffers();
 }
 
@@ -205,7 +205,7 @@ static inline void pci_dma_sync_sg(struc
 				   int nelems, int direction)
 {
 	if (direction == PCI_DMA_NONE)
-		BUG();
+		out_of_line_bug();
 	flush_write_buffers();
 }
 
--- linux-2.4.18-pre9/include/asm-i386/smplock.h	Tue Oct 23 21:59:10 2001
+++ linux-akpm/include/asm-i386/smplock.h	Tue Feb 12 14:56:32 2002
@@ -59,7 +59,7 @@ static __inline__ void lock_kernel(void)
 static __inline__ void unlock_kernel(void)
 {
 	if (current->lock_depth < 0)
-		BUG();
+		out_of_line_bug();
 #if 1
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
--- linux-2.4.18-pre9/include/linux/dcache.h	Tue Oct 23 21:59:05 2001
+++ linux-akpm/include/linux/dcache.h	Tue Feb 12 14:56:32 2002
@@ -242,11 +242,8 @@ extern char * __d_path(struct dentry *, 
  
 static __inline__ struct dentry * dget(struct dentry *dentry)
 {
-	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
+	if (dentry)
 		atomic_inc(&dentry->d_count);
-	}
 	return dentry;
 }
 
--- linux-2.4.18-pre9/include/linux/file.h	Wed Aug 23 11:22:26 2000
+++ linux-akpm/include/linux/file.h	Tue Feb 12 14:56:32 2002
@@ -71,30 +71,7 @@ static inline void put_unused_fd(unsigne
 	write_unlock(&files->file_lock);
 }
 
-/*
- * Install a file pointer in the fd array.  
- *
- * The VFS is full of places where we drop the files lock between
- * setting the open_fds bitmap and installing the file in the file
- * array.  At any such point, we are vulnerable to a dup2() race
- * installing a file in the array before us.  We need to detect this and
- * fput() the struct file we are about to overwrite in this case.
- *
- * It should never happen - if we allow dup2() do it, _really_ bad things
- * will follow.
- */
-
-static inline void fd_install(unsigned int fd, struct file * file)
-{
-	struct files_struct *files = current->files;
-	
-	write_lock(&files->file_lock);
-	if (files->fd[fd])
-		BUG();
-	files->fd[fd] = file;
-	write_unlock(&files->file_lock);
-}
-
+void fd_install(unsigned int fd, struct file * file);
 void put_files_struct(struct files_struct *fs);
 
 #endif /* __LINUX_FILE_H */
--- linux-2.4.18-pre9/include/linux/nfs_fs.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/nfs_fs.h	Tue Feb 12 14:56:32 2002
@@ -168,7 +168,7 @@ nfs_file_cred(struct file *file)
 	struct rpc_cred *cred = (struct rpc_cred *)(file->private_data);
 #ifdef RPC_DEBUG
 	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
-		BUG();
+		out_of_line_bug();
 #endif
 	return cred;
 }
--- linux-2.4.18-pre9/include/linux/quotaops.h	Tue Oct 23 21:59:31 2001
+++ linux-akpm/include/linux/quotaops.h	Tue Feb 12 14:56:32 2002
@@ -40,8 +40,6 @@ extern int  dquot_transfer(struct inode 
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
-	if (!inode->i_sb)
-		BUG();
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
@@ -51,11 +49,8 @@ static __inline__ void DQUOT_INIT(struct
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
 	lock_kernel();
-	if (IS_QUOTAINIT(inode)) {
-		if (!inode->i_sb)
-			BUG();
+	if (IS_QUOTAINIT(inode))
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
-	}
 	unlock_kernel();
 }
 
--- linux-2.4.18-pre9/include/linux/sched.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/sched.h	Tue Feb 12 14:56:32 2002
@@ -888,7 +888,6 @@ static inline int task_on_runqueue(struc
 
 static inline void unhash_process(struct task_struct *p)
 {
-	if (task_on_runqueue(p)) BUG();
 	write_lock_irq(&tasklist_lock);
 	nr_threads--;
 	unhash_pid(p);
--- linux-2.4.18-pre9/include/linux/highmem.h	Thu Feb  7 13:04:22 2002
+++ linux-akpm/include/linux/highmem.h	Tue Feb 12 14:56:32 2002
@@ -63,8 +63,6 @@ static inline void memclear_highpage_flu
 {
 	char *kaddr;
 
-	if (offset + size > PAGE_SIZE)
-		BUG();
 	kaddr = kmap(page);
 	memset(kaddr + offset, 0, size);
 	flush_dcache_page(page);
--- linux-2.4.18-pre9/include/linux/skbuff.h	Mon Nov  5 21:01:12 2001
+++ linux-akpm/include/linux/skbuff.h	Tue Feb 12 14:56:32 2002
@@ -756,9 +756,9 @@ static inline int skb_headlen(const stru
 	return skb->len - skb->data_len;
 }
 
-#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) BUG(); } while (0)
-#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) BUG(); } while (0)
-#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) BUG(); } while (0)
+#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) out_of_line_bug(); } while (0)
+#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) out_of_line_bug(); } while (0)
+#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) out_of_line_bug(); } while (0)
 
 /*
  *	Add data to an sk_buff
@@ -825,8 +825,6 @@ static inline unsigned char *skb_push(st
 static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
 	skb->len-=len;
-	if (skb->len < skb->data_len)
-		BUG();
 	return 	skb->data+=len;
 }
 
@@ -1094,7 +1092,7 @@ static inline void *kmap_skb_frag(const 
 {
 #ifdef CONFIG_HIGHMEM
 	if (in_irq())
-		BUG();
+		out_of_line_bug();
 
 	local_bh_disable();
 #endif
--- linux-2.4.18-pre9/include/asm-i386/highmem.h	Tue Oct 23 21:59:06 2001
+++ linux-akpm/include/asm-i386/highmem.h	Tue Feb 12 14:56:32 2002
@@ -62,7 +62,7 @@ extern void FASTCALL(kunmap_high(struct 
 static inline void *kmap(struct page *page)
 {
 	if (in_interrupt())
-		BUG();
+		out_of_line_bug();
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -71,7 +71,7 @@ static inline void *kmap(struct page *pa
 static inline void kunmap(struct page *page)
 {
 	if (in_interrupt())
-		BUG();
+		out_of_line_bug();
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
@@ -95,7 +95,7 @@ static inline void *kmap_atomic(struct p
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #if HIGHMEM_DEBUG
 	if (!pte_none(*(kmap_pte-idx)))
-		BUG();
+		out_of_line_bug();
 #endif
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
 	__flush_tlb_one(vaddr);
@@ -113,7 +113,7 @@ static inline void kunmap_atomic(void *k
 		return;
 
 	if (vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx))
-		BUG();
+		out_of_line_bug();
 
 	/*
 	 * force other mappings to Oops if they'll try to access
--- linux-2.4.18-pre9/include/net/tcp.h	Tue Oct 23 21:59:58 2001
+++ linux-akpm/include/net/tcp.h	Tue Feb 12 14:56:32 2002
@@ -1329,8 +1329,6 @@ static __inline__ int tcp_prequeue(struc
 		if (tp->ucopy.memory > sk->rcvbuf) {
 			struct sk_buff *skb1;
 
-			if (sk->lock.users) BUG();
-
 			while ((skb1 = __skb_dequeue(&tp->ucopy.prequeue)) != NULL) {
 				sk->backlog_rcv(sk, skb1);
 				NET_INC_STATS_BH(TCPPrequeueDropped);
--- linux-2.4.18-pre9/fs/open.c	Fri Oct 12 13:48:42 2001
+++ linux-akpm/fs/open.c	Tue Feb 12 14:56:39 2002
@@ -71,6 +71,30 @@ out:
 	return error;
 }
 
+/*
+ * Install a file pointer in the fd array.  
+ *
+ * The VFS is full of places where we drop the files lock between
+ * setting the open_fds bitmap and installing the file in the file
+ * array.  At any such point, we are vulnerable to a dup2() race
+ * installing a file in the array before us.  We need to detect this and
+ * fput() the struct file we are about to overwrite in this case.
+ *
+ * It should never happen - if we allow dup2() do it, _really_ bad things
+ * will follow.
+ */
+
+void fd_install(unsigned int fd, struct file * file)
+{
+	struct files_struct *files = current->files;
+	
+	write_lock(&files->file_lock);
+	if (files->fd[fd])
+		BUG();
+	files->fd[fd] = file;
+	write_unlock(&files->file_lock);
+}
+
 int do_truncate(struct dentry *dentry, loff_t length)
 {
 	struct inode *inode = dentry->d_inode;
--- linux-2.4.18-pre9/kernel/ksyms.c	Thu Feb  7 13:04:22 2002
+++ linux-akpm/kernel/ksyms.c	Tue Feb 12 14:56:32 2002
@@ -164,6 +164,7 @@ EXPORT_SYMBOL(mark_buffer_dirty);
 EXPORT_SYMBOL(set_buffer_async_io); /* for reiserfs_writepage */
 EXPORT_SYMBOL(__mark_buffer_dirty);
 EXPORT_SYMBOL(__mark_inode_dirty);
+EXPORT_SYMBOL(fd_install);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);
 EXPORT_SYMBOL(filp_open);
@@ -452,6 +453,7 @@ EXPORT_SYMBOL(nr_running);
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);
 EXPORT_SYMBOL(sscanf);
--- linux-2.4.18-pre9/kernel/panic.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/kernel/panic.c	Tue Feb 12 14:56:32 2002
@@ -120,3 +120,21 @@ const char *print_tainted()
 }
 
 int tainted = 0;
+
+/*
+ * A BUG() call in an inline function in a header should be avoided,
+ * because it can seriously bloat the kernel.  So here we have
+ * helper functions.
+ * We lose the BUG()-time file-and-line info this way, but it's
+ * usually not very useful from an inline anyway.  The backtrace
+ * tells us what we want to know.
+ */
+
+void out_of_line_bug(void)
+{
+	BUG();
+
+	/* Satisfy __attribute__((noreturn)) */
+	for ( ; ; )
+		;
+}


-
