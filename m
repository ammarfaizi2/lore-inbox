Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWIGXti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWIGXti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIGXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:49:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:13752 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751908AbWIGXth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:49:37 -0400
Date: Thu, 7 Sep 2006 16:49:24 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Naughty ramdrives
Message-ID: <20060907234924.GA13787@kroah.com>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru> <20060907145412.db920bb5.akpm@osdl.org> <20060907220852.GA5192@martell.zuzino.mipt.ru> <20060907152037.a4e1437b.akpm@osdl.org> <20060907230130.GA9289@kroah.com> <20060907162800.e92b5c7c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907162800.e92b5c7c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 04:28:00PM -0700, Andrew Morton wrote:
> On Thu, 7 Sep 2006 16:01:30 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Thu, Sep 07, 2006 at 03:20:37PM -0700, Andrew Morton wrote:
> > > On Fri, 8 Sep 2006 02:08:53 +0400
> > > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > 
> > > > > So I assume udev is still madly crunching on its message backlog while
> > > > > this is happening?
> > > > >
> > > > > If so, ug.
> > > > 
> > > > OK. I'll let it stabilize, sorry.
> > > 
> > > You shouldn't have to.
> > 
> > You shouldn't have to what?  You purposefully add and remove a block
> > driver as fast as is possible, creating a ton of new events and you
> > expect userspace processing of those events to be able to keep up in
> > real-time with it?
> 
> Absolutely.  sys_init_module() should not return until the device nodes
> have stabilised.  There is no other sane interface the kernel can offer.

No, the module does not ever know that userspace is even _using_ udev,
let alone care if it is finished or not.

> ho hum.
> 
> Perhaps there's some hacklet we can put into modprobe, to allow it to peek
> at the udev sequence numbering, wait until all the events which were
> associated with this modprobe have been serviced?  Or maybe a standalone
> tool?
>
> Say, just a loopback message: send it into the kernel, knowing that it will
> be appended to the queue.  Wait until a reply comes, so you know that all
> preceding events in the queue have been serviced?

Kay does have some thoughts as to this idea, but it's more like using
the kernel to relay those "all done" events from udev back out to
whoever wants to hear it.

> Or whatever.  Right now, there's no sane way to do
> 
> 	modprobe rd
> 	mkfs /dev/ram0
> 
> so instead we could do
> 
> 	modprobe rd
> 	/sbin/wait-for-udev-to-catch-up
> 	mkfs /dev/ram0
> 
> Or something.

That's why people are switching to event driven startup logic, which
makes all of this not an issue anymore.  See
	http://www.netsplit.com/blog/2006/09/01
for one such example of a system that can handle the above situation
just fine.

"normally", udev creates those device nodes just fine, and fast enough
for your first example to work.  But if you don't want that, use
'udevsettle', which will wait until udev is finished:
	modprobe rd
	/sbin/udevsettle
	mkfs /dev/ram0

It's in use already today by some startup scripts that don't want to
switch over to being event driven.

thanks,

greg k-h
