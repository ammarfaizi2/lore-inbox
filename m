Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSKWAZ7>; Fri, 22 Nov 2002 19:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbSKWAZ7>; Fri, 22 Nov 2002 19:25:59 -0500
Received: from fmr06.intel.com ([134.134.136.7]:17357 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266717AbSKWAZw>; Fri, 22 Nov 2002 19:25:52 -0500
Message-ID: <017601c29287$ddde7860$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Patrick Mochel" <mochel@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0211211637560.913-200000@localhost.localdomain>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Date: Fri, 22 Nov 2002 16:32:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Your changes added various subsys_* calls that do not seem to
exist in the latest bk tree, or in the patch you sent earlier in this
thread.

Do you have a local implementation of:

subsys_create_file()
subsys_remove_file()

and defines struct subsys_attribute?

    -rustyl

----- Original Message -----
From: "Patrick Mochel" <mochel@osdl.org>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, November 21, 2002 3:03 PM
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use


>
> > Very cool.  Bitkeeper is one of those things I never bothered
> > with yet (mainly because I feel some comfortable with CVS.)
> > It looks like it might be worth going through ramp-up time
> > on bk to keep up with changes to the kernel.
>
> There are also nightly snapshots, though I don't recall the URL off the
> top of my head..
>
> > > It seems that having a pure sysfs implementation would be superior,
> > > instead of having to use a character device to write to. After looking
> > > into this, I realize that a couple of pieces of infrastructure are
needed,
> > > so I'm working on that, and will post a modified version of your
module
> > > once I'm done..
> >
> > I look forward to seeing it.
>
> Ok, there are basically two parts to it: the required modifications to
> sysfs and your updated module.
>
> The appended patch adds the support to sysfs be defining struct
> subsys_attribute for declaring attributes of subsystems themselves, as
> well as the needed helpers for creation/teardown and read/write.
>
> I've attached a replacement for noisy.c that creates a sysfs file named
> 'ctl' that handles addition and deletion of nprobes, similar to the char
> device you had created. From the top of the file:
>
> /*
>  * Noisy Interface for Linux
>  *
>  * This driver allows arbitrary printk's to be inserted into
>  * executing kernel code by using the new kprobes interface.
>  * A message is attached to an address, and when that address
>  * is reached, the message is printed.
>  *
>  * This uses a sysfs control file to manage a list of probes.
>  * The sysfs directory is at
>  *
>  * /sys/noisy/
>  *
>  * and the control is named 'ctl'.
>  *
>  * A Noisy Probe can be added by echoing into the file, like:
>  *
>  * $ echo "add <address> <message>" > /sys/noisy/ctl
>  *
>  * where <address> is the address to break on, and <message>
>  * is the message to print when the address is reached.
>  *
>  * Probes can be removed by doing:
>  *
>  * $ echo "del <address>" > /sys/noisy/ctl
>  *
>  * where <address> is the address of the probe.
>  *
>  * The probes themselves get a directory under /sys/noisy/, and
>  * the name of the directory is the address of the probe. Each
>  * probe directory contains one file ('message') that contains
>  * the message to be printed. (More may be added later).
>  */
>
> I've tried to comment the changes and the necessary steps in making this
> work.
>
> [ Note: While I'm generally happy with the way things work, I realize that
> it still requires a decent amount of overhead in using the sysfs interface
> (see the file). I'll be looking into shrinking this...]
>
> Everything seems to work..
>
> > It looks like the patch is against the bk tree, and does not apply
cleanly
> > to
> > strait 2.5.48.  I don't know how much has changed to sysfs/inode.c, but
> > I can see where the last hunk is looking too far up, so I'll try it
anyway.
>
> Ah yes, I forgot there was a patch applied to sysfs since 2.5.48. I've
> included everything since 2.5.48 in the one I've appended.
>
>
> -pat
>
> ===== fs/sysfs/inode.c 1.60 vs 1.67 =====
> --- 1.60/fs/sysfs/inode.c Sat Nov 16 15:01:34 2002
> +++ 1.67/fs/sysfs/inode.c Thu Nov 21 17:01:53 2002
> @@ -23,6 +23,8 @@
>   * Please see Documentation/filesystems/sysfs.txt for more information.
>   */
>
> +#undef DEBUG
> +
>  #include <linux/list.h>
>  #include <linux/init.h>
>  #include <linux/pagemap.h>
> @@ -87,16 +89,17 @@
>   return inode;
>  }
>
> -static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int
mode, int dev)
> +static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int
mode, dev_t dev)
>  {
>   struct inode *inode;
>   int error = 0;
>
>   if (!dentry->d_inode) {
>   inode = sysfs_get_inode(dir->i_sb, mode, dev);
> - if (inode)
> + if (inode) {
>   d_instantiate(dentry, inode);
> - else
> + dget(dentry);
> + } else
>   error = -ENOSPC;
>   } else
>   error = -EEXIST;
> @@ -142,17 +145,43 @@
>   return error;
>  }
>
> -static int sysfs_unlink(struct inode *dir, struct dentry *dentry)
> +#define to_subsys(k) container_of(k,struct subsystem,kobj)
> +#define to_sattr(a) container_of(a,struct subsys_attribute,attr)
> +
> +/**
> + * Subsystem file operations.
> + * These operations allow subsystems to have files that can be
> + * read/written.
> + */
> +ssize_t subsys_attr_show(struct kobject * kobj, struct attribute * attr,
> + char * page, size_t count, loff_t off)
>  {
> - struct inode *inode = dentry->d_inode;
> - down(&inode->i_sem);
> - dentry->d_inode->i_nlink--;
> - up(&inode->i_sem);
> - d_invalidate(dentry);
> - dput(dentry);
> - return 0;
> + struct subsystem * s = to_subsys(kobj);
> + struct subsys_attribute * sattr = to_sattr(attr);
> + ssize_t ret = 0;
> +
> + if (sattr->show)
> + ret = sattr->show(s,page,count,off);
> + return ret;
>  }
>
> +ssize_t subsys_attr_store(struct kobject * kobj, struct attribute * attr,
> +   const char * page, size_t count, loff_t off)
> +{
> + struct subsystem * s = to_subsys(kobj);
> + struct subsys_attribute * sattr = to_sattr(attr);
> + ssize_t ret = 0;
> +
> + if (sattr->store)
> + ret = sattr->store(s,page,count,off);
> + return ret;
> +}
> +
> +static struct sysfs_ops subsys_sysfs_ops = {
> + .show = subsys_attr_show,
> + .store = subsys_attr_store,
> +};
> +
>  /**
>   * sysfs_read_file - read an attribute.
>   * @file: file pointer.
> @@ -173,17 +202,11 @@
>  sysfs_read_file(struct file *file, char *buf, size_t count, loff_t *ppos)
>  {
>   struct attribute * attr = file->f_dentry->d_fsdata;
> - struct sysfs_ops * ops = NULL;
> - struct kobject * kobj;
> + struct sysfs_ops * ops = file->private_data;
> + struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
>   unsigned char *page;
>   ssize_t retval = 0;
>
> - kobj = file->f_dentry->d_parent->d_fsdata;
> - if (kobj && kobj->subsys)
> - ops = kobj->subsys->sysfs_ops;
> - if (!ops || !ops->show)
> - return 0;
> -
>   if (count > PAGE_SIZE)
>   count = PAGE_SIZE;
>
> @@ -234,16 +257,11 @@
>  sysfs_write_file(struct file *file, const char *buf, size_t count, loff_t
*ppos)
>  {
>   struct attribute * attr = file->f_dentry->d_fsdata;
> - struct sysfs_ops * ops = NULL;
> - struct kobject * kobj;
> + struct sysfs_ops * ops = file->private_data;
> + struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
>   ssize_t retval = 0;
>   char * page;
>
> - kobj = file->f_dentry->d_parent->d_fsdata;
> - if (kobj && kobj->subsys)
> - ops = kobj->subsys->sysfs_ops;
> - if (!ops || !ops->store)
> - return 0;
>
>   page = (char *)__get_free_page(GFP_KERNEL);
>   if (!page)
> @@ -275,21 +293,77 @@
>   return retval;
>  }
>
> -static int sysfs_open_file(struct inode * inode, struct file * filp)
> +static int check_perm(struct inode * inode, struct file * file)
>  {
> - struct kobject * kobj;
> + struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
> + struct attribute * attr = file->f_dentry->d_fsdata;
> + struct sysfs_ops * ops = NULL;
>   int error = 0;
>
> - kobj = filp->f_dentry->d_parent->d_fsdata;
> - if ((kobj = kobject_get(kobj))) {
> - struct attribute * attr = filp->f_dentry->d_fsdata;
> - if (!attr)
> - error = -EINVAL;
> - } else
> - error = -EINVAL;
> + if (!kobj || !attr)
> + goto Einval;
> +
> + /* if the kobject has no subsystem, then it is a subsystem itself,
> + * so give it the subsys_sysfs_ops.
> + */
> + if (kobj->subsys)
> + ops = kobj->subsys->sysfs_ops;
> + else
> + ops = &subsys_sysfs_ops;
> +
> + /* No sysfs operations, either from having no subsystem,
> + * or the subsystem have no operations.
> + */
> + if (!ops)
> + goto Eaccess;
> +
> + /* File needs write support.
> + * The inode's perms must say it's ok,
> + * and we must have a store method.
> + */
> + if (file->f_mode & FMODE_WRITE) {
> +
> + if (!(inode->i_mode & S_IWUGO))
> + goto Eperm;
> + if (!ops->store)
> + goto Eaccess;
> +
> + }
> +
> + /* File needs read support.
> + * The inode's perms must say it's ok, and we there
> + * must be a show method for it.
> + */
> + if (file->f_mode & FMODE_READ) {
> + if (!(inode->i_mode & S_IRUGO))
> + goto Eperm;
> + if (!ops->show)
> + goto Eaccess;
> + }
> +
> + /* No error? Great, store the ops in file->private_data
> + * for easy access in the read/write functions.
> + */
> + file->private_data = ops;
> + goto Done;
> +
> + Einval:
> + error = -EINVAL;
> + goto Done;
> + Eaccess:
> + error = -EACCES;
> + goto Done;
> + Eperm:
> + error = -EPERM;
> + Done:
>   return error;
>  }
>
> +static int sysfs_open_file(struct inode * inode, struct file * filp)
> +{
> + return check_perm(inode,filp);
> +}
> +
>  static int sysfs_release(struct inode * inode, struct file * filp)
>  {
>   struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
> @@ -541,7 +615,8 @@
>   /* make sure dentry is really there */
>   if (victim->d_inode &&
>       (victim->d_parent->d_inode == dir->d_inode)) {
> - sysfs_unlink(dir->d_inode,victim);
> + simple_unlink(dir->d_inode,victim);
> + d_delete(victim);
>   }
>   }
>   up(&dir->d_inode->i_sem);
> @@ -599,19 +674,16 @@
>   list_for_each_safe(node,next,&dentry->d_subdirs) {
>   struct dentry * d = list_entry(node,struct dentry,d_child);
>   /* make sure dentry is still there */
> - if (d->d_inode)
> - sysfs_unlink(dentry->d_inode,d);
> + if (d->d_inode) {
> + simple_unlink(dentry->d_inode,d);
> + d_delete(dentry);
> + }
>   }
>
> - d_invalidate(dentry);
> - if (simple_empty(dentry)) {
> - dentry->d_inode->i_nlink -= 2;
> - dentry->d_inode->i_flags |= S_DEAD;
> - parent->d_inode->i_nlink--;
> - }
>   up(&dentry->d_inode->i_sem);
> - dput(dentry);
> -
> + d_invalidate(dentry);
> + simple_rmdir(parent->d_inode,dentry);
> + d_delete(dentry);
>   up(&parent->d_inode->i_sem);
>   dput(parent);
>  }
> @@ -622,4 +694,3 @@
>  EXPORT_SYMBOL(sysfs_remove_link);
>  EXPORT_SYMBOL(sysfs_create_dir);
>  EXPORT_SYMBOL(sysfs_remove_dir);
> -MODULE_LICENSE("GPL");
>

