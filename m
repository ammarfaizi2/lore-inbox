Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWDZJaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWDZJaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDZJaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:30:11 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57467 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751314AbWDZJaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:30:10 -0400
In-Reply-To: <1145975582.11508.13.camel@localhost>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF537C91B1.F096EF22-ON4225715C.002FA5C3-4225715C.003433DD@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 26 Apr 2006 11:30:11 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 26/04/2006 11:31:13
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

Pekka Enberg <penberg@cs.helsinki.fi> wrote on 04/25/2006 04:33:01 PM:
> On Mon, 2006-04-24 at 19:19 +0200, Michael Holzheu wrote:
> > +static int hypfs_create_cpu_files(struct super_block *sb,
> > +              struct dentry *cpus_dir, void *cpu_info)
> > +{
> > +   struct dentry *cpu_dir;
> > +   char buffer[TMP_SIZE];
>
> Holy cow! That's 1 KB allocated on the stack! Please use kmalloc()
> instead.

Thanks! We also have found that already! Shame on me ...

> > +static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user
*buf,
> > +                size_t count, loff_t pos)
> > +{
> > +   int rc;
> > +
> > +   mutex_lock(&hypfs_lock);
> > +   if (last_update_time == get_seconds()) {
> > +      rc = -EBUSY;
> > +      goto out;
> > +   }
> > +   hypfs_delete_tree(hypfs_sblk->s_root);
>
> To state what I said earlier: the use of a global hypfs_sblk is
> problematic because now we can only have the filesystem mounted once. So
> I would really like to see some other way of updating. How do you feel
> about the s_ops->fs_remount thing?
>

I will eliminate the global variable anyway, since I can
get the superblock also from the inode:

+static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
+                               size_t count, loff_t pos)
+{
+       int rc;
+       struct super_block *sb;
+
+       mutex_lock(&hypfs_lock);
+       sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
+       if (last_update_time == get_seconds()) {
+               rc = -EBUSY;
+               goto out;
+       }
+       hypfs_delete_tree(sb->s_root);
+       rc = diag_create_files(sb, sb->s_root);
+       if (rc) {
+               printk(KERN_ERR "hypfs: Update failed\n");
+               hypfs_delete_tree(sb->s_root);
+               goto out;
+       }
+       hypfs_update_update();
+       rc = count;
+      out:
+       mutex_unlock(&hypfs_lock);
+       return rc;
+}

Hmmm... sure, you could use remount to trigger the update.
One advantage of remount is that we do not need the hypfs_lock,
right. But having the hypfs lock needs only three lines
of code and therefore this is not really a strong argument
in my eyes.

I think one disadvantage of the remount mechanism is that it
is not as intuitive as the update attribute. If you have
an update file, it is clear that writing to that file
triggers an update. That a remount triggers an update
seems to be less intuitive for me.

But the bigger disadvantage is that only root (or any user
if you specify 'user' in /etc/fstab) can trigger
the update with remount. We want to allow also other users
to trigger the update and read the attributes. The current
implementation for that is to specify uid and gid as mount
option to define the owner of the files. For example you
can run a user space program with uid xxx and specify
uid=xxx as mount option to allow the program to update
and read the data.

Michael

