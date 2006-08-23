Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWHWVbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWHWVbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWHWVbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:31:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:5855 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965214AbWHWVbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:31:33 -0400
Date: Wed, 23 Aug 2006 14:31:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.11
Message-ID: <20060823213130.GB12308@kroah.com>
References: <20060823213108.GA12308@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823213108.GA12308@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index ed01727..a261e36 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .10
+EXTRAVERSION = .11
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index c7b943f..3edefc8 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -164,10 +164,25 @@ sys_pipe (void)
 	return retval;
 }
 
+int ia64_map_check_rgn(unsigned long addr, unsigned long len,
+		unsigned long flags)
+{
+	unsigned long roff;
+
+	/*
+	 * Don't permit mappings into unmapped space, the virtual page table
+	 * of a region, or across a region boundary.  Note: RGN_MAP_LIMIT is
+	 * equal to 2^n-PAGE_SIZE (for some integer n <= 61) and len > 0.
+	 */
+	roff = REGION_OFFSET(addr);
+	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len)))
+		return -EINVAL;
+	return 0;
+}
+
 static inline unsigned long
 do_mmap2 (unsigned long addr, unsigned long len, int prot, int flags, int fd, unsigned long pgoff)
 {
-	unsigned long roff;
 	struct file *file = NULL;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
@@ -189,17 +204,6 @@ do_mmap2 (unsigned long addr, unsigned l
 		goto out;
 	}
 
-	/*
-	 * Don't permit mappings into unmapped space, the virtual page table of a region,
-	 * or across a region boundary.  Note: RGN_MAP_LIMIT is equal to 2^n-PAGE_SIZE
-	 * (for some integer n <= 61) and len > 0.
-	 */
-	roff = REGION_OFFSET(addr);
-	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len))) {
-		addr = -EINVAL;
-		goto out;
-	}
-
 	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);
diff --git a/arch/sparc/kernel/sys_sparc.c b/arch/sparc/kernel/sys_sparc.c
index 0cdfc9d..fc8cdcc 100644
--- a/arch/sparc/kernel/sys_sparc.c
+++ b/arch/sparc/kernel/sys_sparc.c
@@ -219,6 +219,21 @@ out:
 	return err;
 }
 
+int sparc_mmap_check(unsigned long addr, unsigned long len, unsigned long flags)
+{
+	if (ARCH_SUN4C_SUN4 &&
+	    (len > 0x20000000 ||
+	     ((flags & MAP_FIXED) &&
+	      addr < 0xe0000000 && addr + len > 0x20000000)))
+		return -EINVAL;
+
+	/* See asm-sparc/uaccess.h */
+	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* Linux version of mmap */
 static unsigned long do_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
@@ -233,25 +248,13 @@ static unsigned long do_mmap2(unsigned l
 			goto out;
 	}
 
-	retval = -EINVAL;
 	len = PAGE_ALIGN(len);
-	if (ARCH_SUN4C_SUN4 &&
-	    (len > 0x20000000 ||
-	     ((flags & MAP_FIXED) &&
-	      addr < 0xe0000000 && addr + len > 0x20000000)))
-		goto out_putf;
-
-	/* See asm-sparc/uaccess.h */
-	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
-		goto out_putf;
-
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);
 
-out_putf:
 	if (file)
 		fput(file);
 out:
diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
index 7a86913..a9edcab 100644
--- a/arch/sparc64/kernel/sys_sparc.c
+++ b/arch/sparc64/kernel/sys_sparc.c
@@ -549,6 +549,26 @@ asmlinkage long sparc64_personality(unsi
 	return ret;
 }
 
+int sparc64_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags)
+{
+	if (test_thread_flag(TIF_32BIT)) {
+		if (len >= STACK_TOP32)
+			return -EINVAL;
+
+		if ((flags & MAP_FIXED) && addr > STACK_TOP32 - len)
+			return -EINVAL;
+	} else {
+		if (len >= VA_EXCLUDE_START)
+			return -EINVAL;
+
+		if ((flags & MAP_FIXED) && invalid_64bit_range(addr, len))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Linux version of mmap */
 asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
@@ -564,27 +584,11 @@ asmlinkage unsigned long sys_mmap(unsign
 	}
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	len = PAGE_ALIGN(len);
-	retval = -EINVAL;
-
-	if (test_thread_flag(TIF_32BIT)) {
-		if (len >= STACK_TOP32)
-			goto out_putf;
-
-		if ((flags & MAP_FIXED) && addr > STACK_TOP32 - len)
-			goto out_putf;
-	} else {
-		if (len >= VA_EXCLUDE_START)
-			goto out_putf;
-
-		if ((flags & MAP_FIXED) && invalid_64bit_range(addr, len))
-			goto out_putf;
-	}
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, off);
 	up_write(&current->mm->mmap_sem);
 
-out_putf:
 	if (file)
 		fput(file);
 out:
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 8ea7062..2678034 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
 	iowrite32(interrupt,
 		  chip->vendor.iobase +
 		  TPM_INT_STATUS(chip->vendor.locality));
+	ioread32(chip->vendor.iobase + TPM_INT_STATUS(chip->vendor.locality));
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 8f1292c..d1788cd 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3548,6 +3548,8 @@ #endif /* CONFIG_PPC_PMAC */
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
+	pci_save_state(pdev);
+
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3559,8 +3561,6 @@ #ifdef CONFIG_PPC_PMAC
 	}
 #endif
 
-	pci_save_state(pdev);
-
 	return 0;
 }
 
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 1816f30..5af5265 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -711,6 +711,8 @@ static int multipath_ctr(struct dm_targe
 		return -EINVAL;
 	}
 
+	m->ti = ti;
+
 	r = parse_features(&as, m, ti);
 	if (r)
 		goto bad;
@@ -752,7 +754,6 @@ static int multipath_ctr(struct dm_targe
 	}
 
 	ti->private = m;
-	m->ti = ti;
 
 	return 0;
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4070eff..5a54494 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1486,7 +1486,6 @@ static void raid1d(mddev_t *mddev)
 							d = conf->raid_disks;
 						d--;
 						rdev = conf->mirrors[d].rdev;
-						atomic_add(s, &rdev->corrected_errors);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
 							if (sync_page_io(rdev->bdev,
@@ -1509,6 +1508,9 @@ static void raid1d(mddev_t *mddev)
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							else
+								atomic_add(s, &rdev->corrected_errors);
+
 						}
 					}
 				} else {
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index a3cd0b3..72ca553 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -233,6 +233,8 @@ static void sky2_set_power_state(struct 
 			if (hw->ports > 1)
 				reg1 |= PCI_Y2_PHY2_COMA;
 		}
+		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+		udelay(100);
 
 		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
 			sky2_write16(hw, B0_CTST, Y2_HW_WOL_ON);
@@ -243,8 +245,6 @@ static void sky2_set_power_state(struct 
 			sky2_pci_write32(hw, PCI_DEV_REG5, 0);
 		}
 
-		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
-
 		break;
 
 	case PCI_D3hot:
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d378478..6e3786f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -427,6 +427,7 @@ static void __devinit quirk_ich6_lpc_acp
 	pci_read_config_dword(dev, 0x48, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH6 GPIO");
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
 
 /*
@@ -1043,7 +1044,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc );
 
 static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
 {
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7d22dc0..753b364 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -803,6 +803,7 @@ config SERIAL_MPC52xx
 	tristate "Freescale MPC52xx family PSC serial support"
 	depends on PPC_MPC52xx
 	select SERIAL_CORE
+	select FW_LOADER
 	help
 	  This drivers support the MPC52xx PSC serial ports. If you would
 	  like to use them, you must answer Y or M to this option. Not that
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 68ebd10..aa50dc6 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -512,7 +512,11 @@ befs_utf2nls(struct super_block *sb, con
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = in_len; /* The utf8->nls conversion can't make more chars */
+	/* The utf8->nls conversion won't make the final nls string bigger
+	 * than the utf one, but if the string is pure ascii they'll have the
+	 * same width and an extra char is needed to save the additional \0
+	 */
+	int maxlen = in_len + 1;
 
 	befs_debug(sb, "---> utf2nls()");
 
@@ -588,7 +592,10 @@ befs_nls2utf(struct super_block *sb, con
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = 3 * in_len;
+	/* There're nls characters that will translate to 3-chars-wide UTF-8
+	 * characters, a additional byte is needed to save the final \0
+	 * in special cases */
+	int maxlen = (3 * in_len) + 1;
 
 	befs_debug(sb, "---> nls2utf()\n");
 
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index f8a5266..86534ad 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -620,8 +620,48 @@ #ifdef CONFIG_QUOTA
 #endif
 };
 
+static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext3_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext3_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {
diff --git a/include/asm-generic/mman.h b/include/asm-generic/mman.h
index 3b41d2b..010ced7 100644
--- a/include/asm-generic/mman.h
+++ b/include/asm-generic/mman.h
@@ -39,4 +39,10 @@ #define MADV_DOFORK	11		/* do inherit ac
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
+#ifdef __KERNEL__
+#ifndef arch_mmap_check
+#define arch_mmap_check(addr, len, flags)	(0)
+#endif
+#endif
+
 #endif
diff --git a/include/asm-ia64/mman.h b/include/asm-ia64/mman.h
index 6ba179f..df1b20e 100644
--- a/include/asm-ia64/mman.h
+++ b/include/asm-ia64/mman.h
@@ -8,6 +8,12 @@ #define _ASM_IA64_MMAN_H
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
+#ifdef __KERNEL__
+#define arch_mmap_check	ia64_map_check_rgn
+int ia64_map_check_rgn(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
diff --git a/include/asm-sparc/mman.h b/include/asm-sparc/mman.h
index 88d1886..95ecab5 100644
--- a/include/asm-sparc/mman.h
+++ b/include/asm-sparc/mman.h
@@ -2,6 +2,12 @@
 #ifndef __SPARC_MMAN_H__
 #define __SPARC_MMAN_H__
 
+#ifdef __KERNEL__
+#define arch_mmap_check	sparc_mmap_check
+int sparc_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 /* SunOS'ified... */
diff --git a/include/asm-sparc64/mman.h b/include/asm-sparc64/mman.h
index 6fd878e..b300276 100644
--- a/include/asm-sparc64/mman.h
+++ b/include/asm-sparc64/mman.h
@@ -2,6 +2,12 @@
 #ifndef __SPARC64_MMAN_H__
 #define __SPARC64_MMAN_H__
 
+#ifdef __KERNEL__
+#define arch_mmap_check	sparc64_mmap_check
+int sparc64_mmap_check(unsigned long addr, unsigned long len,
+		unsigned long flags);
+#endif
+
 #include <asm-generic/mman.h>
 
 /* SunOS'ified... */
diff --git a/kernel/timer.c b/kernel/timer.c
index 9e49dee..7bdad89 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -975,46 +975,19 @@ asmlinkage long sys_getpid(void)
 }
 
 /*
- * Accessing ->group_leader->real_parent is not SMP-safe, it could
- * change from under us. However, rather than getting any lock
- * we can use an optimistic algorithm: get the parent
- * pid, and go back and check that the parent is still
- * the same. If it has changed (which is extremely unlikely
- * indeed), we just try again..
- *
- * NOTE! This depends on the fact that even if we _do_
- * get an old value of "parent", we can happily dereference
- * the pointer (it was and remains a dereferencable kernel pointer
- * no matter what): we just can't necessarily trust the result
- * until we know that the parent pointer is valid.
- *
- * NOTE2: ->group_leader never changes from under us.
+ * Accessing ->real_parent is not SMP-safe, it could
+ * change from under us. However, we can use a stale
+ * value of ->real_parent under rcu_read_lock(), see
+ * release_task()->call_rcu(delayed_put_task_struct).
  */
 asmlinkage long sys_getppid(void)
 {
 	int pid;
-	struct task_struct *me = current;
-	struct task_struct *parent;
 
-	parent = me->group_leader->real_parent;
-	for (;;) {
-		pid = parent->tgid;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-{
-		struct task_struct *old = parent;
+	rcu_read_lock();
+	pid = rcu_dereference(current->real_parent)->tgid;
+	rcu_read_unlock();
 
-		/*
-		 * Make sure we read the pid before re-reading the
-		 * parent pointer:
-		 */
-		smp_rmb();
-		parent = me->group_leader->real_parent;
-		if (old != parent)
-			continue;
-}
-#endif
-		break;
-	}
 	return pid;
 }
 
diff --git a/lib/spinlock_debug.c b/lib/spinlock_debug.c
index d8b6bb4..5cbcb80 100644
--- a/lib/spinlock_debug.c
+++ b/lib/spinlock_debug.c
@@ -137,6 +137,7 @@ #endif
 
 #define RWLOCK_BUG_ON(cond, lock, msg) if (unlikely(cond)) rwlock_bug(lock, msg)
 
+#if 0		/* __write_lock_debug() can lock up - maybe this can too? */
 static void __read_lock_debug(rwlock_t *lock)
 {
 	int print_once = 1;
@@ -159,12 +160,12 @@ static void __read_lock_debug(rwlock_t *
 		}
 	}
 }
+#endif
 
 void _raw_read_lock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	if (unlikely(!__raw_read_trylock(&lock->raw_lock)))
-		__read_lock_debug(lock);
+	__raw_read_lock(&lock->raw_lock);
 }
 
 int _raw_read_trylock(rwlock_t *lock)
@@ -210,6 +211,7 @@ static inline void debug_write_unlock(rw
 	lock->owner_cpu = -1;
 }
 
+#if 0		/* This can cause lockups */
 static void __write_lock_debug(rwlock_t *lock)
 {
 	int print_once = 1;
@@ -232,12 +234,12 @@ static void __write_lock_debug(rwlock_t 
 		}
 	}
 }
+#endif
 
 void _raw_write_lock(rwlock_t *lock)
 {
 	debug_write_lock_before(lock);
-	if (unlikely(!__raw_write_trylock(&lock->raw_lock)))
-		__write_lock_debug(lock);
+	__raw_write_lock(&lock->raw_lock);
 	debug_write_lock_after(lock);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e6ee123..d6e9641 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -913,6 +913,10 @@ unsigned long do_mmap_pgoff(struct file 
 	if (!len)
 		return -EINVAL;
 
+	error = arch_mmap_check(addr, len, flags);
+	if (error)
+		return error;
+
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
 	if (!len || len > TASK_SIZE)
@@ -1852,6 +1856,7 @@ unsigned long do_brk(unsigned long addr,
 	unsigned long flags;
 	struct rb_node ** rb_link, * rb_parent;
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
+	int error;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1860,6 +1865,12 @@ unsigned long do_brk(unsigned long addr,
 	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
 		return -EINVAL;
 
+	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+
+	error = arch_mmap_check(addr, len, flags);
+	if (error)
+		return error;
+
 	/*
 	 * mlock MCL_FUTURE?
 	 */
@@ -1900,8 +1911,6 @@ unsigned long do_brk(unsigned long addr,
 	if (security_vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-
 	/* Can we just expand an old private anonymous mapping? */
 	if (vma_merge(mm, prev, addr, addr + len, flags,
 					NULL, NULL, pgoff, NULL))
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e5fd538..5a7760f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -440,11 +440,12 @@ int swap_type_of(dev_t device)
 
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
+
 		if (!device) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info->swap_file->f_dentry->d_inode;
+		inode = swap_info[i].swap_file->f_dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
 			spin_unlock(&swap_lock);
diff --git a/net/bridge/netfilter/ebt_ulog.c b/net/bridge/netfilter/ebt_ulog.c
index ee5a517..ae70123 100644
--- a/net/bridge/netfilter/ebt_ulog.c
+++ b/net/bridge/netfilter/ebt_ulog.c
@@ -75,6 +75,9 @@ static void ulog_send(unsigned int nlgro
 	if (timer_pending(&ub->timer))
 		del_timer(&ub->timer);
 
+	if (!ub->skb)
+		return;
+
 	/* last nlmsg needs NLMSG_DONE */
 	if (ub->qlen > 1)
 		ub->lastnlh->nlmsg_type = NLMSG_DONE;
diff --git a/net/core/dst.c b/net/core/dst.c
index 470c05b..1a5e49d 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -95,12 +95,11 @@ static void dst_run_gc(unsigned long dum
 		dst_gc_timer_inc = DST_GC_INC;
 		dst_gc_timer_expires = DST_GC_MIN;
 	}
-	dst_gc_timer.expires = jiffies + dst_gc_timer_expires;
 #if RT_CACHE_DEBUG >= 2
 	printk("dst_total: %d/%d %ld\n",
 	       atomic_read(&dst_total), delayed,  dst_gc_timer_expires);
 #endif
-	add_timer(&dst_gc_timer);
+	mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
 
 out:
 	spin_unlock(&dst_lock);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3fcfa9c..e02f528 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -395,6 +395,9 @@ static int do_setlink(struct sk_buff *sk
 	}
 
 	if (ida[IFLA_ADDRESS - 1]) {
+		struct sockaddr *sa;
+		int len;
+
 		if (!dev->set_mac_address) {
 			err = -EOPNOTSUPP;
 			goto out;
@@ -406,7 +409,17 @@ static int do_setlink(struct sk_buff *sk
 		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
 			goto out;
 
-		err = dev->set_mac_address(dev, RTA_DATA(ida[IFLA_ADDRESS - 1]));
+		len = sizeof(sa_family_t) + dev->addr_len;
+		sa = kmalloc(len, GFP_KERNEL);
+		if (!sa) {
+			err = -ENOMEM;
+			goto out;
+		}
+		sa->sa_family = dev->type;
+		memcpy(sa->sa_data, RTA_DATA(ida[IFLA_ADDRESS - 1]),
+		       dev->addr_len);
+		err = dev->set_mac_address(dev, sa);
+		kfree(sa);
 		if (err)
 			goto out;
 		send_addr_notify = 1;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0f4145b..1de08c1 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -160,7 +160,7 @@ void free_fib_info(struct fib_info *fi)
 
 void fib_release_info(struct fib_info *fi)
 {
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	if (fi && --fi->fib_treeref == 0) {
 		hlist_del(&fi->fib_hash);
 		if (fi->fib_prefsrc)
@@ -173,7 +173,7 @@ void fib_release_info(struct fib_info *f
 		fi->fib_dead = 1;
 		fib_info_put(fi);
 	}
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 }
 
 static __inline__ int nh_comp(const struct fib_info *fi, const struct fib_info *ofi)
@@ -599,7 +599,7 @@ static void fib_hash_move(struct hlist_h
 	unsigned int old_size = fib_hash_size;
 	unsigned int i, bytes;
 
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	old_info_hash = fib_info_hash;
 	old_laddrhash = fib_info_laddrhash;
 	fib_hash_size = new_size;
@@ -640,7 +640,7 @@ static void fib_hash_move(struct hlist_h
 	}
 	fib_info_laddrhash = new_laddrhash;
 
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 
 	bytes = old_size * sizeof(struct hlist_head *);
 	fib_hash_free(old_info_hash, bytes);
@@ -822,7 +822,7 @@ link_it:
 
 	fi->fib_treeref++;
 	atomic_inc(&fi->fib_clntref);
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	hlist_add_head(&fi->fib_hash,
 		       &fib_info_hash[fib_info_hashfn(fi)]);
 	if (fi->fib_prefsrc) {
@@ -841,7 +841,7 @@ link_it:
 		head = &fib_info_devhash[hash];
 		hlist_add_head(&nh->nh_hash, head);
 	} endfor_nexthops(fi)
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 	return fi;
 
 err_inval:
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index d0d1919..92adfeb 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -237,7 +237,7 @@ unsigned int arpt_do_table(struct sk_buf
 	struct arpt_entry *e, *back;
 	const char *indev, *outdev;
 	void *table_base;
-	struct xt_table_info *private = table->private;
+	struct xt_table_info *private;
 
 	/* ARP header, plus 2 device addresses, plus 2 IP addresses.  */
 	if (!pskb_may_pull((*pskb), (sizeof(struct arphdr) +
@@ -249,6 +249,7 @@ unsigned int arpt_do_table(struct sk_buf
 	outdev = out ? out->name : nulldevname;
 
 	read_lock_bh(&table->lock);
+	private = table->private;
 	table_base = (void *)private->entries[smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 	back = get_entry(table_base, private->underflow[hook]);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index cee3397..71871c4 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -231,7 +231,7 @@ ipt_do_table(struct sk_buff **pskb,
 	const char *indev, *outdev;
 	void *table_base;
 	struct ipt_entry *e, *back;
-	struct xt_table_info *private = table->private;
+	struct xt_table_info *private;
 
 	/* Initialization */
 	ip = (*pskb)->nh.iph;
@@ -248,6 +248,7 @@ ipt_do_table(struct sk_buff **pskb,
 
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
+	private = table->private;
 	table_base = (void *)private->entries[smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 
diff --git a/net/ipv4/netfilter/ipt_ULOG.c b/net/ipv4/netfilter/ipt_ULOG.c
index c84cc03..090f138 100644
--- a/net/ipv4/netfilter/ipt_ULOG.c
+++ b/net/ipv4/netfilter/ipt_ULOG.c
@@ -116,6 +116,11 @@ static void ulog_send(unsigned int nlgro
 		del_timer(&ub->timer);
 	}
 
+	if (!ub->skb) {
+		DEBUGP("ipt_ULOG: ulog_send: nothing to send\n");
+		return;
+	}
+
 	/* last nlmsg needs NLMSG_DONE */
 	if (ub->qlen > 1)
 		ub->lastnlh->nlmsg_type = NLMSG_DONE;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cc9423d..5fe2fcf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3144,7 +3144,7 @@ #endif
 					rhash_entries,
 					(num_physpages >= 128 * 1024) ?
 					15 : 17,
-					HASH_HIGHMEM,
+					0,
 					&rt_hash_log,
 					&rt_hash_mask,
 					0);
diff --git a/net/ipx/af_ipx.c b/net/ipx/af_ipx.c
index 811d998..e6a50e8 100644
--- a/net/ipx/af_ipx.c
+++ b/net/ipx/af_ipx.c
@@ -1647,7 +1647,8 @@ static int ipx_rcv(struct sk_buff *skb, 
 	ipx_pktsize	= ntohs(ipx->ipx_pktsize);
 	
 	/* Too small or invalid header? */
-	if (ipx_pktsize < sizeof(struct ipxhdr) || ipx_pktsize > skb->len)
+	if (ipx_pktsize < sizeof(struct ipxhdr)
+	   || !pskb_may_pull(skb, ipx_pktsize))
 		goto drop;
                         
 	if (ipx->ipx_checksum != IPX_NO_CHECKSUM &&
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 61cdda4..b59d3b2 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -366,6 +366,9 @@ __nfulnl_send(struct nfulnl_instance *in
 	if (timer_pending(&inst->timer))
 		del_timer(&inst->timer);
 
+	if (!inst->skb)
+		return 0;
+
 	if (inst->qlen > 1)
 		inst->lastnlh->nlmsg_type = NLMSG_DONE;
 
