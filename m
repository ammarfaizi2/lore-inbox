Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTDWUcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDWUcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:32:08 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:7829 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264256AbTDWUcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:32:02 -0400
Date: Wed, 23 Apr 2003 16:44:10 -0400
To: lkml <linux-kernel@vger.kernel.org>, lsm <linux-security-module@wirex.com>
Subject: Re: [RFC][PATCH] Process Attribute API for Security Modules
Message-ID: <20030423204409.GB9609@delft.aura.cs.cmu.edu>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1049833073.1018.9.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049833073.1018.9.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that some of my comments are probably specific to whatever
policies the underlying security module implements, but

On Tue, Apr 08, 2003 at 04:17:52PM -0400, Stephen Smalley wrote:
> 2) /proc/PID/attr/exec represents the attributes to assign to the
> process upon a subsequent execve call.  A write to this node followed by
> an execve replaces the execve_secure call of the original SELinux API. 
> This is needed to support role/domain transitions in SELinux, and execve
> is the preferred point to make such transitions because it offers better
> control over the initialization of the process in the new security label
> and the inheritance of state.  In SELinux, this attribute is reset on
> execve after use so that the new program reverts to the default behavior
> for any exec calls that it may make.  In SELinux, a process can only set
> its own /proc/PID/attr/exec attribute.

The generic API seems to allow any one to read attr/current and exec
labels and you are not making any special mention of it. It would be
possible for any process to obtain someone elses 'security context' by
simply reading the label, writing it to attr/exec and then execing
itself into the existing security context.

> 3) /proc/PID/attr/fscreate represents the attributes to assign to files
> created by subsequent calls to open, mkdir, symlink, and mknod. A write

So is this equivalent to fsuid? i.e. when it isn't initialized is the
current context passed during open/mkdir/symlink/mknod?

There are filesystems that are eager to get per-process hooks to store
their own security labels or tokens. But with this API it won't be
possible to run both SE-Linux or other security module and have an
appropriately secure paritioning of AFS or Coda identities at the same
time.

And to reduce some of the code-bloat. How about dropping all those
#define ATTR_GET/ATTR_READ and such by doing something like the
following,


static ssize_t proc_pid_attr_read(struct file * file, char * buf,
				  size_t count, loff_t *ppos)
{
	struct inode * inode = file->f_dentry->d_inode;
	unsigned long page;
	ssize_t length;
	ssize_t end;
	struct task_struct *task = proc_task(inode);

	if (count > PAGE_SIZE)
		count = PAGE_SIZE;
	if (!(page = __get_free_page(GFP_KERNEL)))
		return -ENOMEM;

	length = security_getprocattr(task, file->f_dentry->d_name,
				      (char *)page, count);
	if (length < 0) {
		free_page(page);
		return length;
	}
	/* Static 4kB (or whatever) block capacity */
	if (*ppos >= length) {
		free_page(page);
		return 0;
	}
	if (count + *ppos > length)
		count = length - *ppos;
	end = count + *ppos;
	copy_to_user(buf, (char *) page + *ppos, count);
	*ppos = end;
	free_page(page);
	return count;
}

static ssize_t proc_pid_attr_write(struct file * file, const char * buf,
				   size_t count, loff_t *ppos)
{ 
	struct inode * inode = file->f_dentry->d_inode;
	char *page; 
	ssize_t length; 
	struct task_struct *task = proc_task(inode); 

	if (count > PAGE_SIZE) 
		count = PAGE_SIZE; 
	if (*ppos != 0) {
		/* No partial writes. */
		return -EINVAL;
	}
	page = (char*)__get_free_page(GFP_USER); 
	if (!page) 
		return -ENOMEM;
	length = -EFAULT; 
	if (copy_from_user(page, buf, count)) 
		goto out;

	length = security_setprocattr(task, file->f_dentry->d_name, buffer, count); \
out:
	free_page((unsigned long) page);
	return length;
} 

static struct file_operations proc_pid_attr_operations = {
	.read		= proc_pid_attr_read,
	.write		= proc_pid_attr_write,
};

static struct dentry *proc_attr_lookup(struct inode *dir, struct dentry *dentry)
{
	struct inode *inode;
	int error;
	struct task_struct *task = proc_task(dir);
	struct pid_entry *p;
	struct proc_inode *ei;

	error = -ENOENT;
	inode = NULL;

	for (p = attr_stuff; p->name; p++) {
		if (p->len != dentry->d_name.len)
			continue;
		if (!memcmp(dentry->d_name.name, p->name, p->len))
			break;
	}
	if (!p->name)
		goto out;

	error = -EINVAL;
	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
	if (!inode)
		goto out;

	ei = PROC_I(inode);
	inode->i_mode = p->mode;
	inode->i_fop = &proc_pid_attr_operations;
	dentry->d_op = &pid_dentry_operations;
	d_add(dentry, inode);
	if (!proc_task(dentry->d_inode)->pid)
		d_drop(dentry);
	return NULL;

out:
	return ERR_PTR(error);
}

Jan
