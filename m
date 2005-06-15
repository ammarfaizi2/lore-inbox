Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVFOOo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFOOo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFOOo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:44:57 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:58317 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261511AbVFOOgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:36:04 -0400
Subject: [PATCH] 3 of 5 IMA: LSM-based measurement code
From: Reiner Sailer <sailer@watson.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@mail.wirex.com>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       Kylene Hall <kylene@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Reiner Sailer <sailer@us.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 10:40:13 -0400
Message-Id: <1118846413.2269.18.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies against linux-2.6.12-rc6-mm1 and provides the main
Integrity Measurement Architecture code (LSM-based).

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---

diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_fs.c linux-2.6.12-rc6-mm1-ima/security/ima/ima_fs.c
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_fs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_fs.c	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,432 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_fs.c
+ *		implemenents imafs 
+ *		for reporting measurement log and userspace measure requests
+ */
+
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/security.h>
+#include <linux/major.h>
+#include <linux/seq_file.h>
+#include <linux/percpu.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <linux/file.h>
+#include <linux/parser.h>
+#include <linux/device.h>
+
+#include "ima.h"
+
+struct measure_request {
+	int fd;
+	u16 label;
+};
+
+extern struct h_table htable;
+
+/* based on selinux pseudo filesystem */
+
+#define TMPBUFLEN 12
+static ssize_t ima_show_htable_value(char __user * buf, size_t count,
+				     loff_t * ppos, atomic_t * val)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, TMPBUFLEN, "%i\n", atomic_read(val));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_show_htable_clean_inode_hits(struct file *filp,
+						char __user * buf,
+						size_t count,
+						loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.clean_inode_hits);
+}
+static struct file_operations ima_htable_clean_inode_hits_ops = {
+	.read = ima_show_htable_clean_inode_hits
+};
+
+static ssize_t ima_show_htable_clean_table_hits(struct file *filp,
+						char __user * buf,
+						size_t count,
+						loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.clean_table_hits);
+}
+static struct file_operations ima_htable_clean_table_hits_ops = {
+	.read = ima_show_htable_clean_table_hits
+};
+
+static ssize_t ima_show_htable_dirty_table_hits(struct file *filp,
+						char __user * buf,
+						size_t count,
+						loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.dirty_table_hits);
+}
+static struct file_operations ima_htable_dirty_table_hits_ops = {
+	.read = ima_show_htable_dirty_table_hits
+};
+
+static ssize_t ima_show_htable_changed_files(struct file *filp,
+					     char __user * buf,
+					     size_t count, loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.changed_files);
+}
+static struct file_operations ima_htable_changed_files_ops = {
+	.read = ima_show_htable_changed_files
+};
+
+static ssize_t ima_show_htable_user_measure(struct file *filp,
+					    char __user * buf,
+					    size_t count, loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.user_measure);
+}
+static struct file_operations ima_htable_user_measure_ops = {
+	.read = ima_show_htable_user_measure
+};
+
+static ssize_t ima_show_htable_kernel_measure(struct file *filp,
+					      char __user * buf,
+					      size_t count, loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos,
+				     &htable.kernel_measure);
+}
+static struct file_operations ima_htable_kernel_measure_ops = {
+	.read = ima_show_htable_kernel_measure
+};
+
+static ssize_t ima_show_htable_violations(struct file *filp,
+					  char __user * buf,
+					  size_t count, loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos, &htable.violations);
+}
+static struct file_operations ima_htable_violations_ops = {
+	.read = ima_show_htable_violations
+};
+
+static ssize_t ima_show_measurements_count(struct file *filp,
+					   char __user * buf,
+					   size_t count, loff_t * ppos)
+{
+	return ima_show_htable_value(buf, count, ppos, &htable.len);
+
+}
+static struct file_operations ima_measurements_count_ops = {
+	.read = ima_show_measurements_count
+};
+
+extern int measure_user_file(struct file *, u32 measure_flags);
+extern int ima_enabled;
+
+enum ima_inos {
+	IMA_ROOT_INO = 1,
+	IMA_MEASURE,		/* userspace measurement request */
+	IMA_MEASUREMENTS,	/* measurement log in binary format */
+	IMA_MEASUREMENTS_COUNT,	/* number of measurements in log */
+	IMA_HTABLE_CLEAN_INODE_HITS,
+	IMA_HTABLE_CLEAN_TABLE_HITS,
+	IMA_HTABLE_DIRTY_TABLE_HITS,
+	IMA_HTABLE_CHANGED_FILES,
+	IMA_HTABLE_USER_MEASURE,
+	IMA_HTABLE_KERNEL_MEASURE,
+	IMA_HTABLE_VIOLATIONS,
+};
+
+#define IMA_MAX_EVENT_SIZE 69
+/* print format: 32bit-le=pcr#||char[20]=digest||flags||filename||'\0'  flags bits: 32-16 application flags, 15-3 kernel flags, 2-0 hook len(filename)<=40*/
+static int print_measure_event_entry(struct measure_entry *e, char *buf,
+				     int count)
+{
+	void *ptr = (void *) buf;
+	int filename_len = strlen(e->file_name);
+
+	/* 1st: PCR used is always the same (config option) in little-endian format */
+	*((u32 *) ptr) = (u32) CONFIG_IMA_MEASURE_PCR_IDX;
+	ptr += 4;
+
+	/* 2nd: SHA1 */
+	memcpy(ptr, e->digest, 20);
+	ptr += 20;
+
+	/* 3rd: flags */
+	*((u32 *)ptr) = e->measure_flags;
+	ptr += 4;
+
+	/* 4th:  filename <= 40 + \'0' delimiter */
+	if (filename_len > TCG_EVENT_NAME_LEN_MAX)
+		filename_len = TCG_EVENT_NAME_LEN_MAX;
+
+	memcpy(ptr, e->file_name, filename_len);
+	ptr += filename_len;
+
+	/* 4th: delimiter */
+	*((char *) ptr) = '\0';
+	ptr += 1;
+
+	return ((u32) ptr - (u32) buf);
+}
+
+/* Position pointer is overrided to mean entry # rather than size in bytes */
+static ssize_t ima_measurements_read(struct file *filp, char __user * buf,
+				     size_t count, loff_t * ppos)
+{
+	struct queue_entry *qe;
+	char *tmpbuf;
+	int tmpsiz, i, ret = 0, len;
+	loff_t pos = 0;
+
+	if (count < 0)
+		return -EINVAL;
+
+	tmpsiz = (count < PAGE_SIZE) ? count : PAGE_SIZE;
+	tmpbuf = kmalloc(tmpsiz, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+
+	down(&h_table_mutex);
+
+	/* fast forward to correct measurement for requested position */
+	for (qe = first_measurement, i = 0; qe && qe->entry && i < *ppos;
+	     qe = qe->later, i++);
+
+
+	/* make sure the next entry fits completely */
+	while ((tmpsiz >= IMA_MAX_EVENT_SIZE) && qe && qe->entry) {
+		/* now fill rest of page */
+		len =
+		    print_measure_event_entry(qe->entry, tmpbuf + ret,
+					      count);
+		qe = qe->later;
+		tmpsiz -= len;
+		ret += len;
+		*ppos += 1;
+	}
+	up(&h_table_mutex);
+	len = simple_read_from_buffer(buf, count, &pos, tmpbuf, ret);
+
+	kfree(tmpbuf);
+	return len;
+}
+
+static ssize_t ima_measure_write(struct file *file,
+				 const char __user * buf, size_t count,
+				 loff_t * ppos)
+{
+	struct measure_request *mr;
+	struct file *meas_file;
+	int error = -EINVAL;
+	char tmpbuf[sizeof(struct measure_request)];
+
+	atomic_inc(&htable.user_measure);
+	if (count != sizeof(struct measure_request)) {
+		ima_error("illegal request size (%d, expected %d).\n",
+			  count, sizeof(struct measure_request));
+		return -EIO;
+	}
+
+	if (copy_from_user(tmpbuf, buf, count)) {
+		ima_error("trouble copying request\n");
+		return -EIO;
+	}
+
+	mr = (struct measure_request *) tmpbuf;
+	if (mr->fd < 0) {
+		ima_error("bad descriptor request\n");
+		return -EBADF;
+	}
+
+	meas_file = fget(mr->fd);
+	if (!meas_file) {
+		ima_error("could not open request\n");
+		return -EACCES;
+	}
+
+	error = measure_user_file(meas_file, (u32)(((mr->label) << 16) | USER_MEASURE_FLAG));
+	fput(meas_file);
+	if (error) {
+		ima_error("problem measuring request\n");
+		return error;
+	} else
+		return count;
+}
+
+static struct file_operations ima_measure_ops = {
+	.write = ima_measure_write,
+};
+
+static struct file_operations ima_measurements_ops = {
+	.read = ima_measurements_read
+};
+
+enum { Opt_uid, Opt_gid };
+
+static match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"}
+};
+
+static int ima_remount(struct super_block *sb, int *flags, char *data)
+{
+	char *p;
+	int option;
+	int changed = 0, uid = 0, gid = 0;
+	struct inode *inode;
+
+	if (!data)
+		return 0;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+
+		case Opt_uid:
+			if (match_int(args, &option))
+				return -EINVAL;
+			uid = option;
+			changed = 1;
+			break;
+
+		case Opt_gid:
+			if (match_int(args, &option))
+				return -EINVAL;
+			gid = option;
+			changed = 1;
+			break;
+
+		default:
+			ima_error("ima_fs: unrecognized mount option\n");
+			return -EINVAL;
+		}
+	}
+
+	if (changed) {
+		list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+			inode->i_uid = uid;
+			inode->i_gid = gid;
+		}
+	}
+
+	return 0;
+}
+
+/* imafs Filenames and Permissions are set here -- Double CHECK */
+static int ima_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr ima_files[] = {
+		[IMA_MEASURE] =
+		    {"measurereq", &ima_measure_ops, S_IWUSR | S_IWGRP},
+		[IMA_MEASUREMENTS] =
+		    {"binary_measurements", &ima_measurements_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_MEASUREMENTS_COUNT] =
+		    {"binary_measurements_count",
+		     &ima_measurements_count_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_CLEAN_INODE_HITS] =
+		    {"clean_inode_hits", &ima_htable_clean_inode_hits_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_CLEAN_TABLE_HITS] =
+		    {"clean_hashtable_hits",
+		     &ima_htable_clean_table_hits_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_DIRTY_TABLE_HITS] =
+		    {"dirty_hashtable_hits",
+		     &ima_htable_dirty_table_hits_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_CHANGED_FILES] =
+		    {"changed_files", &ima_htable_changed_files_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_USER_MEASURE] =
+		    {"user_count", &ima_htable_user_measure_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_KERNEL_MEASURE] =
+		    {"kernel_count", &ima_htable_kernel_measure_ops,
+		     S_IRUSR | S_IRGRP},
+		[IMA_HTABLE_VIOLATIONS] =
+		    {"violations", &ima_htable_violations_ops,
+		     S_IRUSR | S_IRGRP},
+
+		/* last one */ {""}
+	};
+
+	return simple_fill_super(sb, IMA_MAGIC, ima_files);
+}
+
+static struct super_block *ima_get_sb(struct file_system_type *fs_type,
+				      int flags, const char *dev_name,
+				      void *data)
+{
+	struct super_block *sb;
+	sb = get_sb_single(fs_type, flags, data, ima_fill_super);
+
+	sb->s_op->remount_fs = ima_remount;
+
+	return sb;
+}
+
+static struct file_system_type ima_fs_type = {
+	.name = "imafs",
+	.get_sb = ima_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+struct vfsmount *imafs_mount;
+
+void ima_fs_init(void)
+{
+	int err;
+
+	if (!ima_enabled)
+		return;
+
+	err = register_filesystem(&ima_fs_type);
+	if (!err) {
+		imafs_mount = kern_mount(&ima_fs_type);
+		if (IS_ERR(imafs_mount)) {
+			ima_error("imafs:  could not mount!\n");
+			err = PTR_ERR(imafs_mount);
+			imafs_mount = NULL;
+		}
+	}
+	return;
+}
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima.h linux-2.6.12-rc6-mm1-ima/security/ima/ima.h
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima.h	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,242 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+#include <linux/major.h>
+#include <linux/crypto.h>
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
+/* if you cannot tolerate panic for the sake of attestation guarantees,
+ * then redefine IMA_PANIC to, e g., ima_error (see INSTALL documentation) */
+#define IMA_PANIC   \
+	panic
+
+/* set during registering as lsm */
+extern unsigned char ima_terminating;
+void invalidate_pcr(char *);
+
+#define IMA_MEASURE_MODULE_NAME	"IMA"
+#define TCG_EVENT_NAME_LEN_MAX	40
+
+/* file systems we expect to change without
+ * our inode_permission hook being called (nfs, remote fs) */
+#define NFS_SUPER_MAGIC		0x6969
+
+/* file systems we won't measure */
+#define IMA_MAGIC 		0x9999
+
+/* Flags for measurement entries (identifying hook) */
+#define FLAG_HOOK_MASK		0x0f
+#define MMAP_MEASURE_FLAG 	0x01
+#define MODULE_MEASURE_FLAG 	0x02
+#define USER_MEASURE_FLAG 	0x04
+
+#define MEASURE_HTABLE_SIZE	512
+#define HASH_KEY(inode_number) ((inode_number) % MEASURE_HTABLE_SIZE)
+#define SHA_KEY(sha_value) (((sha_value)[18] << 8 | (sha_value)[19]) % MEASURE_HTABLE_SIZE)
+typedef enum { CLEAN, DIRTY, CHANGED } ima_entry_flags;
+
+/* security structure appended to inodes */
+struct ima_inode {
+	atomic_t measure_count;	/* # processes currently using this file in measure-mode */
+	ima_entry_flags dirty;
+};
+
+/* security structure appended to measured files*/
+struct ima_file {
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
+struct measure_entry {
+	u32 measure_flags;
+	unsigned long inode_nr;
+	dev_t dev_id;
+	ima_entry_flags dirty;
+	u8 digest[20];				  /* sha1 measurement hash */
+	char file_name[TCG_EVENT_NAME_LEN_MAX+1]; /* name + \0 */
+	struct super_block *super_block;	/* super block link (for umount-dirty flagging) */
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
+	atomic_t user_measure; /* # measurements requested from userspace */
+	atomic_t kernel_measure; /* # measurements performed from kernel */
+	atomic_t clean_inode_hits; /* times we find an inode clean when measuring */
+	atomic_t clean_table_hits; /* times we find a clean htable hit */
+	atomic_t dirty_table_hits; /* times we find a dirty htable hit */
+	atomic_t changed_files;	 /* times we realize a dirty marked entry really changed */
+	atomic_t violations;
+	unsigned int max_htable_size;
+	struct queue_entry *queue[MEASURE_HTABLE_SIZE];
+	atomic_t queue_len[MEASURE_HTABLE_SIZE];
+};
+
+struct sha_table {
+	atomic_t len;
+	unsigned int max_htable_size;
+	struct sha_entry *queue[MEASURE_HTABLE_SIZE];
+	atomic_t queue_len[MEASURE_HTABLE_SIZE];
+};
+
+#define MEM_MINOR	1
+#define KMEM_MINOR	2
+#ifdef CONFIG_IMA_KMEM_BYPASS_PROTECTION
+static inline void check_kmem_bypass(struct inode *inode)
+{
+	if ((imajor(inode) == MEM_MAJOR) 
+	    && S_ISCHR(inode->i_mode) && (iminor(inode) == KMEM_MINOR))
+		invalidate_pcr("/dev/kmem write violation");
+}
+#else
+static inline void check_kmem_bypass(struct inode *inode)
+{
+	return;
+}
+#endif
+
+#ifdef CONFIG_IMA_MEM_BYPASS_PROTECTION
+static inline void check_mem_bypass(struct inode *inode)
+{
+	if ((imajor(inode) == MEM_MAJOR) 
+	    && S_ISCHR(inode->i_mode) && (iminor(inode) == MEM_MINOR))
+		invalidate_pcr("/dev/mmem write violation");
+}
+#else
+static inline void check_mem_bypass(struct inode *inode)
+{
+	return;
+}
+#endif
+
+#ifdef CONFIG_IMA_RAM_BYPASS_PROTECTION
+static inline void check_ram_bypass(struct inode *inode)
+{
+	if ((imajor(inode) == RAMDISK_MAJOR) && S_ISBLK(inode->i_mode))
+		invalidate_pcr("/dev/ram write violation");
+}
+#else
+static inline void check_ram_bypass(struct inode *inode)
+{
+	return;
+}
+#endif
+
+#ifdef CONFIG_IMA_HD_SD_BYPASS_PROTECTION
+static inline void check_hd_sd_bypass(struct inode *inode)
+{
+	if ((imajor(inode) == HD_MAJOR) && S_ISBLK(inode->i_mode))
+		invalidate_pcr("/dev/hdx write violation");
+	else if ((imajor(inode) == SCSI_DISK0_MAJOR) && S_ISBLK(inode->i_mode))
+		invalidate_pcr("/dev/sdx write violation");
+}
+#else
+static inline void check_hd_sd_bypass(struct inode *inode)
+{
+	return;
+}
+#endif
+
+/* configuration options*/
+extern int ima_test_mode;
+extern int skip_boot_aggregate;
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
+
+#endif
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_init.c linux-2.6.12-rc6-mm1-ima/security/ima/ima_init.c
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_init.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_init.c	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer      <sailer@watson.ibm.com>
+ *
+ * Contributions:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+#include "ima_tpm_pcrread.h"
+#include "ima_tpm_extend.h"
+
+/* name for boot aggregate entry */
+char *boot_aggregate_name = "boot_aggregate";
+
+extern struct h_table htable;
+
+/* These identify the driver base version and may not be removed. */
+static const char version[] = "v4.0 06/15/2005";
+static const char illegal_pcr[20] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+
+/* configuration parameters */
+int ima_test_mode;
+int skip_boot_aggregate;
+
+void create_htable(void);
+void create_sha_htable(void);
+void ima_lsm_init(void);
+void ima_fs_init(void);
+int ima_add_measure_entry(struct measure_entry *);
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
+	entry->inode_nr = 0;	/* 0,0 are special (no files) */
+	entry->dev_id = 0;
+	entry->measure_flags = 0;
+	entry->dirty = DIRTY;
+	entry->super_block = NULL;
+	memset(entry->digest, 0, 20);
+	if ((count = strlen(boot_aggregate_name)) > TCG_EVENT_NAME_LEN_MAX)
+		count = TCG_EVENT_NAME_LEN_MAX;
+	memcpy(entry->file_name, boot_aggregate_name, count);
+	entry->file_name[count] = '\0';	/* ez-print */
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
+	/* now add measurement; if TPM bypassed, we have a ff..ff entry */
+	if (ima_add_measure_entry(entry) < 0) {
+		kfree(entry);
+		invalidate_pcr("error adding boot aggregate");
+	} else
+		tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, entry->digest);
+}
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
+	atomic_inc(&htable.violations); /* can overflow into 0; this is an indicator only */
+}
+
+
+static int __init measure_init(void)
+{
+	struct security_operations null_ops;
+
+	printk(KERN_INFO "IBM Integrity Measurement Architecture (IBM IMA %s).\n", 
+	       version);
+	read_configs();
+
+	/* check pre-conditions and dependencies */
+	if (!ima_test_mode)
+		ima_enabled = 1;	/* unconditionally */
+	else {
+		if (!ima_enabled) {
+			printk(KERN_INFO "    IMA (not enabled in kernel command line) aborting!\n");
+			return 0;
+		}
+		printk(KERN_INFO "    IMA (test mode)\n");
+	}
+	ima_used_chip = tpm_chip_lookup(0);
+	if (ima_used_chip == NULL) {
+		if (ima_test_mode)
+			printk(KERN_INFO "    IMA (TPM/BYPASS - no TPM chip found)\n");
+		else
+			/* no way to invalidate pcr and inform remote party */
+			IMA_PANIC("IMA: TPM/no support and IMA not in test mode!\n");
+	}
+	/* check for LSM availability */
+	memset(&null_ops, 0, sizeof(struct security_operations));
+	if (!register_security(&null_ops))
+		unregister_security(&null_ops);
+	else {
+		if (ima_test_mode) {
+			ima_enabled = 0;
+			printk(KERN_INFO "    IMA (LSM/not free) aborting!\n");
+			return -EFAULT;
+		} else
+			invalidate_pcr("LSM/not free in real mode!\n");
+	}
+	create_htable(); /* for measurements */
+	create_sha_htable();
+	/* boot aggregate must be very first entry */
+	if (!skip_boot_aggregate)
+		ima_add_boot_aggregate();
+	ima_lsm_init();
+	ima_fs_init();
+	return 0;
+}
+
+__initcall(measure_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Reiner Sailer <sailer@watson.ibm.com>");
+MODULE_DESCRIPTION
+    ("Run-time LSM-based IBM Integrity Measurement Architecture");
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_lsmhooks.c linux-2.6.12-rc6-mm1-ima/security/ima/ima_lsmhooks.c
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_lsmhooks.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_lsmhooks.c	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+extern struct h_table htable;
+
+/* if set, then hooks do nothing 
+ * (controls non-lsm module hook as well) */
+unsigned char ima_terminating = 1;
+
+struct measure_entry *ima_lookup_measure_entry(unsigned long, dev_t);
+void measure_mmap_file(struct file *, u32 flags);
+int measure_dirty_flag_super(struct super_block *);
+
+/* measure files mmapped with exec permission */
+int ima_file_mmap(struct file *file, unsigned long reqprot, unsigned long prot, unsigned long flags)
+{
+	/* filter interesting calls that actually map files executable */
+	if (!(reqprot & PROT_EXEC))
+		return 0;
+
+	/* now check protection  */
+	if (reqprot & MAP_SHARED & PROT_EXEC & PROT_WRITE) {
+		ima_error("MMAP protection flag error!!!\n");
+		invalidate_pcr("MMAP protection flag violation!");
+	}
+	atomic_inc(&htable.kernel_measure);
+	measure_mmap_file(file, (u32)MMAP_MEASURE_FLAG);
+	/* IMA is non-intrusive, so we always map */
+	return 0;
+}
+
+/* dirty flags on open with MAY_WRITE|MAY_APPEND */
+int ima_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct ima_inode *i_security = NULL;
+	struct measure_entry *entry;
+
+	/* dirty-flagging applies to changing files */
+	if (!(mask & (MAY_WRITE | MAY_APPEND)) || !inode)
+		return 0;
+	
+	/* general checks against bypassing dirty-flagging */
+	check_kmem_bypass(inode);
+	check_mem_bypass(inode);
+	check_ram_bypass(inode);
+	check_hd_sd_bypass(inode);
+	
+	/* files that are written to are usually not executed (measured),
+	   optimize this path */
+	down(&h_table_mutex);
+	if ((entry = ima_lookup_measure_entry(inode->i_ino, inode->i_rdev)) == NULL)
+		goto out; /* not a measured file */
+	if (entry->dirty == CLEAN)
+		entry->dirty = DIRTY;
+	/* dirty flag inode */
+	if ((i_security = ima_get_inode_security(inode)) != NULL) {
+		if (atomic_read(&(i_security->measure_count))) {
+			/* write permission on measured file was granted! */
+			invalidate_pcr("ToMToU violation");
+			ima_error("VIOLATION: Writing to measured file (%s) while it is being used!\n", 
+				  entry->file_name);	
+		}
+		if (i_security->dirty == CLEAN)
+			i_security->dirty = DIRTY;
+	}
+ out:
+	up(&h_table_mutex);
+	return 0;
+}
+
+/* dirty flag files on an umounted file system */
+static int ima_sb_umount(struct vfsmount *mnt, int flags)
+{
+	/* mark all clean entries with this superblock dirty */
+	struct queue_entry *qe;
+	struct super_block *super = mnt->mnt_sb;
+	int j;
+
+	down(&h_table_mutex);
+	for (j = 0; j < htable.max_htable_size; j++) {
+		qe = htable.queue[j];
+		while (qe != NULL) {
+			if (qe->entry->super_block == super)
+				if (qe->entry->dirty == CLEAN)
+					qe->entry->dirty = DIRTY;
+			qe = qe->next;
+		}
+	}
+	up(&h_table_mutex);
+	return 0;
+}
+
+/* free security structure if applies */
+static void ima_inode_free_security(struct inode *inode)
+{
+	struct ima_inode *i_security = ima_get_inode_security(inode);
+
+	if (i_security) {
+		kfree(i_security);
+		ima_store_inode_security(inode, NULL);
+	}
+}
+
+static void ima_file_free_security(struct file *file)
+{
+	struct ima_file *f_security;
+	struct ima_inode *i_security = NULL;
+
+	if ((f_security = ima_get_file_security(file)) == NULL)
+		return;
+	/* decrease measure count if file is measured */
+	i_security = ima_get_inode_security(file->f_dentry->d_inode);
+	if (i_security && (f_security->is_measuring))
+			atomic_dec(&(i_security->measure_count));
+	kfree(f_security);
+	ima_store_file_security(file, NULL);
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
+	/* module measurement hook becomes hot */
+	ima_terminating = 0;
+}
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_main.c linux-2.6.12-rc6-mm1-ima/security/ima/ima_main.c
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_main.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_main.c	2005-06-14 21:58:13.000000000 -0400
@@ -0,0 +1,462 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+#include <linux/stat.h>
+
+#include "ima.h"
+#include "ima_tpm_extend.h"
+
+extern struct h_table htable;
+extern struct sha_table sha_htable;
+
+struct sha_entry *ima_lookup_sha_entry(u8 * sha_value);
+struct measure_entry *ima_lookup_measure_entry(unsigned long, dev_t);
+int ima_add_measure_entry(struct measure_entry *);
+int measure_dirty_flag_inode(struct inode *);
+extern struct tpm_chip *ima_used_chip;
+
+DEFINE_SPINLOCK(ima_measure_file_lock);
+
+/* 
+ * Returns the dirty flag setting for an inode
+ * (nfs, since we don't control changes)
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
+/* returns >0 if measurement must be skipped
+ * returns =0 if measurement allowed 
+ */
+static inline int skip_measurement(struct inode *inode)
+{
+	/* measuring only regular files; can't measure IMA files */
+	if (S_ISREG(inode->i_mode) && (inode->i_sb->s_magic != IMA_MAGIC))
+		return 0;       	/* measure */
+	else
+		return 1;       	/* skip */	
+}
+
+
+/*  measures new file and adds it to measurement list */
+static struct measure_entry *do_measure_file(struct file *file, struct inode *inode)
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
+	entry->inode_nr = inode->i_ino;
+	entry->dev_id = inode->i_rdev;
+	entry->dirty = get_default_dirty_setting(inode);
+	entry->super_block = inode->i_sb;
+	if ((count = file->f_dentry->d_name.len) > TCG_EVENT_NAME_LEN_MAX)
+		count = TCG_EVENT_NAME_LEN_MAX;
+	memcpy(entry->file_name, file->f_dentry->d_name.name, count);
+	entry->file_name[count] = '\0';	/* ez-print */
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
+		i_security->dirty = entry->dirty;
+	} else {
+		ima_error("error No security structure in measure!\n");
+		goto outm;
+	}
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
+	return (NULL);
+}
+
+/* measure memory (kernel module; still the exact copy of the object file) */
+int do_measure_memory(void *start, unsigned long len, u32 measure_flags, char *name)
+{
+	struct crypto_tfm *tfm;
+	u8 mem_digest[20];
+	int error = 0;
+	struct measure_entry *entry;
+	int count;
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
+		entry->inode_nr = 0;	/* special entries, no file entries */
+		entry->dev_id = 0;
+		entry->dirty = DIRTY;
+		entry->super_block = NULL;
+		memcpy(entry->digest, mem_digest, 20);
+		if ((count = strlen(name)) > TCG_EVENT_NAME_LEN_MAX)
+			count = TCG_EVENT_NAME_LEN_MAX;
+		strncpy(entry->file_name, name, count);
+		entry->file_name[count] = '\0';
+		entry->measure_flags = measure_flags;
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
+
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
+	atomic_inc(&htable.kernel_measure); /* CHECK */
+	do_measure_memory(start, len, (u32)MODULE_MEASURE_FLAG, mod->name);
+	return;
+}
+
+
+
+static void measure_file (struct file *file, u32 measure_flags, struct inode *inode, struct ima_inode *i_security)
+{
+	struct measure_entry *entry, *new_entry;
+
+	down(&h_table_mutex);
+	entry = ima_lookup_measure_entry(inode->i_ino, inode->i_rdev);
+	if ((entry != NULL) && (entry->dirty == CLEAN)) {
+		i_security->dirty = CLEAN;
+		atomic_inc(&htable.clean_table_hits);
+		goto out; /* done */
+	}
+	new_entry = do_measure_file(file, inode);
+	/* now we adjust the entry table:
+	 * -- if there was no entry, we just add the new one
+	 * -- if there was one but different hash, we add the new one
+	 * -- if there was one and same hash, we clear dirty bit on existing one
+	 */
+	if (!new_entry) {
+		/* internal error, make sure attestation fails from now on */
+		invalidate_pcr("error measuring file");
+		goto out;
+	}
+	new_entry->measure_flags = measure_flags;
+	if (entry == NULL) {	/* no old entry for this inode found */
+		/* add if this hash is new (i.e., no copy measured yet) */
+		if (!ima_lookup_sha_entry(new_entry->digest)) {
+			if (ima_add_measure_entry(new_entry) < 0) {
+				kfree(new_entry);
+				invalidate_pcr("error adding measurement entry");
+			} else	
+				tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, new_entry->digest);
+		}
+		goto out;
+	}
+	/* old entry exists (!= clean) */
+	if (!memcmp(entry->digest, new_entry->digest, 20)) {
+		/* set with default (no clean-flag for nfs) */
+		entry->dirty = get_default_dirty_setting(inode);
+		i_security->dirty = entry->dirty;
+		atomic_inc(&htable.dirty_table_hits);
+		kfree(new_entry);
+	} else {
+		/* dirty and look whether to add new entry */
+		entry->dirty = CHANGED;
+		atomic_inc(&htable.changed_files);
+		if (!ima_lookup_sha_entry(new_entry->digest)) {
+			if (ima_add_measure_entry(new_entry) < 0) {
+				kfree(new_entry);
+				invalidate_pcr("error adding measurement entry");
+			} else
+				tpm_extend(CONFIG_IMA_MEASURE_PCR_IDX, new_entry->digest);
+		}
+	}
+ out:
+	up(&h_table_mutex);
+}
+
+
+/* Measure user space file descriptor, protect file from being
+ * written until all measureing processes have closed the file
+ */
+int measure_user_file(struct file *file, u32 measure_flags)
+{
+	struct inode *inode;
+	struct ima_file *f_security = NULL;
+	struct ima_inode *i_security = NULL;
+
+	if (!file || !file->f_op || !file->f_dentry || !file->f_dentry->d_inode)
+		return -EACCES;
+
+	inode = file->f_dentry->d_inode;
+
+	/* here we skip unnecessary measurements */
+	if (skip_measurement(inode))
+		return -EACCES; /* not allowed to measure; user apps to handle error */
+ 
+	/* a) if there is already a writer on this file --> error! */
+	if (atomic_read(&(inode->i_writecount)) > 0) {
+		struct measure_entry *entry;
+		invalidate_pcr("ToMToU violation");
+		down(&h_table_mutex);
+		entry = ima_lookup_measure_entry(inode->i_ino, inode->i_rdev);
+		ima_error("VIOLATION: Measured file (%s) has writers!\n",
+			  (entry != NULL) ? entry->file_name : "most likely measuring file opened rw");
+		up(&h_table_mutex);
+		return -EACCES;
+	}
+	inode = file->f_dentry->d_inode;
+	/* mark this file as measuring (increases measurement-refcount on inode) */
+	if ((f_security = ima_get_file_security(file)) != NULL) {
+		i_security = ima_get_inode_security(file->f_dentry->d_inode);
+		if (i_security == NULL) {
+			invalidate_pcr("Internal error (f_security not free but no i_security).\n");
+			return -EFAULT;
+		}
+	} else {
+		/* create f_security and if necessary i_security */
+		f_security = kmalloc(sizeof(struct ima_file), GFP_KERNEL);
+		if (f_security == NULL) {
+			invalidate_pcr("out of memory error");
+			return -ENOMEM;
+		} else {
+			f_security->is_measuring = 1;
+			ima_store_file_security(file, f_security);
+		}
+		/* we maintain an inode copy of clean etc. to speed up clean hits */
+		i_security = ima_get_inode_security(inode);
+		if (i_security != NULL)
+			atomic_inc(&(i_security->measure_count));
+		else {
+			spin_lock(&ima_measure_file_lock);
+			if ((i_security = ima_get_inode_security(inode)))
+				goto dontalloc;
+			i_security =
+				kmalloc(sizeof(struct ima_inode), GFP_KERNEL);
+			if (i_security == NULL) {
+				spin_unlock(&ima_measure_file_lock);
+				invalidate_pcr("out of memory error");
+				return -EFAULT;
+			} else {
+				i_security->dirty = DIRTY;
+				/* is reset later after measuring file */
+				atomic_set(&(i_security->measure_count), 1);
+				ima_store_inode_security(inode, i_security);
+			}
+dontalloc:
+			spin_unlock(&ima_measure_file_lock);	
+		}
+	}
+	/* catch most cases */
+	if (i_security->dirty == CLEAN)
+		atomic_inc(&htable.clean_inode_hits);
+	else
+		measure_file(file, measure_flags, inode, i_security);
+	return 0;
+}
+
+
+/* Measure files mapped as executable */
+void measure_mmap_file(struct file *file, u32 measure_flags)
+{
+	struct inode *inode;
+	struct ima_inode *i_security = NULL;
+
+	if (!file || !file->f_op || !file->f_dentry || !file->f_dentry->d_inode)
+		return;
+	
+	inode = file->f_dentry->d_inode;
+
+	/* here we skip non-allowed measurements */
+	if (skip_measurement(inode))
+		return;
+
+	/* if there is already a writer on this file --> error! */
+	if (atomic_read(&(inode->i_writecount)) > 0) {
+		invalidate_pcr("Measured file has writers.");
+		return;
+	}
+	/* we maintain an inode copy of clean etc. to speed up clean hits */
+	i_security = ima_get_inode_security(inode);
+	if (!i_security) {
+		spin_lock(&ima_measure_file_lock);
+		if ((i_security = ima_get_inode_security(inode)))
+			goto dontalloc;
+		i_security = kmalloc(sizeof(struct ima_inode), GFP_KERNEL);
+		if (i_security == NULL) {
+			spin_unlock(&ima_measure_file_lock);
+			invalidate_pcr("out of memory error");
+			return;
+		} else {
+			i_security->dirty = DIRTY;
+			/* is reset later after measuring file */
+			atomic_set(&(i_security->measure_count), 0);
+			ima_store_inode_security(inode, i_security);
+		}
+dontalloc:
+		spin_unlock(&ima_measure_file_lock);
+	}
+	/* catch most cases */
+	if (i_security->dirty == CLEAN)
+		atomic_inc(&htable.clean_inode_hits);
+	else
+		measure_file(file, measure_flags, inode, i_security);
+}
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_queue.c linux-2.6.12-rc6-mm1-ima/security/ima/ima_queue.c
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_queue.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_queue.c	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,185 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+	for (i = 0; i < sha_htable.max_htable_size; i++) {
+		sha_htable.queue[i] = NULL;
+		atomic_set(&sha_htable.queue_len[i], 0);
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
+	atomic_set(&htable.user_measure, 0);
+	atomic_set(&htable.kernel_measure, 0);
+	atomic_set(&htable.clean_inode_hits, 0);
+	atomic_set(&htable.clean_table_hits, 0);
+	atomic_set(&htable.dirty_table_hits, 0);
+	atomic_set(&htable.changed_files, 0);
+	atomic_set(&htable.violations, 0);
+	htable.max_htable_size = MEASURE_HTABLE_SIZE;
+	for (i = 0; i < htable.max_htable_size; i++) {
+		htable.queue[i] = NULL;
+		atomic_set(&htable.queue_len[i], 0);
+	}
+	up(&h_table_mutex);
+}
+
+/* 
+ * also sets clean and dirty table hit marks 
+ */
+struct measure_entry *ima_lookup_measure_entry(unsigned long inode_number, dev_t dev_number)
+{
+	struct queue_entry *qe;
+	struct measure_entry *me;
+
+	/* fill in later */
+	qe = htable.queue[HASH_KEY(inode_number)];
+	while ((qe != NULL) && ((qe->entry->inode_nr != inode_number)
+				|| (qe->entry->dev_id != dev_number)))
+		qe = qe->next;
+
+	if (qe != NULL) {
+		if (qe->entry->dirty != CLEAN)
+			atomic_inc(&htable.dirty_table_hits);
+		else
+			atomic_inc(&htable.clean_table_hits);
+
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
+	key = SHA_KEY(sha_value);
+	se = sha_htable.queue[key];
+	while ((se != NULL) && (memcmp(se->digest, sha_value, 20)))
+		se = se->next;
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
+	/* calculate key */
+	key = HASH_KEY(entry->inode_nr);
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
+	atomic_inc(&htable.queue_len[key]);
+	/* update later list */
+	if (first_measurement == NULL)
+		first_measurement = qe;
+	else
+		latest_measurement->later = qe;
+	
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
+	atomic_inc(&sha_htable.queue_len[key]);
+	/* update later list */
+	atomic_inc(&sha_htable.len);
+	return 0;
+
+      out:
+	ima_error("OUT OF MEMORY ERROR creating queue entry.\n");
+	return -ENOMEM;
+}
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_tpm_extend.h linux-2.6.12-rc6-mm1-ima/security/ima/ima_tpm_extend.h
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_tpm_extend.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_tpm_extend.h	2005-06-14 20:32:39.000000000 -0400
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_tpm_extend.h
+ *             implements glue code to connect IMA to the TPM driver
+ *             (glues to tpmdd on www.sourceforge.net/tpmdd)
+ */
+#ifndef __LINUX_IMA_TPM_EXTEND_H
+#define __LINUX_IMA_TPM_EXTEND_H
+
+#define TPM_BUFSIZE 2048
+
+extern struct tpm_chip *ima_used_chip;
+
+static const u8 extend[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 34,		/* length */
+	0, 0, 0, 20,		/* TPM_ORD_Extend */
+	0, 0, 0, 0		/* PCR index */
+};
+
+static void tpm_extend(int index, const u8 * digest)
+{
+	u8 *data;
+	u32 i;
+	int len;
+
+	if (ima_used_chip == NULL)
+		return;
+
+	if ((data = kmalloc(TPM_BUFSIZE, GFP_KERNEL)) == NULL)
+		goto error;
+
+	memcpy(data, extend, sizeof(extend));
+	i = cpu_to_be32(index);
+	memcpy(data+10, &i, 4);
+	memcpy(data + 14, digest, 20);
+	if ((len = tpm_transmit(ima_used_chip, data, TPM_BUFSIZE)) >= 30) {
+		memcpy(&i, data + 6, 4); /* return code */
+		if (be32_to_cpu(i) == 0)
+			goto out; /* ok */
+	}
+ error:
+	if (!ima_test_mode)
+		IMA_PANIC("IMA: Error Communicating to TPM chip and IMA not in test mode!\n");
+	else
+		ima_error("Error Communicating to TPM chip\n");
+ out:
+	if (data != NULL)
+		kfree(data);
+}
+
+#endif
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/ima_tpm_pcrread.h linux-2.6.12-rc6-mm1-ima/security/ima/ima_tpm_pcrread.h
--- linux-2.6.12-rc6-mm1_orig/security/ima/ima_tpm_pcrread.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/ima_tpm_pcrread.h	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_tpm_pcrread.h
+ *             implements glue code to connect IMA to the TPM driver
+ *             (glues to tpmdd on www.sourceforge.net/tpmdd)
+ */
+#ifndef __LINUX_IMA_TPM_PCRREAD_H
+#define __LINUX_IMA_TPM_PCRREAD_H
+
+#define TPM_BUFSIZE 2048
+
+extern struct tpm_chip *ima_used_chip;
+
+static const u8 pcrread[] = {
+	0, 193,			/* TPM_TAG_RQU_COMMAND */
+	0, 0, 0, 14,		/* length */
+	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
+	0, 0, 0, 0		/* PCR index */
+};
+
+
+static void tpm_pcrread(int index, u8 * hash)
+{
+	u8 *data;
+	u32 i;
+	ssize_t len;
+
+	if (ima_used_chip == NULL)
+		return;
+
+	if ((data = kmalloc(TPM_BUFSIZE, GFP_KERNEL)) == NULL)
+		goto error;
+
+	memcpy(data, pcrread, sizeof(pcrread));
+	i = cpu_to_be32(index);
+	memcpy(data+10, &i, 4);
+	if ((len = tpm_transmit(ima_used_chip, data, TPM_BUFSIZE)) >= 30) {
+		memcpy(&i, data + 6, 4); /* return code */
+		if (be32_to_cpu(i) == 0) {
+			memcpy(hash, data + 10, 20);
+			goto out; /* ok */
+		}
+	}
+ error:
+	if (!ima_test_mode)
+		IMA_PANIC("IMA: Error Communicating to TPM chip and IMA not in test mode!\n");
+	else
+		ima_error("Error Communicating to TPM chip\n");
+ out:
+	if (data != NULL)
+		kfree(data);
+}
+
+#endif
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/Kconfig linux-2.6.12-rc6-mm1-ima/security/ima/Kconfig
--- linux-2.6.12-rc6-mm1_orig/security/ima/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/Kconfig	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,90 @@
+#
+# IBM Integrity Measurement Architecture
+#
+
+#menu "TPM-based Integrity Measurement Architecture"
+
+config IMA_MEASURE
+	bool "TCG run-time Integrity Measurement Architecture"
+	depends on SECURITY && (CRYPTO_SHA1=y)
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
+	default y
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
diff -uprN linux-2.6.12-rc6-mm1_orig/security/ima/Makefile linux-2.6.12-rc6-mm1-ima/security/ima/Makefile
--- linux-2.6.12-rc6-mm1_orig/security/ima/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/security/ima/Makefile	2005-06-14 16:25:05.000000000 -0400
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_IMA_MEASURE) += ima_init.o ima_main.o \
+				ima_queue.o ima_lsmhooks.o ima_fs.o
+
+
diff -uprN linux-2.6.12-rc6-mm1_orig/security/Kconfig linux-2.6.12-rc6-mm1-ima/security/Kconfig
--- linux-2.6.12-rc6-mm1_orig/security/Kconfig	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6-mm1-ima/security/Kconfig	2005-06-14 16:25:05.000000000 -0400
@@ -86,6 +86,7 @@ config SECURITY_SECLVL
 	  If you are unsure how to answer this question, answer N.
 
 source security/selinux/Kconfig
+source security/ima/Kconfig
 
 endmenu
 
diff -uprN linux-2.6.12-rc6-mm1_orig/security/Makefile linux-2.6.12-rc6-mm1-ima/security/Makefile
--- linux-2.6.12-rc6-mm1_orig/security/Makefile	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6-mm1-ima/security/Makefile	2005-06-14 16:25:05.000000000 -0400
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




