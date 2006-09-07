Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWIGVyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWIGVyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWIGVyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:54:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751848AbWIGVyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:54:21 -0400
Date: Thu, 7 Sep 2006 14:54:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>
Subject: Re: Naughty ramdrives
Message-Id: <20060907145412.db920bb5.akpm@osdl.org>
In-Reply-To: <20060907205927.GA5193@martell.zuzino.mipt.ru>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 00:59:27 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> You'd laugh, but...
> 
> Summary:
> 
> 	After loading and unloading rd.ko many times "ls -l /dev/ram*"
> 	results are not persistent.
> 
> Steps to reproduce:
> 
> 	# while true; do modprobe rd && rmmod rd; done
> 		[wait ~10 seconds]
> 	^C
> 	# modprobe rd
> 
> 	# ls -l /dev/ram*
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
> 	# ls -l /dev/ram*
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram13 -> rd/13
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
> 	# ls -l /dev/ram*
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram1 -> rd/1
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram11 -> rd/11
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram14 -> rd/14
> 	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram15 -> rd/15
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram3 -> rd/3
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram8 -> rd/8
> 	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram9 -> rd/9
> 
> Versions:
> 
> 	Linux 2.6.18-rc5
> 	udev 087

So I assume udev is still madly crunching on its message backlog while
this is happening?

If so, ug.

> P.S.:
> 
> This was noticed while investigating #4899
> http://bugme.osdl.org/show_bug.cgi?id=4899
> where /dev/ram0 when opened, pins module indefinitely. It seems that
> adding ->release() which undoes
> 
> 	inode = igrab(bdev->bd_inode);
> 
> should do the trick. Am I right?

Looks right.

I'm not sure that igrab() is needed though.  Probably bd_openers is
sufficient.

I'm also not sure that rd_open() needs to play with bd_openers. 
fs/block_dev.c:do_open() already does that.

