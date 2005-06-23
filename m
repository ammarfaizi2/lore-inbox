Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVFWUHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVFWUHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVFWUCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:02:37 -0400
Received: from soundwarez.org ([217.160.171.123]:24018 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262992AbVFWTyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:54:31 -0400
Date: Thu, 23 Jun 2005 21:54:30 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Miles Bader <miles@gnu.org>, Mike Bell <kernel@mikebell.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623195430.GA16162@vrfy.org>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050623062627.GB11638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623062627.GB11638@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:26:27PM -0700, Greg KH wrote:
> On Thu, Jun 23, 2005 at 03:14:08PM +0900, Miles Bader wrote:
> > Greg KH <greg@kroah.com> writes:
> > > And again, for embedded systems, there are packages to build it and put
> > > it in initramfs.  People have already done the work for you.
> > 
> > BTW, has anyone done a comparison of the space usage of udev vs. devfs
> > (including size of code etc....)?
> 
> Not that I know of.  If you want to do this, compare the original udev
> releases that were around 5kb of code, as the nice features it has today
> are stuff that devfs can not support at all.

Sure, the main udev target is not the embedded world, just because there
is not such a big requirement to adapt a system to so many possible changes
that a desktop system or big servers seeing today.

But we have prepared the kernel with hotplug-events over netlink and a
full featured environment carried with the event. Instead of whining
about devfs going, start implementing your own tiny "udev" that even works
without sysfs at all:

  o Set /proc/sys/kernel/hotplug to "".

  o Create a single daemon that listens for netlink/events. Use $MAJOR $MINOR
    from the environment and create a node.

  o Define a simple kernel-name <-> node-name + action lookup table in the daemon
    If an action is defined, fork an event with the environment of the received
    netlink/event and handle the event externally.

  o For bootup, embedded setups can probably just use the minimal required set
    of nodes, which are copied over to the tmpfs /dev - mount. After
    real userspace is up, the daemon will take care of maintaining /dev.

That way, you have a nice replacement for devfs, /sbin/hotplug and using
$MODALIAS a replacement for most of the hotplug scripts.

Based on udevd.c in the current udev-tree one can do this in less than a
week, still enough time before devfs is removed. :)

Thanks,
Kay
