Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUEJCMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUEJCMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUEJCMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:12:19 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:58011 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264488AbUEJCLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:11:46 -0400
Date: Sun, 9 May 2004 19:11:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040510021141.GA10760@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084152941.22837.21.camel@vertex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 09:35:41PM -0400, John McCutchan wrote:

> The two biggest complaints people have about dnotify are
>
> 1) dnotify delivers events using signals.

is that really a problem?

>
> 2) dnotify needs a file to be kept open on the device, causing
> problems during unmount.

i never thought of that...  what about

3) dnotify cannot easily watch changes for a directory hierarchy

> @@ -127,6 +128,7 @@
>  	return dn_mask;
>  }
>
> +
>  int notify_change(struct dentry * dentry, struct iattr * attr)
>  {
>  	struct inode *inode = dentry->d_inode;

plz don't add unnecessary whitespace

> diff -ru clean/linux-2.6.5/fs/inode.c linux-2.6.5/fs/inode.c
> +++ linux-2.6.5/fs/inode.c	2004-05-09 21:10:12.000000000 -0400
> @@ -151,6 +151,10 @@
>  			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
>  		memset(&inode->u, 0, sizeof(inode->u));
>  		inode->i_mapping = mapping;
> +
> +		INIT_LIST_HEAD(&inode->watchers);
> +		atomic_set (&inode->watcher_count, 0);
                          ^

whitespace after if/for/while but not functions:

 if (..)
 func(...)

> +#define INOTIFY_MINOR 99

there is a registry for these, i think you can use -1 (to get one
dynamically allocated) if you've not been assigned one

> #define MAX_WATCHER_COUNT 8 /* We only support 8 watchers */

seems like this could be a problem for gui stuff

> #define MAX_WATCH_COUNT 128 /* A watcher can only be watching 128 inodes */

likewise

> static int watcher_count = 0;

global variables don't need explicitly initialized to zero and in fact
this will make the kernel larger when using older gcc versions

> /* A list of these structures is attached to each inode that is being watched.
>  *  * each item in the list represents a unique watcher.
>  *   * it tell us what events we are looking at and who is watching the inode.
>  *    */

heh, odd comment style

> struct inotify_event {
>         struct list_head        list;
>         unsigned long           i_no;
>         unsigned long           i_dev;
>         unsigned long           mask;
> };

i'm not so sure using unsigned long is a good idea here,  it's size
varies depending on arch (also consider 32-bit code on 64-bit
platforms)

we might also have a 64-bit ino_t on i386 some day?  (what a revolting
idea but we have PAE, etc. so it's possible)

> 		if (watcher->private_data == dev)
> 		{
> 			return watcher;
> 		}

minor nit:

	if (...)
	   return ...;

> 	if (NULL != watcher) {

i really hate that, what is wrong with

  if (watcher)

> 	list_for_each_entry (watch, dev->watch, list)

  list_for_each_entry (...) {

> static char inotify_dev_has_events (struct inotify_device *dev)
> {
> 	return dev->events && !list_empty(dev->events);
> }

why does this need to be a separate function?

> static int __init inotify_init (void)
> {
> 	int ret;
>
> 	ret = misc_register (&inotify_device);
>
> 	if (ret) {
> 		goto out;
> 	}
>
> 	ret = 0;

if we got here, ret must be 0



  --cw
