Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVAFUBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVAFUBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVAFUBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:01:22 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:60860 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263004AbVAFTvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:51:54 -0500
Date: Thu, 6 Jan 2005 20:51:44 +0100
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Andi Kleen <ak@suse.de>, linux-usb-devel@lists.sourceforge.net,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, davem@davemloft.net
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106195144.GE28889@wotan.suse.de>
References: <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de> <20050106193520.GA5481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106193520.GA5481@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Agree that's a problem. We just need an alternative interface here
> > or I try to come up with an x86-64 specific hack (I think it's possible
> > to do the compatibility x86-64 specific, just not in compat code for
> > all architectures who have truly separated user/kernel address spaces) 
> > 
> > I hope the USB people will eventually add a better interface here.
> > Greg?
> 
> Yes, we've been talking about a usbfs2 for a long time now, but no one
> has stepped up and done the work.  It would look a lot like gadgetfs,
> which only has a limited number of ioctls needed for its operation.
> 
> But I don't see where the problem is unique to usbfs here, don't we
> properly use the 32->64bit ioctl conversion code to solve this kind of
> issue?  Are we using it incorrectly?

DaveM can probably give you more details since he tried unsucessfully
to make it work. I think the problem is that there is no enough
information for the compat layer to convert everything.

Here's his comment from fs/compat_ioctl.c.

On x86-64 it can be a bit easier because you can get away with
only partially converting a data structure because the 32bit
space is still visible from the kernel. But that doesn't work
on some other archs. 

-Andi


/* This needs more work before we can enable it.  Unfortunately
 * because of the fancy asynchronous way URB status/error is written
 * back to userspace, we'll need to fiddle with USB devio internals
 * and/or reimplement entirely the frontend of it ourselves. -DaveM
 *
 * The issue is:
 *
 *      When an URB is submitted via usbdevicefs it is put onto an
 *      asynchronous queue.  When the URB completes, it may be reaped
 *      via another ioctl.  During this reaping the status is written
 *      back to userspace along with the length of the transfer.
 *
 *      We must translate into 64-bit kernel types so we pass in a kernel
 *      space copy of the usbdevfs_urb structure.  This would mean that we
 *      must do something to deal with the async entry reaping.  First we
 *      have to deal somehow with this transitory memory we've allocated.
 *      This is problematic since there are many call sites from which the
 *      async entries can be destroyed (and thus when we'd need to free up
 *      this kernel memory).  One of which is the close() op of usbdevicefs.
 *      To handle that we'd need to make our own file_operations struct which
 *      overrides usbdevicefs's release op with our own which runs usbdevicefs's
 *      real release op then frees up the kernel memory.
 *
 *      But how to keep track of these kernel buffers?  We'd need to either
 *      keep track of them in some table _or_ know about usbdevicefs internals
 *      (ie. the exact layout of its file private, which is actually defined
 *      in linux/usbdevice_fs.h, the layout of the async queues are private to
 *      devio.c)
 *
 * There is one possible other solution I considered, also involving knowledge
 * of usbdevicefs internals:
 *
 *      After an URB is submitted, we "fix up" the address back to the user
 *      space one.  This would work if the status/length fields written back
 *      by the async URB completion lines up perfectly in the 32-bit type with
 *      the 64-bit kernel type.  Unfortunately, it does not because the iso
 *      frame descriptors, at the end of the struct, can be written back.
 *
 * I think we'll just need to simply duplicate the devio URB engine here.
 */

