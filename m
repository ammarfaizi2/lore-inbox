Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVBAHk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVBAHk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVBAHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:40:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:43164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261693AbVBAHkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:40:51 -0500
Date: Mon, 31 Jan 2005 22:30:24 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
Message-ID: <20050201063024.GA15179@kroah.com>
References: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com> <20050122080930.GB6999@kroah.com> <Pine.CYG.4.58.0501241016430.3748@mawilli1-desk2.amr.corp.intel.com> <20050124213906.GE18933@kroah.com> <Pine.CYG.4.58.0501251519390.2388@mawilli1-desk2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0501251519390.2388@mawilli1-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:39:00PM -0800, Mitch Williams wrote:
> 
> 
> On Mon, 24 Jan 2005, Greg KH wrote:
> >
> > Who is trying to send > 1K to a sysfs file?  Remember, sysfs files are
> > for 1 value only.  If you consider > 1K a "single value" please point me
> > to that part of the kernel that does that.
> >
> > > To the typical user, there's really no difference in behavior, unless
> > you
> > > are writing a ton of data into the file.  Of course, there's the
> > obvious
> > > question of why you'd want to do so...
> >
> > Exactly, you should not be doing that anyway.  So, because of that, I
> > really don't want/like this patch.
> 
> 
> OK, I've had a day to think about this, and I think I have a good answer
> now.
> 
> Leaving aside the issue of how big a 'single object' is, we still have to
> consider the possibility that a user _will_ indeed someday try to write 4K
> (or more) to a sysfs file.  It's just going to happen.  And right now, the
> kernel's behavior in that event is unpredictable, because we don't know
> how the c library is going to buffer this write.

That's your C library, probably not mine :)

Anyway, sure, I can see that we want to handle this in a sane manner.

> diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
> --- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
> +++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 10:47:15.000000000 -0800
> @@ -232,6 +232,8 @@ sysfs_write_file(struct file *file, cons
>  {
>  	struct sysfs_buffer * buffer = file->private_data;
> 
> +        if (*ppos > 0)
> +            return -EIO;
>  	down(&buffer->sem);
>  	count = fill_write_buffer(buffer,buf,count);
>  	if (count > 0)

You are using spaces instead of tabs :(

Care to redo it?

thanks,

greg k-h
