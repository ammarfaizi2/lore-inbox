Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTLAJih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLAJih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:38:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:12214 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262395AbTLAJie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:38:34 -0500
Date: Mon, 1 Dec 2003 15:08:04 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Mike Gorse <mgorse@mgorse.dhs.org>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031201093804.GA6918@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 12:21:14AM +0000, Mike Gorse wrote:
> With 2.6.0-test11, I get a panic if I disconnect a USB serial device with
> a fd open on it and then close the fd.  When the device is disconnected,
> usb_disconnect calls usb_disable_device, which calls device_del, which
> calls kobject_del, which removes the device's sysfs directory.  If a user
> space program has the tts device open, then kobject_cleanup and
> destroy_serial do not get called until the device is closed, but by then
> the kobject_del call to the interface has caused the tty device's sysfs
> directory to be nuked from under it.  Eventually sysfs_remove_dir is
> called and eventually calls simple_rmdir with a dentry with a NULL
> d_inode, causing an oops.  I can make the Oops go away with the following
> patch:
> 
> --- fs/sysfs/dir.c.orig	2003-11-30 18:59:34.395284712 -0500
> +++ fs/sysfs/dir.c	2003-11-30 18:59:50.944768808 -0500
> @@ -83,7 +83,7 @@
>  	struct dentry * parent = dget(d->d_parent);
>  	down(&parent->d_inode->i_sem);
>  	d_delete(d);
> -	simple_rmdir(parent->d_inode,d);
> +	if (d->d_inode) simple_rmdir(parent->d_inode,d);
>  
>  	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
>  		 atomic_read(&d->d_count));
> 

Hi Mike,

IMO d->d_inode is not expected to be NULL at this point. The only
place it can become NULL is in d_delete(d) call, but as the dentry ref.
count will be atleast 2, even this will not make d_inode NULL and it should
only unhash the dentry. Probably it will become more clear if you post
the oops message.

Mean while, I think kobject_del should not remove corresponding sysfs directory
until all the other references to kobject has gone. There can be references
taken in sysfs_open_file() from user space. The following patch moves the  
sysfs_remove_dir() call, to kobject_cleanup() and I think it may solve your 
problem also. It will be nice if you can test it.

Pat, what do you think about the below patch?

Thanks
Maneesh


o kobject_del should not remove the corresponding sysfs directory untill all
  other references to kobject are gone for example references taken from 
  userspace programs doing sysfs_open_file(). Moving sysfs_remove_dir to 
  kobject_cleanup.


 lib/kobject.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN lib/kobject.c~kobject_del-fix lib/kobject.c
--- linux-2.6.0-test11/lib/kobject.c~kobject_del-fix	2003-12-01 11:02:23.000000000 +0530
+++ linux-2.6.0-test11-maneesh/lib/kobject.c	2003-12-01 11:03:51.000000000 +0530
@@ -410,7 +410,6 @@ void kobject_del(struct kobject * kobj)
 	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
 		kset_hotplug("remove", top_kobj->kset, kobj);
 
-	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
 
@@ -454,6 +453,7 @@ void kobject_cleanup(struct kobject * ko
 	struct kset * s = kobj->kset;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
+	sysfs_remove_dir(kobj);
 	if (kobj->k_name != kobj->name)
 		kfree(kobj->k_name);
 	kobj->k_name = NULL;

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
