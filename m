Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSKTU7O>; Wed, 20 Nov 2002 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKTU7N>; Wed, 20 Nov 2002 15:59:13 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47628 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262646AbSKTU7A>; Wed, 20 Nov 2002 15:59:00 -0500
Date: Wed, 20 Nov 2002 22:06:01 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [RFC] module fs or how to not break everything at once
Message-ID: <Pine.LNX.4.44.0211202013000.2113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is worse than getting flamed? Right, not getting flamed. I can 
understand that Rusty is pissed at me, for hitting like this on his code 
and I'm really sorry about that, but code quality is more important to me 
right now. (The other possibility is that he's now laughing maniacally at 
what a fool I am. ;-). ) OTOH it's pretty interesting to see that nobody 
seems to care, as the kernel loader is now in everybody's kernel and if 
everyone were happy, someone should be able tell me, why it should be kept 
in the kernel.
Anyway, this is the last part from me in this series, with this I said 
everything I wanted and if anyone is interested in discussion about module 
design (instead of just throwing it into the kernel), I'd be happy, 
otherwise I'll just shut up for a while.

Below is a basic module fs implementation, which demonstrates an 
alternative way of managing modules. It's reduced to the most basic 
functionality needed to get modules working: map an object into kernel 
space and start/stop a module. Everything else can and should be done in 
user space. On top of this functionality it's easy to emulate the old 
system calls, so old insmod/rmmod work just fine. This allows now to write 
new module tools and when they are ready (this means we're also happy with 
the new module interface), we can drop all the old syscalls. The new 
loader OTOH has not much to do either (see the mini loader I posted last 
week), it only has to relocate the module and move it to the kernel. Most 
important here is the loader doesn't need to know anything about any 
kernel structures, any information needed by the kernel is added in the 
final link stage. This gives us very much freedom with the module layout 
and makes it very unlikely that the user space loader needs to change. 
Once the module tools are ready and we don't need to care about 
compatibility anymore, it's possible to change the driver module interface 
however we want. This should be the last stage during the module code 
cleanup, otherwise complete breakage is guaranteed.

Overall this means all module tasks become nicely separated. During build 
we prepare the module with all the information the kernel needs, the 
loader takes care of dependencies and just relocates the module, modfs 
maps it into the kernel and starts the module. If the interfaces are 
halfway flexible, changes in one part don't require a change somewhere 
else.
This sounds simple, but it's lots of work and I had preferred, we had to 
completely change the module interfaces/tools only once. I will further 
develop the code below over the next months, whenever I'm bored (or if I 
should need modules for some reason) and it should be ready for 2.7.

Some comments about the code: it can be basically dropped into any 
kernel/module.c < 2.5.48 (just remove/comment out the old 
sys_create_module/sys_init_module/sys_delete_module functions).
Loading/removing symbols into kernel through modfs still has to be done. A 
module is simply created with mkdir, the module is a normal (write only) 
file and it can be mapped/unmmapped/inited/exited through a control file, 
Right now it's possible to map multiple files per module dir, e.g. for 
separate core/init sections, but I consider to keep this to one object 
file per directory and just truncate the init part. Anyway, this is only 
supposed to give an idea how it could look like, it's far away from ready, 
but it already works here. Comments are very welcome.

bye, Roman


#include <linux/file.h>
#include <linux/namei.h>
#include <linux/backing-dev.h>
#include <linux/pagemap.h>
#include <linux/ctype.h>

struct module_dir {
	struct dentry *dir;
	struct dentry *control;
	struct dentry *module;
	unsigned int usecount;
};

struct module_data {
	struct dentry *dentry;
	struct module *module;
};

static struct vfsmount *modfs_mount;

static int modfs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
static int modfs_rmdir(struct inode *dir, struct dentry *dentry);
static int modfs_create(struct inode *dir, struct dentry *dentry, int mode);
static int modfs_unlink(struct inode *dir, struct dentry *dentry);
static int modfs_control_file_open(struct inode *inode, struct file *file);
static ssize_t modfs_control_file_write(struct file *file, const char *buffer,
					size_t count, loff_t *ppos);
static int modfs_mod_file_open(struct inode *inode, struct file *file);
static int modfs_mod_file_setattr(struct dentry *dentry, struct iattr *attr);

static struct backing_dev_info modfs_backing_dev_info = {
	.ra_pages	= 0,	/* No readahead */
	.memory_backed	= 1,	/* Does not contribute to dirty memory */
};

static struct address_space_operations modfs_aops = {
	.readpage	= simple_readpage,
	.writepage	= fail_writepage,
	.prepare_write	= simple_prepare_write,
	.commit_write	= simple_commit_write,
};

struct inode_operations modfs_rootdir_inode_operations = {
	.mkdir		= modfs_mkdir,
	.lookup		= simple_lookup,
	.rmdir		= modfs_rmdir,
};

struct inode_operations modfs_moddir_inode_operations = {
	.create		= modfs_create,
	.lookup		= simple_lookup,
	.unlink		= modfs_unlink,
};

static struct file_operations modfs_control_file_operations = {
	.open		= modfs_control_file_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
	.write		= modfs_control_file_write,
};

static struct file_operations modfs_mod_file_operations = {
	.open		= modfs_mod_file_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
	.write		= generic_file_write,
	.mmap		= generic_file_mmap,
};

static struct inode_operations modfs_mod_inode_operations = {
	.setattr	= modfs_mod_file_setattr,
};

static struct super_operations modfs_ops = {
	.statfs		= simple_statfs,
	.drop_inode	= generic_delete_inode,
};

struct inode *modfs_get_inode(struct super_block *sb, int mode, int dev)
{
	struct inode *inode = new_inode(sb);

	if (inode) {
		inode->i_mode = mode;
		inode->i_uid = current->fsuid;
		inode->i_gid = current->fsgid;
		inode->i_blksize = PAGE_CACHE_SIZE;
		inode->i_blocks = 0;
		inode->i_rdev = NODEV;
		inode->i_mapping->a_ops = &modfs_aops;
		inode->i_mapping->backing_dev_info = &modfs_backing_dev_info;
		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
		switch (mode & S_IFMT) {
		default:
			init_special_inode(inode, mode, dev);
			break;
		case S_IFREG:
			break;
		case S_IFDIR:
			inode->i_op = &simple_dir_inode_operations;
			inode->i_fop = &simple_dir_operations;

			/* directory inodes start off with i_nlink == 2 (for "." entry) */
			inode->i_nlink++;
			break;
		case S_IFLNK:
			inode->i_op = &page_symlink_inode_operations;
			break;
		}
	}
	return inode;
}

static int modfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
{
	struct module_dir *moddir;
	struct inode *inode, *inode2;

	moddir = kmalloc(sizeof(*moddir), GFP_KERNEL);
	if (!moddir)
		return -ENOMEM;
	memset(moddir, 0, sizeof(*moddir));

	inode = modfs_get_inode(dir->i_sb, mode | S_IFDIR, 0);
	if (!inode)
		/* FIXME */
		return -ENOSPC;

	moddir->dir = dentry;
	inode->u.generic_ip = moddir;
	inode->i_op = &modfs_moddir_inode_operations;
	d_instantiate(dentry, inode);
	dget(dentry);
	dir->i_nlink++;

	inode2 = modfs_get_inode(dir->i_sb, (mode & ~S_IXUGO) | S_IFREG, 0);
	if (!inode)
		/* FIXME */
		return -ENOSPC;
	down(&inode->i_sem);
	moddir->control = lookup_one_len("control", moddir->dir, 7);
	if (!IS_ERR(dentry)) {
		inode2->i_fop = &modfs_control_file_operations;
		d_instantiate(moddir->control, inode2);
	} else
		/* FIXME */;
	up(&inode->i_sem);

	return 0;
}

static int modfs_rmdir(struct inode *dir, struct dentry *dentry)
{
	int res = simple_rmdir(dir, dentry);
	if (!res)
		kfree(dentry->d_inode->u.generic_ip);
	return res;
}

static int modfs_create(struct inode *dir, struct dentry *dentry, int mode)
{
	struct inode *inode;
	struct module_dir *moddir = dir->u.generic_ip;
	struct module_data *data;

	inode = modfs_get_inode(dir->i_sb, mode | S_IFREG, 0);
	if (!inode)
		return -ENOSPC;

	data = kmalloc(sizeof(*data), GFP_KERNEL);
	if (!data)
		/* FIXME */
		return -ENOMEM;
	memset(data, 0, sizeof(*data));
	data->dentry = dentry;
	inode->u.generic_ip = data;
	inode->i_fop = &modfs_mod_file_operations;
	inode->i_op = &modfs_mod_inode_operations;
	d_instantiate(dentry, inode);
	dget(dentry);
	moddir->usecount++;
	return 0;
}

static int modfs_unlink(struct inode *dir, struct dentry *dentry)
{
	struct inode *inode = dentry->d_inode;
	struct module_dir *moddir = dir->u.generic_ip;

	if (dentry == moddir->control) {
		if (moddir->usecount)
			return -EBUSY;
	} else {
		struct module_data *mdata = inode->u.generic_ip;
		if (mdata->module)
			return -EBUSY;
		moddir->usecount--;
	}
	simple_unlink(dir, dentry);
	return 0;
}

static int modfs_control_file_show(struct seq_file *m, void *v)
{
	seq_printf(m, "todo\n");
	return 0;
}

static int modfs_control_file_open(struct inode *inode, struct file *file)
{
	return single_open(file, modfs_control_file_show, NULL);
}

static struct dentry *modfs_control_get_modfile(struct dentry *parent, char *name)
{
	struct dentry *dentry;
	char *end;

	while (isspace(*name))
		name++;
	end = name;
	while (!isspace(*end))
		end++;
	dentry = lookup_one_len(name, parent, end - name);
	if (IS_ERR(dentry))
		return dentry;
	if (!dentry->d_inode || dentry->d_inode->i_fop != &modfs_mod_file_operations) {
		dput(dentry);
		return ERR_PTR(-ENOENT);
	}
	return dentry;
}

static int modfs_mod_file_map(struct dentry *dentry)
{
	struct module_data *mdata;
	int i, pcnt = (dentry->d_inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
	struct page **pagevec;

	mdata = dentry->d_inode->u.generic_ip;
	if (mdata->module)
		return -EEXIST;
	pagevec = kmalloc(pcnt * sizeof(*pagevec), GFP_KERNEL);
	if (!pagevec)
		/* FIXME */;
	for (i = 0; i < pcnt; i++) {
		pagevec[i] = grab_cache_page(dentry->d_inode->i_mapping, i);
		if (!pagevec[i])
			/* FIXME */;
		/* init page... */;
		unlock_page(pagevec[i]);
	}
	mdata->module = vmap(pagevec, pcnt);
	return 0;
}

static int modfs_mod_file_unmap(struct dentry *dentry)
{
	struct module_data *mdata = dentry->d_inode->u.generic_ip;
	if (!mdata->module)
		return -ENOENT;
	vunmap(mdata->module);
	/* release pages */;
	mdata->module = NULL;
	return 0;
}

static int modfs_mod_file_init(struct dentry *dentry)
{
	struct module_data *mdata = dentry->d_inode->u.generic_ip;
	struct module *mod = mdata->module;
	struct module_ref *dep;
	unsigned long flags;
	int res, i;

	if (!mod)
		return -ENOENT;
	if (module_arch_init(mod))
		return -EINVAL;

	spin_lock_irqsave(&modlist_lock, flags);
	mod->next = module_list;
	module_list = mod;	/* link it in */
	spin_unlock_irqrestore(&modlist_lock, flags);

	/* On some machines it is necessary to do something here
	   to make the I and D caches consistent.  */
	flush_icache_range((unsigned long)mod, (unsigned long)mod + dentry->d_inode->i_size);

	/* Update module references.  */
	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
		struct module *d = dep->dep;

		dep->ref = mod;
		dep->next_ref = d->refs;
		d->refs = dep;
		/* Being referenced by a dependent module counts as a
		   use as far as kmod is concerned.  */
		d->flags |= MOD_USED_ONCE;
	}

	/* Initialize the module.  */
	atomic_set(&mod->uc.usecount,1);
	mod->flags |= MOD_INITIALIZING;
	if (mod->init && (res = mod->init()) != 0) {
		atomic_set(&mod->uc.usecount,0);
		mod->flags &= ~MOD_INITIALIZING;
		if (res > 0)	/* Buggy module */
			res = -EBUSY;
		return res;
	}
	atomic_dec(&mod->uc.usecount);

	/* And set it running.  */
	mod->flags = (mod->flags | MOD_RUNNING) & ~MOD_INITIALIZING;

	return 0;
}

static int modfs_mod_file_exit(struct dentry *dentry)
{
	struct module_data *mdata = dentry->d_inode->u.generic_ip;
	struct module *mod = mdata->module;
	struct module_ref *dep;
	int res = 0, i;

	if (!mod)
		return -ENOENT;

	if (mod->refs != NULL)
		return -EBUSY;

	spin_lock(&unload_lock);
	if (!__MOD_IN_USE(mod))
		mod->flags |= MOD_DELETED;
	else
		res = -EBUSY;
	spin_unlock(&unload_lock);

	if (!res) {
		unsigned long flags;

		/* Let the module clean up.  */
		if (mod->flags & MOD_RUNNING) {
			if(mod->cleanup)
				mod->cleanup();
			mod->flags &= ~MOD_RUNNING;
		}

		/* Remove the module from the dependency lists.  */
		for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
			struct module_ref **pp;
			for (pp = &dep->dep->refs; *pp != dep; pp = &(*pp)->next_ref)
				continue;
			*pp = dep->next_ref;
		}

		/* And from the main module list.  */
		spin_lock_irqsave(&modlist_lock, flags);
		if (mod == module_list) {
			module_list = mod->next;
		} else {
			struct module *p;
			for (p = module_list; p->next != mod; p = p->next)
				continue;
			p->next = mod->next;
		}
		spin_unlock_irqrestore(&modlist_lock, flags);
	}

	return 0;
}

static ssize_t modfs_control_file_write(struct file *file, const char *buffer,
					size_t count, loff_t *ppos)
{
	struct dentry *dentry;
	char *data;

	data = __getname();
	if (!data)
		return -ENOMEM;
	count = min(count, (size_t)PATH_MAX - 1);
	if (!copy_from_user(data, buffer, count)) {
		data[count] = 0;
		if (!strncmp(data, "map ", 4)) {
			dentry = modfs_control_get_modfile(file->f_dentry->d_parent, data + 4);
			if (!IS_ERR(dentry)) {
				modfs_mod_file_map(dentry);
				dput(dentry);
			}
		} else if (!strncmp(data, "unmap ", 6)) {
			dentry = modfs_control_get_modfile(file->f_dentry->d_parent, data + 6);
			if (!IS_ERR(dentry)) {
				modfs_mod_file_unmap(dentry);
				dput(dentry);
			}
		} else if (!strncmp(data, "init ", 5)) {
			dentry = modfs_control_get_modfile(file->f_dentry->d_parent, data + 5);
			if (!IS_ERR(dentry)) {
				modfs_mod_file_init(dentry);
				dput(dentry);
			}
		} else if (!strncmp(data, "exit ", 5)) {
			dentry = modfs_control_get_modfile(file->f_dentry->d_parent, data + 5);
			if (!IS_ERR(dentry)) {
				modfs_mod_file_exit(dentry);
				dput(dentry);
			}
		}
	}
	putname(data);
	return count;
}

static int modfs_mod_file_show(struct seq_file *m, void *v)
{
	struct module_data *data = m->private;
	if (data->module) {
		struct module *mod = data->module;
		if (mod->flags & MOD_DELETED)
			seq_puts(m, "deleted\n");
		else if (mod->flags & MOD_RUNNING) {
			if (mod->flags & MOD_AUTOCLEAN)
				seq_puts(m, "autoclean\n");
			if (!(mod->flags & MOD_USED_ONCE))
				seq_puts(m, "unused\n");
		} else if (mod->flags & MOD_INITIALIZING)
			seq_puts(m, "initializing\n");
		else
			seq_puts(m, "uninitialized\n");
		seq_printf(m, "%p\n", mod);
	} else
		seq_printf(m, "unmapped\n");
	return 0;
}

static int modfs_mod_file_open(struct inode *inode, struct file *file)
{
	return single_open(file, modfs_mod_file_show, inode->u.generic_ip);
}

static int modfs_mod_file_setattr(struct dentry *dentry, struct iattr *attr)
{
	struct inode *inode = dentry->d_inode;

	if (attr->ia_valid & ATTR_SIZE) {
		struct module_data *data = inode->u.generic_ip;
		if (data->module)
			return -EPERM;
	}
	return inode_setattr(inode, attr);
}

static int modfs_fill_super(struct super_block * sb, void * data, int silent)
{
	struct inode * inode;
	struct dentry * root;

	sb->s_blocksize = PAGE_CACHE_SIZE;
	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
	sb->s_magic = 0x7a3dc6cd;//MODFS_MAGIC;
	sb->s_op = &modfs_ops;
	inode = modfs_get_inode(sb, S_IFDIR | 0755, 0);
	if (!inode)
		return -ENOMEM;
	inode->i_op = &modfs_rootdir_inode_operations;

	root = d_alloc_root(inode);
	if (!root) {
		iput(inode);
		return -ENOMEM;
	}
	sb->s_root = root;
	return 0;
}

static struct super_block *modfs_get_sb(struct file_system_type *fs_type,
		int flags, char *dev_name, void *data)
{
	return get_sb_single(fs_type, flags, data, modfs_fill_super);
}

static struct file_system_type module_fs_type = {
	.name		= "modfs",
	.get_sb		= modfs_get_sb,
	.kill_sb	= kill_litter_super,
};

int __init init_modfs(void)
{
	if (!register_filesystem(&module_fs_type)) {
		modfs_mount = kern_mount(&module_fs_type);
		if (IS_ERR(modfs_mount)) {
			printk(KERN_ERR "modfs: could not mount!\n");
			modfs_mount = NULL;
		}
	}
	return 0;
}

device_initcall(init_modfs);

/*
 * Allocate space for a module.
 */

asmlinkage unsigned long
sys_create_module(const char *name_user, size_t size)
{
	char *name;
	struct dentry *dentry;
	struct module_dir *moddir;
	int res = 0;

	if (!capable(CAP_SYS_MODULE))
		return -EPERM;

	name = getname(name_user);
	if (IS_ERR(name))
		return PTR_ERR(name);

	down(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
	dentry = lookup_one_len(name, modfs_mount->mnt_sb->s_root, strlen(name));
	if (!IS_ERR(dentry)) {
		if (!dentry->d_inode)
			res = modfs_mkdir(modfs_mount->mnt_sb->s_root->d_inode, dentry, 0755);
		else
			res = -EEXIST;
	} else
		res = PTR_ERR(dentry);
	up(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
	if (res)
		goto exit;

	moddir = dentry->d_inode->u.generic_ip;
	if (moddir->module) {
		res = -EEXIST;
		goto exit;
	}

	down(&dentry->d_inode->i_sem);
	moddir->module = lookup_one_len("module", dentry, 6);
	if (!IS_ERR(moddir->module)) {
		if (!moddir->module->d_inode)
			res = modfs_create(dentry->d_inode, moddir->module, 0600);
		else
			res = -EEXIST;
	} else
		res = PTR_ERR(moddir->module);
	up(&dentry->d_inode->i_sem);

	if (!res) {
		res = do_truncate(moddir->module, size);
		modfs_mod_file_map(moddir->module);
	}

exit:
	if (res)
		/* clean up */;
	else
		res = (unsigned long)(((struct module_data *)moddir->module->d_inode->u.generic_ip)->module);
	putname(name);
	dput(dentry);

	return res;
}

/*
 * Initialize a module.
 */

asmlinkage long
sys_init_module(const char *name_user, struct module *mod_user)
{
	char *name;
	struct dentry *dentry;
	struct module_dir *moddir;
	struct file *file;
	long res = 0;

	if (!capable(CAP_SYS_MODULE))
		return -EPERM;

	name = getname(name_user);
	if (IS_ERR(name))
		return PTR_ERR(name);

	down(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
	dentry = lookup_one_len(name, modfs_mount->mnt_sb->s_root, strlen(name));
	if (!IS_ERR(dentry)) {
		if (!dentry->d_inode)
			res = -ENOENT;
	} else
		res = PTR_ERR(dentry);
	up(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);

	if (res)
		goto exit;

	moddir = dentry->d_inode->u.generic_ip;
	if (!moddir->module) {
		res = -ENOENT;
		goto exit;
	}

	mntget(modfs_mount);
	dget(moddir->module);
	file = dentry_open(moddir->module, modfs_mount, O_RDWR);
	generic_file_write(file, (void *)mod_user, moddir->module->d_inode->i_size, &file->f_pos);
	fput(file);

	modfs_mod_file_init(moddir->module);

exit:
	putname(name);
	dput(dentry);

	return res;
}

asmlinkage long
sys_delete_module(const char *name_user)
{
	struct dentry *dentry;
	struct module_dir *moddir;
	char *name;
	long res = 0;

	if (!capable(CAP_SYS_MODULE))
		return -EPERM;

	if (!capable(CAP_SYS_MODULE))
		return -EPERM;

	name = getname(name_user);
	if (IS_ERR(name))
		return PTR_ERR(name);

	down(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
	dentry = lookup_one_len(name, modfs_mount->mnt_sb->s_root, strlen(name));
	if (!IS_ERR(dentry)) {
		if (!dentry->d_inode)
			res = -ENOENT;
	} else
		res = PTR_ERR(dentry);
	up(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);

	if (res)
		goto exit;

	moddir = dentry->d_inode->u.generic_ip;
	if (!moddir->module) {
		res = -ENOENT;
		goto exit;
	}

	res = modfs_mod_file_exit(moddir->module);
	if (!res) {
		modfs_mod_file_unmap(moddir->module);
		down(&moddir->dir->d_inode->i_sem);
		modfs_unlink(moddir->dir->d_inode, moddir->module);
		d_invalidate(moddir->module);
		dput(moddir->module);
		moddir->module = NULL;
		if (!modfs_unlink(moddir->dir->d_inode, moddir->control))
			d_invalidate(moddir->control);
		up(&moddir->dir->d_inode->i_sem);
		down(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
		if (!modfs_rmdir(modfs_mount->mnt_sb->s_root->d_inode, moddir->dir))
			d_invalidate(moddir->dir);
		up(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
	}

exit:
	putname(name);
	dput(dentry);

	return res;
}

