Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265691AbSJXWje>; Thu, 24 Oct 2002 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265696AbSJXWjd>; Thu, 24 Oct 2002 18:39:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38792 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265691AbSJXWjc>;
	Thu, 24 Oct 2002 18:39:32 -0400
Date: Thu, 24 Oct 2002 15:49:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Switching from IOCTLs to a RAMFS
In-Reply-To: <3DB868BC.1@pobox.com>
Message-ID: <Pine.LNX.4.44.0210241525560.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there a namespace doc or guideline we can look at?
> (for existing nodes, sure, but more guidelines for future nodes)

There's nothing official, at least not yet. I know that's a pretty crappy 
thing to say, but I've been this -><- close to doing for some time now..

> > I would rather mature the API and consolidate the common code, than 
> > have N
> > copies of the same filesystem, each with a slightly different purpose, in
> > existence. There are so many benefits:
> >
> > - Less code duplication, and less places to fix identical bugs.
> 
> Not in this argument :)  libfs.c handles this quite nicely.  And it's 
> just a matter of moving more code into libfs.c for things like this.

ACK.

> In fact it looks like some of the sysfs/inode.c code could be moved to 
> libfs.c or should be using libfs.c code ;-)

Ok, you got me there. :)

> Further, looking at current sysfs/inode.c code, it seems that ->read and 
> ->write ops provided are severely lacking in flexibility.  If you let 
> users provide their own file_operations directly, that would be nice.   
> Calling __get_free_page and having users send data to that page is easy 
> -- and kills quite a lot of flexibility that would push one towards 
> creating a private 'meta' filesystem.  Having that page provided for you 
> is IMO really only useful for spitting out status data...

Agreed. In many cases, that page should suffice. But, for data that you
want to poll(2) or select(2) for, it doesn't work. Now, it's easy to add
an API in which the caller can pass the file_operations for a file that
they're creating.

But, then we border on what exactly we want in sysfs. The original intent 
was to provide a simple ASCII-based interface, and _not_ provide device 
nodes.

As things have matured, and more people want to move stuff out of procfs
and replace ioctls with custom filesystem interfaces, I've questioned the
original intent. In the end, I'm really ambivalent about whether to use
sysfs or a custom filesystem for custom interfaces beyond the simple
ASCII-based one. I'm not trying to either save or conquer the world with 
sysfs, and it would make my life a whole lot easier if no one at all used 
it. ;)

But, I have arguments for both sides: 

If sysfs is used, there are the arguments I presented last time: once fs
to mount, one API to create files in different subsystems, easier
association between objects.

While it's easy to create your own filesystem, either using fs/libfs.c 
helpers and/or fs/nfsd/nfsctl.c as your based, you still end up with a lot 
of replicated code. There will be copy-n-paste no matter what. I know it's 
not a really solid argument, but how much overhead is it going to incur if 
every subsystem and/or every object that belongs to each subsystem is 
exporting a filesystem instance? 


If sysfs isn't used, then everyone has their own freedom in how they read 
and write files. There are no mutations to the sysfs API, and we don't let 
it deviate from its orginal purpose. It's like procfs, only with N APIs. 
;)


So, I'm in the middle. I don't want to convolute the API, but I'd rather 
have something simple and something central for subsystems and drivers to 
use; of course done right. :)

	-pat

