Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWASFjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWASFjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWASFjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:39:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:23492
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932540AbWASFjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:39:32 -0500
Date: Wed, 18 Jan 2006 21:39:40 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119053940.GB21467@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <20060119025741.GC15706@kroah.com> <1137646957.25584.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137646957.25584.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:02:37PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-18 at 18:57 -0800, Greg KH wrote:
> 
> > Shouldn't you just open the proper chip device and port device itself?
> > That drops one ioctl.
> 
> There isn't usually a "right" chip device and port.  On a NUMA system,
> you want to open the chip that is topologically closest to you, but
> failing that, you want to open something that will at least work.  You
> may *also* want to be able to open a specific unit/port pair, but that
> would not be the normal mode of operation.
> 
> The reason for doing this through a single open syscall, instead of
> making userland try each appropriate device in turn, is the same as
> why /dev/ptmx exists: it guarantees that userland can't do something
> stupid or racy.  The driver checks all units and ports under a single
> mutex, so it doesn't have to retry to see if something got closed behind
> its back, for example.

Ok, that's fair enough.  But if you want to do something like ptys, then
why not just have your own filesystem for this driver?

> > Why not just use mmap?  What's the special needs?
> 
> mmap just maps the hardware MMIO area into user memory.  The ioctl (or
> netlink message, or whatever it's going to be) does quite a lot more,
> such as tell the chip where user buffers are.

Ok.

> > >         UPDM_TID and FREE_TID are used for RDMA context management.
> > 
> > sysfs files.
> 
> Really?  Not netlink messages for these?  It is rightly only the process
> that has a unit/port open that should be able to modify these; can I
> enforce that through sysfs without jumping through too many hoops?

I really don't know your application enough to be sure.  If you want to
use netlink, that's fine too.

> Yes, it does.  There's such a profusion of disconnected interfaces in
> 2.6 for driver authors to get their heads around, it is a big help to
> get some directions through the thicket.

Well, for 99% of the drivers, there is no problem, as there is already a
specified and documented way to interact (like network, tty, block,
etc.)  You are just making your own type of special interface up as you
go, so the complexity is also there (this complexity would normally be
in some core code, which I am hoping that your code will turn into for
other devices of the same type, right?)

thanks,

greg k-h
