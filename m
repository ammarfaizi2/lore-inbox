Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCaWSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCaWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:18:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:29654 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261669AbUCaWSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:18:52 -0500
Date: Wed, 31 Mar 2004 14:18:04 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       David Brownell <david-b@pacbell.net>, viro@math.psu.edu,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040331221804.GA4729@kroah.com>
References: <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com> <20040330230142.GA13571@kroah.com> <20040330235533.GA9018@kroah.com> <1080699090.1198.117.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080699090.1198.117.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 12:11:30PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2004-03-31 at 09:55, Greg KH wrote:
> > Hi,
> > 
> > The patch below backs out Maneesh's sysfs patch that was recently added
> > to the kernel.  In its defense, the original patch did solve some fixes
> > that could be duplicated on SMP machines, but the side affect of the
> > patch caused lots of problems.  Basically it caused kobjects to get
> > their references incremented when files that are not present in the
> > kobject are asked for (udev can easily trigger this when it looks for
> > files call "dev" in directories that do not have that file).  This can
> > cause easy oopses when the VFS later ages out those old dentries and the
> > kobject has its reference finally released (usually after the module
> > that the kobject lived in was removed.)
> 
> I think that the bug in the first place is to have an existing
> kobject that didn't bump the module ref count.
> 
> If a kobject exists that have a pointer to the module code (the
> release function), it _MUST_ have bumped the module ref count,
> that's the whole point of the module reference count.

But that is impossible as has already been pointed out by Alan Stern.
If a module creates a kobject, how can the module_exit() function ever
be called if that kobject incremented the module reference count?

So what we do is any reference to the kobject grabbed by userspace
causes the module reference count to go up.  That fixes the issue for
the most part (with the exception of the race that Maneesh has
documented.)

thanks,

greg k-h
