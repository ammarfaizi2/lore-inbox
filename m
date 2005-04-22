Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVDVI4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVDVI4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVDVI4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:56:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27791 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261938AbVDVI4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:56:07 -0400
Date: Fri, 22 Apr 2005 09:56:14 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org, Mr Morton <akpm@osdl.org>,
       John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] updated inotify for 2.6.12-rc3.
Message-ID: <20050422085614.GE13052@parcelfarce.linux.theplanet.co.uk>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com> <1114146110.6973.101.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114146110.6973.101.camel@jenny.boston.ximian.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int inotify_ignore(struct inotify_device *dev, s32 wd)
> +{
> +	struct inotify_watch *watch;
> +	struct inode *inode;
> +
> +	down(&dev->sem);
> +	watch = idr_find(&dev->idr, wd);
> +	if (unlikely(!watch)) {
> +		up(&dev->sem);
> +		return -EINVAL;
> +	}
> +	get_inotify_watch(watch);
> +	up(&dev->sem);
> +
> +	inode = watch->inode;
> +	down(&inode->inotify_sem);
> +	down(&dev->sem);
> +	remove_watch(watch, dev);
> +	up(&dev->sem);
> +	up(&inode->inotify_sem);
> +	put_inotify_watch(watch);
> +
> +	return 0;
> +}

So what happens if
	* something is holding inotify_sem right now
	* ten threads call that on the same watch
	* all of them get to down(&inode->inotify_sem); and block there,
having acquired ten references to the watch
	* after whatever had been holding ->inotify_sem in the first place
releases it, they will one by one go through the rest of function.  And
drop _20_ references to the watch.  9 of those - after we kfree() the
watch...
