Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWE3J7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWE3J7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWE3J7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:59:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47064 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932221AbWE3J7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:59:08 -0400
Date: Tue, 30 May 2006 10:58:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch 34/61] lock validator: special locking: bdev
Message-ID: <20060530095859.GU27946@ftp.linux.org.uk>
References: <20060529212109.GA2058@elte.hu> <20060529212554.GH3155@elte.hu> <20060529183523.0985b537.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183523.0985b537.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 06:35:23PM -0700, Andrew Morton wrote:
> > +	 * For now, block device ->open() routine must _not_
> > +	 * examine anything in 'inode' argument except ->i_rdev.
> > +	 */
> > +	struct file fake_file = {};
> > +	struct dentry fake_dentry = {};
> > +	fake_file.f_mode = mode;
> > +	fake_file.f_flags = flags;
> > +	fake_file.f_dentry = &fake_dentry;
> > +	fake_dentry.d_inode = bdev->bd_inode;
> > +
> > +	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
> > +}
> 
> "crock" is a decent description ;)
> 
> How long will this live, and what will the fix look like?

The comment there is a bit deceptive.  

The real problem is with the stuff ->open() uses.  Short version of the
story:
	* everything uses inode->i_bdev.  Since we always pass an inode
allocated in block_dev.c along with bdev and its ->i_bdev points to that
bdev (i.e. at the constant offset from inode), it doesn't matter whether
we pass struct inode or struct block_device.
	* many things use file->f_mode.  Nobody modifies it.
	* some things use file->f_flags.  Used flags: O_EXCL and O_NDELAY.
Nobody modifies it.
	* one (and only one) weird driver uses something else.  That FPOS
is floppy.c and it needs more detailed description.

floppy.c is _weird_.  In addition to normally used stuff, it checks for
opener having write permissions on file->f_dentry->d_inode.  Then it
modifies file->private_data to store that information and uses it as
permission check in ->ioctl().

The rationale for that crock is a big load of bullshit.  It goes like that:
	We have priveleged ioctls and can't allow them unless you have
write permissions.
	We can't ask to just open() the damn thing for write and let these
be done as usual (and check file->f_mode & FMODE_WRITE) because we might want
them on drive that has no disk in it or a write-protected one.  Opening it
for write would try to check for disk being writable and screw itself.
	Passing O_NDELAY would avoid that problem by skipping the checks
for disk being writable, present, etc., but we can't use that.  Reasons
why we can't?  We don't need no stinkin' reasons!

IOW, *all* of that could be avoided if floppy.c
	* checked FMODE_WRITE for ability to do priveleged ioctls
	* had those who want to issue such ioctls on drive that might have
no disk in it pass O_NDELAY|O_WRONLY (or O_NDELAY|O_RDWR) when they open
the fscker.  Note that userland code always could have done that -
passing O_NDELAY|O_RDWR will do the right thing with any kernel.

That FPOS is the main reason why we pass struct file * there at all *and*
care to have ->f_dentry->d_inode in it (normally that wouldn't be even
looked at).  Again, my prefered solution would be to pass 4-bit flags and
either inode or block_device.  Flags being FMODE_READ, FMODE_WRITE,
O_EXCL and O_NDELAY.

The problem is moronic semantics for ioctl access control in floppy.c,
even though the sane API is _already_ present and always had been.  In
the very same floppy_open()...
