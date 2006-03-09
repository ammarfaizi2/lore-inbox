Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWCIGAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCIGAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCIGAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:00:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:3470 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750979AbWCIGAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:00:15 -0500
Date: Wed, 8 Mar 2006 21:58:16 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: problem with duplicate sysfs directories and files
Message-ID: <20060309055816.GB9013@kroah.com>
References: <20060308075342.GA17718@kroah.com> <20060309025824.GA4483@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309025824.GA4483@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:28:24AM +0530, Maneesh Soni wrote:
> On Tue, Mar 07, 2006 at 11:53:42PM -0800, Greg KH wrote:
> > Hi,
> > 
> > I spent some time tonight trying to track down how to fix the issue of
> > duplicate sysfs files and/or directories.  This happens when you try to
> > create a kobject with the same name in the same directory.  The creation
> > of the second kobject will fail, but the directory will remain in sysfs.
> > 
> 
> Let me understand this. Lets say we have sysfs directory tree like 
> 	/sys/a/b/c
> and someone is trying to create one more kobject with name "c" for the
> parent kobject "b" ? 

Yes.

> And are you saying that though the new creation fails but the existing
> directory remains in sysfs?

No.  The new creation fails, but we end up with two "c" directories
under "b".

> I think failing the new creation and leaving the exisiting directoy is
> ok.

I agree, but that's not what happens :)

> But there is sysfs_dirent leakage which does need fixing.

Yes.

> > Now I know this isn't a normal operation, but it would be good to fix
> > this eventually.  I traced the issue down to fs/sysfs/dir.c:create_dir()
> > and the check for:
> > 	if (error && (error != -EEXIST)) {
> > 
> > Problem is, error is set to -EEXIST, so we don't clean up properly.  Now
> > I know we can't just not check for this, as if you do that error
> > cleanup, the original kobject's sysfs entry gets very messed up (ls -l
> > does not like it at all...)
> > 
> > But I can't seem to figure out what exactly we need to do to clean up
> > properly here.
> > 
> > Do you, or anyone else, have any pointers or ideas?
> > 
> 
> If you are talking about the example above, to me it appears that except
> a possible sysfs_dirent leakage, we are some what ok, else there would have 
> been more catastrophic results because of the duplicate directory dentry/inode.
> 
> As per the current code 
> 
> static int create_dir(struct kobject * k, struct dentry * p,
>                       const char * n, struct dentry ** d)
> {
>         int error;
>         umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
> 
>         mutex_lock(&p->d_inode->i_mutex);
> 
>         *d = lookup_one_len(n, p, strlen(n));
> 
> ^^^^ lookup_one_len() will return the existing dentry corresponding to
>      the last component "c" in "/sys/a/b/c" without any error. Just note
>      that VFS is not going to allocate a new dentry for it. The existing
>      dentry's ref count will be increased by one.
> 
>         if (!IS_ERR(*d)) {
>                 error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
> 
> ^^^^ we do have problem here, a new sysfs_dirent is allocated which
>      replaces the existing dentry->d_fsdata and yuk... the old sysfs_dirent
>      is no more linked with the existing directory, there by leaking 
>      one sysfs_dirent.

Yeah, I just couldn't figure out how to clean it up properly :)

> Not only for sysfs_create_dir(), I think the problem of existing sysfs_dirent
> is also there with sysfs_add_file() and sysfs_add_link(). I am working on a 
> patch to plug this leak.

That's great, thanks.

I have a test module that shows this at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/gregkh/sysfs-test.patch
just load the 'gregkh' module and look in /sys/class/gregkh/ to see the
duplicate "gregkh1" directories.

thanks,

greg k-h
