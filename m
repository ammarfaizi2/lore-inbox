Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWB1TLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWB1TLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWB1TLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:11:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932428AbWB1TLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:11:50 -0500
Date: Tue, 28 Feb 2006 11:10:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: col-pepper@piments.com, linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-Id: <20060228111032.559e849b.akpm@osdl.org>
In-Reply-To: <200602281347.46169.mason@suse.com>
References: <op.s5lrw0hrj68xd1@mail.piments.com>
	<op.s5nkafhpj68xd1@mail.piments.com>
	<20060227151230.695de2af.akpm@osdl.org>
	<200602281347.46169.mason@suse.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Monday 27 February 2006 18:12, Andrew Morton wrote:
> 
> > We don't know that the same number of same-sized write()s were happening in
> > each case.
> >
> > There's been some talk about implementing fsync()-on-file-close for this
> > problem, and some protopatches.  But nothing final yet.
> 
> Here's the patch I'm using in -suse right now.  What I want to do is make a 
> much more generic -o flush, but it'll still need a few bits in individual 
> filesystem to kick off metadata writes quickly.
> 
> The basic goal behind the code is to trigger writes without waiting for both
> data and metadata.  If the user is watching the memory stick, when the 
> little light stops flashing all the data and metadata will be on disk.
> 
> It also generally throttles userland a little during file release.  This 
> could be changed to throttle for each page dirtied, but most users I 
> asked liked the current setup better.
> 
> ...
>
> +static int
> +fat_file_release(struct inode *inode, struct file *filp)

On a single line, please.

> +	if (MSDOS_SB(inode->i_sb)->options.flush) {

Did you consider making `-o flush' a generic mount option rather than
msdos-only?

I guess there isn't a lot of demand for this for other filesystems, and
having an ignored option like this is a bit misleading...

> +void
> +writeback_inode(struct inode *inode)
> +{
> +
> +	struct address_space *mapping = inode->i_mapping;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_NONE,
> +		.nr_to_write = 0,
> +	};
> +	sync_inode(inode, &wbc);
> +	filemap_fdatawrite(mapping);

I think that filemap_fdatawrite() will be a no-op?

