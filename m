Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCKDnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCKDnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVCKDnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:43:51 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:10378 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261178AbVCKDhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:37:20 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 14:37:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
Subject: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



USER LEVEL DRIVERS: enable PCI device drivers at user space.

This patch adds the capability for suitably privileged user-level processes to 
enable a PCI device, and set up DMA for it.  A subsequent patch hooks up 
the actual system calls.

There are three new system calls:

  long   usr_pci_open(int bus, int slot, int function, __u64 dma_mask);
	 Returns a filedescriptor for the PCI device described 
	 by bus,slot,function.  It also enables the device, and sets it 
	 up as a bus-mastering DMA device, with the specified dma mask.

	 Error codes are:
	ENOMEM: insufficient kernel memory to fulfil your  request
	ENOENT: the specified device doesn't exist, or is otherwise
	        invisible to Linux.
	EBUSY: Another driver has claimed the device
	EIO:   The specified dma mask is invalid for this device.
	ENFILE: too many open files

      long usr_pci_get_consistent(int fd, size_t size, void **vaddrp, unsigned long *dmaaddrp)

	Call pci_alloc_consistent() to get size worth of pci
	consistent memory (currently an error if size != PAGESIZE); 
	map the allocated memory into the user's address space; 
	return the virtual user address in *vaddrp, and the bus 
	address in *dmaaddrp

	ERRORS:
	EINVAL: the filedescriptor was not one obtained from usr_pci_open(), or
		size != PAGESIZE
	ENOMEM: insufficient  appropriate memory or insufficient free 
		virtual address space in the user program.
	EFAULT: vaddrp or dmaaddrp didn't point to writeable memory.

	The mapping obtained can be cleaned up with munmap().

   long usr_pci_mmap(int fd, struct mapping_info *mp) -- 
	map some memory for DMA to/from the device represented by fd, 
	which was obtained from usr_pci_open().

	struct mapping_info contains:
		void *virtaddr -- the virtual address to dma to
		int size -- how many bytes to set up
		struct usr_pci_sglist *sglist -- a pointer to a scatterlist
		int nents -- how many entries in the scatterlist
		enum dma_data_direction direction --- which way the 
		dma is going to happen.

	The scatterlist should be sized at least size/PAGESIZE + 2.

	usr_pci_mmap() will call pci_map_sg() on the virtual region, 
	then copy the resulting scatterlist into *sglist.  The nents field 
	will be updated with the actual number of scatterlist entries filled in.

	Failure codes are:
	EINVAL: the fd wasn't obtained from usr_pci_open, or 
		direction wasn't one of DMA_TO_DEVICE, DMA_FROM_DEVICE 
		or DMA_BIDIRECTIONAL, or the size of the 
		scatterlist is insufficient to map the region.
	EFAULT: mp was a bad pointer, or the region of memory spanned 
	        by (virtaddr, virtaddr + size) was not all mapped.
	ENOMEM: insufficient appropriate memory

   long usr_pci_munmap(int fd, struct mapping_info *mp)
	Unmap a dma region mapped by usr_pci_map().
	Struct mapping info is the same one used in usr_pci_mmap().

	Error codes are:
	EINVAL: : the fd wasn't obtained from usr_pci_open, or the 
	          struct mapping_info was never mapped for this device


Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>	


#
# drivers/Makefile       |    3 
# drivers/pci/Kconfig    |    6 
# drivers/usr/Makefile   |    2 
# drivers/usr/sys.c      |  952 +++++++++++++++++++++++++++++++++++++++++++++++++
# include/linux/usrdrv.h |   63 +++
# 5 files changed, 1026 insertions(+)
#
Index: linux-2.6.11-usrdrivers/drivers/Makefile
===================================================================
--- linux-2.6.11-usrdrivers.orig/drivers/Makefile	2005-03-11 12:25:29.169139978 +1100
+++ linux-2.6.11-usrdrivers/drivers/Makefile	2005-03-11 12:25:41.159270471 +1100
@@ -13,6 +13,9 @@
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
 
+# User level device drivers
+obj-$(CONFIG_USRDEV)			+= usr/
+
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
Index: linux-2.6.11-usrdrivers/drivers/usr/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-usrdrivers/drivers/usr/Makefile	2005-03-11 12:25:41.160247026 +1100
@@ -0,0 +1,2 @@
+obj-y	+= sys.o 
+obj-$(CONFIG_USRBLKDEV) += blkdev.o
Index: linux-2.6.11-usrdrivers/drivers/usr/sys.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-usrdrivers/drivers/usr/sys.c	2005-03-11 14:15:59.897394833 +1100
@@ -0,0 +1,952 @@
+/*
+ * Expose PCI-DMA interface to user mode.
+ *
+ * Copyright 2005 Peter Chubb
+ * National ICT Australia, and the Gelato Project, 
+ * Computer Science and Engineering, UNSW
+ * 
+ * This file is licensed under the Gnu General Public Licence, version 2.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/usrdrv.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/mman.h>
+#include <linux/err.h>
+#include <asm/uaccess.h>
+#include <asm/io.h> /* virt_to_phys() on alpha */
+
+#ifdef CONFIG_USRDEV
+
+/*
+ * For mappings < KMALLOC_BREAKPOINT pages, keep a cache;
+ * otherwise use kmalloc/kfree
+ */
+#define KMALLOC_BREAKPOINT 10
+
+
+/*
+ * The PCI subsystem is implemented as yet-another pseudo filesystem,
+ * albeit one that is never mounted.
+ * This is its magic number.
+ */
+#define USR_PCI_MAGIC (0x12345678)
+
+static int usr_pci_release(struct inode *ip, struct file *fp);
+static void usr_pci_unmapconsistent(struct vm_area_struct *vma);
+static int usr_pci_delete_dentry(struct dentry *dp);
+
+static struct vfsmount *usr_pci_mnt;
+static struct file_operations usr_pci_fops = {
+	.release	= usr_pci_release,
+};
+
+
+/*
+ * Filesystem glue.
+ */
+
+static int
+usr_pci_delete_dentry(struct dentry *dp)
+{
+	return 1;
+}
+
+
+static struct super_block *usr_pci_getsb(
+	struct file_system_type *fstype,
+	int flags,
+	const char *dev_name,
+	void *data) 
+{
+	return get_sb_pseudo(fstype, "usr_pci:", NULL, USR_PCI_MAGIC);
+}
+
+
+static struct dentry_operations usr_pci_dentry_operations = {
+	.d_delete	= usr_pci_delete_dentry,
+};
+
+
+static struct file_system_type usr_pci_fs_type = {
+	.name = "usr_pci_fs",
+	.get_sb	= usr_pci_getsb,
+	.kill_sb = kill_anon_super,
+};
+
+
+/*
+ * Describe a block of PCI-consistent memory mapped by the usr_map_pci()
+ * system call
+ */
+struct consistent_mem {
+	struct pci_dev *devp;	/* the device we're mapping for */
+	unsigned long len;	/* how many bytes */
+	unsigned long kaddr;	/* where in kernel memory it is */
+	dma_addr_t dmaaddr;	/* where it's mapped from the PCI bus */
+};
+
+/*
+ * Each instance of an internal_mapping_info tracks
+ * a mapping set up by userspace, so that it can be torn down
+ * when the process dies, or on request.
+ *
+ * A chain of free struct internal_mapping_info
+ * are kept as a quicklist, and a chain of in-use ones are chained from an
+ * open file descriptor on the usr_pci_fs filesystem.
+ */
+struct internal_mapping_info {
+	struct internal_mapping_info *next;
+	struct mapping_info m;
+	unsigned nent;		 /* number of entries in sg[] */
+	unsigned npages;	 /* number of entries in pages[] */
+	struct scatterlist *sg;
+	struct page *pages[1];
+};
+
+/*
+ * The private open-file data.
+ * --- the list of struct internal_mapping_info,
+ *     a lock to protect the list,
+ *     and a pointer to the PCI device we're managing.
+ */
+struct maplist {
+	struct pci_dev *dev;
+	spinlock_t lk;		/* protect the mappings list */
+	struct internal_mapping_info *mappings;
+};
+
+
+
+static struct vm_operations_struct usr_pci_vmop =  {
+	.close = usr_pci_unmapconsistent,
+};
+
+
+/*
+ * Free list of mappings, and a spinlock to protect it.
+ */
+static struct internal_mapping_info *imap_free;
+static spinlock_t imap_free_lock = SPIN_LOCK_UNLOCKED;
+
+/**
+ * get_imap: allocate and  an internal_mapping_info structure
+ * @npages: the number of pages that the mapping will cover.
+ *
+ * If the mapping is for fewer than KMALLOC_BREAKPOINT pages, 
+ * use the quicklist, otherwise use kmalloc.
+ *
+ */
+static struct internal_mapping_info *
+get_imap(int npages)
+{
+	unsigned long flags;
+	struct internal_mapping_info *ip = NULL;
+
+	if (imap_free && npages <= KMALLOC_BREAKPOINT) {
+		spin_lock_irqsave(&imap_free_lock, flags);
+		if (imap_free) {
+			ip = imap_free;
+			imap_free = ip->next;
+		}
+		spin_unlock_irqrestore(&imap_free_lock, flags);
+	}
+	
+	if (ip == NULL) {
+		if (npages < KMALLOC_BREAKPOINT)
+			npages = KMALLOC_BREAKPOINT;
+		ip = kmalloc(sizeof (*ip) + 
+			     npages * (sizeof (struct page *) + 
+				       sizeof(struct scatterlist)), GFP_KERNEL);
+	}
+	
+	if (ip) {
+		ip->next = NULL;
+		ip->sg = (struct scatterlist *)&ip->pages[npages];
+		ip->npages = 0;
+	}
+
+	return ip;
+}
+
+
+/**
+ * get_imap: allocate and  an internal_mapping_info structure
+ * @ip: a pointer to the structure to free.
+ *
+ * If the mapping is for fewer than KMALLOC_BREAKPOINT pages, 
+ * save the mapping structure onto the  quicklist, otherwise use kfree..
+ *
+ * As a side-effect, release all pages covered by the mapping.
+ */
+static void 
+free_imap(struct internal_mapping_info *ip)
+{
+	int i;
+	unsigned long flags;
+
+	for (i = 0; i < ip->npages; i++)
+		if (!PageReserved(ip->pages[i]))
+			page_cache_release(ip->pages[i]);
+	if (ip->npages > KMALLOC_BREAKPOINT) {
+		kfree(ip);
+		return;
+	}
+
+	spin_lock_irqsave(&imap_free_lock, flags);
+	ip->next = imap_free;
+	imap_free = ip;
+	spin_unlock_irqrestore(&imap_free_lock, flags);
+}
+
+/**
+ * get_hw: Allocate a scatterlist in the right format to be  copied to userspace
+ * @n: the number of pages to cover.
+ *
+ * As there's no next pointer in a struct usr_pci_sglist, 
+ * we chain on the first word cast to a void.
+ */
+static void *hw_free;
+static spinlock_t hw_free_lock = SPIN_LOCK_UNLOCKED;
+
+static struct usr_pci_sglist *
+get_hw(int n)
+{
+	struct usr_pci_sglist *p;
+	unsigned long flags;
+
+	if (hw_free && n <= KMALLOC_BREAKPOINT) {
+		spin_lock_irqsave(&hw_free_lock, flags);
+		if ((p = hw_free))
+			hw_free = *(void **)p;
+		spin_unlock_irqrestore(&hw_free_lock, flags);
+		if (p)
+			return p;
+	}
+	p = kmalloc((sizeof *p) * 
+		    (n >= KMALLOC_BREAKPOINT ? n : KMALLOC_BREAKPOINT), 
+		    GFP_KERNEL);
+	return p;
+}
+
+/**
+ * free_hw: free a scatterlist
+ * @n: the number of pages covered by the scatterlist
+ * @p: a pointer to the scatterlist to free.
+ *
+ * If the number of pages covered is small (less than KMALLOC_BREAKPOINT) 
+ * save the list to a quicklist.  Otherwise, use kfree.
+ */
+static void
+free_hw(int n, struct usr_pci_sglist *p)
+{
+	unsigned long flags;
+
+	if (n > KMALLOC_BREAKPOINT) {
+		kfree(p);
+		return;
+	}
+
+	spin_lock_irqsave(&hw_free_lock, flags);
+	*(void **)p = hw_free;
+	hw_free = (void *)p;
+	spin_unlock_irqrestore(&hw_free_lock, flags);
+}
+
+/**
+ * usr_pci_inode: create an inode for the usr_pci pseudo fs.
+ *
+ */
+static struct inode *
+usr_pci_inode(void)
+{
+	struct inode *inode = new_inode(usr_pci_mnt->mnt_sb);
+	if (!inode)
+		return (struct inode *)-ENOMEM;
+
+	inode->i_fop = &usr_pci_fops;
+
+	/*
+	 * Mark the inode dirty from the very beginning,
+	 * that way it will never be moved to the dirty
+	 * list because mark_inode_dirty() will think
+	 * that it already _is_ on the dirty list.
+	 */
+	inode->i_state = I_DIRTY;
+	inode->i_mode = S_IRUSR | S_IWUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_blksize = PAGE_SIZE;
+	return inode;
+}
+
+/**
+ * usr_pci_get_dev
+ * @fd: file descriptor returned from sys_usr_pci_open()
+ * @pp: returned &struct pci_dev corresponding to fd
+ * @fpp: returned pointer to  &struct file corresponding to fd
+ *
+ * usr_pci_get_dev() is  a helper for the user-level block driver code.
+ * It's used to prevent the device from being released while it 
+ * is registered as a block device, and to return data needed for the 
+ * user<->kernel interface.
+ *
+ * In use, it hould be paired with an (eventual) usr_pci_put_dev() call.
+ */
+int 
+usr_pci_get_dev(int fd, struct pci_dev **pp, struct file **fpp)
+{
+	struct file *filp = fget(fd);
+	struct maplist *p;
+
+	if (!filp)
+		return -EINVAL;
+	if (filp->f_op != &usr_pci_fops) {
+		fput(filp);
+		return -EINVAL;
+	}
+	p =  (struct maplist *)filp->private_data;
+
+	if (!p) {
+		printk(KERN_ERR "usr_pci_fs file has no PCI device???");
+		return -EINVAL;
+	}
+	*pp = p->dev;
+	*fpp = filp;
+	return 0;
+}
+
+/**
+ * usr_pci_put_dev: reverse usr_pci_get_dev()
+ *
+ */
+void
+usr_pci_put_dev(struct file *fp)
+{
+	fput(fp);
+}
+EXPORT_SYMBOL(usr_pci_get_dev);
+EXPORT_SYMBOL(usr_pci_put_dev);
+
+/**
+ * sys_usr_pci_open: Associate an open file descriptor in usr_pci_fs with a PCI device.
+ * @bus, @slot, @function: the PCI address of the device.
+ * @dma_mask: a mask saying what the dma capabilities of the device are.
+ *
+ * Find and attempt to enable the device at (bus, slot, function) as a 
+ * pci bus-mastering device.
+ * Set up an open-file descriptor, with the device and 
+ * the (currently null set of)  mappings associated with the device.
+ */
+long asmlinkage
+sys_usr_pci_open(int bus, int slot, int function, __u64 dma_mask)
+{
+	struct qstr this;
+	int error;
+	int fn;
+
+	char name[32];
+	struct pci_dev *devp = NULL;
+	struct inode *inode;
+	struct dentry *dentry;
+	struct file *file;
+	struct maplist *mp;
+	int fd;
+
+
+	fn = ((slot & 0x1f) << 3) | (function & 0x7);
+
+	mp = kmalloc(sizeof *mp, GFP_KERNEL);
+	if (mp == NULL)
+		return -ENOMEM;
+	mp->mappings = NULL;
+	spin_lock_init(&mp->lk);
+	
+	devp = pci_find_slot(bus, fn);
+	if (devp == NULL) {
+		error = -ENOENT;
+		goto out1;
+	}
+
+	mp->dev = devp;
+
+	this.hash = (bus<<8) | fn;
+	sprintf(name, "%d.%x.%d", bus, slot, fn);
+	this.len = strlen(name);
+	this.name = name;
+
+	/*
+	 * RACE here -- another process could grab the device after
+	 * we've checked.  Also we don't check properly against
+	 * in-kernel device uses.
+	 */
+	dentry = d_lookup(usr_pci_mnt->mnt_sb->s_root, &this);
+	if (dentry) {
+		error = -EBUSY;
+		goto out2;
+	}
+
+	dentry = d_alloc(usr_pci_mnt->mnt_sb->s_root, &this);
+	if (!dentry) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	if (devp->is_enabled) {
+		error = -EBUSY;
+		goto out2;
+	}
+
+	if ((error = pci_enable_device(devp)) != 0) {
+		goto out2;
+	}
+
+	if (dma_mask) {
+		error = pci_set_dma_mask(devp, dma_mask);
+		if (error)
+			goto out3;
+	}
+        pci_set_master(devp);
+
+
+	file = get_empty_filp();
+	if (!file) {
+		error = -ENFILE;
+		goto out3;
+	}
+
+	inode = usr_pci_inode();
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
+		goto out4;
+	}
+
+	dentry->d_op = &usr_pci_dentry_operations;
+	d_add(dentry, inode);
+
+	fd = error = get_unused_fd();
+	if (error < 0) {
+		goto out5;
+	}
+
+	file->f_vfsmnt = mntget(usr_pci_mnt);
+
+	/*
+	 * No dget() here -- we want this entry to go away when the
+	 * file is closed.
+	 */
+	file->f_dentry = dentry;
+	file->f_op = &usr_pci_fops;
+	file->private_data = (void *)mp;
+
+	fd_install(fd, file);
+	return fd;
+
+ out5:
+	iput(inode);
+ out4:
+	put_filp(file);
+ out3:
+	pci_disable_device(devp);
+ out2:
+	dput(dentry);
+ out1:
+	kfree(mp);	
+	return error;
+}
+
+/*
+ * Filesystem glue 
+ */
+static int __init 
+usr_pci_init(void)
+{
+	int error;
+
+	error = register_filesystem(&usr_pci_fs_type);
+	if (error)
+		return error;
+	usr_pci_mnt = kern_mount(&usr_pci_fs_type);
+	if (IS_ERR(usr_pci_mnt)) {
+		unregister_filesystem(&usr_pci_fs_type);
+		return PTR_ERR(usr_pci_mnt);
+	}
+
+	return 0;
+}
+
+__initcall(usr_pci_init);
+
+
+/**
+ * usr_pci_release; clean up when a user_pci_fs file is closed
+ * @ip: pointer to the inode of the file being closed
+ * @fp: pointer to the file being closed.
+ *
+ * This function is called when the reference count on the open 
+ * file falls to zero. 
+ * Disable the pci device (which will stop any DMA), and clean up any mappings
+ */
+static int
+usr_pci_release(struct inode *ip, struct file *fp)
+{
+	struct maplist *mp = (struct maplist *)fp->private_data;
+	struct internal_mapping_info *mip;
+
+	fp->private_data = NULL;
+
+	/* Force DMA to stop */
+	pci_disable_device(mp->dev);
+
+	mip = mp->mappings;
+
+	/*
+	 * We're single-threaded here
+	 */
+	while (mip) {
+		struct internal_mapping_info *im = mip;
+		mip = mip->next;
+
+		pci_unmap_sg(mp->dev, im->sg, im->nent, im->m.direction);
+		free_imap(im);
+	}
+
+		
+	kfree(mp);
+	return 0;
+}
+
+
+/**
+ * do_map: Map contiguous kernel pages into user memory.
+ * @kaddr: the kernel  address of the first page to map
+ * @origlen: the length (in bytes) of the mapping.
+ * @dmaaddr: the bus address of the first page to map
+ * @devp: a pointer to the pci_dev that's going to use the memory
+ *
+ * Find a free area of memory, map the kernel pages into it, 
+ * and mark the space as non-cached and reserved.
+ * Returns the user-space virtual address of the mapping, or ENOMEM if 
+ * one could not be created.
+ */
+static void __user *
+do_map(void *kaddr,
+       unsigned long origlen, 
+       unsigned long dmaaddr, 
+       struct pci_dev *devp)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr;
+	unsigned long len = PAGE_ALIGN(origlen);
+	struct consistent_mem *mp;
+
+
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma)
+		return (void __user *)(-ENOMEM);
+
+	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	if (!mp){
+		kmem_cache_free(vm_area_cachep, vma);
+		return (void __user *)(-ENOMEM);
+	}
+	memset(vma, 0, sizeof *vma);
+
+	mp->devp = devp;
+	mp->kaddr = (unsigned long)kaddr;
+	mp->dmaaddr = dmaaddr;
+	mp->len = origlen;
+
+	vma->vm_mm = mm;
+	vma->vm_flags = VM_WRITE|VM_MAYWRITE|VM_READ|VM_MAYREAD|VM_RESERVED|VM_DONTCOPY;
+	vma->vm_flags |= VM_SHM|VM_LOCKED;
+	vma->vm_page_prot = PAGE_SHARED;
+	/* 
+	 * Should this be marked uncached? 
+	 * It seems to work without on alpha, i386, ia64
+	 */
+	/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
+
+	vma->vm_ops = &usr_pci_vmop;
+ 	vma->vm_private_data = mp;
+
+	down_write(&mm->mmap_sem);
+	addr = get_unmapped_area(NULL, 0, len, 0, MAP_LOCKED|MAP_SHARED);
+	if (PTR_ERR((void *)addr) == -ENOMEM) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		kfree(mp);
+		return (void __user *)(-ENOMEM);
+	}
+
+	vma->vm_start = addr;
+	vma->vm_end = addr + len;
+
+	mm->total_vm  += len >> PAGE_SHIFT;
+
+	insert_vm_struct(mm, vma);
+
+	while (len >= PAGE_SIZE) {
+		long page = virt_to_phys(kaddr);
+		if (remap_pfn_range(vma, addr, page >> PAGE_SHIFT, PAGE_SIZE, PAGE_SHARED)) {
+			up_write(&mm->mmap_sem);
+			do_munmap(mm, vma->vm_start, origlen);
+			return (void __user *)(-ENOMEM);
+		}
+		addr += PAGE_SIZE;
+		kaddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
+	}
+
+	up_write(&mm->mmap_sem);
+	return (void __user *)vma->vm_start;
+}
+
+
+/**
+ * usr_pci_unmapconsistent:  Undo a pci-consistent mapping into user space.
+ * @vma: the vm_area_struct defining the mapping.
+ *
+ * This routine will be called from the vma infrastructure's teardown on 
+ * munmap or process exit.
+ *
+ */
+static void
+usr_pci_unmapconsistent(struct vm_area_struct *vma) {
+	struct consistent_mem *mp = (struct consistent_mem *)vma->vm_private_data;
+	vma->vm_private_data = NULL;	
+
+	ClearPageReserved(virt_to_page(mp->kaddr));
+	pci_free_consistent(mp->devp, mp->len, (void *)mp->kaddr, mp->dmaaddr);
+	kfree(mp);
+}
+
+/**
+ * usr_pci_getconsistent: get a chunk of pci-consistent memory
+ * @fd: filedescriptor returned from usr_pci_open()
+ * @size: number of bytes to map (must be =PAGESIZE at present)
+ * @vaddrp: where to return the virtual address or the new mapping
+ * @dmaaddrp: where to return the bus address of the new mapping.
+ *
+ * The system call calls pci_alloc_consistent() then
+ * maps the resultant page(s) into the caller's address space.
+ *
+ * The mapping can be torn down by munmap(), or at exit() time.
+ */
+long asmlinkage
+sys_usr_pci_get_consistent(int fd, size_t size, void __user **vaddrp, __u64 __user *dmaaddrp)
+{
+	struct maplist *p;
+	struct file *filp = fget(fd);
+	struct pci_dev *devp;
+	int ret = 0;
+	dma_addr_t dma_handle;
+	__u64 udma_addr;
+	void *vaddr;
+	struct page *pp;
+	void __user *virtaddr;
+
+	if (!filp)
+		return -EINVAL;
+
+	/* I suspect this one can't happen */
+	BUG_ON(filp->f_op != &usr_pci_fops);
+
+	p = (struct maplist *)filp->private_data;
+	if (!p) {
+		printk(KERN_ERR "usr_pci_fs file has no PCI device???");
+		ret = -EINVAL;
+		goto out;
+	}
+	devp = p->dev;
+
+	if (size != PAGE_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vaddr = pci_alloc_consistent(devp, size, &dma_handle);
+	if (vaddr == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pp = virt_to_page(vaddr);
+	get_page(pp);
+	SetPageReserved(pp);
+
+	virtaddr = do_map(vaddr, size, dma_handle, devp);
+
+	if (unlikely((unsigned long)virtaddr > (unsigned long)-1000L)) {
+		ret = (long)virtaddr;
+		ClearPageReserved(pp);
+		put_page(pp);
+		pci_free_consistent(devp, size, vaddr, dma_handle);
+       } else {
+		udma_addr = dma_handle;
+		if (copy_to_user(vaddrp, &virtaddr, sizeof virtaddr) ||
+		    copy_to_user(dmaaddrp, &udma_addr, sizeof udma_addr)) {
+			ret = -EFAULT;
+			do_munmap(current->mm, (unsigned long)virtaddr, size);
+		}
+	}
+out:
+	fput(filp);
+	return ret;
+}
+
+/**
+ * sys_usr_pci_mmap(): map some memory for DMA
+ * @fd: filedescriptor returned from usr_pci_open()
+ * @mp: pointer to a &struct mapping_info describing the mapping
+ *
+ * After validating the input, this function calls pci_map_sg()
+ * then converts the resulting scatterlist into something 
+ * more digestible in userland.  It also attaches a record of the
+ * mapping to the open file, so that the mapping can be undone.
+ */
+long asmlinkage
+sys_usr_pci_mmap(int fd,  struct mapping_info __user *mp)
+{
+	struct mapping_info m;
+	struct maplist *p;
+	struct internal_mapping_info *imp;
+	unsigned long flags;
+	int i;
+	int npages;
+	int maxpages;
+	struct file *filp = fget(fd);
+	struct pci_dev *devp;
+	int ret = 0;
+	struct usr_pci_sglist *hw;
+	struct scatterlist *sgp;
+	int write;
+
+	if (!filp) {
+		printk("!filp\n");
+		return -EINVAL;
+	}
+
+	if (filp->f_op != &usr_pci_fops) {
+		printk("Bad fops\n");
+		ret  =  -EINVAL;
+		goto out;
+	}
+
+	if (copy_from_user(&m, mp, sizeof m)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	maxpages = m.size / PAGE_SIZE + 2;
+	p = (struct maplist *)filp->private_data;
+	BUG_ON(!p);
+	devp = p->dev;
+
+	switch (m.direction) {
+	case DMA_TO_DEVICE:
+		write = 0;
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		write = 1;
+		break;
+	default:
+		printk("bad m.direction %d\n", m.direction);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (unlikely((m.nents < maxpages) || (m.size == 0))) {
+		printk("Bad size (%d) or nents (%d) < maxpages (%d)\n",
+		       m.size, m.nents, maxpages);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	imp = get_imap(maxpages);
+	if (unlikely(imp == NULL)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	imp->m = m;
+
+	npages = get_user_pages(current, 
+				current->mm, 
+				(unsigned long)m.virtaddr, 
+				maxpages,
+				write,
+				0,
+				imp->pages,
+				NULL);
+	if (unlikely(npages < 0)) {
+		ret = npages;
+		free_imap(imp);
+		goto out;
+	}
+
+	imp->npages = npages;
+
+	if (unlikely(npages < m.size/PAGE_SIZE)){
+		/*
+		 * Not all the requested area is mapped.
+		 * Return -EFAULT and let the user sort it out.
+		 */
+		free_imap(imp);
+		ret = -EFAULT ;
+		goto out;
+	}
+
+	/*
+	 * Build scatterlist, one entry per page.
+	 * Allow for partial pages at start and end.
+	 */
+	i = 1;
+	imp->sg[0].page = imp->pages[0];
+	imp->sg[0].offset = ((unsigned long)m.virtaddr) & (PAGE_SIZE - 1);
+	imp->sg[0].length = PAGE_SIZE - imp->sg[0].offset;
+	if (imp->sg[0].length >= m.size) {
+		imp->sg[0].length = m.size;
+	} else {
+		unsigned long len = m.size - imp->sg[0].length;
+		for (;len >= PAGE_SIZE && i < npages ; i++) {
+			imp->sg[i].page = imp->pages[i];
+			imp->sg[i].offset = 0;
+			imp->sg[i].length = PAGE_SIZE;
+			len -= PAGE_SIZE;
+		}
+		if (len) {
+			BUG_ON(i >= npages);
+			BUG_ON(len >= PAGE_SIZE);
+			imp->sg[i].page = imp->pages[i];
+			imp->sg[i].offset = 0;
+			imp->sg[i].length = len;
+			i++;
+		}
+	}
+
+	imp->nent = i;
+	imp->m.nents = pci_map_sg(devp, imp->sg, imp->nent, imp->m.direction);
+
+	hw = get_hw(m.nents);
+
+	for (i = 0, sgp = imp->sg; i < m.nents; i++, sgp++) {
+		hw[i].dmaaddr = sg_dma_address(sgp);
+		hw[i].len = sg_dma_len(sgp);
+	}
+
+	imp->m.dmaaddr = hw[0].dmaaddr;
+
+	if (copy_to_user(mp, &imp->m, sizeof imp->m) ||
+	    copy_to_user(m.sglist, hw, sizeof(*hw) * imp->m.nents)) {
+		pci_unmap_sg(devp, imp->sg, imp->nent, imp->m.direction);
+		free_imap(imp);
+		free_hw(m.nents, hw);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	free_hw(m.nents, hw);
+
+	spin_lock_irqsave(&p->lk, flags);
+	imp->next = p->mappings;
+	p->mappings = imp;
+	spin_unlock_irqrestore(&p->lk, flags);
+out:
+	fput(filp);
+	return ret;
+}
+
+/**
+ * sys_usr_pci_unmap(): remove a PCI-consistent mapping.
+ * @fd: filedescriptor returned from usr_pci_open()
+ * @mp: pointer to a &struct mapping_info describing the mapping
+ *
+ * Find the mapping in the list of mappings attached to the open file,
+ * then undo it, and free any resources.
+ */
+long asmlinkage
+sys_usr_pci_munmap(int fd, struct mapping_info __user *mp)
+{
+	struct mapping_info m;
+	struct maplist *p;
+	struct internal_mapping_info *imp;
+	unsigned long flags;
+	struct internal_mapping_info **ipp;
+	struct file *filp = fget(fd);
+	struct pci_dev *devp;
+	int ret = 0;
+
+
+	if (!filp)
+		return -EINVAL;
+	BUG_ON(filp->f_op != &usr_pci_fops);
+
+	if (copy_from_user(&m, mp, sizeof m)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	p = (struct maplist *)filp->private_data;
+	BUG_ON(!p);
+	devp = p->dev;
+
+	/*
+	 * Linear search is adequate for this, as most drivers 
+	 * have very few outstamding mappings
+	 */
+	imp = NULL;
+
+	spin_lock_irqsave(&p->lk, flags);
+	for (ipp = &p->mappings; *ipp; ipp = &(*ipp)->next) {
+		imp = *ipp;
+		if (imp->m.dmaaddr == m.dmaaddr) {
+			*ipp = imp->next;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&p->lk, flags);
+
+	if (imp == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pci_unmap_sg(devp, imp->sg, imp->nent, imp->m.direction);
+	free_imap(imp);
+
+out:
+	fput(filp);
+	return ret;
+}
+
+#else /* CONFIG_USRDEV */
+
+long asmlinkage
+sys_usr_pci_open(int bus, int slot, int function)
+{
+	return -ENOSYS;
+}
+
+long asmlinkage
+sys_usr_pci_get_consistent(int fd, struct mapping_info __user *mp) {
+	return -ENOSYS;
+}
+
+long asmlinkage
+sys_usr_pci_mmap(int fd,  struct mapping_info __user *mp) {
+	return -ENOSYS;
+}
+
+long asmlinkage
+sys_usr_pci_unmap(int fd, struct mapping_info *mp)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_USRDEV */
Index: linux-2.6.11-usrdrivers/include/linux/usrdrv.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-usrdrivers/include/linux/usrdrv.h	2005-03-11 12:25:41.272550741 +1100
@@ -0,0 +1,63 @@
+/************************************************************************
+ * usrdrv.h -- definitions for user-mode device driver
+ */
+
+#ifndef _USRDRV_H
+#define _USRDRV_H
+#ifdef __KERNEL__
+#include <linux/dma-mapping.h>
+
+struct file;
+struct pci_dev;
+extern void usr_pci_put_dev(struct file *fp);
+extern int usr_pci_get_dev(int, struct pci_dev **, struct file **);
+
+#else
+/*
+ * can't include linux/dma-mapping.h in user mode
+ */
+enum dma_data_direction {
+	DMA_BIDIRECTIONAL = 0,
+	DMA_TO_DEVICE = 1,
+	DMA_FROM_DEVICE = 2,
+	DMA_NONE = 3,
+};
+
+#ifndef __user
+# define __user /* nothing */
+#endif
+
+#endif
+
+/*
+ * a scatterlist as exported to userland.
+ */ 
+struct usr_pci_sglist {
+	unsigned long dmaaddr;
+	unsigned long len;
+};
+
+
+/*
+ * virtaddr: user mode address to be mapped/unmapped
+ * size: bytes of address to map
+ * nents: As passed into usr_pci_mmap will contain total 
+ *		number of entries;
+ *	  as passed out, will contain number of valid entries 
+ *		(IOMMU may merge entries)
+ * sglist: allocated by caller of usr_pci_map,
+ *         should be at least (size/PAGE_SIZE) + 2
+ * direction: try not to use DMA_BIDERECTIONAL
+ */
+struct mapping_info {
+	void __user *virtaddr;
+	unsigned long dmaaddr;
+	unsigned int size;
+	unsigned int nents;
+	struct usr_pci_sglist __user  *sglist;
+	enum dma_data_direction direction;
+};
+		
+
+
+#endif /* _USRDRV_H */
Index: linux-2.6.11-usrdrivers/drivers/pci/Kconfig
===================================================================
--- linux-2.6.11-usrdrivers.orig/drivers/pci/Kconfig	2005-03-11 12:25:29.171093086 +1100
+++ linux-2.6.11-usrdrivers/drivers/pci/Kconfig	2005-03-11 14:26:18.660867648 +1100
@@ -47,3 +47,9 @@
 
 	  When in doubt, say Y.
 
+
+config	USRDEV
+	bool "Framework for user-mode PCI drivers"
+	depends on PCI
+	---help---
+	  UNSW NICTA/Gelato user-mode device drivers.
