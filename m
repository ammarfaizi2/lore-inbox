Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbULJRg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbULJRg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbULJRg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:36:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65453 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261765AbULJRgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:36:47 -0500
Date: Fri, 10 Dec 2004 09:35:56 -0800
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210173556.GA8714@kroah.com>
References: <20041210005055.GA17822@kroah.com> <20041210172126.GA23146@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210172126.GA23146@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:21:26PM +0100, J?rn Engel wrote:
> Two-word summary: cool stuff!  Thanks!
> 
> On Thu, 9 December 2004 16:50:56 -0800, Greg KH wrote:
> > 
> > Thus debugfs was born (yes, I know there's a userspace program called
> > debugfs, this is an in-kernel filesystem and has nothing to do with
> > that.)  debugfs is ment for putting stuff that kernel developers need to
> > see exported to userspace, yet don't always want hanging around.
> 
> In principle, it is the same as /proc, just with the explicit
> information that binary compatibility will never be a goal, right?

Yes, that is correct.

> > diff -Nru a/fs/debugfs/debugfs_test.c b/fs/debugfs/debugfs_test.c
> 
> Nice example code.  But I'd vote for either killing it or renaming it
> to debugfs_example.c.  Just to document that anyone actually compiling
> it in is stupid.

Yeah, I forgot I left it in the patch, that was part of my initial test
code.  I'll clean it up and mark it as such.

> > +static ssize_t default_read_file(struct file *file, char __user *user_buf,
> > +				 size_t count, loff_t *ppos)
> 
> For a similar reason, I'd call this example_read_file().  You actually
> fooled me for a moment and I was wondering why the heck this should be
> part of debugfs. ;)

Heh, ok, will do.

> > +#define simple_type(type, format, temptype, strtolfn)	\
> > +static ssize_t read_file_##type(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)	\
> 
> Long lines.  Taste varies, but...

Good point, I'll fix that, thanks.

> > +simple_type(u8, "%c", unsigned long, simple_strtoul);
> > +simple_type(u16, "%hi", unsigned long, simple_strtoul);
> > +simple_type(u32, "%i", unsigned long, simple_strtoul);
> > +EXPORT_SYMBOL_GPL(debugfs_create_u8);
> > +EXPORT_SYMBOL_GPL(debugfs_create_u16);
> > +EXPORT_SYMBOL_GPL(debugfs_create_u32);
> 
> Move above three lines into the macro?  Or do you prefer to me the
> export move obvious?

Hm, I don't remember why I did that.  I'll move that in the macro just
to save 2 lines of code :)

> > +#include <linux/config.h>
> > +#include <linux/module.h>
> > +#include <linux/fs.h>
> > +#include <linux/mount.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/init.h>
> > +#include <linux/namei.h>
> 
> I like to sort the above alphabetically.  Shouldn't matter, but it
> looks neat and since there is no other natural order...

Well config.h should be first.  After that, sometimes it matters, but
usually not.

> > +static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t dev)
> > +{
> > +	struct inode *inode = new_inode(sb);
> > +
> > +	if (inode) {
> > +		inode->i_mode = mode;
> > +		inode->i_uid = 0;
> > +		inode->i_gid = 0;
> > +		inode->i_blksize = PAGE_CACHE_SIZE;
> > +		inode->i_blocks = 0;
> > +		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> > +		switch (mode & S_IFMT) {
> > +		default:
> > +			init_special_inode(inode, mode, dev);
> 
> Just out of curiosity: why would anyone want special nodes under
> /debug?

Just being "correct" :)
I don't think they would want special nodes, but hey, let's not prevent
anyone from doing anything.  If some looney person wants to make device
nodes in debugfs, then they deserve the ridicule they will get when
doing it...

Thanks for reviewing the code, I appreciate it.

greg k-h
