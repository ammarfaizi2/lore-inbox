Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKTV6U>; Wed, 20 Nov 2002 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSKTV5Z>; Wed, 20 Nov 2002 16:57:25 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:18048 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261701AbSKTV4h>;
	Wed, 20 Nov 2002 16:56:37 -0500
Date: Wed, 20 Nov 2002 23:03:38 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] module fs or how to not break everything at once
Message-ID: <20021120220338.GA6079@vana>
References: <Pine.LNX.4.44.0211202013000.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211202013000.2113-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 10:06:01PM +0100, Roman Zippel wrote:
> 
> what a fool I am. ;-). ) OTOH it's pretty interesting to see that nobody 
> seems to care, as the kernel loader is now in everybody's kernel and if 
> everyone were happy, someone should be able tell me, why it should be kept 
> in the kernel.

Nobody is answering for almost hour, so I'll do...

It was surprise to me that after patching about 100 lines in my
kernel I can live without modules ;-) I cannot redistribute it because
of vmmon/vmnet are linked directly to kernel, but it works. Maybe
I should be constructive, and update module-init-tools to fit my
needs (-p, -s; error messages from insmod going to screen and
not to the dmesg by default..., post-install/pre-install/post-remove/pre-remove
support in modprobe), but after comparing size of modutils and
module-init-tools I'll just leave this job to others: it looks like 
fulltime job for couple of months.

> Below is a basic module fs implementation, which demonstrates an 
> alternative way of managing modules. It's reduced to the most basic 
> functionality needed to get modules working: map an object into kernel 
> space and start/stop a module. Everything else can and should be done in 
> user space. On top of this functionality it's easy to emulate the old 
> system calls, so old insmod/rmmod work just fine. This allows now to write 
> new module tools and when they are ready (this means we're also happy with 
> the new module interface), we can drop all the old syscalls. The new 

Nice, but...

> static ssize_t modfs_control_file_write(struct file *file, const char *buffer,
> 					size_t count, loff_t *ppos)
> {
> 	struct dentry *dentry;
> 	char *data;
> 
> 	data = __getname();
> 	if (!data)
> 		return -ENOMEM;
> 	count = min(count, (size_t)PATH_MAX - 1);
> 	if (!copy_from_user(data, buffer, count)) {
> 		data[count] = 0;
> 		if (!strncmp(data, "map ", 4)) {

... now when we have setxattr() in kernel, what about using
setxattr() on module directory instead of separate control file? 
I know, you cannot manage it with "echo" then, but it looks
strange that mkdir automatically creates control file while
rmdir does not remove it automatically... and without control
file, sys_delete_module() could then use simple setxattr/vfs_unlink/vfs_rmdir
instead of doing vfs's job by hand.

> 	down(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);
> 	dentry = lookup_one_len(name, modfs_mount->mnt_sb->s_root, strlen(name));
> 	if (!IS_ERR(dentry)) {
> 		if (!dentry->d_inode)
> 			res = modfs_mkdir(modfs_mount->mnt_sb->s_root->d_inode, dentry, 0755);
> 		else
> 			res = -EEXIST;
> 	} else
> 		res = PTR_ERR(dentry);
> 	up(&modfs_mount->mnt_sb->s_root->d_inode->i_sem);

You are skipping security_ops hooks. Can you use vfs_mkdir() instead
of modfs_mkdir(), just to make sure that if someone adds some new
features into vfs_mkdir(), you'll not miss them ?

> asmlinkage long
> sys_delete_module(const char *name_user)
> {
> 	struct dentry *dentry;
> 	struct module_dir *moddir;
> 	char *name;
> 	long res = 0;
> 
> 	if (!capable(CAP_SYS_MODULE))
> 		return -EPERM;
> 
> 	if (!capable(CAP_SYS_MODULE))
> 		return -EPERM;

One pair of these lines is redundant...

And one minor comment: do you really need both module_dir->module
and module_data->module? Do you use it only to make sure that
sys_delete_module will not operate on modules not created by
sys_init_module? 

It has unfortunate feature that sys_create_module(); 
sys_delete_module() (without suceeding sys_init_module between
them) will return -ENOENT, and you'll have to use rm/rmdir to get 
rid of module :-(
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


