Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757396AbWKWRZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbWKWRZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbWKWRZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:25:49 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:42408 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757441AbWKWRZs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:25:48 -0500
Date: Thu, 23 Nov 2006 12:25:33 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] libfs : file/directory removal fix, 2.6.18
Message-ID: <20061123172533.GA14803@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123082244.GF1703@Krystal> <20061123085056.GJ3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20061123085056.GJ3078@ftp.linux.org.uk>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:01:51 up 92 days, 14:09,  3 users,  load average: 1.55, 1.57, 1.36
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro (viro@ftp.linux.org.uk) wrote:
> On Thu, Nov 23, 2006 at 03:22:44AM -0500, Mathieu Desnoyers wrote:
> > Fix file and directory removal in libfs. Add inotify support for file removal.
> > 
> > The following scenario :
> > create dir a
> > create dir a/b
> > 
> > cd a/b (some process goes in cwd a/b)
> > 
> > rmdir a/b
> > rmdir a
> >
> > fails due to the fact that "a" appears to be non empty.
> 
> What?  Caller will do d_delete() itself.  Care to show a version where
> that would happen and post an strace of the second rmdir?
> 

Hi,

Let me clarify :

The following scenario, in debugfs :
a_dentry = debugfs_create_dir("a", NULL);
b_dentry = debugfs_create_dir("b", a_dentry);


Then, in a shell :
cd /mnt/debugfs/a/b

And, from within the kernel :

debugfs_remove(b_dentry);
debugfs_remove(a_dentry);

If you need an example to see for yourself, here is a _quick and dirty_ one :

-- BEGIN ---
/* test-debugfs.c
 *
 */

#include <linux/marker.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/sched.h>
#include <linux/debugfs.h>
#include <asm/ptrace.h>


static struct dentry *root_dentry;
static struct dentry *a_dentry;

static int my_open(struct inode *inode, struct file *file)
{
	struct dentry *local_dentry;
	printk("create\n");
	local_dentry = debugfs_create_dir("a", root_dentry);
	if (local_dentry == NULL)
		return -EEXIST;
	else
		a_dentry = local_dentry;

	return -EPERM;
}

static int my_open2(struct inode *inode, struct file *file)
{
	printk("remove\n");
	debugfs_remove(a_dentry);
	return -EPERM;
}


static struct file_operations my_operations_a = {
	.open = my_open,
};

static struct file_operations my_operations_b = {
	.open = my_open2,
};


int init_module(void)
{
	struct proc_dir_entry *pentry = NULL;

	root_dentry = debugfs_create_dir("test2", NULL);
	if (root_dentry == NULL)
		return -EEXIST;

	pentry = create_proc_entry("test-create", 0444, NULL);
	if (pentry)
		pentry->proc_fops = &my_operations_a;

	pentry = create_proc_entry("test-remove", 0444, NULL);
	if (pentry)
		pentry->proc_fops = &my_operations_b;

	return 0;
}

void cleanup_module(void)
{
	remove_proc_entry("test-create", NULL);
	remove_proc_entry("test-remove", NULL);
	debugfs_remove(root_dentry);
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mathieu Desnoyers");
MODULE_DESCRIPTION("Marker Test");


-- END ---

Sequence :
insmod test-debugfs.ko
cat /proc/test-create
cd /mnt/debugfs/test2/a
cat /proc/test-remove
cd /
ls /mnt/debugfs : you still see test2.



> > It is because the "b"
> > dentry is not deleted from "a" and still in use. The same problem happens if
> > "b" is a file. d_delete is nice enough to know when it needs to unhash and free
> > the dentry if nothing else is using it or, if someone is using it, to remove it
> > from the hash queues and wait for it to be deleted when it has no users.
> > 
> > The nice side-effect of this fix is that it calls the file removal
> > notification.
> 
> NAK.  First of all, I won't believe you without actual strace.
> 

I am not providing a "strace" because I am talking of simplefs_rmdir,
from libfs, which is meant to be used from within the kernel.

> What's more, WTF would fs _method_ call idiotify?  Keep that crap
> out of filesystems; caller will do it for us just fine.
> 

The 

struct inode_operations simple_dir_inode_operations = {
        .lookup         = simple_lookup,
};

seems to be populated only with the lookup, (not with rmdir, unlink, etc..).
Therefore, as the simple_rmdir and simple_unlink functions are exported with the
primary goal of being called directly (not through the VFS layer). If the goal
is to use them through the VFS, that's fine with me, but I guess their inode
operations should be exported differently, through the
simple_dir_inode_operations.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
