Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULJPdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULJPdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbULJPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:33:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:64477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261732AbULJPdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:33:10 -0500
Date: Fri, 10 Dec 2004 07:30:27 -0800
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jdub@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210153027.GB5827@kroah.com>
References: <20041210005055.GA17822@kroah.com> <1102689974.26320.39.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102689974.26320.39.camel@weaponx.rchland.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 08:46:14AM -0600, Josh Boyer wrote:
> On Thu, 2004-12-09 at 18:50, Greg KH wrote:
> > diff -Nru a/fs/debugfs/debugfs.h b/fs/debugfs/debugfs.h
> > --- /dev/null	Wed Dec 31 16:00:00 196900
> > +++ b/fs/debugfs/debugfs.h	2004-12-09 16:32:32 -08:00
> > @@ -0,0 +1,10 @@
> > +#define DEBUG
> > +
> > +#ifdef DEBUG
> > +#define dbg(format, arg...) printk(KERN_DEBUG "%s: " format , __FILE__ , ## arg)
> > +#else
> > +#define dbg(format, arg...) do {} while (0)
> > +#endif
> 
> Fine for now, but if it gets merged should pr_debug be used?

Yeah, good point.  I'll go change it.

> > diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
> > --- /dev/null	Wed Dec 31 16:00:00 196900
> > +++ b/fs/debugfs/file.c	2004-12-09 16:32:32 -08:00
> > @@ -0,0 +1,165 @@
> > +/*
> > + *  debugfs.c  - a tiny little debug file system for people to use instead of /proc or /sys
> 
> <NIT>
> Wrong file name :).
> </NIT>

Yeah, you can tell I split it up into 2 files at the last minute, can't
ya :)

> > +static ssize_t write_file_bool(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
> > +{
> > +	char buf[32];
> > +	int buf_size;
> > +	u32 *val = file->private_data;
> > +
> > +	buf_size = min(count, (sizeof(buf)-1));
> > +	if (copy_from_user(buf, user_buf, buf_size))
> > +		return -EFAULT;
> > +
> > +	switch (buf[0]) {
> > +	case 'y':
> > +	case 'Y':
> > +	case '1':
> > +		*val = 1;
> > +		break;
> > +	case 'n':
> > +	case 'N':
> > +	case '0':
> > +		*val = 0;
> > +		break;
> > +	}
> 
> Writing 'Y', 'y', or '1' is allowed, but only 'Y' is ever returned by
> the read function (similar for the "false" case).  That can be confusing
> to a program if it writes '1', and then checks to see if the value it
> wrote took and it gets back 'Y'.  Maybe only allow what you are going to
> return for bool values in the write case?

No, this is the exact same way (and pretty much the same code) as the
module param stuff is in sysfs today.  Just trying to be consistant
here.

> > +#define DEBUG_MAGIC	0x64626720
> 
> #define DEBUGFS_MAGIC

Hm, ok, sure.  That doesn't really matter.

> > +static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value)
> > +{ return EFF_PTR(-ENODEV); }
> 
> Could these just return NULL perhaps?  Would be more like procfs then,
> which is what I'd assume most drivers will be converting from.

No, see my previous response as to why this would be a bad thing to do.
We should all learn from the mistakes made in the past and try not to
repeat them.

Thanks for reviewing the code.

greg k-h
