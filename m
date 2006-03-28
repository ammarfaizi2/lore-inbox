Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWC1Iv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWC1Iv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWC1Iv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:51:59 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30671 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751388AbWC1Iv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:51:58 -0500
Date: Tue, 28 Mar 2006 11:51:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filesystem Events Connector v4
Message-ID: <20060328075126.GA11334@2ka.mipt.ru>
References: <4427FF42.8070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4427FF42.8070100@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Mar 2006 11:51:29 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 11:05:38PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> This release is v4, compared with v3, it adds and improve some functions:
> 	* The user can set event filter in order to just get 
> 	  those events who concerns, filter may be based on 
> 	  event mask, pid, uid and gid.
> 	* it removes the atomic_t variable cn_fs_listener and
> 	  adopt a smart way to decide whether it should send a
> 	  event.
> 	* Add several filter operation commands and acknowleges
> 	  , add a new struct fsevent_filter as command struct.
> 
> basically, these functions enable it to meet the user's requirements better,
>  but, it can't do better because of connector broadcast property, I plan to
>  use netlink to let different user see different events, filter is based on
>  userspace appplication using it, every application can set its own filters
>  and see different events.
> 
>  drivers/connector/Kconfig     |   12 +
>  drivers/connector/Makefile    |    1 
>  drivers/connector/cn_fs.c     |  298 +++++++++++++++++++++++++++++++++++++++++
>  drivers/connector/connector.c |    4 
>  fs/namespace.c                |   12 +
>  include/linux/connector.h     |    8 -
>  include/linux/fsevent.h       |  122 +++++++++++++++++
>  include/linux/fsnotify.h      |   37 +++++
>  8 files changed, 490 insertions(+), 4 deletions(-)
> 
> Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

> +
> +#ifdef CONFIG_FS_EVENTS
> +	{
> +	u32 fsevent_mask = 0;
> +	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE))
> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
> +	if ((ia_valid & ATTR_ATIME) && (ia_valid & ATTR_MTIME))
> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
> +	else if (ia_valid & ATTR_ATIME)
> +		fsevent_mask |= FSEVENT_ACCESS;
> +	else if (ia_valid & ATTR_MTIME)
> +		fsevent_mask |= FSEVENT_MODIFY;
> +	if (ia_valid & ATTR_SIZE)
> +		fsevent_mask |= FSEVENT_MODIFY;
> +	if (fsevent_mask)
> +		raise_fsevent(dentry, fsevent_mask);
> +	}
> +#endif /* CONFIG_FS_EVENTS */
>  }

Coding style?


> --- a/drivers/connector/connector.c.orig	2006-03-27 21:35:15.000000000 +0800
> +++ b/drivers/connector/connector.c	2006-03-27 21:35:53.000000000 +0800
> @@ -111,9 +111,7 @@ int cn_netlink_send(struct cn_msg *msg, 
>  
>  	NETLINK_CB(skb).dst_group = group;
>  
> -	netlink_broadcast(dev->nls, skb, 0, group, gfp_mask);
> -
> -	return 0;
> +	return (netlink_broadcast(dev->nls, skb, 0, group, gfp_mask));
>  
>  nlmsg_failure:
>  	kfree_skb(skb);

This error value is propageted back in current connector code already.

> +
> +	/* The following definitions are commands for event filter
> +	 * , in acknowlege event for the corresponding command, it
> +	 * will set to type field of struct fsevent.
> +	*/

Not an eye-candy.

> +	FSEVENT_FILTER_ALL = 	0x08000000,	/* For all events */
> +	FSEVENT_FILTER_PID = 	0x10000000,	/* For some process ID */
> +	FSEVENT_FILTER_UID = 	0x20000000,	/* For some user ID */
> +	FSEVENT_FILTER_GID =	0x40000000,	/* For some group ID */
> +
> +	FSEVENT_ISDIR = 	0x80000000	/* It is set for a dir */
> +};
> +
> +#define FSEVENT_MASK 0x800003ff
> +
> +typedef unsigned long fsevent_mask_t;
> +
> +struct fsevent_filter {
> +	/* filter type, it just is one or bit-or of them
> +	 * FSEVENT_FILTER_ALL
> +	 * FSEVENT_FILTER_PID
> +	 * FSEVENT_FILTER_UID
> +	 * FSEVENT_FILTER_GID
> +	 */
> +	enum fsevent_type type;	/* filter type */
> +
> +	/* mask of file system events the user listen or ignore
> +	 * if the user need to ignore all the events of some pid
> +	 * , gid or uid, he(she) must set mask to FSEVENT_MASK.
> +	 */ 

"," on the new line.

> +static void turn_off_fsevents(void)
> +{
> +	write_lock(&fsevents_lock);
> +	fsevents_mask = 0;
> +	fsevents_pid_mask = 0;
> +	filter_pid = -1;
> +	fsevents_uid_mask = 0;
> +	filter_uid = -1;
> +	fsevents_gid_mask = 0;
> +	filter_gid = -1;
> +	write_unlock(&fsevents_lock);
> +}
> +
> +static int filter_fsevents(u32 * mask)
> +{
> +	int ret = 0;
> +
> +	(*mask) &= FSEVENT_MASK;
> +	read_lock(&fsevents_lock);

You do want to use RCU locking here.
It is fast path and it is not allowed to get global
smp-unfriendly read lock.

> +	if (current->pid == filter_pid) {
> +		(*mask) &= fsevents_pid_mask;
> +		if ((*mask) == 0) {
> +			ret = -2;
> +		}
> +		goto release_lock;
> +	}
> +			
> +	if (current->uid == filter_uid) {
> +		(*mask) &= fsevents_uid_mask;
> +		if ((*mask) == 0) {
> +			ret = -3;
> +		}
> +		goto release_lock;
> +	}
> +		
> +	if (current->gid == filter_gid) {
> +		(*mask) &= fsevents_gid_mask;
> +		if ((*mask) == 0) {
> +			ret = -4;
> +		}
> +		goto release_lock;
> +	}
> +
> +	if ((((*mask) & FSEVENT_ISDIR) == FSEVENT_ISDIR)
> +		 & ((fsevents_mask & FSEVENT_ISDIR) == 0)) {
> +		ret = -1;
> +		goto release_lock;
> +	}
> +
> +	(*mask) &= fsevents_mask;
> +	if ((*mask) == 0) {
> +		ret = -5;
> +	}
> +
> +release_lock:
> +	read_unlock(&fsevents_lock);
> +	return ret;
> +}

Can it be somehow turned off or moved into per-cpu variables?
It is a lot of smp-unfriendly access of global variables.

It of course costs much less than allocations and copies,
but no global lock at least.

> +	if (newname) {
> +		event->new_fname_len = strlen(newname);
> +		 append_string(&nameptr, newname, event->new_fname_len);
> +		event->len += event->new_fname_len + 1;
> +	}

A space from nowhere.

> +	if (ret == -ESRCH) {
> +		turn_off_fsevents();
> +	}

Coding style.

> +void raise_fsevent(struct dentry * dentryp, u32 mask)
> +{
> +	if (dentryp->d_inode && (MAJOR(dentryp->d_inode->i_rdev) == 4))
> +		return;
> +	__raise_fsevent(dentryp->d_name.name, NULL, mask);
> +}

Yep, tty can mess the things.
Maybe remove all special devices at all?

> +EXPORT_SYMBOL_GPL(raise_fsevent);
> +
> +void raise_fsevent_create(struct inode * inode, const char * name, u32 mask)
> +{
> +	read_lock(&fsevents_lock);
> +	__raise_fsevent(name, NULL, mask);
> +}

Lost read_lock here - you will grab it in
__raise_fsevent()->filter_fsevents().


> +static int __init cn_fs_init(void)
> +{
> +	int err;
> +
> +	if ((err = cn_add_callback(&cn_fs_event_id, "cn_fs",
> +	 			   &cn_fsevent_filter_ctl))) {
> +		printk(KERN_WARNING "cn_fs failed to register\n");
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +module_init(cn_fs_init);

Add module_exit() too.

Main issue is locking in this patchset - it is not allowed to have such
a global lock in those pathes, moving this to RCU is the way to go and definitely not a
problem to implement.

Thank you.

-- 
	Evgeniy Polyakov
