Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUIYTR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUIYTR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUIYTR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:17:26 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:1807 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269394AbUIYTRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:17:14 -0400
Message-ID: <9e473391040925121774e7e1e1@mail.gmail.com>
Date: Sat, 25 Sep 2004 15:17:14 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: __initcall macros and C token pasting
Cc: lkml <linux-kernel@vger.kernel.org>,
       dri-devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104092510574c908525@mail.gmail.com>
	 <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To start off with, I didn't write the DRM macros, I'm just trying to
work with the code that is already there. Here's my understanding of
the state of the macros...

The DRM macros are there because of the way DRM is built. There are
two pieces of DRM, the core and the chip drivers. Most drivers, like
fbdev, make the core into one module and the chip drivers into others.
This allows the chip drivers to share the core code.

DRM is built differently. The core is linked into each chip driver.
This lets you get drivers from different places (ATI) that might use a
core that doesn't match the one in your kernel. If you load two DRM
drivers you will get two copies of the core.

With modules this doesn't make a difference. But instead, if you link
these drivers into the kernel you get a bunch of symbol conflicts from
the duplicated cores. This is where the DRM() macro come into play.
The DRM() macros give the radeon driver core distinct symbol names
from the other drivers. This lets you link in drivers for all of the
chips if you want to without causing symbol conflicts.

I'm building a test version of DRM that uses a core model like fbdev
does. Doing this allows me to remove the DRM() macros.

However this has a side effect. DRM drivers are distributed outside of
the kernel. This leads to the possibility of wanting two drivers
simultaneously loaded that need different versions of the core.
Without the DRM macros we can only have one version of the core
loaded. What are you going to do?

One response is to build a stable API for the core. This may come over
time but right now this interface is very volatile. It's also obvious
that vendors shouldn't build DRM core into the kernel in case an
outside driver needs to replace it.

So it looks like the downside to getting rid of the macros is that
people who are running multiple video cards can't mix drivers with
drivers from outside the tree. This used to work but creating DRM core
will break it. The solution to this seems to be for vendors with
drivers outside of the tree to add the DRM macros to their derivative
code base in order to stop the symbol conflicts.

The new DRM core version for Linux 2.6 that I'm building also
incorporates GPL code. It's unclear how that is going to impact
outside drivers.

-- 
Jon Smirl
jonsmirl@gmail.com
