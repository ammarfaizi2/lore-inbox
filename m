Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUDAHMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUDAHMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:12:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:43980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261802AbUDAHMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:12:17 -0500
Date: Wed, 31 Mar 2004 22:55:34 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       David Brownell <david-b@pacbell.net>, viro@math.psu.edu,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040401065534.GD11655@kroah.com>
References: <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com> <20040330230142.GA13571@kroah.com> <20040330235533.GA9018@kroah.com> <1080699090.1198.117.camel@gaston> <20040331221804.GA4729@kroah.com> <1080784568.1435.37.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080784568.1435.37.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 11:56:09AM +1000, Benjamin Herrenschmidt wrote:
> 
> > But that is impossible as has already been pointed out by Alan Stern.
> > If a module creates a kobject, how can the module_exit() function ever
> > be called if that kobject incremented the module reference count?
> 
> I just had a loooong discussion with Rusty on that subject, it's
> indeed a nasty one.

Ah, he sucks another person into the "module unload" discussion.  My
sympathies :)

> The problem is that the real solution is to
> change the module unload semantics. Regardless of the count, module
> exit should be called, and the actual unload (and eventually calling
> an additional module "release" function) then should only happen
> once the count is down to 0. That means that rmmod would block forever
> if the driver is opened, but that is just something that needs to be
> known.
> 
> But that's not something we'll do for 2.6. For that to work, it also
> need various subsystem unregister_* (netdev etc...) functions to not
> error when the device is opened, just prevent new opens, and operate
> asynchronously (freeing data structures on kobject release) etc...

I agree, it's a difficult problem to solve, and something we aren't
going to do for 2.6.  That's one reason why module unload is its own
config option :)

Anyway, Rusty's proposal of "never unload, just mark not used" and then
load a new copy into memory that he did during the OLS timeframe last
year sounds like the only sane way to get this completely correct, with
the trade off of never releasing memory.

thanks,

greg k-h
