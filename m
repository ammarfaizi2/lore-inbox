Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbULVRQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbULVRQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 12:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbULVRQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 12:16:28 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:34296 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261885AbULVRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 12:16:20 -0500
Subject: Re: ioctl assignment strategy?
From: Al Hooton <al@hootons.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215004620.GA15850@kroah.com>
References: <1103067067.2826.92.camel@chatsworth.hootons.org>
	 <20041215004620.GA15850@kroah.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 09:16:18 -0800
Message-Id: <1103735778.26753.92.camel@chatsworth.hootons.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	With permission from participants, posting the end of this thread back
to the list for the archives... .  a little long, if you're not
interested in strategies to avoid creating new ioctls for calls from
userspace, hit delete now....


On Tue, 2004-12-14 at 16:46 -0800, Greg KH wrote:
> Minor one coming, why do you want to use an ioctl?  ioctls are generally
> frowned upon these days, and trying to add a new one is a tough and
> arduous process, that is not for the weak, or faint of heart.


On Fri, 2004-12-17 at 15:50 -0800, Greg KH wrote:
> > 
> > We use sysfs or individual /dev nodes (now that we have a huge range of
> > major and minor numbers.)  We can also create a filesystem just for an
> > individual driver (takes less than 100 lines of kernel code now.)
> 
> 	Excellent, this is exactly what I needed to know -- architectural-level
> changes in how the kernel architects now expect things to be done.  I
> had not yet discovered the change in major/minor space during this "get
> reacquainted with the kernel" period I'm in, and was still operating
> under the old 256 minors limitation, etc., in my mind.  This is perfect!
> > 
> > What do your ioctls do?  Usually just rethinking about what is really
> > needed from them can show us where to put them.
> 
> 	In the parapin digital I/O kernel module, there are 6 operations:
> 
> - Claim the parallel port
> - Configure individual pins to be either input or output
> - Set pin states (high or low) for one or more pins using a bitmask
> - Get pin states (high or low)
> - Respond to a pin-10 hardware interrupt
> - Release the parallel port
> 
> 	My original device driver implementation uses open() to claim the port,
> close() to release it, and ioctl() for everything except setting up the
> interrupt/handler mechanisms.  Sometime in the near future I will deal
> with interrupts, but not until after I get everything else stabilized.
> 
> 	Thanks to your input, have decided a clean approach would be to use
> read/write for everything I was doing with ioctls (which, obviously,
> would have been possible anyway, but sometimes the whack with the
> cluebat makes the obvious more obvious...).  I plan to set it up such
> that each write() requires two words (a control word specifying the
> operation to perform, and a data word with a bitmask or bit values in
> it.  Each read returns a single word with current pin states, possibly
> masked by a bit mask handed down in the write().  We currently support
> building on 16-bit archs, so I don't want to combine control bits in
> words with data bits, we don't have enough space.  This will be a simple
> interface that is very easy to port to just about any platform.
> 
> 	My plan, now changed, for the interrupts is to not set up a
> signal-based mechanism, at least at first.  Instead, I will define
> another minor on the device for letting apps know an interrupt came in
> on pin 10.  When an interrupt hits, the driver will send up a single
> word to that minor.  Once an app has opened the device, it can check for
> words showing up on it, either blocking or non-blocking.  I realize
> there is increased latency with this approach, but a lot of the folks
> that use parapin are hardware engineers or students in universities with
> relatively little coding background.  Dealing with signals is farther
> down the stack than many of them will ever get.  I will probably add an
> interrupt-driven signal mechanism later for those that want to use it.
> 
> 	I may have another project coming up sometime next year, however, that
> will probably require several hundred minors, and a few majors, which
> can be dynamically defined (another great improvement in device
> interfacing since I was last poking around!).  You don't want to see how
> ugly that interface was planned to be before you pointed me to the
> major/minor improvements...     8^)=
> 
> 	Thanks again!
> 
> Best Regards,
> Al
> 

