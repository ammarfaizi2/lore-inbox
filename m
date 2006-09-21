Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWIUDT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWIUDT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIUDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:19:27 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:57309 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751173AbWIUDT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:19:26 -0400
Date: Thu, 21 Sep 2006 08:49:21 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.18] sysfs: remove duplicated dput in sysfs_update_file
Message-ID: <20060921031921.GA7183@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <4510EFD8.2050608@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4510EFD8.2050608@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 04:38:00PM +0900, Hidetoshi Seto wrote:
> Following function can drops d_count twice against one reference
> by lookup_one_len.
> 
> <SOURCE>
> /**
>  * sysfs_update_file - update the modified timestamp on an object attribute.
>  * @kobj: object we're acting for.
>  * @attr: attribute descriptor.
>  */
> int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
> {
>         struct dentry * dir = kobj->dentry;
>         struct dentry * victim;
>         int res = -ENOENT;
> 
>         mutex_lock(&dir->d_inode->i_mutex);
>         victim = lookup_one_len(attr->name, dir, strlen(attr->name));
>         if (!IS_ERR(victim)) {
>                 /* make sure dentry is really there */
>                 if (victim->d_inode &&
>                     (victim->d_parent->d_inode == dir->d_inode)) {
>                         victim->d_inode->i_mtime = CURRENT_TIME;
>                         fsnotify_modify(victim);
> 
>                         /**
>                          * Drop reference from initial sysfs_get_dentry().
>                          */
>                         dput(victim);
>                         res = 0;
>                 } else
>                         d_drop(victim);
> 
>                 /**
>                  * Drop the reference acquired from sysfs_get_dentry() above.
>                  */
>                 dput(victim);
>         }
>         mutex_unlock(&dir->d_inode->i_mutex);
> 
>         return res;
> }
> </SOURCE>
> 
> PCI-hotplug (drivers/pci/hotplug/pci_hotplug_core.c) is only user of
> this function. I confirmed that dentry of /sys/bus/pci/slots/XXX/*
> have negative d_count value.
> 
> This patch removes unnecessary dput().
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> 
> ---
>  fs/sysfs/file.c |    5 -----
>  1 files changed, 5 deletions(-)
> 
> Index: linux-2.6.18/fs/sysfs/file.c
> ===================================================================
> --- linux-2.6.18.orig/fs/sysfs/file.c
> +++ linux-2.6.18/fs/sysfs/file.c
> @@ -483,11 +483,6 @@
>  		    (victim->d_parent->d_inode == dir->d_inode)) {
>  			victim->d_inode->i_mtime = CURRENT_TIME;
>  			fsnotify_modify(victim);
> -
> -			/**
> -			 * Drop reference from initial sysfs_get_dentry().
> -			 */
> -			dput(victim);
>  			res = 0;
>  		} else
>  			d_drop(victim);
> 
> -
> 

Looks good to me..

Thanks
Maneesh
