Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVKXM25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVKXM25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbVKXM25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:28:57 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:55183 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161040AbVKXM25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:28:57 -0500
Date: Thu, 24 Nov 2005 17:56:15 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <greg@kroah.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
Message-ID: <20051124122614.GA16465@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123125212.GD22714@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 06:22:13PM +0530, Maneesh Soni wrote:
> On Wed, Nov 23, 2005 at 09:18:45AM +0100, Ingo Molnar wrote:
> > 
> [..]
> > on a related note - i've been carrying the patch below in -rt for 2 
> > months (i.e. Steven's kernel has it too), as a workaround against the 
> > crash described below.
> > 
> [..]
> 
> > i'm occasionally getting the crash below on a PREEMPT_RT kernel. Might 
> > be a PREEMPT_RT bug, or might be some sysfs race only visible under 
> > PREEMPT_RT. Any ideas? The crash is at:
> > 
> > (gdb) list *0xc01a2095
> > 0xc01a2095 is in sysfs_hash_and_remove (fs/sysfs/inode.c:229).
> > 224     }
> > 225
> > 226     void sysfs_hash_and_remove(struct dentry * dir, const char * name)
> > 227     {
> > 228             struct sysfs_dirent * sd;
> > 229             struct sysfs_dirent * parent_sd = dir->d_fsdata;
> > 230
> > 231             if (dir->d_inode == NULL)
> > 232                     /* no inode means this hasn't been made visible yet */
> > 233                     return;
> > (gdb)
> > 
> Looks like here it is crashing due to bogus dentry pointer in the kobject 
> kobj->dentry. Could be some stale pointer? 
> 

[From the mbox sent by Ingo]

On Sat, Sep 24, 2005 at 09:06:27AM -0500, James Bottomley wrote:
> On Sat, 2005-09-24 at 14:36 +0200, Ingo Molnar wrote:
> > so to me this seems like that in certain cases the starget->dev gets 
> > released once too often? Full log attached.
> 
> But that's not what your traces show.  The trace shows the target0:0:2
> object going through the last two phases of its lifecycle; remove and
> then release (which your trace doesn't show it as having got to).
> 
> The trace also seems to show that the object that is already gone is the
> dentry.
> 
> So, based on this, I think it's a dev<->classdev linkage problem.  This
> is what I think it is:
> 
> Previously, classdevs being interfaces on devs used to (2.6.13 and
> before) simply point to their various devs via links.  The remove (not
> release) order was always dev then classdevs.  However, remove is making
> the object invisible, so this is actually physically removing pieces of
> the sysfs infrastructure.  The problem seems to be that the dev sysfs
> directory is removed first, followed by the classdevs sysfs dir.  Even
> though the classdevs sysfs dir contains symlinks into dev, this is fine
> because symlinks don't ping the dentries of targets.  However, post

sysfs symlinks do pin dentry though not directly. The target kobject is
pinned (kobject_get) when a symlink pointing to it is created. And as
long as the target kobject is alive, the corresponding dentry will remain.
The target kobject is un-pinned when the symlink is released.

> 2.6.13 greg introduced a backlink from dev->classdev so you can tell
> what interfaces exist on a device.  In this case, that's the
> spi_transport:target0:0:2 dentry in the dev dir.  However, the dev dir
> removal appears to have released this, and we just don't notice.
> 
> To test the theory, try this patch.  However, I have no clue what to do
> about this if it truly is the problem ... we have bidirectional cross
> object links, so remove order can't be altered to fix it.  It looks like
> we need to understand why we have to remove the links in the first
> place ... if the kobject dir removal does that for us, then they're
> unnecessary.

yes, sysfs_remove_directory() will remove the contents (including symlinks)
first and then remove the directory. But there is some complication in case 
of bidirectional links. Lets say we have

[maneesh@bigbang ingo]$ ls -la a b
a:
total 8
drwxrwxr-x  2 maneesh maneesh 4096 Nov 23 23:13 .
drwxrwxr-x  4 maneesh maneesh 4096 Nov 23 23:12 ..
lrwxrwxrwx  1 maneesh maneesh    4 Nov 23 23:13 link-to-b-in-a -> ../b

b:
total 8
drwxrwxr-x  2 maneesh maneesh 4096 Nov 23 23:13 .
drwxrwxr-x  4 maneesh maneesh 4096 Nov 23 23:12 ..
lrwxrwxrwx  1 maneesh maneesh    4 Nov 23 23:13 link-to-a-in-b -> ../a

so when "link-to-b-in-a" is created a ref is taken for "b" and vice versa.

Assuming kobject "a" is deleted first (without removing the symlink 
"link-to-b-in-a"). Because of extra ref taken while creating "link-to-a-in-b", 
kobject "a" is not removed and hence sysfs_remove_dir() is also not called.

So, IMO, it is necessary to explicitly remove links before unregistering 
the kobject in case of bidirectional cross symlinks.

The patch from James, is working, because it is not creating the cross
symlink itself.



> James
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -520,8 +520,10 @@ int class_device_add(struct class_device
>  		class_name = make_class_name(class_dev);
>  		sysfs_create_link(&class_dev->kobj,
>  				  &class_dev->dev->kobj, "device");
> +		/*
>  		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
>  				  class_name);
> +		*/
>  	}
>  
>  	/* notify any interfaces this device is now here */
> @@ -618,7 +620,9 @@ void class_device_del(struct class_devic
>  	if (class_dev->dev) {
>  		class_name = make_class_name(class_dev);
>  		sysfs_remove_link(&class_dev->kobj, "device");
> +		/*
>  		sysfs_remove_link(&class_dev->dev->kobj, class_name);
> +		*/
>  	}
>  	if (class_dev->devt_attr)
>  		class_device_remove_file(class_dev, class_dev->devt_attr);
> 


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
