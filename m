Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUKAWZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUKAWZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S310556AbUKAWZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:25:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:2238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S292944AbUKATrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:47:22 -0500
Date: Mon, 1 Nov 2004 11:46:23 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew <cmkrnl@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041101194623.GA15341@kroah.com>
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net> <20041029201314.GA29171@kroah.com> <20041029212856.GA12582@vrfy.org> <20041029231319.GA503@kroah.com> <20041030000045.GA13356@vrfy.org> <20041030002523.GA13425@vrfy.org> <20041030025429.GA13757@vrfy.org> <20041031041112.GA1711@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031041112.GA1711@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 05:11:12AM +0100, Kay Sievers wrote:
> On Sat, Oct 30, 2004 at 04:54:29AM +0200, Kay Sievers wrote:
> > On Sat, Oct 30, 2004 at 02:25:23AM +0200, Kay Sievers wrote:
> > > On Sat, Oct 30, 2004 at 02:00:45AM +0200, Kay Sievers wrote:
> > > > On Fri, Oct 29, 2004 at 06:13:19PM -0500, Greg KH wrote:
> > > > > On Fri, Oct 29, 2004 at 11:28:56PM +0200, Kay Sievers wrote:
> > > > > > > But there might still be a problem.  With this change, the sequence
> > > > > > > number is not sent out the kevent message.  Kay, do you think this is an
> > > > > > > issue?  I don't think we can get netlink messages out of order, right?
> > > > > > 
> > > > > > Right, especially not the events with the same DEVPATH, like "remove"
> > > > > > beating an "add". But I'm not sure if the number isn't useful. Whatever
> > > > > > we may do with the hotplug over netlink in the future, we will only have
> > > > > > /sbin/hotplug for the early boot and it may be nice to know, what events
> > > > > > we have already handled...
> > > > > > 
> > > > > > > I'll hold off on applying this patch until we figure this out...
> > > > > > 
> > > > > > How about just reserving 20 bytes for the number (u64 will never be
> > > > > > more than that), save the pointer to that field, and fill the number in
> > > > > > later?
> > > > > 
> > > > > Ah, something like this instead?  I like it, it's even smaller than the
> > > > > previous patch.  Compile tested only...
> > > > 
> > > > I like that. How about the following. It will keep the buffer clean from
> > > > random chars, cause the kevent does not have the vector and relies on
> > > > the '\0' to separate the strings from each other.
> > > > I've tested it. The netlink-hotplug message looks like this:
> > > > 
> > > > recv(3, "remove@/class/input/mouse2\0ACTION=remove\0DEVPATH=/class/input/mouse2\0SUBSYSTEM=input\0SEQNUM=961                 \0", 1024, 0) = 113
> > > 
> > > Hmm, these trailing spaces are just bad, sorry. I'll better pass the
> > > envp array over to send_uevent() and clean up the keys while copying
> > > the env values into the skb buffer. This will make the event payload
> > > more safe too. So your first version looks better.
> > 
> > How about this? We copy over key by key into the skb buffer and the
> > netlink message can get the envp array without depending on a single
> > continuous buffer.
> > 
> > The netlink message looks nice like this now:
> > 
> > recv(3, "
> >   add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
> >   HOME=/\0
> >   PATH=/sbin:/bin:/usr/sbin:/usr/bin\0
> >   ACTION=add\0
> >   DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
> >   SUBSYSTEM=usb\0
> >   SEQNUM=991\0
> >   DEVICE=/proc/bus/usb/003/008\0
> >   PRODUCT=46d/c03e/2000\0
> >   TYPE=0/0/0\0
> >   INTERFACE=3/1/2\0
> > ", 1024, 0) = 268
> 
> Here is an improved version that uses skb_put() to fill the skb buffer,
> instead of trimming the buffer to the final size after we've copied over
> all keys.

Thanks, I've applied this version.  Hopefully I'll get it out to Linus
later today.

greg k-h
