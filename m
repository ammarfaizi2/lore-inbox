Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUDAB6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUDAB6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:58:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:1948 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261969AbUDAB6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:58:48 -0500
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       David Brownell <david-b@pacbell.net>, viro@math.psu.edu,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040331221804.GA4729@kroah.com>
References: <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org>
	 <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com>
	 <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com>
	 <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com>
	 <20040330230142.GA13571@kroah.com> <20040330235533.GA9018@kroah.com>
	 <1080699090.1198.117.camel@gaston>  <20040331221804.GA4729@kroah.com>
Content-Type: text/plain
Message-Id: <1080784568.1435.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 11:56:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But that is impossible as has already been pointed out by Alan Stern.
> If a module creates a kobject, how can the module_exit() function ever
> be called if that kobject incremented the module reference count?

I just had a loooong discussion with Rusty on that subject, it's
indeed a nasty one. The problem is that the real solution is to
change the module unload semantics. Regardless of the count, module
exit should be called, and the actual unload (and eventually calling
an additional module "release" function) then should only happen
once the count is down to 0. That means that rmmod would block forever
if the driver is opened, but that is just something that needs to be
known.

But that's not something we'll do for 2.6. For that to work, it also
need various subsystem unregister_* (netdev etc...) functions to not
error when the device is opened, just prevent new opens, and operate
asynchronously (freeing data structures on kobject release) etc...

> So what we do is any reference to the kobject grabbed by userspace
> causes the module reference count to go up.  That fixes the issue for
> the most part (with the exception of the race that Maneesh has
> documented.)

Well.... Maybe, I still think it's dodgy, but probably fine for 2.6

Ben.


