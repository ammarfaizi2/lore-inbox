Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUCaCMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUCaCMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:12:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:1433 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261638AbUCaCMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:12:22 -0500
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       David Brownell <david-b@pacbell.net>, viro@math.psu.edu,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040330235533.GA9018@kroah.com>
References: <20040328063711.GA6387@kroah.com>
	 <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org>
	 <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com>
	 <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com>
	 <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com>
	 <20040330230142.GA13571@kroah.com>  <20040330235533.GA9018@kroah.com>
Content-Type: text/plain
Message-Id: <1080699090.1198.117.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 12:11:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 09:55, Greg KH wrote:
> Hi,
> 
> The patch below backs out Maneesh's sysfs patch that was recently added
> to the kernel.  In its defense, the original patch did solve some fixes
> that could be duplicated on SMP machines, but the side affect of the
> patch caused lots of problems.  Basically it caused kobjects to get
> their references incremented when files that are not present in the
> kobject are asked for (udev can easily trigger this when it looks for
> files call "dev" in directories that do not have that file).  This can
> cause easy oopses when the VFS later ages out those old dentries and the
> kobject has its reference finally released (usually after the module
> that the kobject lived in was removed.)

I think that the bug in the first place is to have an existing
kobject that didn't bump the module ref count.

If a kobject exists that have a pointer to the module code (the
release function), it _MUST_ have bumped the module ref count,
that's the whole point of the module reference count.

If rmmod blocks forever because that kobject has a stale reference,
that's a different problem, but khubd should not be involved in
that process and should definitely not be blocked and not wait for
the kobject to go away.

Ben.


