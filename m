Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSKUWCi>; Thu, 21 Nov 2002 17:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSKUWCi>; Thu, 21 Nov 2002 17:02:38 -0500
Received: from fmr01.intel.com ([192.55.52.18]:5068 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264919AbSKUWCN>;
	Thu, 21 Nov 2002 17:02:13 -0500
Message-ID: <003701c291aa$a3b28a10$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Patrick Mochel" <mochel@osdl.org>,
       "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0211211352100.913-200000@localhost.localdomain>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Date: Thu, 21 Nov 2002 14:07:00 -0800
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

>
> Ok, I've had a chance to play with it a bit..
>
> The kprobes patch didn't apply to current -bk. Attached is an updated
> patch. I also have some comments on your 'noisy' patch, but first..
>

Very cool.  Bitkeeper is one of those things I never bothered
with yet (mainly because I feel some comfortable with CVS.)
It looks like it might be worth going through ramp-up time
on bk to keep up with changes to the kernel.

> > I can see this with a little kprobes example code that I have
> > been playing with that will create entries like:
> >
> > /sysfsroot/noisy/0xc0107ae0/sys_fork
> >
> > when someone uses that driver to insert a kernel probe
> > at 0xc0107ae0 that will printk "sys_fork".
>
> It seems that having a pure sysfs implementation would be superior,
> instead of having to use a character device to write to. After looking
> into this, I realize that a couple of pieces of infrastructure are needed,
> so I'm working on that, and will post a modified version of your module
> once I'm done..

I look forward to seeing it.

>
> > What I have noticed, is that if I create a new probe
> > (which will create the sysfs entry), open a new shell and
> > cd to /sysfsroot/noisy/0xc0107ae0, and then use my
> > driver to remove the probe (which will remove the
> > sysfs entry), then /sysfsroot/noisy/0xc0107ae0 doesn't
> > go away after I cd out of the shell.
> >
> > >From then on any attempts to create new sysfs entries
> > do not show up in /sysfsroot/ until I unload/load my driver
> > again.
> >
> > It seems like this could be an issue with some real code
> > (not just this stupid play code of mine), like maybe hotswap
> > code that updates sysfs entries.
>
> Yes, it was a real bug. I've mucked with the method to do file and
> directory deletion, and it turns out that the way I was doing it was
> wrong. I've gone back to mimmicking vfs_unlink() and vfs_rmdir(), which I
> shouldn't have diverged from in the first place. (doing d_delete() after
> low-level unlinking, instead of d_invalidate() before it).
>
> Appended to this email is my current working patch to sysfs, including
> fixes discussed and posted yesterday. I've pushed these to Linus, though
> he appears to be away. I'll push again, with this fix in the next day or
> so.
>
> Please try this patch and let me know if you still experience the problem
> you're seeing.
>
It looks like the patch is against the bk tree, and does not apply cleanly
to
strait 2.5.48.  I don't know how much has changed to sysfs/inode.c, but
I can see where the last hunk is looking too far up, so I'll try it anyway.

In the meantime I'll be grabbing bk so I can see what everyone is looking
at.

> Concerning your patch:

Thanks for taking the time to look at my module.  The reason I created
it was to get familiar with the 2.5 kernel, so this feedback is very
helpful.

I'll take a stab at the changes.

>
> > +config NOISY
>
> 'Noisy' seems like such a generic name, and the description doesn't seem
> to imply its dependence on kprobes. Maybe KPROBES_NOISY? And, you should
> put it under KPROBES, under DEBUG_KERNEL.
>

yea, I don't put much thought into a name, or where would show up
in the config.  I'll change it.

> > diff -urN linux-2.5.48-kprobes/drivers/char/noisy.c
> > linux-2.5.48-kprobes-patched/drivers/char/noisy.c
>
> > +static struct list_head probe_list;
> > +struct nprobe {
> > + struct list_head list;
> > + struct kprobe probe;
> > + char message[MAX_MSG_SIZE + 1];
> > + struct attribute attr;
> > + struct kobject kobj;
> > +};
>
> struct subsystem has a list, and kobject and entry, so you don't have to
> do it yourself..
>
> > +static ssize_t noisy_write(struct file *file, const char *buf, size_t
> > count,
> > +    loff_t *ppos)
> > +{
> > + struct nprobe *n = 0;
> > + size_t ret = -ENOMEM;
> > + char *tmp = 0;
> > +
> > + if (count > MAX_MSG_SIZE) {
> > + printk(KERN_CRIT
> > +        "noisy: Input buffer (%i bytes) is too big!\n",
> > +        count);
> > + ret = -EINVAL;
> > + goto out;
> > + }
> > +
> > + tmp = kmalloc(count + 1, GFP_KERNEL);
> > + if (!tmp) {
> > + ret = -ENOMEM;
> > + goto out;
> > + }
>
> This should be memset to 0.
>
> > + n = kmalloc(sizeof(struct nprobe), GFP_KERNEL);
> > + if (!n) {
> > + ret = -ENOMEM;
> > + goto out;
> > + }
> > + memset(n, '\0', sizeof(struct nprobe));
> > +
> > + if (copy_from_user((void *)tmp, (void *)buf, count)) {
> > + ret = -ENOMEM;
> > + goto out;
> > + }
> > + tmp[count] = '\0';
> > +
> > + if (2 != sscanf(tmp, "0x%x %s", &(n->probe).addr, n->message)) {
> > + ret = -EINVAL;
> > + goto out;
> > + }
>
> You don't free n if you get an error from copy_from_user() or sscanf().
>
> > + (n->attr).name = n->message;
> > + (n->attr).mode = S_IRUGO;
>
> Instead of doing this, you should just declare a static attribute called
> 'message' and have the contents be the message. This will save you from
> initializing it each time, and save you 4 bytes in struct nprobe.
> Something like this should work:
>
>
> struct noisy_attribute {
> struct attribute attr;
> ssize_t (*read)(struct nprobe *,char *,size_t,loff_t);
> };
>
> static ssize_t noisy_attr_show(struct kobject * kobj, struct attribute *
> attr,
>        char * page, size_t count, loff_t off)
> {
> struct nprobe * n = container_of(kobj,struct nprobe,kobj);
> struct noisy_attribute * noisy_attr = container_of(attr,struct
> noisy_attribute,attr);
> ssize_t ret = 0;
> return noisy_attr->show ? noisy_attr->show(n,page,count,off);
> }
>
> static struct sysfs_ops noisy_sysfs_ops = {
> .show = noisy_attr_show,
> };
>
>
> /* Default Attribute */
> static ssize_t noisy_message_read(struct nprobe * n, char * page, size_t
> count, loff_t off)
> {
> return off ? snprintf(page,MAX_MSG_SIZE,"%s",n->message);
> }
>
> static struct noisy_attribute attr_message = {
> .attr = { .name = "message", .mode = S_IRUGO },
> };
>
> static struct attribute * default_attrs[] = {
> &attr_message.attr,
> NULL,
> };
>
> /*
>  * sysfs stuff
>  */
>
> struct subsystem noisy_subsys = {
> .kobj = { .name = "noisy" },
> .default_attrs = default_attrs,
> .sysfs_ops = noisy_sysfs_ops,
> };
>
>
> Note that this will also save you from manually having to create and
> teardown the file when the kobject is registered and unregistered.
>
>
> -pat
>
> --- linux-2.5-virgin/fs/sysfs/inode.c Wed Nov 20 12:13:06 2002
> +++ linux-2.5-core/fs/sysfs/inode.c Thu Nov 21 13:51:32 2002
> @@ -23,6 +23,8 @@
>   * Please see Documentation/filesystems/sysfs.txt for more information.
>   */
>
> +#undef DEBUG
> +
>  #include <linux/list.h>
>  #include <linux/init.h>
>  #include <linux/pagemap.h>
> @@ -94,9 +96,10 @@
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
> @@ -142,17 +145,6 @@
>   return error;
>  }
>
> -static int sysfs_unlink(struct inode *dir, struct dentry *dentry)
> -{
> - struct inode *inode = dentry->d_inode;
> - down(&inode->i_sem);
> - dentry->d_inode->i_nlink--;
> - up(&inode->i_sem);
> - d_invalidate(dentry);
> - dput(dentry);
> - return 0;
> -}
> -
>  /**
>   * sysfs_read_file - read an attribute.
>   * @file: file pointer.
> @@ -173,17 +165,11 @@
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
> @@ -234,16 +220,11 @@
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
> - return -EINVAL;
>
>   page = (char *)__get_free_page(GFP_KERNEL);
>   if (!page)
> @@ -275,21 +256,72 @@
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
> + if (kobj->subsys)
> + ops = kobj->subsys->sysfs_ops;
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
> @@ -541,7 +573,8 @@
>   /* make sure dentry is really there */
>   if (victim->d_inode &&
>       (victim->d_parent->d_inode == dir->d_inode)) {
> - sysfs_unlink(dir->d_inode,victim);
> + simple_unlink(dir->d_inode,victim);
> + d_delete(victim);
>   }
>   }
>   up(&dir->d_inode->i_sem);
> @@ -599,19 +632,16 @@
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
> @@ -622,4 +652,3 @@
>  EXPORT_SYMBOL(sysfs_remove_link);
>  EXPORT_SYMBOL(sysfs_create_dir);
>  EXPORT_SYMBOL(sysfs_remove_dir);
> -MODULE_LICENSE("GPL");
>

