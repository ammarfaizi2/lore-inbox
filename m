Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265257AbSJWXS5>; Wed, 23 Oct 2002 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265265AbSJWXS5>; Wed, 23 Oct 2002 19:18:57 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:20467 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265257AbSJWXSb>; Wed, 23 Oct 2002 19:18:31 -0400
Message-ID: <3DB7304A.3030903@mvista.com>
Date: Wed, 23 Oct 2002 16:27:06 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, alan@lxorquk.ukuu.org.uk
Subject: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml,

Attached is an update of the Advanced TCA disk hotswap driver to provide 
disk hotswap
support for the Linux Kernel 2.5.43.  Hotswap targets include both SCSI 
and FibreChannel.
Note this support is generic in that it will work in a typical PC system 
with SCSI or
FibreChannel disks.

I've not yet ported or made suggested changes to the ga mapping driver 
yet.  I'll work on
that next.

As always, the latest Advanced TCA hotswap patches are available for 
Linux 2.4 and Linux 2.5
at the sourceforge site: (please note ga mapper hasn't yet been ported 
to 2.5)
http://sourceforge.net/project/showfiles.php?group_id=64580

Changes from kernel 2.4.19 to 2.5.44 release:
* Complete port to linux kernel 2.5.44
* Locking of scsi_host->host_queue structure when traversing scsi device 
list (suggested by Alan Cox)
   - This keeps multiple hotswap commands from corrupting the SCSI 
device list and
     causing system failure
* ioctls deleted and replaced by ramfs scsi_hotswap_fs (suggested by 
Greg KH)
   - removes need for character device node
   - usage information available by read() call to files
   - available over nfs exported directories
* local file-scope functions declared as static instead of global 
(suggested by Greg KH)
* code reformatted to fit on 80 character wide screen and to follow 
linux general kernel
   instead of scsi subsystem format
* KERNEL_SYSCALLS define removed from header (suggested by Greg KH)
* list of include files optimized to only include files as needed
* Removed direct call from scsi.c into scsi_hotswap_init and used 
module_init instead
* Made modular so can be compiled as a module or in the kernel directly
* Fixed bug where scsi_hotswap_insert_by_scsi_id didn't properly add a 
device in some cases


******************************************************


diff -uNr linux-2.5.44-qla/MAINTAINERS 
linux-2.5.44-scsi-hotswap/MAINTAINERS
--- linux-2.5.44-qla/MAINTAINERS    Fri Oct 18 21:01:59 2002
+++ linux-2.5.44-scsi-hotswap/MAINTAINERS    Wed Oct 23 11:44:05 2002
@@ -1418,6 +1418,12 @@
W:    http://www.kernel.dk
S:    Maintained

+SCSI HOTSWAP DRIVER
+P:    Steven Dake
+M:    sdake@mvista.com
+L:    linux-kernel@vger.kernel.org
+S:    Maintained
+
SCSI SG DRIVER
P:    Doug Gilbert
M:    dgilbert@interlog.com
diff -uNr linux-2.5.44-qla/drivers/scsi/Config.help 
linux-2.5.44-scsi-hotswap/drivers/scsi/Config.help
--- linux-2.5.44-qla/drivers/scsi/Config.help    Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Config.help    Wed Oct 23 
11:44:06 2002
@@ -34,6 +34,17 @@
  is located on a SCSI disk. In this case, do not compile the driver
  for your SCSI host adapter (below) as a module either.

+CONFIG_SCSIFCHOTSWAP
+ If you want to support the ability to include the hotswap FibreChannel
+ and SCSI driver, please say yes here.  Hotswap can then be executed
+ through a ramfs interface which provides better error reporting.
+
+ Further, this interface supports insertion and removal by WWN for
+ FibreChannel drivers which support this feature.
+
+ The only FibreChannel driver that supports this feature is Qlogic V6
+ with a specific support patch.
+
CONFIG_SD_EXTRA_DEVS
  This controls the amount of additional space allocated in tables for
  drivers that are loaded as modules after the kernel is booted.  In
diff -uNr linux-2.5.44-qla/drivers/scsi/Config.in 
linux-2.5.44-scsi-hotswap/drivers/scsi/Config.in
--- linux-2.5.44-qla/drivers/scsi/Config.in    Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Config.in    Wed Oct 23 
11:44:06 2002
@@ -1,5 +1,6 @@
comment 'SCSI support type (disk, tape, CD-ROM)'

+dep_tristate '  SCSI hotswap support' CONFIG_SCSIFCHOTSWAP $CONFIG_SCSI
dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI

if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
diff -uNr linux-2.5.44-qla/drivers/scsi/Makefile 
linux-2.5.44-scsi-hotswap/drivers/scsi/Makefile
--- linux-2.5.44-qla/drivers/scsi/Makefile    Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Makefile    Wed Oct 23 
11:44:06 2002
@@ -117,6 +117,7 @@

obj-$(CONFIG_ARCH_ACORN)    += ../acorn/scsi/

+obj-$(CONFIG_SCSIFCHOTSWAP)    += hotswap.o
obj-$(CONFIG_CHR_DEV_ST)    += st.o
obj-$(CONFIG_CHR_DEV_OSST)    += osst.o
obj-$(CONFIG_BLK_DEV_SD)    += sd_mod.o
diff -uNr linux-2.5.44-qla/drivers/scsi/hosts.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c
--- linux-2.5.44-qla/drivers/scsi/hosts.c    Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c    Wed Oct 23 
15:35:30 2002
@@ -371,6 +371,7 @@
    scsi_hosts_registered++;

    spin_lock_init(&shost->default_lock);
+    spin_lock_init(&shost->host_queue_lock);
    scsi_assign_lock(shost, &shost->default_lock);
    atomic_set(&shost->host_active,0);

diff -uNr linux-2.5.44-qla/drivers/scsi/hosts.h 
linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.h
--- linux-2.5.44-qla/drivers/scsi/hosts.h    Fri Oct 18 21:01:21 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.h    Wed Oct 23 
15:24:39 2002
@@ -264,6 +264,14 @@
     */
    int (* bios_param)(Disk *, struct block_device *, int []);

+#ifdef CONFIG_SCSIFCHOTSWAP
+    /*
+     * Used to determine the id to send the inquiry command to during
+     * hot additions of FibreChannel targets
+     */
+    int (*get_scsi_info_from_wwn)(int mode, unsigned long long wwn, int 
*host, int *channel, int *lun, int *id);
+#endif
+
    /*
     * This determines if we will use a non-interrupt driven
     * or an interrupt driven scheme,  It is set to the maximum number
@@ -374,6 +382,7 @@
     */
    struct list_head      sh_list;
    Scsi_Device           * host_queue;
+    spinlock_t          host_queue_lock;
    struct list_head      all_scsi_hosts;
    struct list_head      my_devices;

diff -uNr linux-2.5.44-qla/drivers/scsi/hotswap.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/hotswap.c
--- linux-2.5.44-qla/drivers/scsi/hotswap.c    Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hotswap.c    Wed Oct 23 
15:28:15 2002
@@ -0,0 +1,1334 @@
+/*
+ * hotswap.c
+ *
+ * SCSI/FibreChannel Hotswap kernel implementaton
+ * + * Author: MontaVista Software, Inc.
+ *         Steven Dake (sdake@mvista.com)
+ *         source@mvista.com
+ *
+ * Copyright (C) 2002 MontaVista Software Inc.
+ *
+ * Derived from linux/scsi/scsi.c hotswap code
+ *
+ *     added FibreChannel hotswap by both WWN/host/channel/lun and WWN 
wildcard
+ *     added ramfs interface
+ *     added locking to scsi host queue structure (list of scsi devices 
on host)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Library General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
DAMAGE.
+ *
+ *  You should have received a copy of the GNU Library General Public
+ *  License along with this program; if not, write to the Free
+ *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/types.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/blk.h>
+#include <linux/spinlock.h>
+
+#include <asm/uaccess.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include <linux/scsi_hotswap.h>
+
+#define SCSI_HOTSWAP_MAGIC 0x02834431
+
+#define DRIVER_VERSION "0.9"
+#define DRIVER_AUTHOR "MontaVista Software Inc, Steven Dake 
<sdake@mvista.com>"
+#define DRIVER_DESCRIPTION "SCSI and FibreChannel Hotswap Core"
+
+static struct cmd_fs {
+    struct dentry *insert_by_scsi_id;
+    struct dentry *remove_by_scsi_id;
+    struct dentry *insert_by_fc_wwn;
+    struct dentry *remove_by_fc_wwn;
+    struct dentry *insert_by_fc_wwn_wildcard;
+    struct dentry *remove_by_fc_wwn_wildcard;
+} scsi_hotswap_cmd_fs;
+
+static struct super_operations scsi_hotswap_super_operations;
+static struct file_operations default_file_operations;
+static struct inode_operations scsi_hotswap_dir_inode_operations;
+
+static struct vfsmount *scsi_hotswap_mountpoint;
+
+/*
+ * Default file operations
+ */
+static int scsi_hotswap_statfs (struct super_block *sb, struct statfs 
*buf)
+{
+    buf->f_type = SCSI_HOTSWAP_MAGIC;
+    buf->f_bsize = PAGE_CACHE_SIZE;
+    buf->f_namelen = 255;
+    return (0);
+}
+
+static struct dentry *scsi_hotswap_lookup (struct inode *dir,
+    struct dentry *dentry)
+{
+    d_add (dentry, NULL);
+    return (NULL);
+}
+
+static struct inode *scsi_hotswap_get_inode (struct super_block *sb, 
int mode,
+    int dev)
+{
+    struct inode *inode = new_inode(sb);
+
+    if (inode) {
+        inode->i_mode = mode;
+        inode->i_uid = current->fsuid;
+        inode->i_gid = current->fsgid;
+        inode->i_blksize = PAGE_CACHE_SIZE;
+        inode->i_blocks = 0;
+        inode->i_rdev = NODEV;
+        inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+        switch (mode & S_IFMT) {
+        default:
+            init_special_inode (inode, mode, dev);
+            break;
+
+        case S_IFREG:
+            inode->i_fop = &default_file_operations;
+            break;
+        case S_IFDIR:
+            inode->i_op = &scsi_hotswap_dir_inode_operations;
+            inode->i_fop = &simple_dir_operations;
+            inode->i_nlink++;
+            break;
+        }
+    }
+    return (inode);
+}
+
+static int scsi_hotswap_mknod (struct inode *dir, struct dentry *dentry,
+    int mode, int dev)
+{
+    struct inode *inode = scsi_hotswap_get_inode (dir->i_sb, mode, dev);
+    int error = -ENOSPC;
+
+    if (inode) {
+        d_instantiate (dentry, inode);
+        dget (dentry);
+        error = 0;
+    }
+    return (error);
+}
+
+static int scsi_hotswap_mkdir (struct inode *dir, struct dentry *dentry,
+    int mode)
+{
+    return (scsi_hotswap_mknod (dir, dentry, mode | S_IFDIR, 0));
+}
+
+static int scsi_hotswap_create (struct inode *dir, struct dentry *dentry,
+    int mode)
+{
+    return (scsi_hotswap_mknod (dir, dentry, mode | S_IFREG, 0));
+}
+
+static int scsi_hotswap_link (struct dentry *old_dentry, struct inode 
*dir,
+    struct dentry *dentry)
+{
+    struct inode *inode = old_dentry->d_inode;
+
+    if (S_ISDIR(inode->i_mode)) {
+        return (-EPERM);
+    }
+
+    inode->i_nlink++;
+    atomic_inc (&inode->i_count);
+    dget (dentry);
+    d_instantiate (dentry, inode);
+
+    return (0);
+}
+
+static inline int scsi_hotswap_positive (struct dentry *dentry)
+{
+    return (dentry->d_inode && !d_unhashed (dentry));
+}
+
+static int scsi_hotswap_empty (struct dentry *dentry)
+{
+    struct list_head *list;
+
+    spin_lock(&dcache_lock);
+
+    list_for_each (list, &dentry->d_subdirs) {
+        struct dentry *de = list_entry(list, struct dentry, d_child);
+        if (scsi_hotswap_positive (de)) {
+            spin_unlock (&dcache_lock);
+            return 0;
+        }
+        }
+
+    spin_unlock(&dcache_lock);
+    return (1);
+}
+
+static int scsi_hotswap_unlink (struct inode *dir, struct dentry *dentry)
+{
+    int error = -ENOTEMPTY;
+
+    if (scsi_hotswap_empty (dentry)) {
+        struct inode *inode = dentry->d_inode;
+
+        inode->i_nlink--;
+        dput (dentry);
+        error = 0;
+    }
+    return (error);
+}
+
+static int scsi_hotswap_rename (struct inode *old_dir,
+    struct dentry *old_dentry, struct inode *new_dir,
+    struct dentry *new_dentry)
+{
+    int error = -ENOTEMPTY;
+
+    if (scsi_hotswap_empty (new_dentry)) {
+        struct inode *inode = new_dentry->d_inode;
+        if (inode) {
+            inode->i_nlink--;
+            dput (new_dentry);
+        }
+        error = 0;
+    }
+
+    return (error);
+}
+
+#define scsi_hotswap_rmdir scsi_hotswap_unlink
+
+static ssize_t default_read_file (struct file *file, char *buf, size_t 
count,
+    loff_t *ppos)
+{
+    return (0);
+}
+
+static ssize_t default_write_file (struct file *file, const char *buf,
+    size_t count, loff_t *ppos)
+{
+    return (count);
+}
+
+static loff_t default_file_lseek (struct file *file, loff_t offset, int 
orig)
+{
+    loff_t retval = -EINVAL;
+
+    switch(orig) {
+    case 0:
+        if (offset > 0) {
+            file->f_pos = offset;
+            retval = file->f_pos;
+        }
+        break;
+    case 1:
+        if ((offset + file->f_pos) > 0) {
+            file->f_pos += offset;
+            retval = file->f_pos;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return (retval);
+}
+
+static int default_open (struct inode *inode, struct file *filp)
+{
+    if (inode->u.generic_ip) {
+        filp->private_data = inode->u.generic_ip;
+    }
+    return (0);
+}
+
+static int default_sync_file (struct file *file, struct dentry *dentry,
+    int datasync)
+{
+    return (0);
+}
+
+static struct file_operations default_file_operations = {
+    read:        default_read_file,
+    write:         default_write_file,
+    open:        default_open,
+    llseek:        default_file_lseek,
+    fsync:         default_sync_file,
+    mmap:         generic_file_mmap,
+};
+
+static struct inode_operations scsi_hotswap_dir_inode_operations = {
+    create:        scsi_hotswap_create,
+    lookup:        scsi_hotswap_lookup,
+    link:        scsi_hotswap_link,
+    unlink:        scsi_hotswap_unlink,
+    mkdir:        scsi_hotswap_mkdir,
+    rmdir:        scsi_hotswap_rmdir,
+    mknod:        scsi_hotswap_mknod,
+    rename:        scsi_hotswap_rename,
+};
+
+static struct super_operations scsi_hotswap_super_operations = {
+    statfs:        scsi_hotswap_statfs,
+    drop_inode:    generic_delete_inode,
+/* IFDEF LINUX-2.4 +    put_inode:    force_delete,
+*/
+};
+
+/*
+ * scsi_hotswap_insert_by_scsi_id file operations structure
+ */
+static ssize_t scsi_hotswap_insert_by_scsi_id_read_file (struct file 
*file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_insert_by_scsi_id_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_insert_by_scsi_id_file_operations = {
+    read:    scsi_hotswap_insert_by_scsi_id_read_file,
+    write:    scsi_hotswap_insert_by_scsi_id_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+
+/*
+ * scsi_hotswap_remove_by_scsi_id file operations structure
+ */
+static ssize_t scsi_hotswap_remove_by_scsi_id_read_file (struct file 
*file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_remove_by_scsi_id_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_remove_by_scsi_id_file_operations = {
+    read:    scsi_hotswap_remove_by_scsi_id_read_file,
+    write:    scsi_hotswap_remove_by_scsi_id_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+
+/*
+ * scsi_hotswap_insert_by_fc_wwn file operations structure
+ */
+static ssize_t scsi_hotswap_insert_by_fc_wwn_read_file (struct file *file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_insert_by_fc_wwn_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_insert_by_fc_wwn_file_operations = {
+    read:    scsi_hotswap_insert_by_fc_wwn_read_file,
+    write:    scsi_hotswap_insert_by_fc_wwn_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+
+/*
+ * scsi_hotswap_remove_by_fc_wwn file operations structure
+ */
+static ssize_t scsi_hotswap_remove_by_fc_wwn_read_file (struct file *file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_remove_by_fc_wwn_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_remove_by_fc_wwn_file_operations = {
+    read:    scsi_hotswap_remove_by_fc_wwn_read_file,
+    write:    scsi_hotswap_remove_by_fc_wwn_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+/*
+ * scsi_hotswap_insert_by_fc_wwn_wildcard file operations structure
+ */
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_read_file (struct 
file *file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_write_file 
(struct file *file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_insert_by_fc_wwn_wildcard_file_operations = {
+    read:    scsi_hotswap_insert_by_fc_wwn_wildcard_read_file,
+    write:    scsi_hotswap_insert_by_fc_wwn_wildcard_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+
+/*
+ * scsi_hotswap_remove_by_fc_wwn_wildcard file operations structure
+ */
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_read_file (struct 
file *file,
+    char *buf, size_t count, loff_t *offset);
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_write_file 
(struct file *file,
+    const char *buf, size_t count, loff_t *ppos);
+
+static struct file_operations 
scsi_hotswap_remove_by_fc_wwn_wildcard_file_operations = {
+    read:    scsi_hotswap_remove_by_fc_wwn_wildcard_read_file,
+    write:    scsi_hotswap_remove_by_fc_wwn_wildcard_write_file,
+    open:    default_open,
+    llseek:    default_file_lseek,
+    fsync:    default_sync_file,
+    mmap:    generic_file_mmap
+};
+
+//static struct super_block *scsi_hotswap_read_super (struct 
super_block *sb, void *data, int silet) {
+static int scsi_hotswap_fill_super (struct super_block *sb, void *data,
+    int silet)
+{
+    struct inode *inode;
+    struct dentry *root;
+
+    sb->s_blocksize = PAGE_CACHE_SIZE;
+    sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+    sb->s_magic = SCSI_HOTSWAP_MAGIC;
+    sb->s_op = &scsi_hotswap_super_operations;
+    inode = scsi_hotswap_get_inode (sb, S_IFDIR | 0755, 0);
+
+    if (inode == 0) {
+        return (-ENOMEM);
+    }
+
+    root = d_alloc_root (inode);
+    if (root == 0) {
+        iput(inode);
+        return (-ENOMEM);
+    }
+    sb->s_root = root;
+
+    return (0);
+}
+
+static struct super_block *scsi_hotswap_get_sb (struct file_system_type 
*fs_type,
+    int flags, char *dev_name, void *data)
+{
+    return (get_sb_single (fs_type, flags, data, 
scsi_hotswap_fill_super));
+}   
+
+static struct file_system_type scsi_hotswap_fs_type = {
+    owner:        THIS_MODULE,
+    name:        "scsi_hotswap_fs",
+    get_sb:        scsi_hotswap_get_sb,
+    kill_sb:    kill_litter_super,
+};
+
+static int scsi_hotswap_fs_create_by_name (const char *name, mode_t mode,
+    struct dentry *parent, struct dentry **dentry)
+{
+    struct dentry *d = NULL;
+    struct qstr qstr;
+    int error;
+
+    if (parent == 0) {
+        parent = scsi_hotswap_mountpoint->mnt_sb->s_root;
+    }
+
+    if (parent == 0) {
+        return (-EINVAL);
+    }
+
+    *dentry = NULL;
+    qstr.name = name;
+    qstr.len = strlen (name);
+    qstr.hash = full_name_hash (name, qstr.len);
+
+    parent = dget (parent);
+
+    down (&parent->d_inode->i_sem);
+
+    d = lookup_hash (&qstr, parent);
+
+    error = PTR_ERR (d);
+    if (IS_ERR(d) == 0) {
+        switch (mode & S_IFMT) {
+            case 0:
+            case S_IFREG:
+                error = vfs_create (parent->d_inode, d, mode);
+                break;
+            case S_IFDIR:
+                error = vfs_mkdir (parent->d_inode, d, mode);
+                break;
+            default:
+                error = -EINVAL;
+        }
+        *dentry = d;
+    }
+    up (&parent->d_inode->i_sem);
+
+    dput (parent);
+
+    return (error);
+}
+
+static struct dentry *scsi_hotswap_fs_create_file (const char *name,
+    mode_t mode, struct dentry *parent,
+    struct file_operations *file_operations)
+{
+    struct dentry *dentry;
+    int error;
+
+    error = scsi_hotswap_fs_create_by_name (name, mode, parent, &dentry);
+    if (error) {
+        dentry = 0;
+    } else {
+        if (dentry->d_inode) {
+            if (file_operations) {
+                dentry->d_inode->i_fop = file_operations;
+            }
+        }
+    }
+
+    return (dentry);
+}
+
+static void fs_remove_file (struct dentry *dentry) {
+    struct dentry *parent = dentry->d_parent;
+
+    if (!parent || !parent->d_inode) {
+        return;
+    }
+
+    down (&parent->d_inode->i_sem);
+
+    if (scsi_hotswap_positive (dentry)) {
+        if (dentry->d_inode) {
+            if (S_ISDIR (dentry->d_inode->i_mode)) {
+                vfs_rmdir (parent->d_inode,dentry);
+            } else {
+                vfs_unlink (parent->d_inode,dentry);
+            }
+        }
+        dput (dentry);
+    }
+    up (&parent->d_inode->i_sem);
+}
+
+/*
+ * Core file read/write operations interfaces
+ */
+static char scsi_hotswap_insert_by_scsi_id_usage[] = {
+    "Usage: echo \"[host] [channel] [lun] [id]\" > insert_by_scsi_id\n"
+};
+
+static char scsi_hotswap_remove_by_scsi_id_usage[] = {
+    "Usage: echo \"[host] [channel] [lun] [id]\" > remove_by_scsi_id\n"
+};
+
+static char scsi_hotswap_insert_by_fc_wwn_usage[]  = {
+    "Usage: echo \"[host] [channel] [lun] [wwn]\" > insert_by_fc_wwn\n"
+};
+
+static char scsi_hotswap_remove_by_fc_wwn_usage[]  = {
+    "Usage: echo \"[host] [channel] [lun] [wwn]\" > remove_by_fc_wwn\n"
+};
+
+static char scsi_hotswap_insert_by_fc_wwn_wildcard_usage[]  = {
+    "Usage: echo \"[wwn]\" > insert_by_fc_wwn_wildcard\n"
+};
+
+static char scsi_hotswap_remove_by_fc_wwn_wildcard_usage[]  = {
+    "Usage: echo \"[wwn]\" > remove_by_fc_wwn_wildcard\n"
+};
+
+static ssize_t scsi_hotswap_insert_by_scsi_id_read_file (struct file 
*file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_insert_by_scsi_id_usage);
+    if (copy_to_user (buf, scsi_hotswap_insert_by_scsi_id_usage, len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_scsi_id_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    int host, channel, lun, id;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    host = simple_strtoul (p, &p, 0);
+    channel = simple_strtoul (p + 1, &p, 0);
+    lun = simple_strtoul (p + 1, &p, 0);
+    id = simple_strtoul (p + 1, &p, 0);
+
+    result = scsi_hotswap_insert_by_scsi_id (host, channel, lun, id);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+}
+
+static ssize_t scsi_hotswap_remove_by_scsi_id_read_file (struct file 
*file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_remove_by_scsi_id_usage);
+    if (copy_to_user (buf, scsi_hotswap_remove_by_scsi_id_usage, len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_scsi_id_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    int host, channel, lun, id;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    host = simple_strtoul (p, &p, 0);
+    channel = simple_strtoul (p + 1, &p, 0);
+    lun = simple_strtoul (p + 1, &p, 0);
+    id = simple_strtoul (p + 1, &p, 0);
+
+    result = scsi_hotswap_remove_by_scsi_id (host, channel, lun, id);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+    return (-ENOMEM);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_read_file (struct file *file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_insert_by_fc_wwn_usage);
+    if (copy_to_user (buf, scsi_hotswap_insert_by_fc_wwn_usage, len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    int host, channel, lun;
+    unsigned long long wwn;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    host = simple_strtoul (p, &p, 0);
+    channel = simple_strtoul (p + 1, &p, 0);
+    lun = simple_strtoul (p + 1, &p, 0);
+    wwn = simple_strtoull (p + 1, &p, 0);
+
+    result = scsi_hotswap_insert_by_fc_wwn (host, channel, lun, wwn);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_read_file (struct file *file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_remove_by_fc_wwn_usage);
+
+    if (copy_to_user (buf, scsi_hotswap_remove_by_fc_wwn_usage, len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_write_file (struct file 
*file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    int host, channel, lun;
+    unsigned long long wwn;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    host = simple_strtoul (p, &p, 0);
+    channel = simple_strtoul (p + 1, &p, 0);
+    lun = simple_strtoul (p + 1, &p, 0);
+    wwn = simple_strtoull (p + 1, &p, 0);
+
+    result = scsi_hotswap_remove_by_fc_wwn (host, channel, lun, wwn);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_read_file (struct 
file *file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_insert_by_fc_wwn_wildcard_usage);
+    if (copy_to_user (buf, scsi_hotswap_insert_by_fc_wwn_wildcard_usage,
+        len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_write_file 
(struct file *file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    unsigned long long wwn;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    wwn = simple_strtoull (p, &p, 0);
+
+    result = scsi_hotswap_insert_by_fc_wwn_wildcard (wwn);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+    return (-ENOMEM);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_read_file (struct 
file *file,
+    char *buf, size_t count, loff_t *offset)
+{
+    int len;
+
+    if (*offset) {
+        return (0);
+    }
+    len = strlen (scsi_hotswap_remove_by_fc_wwn_wildcard_usage);
+    if (copy_to_user (buf, scsi_hotswap_remove_by_fc_wwn_wildcard_usage,
+        len)) {
+        return (-EFAULT);
+    }
+
+    *offset += len;
+    return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_write_file 
(struct file *file,
+    const char *buf, size_t count, loff_t *ppos)
+{
+    unsigned long long wwn;
+    char parameters[1024];
+    char *p;
+    int result;
+
+    if (count == 0 || count > 1024) {
+        return (0);
+    }
+
+    if (copy_from_user ((void *)parameters, (void *)buf, count)) {
+        return (-EFAULT);
+    }
+
+    p = parameters;
+    wwn = simple_strtoull (p, &p, 0);
+
+    result = scsi_hotswap_remove_by_fc_wwn_wildcard (wwn);
+
+    if (result) {
+        return (result);
+    }
+    return (count);
+}
+
+/*
+ * Core Interface Implementation
+ * Note these are exported to the global symbol table for
+ * other subsystems to use such as a scsi processor or 1394
+ */
+int scsi_hotswap_insert_by_scsi_id (unsigned int host, unsigned int 
channel,
+    unsigned int lun, unsigned int id)
+{
+    struct Scsi_Host *scsi_host;
+    Scsi_Device *scsi_device;
+
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        if (scsi_host->host_no == host) {
+            break;
+        }
+    }
+    if (scsi_host == 0) {
+        return (-ENXIO);
+    }
+
+    spin_lock (&scsi_host->host_queue_lock);
+
+    /*
+     * Determine if device already attached
+     */
+    for (scsi_device = scsi_host->host_queue; scsi_device; scsi_device 
= scsi_device->next) {
+        if ((scsi_device->channel == channel
+             && scsi_device->id == id
+             && scsi_device->lun == lun)) {
+            break;
+        }
+    }
+   
+    spin_unlock (&scsi_host->host_queue_lock);
+
+    /*
+     * If scsi_device found in host queue, then device already attached
+     */
+    if (scsi_device) {
+        return (-EEXIST);
+    }
+
+    scan_scsis(scsi_host, 1, channel, id, lun);
+
+    return (0);
+}
+
+int scsi_hotswap_remove_by_scsi_id (unsigned int host, unsigned int 
channel,
+    unsigned int lun, unsigned int id)
+{
+    struct Scsi_Device_Template *scsi_template;
+    struct Scsi_Host *scsi_host;
+    Scsi_Device *scsi_device;
+
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        if (scsi_host->host_no == host) {
+            break;
+        }
+    }
+    if (scsi_host == 0) {
+        return (-ENODEV);
+    }
+
+    spin_lock (&scsi_host->host_queue_lock);
+
+    for (scsi_device = scsi_host->host_queue; scsi_device;
+        scsi_device = scsi_device->next) {
+        if ((scsi_device->channel == channel
+             && scsi_device->id == id
+             && scsi_device->lun == lun)) {
+            break;
+        }
+    }
+
+    spin_unlock (&scsi_host->host_queue_lock);
+
+    if (scsi_device == NULL) {
+        return (-ENOENT);
+    }
+
+    if (scsi_device->access_count) {
+        return (-EBUSY);
+    }
+
+    for (scsi_template = scsi_devicelist; scsi_template; scsi_template 
= scsi_template->next) {
+        if (scsi_template->detach) {
+            (*scsi_template->detach) (scsi_device);
+        }
+    }
+
+    if (scsi_device->attached == 0) {
+        /*
+         * Nobody is using this device any more.
+         * Free all of the command structures.
+         */
+        if (scsi_host->hostt->revoke)
+            scsi_host->hostt->revoke(scsi_device);
+        devfs_unregister (scsi_device->de);
+        scsi_release_commandblocks(scsi_device);
+
+        /* Now we can remove the device structure */
+        if (scsi_device->next != NULL)
+            scsi_device->next->prev = scsi_device->prev;
+
+        if (scsi_device->prev != NULL)
+            scsi_device->prev->next = scsi_device->next;
+
+        if (scsi_host->host_queue == scsi_device) {
+            scsi_host->host_queue = scsi_device->next;
+        }
+        blk_cleanup_queue(&scsi_device->request_queue);
+        kfree((char *) scsi_device);
+    }
+
+    return (0);
+}
+
+int scsi_hotswap_insert_by_fc_wwn (unsigned int host, unsigned int 
channel,
+    unsigned int lun, unsigned long long wwn)
+{
+    struct Scsi_Host *scsi_host;
+    Scsi_Device *scsi_device;
+    int id;
+    int result;
+
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        if (scsi_host->host_no == host) {
+            break;
+        }
+    }
+
+    if (scsi_host == 0) {
+        return (-ENXIO);
+    }
+
+    result = scsi_host->hostt->get_scsi_info_from_wwn (0, wwn, &host,
+        &channel, &lun, &id);
+    /*
+     * Nonzero result indicates error
+     */
+    if (result) {
+        return (result);
+    }
+
+    /*
+     * Determine if device already attached
+     */
+    spin_lock (&scsi_host->host_queue_lock);
+
+    for (scsi_device = scsi_host->host_queue; scsi_device;
+        scsi_device = scsi_device->next) {
+        if ((scsi_device->channel == channel
+             && scsi_device->id == id
+             && scsi_device->lun == lun)) {
+            break;
+        }
+    }
+
+    spin_unlock (&scsi_host->host_queue_lock);
+
+    /*
+     * If scsi_device found in host queue, then device already attached
+     */
+    if (scsi_device) {
+        return (-EEXIST);
+    }
+
+    scan_scsis (scsi_host, 1, channel, id, lun);
+    return (0);
+}
+
+int scsi_hotswap_remove_by_fc_wwn (unsigned int host, unsigned int 
channel,
+    unsigned int lun, unsigned long long wwn)
+{
+
+    struct Scsi_Device_Template *scsi_template;
+    Scsi_Device *scsi_device;
+    struct Scsi_Host *scsi_host;
+    int id;
+    int result;
+
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        if (scsi_host->host_no == host) {
+            break;
+        }
+    }
+    if (scsi_host == 0) {
+        return (-ENODEV);
+    }
+
+    result = scsi_host->hostt->get_scsi_info_from_wwn (1, wwn, &host,
+        &channel, &lun, &id);
+
+    /*
+     * Nonzero indicates error
+     */
+    if (result) {
+        return (result);
+    }
+
+    spin_lock (&scsi_host->host_queue_lock);
+
+    for (scsi_device = scsi_host->host_queue; scsi_device;
+        scsi_device = scsi_device->next) {
+        if ((scsi_device->channel == channel
+             && scsi_device->id == id
+             && scsi_device->lun == lun)) {
+            break;
+        }
+    }
+
+    spin_unlock (&scsi_host->host_queue_lock);
+
+    if (scsi_device == NULL) {
+        return (-ENOENT);
+    }
+
+    if (scsi_device->access_count) {
+        return (-EBUSY);
+    }
+
+    for (scsi_template = scsi_devicelist; scsi_template; scsi_template 
= scsi_template->next) {
+        if (scsi_template->detach) {
+            (*scsi_template->detach) (scsi_device);
+        }
+    }
+
+    if (scsi_device->attached == 0) {
+        /*
+         * Nobody is using this device any more.
+         * Free all of the command structures.
+         */
+        if (scsi_host->hostt->revoke)
+            scsi_host->hostt->revoke(scsi_device);
+        devfs_unregister (scsi_device->de);
+        scsi_release_commandblocks(scsi_device);
+
+        /* Now we can remove the device structure */
+        if (scsi_device->next != NULL)
+            scsi_device->next->prev = scsi_device->prev;
+
+        if (scsi_device->prev != NULL)
+            scsi_device->prev->next = scsi_device->next;
+
+        if (scsi_host->host_queue == scsi_device) {
+            scsi_host->host_queue = scsi_device->next;
+        }
+        blk_cleanup_queue(&scsi_device->request_queue);
+        kfree((char *) scsi_device);
+    }
+    return (0);
+}
+
+int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long wwn)
+{
+    struct Scsi_Host *scsi_host;
+    Scsi_Device *scsi_device;
+    int host, lun, channel, id;
+    int result;
+
+    /*
+     * Search scsi hostlist +     */
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        /*
+         * Skip unsupported drivers.  This is known because
+         * get_scsi_info_from_wwn would be defined as 0
+         */
+        if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+            continue;
+        }
+       
+        result = scsi_host->hostt->get_scsi_info_from_wwn (0, wwn,
+            &host, &channel, &lun, &id);
+        /*
+         * WWN not found, try next adaptor
+         */
+        if (result == -ENOENT) {
+            continue;
+        }
+
+
+        /*
+         * If the currently scanned host doesn't match the WWN's host ID
+         * try again searching with new host id
+         */
+        if (scsi_host->host_no != host) {
+            continue;
+        }
+
+           
+        /*
+         * Verify we are not inserting an existing device
+         */
+        spin_lock (&scsi_host->host_queue_lock);
+
+        for (scsi_device = scsi_host->host_queue; scsi_device;
+            scsi_device = scsi_device->next) {
+            if ((scsi_device->channel == channel
+                 && scsi_device->id == id
+                 && scsi_device->lun == lun)) {
+                break;
+            }
+        }
+
+        spin_unlock (&scsi_host->host_queue_lock);
+
+        /*
+         * Insertion if no device found
+         */
+        if (scsi_device == 0) {
+            scan_scsis(scsi_host, 1, 0, id, lun);
+            scan_scsis(scsi_host, 1, 1, id, lun);
+            break; /* exit scsi_host scan */
+        }
+    } /* scsi_host scan */
+
+    if (scsi_host == 0) {
+        return (-ENOENT);
+    }
+    return (0);
+}
+
+int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long wwn)
+{
+    struct Scsi_Device_Template *scsi_template;
+    Scsi_Device *scsi_device;
+    struct Scsi_Host *scsi_host;
+    int host, lun, channel, id;
+    int result;
+
+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+        scsi_host = scsi_host_get_next (scsi_host)) {
+        /*
+         * Skip unsupported drivers
+         */
+        if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+            continue;
+        }
+
+        result = scsi_host->hostt->get_scsi_info_from_wwn (1, wwn,
+            &host, &channel, &lun, &id);
+
+        /*
+         * Adaptor not found, try next adaptor +         */
+        if (result) {
+            continue;
+        }
+
+        spin_lock (&scsi_host->host_queue_lock);
+
+        for (scsi_device = scsi_host->host_queue; scsi_device;
+            scsi_device = scsi_device->next) {
+            if ((scsi_device->channel == channel
+                 && scsi_device->id == id
+                 && scsi_device->lun == lun)) {
+                break;
+            }
+        }
+
+        spin_unlock (&scsi_host->host_queue_lock);
+
+        if (scsi_device->access_count) {
+            return (-EBUSY);
+        }
+
+        for (scsi_template = scsi_devicelist; scsi_template;
+            scsi_template = scsi_template->next) {
+            if (scsi_template->detach) {
+                (*scsi_template->detach) (scsi_device);
+            }
+        }
+
+        if (scsi_device->attached == 0) {
+            /*
+             * Nobody is using this device any more.
+             * Free all of the command structures.
+             */
+            if (scsi_host->hostt->revoke)
+                scsi_host->hostt->revoke(scsi_device);
+            devfs_unregister (scsi_device->de);
+            scsi_release_commandblocks(scsi_device);
+
+            /* Now we can remove the device structure */
+            if (scsi_device->next != NULL)
+                scsi_device->next->prev = scsi_device->prev;
+   
+            if (scsi_device->prev != NULL)
+                scsi_device->prev->next = scsi_device->next;
+   
+            if (scsi_host->host_queue == scsi_device) {
+                scsi_host->host_queue = scsi_device->next;
+            }
+            blk_cleanup_queue(&scsi_device->request_queue);
+            kfree((char *) scsi_device);
+        }
+        break; /* Break from scan all hosts since we found match */
+    } /* scan all hosts */
+
+    if (scsi_host == 0) {
+        return (-ENOENT);
+    }
+    return (0);
+}
+
+static int __init scsi_hotswap_init (void) {
+    int result = 0;
+    printk (KERN_INFO "Copyright (C) 2002 MontaVista Software - 
SCSI/FibreChannel hotswap driver\n");
+
+    /*
+     * Register the filesystem
+     */
+    result = register_filesystem (&scsi_hotswap_fs_type);
+
+    /*
+     * Mount the filesystem
+     */
+    scsi_hotswap_mountpoint = kern_mount (&scsi_hotswap_fs_type);
+    if (IS_ERR (scsi_hotswap_mountpoint)) {
+        return (-ENODEV);
+    }
+    mntget (scsi_hotswap_mountpoint);
+
+    /*
+     * Create file command entries in filesystem
+     */
+    scsi_hotswap_cmd_fs.insert_by_scsi_id = scsi_hotswap_fs_create_file 
("insert_by_scsi_id",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_insert_by_scsi_id_file_operations);
+
+    scsi_hotswap_cmd_fs.remove_by_scsi_id = scsi_hotswap_fs_create_file 
("remove_by_scsi_id",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_remove_by_scsi_id_file_operations);
+
+    scsi_hotswap_cmd_fs.insert_by_fc_wwn = scsi_hotswap_fs_create_file 
("insert_by_fc_wwn",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_insert_by_fc_wwn_file_operations);
+
+    scsi_hotswap_cmd_fs.remove_by_fc_wwn = scsi_hotswap_fs_create_file 
("remove_by_fc_wwn",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_remove_by_fc_wwn_file_operations);
+
+    scsi_hotswap_cmd_fs.insert_by_fc_wwn_wildcard = 
scsi_hotswap_fs_create_file ("insert_by_fc_wwn_wildcard",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_insert_by_fc_wwn_wildcard_file_operations);
+
+    scsi_hotswap_cmd_fs.remove_by_fc_wwn_wildcard = 
scsi_hotswap_fs_create_file ("remove_by_fc_wwn_wildcard",
+        S_IFREG | S_IRUGO | S_IWUSR,
+        NULL, &scsi_hotswap_remove_by_fc_wwn_wildcard_file_operations);
+
+    return (result);
+}
+
+static void __exit scsi_hotswap_exit (void) {
+    /*
+     * Delete all files in filesystem
+     */
+    fs_remove_file (scsi_hotswap_cmd_fs.insert_by_scsi_id);
+    fs_remove_file (scsi_hotswap_cmd_fs.remove_by_scsi_id);
+    fs_remove_file (scsi_hotswap_cmd_fs.insert_by_fc_wwn);
+    fs_remove_file (scsi_hotswap_cmd_fs.remove_by_fc_wwn);
+    fs_remove_file (scsi_hotswap_cmd_fs.insert_by_fc_wwn_wildcard);
+    fs_remove_file (scsi_hotswap_cmd_fs.remove_by_fc_wwn_wildcard);
+
+    /*
+     * Remove mount
+     */
+    mntput (scsi_hotswap_mountpoint);
+
+    /*
+     * Remove filesystem registration
+     */
+    unregister_filesystem (&scsi_hotswap_fs_type);
+}
+
+module_init(scsi_hotswap_init);
+module_exit(scsi_hotswap_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_LICENSE("GPL");
diff -uNr linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c
--- linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c    Wed Oct 23 
15:47:43 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c    Wed Oct 
23 15:47:03 2002
@@ -244,6 +244,7 @@
STATIC uint8_t  qla2x00_register_with_Linux(scsi_qla_host_t *ha, uint8_t 
maxchannels);
STATIC int   qla2x00_done(scsi_qla_host_t *);
//STATIC void qla2x00_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
+int qla2x00_get_scsi_info_from_wwn (int mode, unsigned long long wwn, 
int *host, int *channel, int *lun, int *id);

STATIC void
qla2x00_timer(scsi_qla_host_t *);
@@ -2037,6 +2038,7 @@
    host->can_queue = max_srbs;  /* default value:-MAX_SRBS(4096)  */
    host->cmd_per_lun = 1;
//    host->select_queue_depths = qla2x00_select_queue_depth;
+    host->hostt->get_scsi_info_from_wwn = qla2x00_get_scsi_info_from_wwn;

    host->n_io_port = 0xFF;

@@ -3989,6 +3991,80 @@
}
#endif

+union wwnmap {
+    unsigned long long wwn;
+    unsigned char wwn_u8[8];
+};
+
+int qla2x00_get_scsi_info_from_wwn (int mode,
+    unsigned long long wwn,
+    int *host,
+    int *channel,
+    int *lun,
+    int *id) {
+
+scsi_qla_host_t *list;
+Scsi_Device *scsi_device;
+union wwnmap wwncompare;
+union wwnmap wwncompare2;
+int i, j, k;
+
+    /*
+     * Retrieve big endian version of world wide name
+     */
+    wwncompare2.wwn = wwn;
+    for (j = 0, k=7; j < 8; j++, k--) {
+        wwncompare.wwn_u8[j] = wwncompare2.wwn_u8[k];
+    }
+
+    /*
+     * query all hosts searching for WWN
+     */
+    for (list = qla2x00_hostlist; list; list = list->next) {
+        for (i = 0; i < MAX_FIBRE_DEVICES; i++) {
+            /*
+             * Scan all devices in FibreChannel database
+             * if WWN match found, return SCSI device information
+             */
+            if (memcmp (wwncompare.wwn_u8, list->fc_db[i].wwn, 8) == 0) {
+                /*
+                 * If inserting, avoid scan for channel and lun 
information
+                 */
+                if (mode == 0) {
+                    *channel = 0;
+                    *lun = 0;
+                    *host = list->host->host_no;
+                    *id = i;
+                    return (0);
+                }
+           
+
+                /*
+                 * WWN matches, find channel and lun information from scsi
+                 * device
+                 */
+                for (scsi_device = list->host->host_queue; scsi_device; 
scsi_device = scsi_device->next) {
+                    if (scsi_device->id == i) {
+                        *channel = scsi_device->channel;
+                        *lun = scsi_device->lun;
+                        break;
+                    }
+                }
+                if (scsi_device == 0) {
+                    return (-ENOENT);
+                }
+                /*
+                 * Device found, return all data
+                 */
+                *host = list->host->host_no;
+                *id = i;
+                return (0);
+            } /* memcmp */
+        } /* i < MAXFIBREDEVICES */
+    }
+    return (-ENOENT);
+}
+
/**************************************************************************
*   qla2x00_select_queue_depth
*
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/scsi.c
--- linux-2.5.44-qla/drivers/scsi/scsi.c    Fri Oct 18 21:01:54 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi.c    Wed Oct 23 15:15:07 
2002
@@ -413,6 +413,9 @@
                 * allow us to more easily figure out whether we should
                 * do anything here or not.
                 */
+
+                spin_lock (&host->host_queue_lock);
+
                for (SDpnt = host->host_queue;
                     SDpnt;
                     SDpnt = SDpnt->next) {
@@ -430,6 +433,9 @@
                                                break;
                                        }
                }
+
+                spin_unlock (&host->host_queue_lock);
+
                if (SDpnt) {
                    /*
                     * Some other device in this cluster is busy.
@@ -1694,6 +1700,8 @@
        len += size;
        pos = begin + len;
#endif
+        spin_lock (&HBA_ptr->host_queue_lock);
+
        for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
            proc_print_scsidevice(scd, buffer, &size, len);
            len += size;
@@ -1706,6 +1714,8 @@
            if (pos > offset + length)
                goto stop_output;
        }
+
+        spin_unlock (&HBA_ptr->host_queue_lock);
    }

stop_output:
@@ -1864,6 +1874,8 @@
        if (!HBA_ptr)
            goto out;

+        spin_lock (&HBA_ptr->host_queue_lock);
+
        for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
            if ((scd->channel == channel
                 && scd->id == id
@@ -1872,6 +1884,8 @@
            }
        }

+        spin_unlock (&HBA_ptr->host_queue_lock);
+
        err = -ENOSYS;
        if (scd)
            goto out;    /* We do not yet support unplugging */
@@ -1910,6 +1924,8 @@
        if (!HBA_ptr)
            goto out;

+        spin_lock (&HBA_ptr->host_queue_lock);
+
        for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
            if ((scd->channel == channel
                 && scd->id == id
@@ -1918,6 +1934,8 @@
            }
        }

+        spin_unlock (&HBA_ptr->host_queue_lock);
+
        if (scd == NULL)
            goto out;    /* there is no such device attached */

@@ -1951,9 +1969,14 @@
            if (scd->prev != NULL)
                scd->prev->next = scd->next;

+            spin_lock (&HBA_ptr->host_queue_lock);
+
            if (HBA_ptr->host_queue == scd) {
                HBA_ptr->host_queue = scd->next;
            }
+
+            spin_unlock (&HBA_ptr->host_queue_lock);
+
            blk_cleanup_queue(&scd->request_queue);
            if (scd->inquiry)
                kfree(scd->inquiry);
@@ -1997,11 +2020,15 @@

    for (shpnt = scsi_host_get_next(NULL); shpnt;
         shpnt = scsi_host_get_next(shpnt)) {
+        spin_lock (&shpnt->host_queue_lock);
+
        for (SDpnt = shpnt->host_queue; SDpnt;
             SDpnt = SDpnt->next) {
            if (tpnt->detect)
                SDpnt->attached += (*tpnt->detect) (SDpnt);
        }
+
+        spin_unlock (&shpnt->host_queue_lock);
    }

    /*
@@ -2017,6 +2044,8 @@
     */
    for (shpnt = scsi_host_get_next(NULL); shpnt;
         shpnt = scsi_host_get_next(shpnt)) {
+        spin_lock (&shpnt->host_queue_lock);
+
        for (SDpnt = shpnt->host_queue; SDpnt;
             SDpnt = SDpnt->next) {
            if (tpnt->attach)
@@ -2032,6 +2061,8 @@
                    out_of_space = 1;
            }
        }
+
+        spin_unlock (&shpnt->host_queue_lock);
    }

    /*
@@ -2068,6 +2099,8 @@

    for (shpnt = scsi_host_get_next(NULL); shpnt;
         shpnt = scsi_host_get_next(shpnt)) {
+        spin_lock (&shpnt->host_queue_lock);
+
        for (SDpnt = shpnt->host_queue; SDpnt;
             SDpnt = SDpnt->next) {
            if (tpnt->detach)
@@ -2084,6 +2117,8 @@
                scsi_release_commandblocks(SDpnt);
            }
        }
+
+        spin_unlock (&shpnt->host_queue_lock);
    }
    /*
     * Extract the template from the linked list.
@@ -2154,6 +2189,8 @@
    for (shpnt = scsi_host_get_next(NULL); shpnt;
         shpnt = scsi_host_get_next(shpnt)) {
        printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all 
flg) (to/cmd to ito) cmd snse result\n");
+        spin_lock (&shpnt->host_queue_lock);
+
        for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
            for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
                /*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all 
flg) (to/cmd to ito) cmd snse result %d %x      */
@@ -2185,6 +2222,8 @@
                       SCpnt->result);
            }
        }
+
+        spin_unlock (&shpnt->host_queue_lock);
    }
#endif    /* CONFIG_SCSI_LOGGING */ /* } */
}
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_error.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_error.c
--- linux-2.5.44-qla/drivers/scsi/scsi_error.c    Fri Oct 18 21:01:07 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_error.c    Wed Oct 23 
11:48:20 2002
@@ -202,6 +202,8 @@
    int devices_failed = 0;


+    spin_lock (&shost->host_queue_lock);
+
    for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
        for (scmd = sc_list; scmd; scmd = scmd->bh_next) {
            if (scmd->device == sdev) {
@@ -227,6 +229,8 @@
        }
    }

+    spin_unlock (&shost->host_queue_lock);
+
    SCSI_LOG_ERROR_RECOVERY(2, printk("Total of %d commands on %d"
                      " devices require eh work\n",
                  total_failures, devices_failed));
@@ -247,6 +251,8 @@
    Scsi_Device *sdev;
    Scsi_Cmnd *scmd;

+    spin_lock (&shost->host_queue_lock);
+
    for (found = 0, sdev = shost->host_queue; sdev; sdev = sdev->next) {
        for (scmd = sdev->device_queue; scmd; scmd = scmd->next) {
            if (scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)) {
@@ -283,6 +289,8 @@
        }
    }

+    spin_unlock (&shost->host_queue_lock);
+
    SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(*sc_list, shost));

    if (shost->host_failed != found)
@@ -962,6 +970,8 @@

    SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Trying BDR\n", __FUNCTION__));

+    spin_lock (&shost->host_queue_lock);
+
    for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
        for (scmd = sc_todo; scmd; scmd = scmd->bh_next)
            if ((scmd->device == sdev) &&
@@ -985,6 +995,7 @@
                            scsi_eh_finish_cmd(scmd, shost);
                    }
    }
+    spin_unlock (&shost->host_queue_lock);

    return shost->host_failed;
}
@@ -1016,11 +1027,15 @@
        /*
         * Mark all affected devices to expect a unit attention.
         */
+        spin_lock (&scmd->host->host_queue_lock);
+
        for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
            if (scmd->channel == sdev->channel) {
                sdev->was_reset = 1;
                sdev->expecting_cc_ua = 1;
            }
+
+        spin_unlock (&scmd->host->host_queue_lock);
    }
    return rtn;
}
@@ -1052,11 +1067,13 @@
        /*
         * Mark all affected devices to expect a unit attention.
         */
+        spin_lock (&scmd->host->host_queue_lock);
        for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
            if (scmd->channel == sdev->channel) {
                sdev->was_reset = 1;
                sdev->expecting_cc_ua = 1;
            }
+        spin_unlock (&scmd->host->host_queue_lock);
    }
    return rtn;
}
@@ -1475,6 +1492,8 @@
     * requests are started.
     */
    spin_lock_irqsave(shost->host_lock, flags);
+    spin_lock (&shost->host_queue_lock);
+
    for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
        request_queue_t *q = &sdev->request_queue;

@@ -1487,6 +1506,8 @@

        q->request_fn(q);
    }
+
+    spin_unlock (&shost->host_queue_lock);
    spin_unlock_irqrestore(shost->host_lock, flags);
}

diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_lib.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_lib.c
--- linux-2.5.44-qla/drivers/scsi/scsi_lib.c    Fri Oct 18 21:01:53 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_lib.c    Wed Oct 23 
11:44:06 2002
@@ -261,6 +261,8 @@
    if (SDpnt->single_lun && blk_queue_empty(q) && SDpnt->device_busy ==0) {
        request_queue_t *q;

+        spin_lock (&SHpnt->host_queue_lock);
+
        for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
            if (((SHpnt->can_queue > 0)
                 && (SHpnt->host_busy >= SHpnt->can_queue))
@@ -273,6 +275,8 @@
            q = &SDpnt->request_queue;
            q->request_fn(q);
        }
+
+        spin_unlock (&SHpnt->host_queue_lock);
    }

    /*
@@ -285,6 +289,7 @@
     */
    all_clear = 1;
    if (SHpnt->some_device_starved) {
+        spin_lock (&SHpnt->host_queue_lock);
        for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
            request_queue_t *q;
            if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= 
SHpnt->can_queue))
@@ -299,6 +304,7 @@
            q->request_fn(q);
            all_clear = 0;
        }
+        spin_unlock (&SHpnt->host_queue_lock);
        if (SDpnt == NULL && all_clear) {
            SHpnt->some_device_starved = 0;
        }
@@ -1038,8 +1044,13 @@

    SHpnt->host_self_blocked = FALSE;
    /* Now that we are unblocked, try to start the queues. */
+
+    spin_lock (&SHpnt->host_queue_lock);
+
    for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
        scsi_queue_next_request(&SDloop->request_queue, NULL);
+
+    spin_unlock (&SHpnt->host_queue_lock);
}

/*
@@ -1066,12 +1077,17 @@
void scsi_report_bus_reset(struct Scsi_Host * SHpnt, int channel)
{
    Scsi_Device *SDloop;
+
+    spin_lock (&SHpnt->host_queue_lock);
+
    for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next) {
        if (channel == SDloop->channel) {
            SDloop->was_reset = 1;
            SDloop->expecting_cc_ua = 1;
        }
    }
+
+    spin_unlock (&SHpnt->host_queue_lock);
}

/*
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_scan.c 
linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_scan.c
--- linux-2.5.44-qla/drivers/scsi/scsi_scan.c    Fri Oct 18 21:02:28 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_scan.c    Wed Oct 23 
11:44:06 2002
@@ -530,6 +530,8 @@
        /*
         * Add it to the end of the shost->host_queue list.
         */
+        spin_lock (&shost->host_queue_lock);
+
        if (shost->host_queue != NULL) {
            sdev->prev = shost->host_queue;
            while (sdev->prev->next != NULL)
@@ -538,6 +540,8 @@
        } else
            shost->host_queue = sdev;

+        spin_unlock (&shost->host_queue_lock);
+
    }
    return (sdev);
}
@@ -554,8 +558,12 @@
{
    if (sdev->prev != NULL)
        sdev->prev->next = sdev->next;
-    else
+    else {
+        spin_lock (&sdev->host->host_queue_lock);
        sdev->host->host_queue = sdev->next;
+        spin_unlock (&sdev->host->host_queue_lock);
+    }
+
    if (sdev->next != NULL)
        sdev->next->prev = sdev->prev;

diff -uNr linux-2.5.44-qla/include/linux/scsi_hotswap.h 
linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h
--- linux-2.5.44-qla/include/linux/scsi_hotswap.h    Wed Dec 31 17:00:00 
1969
+++ linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h    Wed Oct 23 
11:44:06 2002
@@ -0,0 +1,84 @@
+/*
+ * scsi_hotswap.h
+ *
+ * SCSI/FibreChannel Hotswap userland interface to kernel features
+ * + * Author: MontaVista Software, Inc.
+ *         Steven Dake (sdake@mvista.com)
+ *         source@mvista.com
+ *
+ * Copyright (C) 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Library General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
DAMAGE.
+ *
+ *  You should have received a copy of the GNU Library General Public
+ *  License along with this program; if not, write to the Free
+ *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __SCSI_HOTSWAP_H
+#define __SCSI_HOTSWAP_H
+
+/*
+ * Software Interface
+ */
+
+/*
+ * Find a device by host, channel, lun and scsi id and insert it into 
the system
+ */
+extern int scsi_hotswap_insert_by_scsi_id (unsigned int host,
+    unsigned int channel,
+    unsigned int lun,
+    unsigned int id);
+
+/*
+ * Find a device by host, channel, lun and scsi id and remove it from 
the system
+ */
+extern int scsi_hotswap_remove_by_scsi_id (unsigned int host,
+    unsigned int channel,
+    unsigned int lun,
+    unsigned int id);
+
+/*
+ * Find a device by host, channel, lun and wwn and insert it into the 
system
+ */
+extern int scsi_hotswap_insert_by_fc_wwn (unsigned int host,
+    unsigned int channel,
+    unsigned int lun,
+    unsigned long long wwn);
+
+/*
+ * Find a device by host, channel, lun and wwn and remove it from the 
system
+ */
+extern int scsi_hotswap_remove_by_fc_wwn (unsigned int host,
+    unsigned int channel,
+    unsigned int lun,
+    unsigned long long wwn);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, insert it into the system
+ */
+extern int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long 
wwn);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, remove it from the system
+ */
+extern int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long 
wwn);
+
+#endif /* __SCSI_HOTSWAP_H */







