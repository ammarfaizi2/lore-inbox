Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161321AbWASFDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbWASFDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161322AbWASFDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:03:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:46238 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161321AbWASFDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:03:04 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060119025741.GC15706@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060119025741.GC15706@kroah.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 21:02:37 -0800
Message-Id: <1137646957.25584.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 18:57 -0800, Greg KH wrote:

> Shouldn't you just open the proper chip device and port device itself?
> That drops one ioctl.

There isn't usually a "right" chip device and port.  On a NUMA system,
you want to open the chip that is topologically closest to you, but
failing that, you want to open something that will at least work.  You
may *also* want to be able to open a specific unit/port pair, but that
would not be the normal mode of operation.

The reason for doing this through a single open syscall, instead of
making userland try each appropriate device in turn, is the same as
why /dev/ptmx exists: it guarantees that userland can't do something
stupid or racy.  The driver checks all units and ports under a single
mutex, so it doesn't have to retry to see if something got closed behind
its back, for example.

> Why not just use mmap?  What's the special needs?

mmap just maps the hardware MMIO area into user memory.  The ioctl (or
netlink message, or whatever it's going to be) does quite a lot more,
such as tell the chip where user buffers are.

> >         RCVCTRL enables/disables receipt of packets.
> 
> sysfs file.
>
> >         SET_PKEY sets a partition key, essentially telling hardware
> >         which packets are interesting to userspace.
> 
> sysfs file.
> 
> >         UPDM_TID and FREE_TID are used for RDMA context management.
> 
> sysfs files.

Really?  Not netlink messages for these?  It is rightly only the process
that has a unit/port open that should be able to modify these; can I
enforce that through sysfs without jumping through too many hoops?

> Use netlink for subnet stuff.

OK.

> > For diagnostics:

> Use debugfs.

Ah, yes.

> Use the pci sysfs config files, don't duplicate existing functionality.

OK.

> Hope this helps,

Yes, it does.  There's such a profusion of disconnected interfaces in
2.6 for driver authors to get their heads around, it is a big help to
get some directions through the thicket.

Thanks,

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

