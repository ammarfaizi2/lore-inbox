Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267201AbUHDB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUHDB60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUHDB6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:58:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:57250 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267201AbUHDB6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:58:00 -0400
Subject: Re: Exposing ROM's though sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040804013745.7323.qmail@web14927.mail.yahoo.com>
References: <20040804013745.7323.qmail@web14927.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1091584635.1922.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 11:57:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 11:37, Jon Smirl wrote:
> Ben, can you put together a first pass on a "VGA arbitration driver"?
> You probably know more about the quirks necessary on non-x86 platforms
> than anyone else. I can help from the desktop x86 side but I've never
> worked on high end hardware that allows things like multiple active VGA
> devices. I'm sure the Mac machines and ia64 systems will need some
> special code too.

At this point, even the kernel doesn't have internally the necessary
platform hooks for dealing with multi domains legacy port IOs or
VGA memory space, it's all plaform hacks. But we can define an API at
least for userland and fix the kernel driver afterward.

I'm fairly busy this week, so it would be nice if you guys could come
up with some rough idea of the API you think the kernel driver should
provide (a /dev entry with ioctl's ? Linus won't be too happy ... something
in sysfs ?) and I can sit down & code something hopefully next week end
and/or next week.

Jesse did a pretty good summary of what features need to be provided
though. Note also that this "arbitration" layer may also need an in-kernel
API for things like vgacon or whatever may want to "grab" access to the
VGA device.

I suggest that at this point, we don't try to bother with simultaneous
access to devices on separate PCI domains, but just use an in-kernel
semaphore to arbitrate the single user at a given point in time who "owns"
the VGA access, whatever bus it is on. So we need 2 things, both in-kernel
and for userland:

 - A way to identify a VGA device on a given bus. Could this be a PCI
ID (or in kernel a pci_dev ?). That would mean no support for non-PCI stuffs,
how bad would that be ? Or we can try to be more smart and have userland
pass an ID string that contains the bus type, leaving us with some room
for accomodation of crappy bus types (read: embedded).
Maybe we just need to add to any entry in sysfs that is a VGA device some
kind of "vga_token" attribute that contains a "magic string" to be then used
with the driver for identification purposes ? For in kernel, we then just
use the pci_dev, with a special case for "legacy non-PCI" VGA ?

 - Basic API for grabbing/releasing the VGA lock, passing a given ID. This
would both take the exclusive access lock, and "set" IOs to the given device
(enable IOs to it). The API doesn't prevent future implementation of per-domain
locks if we want to have some concurrency here, though I feel that's useless.
The kernel-side is simple, the userland side could be an ioctl (hrm....).
However, should it be blocking or of trylock kind ? I don't like the idea of
userland beeing able to block the kernel (vgacon or whoever else in the kernel
need to do legacy IOs). Also, some console drivers still need to run in
'atomic' environment, though we did move a lot of things down to normal
task protected by the console semaphore, the printk and blanking code path,
afaik, are still a problem. So a simple semaphore may not do the trick. We
could simply abuse the console sem instead for now as our VGA lock, which means
that an fb driver would alwyas be called with the lock already held... but then,
we still need a call to "set"  the current active VGA device while already
owning the lock... I liked the idea of having one single call doing both.
Alan, what is your opinion there ?

 - In kernel API for vga_inX/outX and vga mem access on a given device

 - Userland should use read/write for IOs imho, either to a /dev device
(with maybe an ioctl to switch between PIO and VGA mem, though mmap is
better for the later) or to some sysfs entry (in which case, can we add
mmap call to a sysfs attribute ? last time I looked, it wasn't simple).

Ben.
 



