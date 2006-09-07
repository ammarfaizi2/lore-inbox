Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWIGX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWIGX2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWIGX2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:28:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422723AbWIGX2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:28:08 -0400
Date: Thu, 7 Sep 2006 16:28:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: Re: Naughty ramdrives
Message-Id: <20060907162800.e92b5c7c.akpm@osdl.org>
In-Reply-To: <20060907230130.GA9289@kroah.com>
References: <20060907205927.GA5193@martell.zuzino.mipt.ru>
	<20060907145412.db920bb5.akpm@osdl.org>
	<20060907220852.GA5192@martell.zuzino.mipt.ru>
	<20060907152037.a4e1437b.akpm@osdl.org>
	<20060907230130.GA9289@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 16:01:30 -0700
Greg KH <greg@kroah.com> wrote:

> On Thu, Sep 07, 2006 at 03:20:37PM -0700, Andrew Morton wrote:
> > On Fri, 8 Sep 2006 02:08:53 +0400
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > > > So I assume udev is still madly crunching on its message backlog while
> > > > this is happening?
> > > >
> > > > If so, ug.
> > > 
> > > OK. I'll let it stabilize, sorry.
> > 
> > You shouldn't have to.
> 
> You shouldn't have to what?  You purposefully add and remove a block
> driver as fast as is possible, creating a ton of new events and you
> expect userspace processing of those events to be able to keep up in
> real-time with it?

Absolutely.  sys_init_module() should not return until the device nodes
have stabilised.  There is no other sane interface the kernel can offer.

ho hum.

Perhaps there's some hacklet we can put into modprobe, to allow it to peek
at the udev sequence numbering, wait until all the events which were
associated with this modprobe have been serviced?  Or maybe a standalone
tool?

Say, just a loopback message: send it into the kernel, knowing that it will
be appended to the queue.  Wait until a reply comes, so you know that all
preceding events in the queue have been serviced?

Or whatever.  Right now, there's no sane way to do

	modprobe rd
	mkfs /dev/ram0

so instead we could do

	modprobe rd
	/sbin/wait-for-udev-to-catch-up
	mkfs /dev/ram0

Or something.
