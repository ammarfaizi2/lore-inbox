Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbTJFRp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTJFRov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:44:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:39629 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263368AbTJFRoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:44:34 -0400
Date: Mon, 6 Oct 2003 10:44:15 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/6] sysfs-kobject.patch
Message-ID: <20031006174414.GB4460@kroah.com>
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com> <20031006161639.GC4125@us.ibm.com> <20031006174108.GB1788@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006174108.GB1788@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:11:08PM +0530, Dipankar Sarma wrote:
> On Mon, Oct 06, 2003 at 09:16:40AM -0700, Greg KH wrote:
> > On Mon, Oct 06, 2003 at 02:30:03PM +0530, Maneesh Soni wrote:
> > > diff -puN include/linux/kobject.h~sysfs-kobject include/linux/kobject.h
> > > --- linux-2.6.0-test6/include/linux/kobject.h~sysfs-kobject	2003-10-06 11:48:37.000000000 +0530
> > > +++ linux-2.6.0-test6-maneesh/include/linux/kobject.h	2003-10-06 11:48:51.000000000 +0530
> > > @@ -32,6 +32,12 @@ struct kobject {
> > >  	struct kset		* kset;
> > >  	struct kobj_type	* ktype;
> > >  	struct dentry		* dentry;
> > > + 	struct list_head	k_sibling;
> > > + 	struct list_head	k_children;
> > > +	struct list_head	attr;
> > > +	struct list_head	attr_group;
> > > +	struct rw_semaphore	k_rwsem;
> > > +	char 			*k_symlink;
> > >  };
> > 
> > Ouch.  Like Al said, this is too bloated.  Remember, not all kobjects
> 
> That is not what LowFree numbers after mounting sysfs says. Sure
> you add some 48 bytes to kobject, but you are no longer pinning
> 256-byte(??) dentries and possibly bigger inodes for kobjects.
> Doesn't that count ?

For kobjects that are not ever registered with sysfs?  Those kobjects
never create dentries, so yes, this is unneeded.  For an example of this
kind of usage, see the drivers/usb/serial/usb-serial.c file.  I know the
scsi people are also looking into using kobjects in this manner for some
of their internal structures.  

I would also like to use kobjects this way for all USB urbs, but they
are too heavy in their existing footprint for this to work out.  And by
adding this extra overhead, there's no way I could advocate using
kobjects for them in the future :(

thanks,

greg k-h
