Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265637AbTFSAAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265638AbTFSAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:00:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16351 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265637AbTFSAAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:00:41 -0400
Date: Wed, 18 Jun 2003 16:52:32 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking - take 2
Message-ID: <20030618235232.GA2667@kroah.com>
References: <20030618212921.GA1807@kroah.com> <20030618153324.A20212@figure1.int.wirex.com> <20030618224609.GB2215@kroah.com> <20030618163237.A21050@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618163237.A21050@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 04:32:37PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > Hm, I think we should probably just check in pci_get_device() to verify
> > that ->next is really valid.  If it isn't just return NULL, as we have
> > no idea what the next device would possibly be.  The worse thing that
> > would happen is the proc file would be a bit shorter than expected.  If
> > read again, it would be correct, with the previously referenced device
> > now gone.
> 
> I'm not sure testing a valid ->next makes sense.  It could be non-NULL,
> but poison, or if it was using list_del_init, it would be stuck in loop.

When we take the devices off of the list, after list_del(), still under
the lock, we can null out the list pointers.  Then, later under the
lock, we can check the pointer before we move to it.  We aren't doing
fancy list_* functions with the pci device lists at all.

> > I don't want to try to hold a lock over start/next/stop as that would
> > just be asking for trouble :)
> 
> Heh, I agree, it doesn't feel quite right to acquire lock and release
> lock in separate functions, but in the case of start/show/next/stop this
> seems to be the design.  Alternative here seems to be keeping thing on
> list with get and deleting from with put on last ref, but that didn't
> look so simple.

No, that isn't the proper model anyway.  After the device is removed, we
don't want to still have it floating around on the device lists, even if
someone has a reference to it.  That would make things just too
difficult :)

I'll go and try to see how the above proposed changes will work out, and
see if I can see any side affects when beating on /proc/pci on a pci
hotplug box...

thanks,

greg k-h
