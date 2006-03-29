Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWC2X2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWC2X2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWC2X2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:28:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:23240 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751250AbWC2XXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:23:53 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 16] ipath - sysfs and ipathfs support for core driver
X-Mercurial-Node: a7122f893096caa30c223d829e9798bec3c95a8c
Message-Id: <a7122f893096caa30c22.1143674610@chalcedony.internal.keyresearch.com>
In-Reply-To: <patchbomb.1143674603@chalcedony.internal.keyresearch.com>
Date: Wed, 29 Mar 2006 15:23:30 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ipathfs filesystem contains files that are not appropriate for
sysfs, because they contain binary data.  The hierarchy is simple; the
top-level directory contains driver-wide attribute files, while numbered
subdirectories contain per-device attribute files.

Our userspace code currently expects this filesystem to be mounted on
/ipathfs, but a final location has not yet been chosen.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r f4786f239154 -r a7122f893096 drivers/infiniband/hw/ipath/ipath_fs.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c	Wed Mar 29 15:21:26 2006 -0800
@@ -0,0 +1,605 @@
+/*
+ * Copyright (c) 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+
+#define IPATHFS_MAGIC 0x726a77
+
+static struct super_block *ipath_super;
+
+static int ipathfs_mknod(struct inode *dir, struct dentry *dentry,
+			 int mode, struct file_operations *fops,
+			 void *data)
+{
+	int error;
+	struct inode *inode = new_inode(dir->i_sb);
+
+	if (!inode) {
+		error = -EPERM;
+		goto bail;
+	}
+
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->u.generic_ip = data;
+	if ((mode & S_IFMT) == S_IFDIR) {
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_nlink++;
+		dir->i_nlink++;
+	}
+
+	inode->i_fop = fops;
+
+	d_instantiate(dentry, inode);
+	error = 0;
+
+bail:
+	return error;
+}
+
+static int create_file(const char *name, mode_t mode,
+		       struct dentry *parent, struct dentry **dentry,
+		       struct file_operations *fops, void *data)
+{
+	int error;
+
+	*dentry = NULL;
+	mutex_lock(&parent->d_inode->i_mutex);
+	*dentry = lookup_one_len(name, parent, strlen(name));
+	if (!IS_ERR(dentry))
+		error = ipathfs_mknod(parent->d_inode, *dentry,
+				      mode, fops, data);
+	else
+		error = PTR_ERR(dentry);
+	mutex_unlock(&parent->d_inode->i_mutex);
+
+	return error;
+}
+
+static ssize_t atomic_stats_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, &ipath_stats,
+				       sizeof ipath_stats);
+}
+
+static struct file_operations atomic_stats_ops = {
+	.read = atomic_stats_read,
+};
+
+#define NUM_COUNTERS sizeof(struct infinipath_counters) / sizeof(u64)
+
+static ssize_t atomic_counters_read(struct file *file, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	u64 counters[NUM_COUNTERS];
+	u16 i;
+	struct ipath_devdata *dd;
+
+	dd = file->f_dentry->d_inode->u.generic_ip;
+
+	for (i = 0; i < NUM_COUNTERS; i++)
+		counters[i] = ipath_snap_cntr(dd, i);
+
+	return simple_read_from_buffer(buf, count, ppos, counters,
+				       sizeof counters);
+}
+
+static struct file_operations atomic_counters_ops = {
+	.read = atomic_counters_read,
+};
+
+static ssize_t atomic_node_info_read(struct file *file, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	u32 nodeinfo[10];
+	struct ipath_devdata *dd;
+	u64 guid;
+
+	dd = file->f_dentry->d_inode->u.generic_ip;
+
+	guid = be64_to_cpu(dd->ipath_guid);
+
+	nodeinfo[0] =			/* BaseVersion is SMA */
+		/* ClassVersion is SMA */
+		(1 << 8)		/* NodeType  */
+		| (1 << 0);		/* NumPorts */
+	nodeinfo[1] = (u32) (guid >> 32);
+	nodeinfo[2] = (u32) (guid & 0xffffffff);
+	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[3] = nodeinfo[1];
+	/* PortGUID == SystemImageGUID for us */
+	nodeinfo[4] = nodeinfo[2];
+	/* PortGUID == NodeGUID for us */
+	nodeinfo[5] = nodeinfo[3];
+	/* PortGUID == NodeGUID for us */
+	nodeinfo[6] = nodeinfo[4];
+	nodeinfo[7] = (4 << 16) /* we support 4 pkeys */
+		| (dd->ipath_deviceid << 0);
+	/* our chip version as 16 bits major, 16 bits minor */
+	nodeinfo[8] = dd->ipath_minrev | (dd->ipath_majrev << 16);
+	nodeinfo[9] = (dd->ipath_unit << 24) | (dd->ipath_vendorid << 0);
+
+	return simple_read_from_buffer(buf, count, ppos, nodeinfo,
+				       sizeof nodeinfo);
+}
+
+static struct file_operations atomic_node_info_ops = {
+	.read = atomic_node_info_read,
+};
+
+static ssize_t atomic_port_info_read(struct file *file, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	u32 portinfo[13];
+	u32 tmp, tmp2;
+	struct ipath_devdata *dd;
+
+	dd = file->f_dentry->d_inode->u.generic_ip;
+
+	/* so we only initialize non-zero fields. */
+	memset(portinfo, 0, sizeof portinfo);
+
+	/*
+	 * Notimpl yet M_Key (64)
+	 * Notimpl yet GID (64)
+	 */
+
+	portinfo[4] = (dd->ipath_lid << 16);
+
+	/*
+	 * Notimpl yet SMLID (should we store this in the driver, in case
+	 * SMA dies?)  CapabilityMask is 0, we don't support any of these
+	 * DiagCode is 0; we don't store any diag info for now Notimpl yet
+	 * M_KeyLeasePeriod (we don't support M_Key)
+	 */
+
+	/* LocalPortNum is whichever port number they ask for */
+	portinfo[7] = (dd->ipath_unit << 24)
+		/* LinkWidthEnabled */
+		| (2 << 16)
+		/* LinkWidthSupported (really 2, but not IB valid) */
+		| (3 << 8)
+		/* LinkWidthActive */
+		| (2 << 0);
+	tmp = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
+	tmp2 = 5;
+	if (tmp == IPATH_IBSTATE_INIT)
+		tmp = 2;
+	else if (tmp == IPATH_IBSTATE_ARM)
+		tmp = 3;
+	else if (tmp == IPATH_IBSTATE_ACTIVE)
+		tmp = 4;
+	else {
+		tmp = 0;	/* down */
+		tmp2 = tmp & 0xf;
+	}
+
+	portinfo[8] = (1 << 28)	/* LinkSpeedSupported */
+		| (tmp << 24)	/* PortState */
+		| (tmp2 << 20)	/* PortPhysicalState */
+		| (2 << 16)
+
+		/* LinkDownDefaultState */
+		/* M_KeyProtectBits == 0 */
+		/* NotImpl yet LMC == 0 (we can support all values) */
+		| (1 << 4)	/* LinkSpeedActive */
+		| (1 << 0);	/* LinkSpeedEnabled */
+	switch (dd->ipath_ibmtu) {
+	case 4096:
+		tmp = 5;
+		break;
+	case 2048:
+		tmp = 4;
+		break;
+	case 1024:
+		tmp = 3;
+		break;
+	case 512:
+		tmp = 2;
+		break;
+	case 256:
+		tmp = 1;
+		break;
+	default:		/* oops, something is wrong */
+		ipath_dbg("Problem, ipath_ibmtu 0x%x not a valid IB MTU, "
+			  "treat as 2048\n", dd->ipath_ibmtu);
+		tmp = 4;
+		break;
+	}
+	portinfo[9] = (tmp << 28)
+		/* NeighborMTU */
+		/* Notimpl MasterSMSL */
+		| (1 << 20)
+
+		/* VLCap */
+		/* Notimpl InitType (actually, an SMA decision) */
+		/* VLHighLimit is 0 (only one VL) */
+		; /* VLArbitrationHighCap is 0 (only one VL) */
+	portinfo[10] = 	/* VLArbitrationLowCap is 0 (only one VL) */
+		/* InitTypeReply is SMA decision */
+		(5 << 16)	/* MTUCap 4096 */
+		| (7 << 13)	/* VLStallCount */
+		| (0x1f << 8)	/* HOQLife */
+		| (1 << 4)
+
+		/* OperationalVLs 0 */
+		/* PartitionEnforcementInbound */
+		/* PartitionEnforcementOutbound not enforced */
+		/* FilterRawinbound not enforced */
+		;		/* FilterRawOutbound not enforced */
+	/* M_KeyViolations are not counted by hardware, SMA can count */
+	tmp = ipath_read_creg32(dd, dd->ipath_cregs->cr_errpkey);
+	/* P_KeyViolations are counted by hardware. */
+	portinfo[11] = ((tmp & 0xffff) << 0);
+	portinfo[12] =
+		/* Q_KeyViolations are not counted by hardware */
+		(1 << 8)
+
+		/* GUIDCap */
+		/* SubnetTimeOut handled by SMA */
+		/* RespTimeValue handled by SMA */
+		;
+	/* LocalPhyErrors are programmed to max */
+	portinfo[12] |= (0xf << 20)
+		| (0xf << 16)   /* OverRunErrors are programmed to max */
+		;
+
+	return simple_read_from_buffer(buf, count, ppos, portinfo,
+				       sizeof portinfo);
+}
+
+static struct file_operations atomic_port_info_ops = {
+	.read = atomic_port_info_read,
+};
+
+static ssize_t flash_read(struct file *file, char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	struct ipath_devdata *dd;
+	ssize_t ret;
+	loff_t pos;
+	char *tmp;
+
+	pos = *ppos;
+
+	if ( pos < 0) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (pos >= sizeof(struct ipath_flash)) {
+		ret = 0;
+		goto bail;
+	}
+
+	if (count > sizeof(struct ipath_flash) - pos)
+		count = sizeof(struct ipath_flash) - pos;
+
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	dd = file->f_dentry->d_inode->u.generic_ip;
+	if (ipath_eeprom_read(dd, pos, tmp, count)) {
+		ipath_dev_err(dd, "failed to read from flash\n");
+		ret = -ENXIO;
+		goto bail_tmp;
+	}
+
+	if (copy_to_user(buf, tmp, count)) {
+		ret = -EFAULT;
+		goto bail_tmp;
+	}
+
+	*ppos = pos + count;
+	ret = count;
+
+bail_tmp:
+	kfree(tmp);
+
+bail:
+	return ret;
+}
+
+static ssize_t flash_write(struct file *file, const char __user *buf,
+			   size_t count, loff_t *ppos)
+{
+	struct ipath_devdata *dd;
+	ssize_t ret;
+	loff_t pos;
+	char *tmp;
+
+	pos = *ppos;
+
+	if ( pos < 0) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (pos >= sizeof(struct ipath_flash)) {
+		ret = 0;
+		goto bail;
+	}
+
+	if (count > sizeof(struct ipath_flash) - pos)
+		count = sizeof(struct ipath_flash) - pos;
+
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	if (copy_from_user(tmp, buf, count)) {
+		ret = -EFAULT;
+		goto bail_tmp;
+	}
+
+	dd = file->f_dentry->d_inode->u.generic_ip;
+	if (ipath_eeprom_write(dd, pos, tmp, count)) {
+		ret = -ENXIO;
+		ipath_dev_err(dd, "failed to write to flash\n");
+		goto bail_tmp;
+	}
+
+	*ppos = pos + count;
+	ret = count;
+
+bail_tmp:
+	kfree(tmp);
+
+bail:
+	return ret;
+}
+
+static struct file_operations flash_ops = {
+	.read = flash_read,
+	.write = flash_write,
+};
+
+static int create_device_files(struct super_block *sb,
+			       struct ipath_devdata *dd)
+{
+	struct dentry *dir, *tmp;
+	char unit[10];
+	int ret;
+
+	snprintf(unit, sizeof unit, "%02d", dd->ipath_unit);
+	ret = create_file(unit, S_IFDIR|S_IRUGO|S_IXUGO, sb->s_root, &dir,
+			  (struct file_operations *) &simple_dir_operations,
+			  dd);
+	if (ret) {
+		printk(KERN_ERR "create_file(%s) failed: %d\n", unit, ret);
+		goto bail;
+	}
+
+	ret = create_file("atomic_counters", S_IFREG|S_IRUGO, dir, &tmp,
+			  &atomic_counters_ops, dd);
+	if (ret) {
+		printk(KERN_ERR "create_file(%s/atomic_counters) "
+		       "failed: %d\n", unit, ret);
+		goto bail;
+	}
+
+	ret = create_file("node_info", S_IFREG|S_IRUGO, dir, &tmp,
+			  &atomic_node_info_ops, dd);
+	if (ret) {
+		printk(KERN_ERR "create_file(%s/node_info) "
+		       "failed: %d\n", unit, ret);
+		goto bail;
+	}
+
+	ret = create_file("port_info", S_IFREG|S_IRUGO, dir, &tmp,
+			  &atomic_port_info_ops, dd);
+	if (ret) {
+		printk(KERN_ERR "create_file(%s/port_info) "
+		       "failed: %d\n", unit, ret);
+		goto bail;
+	}
+
+	ret = create_file("flash", S_IFREG|S_IWUSR|S_IRUGO, dir, &tmp,
+			  &flash_ops, dd);
+	if (ret) {
+		printk(KERN_ERR "create_file(%s/flash) "
+		       "failed: %d\n", unit, ret);
+		goto bail;
+	}
+
+bail:
+	return ret;
+}
+
+static void remove_file(struct dentry *parent, char *name)
+{
+	struct dentry *tmp;
+
+	tmp = lookup_one_len(name, parent, strlen(name));
+
+	spin_lock(&dcache_lock);
+	spin_lock(&tmp->d_lock);
+	if (!(d_unhashed(tmp) && tmp->d_inode)) {
+		dget_locked(tmp);
+		__d_drop(tmp);
+		spin_unlock(&tmp->d_lock);
+		spin_unlock(&dcache_lock);
+		simple_unlink(parent->d_inode, tmp);
+	} else {
+		spin_unlock(&tmp->d_lock);
+		spin_unlock(&dcache_lock);
+	}
+}
+
+static int remove_device_files(struct super_block *sb,
+			       struct ipath_devdata *dd)
+{
+	struct dentry *dir, *root;
+	char unit[10];
+	int ret;
+
+	root = dget(sb->s_root);
+	mutex_lock(&root->d_inode->i_mutex);
+	snprintf(unit, sizeof unit, "%02d", dd->ipath_unit);
+	dir = lookup_one_len(unit, root, strlen(unit));
+
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
+		printk(KERN_ERR "Lookup of %s failed\n", unit);
+		goto bail;
+	}
+
+	remove_file(dir, "flash");
+	remove_file(dir, "port_info");
+	remove_file(dir, "node_info");
+	remove_file(dir, "atomic_counters");
+	d_delete(dir);
+	ret = simple_rmdir(root->d_inode, dir);
+
+bail:
+	mutex_unlock(&root->d_inode->i_mutex);
+	dput(root);
+	return ret;
+}
+
+static int ipathfs_fill_super(struct super_block *sb, void *data,
+			      int silent)
+{
+	struct ipath_devdata *dd, *tmp;
+	unsigned long flags;
+	int ret;
+
+	static struct tree_descr files[] = {
+		[1] = {"atomic_stats", &atomic_stats_ops, S_IRUGO},
+		{""},
+	};
+
+	ret = simple_fill_super(sb, IPATHFS_MAGIC, files);
+	if (ret) {
+		printk(KERN_ERR "simple_fill_super failed: %d\n", ret);
+		goto bail;
+	}
+
+	spin_lock_irqsave(&ipath_devs_lock, flags);
+
+	list_for_each_entry_safe(dd, tmp, &ipath_dev_list, ipath_list) {
+		spin_unlock_irqrestore(&ipath_devs_lock, flags);
+		ret = create_device_files(sb, dd);
+		if (ret) {
+			deactivate_super(sb);
+			goto bail;
+		}
+		spin_lock_irqsave(&ipath_devs_lock, flags);
+	}
+
+	spin_unlock_irqrestore(&ipath_devs_lock, flags);
+
+bail:
+	return ret;
+}
+
+static struct super_block *ipathfs_get_sb(struct file_system_type *fs_type,
+				        int flags, const char *dev_name,
+					void *data)
+{
+	ipath_super = get_sb_single(fs_type, flags, data,
+				    ipathfs_fill_super);
+	return ipath_super;
+}
+
+static void ipathfs_kill_super(struct super_block *s)
+{
+	kill_litter_super(s);
+	ipath_super = NULL;
+}
+
+int ipathfs_add_device(struct ipath_devdata *dd)
+{
+	int ret;
+
+	if (ipath_super == NULL) {
+		ret = 0;
+		goto bail;
+	}
+
+	ret = create_device_files(ipath_super, dd);
+
+bail:
+	return ret;
+}
+
+int ipathfs_remove_device(struct ipath_devdata *dd)
+{
+	int ret;
+
+	if (ipath_super == NULL) {
+		ret = 0;
+		goto bail;
+	}
+
+	ret = remove_device_files(ipath_super, dd);
+
+bail:
+	return ret;
+}
+
+static struct file_system_type ipathfs_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"ipathfs",
+	.get_sb =	ipathfs_get_sb,
+	.kill_sb =	ipathfs_kill_super,
+};
+
+int __init ipath_init_ipathfs(void)
+{
+	return register_filesystem(&ipathfs_fs_type);
+}
+
+void __exit ipath_exit_ipathfs(void)
+{
+	unregister_filesystem(&ipathfs_fs_type);
+}
diff -r f4786f239154 -r a7122f893096 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Wed Mar 29 15:21:26 2006 -0800
@@ -0,0 +1,778 @@
+/*
+ * Copyright (c) 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/ctype.h>
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/**
+ * ipath_parse_ushort - parse an unsigned short value in an arbitrary base
+ * @str: the string containing the number
+ * @valp: where to put the result
+ *
+ * returns the number of bytes consumed, or negative value on error
+ */
+int ipath_parse_ushort(const char *str, unsigned short *valp)
+{
+	unsigned long val;
+	char *end;
+	int ret;
+
+	if (!isdigit(str[0])) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	val = simple_strtoul(str, &end, 0);
+
+	if (val > 0xffff) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	*valp = val;
+
+	ret = end + 1 - str;
+	if (ret == 0)
+		ret = -EINVAL;
+
+bail:
+	return ret;
+}
+
+static ssize_t show_version(struct device_driver *dev, char *buf)
+{
+	/* The string printed here is already newline-terminated. */
+	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
+}
+
+static ssize_t show_num_units(struct device_driver *dev, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 ipath_count_units(NULL, NULL, NULL));
+}
+
+#define DRIVER_STAT(name, attr) \
+	static ssize_t show_stat_##name(struct device_driver *dev, \
+					char *buf) \
+	{ \
+		return scnprintf( \
+			buf, PAGE_SIZE, "%llu\n", \
+			(unsigned long long) ipath_stats.sps_ ##attr); \
+	} \
+	static DRIVER_ATTR(name, S_IRUGO, show_stat_##name, NULL)
+
+DRIVER_STAT(intrs, ints);
+DRIVER_STAT(err_intrs, errints);
+DRIVER_STAT(errs, errs);
+DRIVER_STAT(pkt_errs, pkterrs);
+DRIVER_STAT(crc_errs, crcerrs);
+DRIVER_STAT(hw_errs, hwerrs);
+DRIVER_STAT(ib_link, iblink);
+DRIVER_STAT(port0_pkts, port0pkts);
+DRIVER_STAT(ether_spkts, ether_spkts);
+DRIVER_STAT(ether_rpkts, ether_rpkts);
+DRIVER_STAT(sma_spkts, sma_spkts);
+DRIVER_STAT(sma_rpkts, sma_rpkts);
+DRIVER_STAT(hdrq_full, hdrqfull);
+DRIVER_STAT(etid_full, etidfull);
+DRIVER_STAT(no_piobufs, nopiobufs);
+DRIVER_STAT(ports, ports);
+DRIVER_STAT(pkey0, pkeys[0]);
+DRIVER_STAT(pkey1, pkeys[1]);
+DRIVER_STAT(pkey2, pkeys[2]);
+DRIVER_STAT(pkey3, pkeys[3]);
+/* XXX fix the following when dynamic table of devices used */
+DRIVER_STAT(lid0, lid[0]);
+DRIVER_STAT(lid1, lid[1]);
+DRIVER_STAT(lid2, lid[2]);
+DRIVER_STAT(lid3, lid[3]);
+
+DRIVER_STAT(nports, nports);
+DRIVER_STAT(null_intr, nullintr);
+DRIVER_STAT(max_pkts_call, maxpkts_call);
+DRIVER_STAT(avg_pkts_call, avgpkts_call);
+DRIVER_STAT(page_locks, pagelocks);
+DRIVER_STAT(page_unlocks, pageunlocks);
+DRIVER_STAT(krdrops, krdrops);
+/* XXX fix the following when dynamic table of devices used */
+DRIVER_STAT(mlid0, mlid[0]);
+DRIVER_STAT(mlid1, mlid[1]);
+DRIVER_STAT(mlid2, mlid[2]);
+DRIVER_STAT(mlid3, mlid[3]);
+
+static struct attribute *driver_stat_attributes[] = {
+	&driver_attr_intrs.attr,
+	&driver_attr_err_intrs.attr,
+	&driver_attr_errs.attr,
+	&driver_attr_pkt_errs.attr,
+	&driver_attr_crc_errs.attr,
+	&driver_attr_hw_errs.attr,
+	&driver_attr_ib_link.attr,
+	&driver_attr_port0_pkts.attr,
+	&driver_attr_ether_spkts.attr,
+	&driver_attr_ether_rpkts.attr,
+	&driver_attr_sma_spkts.attr,
+	&driver_attr_sma_rpkts.attr,
+	&driver_attr_hdrq_full.attr,
+	&driver_attr_etid_full.attr,
+	&driver_attr_no_piobufs.attr,
+	&driver_attr_ports.attr,
+	&driver_attr_pkey0.attr,
+	&driver_attr_pkey1.attr,
+	&driver_attr_pkey2.attr,
+	&driver_attr_pkey3.attr,
+	&driver_attr_lid0.attr,
+	&driver_attr_lid1.attr,
+	&driver_attr_lid2.attr,
+	&driver_attr_lid3.attr,
+	&driver_attr_nports.attr,
+	&driver_attr_null_intr.attr,
+	&driver_attr_max_pkts_call.attr,
+	&driver_attr_avg_pkts_call.attr,
+	&driver_attr_page_locks.attr,
+	&driver_attr_page_unlocks.attr,
+	&driver_attr_krdrops.attr,
+	&driver_attr_mlid0.attr,
+	&driver_attr_mlid1.attr,
+	&driver_attr_mlid2.attr,
+	&driver_attr_mlid3.attr,
+	NULL
+};
+
+static struct attribute_group driver_stat_attr_group = {
+	.name = "stats",
+	.attrs = driver_stat_attributes
+};
+
+static ssize_t show_status(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	if (!dd->ipath_statusp) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	ret = scnprintf(buf, PAGE_SIZE, "0x%llx\n",
+			(unsigned long long) *(dd->ipath_statusp));
+
+bail:
+	return ret;
+}
+
+static const char *ipath_status_str[] = {
+	"Initted",
+	"Disabled",
+	"Admin_Disabled",
+	"OIB_SMA",
+	"SMA",
+	"Present",
+	"IB_link_up",
+	"IB_configured",
+	"NoIBcable",
+	"Fatal_Hardware_Error",
+	NULL,
+};
+
+static ssize_t show_status_str(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int i, any;
+	u64 s;
+	ssize_t ret;
+
+	if (!dd->ipath_statusp) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	s = *(dd->ipath_statusp);
+	*buf = '\0';
+	for (any = i = 0; s && ipath_status_str[i]; i++) {
+		if (s & 1) {
+			if (any && strlcat(buf, " ", PAGE_SIZE) >=
+			    PAGE_SIZE)
+				/* overflow */
+				break;
+			if (strlcat(buf, ipath_status_str[i],
+				    PAGE_SIZE) >= PAGE_SIZE)
+				break;
+			any = 1;
+		}
+		s >>= 1;
+	}
+	if (any)
+		strlcat(buf, "\n", PAGE_SIZE);
+
+	ret = strlen(buf);
+
+bail:
+	return ret;
+}
+
+static ssize_t show_boardversion(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	/* The string printed here is already newline-terminated. */
+	return scnprintf(buf, PAGE_SIZE, "%s", dd->ipath_boardversion);
+}
+
+static ssize_t show_lid(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dd->ipath_lid);
+}
+
+static ssize_t store_lid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u16 lid;
+	int ret;
+
+	ret = ipath_parse_ushort(buf, &lid);
+	if (ret < 0)
+		goto invalid;
+
+	if (lid == 0 || lid >= 0xc000) {
+		ret = -EINVAL;
+		goto invalid;
+	}
+
+	ipath_set_sps_lid(dd, lid, 0);
+
+	goto bail;
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid LID\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_mlid(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dd->ipath_mlid);
+}
+
+static ssize_t store_mlid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int unit;
+	u16 mlid;
+	int ret;
+
+	ret = ipath_parse_ushort(buf, &mlid);
+	if (ret < 0)
+		goto invalid;
+
+	unit = dd->ipath_unit;
+
+	dd->ipath_mlid = mlid;
+	ipath_stats.sps_mlid[unit] = mlid;
+	ipath_layer_intr(dd, IPATH_LAYER_INT_BCAST);
+
+	goto bail;
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid MLID\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_guid(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	u8 *guid;
+
+	guid = (u8 *) & (dd->ipath_guid);
+
+	return scnprintf(buf, PAGE_SIZE,
+			 "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+			 guid[0], guid[1], guid[2], guid[3],
+			 guid[4], guid[5], guid[6], guid[7]);
+}
+
+static ssize_t store_guid(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+	unsigned short guid[8];
+	__be64 nguid;
+	u8 *ng;
+	int i;
+
+	if (sscanf(buf, "%hx:%hx:%hx:%hx:%hx:%hx:%hx:%hx",
+		   &guid[0], &guid[1], &guid[2], &guid[3],
+		   &guid[4], &guid[5], &guid[6], &guid[7]) != 8)
+		goto invalid;
+
+	ng = (u8 *) &nguid;
+
+	for (i = 0; i < 8; i++) {
+		if (guid[i] > 0xff)
+			goto invalid;
+		ng[i] = guid[i];
+	}
+
+	dd->ipath_guid = nguid;
+	dd->ipath_nguid = 1;
+
+	ret = strlen(buf);
+	goto bail;
+
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid GUID\n");
+	ret = -EINVAL;
+
+bail:
+	return ret;
+}
+
+static ssize_t show_nguid(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_nguid);
+}
+
+static ssize_t show_serial(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	buf[sizeof dd->ipath_serial] = '\0';
+	memcpy(buf, dd->ipath_serial, sizeof dd->ipath_serial);
+	strcat(buf, "\n");
+	return strlen(buf);
+}
+
+static ssize_t show_unit(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_unit);
+}
+
+#define DEVICE_COUNTER(name, attr) \
+	static ssize_t show_counter_##name(struct device *dev, \
+					   struct device_attribute *attr, \
+					   char *buf) \
+	{ \
+		struct ipath_devdata *dd = dev_get_drvdata(dev); \
+		return scnprintf(\
+			buf, PAGE_SIZE, "%llu\n", (unsigned long long) \
+			ipath_snap_cntr( \
+				dd, offsetof(struct infinipath_counters, \
+					     attr) / sizeof(u64)));	\
+	} \
+	static DEVICE_ATTR(name, S_IRUGO, show_counter_##name, NULL);
+
+DEVICE_COUNTER(ib_link_downeds, IBLinkDownedCnt);
+DEVICE_COUNTER(ib_link_err_recoveries, IBLinkErrRecoveryCnt);
+DEVICE_COUNTER(ib_status_changes, IBStatusChangeCnt);
+DEVICE_COUNTER(ib_symbol_errs, IBSymbolErrCnt);
+DEVICE_COUNTER(lb_flow_stalls, LBFlowStallCnt);
+DEVICE_COUNTER(lb_ints, LBIntCnt);
+DEVICE_COUNTER(rx_bad_formats, RxBadFormatCnt);
+DEVICE_COUNTER(rx_buf_ovfls, RxBufOvflCnt);
+DEVICE_COUNTER(rx_data_pkts, RxDataPktCnt);
+DEVICE_COUNTER(rx_dropped_pkts, RxDroppedPktCnt);
+DEVICE_COUNTER(rx_dwords, RxDwordCnt);
+DEVICE_COUNTER(rx_ebps, RxEBPCnt);
+DEVICE_COUNTER(rx_flow_ctrl_errs, RxFlowCtrlErrCnt);
+DEVICE_COUNTER(rx_flow_pkts, RxFlowPktCnt);
+DEVICE_COUNTER(rx_icrc_errs, RxICRCErrCnt);
+DEVICE_COUNTER(rx_len_errs, RxLenErrCnt);
+DEVICE_COUNTER(rx_link_problems, RxLinkProblemCnt);
+DEVICE_COUNTER(rx_lpcrc_errs, RxLPCRCErrCnt);
+DEVICE_COUNTER(rx_max_min_len_errs, RxMaxMinLenErrCnt);
+DEVICE_COUNTER(rx_p0_hdr_egr_ovfls, RxP0HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p1_hdr_egr_ovfls, RxP1HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p2_hdr_egr_ovfls, RxP2HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p3_hdr_egr_ovfls, RxP3HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p4_hdr_egr_ovfls, RxP4HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p5_hdr_egr_ovfls, RxP5HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p6_hdr_egr_ovfls, RxP6HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p7_hdr_egr_ovfls, RxP7HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_p8_hdr_egr_ovfls, RxP8HdrEgrOvflCnt);
+DEVICE_COUNTER(rx_pkey_mismatches, RxPKeyMismatchCnt);
+DEVICE_COUNTER(rx_tid_full_errs, RxTIDFullErrCnt);
+DEVICE_COUNTER(rx_tid_valid_errs, RxTIDValidErrCnt);
+DEVICE_COUNTER(rx_vcrc_errs, RxVCRCErrCnt);
+DEVICE_COUNTER(tx_data_pkts, TxDataPktCnt);
+DEVICE_COUNTER(tx_dropped_pkts, TxDroppedPktCnt);
+DEVICE_COUNTER(tx_dwords, TxDwordCnt);
+DEVICE_COUNTER(tx_flow_pkts, TxFlowPktCnt);
+DEVICE_COUNTER(tx_flow_stalls, TxFlowStallCnt);
+DEVICE_COUNTER(tx_len_errs, TxLenErrCnt);
+DEVICE_COUNTER(tx_max_min_len_errs, TxMaxMinLenErrCnt);
+DEVICE_COUNTER(tx_underruns, TxUnderrunCnt);
+DEVICE_COUNTER(tx_unsup_vl_errs, TxUnsupVLErrCnt);
+
+static struct attribute *dev_counter_attributes[] = {
+	&dev_attr_ib_link_downeds.attr,
+	&dev_attr_ib_link_err_recoveries.attr,
+	&dev_attr_ib_status_changes.attr,
+	&dev_attr_ib_symbol_errs.attr,
+	&dev_attr_lb_flow_stalls.attr,
+	&dev_attr_lb_ints.attr,
+	&dev_attr_rx_bad_formats.attr,
+	&dev_attr_rx_buf_ovfls.attr,
+	&dev_attr_rx_data_pkts.attr,
+	&dev_attr_rx_dropped_pkts.attr,
+	&dev_attr_rx_dwords.attr,
+	&dev_attr_rx_ebps.attr,
+	&dev_attr_rx_flow_ctrl_errs.attr,
+	&dev_attr_rx_flow_pkts.attr,
+	&dev_attr_rx_icrc_errs.attr,
+	&dev_attr_rx_len_errs.attr,
+	&dev_attr_rx_link_problems.attr,
+	&dev_attr_rx_lpcrc_errs.attr,
+	&dev_attr_rx_max_min_len_errs.attr,
+	&dev_attr_rx_p0_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p1_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p2_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p3_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p4_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p5_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p6_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p7_hdr_egr_ovfls.attr,
+	&dev_attr_rx_p8_hdr_egr_ovfls.attr,
+	&dev_attr_rx_pkey_mismatches.attr,
+	&dev_attr_rx_tid_full_errs.attr,
+	&dev_attr_rx_tid_valid_errs.attr,
+	&dev_attr_rx_vcrc_errs.attr,
+	&dev_attr_tx_data_pkts.attr,
+	&dev_attr_tx_dropped_pkts.attr,
+	&dev_attr_tx_dwords.attr,
+	&dev_attr_tx_flow_pkts.attr,
+	&dev_attr_tx_flow_stalls.attr,
+	&dev_attr_tx_len_errs.attr,
+	&dev_attr_tx_max_min_len_errs.attr,
+	&dev_attr_tx_underruns.attr,
+	&dev_attr_tx_unsup_vl_errs.attr,
+	NULL
+};
+
+static struct attribute_group dev_counter_attr_group = {
+	.name = "counters",
+	.attrs = dev_counter_attributes
+};
+
+static ssize_t store_reset(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int ret;
+
+	if (count < 5 || memcmp(buf, "reset", 5)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	if (dd->ipath_flags & IPATH_DISABLED) {
+		/*
+		 * post-reset init would re-enable interrupts, etc.
+		 * so don't allow reset on disabled devices.  Not
+		 * perfect error, but about the best choice.
+		 */
+		dev_info(dev,"Unit %d is disabled, can't reset\n",
+			 dd->ipath_unit);
+		ret = -EINVAL;
+	}
+	ret = ipath_reset_device(dd->ipath_unit);
+bail:
+	return ret<0 ? ret : count;
+}
+
+static ssize_t store_link_state(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int ret, r;
+	u16 state;
+
+	ret = ipath_parse_ushort(buf, &state);
+	if (ret < 0)
+		goto invalid;
+
+	r = ipath_layer_set_linkstate(dd, state);
+	if (r < 0) {
+		ret = r;
+		goto bail;
+	}
+
+	goto bail;
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid link state\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_mtu(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_ibmtu);
+}
+
+static ssize_t store_mtu(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+	u16 mtu = 0;
+	int r;
+
+	ret = ipath_parse_ushort(buf, &mtu);
+	if (ret < 0)
+		goto invalid;
+
+	r = ipath_layer_set_mtu(dd, mtu);
+	if (r < 0)
+		ret = r;
+
+	goto bail;
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid MTU\n");
+bail:
+	return ret;
+}
+
+static ssize_t show_enabled(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (dd->ipath_flags & IPATH_DISABLED) ? 0 : 1);
+}
+
+static ssize_t store_enabled(struct device *dev,
+			 struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	ssize_t ret;
+	u16 enable = 0;
+
+	ret = ipath_parse_ushort(buf, &enable);
+	if (ret < 0) {
+		ipath_dev_err(dd, "attempt to use non-numeric on enable\n");
+		goto bail;
+	}
+
+	if (enable) {
+		if (!(dd->ipath_flags & IPATH_DISABLED))
+			goto bail;
+
+		dev_info(dev, "Enabling unit %d\n", dd->ipath_unit);
+		/* same as post-reset */
+		ret = ipath_init_chip(dd, 1);
+		if (ret)
+			ipath_dev_err(dd, "Failed to enable unit %d\n",
+				      dd->ipath_unit);
+		else {
+			dd->ipath_flags &= ~IPATH_DISABLED;
+			*dd->ipath_statusp &= ~IPATH_STATUS_ADMIN_DISABLED;
+		}
+	}
+	else if (!(dd->ipath_flags & IPATH_DISABLED)) {
+		dev_info(dev, "Disabling unit %d\n", dd->ipath_unit);
+		ipath_shutdown_device(dd);
+		dd->ipath_flags |= IPATH_DISABLED;
+		*dd->ipath_statusp |= IPATH_STATUS_ADMIN_DISABLED;
+	}
+
+bail:
+	return ret;
+}
+
+static DRIVER_ATTR(num_units, S_IRUGO, show_num_units, NULL);
+static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
+
+static struct attribute *driver_attributes[] = {
+	&driver_attr_num_units.attr,
+	&driver_attr_version.attr,
+	NULL
+};
+
+static struct attribute_group driver_attr_group = {
+	.attrs = driver_attributes
+};
+
+static DEVICE_ATTR(guid, S_IWUSR | S_IRUGO, show_guid, store_guid);
+static DEVICE_ATTR(lid, S_IWUSR | S_IRUGO, show_lid, store_lid);
+static DEVICE_ATTR(link_state, S_IWUSR, NULL, store_link_state);
+static DEVICE_ATTR(mlid, S_IWUSR | S_IRUGO, show_mlid, store_mlid);
+static DEVICE_ATTR(mtu, S_IWUSR | S_IRUGO, show_mtu, store_mtu);
+static DEVICE_ATTR(enabled, S_IWUSR | S_IRUGO, show_enabled, store_enabled);
+static DEVICE_ATTR(nguid, S_IRUGO, show_nguid, NULL);
+static DEVICE_ATTR(reset, S_IWUSR, NULL, store_reset);
+static DEVICE_ATTR(serial, S_IRUGO, show_serial, NULL);
+static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+static DEVICE_ATTR(status_str, S_IRUGO, show_status_str, NULL);
+static DEVICE_ATTR(boardversion, S_IRUGO, show_boardversion, NULL);
+static DEVICE_ATTR(unit, S_IRUGO, show_unit, NULL);
+
+static struct attribute *dev_attributes[] = {
+	&dev_attr_guid.attr,
+	&dev_attr_lid.attr,
+	&dev_attr_link_state.attr,
+	&dev_attr_mlid.attr,
+	&dev_attr_mtu.attr,
+	&dev_attr_nguid.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_status.attr,
+	&dev_attr_status_str.attr,
+	&dev_attr_boardversion.attr,
+	&dev_attr_unit.attr,
+	&dev_attr_enabled.attr,
+	NULL
+};
+
+static struct attribute_group dev_attr_group = {
+	.attrs = dev_attributes
+};
+
+/**
+ * ipath_expose_reset - create a device reset file
+ * @dev: the device structure
+ *
+ * Only expose a file that lets us reset the device after someone
+ * enters diag mode.  A device reset is quite likely to crash the
+ * machine entirely, so we don't want to normally make it
+ * available.
+ */
+int ipath_expose_reset(struct device *dev)
+{
+	return device_create_file(dev, &dev_attr_reset);
+}
+
+int ipath_driver_create_group(struct device_driver *drv)
+{
+	int ret;
+
+	ret = sysfs_create_group(&drv->kobj, &driver_attr_group);
+	if (ret)
+		goto bail;
+
+	ret = sysfs_create_group(&drv->kobj, &driver_stat_attr_group);
+	if (ret)
+		sysfs_remove_group(&drv->kobj, &driver_attr_group);
+
+bail:
+	return ret;
+}
+
+void ipath_driver_remove_group(struct device_driver *drv)
+{
+	sysfs_remove_group(&drv->kobj, &driver_stat_attr_group);
+	sysfs_remove_group(&drv->kobj, &driver_attr_group);
+}
+
+int ipath_device_create_group(struct device *dev, struct ipath_devdata *dd)
+{
+	int ret;
+	char unit[5];
+
+	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
+	if (ret)
+		goto bail;
+
+	ret = sysfs_create_group(&dev->kobj, &dev_counter_attr_group);
+	if (ret)
+		goto bail_attrs;
+
+	snprintf(unit, sizeof(unit), "%02d", dd->ipath_unit);
+	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj, unit);
+	if (ret == 0)
+		goto bail;
+
+	sysfs_remove_group(&dev->kobj, &dev_counter_attr_group);
+bail_attrs:
+	sysfs_remove_group(&dev->kobj, &dev_attr_group);
+bail:
+	return ret;
+}
+
+void ipath_device_remove_group(struct device *dev, struct ipath_devdata *dd)
+{
+	char unit[5];
+
+	snprintf(unit, sizeof(unit), "%02d", dd->ipath_unit);
+	sysfs_remove_link(&dev->driver->kobj, unit);
+
+	sysfs_remove_group(&dev->kobj, &dev_counter_attr_group);
+	sysfs_remove_group(&dev->kobj, &dev_attr_group);
+
+	device_remove_file(dev, &dev_attr_reset);
+}
