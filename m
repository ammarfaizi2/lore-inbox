Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbTA3D0j>; Wed, 29 Jan 2003 22:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbTA3D0j>; Wed, 29 Jan 2003 22:26:39 -0500
Received: from fmr02.intel.com ([192.55.52.25]:32979 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267394AbTA3D0U>; Wed, 29 Jan 2003 22:26:20 -0500
Date: Thu, 30 Jan 2003 11:32:32 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Stanley Wang <stanley.wang@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: [Resend][PATCH] Replace pcihpfs with sysfs.
In-Reply-To: <20030124004529.GA11646@kroah.com>
Message-ID: <Pine.LNX.4.44.0301301126150.20600-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg
Here is the latest patch for replacing pcihpfs with sysfs. Also remove
procfs stuff from pci_hotplug_core. And include change_slot_info function.

Best Regards,
-Stan

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.959, 2003-01-30 11:25:26+08:00, stanley@manticore.sh.intel.com
  Restore pci_hp_change_slot_info in pci_hotplug_core.c

ChangeSet@1.958, 2003-01-24 13:54:18+08:00, stanley@manticore.sh.intel.com
  Remove /proc entry for pci_hotplug_core.

ChangeSet@1.957, 2003-01-24 10:03:36+08:00, stanley@manticore.sh.intel.com
  Replace pcihpfs with sysfs

ChangeSet@1.956, 2003-01-16 18:20:34-08:00, torvalds@penguin.transmeta.com
  Linux v2.5.59
  TAG: v2.5.59


 pci_hotplug.h      |    9 
 pci_hotplug_core.c | 1027 ++++++++---------------------------------------------
 2 files changed, 167 insertions(+), 869 deletions(-)


diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Jan 30 11:29:24 2003
+++ b/drivers/hotplug/pci_hotplug.h	Thu Jan 30 11:29:24 2003
@@ -46,8 +46,11 @@
 };
 
 struct hotplug_slot;
-struct hotplug_slot_core;
-
+struct hotplug_slot_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct hotplug_slot *, char *);
+	ssize_t (*store)(struct hotplug_slot *, const char *, size_t);
+};
 /**
  * struct hotplug_slot_ops -the callbacks that the hotplug pci core can use
  * @owner: The module owner of this structure
@@ -131,7 +134,7 @@
 
 	/* Variables below this are for use only by the hotplug pci core. */
 	struct list_head		slot_list;
-	struct hotplug_slot_core	*core_priv;
+	struct kobject			kobj;
 };
 
 extern int pci_hp_register		(struct hotplug_slot *slot);
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Jan 30 11:29:24 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Jan 30 11:29:24 2003
@@ -40,8 +40,9 @@
 #include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>
-#include <linux/proc_fs.h>
 #include <asm/uaccess.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include "pci_hotplug.h"
 
 
@@ -67,29 +68,43 @@
 
 //////////////////////////////////////////////////////////////////
 
-/* Random magic number */
-#define PCIHPFS_MAGIC 0x52454541
+static spinlock_t list_lock;
+
+static LIST_HEAD(pci_hotplug_slot_list);
+
+static struct subsystem hotplug_slots_subsys;
+
+static ssize_t hotplug_slot_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct hotplug_slot *slot=container_of(kobj,
+			struct hotplug_slot,kobj);
+	struct hotplug_slot_attribute *attribute =
+		container_of(attr, struct hotplug_slot_attribute, attr);
+	return attribute->show ? attribute->show(slot, buf) : 0;
+}
+
+static ssize_t hotplug_slot_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t len)
+{
+	struct hotplug_slot *slot=container_of(kobj,
+			struct hotplug_slot,kobj);
+	struct hotplug_slot_attribute *attribute =
+		container_of(attr, struct hotplug_slot_attribute, attr);
+	return attribute->store ? attribute->store(slot, buf, len) : 0;
+}
 
-struct hotplug_slot_core {
-	struct dentry	*dir_dentry;
-	struct dentry	*power_dentry;
-	struct dentry	*attention_dentry;
-	struct dentry	*latch_dentry;
-	struct dentry	*adapter_dentry;
-	struct dentry	*test_dentry;
-	struct dentry	*max_bus_speed_dentry;
-	struct dentry	*cur_bus_speed_dentry;
+static struct sysfs_ops hotplug_slot_sysfs_ops = {
+	.show = hotplug_slot_attr_show,
+	.store = hotplug_slot_attr_store,
 };
 
-static struct super_operations pcihpfs_ops;
-static struct file_operations default_file_operations;
-static struct inode_operations pcihpfs_dir_inode_operations;
-static struct vfsmount *pcihpfs_mount;	/* one of the mounts of our fs for reference counting */
-static int pcihpfs_mount_count;		/* times we have mounted our fs */
-static spinlock_t mount_lock;		/* protects our mount_count */
-static spinlock_t list_lock;
+static struct kobj_type hotplug_slot_ktype = {
+	.sysfs_ops = &hotplug_slot_sysfs_ops
+};
+
+static decl_subsys(hotplug_slots, &hotplug_slot_ktype);
 
-static LIST_HEAD(pci_hotplug_slot_list);
 
 /* these strings match up with the values in pci_bus_speed */
 static char *pci_bus_speed_strings[] = {
@@ -115,12 +130,6 @@
 	"133 MHz PCIX 533",	/* 0x13 */
 };
 
-#ifdef CONFIG_PROC_FS		
-extern struct proc_dir_entry *proc_bus_pci_dir;
-static struct proc_dir_entry *slotdir = NULL;
-static const char *slotdir_name = "slots";
-#endif
-
 #ifdef CONFIG_HOTPLUG_PCI_CPCI
 extern int cpci_hotplug_init(int debug);
 extern void cpci_hotplug_exit(void);
@@ -129,438 +138,6 @@
 static inline void cpci_hotplug_exit(void) { }
 #endif
 
-static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, dev_t dev)
-{
-	struct inode *inode = new_inode(sb);
-
-	if (inode) {
-		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
-		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_blocks = 0;
-		inode->i_rdev = NODEV;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		switch (mode & S_IFMT) {
-		default:
-			init_special_inode(inode, mode, dev);
-			break;
-		case S_IFREG:
-			inode->i_fop = &default_file_operations;
-			break;
-		case S_IFDIR:
-			inode->i_op = &pcihpfs_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
-
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
-			inode->i_nlink++;
-			break;
-		}
-	}
-	return inode; 
-}
-
-/* SMP-safe */
-static int pcihpfs_mknod (struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
-{
-	struct inode *inode = pcihpfs_get_inode(dir->i_sb, mode, dev);
-	int error = -ENOSPC;
-
-	if (inode) {
-		d_instantiate(dentry, inode);
-		dget(dentry);
-		error = 0;
-	}
-	return error;
-}
-
-static int pcihpfs_mkdir (struct inode *dir, struct dentry *dentry, int mode)
-{
-	return pcihpfs_mknod (dir, dentry, mode | S_IFDIR, 0);
-}
-
-static int pcihpfs_create (struct inode *dir, struct dentry *dentry, int mode)
-{
- 	return pcihpfs_mknod (dir, dentry, mode | S_IFREG, 0);
-}
-
-static inline int pcihpfs_positive (struct dentry *dentry)
-{
-	return dentry->d_inode && !d_unhashed(dentry);
-}
-
-static int pcihpfs_empty (struct dentry *dentry)
-{
-	struct list_head *list;
-
-	spin_lock(&dcache_lock);
-
-	list_for_each(list, &dentry->d_subdirs) {
-		struct dentry *de = list_entry(list, struct dentry, d_child);
-		if (pcihpfs_positive(de)) {
-			spin_unlock(&dcache_lock);
-			return 0;
-		}
-	}
-
-	spin_unlock(&dcache_lock);
-	return 1;
-}
-
-static int pcihpfs_unlink (struct inode *dir, struct dentry *dentry)
-{
-	int error = -ENOTEMPTY;
-
-	if (pcihpfs_empty(dentry)) {
-		struct inode *inode = dentry->d_inode;
-
-		lock_kernel();
-		inode->i_nlink--;
-		unlock_kernel();
-		dput(dentry);
-		error = 0;
-	}
-	return error;
-}
-
-#define pcihpfs_rmdir pcihpfs_unlink
-
-/* default file operations */
-static ssize_t default_read_file (struct file *file, char *buf, size_t count, loff_t *ppos)
-{
-	dbg ("\n");
-	return 0;
-}
-
-static ssize_t default_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos)
-{
-	dbg ("\n");
-	return count;
-}
-
-static loff_t default_file_lseek (struct file *file, loff_t offset, int orig)
-{
-	loff_t retval = -EINVAL;
-
-	lock_kernel();
-	switch(orig) {
-	case 0:
-		if (offset > 0) {
-			file->f_pos = offset;
-			retval = file->f_pos;
-		} 
-		break;
-	case 1:
-		if ((offset + file->f_pos) > 0) {
-			file->f_pos += offset;
-			retval = file->f_pos;
-		} 
-		break;
-	default:
-		break;
-	}
-	unlock_kernel();
-	return retval;
-}
-
-static int default_open (struct inode *inode, struct file *filp)
-{
-	if (inode->u.generic_ip)
-		filp->private_data = inode->u.generic_ip;
-
-	return 0;
-}
-
-static struct file_operations default_file_operations = {
-	.read =		default_read_file,
-	.write =	default_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-/* file ops for the "power" files */
-static ssize_t power_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static ssize_t power_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
-static struct file_operations power_file_operations = {
-	.read =		power_read_file,
-	.write =	power_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-/* file ops for the "attention" files */
-static ssize_t attention_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static ssize_t attention_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
-static struct file_operations attention_file_operations = {
-	.read =		attention_read_file,
-	.write =	attention_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-/* file ops for the "latch" files */
-static ssize_t latch_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static struct file_operations latch_file_operations = {
-	.read =		latch_read_file,
-	.write =	default_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-/* file ops for the "presence" files */
-static ssize_t presence_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static struct file_operations presence_file_operations = {
-	.read =		presence_read_file,
-	.write =	default_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-/* file ops for the "max bus speed" files */
-static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static struct file_operations max_bus_speed_file_operations = {
-	.read		= max_bus_speed_read_file,
-	.write		= default_write_file,
-	.open		= default_open,
-	.llseek		= default_file_lseek,
-};
-
-/* file ops for the "current bus speed" files */
-static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
-static struct file_operations cur_bus_speed_file_operations = {
-	.read		= cur_bus_speed_read_file,
-	.write		= default_write_file,
-	.open		= default_open,
-	.llseek		= default_file_lseek,
-};
-
-/* file ops for the "test" files */
-static ssize_t test_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
-static struct file_operations test_file_operations = {
-	.read =		default_read_file,
-	.write =	test_write_file,
-	.open =		default_open,
-	.llseek =	default_file_lseek,
-};
-
-static struct inode_operations pcihpfs_dir_inode_operations = {
-	.create =	pcihpfs_create,
-	.lookup =	simple_lookup,
-	.unlink =	pcihpfs_unlink,
-	.mkdir =	pcihpfs_mkdir,
-	.rmdir =	pcihpfs_rmdir,
-	.mknod =	pcihpfs_mknod,
-};
-
-static struct super_operations pcihpfs_ops = {
-	.statfs =	simple_statfs,
-	.drop_inode =	generic_delete_inode,
-};
-
-static int pcihpfs_fill_super(struct super_block *sb, void *data, int silent)
-{
-	struct inode *inode;
-	struct dentry *root;
-
-	sb->s_blocksize = PAGE_CACHE_SIZE;
-	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->s_magic = PCIHPFS_MAGIC;
-	sb->s_op = &pcihpfs_ops;
-	inode = pcihpfs_get_inode(sb, S_IFDIR | 0755, 0);
-
-	if (!inode) {
-		dbg("%s: could not get inode!\n",__FUNCTION__);
-		return -ENOMEM;
-	}
-
-	root = d_alloc_root(inode);
-	if (!root) {
-		dbg("%s: could not get root dentry!\n",__FUNCTION__);
-		iput(inode);
-		return -ENOMEM;
-	}
-	sb->s_root = root;
-	return 0;
-}
-
-static struct super_block *pcihpfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
-{
-	return get_sb_single(fs_type, flags, data, pcihpfs_fill_super);
-}
-
-static struct file_system_type pcihpfs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"pcihpfs",
-	.get_sb =	pcihpfs_get_sb,
-	.kill_sb =	kill_litter_super,
-};
-
-static int get_mount (void)
-{
-	struct vfsmount *mnt;
-
-	spin_lock (&mount_lock);
-	if (pcihpfs_mount) {
-		mntget(pcihpfs_mount);
-		++pcihpfs_mount_count;
-		spin_unlock (&mount_lock);
-		goto go_ahead;
-	}
-
-	spin_unlock (&mount_lock);
-	mnt = kern_mount (&pcihpfs_type);
-	if (IS_ERR(mnt)) {
-		err ("could not mount the fs...erroring out!\n");
-		return -ENODEV;
-	}
-	spin_lock (&mount_lock);
-	if (!pcihpfs_mount) {
-		pcihpfs_mount = mnt;
-		++pcihpfs_mount_count;
-		spin_unlock (&mount_lock);
-		goto go_ahead;
-	}
-	mntget(pcihpfs_mount);
-	++pcihpfs_mount_count;
-	spin_unlock (&mount_lock);
-	mntput(mnt);
-
-go_ahead:
-	dbg("pcihpfs_mount_count = %d\n", pcihpfs_mount_count);
-	return 0;
-}
-
-static void remove_mount (void)
-{
-	struct vfsmount *mnt;
-
-	spin_lock (&mount_lock);
-	mnt = pcihpfs_mount;
-	--pcihpfs_mount_count;
-	if (!pcihpfs_mount_count)
-		pcihpfs_mount = NULL;
-
-	spin_unlock (&mount_lock);
-	mntput(mnt);
-	dbg("pcihpfs_mount_count = %d\n", pcihpfs_mount_count);
-}
-
-
-/**
- * pcihpfs_create_by_name - create a file, given a name
- * @name:	name of file
- * @mode:	type of file
- * @parent:	dentry of directory to create it in
- * @dentry:	resulting dentry of file
- *
- * There is a bit of overhead in creating a file - basically, we 
- * have to hash the name of the file, then look it up. This will
- * prevent files of the same name. 
- * We then call the proper vfs_ function to take care of all the 
- * file creation details. 
- * This function handles both regular files and directories.
- */
-static int pcihpfs_create_by_name (const char *name, mode_t mode,
-				   struct dentry *parent, struct dentry **dentry)
-{
-	struct dentry *d = NULL;
-	struct qstr qstr;
-	int error;
-
-	/* If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super 
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent ) {
-		if (pcihpfs_mount && pcihpfs_mount->mnt_sb) {
-			parent = pcihpfs_mount->mnt_sb->s_root;
-		}
-	}
-
-	if (!parent) {
-		dbg("Ah! can not find a parent!\n");
-		return -EINVAL;
-	}
-
-	*dentry = NULL;
-	qstr.name = name;
-	qstr.len = strlen(name);
- 	qstr.hash = full_name_hash(name,qstr.len);
-
-	parent = dget(parent);
-
-	down(&parent->d_inode->i_sem);
-
-	d = lookup_hash(&qstr,parent);
-
-	error = PTR_ERR(d);
-	if (!IS_ERR(d)) {
-		switch(mode & S_IFMT) {
-		case 0: 
-		case S_IFREG:
-			error = vfs_create(parent->d_inode,d,mode);
-			break;
-		case S_IFDIR:
-			error = vfs_mkdir(parent->d_inode,d,mode);
-			break;
-		default:
-			err("cannot create special files\n");
-		}
-		*dentry = d;
-	}
-	up(&parent->d_inode->i_sem);
-
-	dput(parent);
-	return error;
-}
-
-static struct dentry *fs_create_file (const char *name, mode_t mode,
-				      struct dentry *parent, void *data,
-				      struct file_operations *fops)
-{
-	struct dentry *dentry;
-	int error;
-
-	dbg("creating file '%s'\n",name);
-
-	error = pcihpfs_create_by_name(name,mode,parent,&dentry);
-	if (error) {
-		dentry = NULL;
-	} else {
-		if (dentry->d_inode) {
-			if (data)
-				dentry->d_inode->u.generic_ip = data;
-			if (fops)
-			dentry->d_inode->i_fop = fops;
-		}
-	}
-
-	return dentry;
-}
-
-static void fs_remove_file (struct dentry *dentry)
-{
-	struct dentry *parent = dentry->d_parent;
-	
-	if (!parent || !parent->d_inode)
-		return;
-
-	down(&parent->d_inode->i_sem);
-	if (pcihpfs_positive(dentry)) {
-		if (dentry->d_inode) {
-			if (S_ISDIR(dentry->d_inode->i_mode))
-				vfs_rmdir(parent->d_inode,dentry);
-			else
-				vfs_unlink(parent->d_inode,dentry);
-		}
-
-		dput(dentry);
-	}
-	up(&parent->d_inode->i_sem);
-}
-
 /* Weee, fun with macros... */
 #define GET_STATUS(name,type)	\
 static int get_##name (struct hotplug_slot *slot, type *value)		\
@@ -584,80 +161,27 @@
 GET_STATUS(max_bus_speed, enum pci_bus_speed)
 GET_STATUS(cur_bus_speed, enum pci_bus_speed)
 
-static ssize_t power_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static ssize_t power_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
 
-	dbg(" count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 16384)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_power_status (slot, &value);
 	if (retval)
 		goto exit;
-	len = sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
-
+	retval = sprintf (buf, "%d\n", value);
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
-static ssize_t power_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
+static ssize_t power_write_file (struct hotplug_slot *slot, const char *buf,
+		size_t count)
 {
-	struct hotplug_slot *slot = file->private_data;
-	char *buff;
 	unsigned long lpower;
 	u8 power;
 	int retval = 0;
 
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 16384)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	buff = kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
- 
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	
-	lpower = simple_strtoul (buff, NULL, 10);
+	lpower = simple_strtoul (buf, NULL, 10);
 	power = (u8)(lpower & 0xff);
 	dbg ("power = %d\n", power);
 
@@ -683,87 +207,39 @@
 	module_put(slot->ops->owner);
 
 exit:	
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
 
-static ssize_t attention_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_power = {
+	.attr = {.name = "power", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = power_read_file,
+	.store = power_write_file
+};
+
+static ssize_t attention_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
 
-	dbg("count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <= 0)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_attention_status (slot, &value);
 	if (retval)
 		goto exit;
-	len = sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	retval = sprintf (buf, "%d\n", value);
 
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
-static ssize_t attention_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
+static ssize_t attention_write_file (struct hotplug_slot *slot, const char *buf,
+		size_t count)
 {
-	struct hotplug_slot *slot = file->private_data;
-	char *buff;
 	unsigned long lattention;
 	u8 attention;
 	int retval = 0;
 
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 16384)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	buff = kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
-
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	
-	lattention = simple_strtoul (buff, NULL, 10);
+	lattention = simple_strtoul (buf, NULL, 10);
 	attention = (u8)(lattention & 0xff);
 	dbg (" - attention = %d\n", attention);
 
@@ -776,128 +252,63 @@
 	module_put(slot->ops->owner);
 
 exit:	
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
 
-static ssize_t latch_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_attention = {
+	.attr = {.name = "attention", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = attention_read_file,
+	.store = attention_write_file
+};
+
+static ssize_t latch_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
 
-	dbg("count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <= 0)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_latch_status (slot, &value);
 	if (retval)
 		goto exit;
-	len = sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	retval = sprintf (buf, "%d\n", value);
 
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
-static ssize_t presence_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_latch = {
+	.attr = {.name = "latch", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = latch_read_file,
+};
+
+static ssize_t presence_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	int retval;
-	int len;
 	u8 value;
 
-	dbg("count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <= 0)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_adapter_status (slot, &value);
 	if (retval)
 		goto exit;
-	len = sprintf (page, "%d\n", value);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	retval = sprintf (buf, "%d\n", value);
 
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
+static struct hotplug_slot_attribute hotplug_slot_attr_presence = {
+	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = presence_read_file,
+};
+
 static char *unknown_speed = "Unknown bus speed";
 
-static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static ssize_t max_bus_speed_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	char *speed_string;
 	int retval;
-	int len = 0;
 	enum pci_bus_speed value;
 	
-	dbg ("count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <= 0)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_max_bus_speed (slot, &value);
 	if (retval)
 		goto exit;
@@ -907,47 +318,23 @@
 	else
 		speed_string = pci_bus_speed_strings[value];
 	
-	len = sprintf (page, "%s\n", speed_string);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	retval = sprintf (buf, "%s\n", speed_string);
 
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
-static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_max_bus_speed = {
+	.attr = {.name = "max_bus_speed", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = max_bus_speed_read_file,
+};
+
+static ssize_t cur_bus_speed_read_file (struct hotplug_slot *slot, char *buf)
 {
-	struct hotplug_slot *slot = file->private_data;
-	unsigned char *page;
 	char *speed_string;
 	int retval;
-	int len = 0;
 	enum pci_bus_speed value;
 
-	dbg ("count = %d, offset = %lld\n", count, *offset);
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count <= 0)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	retval = get_cur_bus_speed (slot, &value);
 	if (retval)
 		goto exit;
@@ -957,51 +344,25 @@
 	else
 		speed_string = pci_bus_speed_strings[value];
 	
-	len = sprintf (page, "%s\n", speed_string);
-
-	if (copy_to_user (buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	retval = sprintf (buf, "%s\n", speed_string);
 
 exit:
-	free_page((unsigned long)page);
 	return retval;
 }
 
-static ssize_t test_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
+static struct hotplug_slot_attribute hotplug_slot_attr_cur_bus_speed = {
+	.attr = {.name = "cur_bus_speed", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = cur_bus_speed_read_file,
+};
+
+static ssize_t test_write_file (struct hotplug_slot *slot, const char *buf,
+		size_t count)
 {
-	struct hotplug_slot *slot = file->private_data;
-	char *buff;
 	unsigned long ltest;
 	u32 test;
 	int retval = 0;
 
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 16384)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (slot == NULL) {
-		dbg("slot == NULL???\n");
-		return -ENODEV;
-	}
-
-	buff = kmalloc (count + 1, GFP_KERNEL);
-	if (!buff)
-		return -ENOMEM;
-	memset (buff, 0x00, count + 1);
-
-	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	
-	ltest = simple_strtoul (buff, NULL, 10);
+        ltest = simple_strtoul (buf, NULL, 10);
 	test = (u32)(ltest & 0xffffffff);
 	dbg ("test = %d\n", test);
 
@@ -1014,104 +375,69 @@
 	module_put(slot->ops->owner);
 
 exit:	
-	kfree (buff);
-
 	if (retval)
 		return retval;
 	return count;
 }
 
+static struct hotplug_slot_attribute hotplug_slot_attr_test = {
+	.attr = {.name = "test", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.store = test_write_file
+};
+
 static int fs_add_slot (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core = slot->core_priv;
-	int result;
+	if ((slot->ops->enable_slot) ||
+	    (slot->ops->disable_slot) ||
+	    (slot->ops->get_power_status))
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if ((slot->ops->set_attention_status) ||
+	    (slot->ops->get_attention_status))
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if (slot->ops->get_latch_status)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
 
-	result = get_mount();
-	if (result)
-		return result;
-
-	core->dir_dentry = fs_create_file (slot->name,
-					   S_IFDIR | S_IXUGO | S_IRUGO,
-					   NULL, NULL, NULL);
-	if (core->dir_dentry != NULL) {
-		if ((slot->ops->enable_slot) ||
-		    (slot->ops->disable_slot) ||
-		    (slot->ops->get_power_status))
-			core->power_dentry = 
-				fs_create_file ("power",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&power_file_operations);
-
-		if ((slot->ops->set_attention_status) ||
-		    (slot->ops->get_attention_status))
-			core->attention_dentry =
-				fs_create_file ("attention",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&attention_file_operations);
-
-		if (slot->ops->get_latch_status)
-			core->latch_dentry = 
-				fs_create_file ("latch",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&latch_file_operations);
-
-		if (slot->ops->get_adapter_status)
-			core->adapter_dentry = 
-				fs_create_file ("adapter",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&presence_file_operations);
-
-		if (slot->ops->get_max_bus_speed)
-			core->max_bus_speed_dentry = 
-				fs_create_file ("max_bus_speed",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&max_bus_speed_file_operations);
-
-		if (slot->ops->get_cur_bus_speed)
-			core->cur_bus_speed_dentry =
-				fs_create_file ("cur_bus_speed",
-						S_IFREG | S_IRUGO,
-						core->dir_dentry, slot,
-						&cur_bus_speed_file_operations);
-
-		if (slot->ops->hardware_test)
-			core->test_dentry =
-				fs_create_file ("test",
-						S_IFREG | S_IRUGO | S_IWUSR,
-						core->dir_dentry, slot,
-						&test_file_operations);
-	}
+	if (slot->ops->get_adapter_status)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+
+	if (slot->ops->get_max_bus_speed)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if (slot->ops->get_cur_bus_speed)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	if (slot->ops->hardware_test)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_test.attr);
 	return 0;
 }
 
 static void fs_remove_slot (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core = slot->core_priv;
+	if ((slot->ops->enable_slot) ||
+	    (slot->ops->disable_slot) ||
+	    (slot->ops->get_power_status))
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if ((slot->ops->set_attention_status) ||
+	    (slot->ops->get_attention_status))
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if (slot->ops->get_latch_status)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
 
-	if (core->dir_dentry) {
-		if (core->power_dentry)
-			fs_remove_file (core->power_dentry);
-		if (core->attention_dentry)
-			fs_remove_file (core->attention_dentry);
-		if (core->latch_dentry)
-			fs_remove_file (core->latch_dentry);
-		if (core->adapter_dentry)
-			fs_remove_file (core->adapter_dentry);
-		if (core->max_bus_speed_dentry)
-			fs_remove_file (core->max_bus_speed_dentry);
-		if (core->cur_bus_speed_dentry)
-			fs_remove_file (core->cur_bus_speed_dentry);
-		if (core->test_dentry)
-			fs_remove_file (core->test_dentry);
-		fs_remove_file (core->dir_dentry);
-	}
+	if (slot->ops->get_adapter_status)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
 
-	remove_mount();
+	if (slot->ops->get_max_bus_speed)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if (slot->ops->get_cur_bus_speed)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	if (slot->ops->hardware_test)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_test.attr);
 }
 
 static struct hotplug_slot *get_slot_from_name (const char *name)
@@ -1138,7 +464,6 @@
  */
 int pci_hp_register (struct hotplug_slot *slot)
 {
-	struct hotplug_slot_core *core;
 	int result;
 
 	if (slot == NULL)
@@ -1146,21 +471,21 @@
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
 
-	core = kmalloc (sizeof (struct hotplug_slot_core), GFP_KERNEL);
-	if (!core)
-		return -ENOMEM;
-
 	/* make sure we have not already registered this slot */
 	spin_lock (&list_lock);
 	if (get_slot_from_name (slot->name) != NULL) {
 		spin_unlock (&list_lock);
-		kfree (core);
 		return -EINVAL;
 	}
 
-	memset (core, 0, sizeof (struct hotplug_slot_core));
-	slot->core_priv = core;
+	strncpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
+	kobj_set_kset_s(slot, hotplug_slots_subsys);
 
+	if (kobject_register(&slot->kobj)) {
+		err("Unable to register kobject");
+		return -EINVAL;
+	}
+		
 	list_add (&slot->slot_list, &pci_hotplug_slot_list);
 	spin_unlock (&list_lock);
 
@@ -1197,20 +522,11 @@
 	spin_unlock (&list_lock);
 
 	fs_remove_slot (slot);
-	kfree(slot->core_priv);
 	dbg ("Removed slot %s from the list\n", slot->name);
+	kobject_unregister(&slot->kobj);
 	return 0;
 }
 
-static inline void update_dentry_inode_time (struct dentry *dentry)
-{
-	struct inode *inode = dentry->d_inode;
-	if (inode) {
-		inode->i_mtime = CURRENT_TIME;
-		dnotify_parent(dentry, DN_MODIFY);
-	}
-}
-
 /**
  * pci_hp_change_slot_info - changes the slot's information structure in the core
  * @name: the name of the slot whose info has changed
@@ -1224,7 +540,6 @@
 int pci_hp_change_slot_info (const char *name, struct hotplug_slot_info *info)
 {
 	struct hotplug_slot *temp;
-	struct hotplug_slot_core *core;
 
 	if (info == NULL)
 		return -ENODEV;
@@ -1240,22 +555,16 @@
 	 * check all fields in the info structure, and update timestamps
 	 * for the files referring to the fields that have now changed.
 	 */
-	core = temp->core_priv;
-	if ((core->power_dentry) &&
-	    (temp->info->power_status != info->power_status))
-		update_dentry_inode_time (core->power_dentry);
-	if ((core->attention_dentry) &&
-	    (temp->info->attention_status != info->attention_status))
-		update_dentry_inode_time (core->attention_dentry);
-	if ((core->latch_dentry) &&
-	    (temp->info->latch_status != info->latch_status))
-		update_dentry_inode_time (core->latch_dentry);
-	if ((core->adapter_dentry) &&
-	    (temp->info->adapter_status != info->adapter_status))
-		update_dentry_inode_time (core->adapter_dentry);
-	if ((core->cur_bus_speed_dentry) &&
-	    (temp->info->cur_bus_speed != info->cur_bus_speed))
-		update_dentry_inode_time (core->cur_bus_speed_dentry);
+	if (temp->info->power_status != info->power_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->attention_status != info->attention_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->latch_status != info->latch_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->adapter_status != info->adapter_status)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
+	if (temp->info->cur_bus_speed != info->cur_bus_speed)
+		inode_dir_notify(temp->kobj.dentry->d_inode, DN_MODIFY);
 
 	memcpy (temp->info, info, sizeof (struct hotplug_slot_info));
 	spin_unlock (&list_lock);
@@ -1266,32 +575,25 @@
 {
 	int result;
 
-	spin_lock_init(&mount_lock);
 	spin_lock_init(&list_lock);
 
-	dbg("registering filesystem.\n");
-	result = register_filesystem(&pcihpfs_type);
+	kset_set_kset_s(&hotplug_slots_subsys, pci_bus_type.subsys);
+	result = subsystem_register(&hotplug_slots_subsys);
 	if (result) {
-		err("register_filesystem failed with %d\n", result);
+		err("Register subsys with error %d\n", result);
 		goto exit;
 	}
-
 	result = cpci_hotplug_init(debug);
 	if (result) {
 		err ("cpci_hotplug_init with error %d\n", result);
-		goto error_fs;
+		goto err_subsys;
 	}
 
-#ifdef CONFIG_PROC_FS
-	/* create mount point for pcihpfs */
-	slotdir = proc_mkdir(slotdir_name, proc_bus_pci_dir);
-#endif
-
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	goto exit;
 	
-error_fs:
-	unregister_filesystem(&pcihpfs_type);
+err_subsys:
+	subsystem_unregister(&hotplug_slots_subsys);
 exit:
 	return result;
 }
@@ -1299,13 +601,7 @@
 static void __exit pci_hotplug_exit (void)
 {
 	cpci_hotplug_exit();
-
-	unregister_filesystem(&pcihpfs_type);
-
-#ifdef CONFIG_PROC_FS
-	if (slotdir)
-		remove_proc_entry(slotdir_name, proc_bus_pci_dir);
-#endif
+	subsystem_unregister(&hotplug_slots_subsys);
 }
 
 module_init(pci_hotplug_init);
@@ -1320,4 +616,3 @@
 EXPORT_SYMBOL_GPL(pci_hp_register);
 EXPORT_SYMBOL_GPL(pci_hp_deregister);
 EXPORT_SYMBOL_GPL(pci_hp_change_slot_info);
-

===================================================================


This BitKeeper patch contains the following changesets:
1.956..1.959
## Wrapped with gzip_uu ##


begin 664 bkpatch21037
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
39-,#C5HC0,Y0_@.H-[J;-C(`````
`
end

-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


