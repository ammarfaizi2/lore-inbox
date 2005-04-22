Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVDVPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVDVPQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVDVPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:13:48 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:54187
	"EHLO vertex") by vger.kernel.org with ESMTP id S261977AbVDVPEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:04:05 -0400
Subject: Re: [patch] updated inotify for 2.6.12-rc3.
From: John McCutchan <ttb@tentacle.dhs.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org,
       Mr Morton <akpm@osdl.org>
In-Reply-To: <20050422085614.GE13052@parcelfarce.linux.theplanet.co.uk>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com>
	 <1114146110.6973.101.camel@jenny.boston.ximian.com>
	 <20050422085614.GE13052@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Apr 2005 11:04:33 -0400
Message-Id: <1114182273.13886.17.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-22 at 09:56 +0100, Al Viro wrote:
> > +static int inotify_ignore(struct inotify_device *dev, s32 wd)
> > +{
> > +	struct inotify_watch *watch;
> > +	struct inode *inode;
> > +
> > +	down(&dev->sem);
> > +	watch = idr_find(&dev->idr, wd);
> > +	if (unlikely(!watch)) {
> > +		up(&dev->sem);
> > +		return -EINVAL;
> > +	}
> > +	get_inotify_watch(watch);
> > +	up(&dev->sem);
> > +
> > +	inode = watch->inode;
> > +	down(&inode->inotify_sem);
> > +	down(&dev->sem);
> > +	remove_watch(watch, dev);
> > +	up(&dev->sem);
> > +	up(&inode->inotify_sem);
> > +	put_inotify_watch(watch);
> > +
> > +	return 0;
> > +}
> 
> So what happens if
> 	* something is holding inotify_sem right now
> 	* ten threads call that on the same watch
> 	* all of them get to down(&inode->inotify_sem); and block there,
> having acquired ten references to the watch
> 	* after whatever had been holding ->inotify_sem in the first place
> releases it, they will one by one go through the rest of function.  And
> drop _20_ references to the watch.  9 of those - after we kfree() the
> watch...

In create_watch () we call get_inotify_watch (), which maps to the
put_inotify_watch() in remove_watch(). As far as I can tell the ref
counting is 1 for 1.


-- 
John McCutchan <ttb@tentacle.dhs.org>
