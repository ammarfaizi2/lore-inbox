Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVEQHoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVEQHoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEQHmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:42:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41641 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261333AbVEQHiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:38:08 -0400
Date: Tue, 17 May 2005 08:38:27 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] Fix root hole in raw device
Message-ID: <20050517073827.GS1150@parcelfarce.linux.theplanet.co.uk>
References: <11163046682662@kroah.com> <11163046681444@kroah.com> <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk> <20050517070305.GA31135@alpha.home.local> <20050517070735.GB31163@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517070735.GB31163@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 09:07:35AM +0200, Willy Tarreau wrote:
> >  	struct block_device *bdev = filp->private_data;
> >  	int err = -EINVAL;
> >  
> > -	return ioctl_by_bdev(bdev, command, arg);
> > +	if (bdev && bdev->bd_inode)
> > +		err = blkdev_ioctl(bdev->bd_inode, filp, command, arg);
>                                                  ^^^^^^^
> Sorry, I forgot it...
> I meant the same with the NULL. Is it OK ?

What is that if () doing there?  bdev->bd_inode is *never* NULL - it's
set when we allocate the bdev and never changed; the code setting it
is
        if (inode->i_state & I_NEW) {
                bdev->bd_contains = NULL;
                bdev->bd_inode = inode;
so you are not going to have it NULL, no matter what.

And filp->private_data is set in raw_open() by
        filp->private_data = bdev;
a couple of lines after
        filp->f_mapping = bdev->bd_inode->i_mapping;
so it's not going to be NULL either.
