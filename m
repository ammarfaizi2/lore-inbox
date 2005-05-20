Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVETN6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVETN6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVETN6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:58:53 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:60106 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261454AbVETNnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:43:50 -0400
Subject: [PATCH 3 of 4] ima: Linux Security Module implementation
From: Reiner Sailer <sailer@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@mail.wirex.com, kylene@us.ibm.com, emilyr@us.ibm.com,
       toml@us.ibm.com
Content-Type: text/plain
Date: Fri, 20 May 2005 09:48:26 -0400
Message-Id: <1116596906.8426.1.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd of 4 patches that constitute the IBM Integrity
Measurement Architecture (IMA). This patch includes the main IMA
functionality as a Linux Security Module.

This patch applies to the clean 2.6.12-rc4 test kernel.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---
diff -uprN linux-2.6.12-rc4/security/ima/ima.h linux-2.6.12-rc4-ima/security/ima/ima.h
--- linux-2.6.12-rc4/security/ima/ima.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima.h	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,227 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.	  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima.h
+ *             defs
+ */
+#ifndef __LINUX_IMA_H
+#define __LINUX_IMA_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+
+#define ima_printk(level, format, arg...)	\
+	printk(level "ima (%s): " format ,__func__, ## arg)
+       
+#define ima_error(format, arg...)	\
+	ima_printk(KERN_ERR, format, ## arg)
+
+#define ima_info(format, arg...)	\
+	ima_printk(KERN_INFO, format, ## arg)
+
+/* set during registering as lsm */
+extern unsigned char ima_terminating;
+
+#define IMA_MEASURE_MODULE_NAME	"IMA"
+#define IMA_MEASURE_PROC_NAME	"ima"
+
+/* file systems we expect to change without
+ * our inode_permission hook being called (nfs, remote fs) */
+#define NFS_SUPER_MAGIC		0x6969
+
+/* file systems we won't measure
+   (invalidate TPM PCR when executing one of these) */
+#define DEVFS_SUPER_MAGIC       0x1373
+#define PROC_SUPER_MAGIC        0x9fa0
+#define SYSFS_MAGIC		0x62656572
+
+/* 
+ * request structure fd: file descriptor
+ * label: sec label defined in user space or in kernel
+ * flags: store the hook that initiated measurement and more
+ */
+#define FLAG_HOOK_MASK		0x0f
+#define MMAP_MEASURE_FLAG 	0x01
+#define MODULE_MEASURE_FLAG 	0x02
+#define USER_MEASURE_FLAG 	0x04
+struct measure_request {
+	int fd;
+	unsigned short label;
+	unsigned long flags;
+};
+
+#define MEASURE_HTABLE_SIZE	512
+/* key = lowest two bytes of inode_number */
+#define HASH_KEY(inode_number) ((inode_number) % MEASURE_HTABLE_SIZE)
+#define SHA_KEY(sha_value) (((sha_value)[18] << 8 | (sha_value)[19]) % MEASURE_HTABLE_SIZE)
+typedef enum { CLEAN, DIRTY, CHANGED } ima_entry_flags;
+
+/* security structure appended to inodes */
+#define IMA_MAGIC 0x9999
+struct ima_inode {
+	unsigned short magic;
+	atomic_t measure_count;	/* # processes currently using this file in measure-mode */
+	ima_entry_flags dirty;
+	char *file_name;	/* points to measure entry->fileName */
+};
+
+/* security structure appended to measured files*/
+struct ima_file {
+	unsigned short magic;	/* identify our struct format */
+	char is_measuring;	/* identify fds that are "measuring" */
+};
+
+/* get/store security state information;
+ * if stacking were to be implemented, this would be the place */
+#define ima_get_inode_security(inode) \
+	((struct ima_inode *) ((inode)->i_security))
+
+#define ima_store_inode_security(inode,sec_struct) \
+	((inode)->i_security = (sec_struct))
+
+#define ima_get_file_security(file) \
+	((struct ima_file *) ((file)->f_security))
+
+#define ima_store_file_security(file, sec_struct) \
+	((file)->f_security = (sec_struct))
+
+#define ENTRY_MAXFILENAME 50
+struct measure_entry {
+	struct measure_request mr; /* keep info from measure request if applies */
+	unsigned long inodeNr;
+	dev_t devId;
+	ima_entry_flags dirty;
+	u8 digest[20];		/* sha1 measurement hash */
+	char fileName[51];	/* max first 50 characters of name + \0 */
+	unsigned long fsMagic;	/* file system magic (distinuish local/remote files) */
+	struct super_block *superBlock;	/* super block link (for umount-dirty flagging) */
+};
+
+struct sha_entry {
+	struct sha_entry *next;
+	u8 *digest;
+	struct measure_entry *m_entry;
+};
+
+struct queue_entry {
+	struct queue_entry *next;
+	struct queue_entry *later;
+	struct measure_entry *entry;
+};
+
+extern struct queue_entry *first_measurement;	/* for printing */
+extern struct queue_entry *latest_measurement;	/* for adding */
+
+/* hash table to keep fast access to past measurements 
+ * uses one global lock for now (read/write) */
+extern struct semaphore h_table_mutex;
+
+struct h_table {
+	atomic_t len;
+	atomic_t sysfs;
+	atomic_t cleanInodeHits; /* times we find an inode clean when measuring */
+	atomic_t cleanTableHits; /* times we find a clean htable hit */
+	atomic_t dirtyTableHits; /* times we find a dirty htable hit */
+	atomic_t changedFiles;	 /* times we realize a dirty marked entry really changed */
+	unsigned int max_htable_size;
+	u8 terminating;
+	struct queue_entry *queue[MEASURE_HTABLE_SIZE];
+	atomic_t queueLen[MEASURE_HTABLE_SIZE];
+	spinlock_t lock;
+};
+
+struct sha_table {
+	atomic_t len;
+	unsigned int max_htable_size;
+	u8 terminating;
+	struct sha_entry *queue[MEASURE_HTABLE_SIZE];
+	atomic_t queueLen[MEASURE_HTABLE_SIZE];
+	spinlock_t lock;
+};
+
+/* configuration options*/
+extern int ima_test_mode;
+extern int skip_boot_aggregate;
+extern int ram_bypass_protection;
+extern int hd_sd_bypass_protection;
+extern int kmem_bypass_protection;
+extern int mem_bypass_protection;
+
+static inline void read_configs(void)
+{
+#ifdef CONFIG_IMA_TEST_MODE
+	ima_test_mode = 1;
+#else
+	ima_test_mode = 0;
+#endif
+
+#ifdef CONFIG_IMA_SKIP_BOOT_AGGREGATE
+	skip_boot_aggregate = 1;
+#else
+	skip_boot_aggregate = 0;
+#endif
+
+#ifdef CONFIG_IMA_RAM_BYPASS_PROTECTION
+	ram_bypass_protection = 1;
+#else
+	ram_bypass_protection = 0;
+#endif
+
+#ifdef CONFIG_IMA_HD_SD_BYPASS_PROTECTION
+	hd_sd_bypass_protection = 1;
+#else
+	hd_sd_bypass_protection = 0;
+#endif
+
+#ifdef CONFIG_IMA_KMEM_BYPASS_PROTECTION
+	kmem_bypass_protection = 1;
+#else
+	kmem_bypass_protection = 0;
+#endif
+
+#ifdef CONFIG_IMA_MEM_BYPASS_PROTECTION
+	mem_bypass_protection = 1;
+#else
+	mem_bypass_protection = 0;
+#endif
+}
+
+#ifdef CONFIG_TCG_TPM
+struct tpm_chip;
+
+extern ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf, size_t bufsiz);
+
+extern struct tpm_chip *tpm_chip_lookup(int chip_num);
+#else
+struct tpm_chip {
+	char dummy;
+};
+
+static inline ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf, size_t bufsiz)
+{
+	return 0;
+}
+
+static inline struct tpm_chip *tpm_chip_lookup(int chip_num)
+{
+	return NULL;
+}
+#endif
+
+/* general prototypes */
+void invalidate_pcr(char *);
+
+#endif
diff -uprN linux-2.6.12-rc4/security/ima/ima_init.c linux-2.6.12-rc4-ima/security/ima/ima_init.c
--- linux-2.6.12-rc4/security/ima/ima_init.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_init.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,161 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer      <sailer@watson.ibm.com>
+ *
+ * Contributions:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.	  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_init.c
+ *             init functions to start up IBM IMA as LSM
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/crypto.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include "ima.h"
+
+/* These identify the driver base version and may not be removed. */
+static const char version[] = "v2.0 05/18/2005";
+static const char illegal_pcr[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+
+/* configuration parameters */
+int ima_test_mode;
+int skip_boot_aggregate;
+int ram_bypass_protection;
+int hd_sd_bypass_protection;
+int kmem_bypass_protection;
+int mem_bypass_protection;
+
+void create_htable(void);
+void destroy_htable(void);
+void create_sha_htable(void);
+void ima_proc_init(void);
+void ima_sysfs_init(void);
+void ima_sysfs_remove(void);
+void ima_add_boot_aggregate(void);
+void ima_lsm_init(void);
+void tpm_extend(int index, const u8 * digest);
+
+int ima_enabled = 0;
+struct tpm_chip *ima_used_chip;
+
+static int __init ima_enabled_setup(char *str)
+{
+	ima_enabled = simple_strtol(str, NULL, 0);
+	return 1;
+}
+
+__setup("ima=", ima_enabled_setup);
+
+
+/* general invalidation function called by the measurement code */
+void invalidate_pcr(char *cause)
+{
+	/* extend pcr with illegal digest (no digest yields 0) */
+	/* extending twice is obviously flagging the exception condition... */
+	ima_error("INVALIDATING PCR AGGREGATE. Cause=%s.\n", cause);
+	tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, illegal_pcr);
+	tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, illegal_pcr);
+	/* now indicate that we invalidated pcr in another pcr (not mandatory) */
+	tpm_extend(CONFIG_IMA_MEASURE_INVALIDATE_INDICATION_IDX, illegal_pcr);
+}
+
+static int __init measure_init(void)
+{
+	struct crypto_tfm *tfm;
+	struct security_operations null_ops;
+
+	printk(KERN_INFO "IBM Integrity Measurement Architecture (IBM IMA %s).\n", 
+	       version);
+	read_configs();
+
+	/* check pre-conditions and dependencies */
+	if (!ima_test_mode) {
+		ima_enabled = 1;	/* unconditionally */
+	} else {
+		if (!ima_enabled) {
+			printk(KERN_INFO "    IMA (not enabled in kernel command line) aborting!\n");
+			return 0;
+		}
+		printk(KERN_INFO "    IMA (test mode)\n");
+	}
+	ima_used_chip = tpm_chip_lookup(0);
+	if (ima_used_chip == NULL) {
+		if (ima_test_mode) {
+			printk(KERN_INFO "    IMA (TPM/BYPASS - no TPM chip found)\n");
+		} else {
+			/* no way to invalidate pcr and inform remote party */
+			panic("IMA: TPM/no support and IMA not in test mode!\n");
+		}
+	}
+	if ((tfm = crypto_alloc_tfm("sha1", 0)) == NULL) {
+		if (ima_test_mode) {
+			printk(KERN_INFO "    IMA (SHA-1/no support) aborting!\n");
+			ima_enabled = 0;
+			return -EFAULT;
+		} else {
+			invalidate_pcr("No SHA1 support in real mode!");
+		}
+	} else {
+		crypto_free_tfm(tfm);
+	}
+	/* check for LSM availability */
+	memset(&null_ops, 0, sizeof(struct security_operations));
+	if (!register_security(&null_ops)) {
+		unregister_security(&null_ops);
+	} else {
+		if (ima_test_mode) {
+			ima_enabled = 0;
+			printk(KERN_INFO "    IMA (LSM/not free) aborting!\n");
+			return -EFAULT;
+		} else {
+			invalidate_pcr("LSM/not free in real mode!\n");
+		}
+	}
+	create_htable(); /* for measurements */
+	create_sha_htable();
+	/* boot aggregate must be very first entry */
+	if (!skip_boot_aggregate)
+		ima_add_boot_aggregate();
+	ima_lsm_init();
+	ima_sysfs_init();
+	ima_proc_init();
+	return 0;
+}
+
+static void __exit measure_exit(void)
+{
+	if (!ima_enabled)
+		return;
+	ima_sysfs_remove();
+}
+
+__initcall(measure_init);
+__exitcall(measure_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Reiner Sailer <sailer@watson.ibm.com>");
+MODULE_DESCRIPTION
+    ("Run-time LSM-based IBM Integrity Measurement Architecture");
diff -uprN linux-2.6.12-rc4/security/ima/ima_lsmhooks.c linux-2.6.12-rc4-ima/security/ima/ima_lsmhooks.c
--- linux-2.6.12-rc4/security/ima/ima_lsmhooks.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_lsmhooks.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,242 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_lsmhooks.c
+ *             implements Linux Security Modules hooks that call into
+ *             into the measurement functions
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/mman.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include "ima.h"
+
+#define MEMORY_MAJOR	1
+#define RAMDISK_MAJOR	1
+#define HD_MAJOR	3
+#define SD_MAJOR        8
+#define MEM_MINOR	1
+#define KMEM_MINOR	2
+
+/* if set, then hooks do nothing 
+ * (controls non-lsm module hook as well) */
+unsigned char ima_terminating = 1;
+
+/* keeps track of calls to mmap_measure */
+atomic_t global_count_mmap_measure;
+
+int measure_file_exec(struct file *, const struct measure_request *);
+int measure_dirty_flag_inode(struct inode *);
+int measure_dirty_flag_super(struct super_block *);
+
+/* measure files mmapped with exec permission */
+int ima_file_mmap(struct file *file, unsigned long reqprot, unsigned long prot, unsigned long flags)
+{
+	static struct measure_request mr = {
+		.fd = 0, .label = 0, 
+		.flags = MMAP_MEASURE_FLAG
+	};
+
+	if (ima_terminating)
+		return 0;
+
+	/* filter interesting calls that actually map files executable */
+	if (!(reqprot & PROT_EXEC) || !file || !file->f_op)
+		return 0;
+
+	/* now check protection  */
+	if (reqprot & MAP_SHARED & PROT_EXEC & PROT_WRITE) {
+		ima_error("MMAP protection flag error!!!\n");
+		invalidate_pcr("MMAP protection flag violation!");
+	}
+	atomic_inc(&global_count_mmap_measure);
+	measure_file_exec(file, &mr);
+	/* IMA is non-intrusive, so we always map */
+	return 0;
+}
+
+/* dirty flags on access with MAY_WRITE|MAY_APPEND */
+int ima_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct ima_inode *i_security = NULL;
+	unsigned int major, minor;
+
+	if (ima_terminating)
+		return 0;
+
+	/* filter interesting permissions for dirty-flagging */
+	if (!(mask & (MAY_WRITE | MAY_APPEND)) || !inode)
+		return 0;
+
+	major = imajor(inode);
+	minor = iminor(inode);
+	/* check for write/append on /dev/kmem, major=1,minor=2 */
+	if ((major == MEMORY_MAJOR) && S_ISCHR(inode->i_mode)) {
+		if (kmem_bypass_protection && (minor == KMEM_MINOR)) {
+			invalidate_pcr("/dev/kmem write violation");
+			/* if needed, get cmdline as done in /fs/proc/base.c */
+		}
+		/* X uses it all over the place ... */
+		if (mem_bypass_protection && (minor == MEM_MINOR)) {
+			invalidate_pcr("/dev/mmem write violation");
+		}
+	} else if (ram_bypass_protection && (major == RAMDISK_MAJOR)
+		   && S_ISBLK(inode->i_mode)) {
+		invalidate_pcr("/dev/ram write violation");
+	} else if (hd_sd_bypass_protection && (major == HD_MAJOR)
+		   && S_ISBLK(inode->i_mode)) {
+		invalidate_pcr("/dev/hdx write violation");
+	} else if (hd_sd_bypass_protection && (major == SD_MAJOR)
+		   && S_ISBLK(inode->i_mode)) {
+		invalidate_pcr("/dev/sdx write violation");
+	}
+	/* else dirty-flag file if measurement bit set in inode-extension */
+	i_security = ima_get_inode_security(inode);
+	/* now check whether this is a file that is currently measured */
+	if (i_security == NULL) 
+		goto out;
+	if (i_security->magic != IMA_MAGIC) {
+		invalidate_pcr("IILLEGAL IMA INODE magic found.\n");
+		return 0;
+	}
+	if (!i_security->file_name) {
+		/* no file name; don't dirty flag */
+		return 0;
+	}
+	if (atomic_read(&(i_security->measure_count))) {
+		/* write permission on measured file was granted! 
+		 * should never occur to file_mmap-ed files but 
+		 * only to instrumented measures from user space */
+		ima_error("ToMToU VIOLATION on file=%s!\n",
+			  i_security->file_name ? 
+			  i_security->file_name : "NONAME");
+		invalidate_pcr("ToMToU violation");
+	}
+ out:
+	/* dirty-flag flag in inode and htable */
+	measure_dirty_flag_inode(inode);
+	return 0;
+}
+
+/* dirty flag files on an umounted file system */
+int ima_sb_umount(struct vfsmount *mnt, int flags)
+{
+	if (ima_terminating)
+		return 0;
+
+	measure_dirty_flag_super(mnt->mnt_sb);
+	return 0;
+}
+
+/* free security structure if applies */
+static void ima_inode_free_security(struct inode *inode)
+{
+	struct ima_inode *i_security;
+
+	if (ima_terminating)
+		return;
+
+	i_security = ima_get_inode_security(inode);
+	if (i_security) {
+		if (i_security->magic != IMA_MAGIC) {
+			ima_error("ILLEGAL IMA INODE magic=%x in ima_inode_free_security.\n",
+			     i_security->magic);
+			return;
+		}
+		kfree(i_security);
+		ima_store_inode_security(inode, NULL);
+	}
+	return;
+}
+
+static void ima_file_free_security(struct file *file)
+{
+	struct ima_file *f_security;
+	struct ima_inode *i_security = NULL;
+
+	if (ima_terminating)
+		return;
+
+	f_security = ima_get_file_security(file);
+	/* decrease measure count if file is measured */
+	if (f_security == NULL)
+		return;
+	if (f_security->magic != IMA_MAGIC) {
+		ima_error("ILLEGAL IMA FILE magic=%x in ima_file_free_security.\n", 
+			  f_security->magic);
+		return;
+	}
+	i_security = ima_get_inode_security(file->f_dentry->d_inode);
+	if (i_security) {
+		if (f_security->is_measuring) {
+			atomic_dec(&(i_security->measure_count));
+		}
+	}
+	kfree(f_security);
+	ima_store_file_security(file, NULL);
+	return;
+}
+
+/* module stacking operations */
+int ima_register_security(const char *name, struct security_operations *ops)
+{
+	/* no stacking */
+	return -EFAULT;
+}
+
+int ima_unregister_security(const char *name, struct security_operations *ops)
+{
+	/* no stacking */
+	return -EFAULT;
+}
+
+struct security_operations ima_ops;
+
+/* IMA requires early initialization in order measure
+   all executables etc from the very beginning. */
+void ima_lsm_init(void)
+{
+	atomic_set(&global_count_mmap_measure, 0);
+
+	/* prepare ima_ops struct */
+	memset(&ima_ops, 0, sizeof(struct security_operations));
+	/* set the few non-null elements */
+	ima_ops.file_mmap = ima_file_mmap;
+	ima_ops.file_free_security = ima_file_free_security;
+	ima_ops.inode_permission = ima_inode_permission;
+	ima_ops.inode_free_security = ima_inode_free_security;
+	ima_ops.sb_umount = ima_sb_umount;
+	ima_ops.register_security = ima_register_security;
+	ima_ops.unregister_security = ima_unregister_security;
+	/* rest will be taken care of by registration (fixup) */
+	if (register_security(&ima_ops)) {
+		invalidate_pcr("IMA: Unable to register with kernel.\n");
+		return;
+	}
+	/* lsm callback and module hooks become hot now ... */
+	ima_terminating = 0;
+}
+
+void ima_remove(void)
+{
+	ima_terminating = 1;
+	/* now unregister the security module */
+	unregister_security(&ima_ops);
+}
+
diff -uprN linux-2.6.12-rc4/security/ima/ima_main.c linux-2.6.12-rc4-ima/security/ima/ima_main.c
--- linux-2.6.12-rc4/security/ima/ima_main.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_main.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,596 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_main.c
+ *             implements run-time measurements
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/crypto.h>
+#include <linux/stat.h>
+#include "ima.h"
+
+/* name for boot aggregate entry */
+char *boot_aggregate_name = "boot_aggregate";
+
+extern struct h_table htable;
+extern struct sha_table sha_htable;
+
+struct sha_entry *ima_lookup_sha_entry(u8 * sha_value);
+struct measure_entry *ima_lookup_measure_entry(unsigned long, dev_t);
+int ima_add_measure_entry(struct measure_entry *);
+int measure_dirty_flag_inode(struct inode *);
+extern struct tpm_chip *ima_used_chip;
+void tpm_extend(int index, const u8 * digest);
+void tpm_pcrread(int index, u8 * hash);
+
+static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
+{
+	return (void *) &tfm[1];
+}
+
+void ima_add_boot_aggregate(void)
+{
+	/* cumulative sha1 the first 8 tpm registers */
+	struct measure_entry *entry;
+	size_t count;
+
+	/* create new entry for boot aggregate */
+	entry = (struct measure_entry *)
+	    kmalloc(sizeof(struct measure_entry), GFP_KERNEL);
+	if (entry == NULL) {
+		invalidate_pcr("error allocating new measurement entry");
+		return;
+	}
+	entry->inodeNr = 0;	/* 0,0 are special (no files) */
+	entry->devId = 0;
+	entry->fsMagic = 0;
+	entry->dirty = DIRTY;
+	entry->superBlock = NULL;
+	memset(entry->digest, 0, 20);
+	if ((count = strlen(boot_aggregate_name)) > ENTRY_MAXFILENAME)
+		count = ENTRY_MAXFILENAME;
+	memcpy(entry->fileName, boot_aggregate_name, count);
+	entry->fileName[count] = '\0';	/* ez-print */
+	if (ima_used_chip != NULL) {
+		int i;
+		u8 pcr_i[20];
+		struct crypto_tfm *tfm;
+		
+		tfm = crypto_alloc_tfm("sha1", 0);
+		if (tfm == NULL) {
+			ima_error("Digest init failed ERROR.\n");
+			return;
+		}
+		crypto_digest_init(tfm);
+
+		for (i = 0; i < 8; i++) {
+			tpm_pcrread(i, pcr_i);
+			/* now accumulate with current aggregate */
+			tfm->__crt_alg->cra_digest.
+			    dia_update(crypto_tfm_ctx(tfm), pcr_i, 20);
+		}
+		crypto_digest_final(tfm, entry->digest);
+		crypto_free_tfm(tfm);
+	} else
+		memset(entry->digest, 0xff, 20);
+
+	/* now add measurement; if TPM bypassed, we have a 0..0 entry */
+	if (ima_add_measure_entry(entry) < 0) {
+		kfree(entry);
+		invalidate_pcr("error adding boot aggregate");
+	} else {		/* extend PCR */
+		tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, entry->digest);
+	}
+}
+
+/* 
+ * Returns the dirty flag setting for an inode
+ * (nfs, windows fs, etc. since we don't control changes)
+ */
+static inline ima_entry_flags get_default_dirty_setting(struct inode *inode)
+{
+	switch (inode->i_sb->s_magic) {
+	case NFS_SUPER_MAGIC:
+		return DIRTY;	/* dirty */
+		break;
+	default:		/* local fs etc. */
+		return CLEAN;	/* clean */
+	}
+}
+
+/* returns >0 if measurement can be skipped
+ * returns =0 if measurement must be done 
+ */
+static int skip_measurement(struct file *file)
+{
+	/* what could we exclude 
+	 *   - non-executable/non-library files ?
+	 *   - /proc /dev ?
+	 */
+	struct inode *inode = file->f_dentry->d_inode;
+
+	if (!(file->f_op) || !(file->f_op->read))
+		return 1;	/* no file to measure */
+	if ((inode->i_sb->s_magic == DEVFS_SUPER_MAGIC) ||
+	    (inode->i_sb->s_magic == PROC_SUPER_MAGIC) ||
+	    (inode->i_sb->s_magic == SYSFS_MAGIC)) {
+		invalidate_pcr("CANNOT measure fs type.\n");	
+		return 1; 	/*can't measure */
+	}
+	if (S_ISLNK(inode->i_mode) ||
+	    S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		return 1;	/* don't measure */
+	}
+	return 0;	       	/* measure */
+}
+
+
+/* 
+ * measures new file and 
+ * adds it to measurement list 
+ */
+static struct measure_entry *measure_file(struct file *file, struct dentry *dentry, struct inode *inode)
+{
+	struct ima_inode *i_security = NULL;
+	mm_segment_t oldfs;
+	int error = 0;
+	loff_t offset = 0;
+	size_t count;
+	struct crypto_tfm *tfm;
+	struct measure_entry *entry;
+
+	char *bufp = NULL;
+	/* create read buffer */
+	if ((bufp =
+	     (char *) kmalloc(PAGE_SIZE, GFP_KERNEL)) == 0) {
+		ima_error("no memory for read buffer\n");
+		error = -ENOMEM;
+		goto out;	/* invalidate pcr */
+	}
+	/* create new entry and measure */
+	entry = (struct measure_entry *)
+	    kmalloc(sizeof(struct measure_entry), GFP_KERNEL);
+	if (entry == NULL) {
+		error = -ENOMEM;
+		ima_error("error allocating new measurement entry");
+		kfree(bufp);
+		goto out;	/* invalidate pcr */
+	}
+	entry->inodeNr = inode->i_ino;
+	entry->devId = inode->i_rdev;
+	entry->fsMagic = inode->i_sb->s_magic;
+	entry->dirty = get_default_dirty_setting(inode);
+	entry->superBlock = inode->i_sb;
+	if ((count = dentry->d_name.len) > ENTRY_MAXFILENAME)
+		count = ENTRY_MAXFILENAME;
+	memcpy(entry->fileName, dentry->d_name.name, count);
+	entry->fileName[count] = '\0';	/* ez-print */
+	error = 0;
+	/* second add sha1 over file contents */
+	/* init context */
+	tfm = crypto_alloc_tfm("sha1", 0);
+	if (tfm == NULL) {
+		ima_error("Digest init failed ERROR.\n");
+		goto outm;
+	}
+	crypto_digest_init(tfm);
+
+	/* set fs so that kernel writes into kernel segment */
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	do {
+		if ((count =
+		     (file->f_op->read) (file,
+					 (char __user *) bufp,
+					 PAGE_SIZE,
+					 &offset)) < 0) {
+			error = count;
+			ima_error("Error reading from file (%d)\n", error);
+			goto outf;
+		}
+		/* update hash with this part */
+		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
+						      bufp, count);
+	} while (count);
+	set_fs(oldfs);
+
+	/* complete hash */
+	crypto_digest_final(tfm, entry->digest);
+	crypto_free_tfm(tfm);
+	/* before returning, replicate important information into inode->i_security */
+	i_security = ima_get_inode_security(inode);
+	if (i_security != NULL) {
+		/* update */
+		if (i_security->magic != IMA_MAGIC) {
+			invalidate_pcr("Illegal magic in i_security structure");
+			goto outm;
+		} else {
+			i_security->dirty = entry->dirty;
+			/* measure_count was increased in local_measure already */
+			i_security->file_name = (char *) (entry->fileName);
+			/* increase #procs measuring; dec on file-close */
+		}
+	} else
+		panic("IMA: never should we end up here! No security structure in measure!\n");
+
+	kfree(bufp);
+	return (entry);
+
+	/* error exits */
+      outf:
+	set_fs(oldfs);
+      outm:
+	kfree(entry);
+	kfree(bufp);
+      out:
+	/* invalidate TPM */
+	invalidate_pcr("error measuring file");
+	return (NULL);
+}
+
+/* measure memory */
+int do_measure_memory(void *start, unsigned long len, const struct measure_request *mr, char *name)
+{
+	struct crypto_tfm *tfm;
+	u8 mem_digest[20];
+	int error = 0;
+	struct measure_entry *entry;
+
+	/* init context */
+	tfm = crypto_alloc_tfm("sha1", 0);
+	if (tfm == NULL) {
+		invalidate_pcr("No SHA1 available");
+		return -EFAULT;
+	}
+	crypto_digest_init(tfm);
+	/* now measure the memory ... */
+	tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm), start,
+					      len);
+	crypto_digest_final(tfm, mem_digest);
+	crypto_free_tfm(tfm);
+
+	down(&h_table_mutex);
+	if (!ima_lookup_sha_entry(mem_digest)) {
+		/* create new entry and measure */
+		entry = (struct measure_entry *)
+		    kmalloc(sizeof(struct measure_entry), GFP_KERNEL);
+		if (entry == NULL) {
+			invalidate_pcr("OUT OF MEMORY");
+			error = -EFAULT;
+			goto out;
+		}
+		entry->inodeNr = 0;	/* special entries, no file entries */
+		entry->devId = 0;
+		entry->fsMagic = 0;
+		entry->dirty = DIRTY;
+		entry->superBlock = NULL;
+		memcpy(entry->digest, mem_digest, 20);
+		strncpy(entry->fileName, name, ENTRY_MAXFILENAME);	/* ez-print */
+		if (mr != NULL) {
+			memcpy(&(entry->mr), mr,
+			       sizeof(struct measure_request));
+		} else {
+			memset(&(entry->mr), 0,
+			       sizeof(struct measure_request));
+		}
+
+		if ((error = ima_add_measure_entry(entry)) < 0) {
+			kfree(entry);
+			invalidate_pcr
+			    ("error adding new measurement entry");;
+			goto out;
+		} else {	/* extend PCR */
+			tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, entry->digest);
+		}
+	}			/* else we already have this hash value from an exec/file that was running earlier */
+	up(&h_table_mutex);
+	return 0;
+      out:
+	up(&h_table_mutex);
+	return -EFAULT;
+}
+
+static unsigned int find_mod_sec(Elf_Ehdr * hdr, Elf_Shdr * sechdrs, const char *secstrings, const char *name)
+{
+	unsigned int i;
+	for (i = 1; i < hdr->e_shnum; i++)
+		/* Alloc bit cleared means "here is nothing to look for (ignore)" */
+		if ((sechdrs[i].sh_flags & SHF_ALLOC)
+		    && strcmp(secstrings + sechdrs[i].sh_name, name) == 0)
+			return i;
+	return 0;
+}
+
+/* Measure kernel modules in-memory before relocation */
+void measure_kernel_module(void *start, unsigned long len, const char __user * uargs)
+{
+	Elf_Ehdr *hdr;
+	Elf_Shdr *sechdrs;
+	struct module *mod;
+	unsigned int modindex;
+	char *args, *secstrings;
+	long arglen;
+	struct measure_request mr = {.fd = 0, .label = 0,
+				     .flags = MODULE_MEASURE_FLAG	  
+	};
+	arglen = strlen_user(uargs);
+	if (!arglen) {
+		invalidate_pcr("ERROR measuring kernel module!");
+		return;
+	}
+	args = kmalloc(arglen, GFP_KERNEL);
+	if (!args) {
+		invalidate_pcr("OUT OF MEMORY measuring kernel module!");
+		return;
+	}
+	if (copy_from_user(args, uargs, arglen) != 0) {
+		invalidate_pcr("ERROR measuring kernel module!");
+		return;
+	}
+	/* get the module name for entry */
+	hdr = (Elf_Ehdr *) start;
+	sechdrs = (void *) hdr + hdr->e_shoff;
+	secstrings = (void *) hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	modindex = find_mod_sec(hdr, sechdrs, secstrings,
+				".gnu.linkonce.this_module");
+	if (!modindex) {
+		ima_error("No module found in object\n");
+		invalidate_pcr("Module without name?!");
+		return;
+	}
+	mod = (void *) ((size_t) hdr + sechdrs[modindex].sh_offset);
+	do_measure_memory(start, len, &mr, mod->name);
+	return;
+}
+
+
+/* Measure files mapped as executable */
+int measure_file_exec(struct file *file, const struct measure_request *mr)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	int error = 0;
+	struct measure_entry *entry, *new_entry;
+	struct ima_file *f_security = NULL;
+	struct ima_inode *i_security = NULL;
+
+	if (!file || !file->f_op) {
+		ima_error("File not found Error!\n");
+		return -EACCES;
+	}
+	if (!file->f_dentry || !file->f_dentry->d_inode) {
+		ima_error("File dentry or inode connection broken (NULL) ERROR!\n");
+		return -EACCES;
+	}
+	/* here we skip unnecessary measurements */
+	if (skip_measurement(file)) {
+		return 0;
+	}
+	dentry = file->f_dentry;
+	inode = dentry->d_inode;
+	/* save information in file in order to dec measure_count in inode once
+	 * file is closed ... */
+	f_security = ima_get_file_security(file);
+	if (f_security != NULL) {
+		if (f_security->magic != IMA_MAGIC) {
+			invalidate_pcr("Internal inconsistency error (f_security with illegal magic).\n");
+			return -EFAULT;
+		} else {
+			/* HERE file struct is being re-used (not freed) .. happens more and more */
+			i_security =
+			    ima_get_inode_security(file->f_dentry->
+						   d_inode);
+			if ((i_security == NULL)
+			    || (i_security->magic != IMA_MAGIC)) {
+				invalidate_pcr("Internal inconsistency error (f_security not free but no i_security).\n");
+				return -EFAULT;
+			}
+		}
+	} else {
+		/* file->f_security = NULL; normal case */
+		f_security = kmalloc(sizeof(struct ima_file), GFP_KERNEL);
+		if (f_security == NULL) {
+			invalidate_pcr("out of memory error");
+			return -EFAULT;
+		} else {
+			f_security->magic = IMA_MAGIC;
+			f_security->is_measuring = 1;
+			ima_store_file_security(file, f_security);
+		}
+		/* a) we maintain an inode copy of clean etc. to speed up clean hits */
+		i_security = ima_get_inode_security(inode);
+		if (i_security != NULL) {
+			if (i_security->magic != IMA_MAGIC) {
+				invalidate_pcr
+				    ("PANIC! Unexpected i_security MAGIC!");
+				return -EFAULT;
+			}
+			/* only increment it once for any open file, thus here in the "f_security==null" case */
+			atomic_inc(&(i_security->measure_count));
+		} else {
+			/* create ima_inode structure */
+			i_security =
+			    kmalloc(sizeof(struct ima_inode), GFP_KERNEL);
+			if (i_security == NULL) {;
+				invalidate_pcr("out of memory error");
+				return -EFAULT;
+			} else {
+				i_security->magic = IMA_MAGIC;
+				i_security->dirty = DIRTY;
+				/* is reset later after measuring file */
+				atomic_set(&(i_security->measure_count),
+					   1);
+				i_security->file_name = NULL;
+				ima_store_inode_security(inode,
+							 i_security);
+			}
+		}
+	}
+	/* a) catch most cases */
+	i_security = ima_get_inode_security(inode);
+	if ((i_security) && (i_security->dirty == CLEAN)) {
+		atomic_inc(&htable.cleanInodeHits);
+		return 0;	/* clean hit */
+	}
+	/* b) if there is already a writer on this file --> error! 
+	 *    only i_writecount < 0 disables writers;
+	 * do this test AFTER setting inode->i_security->measure_count!
+	 */
+	if (atomic_read(&(inode->i_writecount)) > 0) {
+		invalidate_pcr("Measured file has writers.");
+		return -EFAULT;
+	}
+	/* c) real measure work */
+	down(&h_table_mutex);
+	entry = ima_lookup_measure_entry(inode->i_ino, inode->i_rdev);
+	if ((entry != NULL) && (entry->dirty == CLEAN)) {
+		goto out;	/* release lock; nothing to measure */
+	}
+	new_entry = measure_file(file, dentry, inode);
+	/* now we adjust the entry table:
+	 * -- if there was no entry, we just add the new one
+	 * -- if there was one but different hash, we add the new one
+	 * -- if there was one and same hash, we clear dirty bit on existing one
+	 */
+	if (!new_entry) {
+		/* internal error, make sure attestation fails from now on */
+		invalidate_pcr("internal error");	/* expand with illegal entry */
+		error = -EFAULT;
+		goto out;
+	}
+	if (mr != NULL) {
+		memcpy(&(new_entry->mr), mr,
+		       sizeof(struct measure_request));
+	} else {
+		memset(&(new_entry->mr), 0,
+		       sizeof(struct measure_request));
+	}
+	if (entry == NULL) {	/* no old entry for this inode found */
+		/* add if no same-hash recorded (i.e., no copy measured yet) */
+		if (!ima_lookup_sha_entry(new_entry->digest)) {
+			if ((error = ima_add_measure_entry(new_entry)) < 0) {
+				kfree(new_entry);
+				invalidate_pcr
+				    ("error adding measurement entry");
+				error = -EFAULT;
+			} else {	/* extend PCR */
+				tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX,
+					   new_entry->digest);
+			}
+		}
+	} else {		/* old entry exists */
+		if (!memcmp(entry->digest, new_entry->digest, 20)) {
+			entry->dirty = get_default_dirty_setting(inode);
+			/* re-label with default (not to ever clean nfs etc. files) */
+			kfree(new_entry);
+		} else {
+			/* dirty and look whether to add new entry */
+			entry->dirty = CHANGED;
+			atomic_inc(&htable.changedFiles);
+			if (!ima_lookup_sha_entry(new_entry->digest)) {
+				if ((error =
+				     ima_add_measure_entry(new_entry)) <
+				    0) {
+					kfree(new_entry);
+					invalidate_pcr
+					    ("error adding measurement entry");
+					error = -EFAULT;
+				} else {	/* extend PCR */
+					tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX,
+						   new_entry->digest);
+				}
+			}
+		}
+	}
+      out:
+	up(&h_table_mutex);
+	return (error);
+}
+
+/* called permission for dirty-flagging 
+ * we are moving towards inode-based flagging
+ * and thus avoiding table lookup for dirty flagging
+ */
+int measure_dirty_flag_inode(struct inode *inode)
+{
+	struct measure_entry *entry;
+	struct ima_inode *i_security = NULL;
+
+	if (!inode) {
+		/* not a file to measure */
+		return 0;
+	}
+	down(&h_table_mutex);
+	if ((entry =
+	     ima_lookup_measure_entry(inode->i_ino, inode->i_rdev))) {
+		if (entry->dirty == CLEAN)
+			entry->dirty = DIRTY;
+		/* change from clean to dirty only, leave "changed" unchanged */
+		/* inode dirty flag must be set, too */
+		if ((i_security = ima_get_inode_security(inode)) != NULL) {
+			if (i_security->dirty == CLEAN) {
+				i_security->dirty = DIRTY;
+			}
+		}
+	}
+	up(&h_table_mutex);
+	return 0;
+}
+
+/* called by mount to dirty-flag on "umount" */
+int measure_dirty_flag_super(struct super_block *super)
+{
+	/* here we go through the whole hash table and look 
+	 * for entries with this superblock to mark them dirty if clean
+	 */
+	struct queue_entry *qe;
+	int j;
+
+	if (htable.terminating)
+		return 0;
+
+	down(&h_table_mutex);
+	for (j = 0; j < htable.max_htable_size; j++) {
+		/* walk the whole hash table */
+		qe = htable.queue[j];
+		while (qe != NULL) {
+			if (qe->entry->superBlock == super) {
+				if (qe->entry->dirty == CLEAN)
+					qe->entry->dirty = DIRTY;
+			}
+			qe = qe->next;
+		}
+	}
+	up(&h_table_mutex);
+	return 0;
+}
+
+EXPORT_SYMBOL(measure_file_exec);
+EXPORT_SYMBOL(measure_kernel_module);
+EXPORT_SYMBOL(measure_dirty_flag_super);
+EXPORT_SYMBOL(measure_dirty_flag_inode);
diff -uprN linux-2.6.12-rc4/security/ima/ima_proc.c linux-2.6.12-rc4-ima/security/ima/ima_proc.c
--- linux-2.6.12-rc4/security/ima/ima_proc.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_proc.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,444 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_proc.c
+ *             implements proc fs for measurements;
+ *             added static large buffer for /proc/ima/xmlmeasurements
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/crypto.h>
+#include <linux/string.h>
+#include <linux/proc_fs.h>
+
+#include "ima.h"
+
+#define MAXPROCMEM 128*1024
+static struct proc_dir_entry *tpm_dir;
+static char *xmlmem = NULL;
+extern atomic_t global_count_sysfs;
+extern atomic_t global_count_sysfs_measure;
+extern atomic_t global_count_mmap_measure;
+extern struct h_table htable;
+
+/*
+ * /proc filesystem interface
+ */
+static int ima_proc_read_htable(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ssize_t len = 0;
+
+	down(&h_table_mutex);
+	if (count - len > 0)
+		len +=
+		    snprintf(page + len, count - len,
+			     "\nTCG MEASUREMENT HASH TABLE: \n");
+	if (count - len > 0)
+		len +=
+		    snprintf(page + len, count - len,
+			     "len\t\tcleanIHit\tcleanHit\tdirtyHit\tchangedFiles\n");
+	if (count - len > 0) {
+		len +=
+		    snprintf(page + len, count - len,
+			     "%i\t\t%i\t\t%i\t\t%i\t\t%i\n\n",
+			     atomic_read(&htable.len),
+			     atomic_read(&htable.cleanInodeHits),
+			     atomic_read(&htable.cleanTableHits),
+			     atomic_read(&htable.dirtyTableHits),
+			     atomic_read(&htable.changedFiles)
+		    );
+	}
+	if (count - len > 0)
+		len +=
+		    snprintf(page + len, count - len,
+			     "sysfs\t\tsysfs_measure\t\tmmap_measure\t\ttermFlag\n");
+	if (count - len > 0) {
+		len +=
+		    snprintf(page + len, count - len,
+			     "%i\t\t%i\t\t\t%i\t\t\t%i\n\n",
+			     atomic_read(&global_count_sysfs),
+			     atomic_read(&global_count_sysfs_measure),
+			     atomic_read(&global_count_mmap_measure),
+			     htable.terminating);
+	}
+
+	*eof = 1;
+	up(&h_table_mutex);
+	if (len > count)
+		len = count;
+
+	return len;
+}
+
+
+static int print_measure_entry(struct measure_entry *e, char *buf, int count, int nr)
+{
+	return snprintf(buf, count,
+			"#%03d: %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X"
+			"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X [%s] %s\n",
+			nr, e->digest[0], e->digest[1], e->digest[2],
+			e->digest[3], e->digest[4], e->digest[5],
+			e->digest[6], e->digest[7], e->digest[8],
+			e->digest[9], e->digest[10], e->digest[11],
+			e->digest[12], e->digest[13], e->digest[14],
+			e->digest[15], e->digest[16], e->digest[17],
+			e->digest[18], e->digest[19],
+			(e->dirty ==
+			 DIRTY) ? "remeasure" : ((e->dirty ==
+						  CHANGED) ? "changed" :
+						 "clean"), e->fileName);
+}
+
+
+static int ima_proc_read_measurements(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct queue_entry *qe;
+	static unsigned int len, i;
+	static unsigned int nextpos;
+	int ret = 0;
+
+	down(&h_table_mutex);
+	/* first reset pos for new requests */
+	if (!off)
+		nextpos = 0;
+
+	/* ALWAYS set page here... otherwise it uses running offset */
+	*start = page;
+	ret = 0;
+	*eof = 0;
+
+	/* now overread the first "nextpos" elements */
+	for (qe = first_measurement, i = 0;
+	     qe && qe->entry && (i < nextpos); qe = qe->later, i++);
+
+	/* make sure the next entry fits completely */
+	while ((count > 500) && qe && qe->entry) {
+		/* now fill rest of page */
+		len =
+		    print_measure_entry(qe->entry, page + ret, count,
+					nextpos);
+		qe = qe->later;
+		count -= len;
+		ret += len;
+		nextpos += 1;
+	}
+	/* do we have more elements? */
+	if (!qe) {
+		*eof = 1;
+	}
+	up(&h_table_mutex);
+	return ret;
+}
+
+/* print format: 32bit-le=pcr#||char[20]=digest||filename||'\0'  len(filename)<40*/
+static int print_measure_event_entry(struct measure_entry *e, char *buf, int count, int nr)
+{
+#define TCG_EVENT_NAME_LEN_MAX	40
+
+	void *ptr = (void *) buf;
+	int filename_len = strlen(e->fileName);
+
+	/* 1st: PCR used is always the same (config option) in little-endian format */
+	*((u32 *) ptr) = (u32) CONFIG_IMA_MEASURE_PCR_IDX;
+	ptr += 4;
+
+	/* 2nd: SHA1 ... */
+	memcpy(ptr, e->digest, 20);
+	ptr += 20;
+
+	/* 3rd:  filename <=40 + \'0' delimiter */
+	if (filename_len > (TCG_EVENT_NAME_LEN_MAX - 1))
+		filename_len = TCG_EVENT_NAME_LEN_MAX - 1;
+
+	memcpy(ptr, e->fileName, filename_len);
+	ptr += filename_len;
+
+	/* 4th: delimiter */
+	*((char *) ptr) = '\0';
+	ptr += 1;
+
+	return ((u32) ptr - (u32) buf);
+}
+
+
+static int ima_proc_read_measurement_events(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct queue_entry *qe;
+	static unsigned int len, i;
+	static unsigned int nextpos;
+	int ret = 0;
+
+	down(&h_table_mutex);
+	/* first reset pos for new requests */
+	if (!off)
+		nextpos = 0;
+
+	*start = page;
+	ret = 0;
+	*eof = 0;
+
+	/* now overread the first "nextpos" elements */
+	for (qe = first_measurement, i = 0;
+	     qe && qe->entry && (i < nextpos); qe = qe->later, i++);
+
+	/* make sure the next entry fits completely */
+	while ((count > 500) && qe && qe->entry) {
+		/* now fill rest of page */
+		len =
+		    print_measure_event_entry(qe->entry, page + ret, count,
+					      nextpos);
+		qe = qe->later;
+		count -= len;
+		ret += len;
+		nextpos += 1;
+	}
+	/* do we have more elements or not ? */
+	if (!qe) {
+		*eof = 1;
+	}
+	up(&h_table_mutex);
+	return ret;
+}
+
+#define mr_hook(e) \
+	(((e)->mr.flags & MMAP_MEASURE_FLAG) ?		\
+	 "mmap" :					\
+	 ((e)->mr.flags & MODULE_MEASURE_FLAG) ?	\
+	 "module" :				\
+	 ((e)->mr.flags & USER_MEASURE_FLAG) ?		\
+	 "user" : "UNKNOWN")
+	
+static int print_extmeasure_entry(struct measure_entry *e, char *buf, int count, int nr)
+{
+	return snprintf(buf, count,
+			"#%03d: %02X%02X%02X%02X%02X%02X%02X%02X%02X%02X"
+			"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X [%s] %s L[%u,%lu,%s]\n",
+			nr, e->digest[0], e->digest[1], e->digest[2],
+			e->digest[3], e->digest[4], e->digest[5],
+			e->digest[6], e->digest[7], e->digest[8],
+			e->digest[9], e->digest[10], e->digest[11],
+			e->digest[12], e->digest[13], e->digest[14],
+			e->digest[15], e->digest[16], e->digest[17],
+			e->digest[18], e->digest[19],
+			(e->dirty ==
+			 DIRTY) ? "remeasure" : ((e->dirty ==
+						  CHANGED) ? "changed" :
+						 "clean"), e->fileName,
+			e->mr.label, e->mr.flags, mr_hook(e));
+}
+
+
+static int ima_proc_read_extmeasurements(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct queue_entry *qe;
+	static unsigned int len, i;
+	static unsigned int nextpos;
+	int ret = 0;
+
+	down(&h_table_mutex);
+	/* first reset pos for new requests */
+	if (!off)
+		nextpos = 0;
+
+	/* ALWAYS set page here... otherwise it uses running offset not return value! */
+	*start = page;
+	ret = 0;
+	*eof = 0;
+
+	/* now overread the first "nextpos" elements */
+	for (qe = first_measurement, i = 0;
+	     qe && qe->entry && (i < nextpos); qe = qe->later, i++);
+
+	/* make sure the next entry fits completely */
+	while ((count > 500) && qe && qe->entry) {
+		/* now fill rest of page */
+		len =
+		    print_extmeasure_entry(qe->entry, page + ret, count,
+					   nextpos);
+		qe = qe->later;
+		count -= len;
+		ret += len;
+		nextpos += 1;
+	}
+	/* do we have more elements or not ? */
+	if (!qe) {
+		*eof = 1;
+	}
+	up(&h_table_mutex);
+	return ret;
+}
+
+
+static int print_xmlmeasure_entry(struct measure_entry *e, char *buf, int count, int nr)
+{
+	return snprintf(buf, count,
+			"<NUM>%03d</NUM><SHA1>%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X"
+			"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X</SHA1><STATUS>%s</STATUS><NAME>%s</NAME>\n",
+			nr, e->digest[0], e->digest[1], e->digest[2],
+			e->digest[3], e->digest[4], e->digest[5],
+			e->digest[6], e->digest[7], e->digest[8],
+			e->digest[9], e->digest[10], e->digest[11],
+			e->digest[12], e->digest[13], e->digest[14],
+			e->digest[15], e->digest[16], e->digest[17],
+			e->digest[18], e->digest[19],
+			(e->dirty ==
+			 DIRTY) ? "remeasure" : ((e->dirty ==
+						  CHANGED) ? "changed" :
+						 "clean"), e->fileName);
+}
+
+
+static int ima_proc_read_xmlmeasurements(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct queue_entry *qe;
+	static unsigned int len, i;
+	static unsigned int nextpos;
+	int ret = 0;
+
+	down(&h_table_mutex);
+	/* first reset pos for new requests */
+	if (!off)
+		nextpos = 0;
+
+	*start = page;
+	ret = 0;
+	*eof = 0;
+
+	/* now overread the first "nextpos" elements */
+	for (qe = first_measurement, i = 0;
+	     qe && qe->entry && (i < nextpos); qe = qe->later, i++);
+
+	/* make sure the next entry fits completely */
+	while ((count > 500) && qe && qe->entry) {
+		/* now fill rest of page */
+		len =
+		    print_xmlmeasure_entry(qe->entry, page + ret, count,
+					   nextpos);
+		qe = qe->later;
+		count -= len;
+		ret += len;
+		nextpos += 1;
+	}
+	/* do we have more elements or not ? */
+	if (!qe) {
+		*eof = 1;
+	}
+	up(&h_table_mutex);
+	return ret;
+}
+
+
+void ima_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	tpm_dir = proc_mkdir(IMA_MEASURE_PROC_NAME, NULL);
+	if (tpm_dir == NULL)
+		return;
+
+	if ((xmlmem = kmalloc(MAXPROCMEM, GFP_KERNEL)) == NULL) {
+		ima_error("proc XMLmeasurements out of memory ERROR.\n");
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		return;
+	}
+
+	entry = create_proc_read_entry("measurements",
+				       0444, tpm_dir,
+				       ima_proc_read_measurements, NULL);
+	if (entry == NULL) {
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		if (xmlmem != NULL)
+			kfree(xmlmem);
+		return;
+	}
+	entry->owner = THIS_MODULE;
+
+	entry = create_proc_read_entry("xmlmeasurements",
+				       0444, tpm_dir,
+				       ima_proc_read_xmlmeasurements,
+				       NULL);
+	if (entry == NULL) {
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		remove_proc_entry("measurements", tpm_dir);
+		if (xmlmem != NULL)
+			kfree(xmlmem);
+		return;
+	}
+	entry->owner = THIS_MODULE;
+
+	entry = create_proc_read_entry("extmeasurements",
+				       0444, tpm_dir,
+				       ima_proc_read_extmeasurements,
+				       NULL);
+	if (entry == NULL) {
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		remove_proc_entry("measurements", tpm_dir);
+		remove_proc_entry("xmlmeasurements", tpm_dir);
+		if (xmlmem != NULL)
+			kfree(xmlmem);
+		return;
+	}
+	entry->owner = THIS_MODULE;
+
+	entry = create_proc_read_entry("measurement_events",
+				       0444, tpm_dir,
+				       ima_proc_read_measurement_events,
+				       NULL);
+	if (entry == NULL) {
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		remove_proc_entry("measurements", tpm_dir);
+		remove_proc_entry("xmlmeasurements", tpm_dir);
+		remove_proc_entry("extmeasurements", tpm_dir);
+		if (xmlmem != NULL)
+			kfree(xmlmem);
+		return;
+	}
+	entry->owner = THIS_MODULE;
+
+	entry = create_proc_read_entry("htable",
+				       0444, tpm_dir, ima_proc_read_htable,
+				       NULL);
+	if (entry == NULL) {
+		remove_proc_entry("measurements", tpm_dir);
+		remove_proc_entry("xmlmeasurements", tpm_dir);
+		remove_proc_entry("extmeasurements", tpm_dir);
+		remove_proc_entry("measurement_events", tpm_dir);
+		remove_proc_entry(IMA_MEASURE_MODULE_NAME, NULL);
+		if (xmlmem != NULL)
+			kfree(xmlmem);
+		return;
+	}
+	entry->owner = THIS_MODULE;
+}
+
+void ima_proc_cleanup(void)
+{
+	remove_proc_entry("htable", tpm_dir);
+	remove_proc_entry("measurements", tpm_dir);
+	remove_proc_entry("xmlmeasurements", tpm_dir);
+	remove_proc_entry("extmeasurements", tpm_dir);
+	remove_proc_entry("measurement_events", tpm_dir);
+	remove_proc_entry(IMA_MEASURE_PROC_NAME, NULL);
+	if (xmlmem != NULL)
+		kfree(xmlmem);
+}
diff -uprN linux-2.6.12-rc4/security/ima/ima_queue.c linux-2.6.12-rc4-ima/security/ima/ima_queue.c
--- linux-2.6.12-rc4/security/ima/ima_queue.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_queue.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,241 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_queue.c
+ *             implements queues for run-time measurement
+ *             functions based on SHA1
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/crypto.h>
+
+#include "ima.h"
+
+/* pointer to very first and latest measurement (time-ordered) */
+struct queue_entry *first_measurement = NULL;	/* for printing */
+struct queue_entry *latest_measurement = NULL;	/* for adding */
+
+struct h_table htable;		/* key: inode (before secure-hashing a file) */
+struct sha_table sha_htable;	/* key: hash (after secure-hashing a file) */
+int ima_add_sha_entry(struct measure_entry *);
+
+DECLARE_MUTEX_LOCKED(h_table_mutex);
+
+void create_sha_htable(void)
+{
+	int i;
+
+	atomic_set(&sha_htable.len, 0);
+	sha_htable.max_htable_size = MEASURE_HTABLE_SIZE;
+	sha_htable.terminating = 0;
+	for (i = 0; i < sha_htable.max_htable_size; i++) {
+		sha_htable.queue[i] = NULL;
+		atomic_set(&sha_htable.queueLen[i], 0);
+	}
+}
+
+void create_htable(void)
+{
+	int i;
+
+	init_MUTEX_LOCKED(&h_table_mutex);
+	first_measurement = NULL;
+	latest_measurement = NULL;
+	atomic_set(&htable.len, 0);
+	atomic_set(&htable.cleanInodeHits, 0);
+	atomic_set(&htable.cleanTableHits, 0);
+	atomic_set(&htable.dirtyTableHits, 0);
+	atomic_set(&htable.changedFiles, 0);
+	htable.max_htable_size = MEASURE_HTABLE_SIZE;
+	htable.terminating = 0;
+	for (i = 0; i < htable.max_htable_size; i++) {
+		htable.queue[i] = NULL;
+		atomic_set(&htable.queueLen[i], 0);
+	}
+	up(&h_table_mutex);
+}
+
+void destroy_sha_htable(void)
+{
+	struct sha_entry *qe;
+	int i;
+
+	sha_htable.terminating = 1;
+	/* now release queues */
+	for (i = 0; i < sha_htable.max_htable_size; i++) {
+		while ((qe = sha_htable.queue[i]) != NULL) {
+			sha_htable.queue[i] = qe->next;
+			kfree(qe);
+		}
+		sha_htable.queue[i] = NULL;
+		atomic_set(&sha_htable.queueLen[i], 0);
+	}
+	return;
+}
+
+void destroy_htable(void)
+{
+	struct queue_entry *qe;
+	int i;
+
+	down(&h_table_mutex);
+	first_measurement = NULL;
+	latest_measurement = NULL;
+	htable.terminating = 1;
+	/* now release queues */
+	for (i = 0; i < htable.max_htable_size; i++) {
+		while ((qe = htable.queue[i]) != NULL) {
+			htable.queue[i] = qe->next;
+			if (qe->entry)
+				kfree(qe->entry);
+			kfree(qe);
+		}
+		htable.queue[i] = NULL;
+		atomic_set(&htable.queueLen[i], 0);
+	}
+	/* no up until create */
+	return;
+}
+
+/* 
+ * also sets clean and dirty table hit marks 
+ */
+struct measure_entry *ima_lookup_measure_entry(unsigned long inodeNumber, dev_t devNumber)
+{
+	struct queue_entry *qe;
+	struct measure_entry *me;
+
+	if (htable.terminating)
+		return NULL;
+
+	/* fill in later */
+	qe = htable.queue[HASH_KEY(inodeNumber)];
+	while ((qe != NULL) && ((qe->entry->inodeNr != inodeNumber)
+				|| (qe->entry->devId != devNumber)))
+		qe = qe->next;
+
+	if (qe != NULL) {
+		if (qe->entry->dirty != CLEAN) {
+			atomic_inc(&htable.dirtyTableHits);
+		} else {
+			atomic_inc(&htable.cleanTableHits);
+		}
+		me = qe->entry;
+	} else {
+		me = NULL;
+	}
+	return me;
+}
+
+
+
+struct sha_entry *ima_lookup_sha_entry(u8 * sha_value)
+{
+	struct sha_entry *se;
+	unsigned int key;
+
+	if (sha_htable.terminating)
+		return NULL;
+
+	key = SHA_KEY(sha_value);
+	se = sha_htable.queue[key];
+	while ((se != NULL) && (memcmp(se->digest, sha_value, 20))) {
+		/* unequal hash */
+		se = se->next;
+	}
+	return se;
+}
+
+
+int ima_add_measure_entry(struct measure_entry *entry)
+{
+	unsigned int key;
+	struct queue_entry *qe;
+	int error = 0;
+
+	/* new measurement -> add */
+	if (htable.terminating)
+		return -1;
+
+	/* calculate key */
+	key = HASH_KEY(entry->inodeNr);
+
+	/* create queue_entry */
+	if ((qe = kmalloc(sizeof(struct queue_entry), GFP_KERNEL)) == NULL) {
+		ima_error("OUT OF MEMORY in %s.\n", __func__);
+		error = -ENOMEM;
+		goto out;
+	}
+	qe->entry = entry;
+
+	/* insert entry at beginning of queue */
+	qe->next = htable.queue[key];
+	qe->later = NULL;
+	htable.queue[key] = qe;
+	atomic_inc(&htable.queueLen[key]);
+	/* update later list */
+	if (first_measurement == NULL) {
+		first_measurement = qe;
+	} else {
+		latest_measurement->later = qe;
+	}
+	latest_measurement = qe;
+	atomic_inc(&htable.len);
+	/* now add to sha hash table, too */
+	if (ima_add_sha_entry(entry))
+		error = -ENOMEM;
+      out:
+	return error;
+}
+
+
+
+int ima_add_sha_entry(struct measure_entry *entry)
+{
+	unsigned int key;
+	struct sha_entry *se;
+
+	if (sha_htable.terminating)
+		return -1;
+
+	/* calculate key */
+	key = SHA_KEY(entry->digest);
+	/* create queue_entry */
+	if ((se = kmalloc(sizeof(struct sha_entry), GFP_KERNEL)) == NULL)
+		goto out;
+	se->m_entry = entry;
+	se->digest = entry->digest;
+	se->next = NULL;
+
+	/* insert entry at beginning of queue */
+	se->next = sha_htable.queue[key];
+	sha_htable.queue[key] = se;
+	atomic_inc(&sha_htable.queueLen[key]);
+	/* update later list */
+	atomic_inc(&sha_htable.len);
+	return 0;
+
+      out:
+	ima_error("OUT OF MEMORY ERROR creating queue entry.\n");
+	return -ENOMEM;
+}
diff -uprN linux-2.6.12-rc4/security/ima/ima_sysfs.c linux-2.6.12-rc4-ima/security/ima/ima_sysfs.c
--- linux-2.6.12-rc4/security/ima/ima_sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_sysfs.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_sysfs.c
+ *             sysfs interface to request measurements
+ *             through instrumented user applications
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/kmod.h>
+#include <linux/kobj_map.h>
+#include <linux/sysfs.h>
+#include "ima.h"
+
+static struct subsystem security_subsys;
+
+atomic_t global_count_sysfs;
+atomic_t global_count_sysfs_measure;
+
+int measure_file_exec(struct file *, const struct measure_request *);
+
+static ssize_t security_attr_show(struct kobject *kobj,
+				  struct attribute *attr, char *page)
+{
+	/* get security attribute */
+	struct subsys_attribute *security_attr =
+	    container_of(attr, struct subsys_attribute, attr);
+
+	if (security_attr->show)
+		security_attr->show(&security_subsys, page);
+	else
+		ima_error("Attr method >show< not defined.\n");
+
+	return (ssize_t) 0;
+}
+
+static ssize_t security_attr_store(struct kobject *kobj,struct attribute *attr,
+				   const char *page, size_t count)
+{
+	/* get security attribute */
+	struct subsys_attribute *security_attr =
+	    container_of(attr, struct subsys_attribute, attr);
+	if (security_attr->store)
+		security_attr->store(&security_subsys, page, count);
+	else
+		ima_error("Attr method >store< not defined.\n");
+
+	return (ssize_t) count;
+}
+
+static struct sysfs_ops security_sysfs_ops = {
+	.show = &security_attr_show,
+	.store = &security_attr_store,
+};
+
+static ssize_t measurements_read(struct subsystem *sub, char *page)
+{
+	char *msg = "Hi There! Read is not supported :-)\n";
+	strncpy(page, msg, PAGE_SIZE);
+	return (strlen(msg));
+}
+
+static ssize_t measurement_store(struct subsystem *sub, const char *page,
+				 size_t count)
+{
+	struct measure_request *mr;
+	struct file *file;
+	int error = -EINVAL;
+
+	atomic_inc(&global_count_sysfs);
+	if (count != sizeof(struct measure_request)) {
+		ima_error("illegal request size (%d, expected %d).\n",
+		       count, sizeof(struct measure_request));
+		return -EIO;
+	}
+	mr = (struct measure_request *) page;
+	if (mr->fd < 0)
+		return -EBADF;
+
+	file = fget(mr->fd);
+	if (!file)
+		return -EACCES;
+	mr->flags = ((mr->flags) & (~FLAG_HOOK_MASK)) || USER_MEASURE_FLAG;
+	/* future: check inode->security to see if measure necessary */ 
+	atomic_inc(&global_count_sysfs_measure);
+	error = measure_file_exec(file, mr);
+	fput(file);
+	if (error)
+		return error;
+	else
+		return (ssize_t) count;	/* length of written data */
+}
+
+static struct subsys_attribute security_attr_measure = {
+	.attr = {.name = "measure",.mode = S_IRUGO | S_IWUGO},
+	.show = measurements_read,
+	.store = measurement_store,
+};
+
+static struct attribute *default_security_attrs[] = {
+	&security_attr_measure.attr,
+	NULL,
+};
+
+static void security_object_release(struct kobject *kobj)
+{
+	return;
+}
+
+static struct kobj_type ktype_security = {
+	.release = security_object_release,
+	.sysfs_ops = &security_sysfs_ops,
+	.default_attrs = default_security_attrs,
+};
+
+/* declare security_subsys. */
+static decl_subsys(security, &ktype_security, NULL);
+
+
+int ima_sysfs_init(void)
+{
+	atomic_set(&global_count_sysfs, 0);
+	atomic_set(&global_count_sysfs_measure, 0);
+	subsystem_register(&security_subsys);
+	subsys_create_file(&security_subsys, &security_attr_measure);
+	return 0;
+}
+
+int ima_sysfs_remove(void)
+{
+	subsys_remove_file(&security_subsys, &security_attr_measure);
+	subsystem_unregister(&security_subsys);
+	return 0;
+}
diff -uprN linux-2.6.12-rc4/security/ima/ima_tpm_glue.c linux-2.6.12-rc4-ima/security/ima/ima_tpm_glue.c
--- linux-2.6.12-rc4/security/ima/ima_tpm_glue.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/ima_tpm_glue.c	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_tpm_glue.c
+ *             implements glue code to connect IMA to the TPM driver
+ *             by protecting new measurements in the TPM PCR
+ *             (glues to tpmdd on www.sourceforge.net/tpmdd)
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include "ima.h"
+
+#define TPM_BUFSIZE 2048
+
+extern struct tpm_chip *ima_used_chip;
+void tpm_extend(int index, const u8 * digest);
+void tpm_pcrread(int index, u8 * hash);
+
+static u32 decode_u32(u8 * buf)
+{
+	u32 val = buf[0];
+	val = (val << 8) | (u8) buf[1];
+	val = (val << 8) | (u8) buf[2];
+	val = (val << 8) | (u8) buf[3];
+	return val;
+}
+
+static void encode_u32(u8 * buf, u32 val)
+{
+	buf[0] = (u8) val >> 24;
+	buf[1] = (u8) val >> 16;
+	buf[2] = (u8) val >> 8;
+	buf[3] = (u8) val >> 0;
+}
+
+static u8 pcrread[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 14,		/* length */
+	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
+	0, 0, 0, 0		/* PCR index */
+};
+
+
+void tpm_pcrread(int index, u8 * hash)
+{
+	u8 data[TPM_BUFSIZE];
+	ssize_t len;
+
+	if (ima_used_chip == NULL)
+		return;
+
+	memcpy(data, pcrread, sizeof(pcrread));
+	encode_u32(data + 10, index);
+	if (((len = tpm_transmit(ima_used_chip, data, sizeof(data))) >= 30) &&
+	    (decode_u32(data + 6) == 0))
+		memcpy(hash, data + 10, 20);
+}
+
+
+static u8 extend[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 34,		/* length */
+	0, 0, 0, 20,		/* TPM_ORD_Extend */
+	0, 0, 0, 0		/* PCR index */
+};
+
+void tpm_extend(int index, const u8 * digest)
+{
+	u8 data[TPM_BUFSIZE];
+	int len;
+
+	if (ima_used_chip == NULL)
+		return;
+
+	memcpy(data, extend, sizeof(extend));
+	encode_u32(data + 10, index);
+	memcpy(data + 14, digest, 20);
+	if (((len = tpm_transmit(ima_used_chip, data, sizeof(data))) < 30) ||
+	    (decode_u32(data + 6) != 0)) {
+		if (!ima_test_mode)
+			panic("IMA: Error Communicating to TPM chip and IMA not in test mode!\n");
+	}
+}
diff -uprN linux-2.6.12-rc4/security/ima/INSTALL linux-2.6.12-rc4-ima/security/ima/INSTALL
--- linux-2.6.12-rc4/security/ima/INSTALL	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/INSTALL	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,124 @@
+File: INSTALL
+
+Installation File for
+IBM Integrity Measurement Architecture
+
+Copyright IBM (c) April 30, 2005
+Author: Reiner Sailer, sailer@watson.ibm.com
+
+For background information, examples, and publications
+   on this topic, please visit:
+   http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
+
+The following instructions work for Fedora Core3 but should be
+generic (you just need a configuration file that works for the kernel)
+
+1. Required kernel configuration options
+========================================
+ a)  crypto->SHA1 is (y)           
+          [IMA needs sha before modules are loaded]
+
+ b)  security->Default Linux Capabilities (n) 
+              [IMA cannot share LSM with the capabilities]
+
+ c)  choose (y) for "TCG run-time Integrity Measurement Architecture"
+              [switchtes IMA measurements on]
+
+ d)  choose (y) for "IMA test mode"
+          This option tells IMA to try to use a real hw TPM or bypass it
+          if in test mode.
+          Choose (y) if you don't have a TPM on your machine or if you 
+	  have a TPM on your machine but you want to test IMA and the
+          dependencies first. In any case, make sure you have a TPM
+          driver with the internal kernel interface patch posted to 
+          LKML 05/2005. If you choose (n) and IMA can't start up for any
+          reason, it will panic the kernel to protect attestation. 
+          If unsure, say (y). Say (y) only after testing.
+   
+ e)  If you'd like to compile SELinux and IMA and choose between
+     them at boot-time then configure:
+     NSA SELinux boot paramter
+         NSA SELinux boot parameter default value to (0)
+          (see 3 for kernel command line options)
+
+
+2. Compile and install the new kernel and initrd
+================================================
+make all; make modules_install; make install
+
+
+3. Change kernel command line options
+=====================================
+to activate the Integrity Measurement Architecture at boot-time, 
+add: 'ima=1', to deactivate use 'ima=0' (default)
+
+If you have both SELinux and IBM IMA support compiled into
+the kernel, then switch at least one of:
+ 'ima=1 selinux=0' activates the Integrity Measurement Architecture
+ 'ima=0 selinux=1' activates SELinux
+
+You can't activate both because the kernel does not
+support LSM stacking.
+
+
+4. Trouble-shooting (restart your system to activate new kernel)
+================================================================
+Use `dmesg |grep IMA` to print IMA status startup information:
+You may find the following output:
+
+   a) you are fine if you see 
+   the following lines (if you have TPM hardware):
+   ----
+   IBM Integrity Measurement Architecture (IBM IMA v2.0 05/18/2005).
+       IMA (test mode)
+   ----
+   or the following lines (if you don't have TPM hardware):
+   ----
+   IBM Integrity Measurement Architecture (IBM IMA v2.0 05/18/2005).
+       IMA (test mode)
+       IMA (TPM/BYPASS - no TPM chip found)
+   ----
+
+   b) you need to add the "ima=1" kernel boot paramter if you see:
+   ---
+   IBM Integrity Measurement Architecture (IBM IMA v2.0 05/18/2005).
+       IMA (not enabled in kernel command line) aborting!
+   ---
+ 
+   c) you need to compile SHA1 support statically into the kernel 
+     (see configuration requirements) if you see:
+   ---
+   IBM Integrity Measurement Architecture (IBM IMA v2.0 05/18/2005).
+       IMA (test mode)
+       IMA (SHA-1/no support) aborting!
+   ---
+
+   d) you need to disable security->Default Linux Capabilities or
+      SELinux  (see configuration requirements) if you see:
+   ---
+   IBM Integrity Measurement Architecture (IBM IMA v2.0 05/18/2005).
+       IMA (test mode)
+       IMA (LSM/not free) aborting!
+   ---
+
+5. Measurement example
+======================
+# cat /proc/ima/measurements
+
+#000: FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF [remeasure] boot_aggregate
+#001: E2594BF3AA97ED8824A84F7D9ADAE054A7BAB788 [clean] nash
+#002: 2A954FC4EBAC54BA26909A5AD52AEE5848425C3F [clean] udev
+#003: BD145AE0CFC2021C065AEAE52355FEFEA741A0E2 [clean] insmod
+#004: 6A82A9D8537E7767CC0DC980912CE2949EEFF265 [remeasure] jbd
+#005: CB3A142617B950CC180E737EE0C4EC9C082A8D7C [remeasure] ext3
+#006: F3B8622110E3979FC4DE41598157C80F5F688AC6 [clean] init
+#007: 5ACBD4089B3BBAD951AD13775B41BB951EAE306C [clean] ld-2.3.5.so
+#008: 99554AD938DB53DDEAF1EFFBE472F05BF5F95878 [clean] libsepol.so.1
+#009: E9114FC95121F4F04EBEEE500107C80732279F87 [clean] libselinux.so.1
+#010: DCDDF67F5239F6E029CA7FA4C1332A7A109A22E2 [clean] libc-2.3.5.so
+#011: F49DD0EA2ED1547B6F1B1BEC085A685404303646 [clean] modprobe
+#012: 645C2BFC2D6EEF4AA807213295948AA0DB048577 [clean] bash
+ ....
+
+
+ 
diff -uprN linux-2.6.12-rc4/security/ima/Kconfig linux-2.6.12-rc4-ima/security/ima/Kconfig
--- linux-2.6.12-rc4/security/ima/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/Kconfig	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,103 @@
+#
+# IBM Integrity Measurement Architecture
+#
+
+#menu "TPM-based Integrity Measurement Architecture"
+
+config IMA_MEASURE
+	bool "TCG run-time Integrity Measurement Architecture"
+	depends on SECURITY && CRYPTO_SHA1 
+	help
+    		To measure executable code running on this 
+		system, say Y. If you say Y, you must disable
+		any other security modules because LSM are 
+		currently not stackable.To actually start IMA,
+		you need to set a kernel boot parameter "ima=1".
+    		If unsure, say N.
+
+config IMA_TEST_MODE
+	bool "IMA test mode"
+	depends on IMA_MEASURE
+	help
+		If you would like to test the measurement 
+		architecture but you do not have a TPM hardware 
+		on your system, say Y. Otherwise say N. If you say
+		Y and IMA does not find a TPM chip it will just bypass
+
+config IMA_MEASURE_PCR_IDX
+	int "PCR for Aggregate (8<= Index <= 15)"
+	depends on IMA_MEASURE
+	range 8 15
+	default 10
+	help
+		This determines the PCR index used for aggregating the
+		measurement list into the TPM hardware.
+		If unsure, use the default 10.
+
+config IMA_MEASURE_INVALIDATE_INDICATION_IDX
+	int "PCR for indicating invalidated PCR (8<= Index <= 15)"
+	depends on IMA_MEASURE
+	range 0 15
+	default 9
+	help
+		This determines the PCR index used to indicate that the
+		main measure pcr IMA_MEASURE_PCR_IDX aggregate has been 
+		invalidated due to suspicious activity. This is just for 
+		easily spotting invalidated IMA_MEASURE_PCR_IDX.
+		The main pcr was invalidated if 
+		IMA_MEASURE_INVALIDATE_INDICATION_IDX is !=0.
+		If unsure, use the default pcr number 9.
+
+config IMA_SKIP_BOOT_AGGREGATE
+	bool "Skip Boot Aggregate Creation"
+	depends on IMA_MEASURE
+	help
+		If y, the usual aggregate over the boot PCRs 
+		of the TPM is not calculated and not added to 
+		the measurement list. If unsure, say N.
+
+config IMA_KMEM_BYPASS_PROTECTION
+	bool "Invalidate PCR on /dev/kmem write"
+	depends on IMA_MEASURE
+	help
+		This setting enforces TPM PCR invalidation if /dev/kmem
+                is written (bypass of measurements possible). Usually,
+                this does not restrict normal systems. 
+		If unsure, say Y.
+
+config IMA_RAM_BYPASS_PROTECTION
+	bool "Invalidate PCR on /dev/ram write"
+	depends on IMA_MEASURE
+	help
+		This setting enforces TPM PCR invalidation if /dev/ram
+                is written (bypass of measurements possible). If you use
+		ramdisk, you might have a problem.
+		If unsure, say N.
+
+config IMA_HD_SD_BYPASS_PROTECTION
+	bool "Invalidate PCR on /dev/hdx /dev/sdx write"
+	depends on IMA_MEASURE
+	help
+		This setting enforces TPM PCR invalidation if /dev/hda,
+		/dev/hdb ... or /dev/sda, /dev/sdb ... are written
+		directly (bypass of measurement dirty flagging possible). 
+		This requires some changes in /etc/rc.sysinit:
+		   * check filesystems readonly (in rc.sysinit add "-n" fsck
+		     option, remove -a where it appears
+		   * switch off swapping (kernel controlled open on rw)
+		otherwise the PCRs will usually be invalidated.
+		If unsure, say N.
+
+config IMA_MEM_BYPASS_PROTECTION
+	bool "Invalidate PCR on /dev/mem write"
+	depends on IMA_MEASURE
+	help
+		This setting enforces TPM PCR invalidation if /dev/mem
+                is written (bypass of measurements possible). X needs
+		currently to write directly to /dev/mem. For client systems,
+		you might want to chose N here. For server systems not running X,
+		it is safe to say yes. 
+		If unsure, say N.
+
+#endmenu
+
diff -uprN linux-2.6.12-rc4/security/ima/Makefile linux-2.6.12-rc4-ima/security/ima/Makefile
--- linux-2.6.12-rc4/security/ima/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/security/ima/Makefile	2005-05-19 17:59:20.000000000 -0400
@@ -0,0 +1,12 @@
+#
+# Makefile for the TCG run-time Measurements
+#
+# Author: sailer@watson.ibm.com
+# adapted to 2.6 kernel
+
+ifdef CONFIG_IMA_MEASURE
+obj-$(CONFIG_IMA_MEASURE) += ima_init.o ima_sysfs.o ima_main.o ima_proc.o \
+				ima_queue.o ima_lsmhooks.o ima_tpm_glue.o
+
+endif
+
diff -uprN linux-2.6.12-rc4/security/Kconfig linux-2.6.12-rc4-ima/security/Kconfig
--- linux-2.6.12-rc4/security/Kconfig	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-ima/security/Kconfig	2005-05-19 17:59:20.000000000 -0400
@@ -86,6 +86,7 @@ config SECURITY_SECLVL
 	  If you are unsure how to answer this question, answer N.
 
 source security/selinux/Kconfig
+source security/ima/Kconfig
 
 endmenu
 
diff -uprN linux-2.6.12-rc4/security/Makefile linux-2.6.12-rc4-ima/security/Makefile
--- linux-2.6.12-rc4/security/Makefile	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-ima/security/Makefile	2005-05-19 17:59:20.000000000 -0400
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_KEYS)			+= keys/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
+subdir-$(CONFIG_IMA_MEASURE)		+= ima
 
 # if we don't select a security model, use the default capabilities
 ifneq ($(CONFIG_SECURITY),y)
@@ -14,6 +15,7 @@ endif
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
+obj-$(CONFIG_IMA_MEASURE)		+= ima/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o






