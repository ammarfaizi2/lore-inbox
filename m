Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUEJWQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUEJWQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUEJWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:16:00 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:48815
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S261693AbUEJWOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:14:55 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: nautilus-list@gnome.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040510021141.GA10760@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084227460.28663.8.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 18:17:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-09 at 22:11, Chris Wedgwood wrote:
> On Sun, May 09, 2004 at 09:35:41PM -0400, John McCutchan wrote:
> 
> > The two biggest complaints people have about dnotify are
> >
> > 1) dnotify delivers events using signals.
> 
> is that really a problem?

According to everyone who uses dnotify it is.

> >
> > 2) dnotify needs a file to be kept open on the device, causing
> > problems during unmount.
> 
> i never thought of that...  what about
> 
> 3) dnotify cannot easily watch changes for a directory hierarchy

People don't seem to really care about this one. Alexander Larsson has
said he doesn't care about it. It might be nice to add in the future.

> 
> > @@ -127,6 +128,7 @@
> >  	return dn_mask;
> >  }
> >
> > +
> >  int notify_change(struct dentry * dentry, struct iattr * attr)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> 
> plz don't add unnecessary whitespace

fixed

> 
> > diff -ru clean/linux-2.6.5/fs/inode.c linux-2.6.5/fs/inode.c
> > +++ linux-2.6.5/fs/inode.c	2004-05-09 21:10:12.000000000 -0400
> > @@ -151,6 +151,10 @@
> >  			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
> >  		memset(&inode->u, 0, sizeof(inode->u));
> >  		inode->i_mapping = mapping;
> > +
> > +		INIT_LIST_HEAD(&inode->watchers);
> > +		atomic_set (&inode->watcher_count, 0);
>                           ^
> 
> whitespace after if/for/while but not functions:
> 
>  if (..)
>  func(...)

fixed

> 
> > +#define INOTIFY_MINOR 99
> 
> there is a registry for these, i think you can use -1 (to get one
> dynamically allocated) if you've not been assigned one

fixed

> 
> > #define MAX_WATCHER_COUNT 8 /* We only support 8 watchers */
> 
> seems like this could be a problem for gui stuff

see below

> 
> > #define MAX_WATCH_COUNT 128 /* A watcher can only be watching 128 inodes */
> 
> likewise

The idea is to encourage use of a user-space daemon that will multiplex
all requests, so if 5 people want to watch /somedir the daemon will only
use one watcher in the kernel. The number might be too low, but its
easily upped.

> 
> > static int watcher_count = 0;
> 
> global variables don't need explicitly initialized to zero and in fact
> this will make the kernel larger when using older gcc versions

fixed

> 
> > struct inotify_event {
> >         struct list_head        list;
> >         unsigned long           i_no;
> >         unsigned long           i_dev;
> >         unsigned long           mask;
> > };
> 
> i'm not so sure using unsigned long is a good idea here,  it's size
> varies depending on arch (also consider 32-bit code on 64-bit
> platforms)
> 
> we might also have a 64-bit ino_t on i386 some day?  (what a revolting
> idea but we have PAE, etc. so it's possible)

I now use ino_t and dev_t , though in struct inode, i_no is unsigned
long?

> > static char inotify_dev_has_events (struct inotify_device *dev)
> > {
> > 	return dev->events && !list_empty(dev->events);
> > }
> 
> why does this need to be a separate function?

Modularity. I changed it to a macro though.

> 
> > static int __init inotify_init (void)
> > {
> > 	int ret;
> >
> > 	ret = misc_register (&inotify_device);
> >
> > 	if (ret) {
> > 		goto out;
> > 	}
> >
> > 	ret = 0;
> 
> if we got here, ret must be 0
> 
> 

fixed


Thanks for the review. 

John
