Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVLUNvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVLUNvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLUNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:51:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:47834 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932418AbVLUNvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:51:54 -0500
Date: Wed, 21 Dec 2005 19:19:02 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
Message-ID: <20051221134901.GA19746@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <17320.36949.269788.520946@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17320.36949.269788.520946@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:14:29AM +1100, Neil Brown wrote:
> 
> I suggested an early of this patch some time ago to see if it was an
> acceptable approach and got zero feedback, which presumably means it
> is perfect:-)
> 
> I've now reviewed it, fixed up the bits I didn't like, and tested it.
> It works and I am happy with in.
> 
> So: I would like to submit it for inclusion in a future kernel.
> 
> Comments, or acks, please :-)
> 
> NeilBrown
> 
> 
> ---------
> This allows an attribute file in sysfs to be polled for activity.
> 
> It works like this:
>   Open the file
>   Read all the contents.
>   Call poll requesting POLLERR or POLLPRI (so select/exceptfds works)
>   When poll returns, close the file, and go to top of loop.
> 

I am no "poll/select" expert, but is reading the contents always a
requirement for "poll"? If not then probably it is not a good idea to 
put such rules.

> Events are signaled by an object manager calling
>    sysfs_notify(kobj, dir, attr);
> 
> If the dir is non-NULL, it is used to find a subdirectory which
> contains the attribute (presumably created by sysfs_create_group).
> 
> This has a cost of one int  per attribute, one wait_queuehead per kobject,
> one int per open file.
> 
So, all the attribute files for a given kobject will use the same
wait queue? What happens if there are multiple attribute files 
polled for the same kobject.

> The name "sysfs_notify" may be confused with the inotify
> functionality.  Maybe it would be nice to support inotify for sysfs
> attributes as well?
> 
> This patch also uses sysfs_notify to allow /sys/block/md*/md/sync_action
> to be pollable
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./drivers/md/md.c         |    1 
>  ./fs/sysfs/dir.c          |    1 
>  ./fs/sysfs/file.c         |   47 ++++++++++++++++++++++++++++++++++++++++++++++
>  ./fs/sysfs/inode.c        |   20 +++++++++++++++++++
>  ./fs/sysfs/sysfs.h        |    1 
>  ./include/linux/kobject.h |    2 +
>  ./include/linux/sysfs.h   |    7 ++++++
>  ./lib/kobject.c           |    1 
>  8 files changed, 80 insertions(+)
> 
> diff ./drivers/md/md.c~current~ ./drivers/md/md.c
> --- ./drivers/md/md.c~current~	2005-12-21 09:42:07.000000000 +1100
> +++ ./drivers/md/md.c	2005-12-21 09:43:52.000000000 +1100
> @@ -162,6 +162,7 @@ void md_new_event(mddev_t *mddev)
>  {
>  	atomic_inc(&md_event_count);
>  	wake_up(&md_event_waiters);
> +	sysfs_notify(&mddev->kobj, NULL, "sync_action");
>  }
>  
>  /*
> 
> diff ./fs/sysfs/dir.c~current~ ./fs/sysfs/dir.c
> --- ./fs/sysfs/dir.c~current~	2005-12-21 09:43:51.000000000 +1100
> +++ ./fs/sysfs/dir.c	2005-12-21 09:43:52.000000000 +1100
> @@ -43,6 +43,7 @@ static struct sysfs_dirent * sysfs_new_d
>  
>  	memset(sd, 0, sizeof(*sd));
>  	atomic_set(&sd->s_count, 1);
> +	atomic_set(&sd->s_event, 0);
>  	INIT_LIST_HEAD(&sd->s_children);
>  	list_add(&sd->s_sibling, &parent_sd->s_children);
>  	sd->s_element = element;
> 
> diff ./fs/sysfs/file.c~current~ ./fs/sysfs/file.c
> --- ./fs/sysfs/file.c~current~	2005-12-21 09:43:51.000000000 +1100
> +++ ./fs/sysfs/file.c	2005-12-21 09:44:28.000000000 +1100
> @@ -7,6 +7,7 @@
>  #include <linux/kobject.h>
>  #include <linux/namei.h>
>  #include <linux/limits.h>
> +#include <linux/poll.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/semaphore.h>
> @@ -59,6 +60,7 @@ struct sysfs_buffer {
>  	struct sysfs_ops	* ops;
>  	struct semaphore	sem;
>  	int			needs_read_fill;
> +	int			event;
>  };
>  
>  
> @@ -74,6 +76,7 @@ struct sysfs_buffer {
>   */
>  static int fill_read_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
>  {
> +	struct sysfs_dirent * sd = dentry->d_fsdata;
>  	struct attribute * attr = to_attr(dentry);
>  	struct kobject * kobj = to_kobj(dentry->d_parent);
>  	struct sysfs_ops * ops = buffer->ops;
> @@ -85,6 +88,7 @@ static int fill_read_buffer(struct dentr
>  	if (!buffer->page)
>  		return -ENOMEM;
>  
> +	buffer->event = atomic_read(&sd->s_event);
>  	count = ops->show(kobj,attr,buffer->page);
>  	buffer->needs_read_fill = 0;
>  	BUG_ON(count > (ssize_t)PAGE_SIZE);
> @@ -357,12 +361,55 @@ static int sysfs_release(struct inode * 
>  	return 0;
>  }
>  
> +/* Sysfs attribute files are pollable.  The idea is that you read
> + * the content and then you use 'poll' or 'select' to wait for
> + * the content to change.  When the content changes (assuming the
> + * manager for the kobject supports notification), poll will
> + * return POLLERR|POLLPRI, and select will return the fd whether
> + * it is waiting for read, write, or exceptions.
> + * Once poll/select indicates that the value has changed, you
> + * need to close and re-open the file, as simply seeking and reading
> + * again will not get new data, or reset the state of 'poll'.
> + * Reminder: this only works for attributes which actively support
> + * it, and it is not possible to test an attribute from userspace
> + * to see if it supports poll.
> + */
> +static unsigned int sysfs_poll(struct file *filp, poll_table *wait)
> +{
> +	struct sysfs_buffer * buffer = filp->private_data;
> +	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
> +	struct sysfs_dirent * sd = filp->f_dentry->d_fsdata;
> +	int res = 0;
> +
> +	poll_wait(filp, &kobj->poll, wait);
> +
> +	if (buffer->event != atomic_read(&sd->s_event))
> +		res = POLLERR|POLLPRI;
> +
> +	return res;
> +}
> +
> +void sysfs_notify(struct kobject * k, char *dir, char *attr)
> +{
> +	struct sysfs_dirent * sd = k->dentry->d_fsdata;
> +	if (sd && dir)
> +		sd = sysfs_find(sd, dir);
> +	if (sd && attr)
> +		sd = sysfs_find(sd, attr);
> +	if (sd) {
> +		atomic_inc(&sd->s_event);
> +		wake_up_interruptible(&k->poll);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sysfs_notify);
> +
>  struct file_operations sysfs_file_operations = {
>  	.read		= sysfs_read_file,
>  	.write		= sysfs_write_file,
>  	.llseek		= generic_file_llseek,
>  	.open		= sysfs_open_file,
>  	.release	= sysfs_release,
> +	.poll		= sysfs_poll,
>  };
>  
>  
> 
> diff ./fs/sysfs/inode.c~current~ ./fs/sysfs/inode.c
> --- ./fs/sysfs/inode.c~current~	2005-12-21 09:43:51.000000000 +1100
> +++ ./fs/sysfs/inode.c	2005-12-21 09:43:52.000000000 +1100
> @@ -247,3 +247,23 @@ void sysfs_hash_and_remove(struct dentry
>  }
>  
>  
> +struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name)
> +{
> +	struct sysfs_dirent * sd, * rv = NULL;
> +
> +	if (dir->s_dentry == NULL ||
> +	    dir->s_dentry->d_inode == NULL)
> +		return NULL;
> +
> +	down(&dir->s_dentry->d_inode->i_sem);
> +	list_for_each_entry(sd, &dir->s_children, s_sibling) {
> +		if (!sd->s_element)
> +			continue;
> +		if (!strcmp(sysfs_get_name(sd), name)) {
> +			rv = sd;
> +			break;
> +		}
> +	}
> +	up(&dir->s_dentry->d_inode->i_sem);
> +	return rv;
> +}

I think there might be some issues here, if some other thread wants to
remove the kobject, while this thread is trying to notify. Testing
with some parallel add/delete operations should tell.

One can pin the sysfs_dirent corresponding to the attribute file
by doing sysfs_get() but that might create/need more complication 
related to parent sysfs_dirent and so on. Because as of now, 
sysfs_dirents have 0, 1 or 2 as ref count. At the time of creation
it is 1, and at the time of linking with dentry it is 2. Once it
becomes 0, the sysfs_dirent is freed. This was just to keep the
refcounting simple and use the already available VFS dentry refcounting.

In this case IMO, the better option is to do just lookup_one_len(), get
the dentry and then get the sysfs_dirent as dentry->d_fsdata. And once
done, do dput() which will release the references taken.

I think its time to queue a sysfs locking document in my todo list ;-)

> 
> diff ./fs/sysfs/sysfs.h~current~ ./fs/sysfs/sysfs.h
> --- ./fs/sysfs/sysfs.h~current~	2005-12-21 09:43:51.000000000 +1100
> +++ ./fs/sysfs/sysfs.h	2005-12-21 09:43:52.000000000 +1100
> @@ -10,6 +10,7 @@ extern int sysfs_make_dirent(struct sysf
>  
>  extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
>  extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
> +extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
>  
>  extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
>  extern void sysfs_remove_subdir(struct dentry *);
> 
> diff ./include/linux/kobject.h~current~ ./include/linux/kobject.h
> --- ./include/linux/kobject.h~current~	2005-12-21 09:43:51.000000000 +1100
> +++ ./include/linux/kobject.h	2005-12-21 09:43:52.000000000 +1100
> @@ -24,6 +24,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/kref.h>
>  #include <linux/kernel.h>
> +#include <linux/wait.h>
>  #include <asm/atomic.h>
>  
>  #define KOBJ_NAME_LEN			20
> @@ -54,6 +55,7 @@ struct kobject {
>  	struct kset		* kset;
>  	struct kobj_type	* ktype;
>  	struct dentry		* dentry;
> +	wait_queue_head_t	poll;
>  };




>  
>  extern int kobject_set_name(struct kobject *, const char *, ...)
> 
> diff ./include/linux/sysfs.h~current~ ./include/linux/sysfs.h
> --- ./include/linux/sysfs.h~current~	2005-12-21 09:43:52.000000000 +1100
> +++ ./include/linux/sysfs.h	2005-12-21 09:43:52.000000000 +1100
> @@ -74,6 +74,7 @@ struct sysfs_dirent {
>  	umode_t			s_mode;
>  	struct dentry		* s_dentry;
>  	struct iattr		* s_iattr;
> +	atomic_t		s_event;
>  };
>  
>  #define SYSFS_ROOT		0x0001
> @@ -118,6 +119,7 @@ int sysfs_remove_bin_file(struct kobject
>  int sysfs_create_group(struct kobject *, const struct attribute_group *);
>  void sysfs_remove_group(struct kobject *, const struct attribute_group *);
>  
> +void sysfs_notify(struct kobject * k, char *dir, char *attr);
>  #else /* CONFIG_SYSFS */
>  
>  static inline int sysfs_create_dir(struct kobject * k)
> @@ -185,6 +187,11 @@ static inline void sysfs_remove_group(st
>  	;
>  }
>  
> +static inline void sysfs_notify(struct kobject * k, char *dir, char *attr)
> +{
> +	;
> +}
> +
>  #endif /* CONFIG_SYSFS */
>  
>  #endif /* _SYSFS_H_ */
> 
> diff ./lib/kobject.c~current~ ./lib/kobject.c
> --- ./lib/kobject.c~current~	2005-12-21 09:43:52.000000000 +1100
> +++ ./lib/kobject.c	2005-12-21 09:43:52.000000000 +1100
> @@ -124,6 +124,7 @@ void kobject_init(struct kobject * kobj)
>  {
>  	kref_init(&kobj->kref);
>  	INIT_LIST_HEAD(&kobj->entry);
> +	init_waitqueue_head(&kobj->poll);
>  	kobj->kset = kset_get(kobj->kset);
>  }
>  
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
