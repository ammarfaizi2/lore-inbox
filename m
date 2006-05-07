Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWEGIrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWEGIrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWEGIrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:47:35 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:59864 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932106AbWEGIrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:47:35 -0400
Date: Sun, 7 May 2006 04:54:34 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060507085433.GA28394@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	Jon Smirl <jonsmirl@gmail.com>, Ian Romanick <idr@us.ibm.com>,
	Dave Airlie <airlied@linux.ie>,
	Arjan van de Ven <arjan@linux.intel.com>,
	linux-kernel@vger.kernel.org
References: <E1FbjiL-0001B9-00@chiark.greenend.org.uk> <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com> <1146776736.27727.11.camel@localhost.localdomain> <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain> <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505202603.GB6413@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 01:26:03PM -0700, Greg KH wrote:
> On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> > I would like to see other design alternatives considered on this
> > issue. The 'enable' attribute has a clear problem in that you can't
> > tell which user space program is trying to control the device.
> > Multiple programs accessing the video hardware with poor coordination
> > is already the source of many problems.
> 
> Who cares who "enabled" the device.  Remember, the majority of PCI
> devices in the system are not video ones.  Lots of other types of
> devices want this ability to enable PCI devices from userspace.  I've
> been talking with some people about how to properly write PCI drivers in
> userspace, and this attribute is a needed part of it.
> 
> And if X gets enabling the device wrong, again, who cares, it's not a
> kernel issue. :)
> 
> thanks,
> 
> greg k-h
> -

The main issue I see with the "enable" sysfs attribute is that it doesn't
mediate who has ownership of the device's state and context, as Jon has
mentioned.  As a result, userspace might, not knowing any better, disable
the device while its kernel driver is trying to access it, or a number of
other fatal senarios.

However, I understand that video is not the only issue at hand, and there is
some interest in userspace PCI drivers.  At the very least, we should prevent
any writing to the "enable" attribute if a kernelspace driver is bound to
the device.  This patch completely ignores such issues.

We might want to take this a step further and create a generic PCI userspace
kernel driver that exports knobs such as "enable" in sysfs and also handles
some baseline suspend/resume behavior and whatever else is needed for
userspace drivers.  This will ensure that the kernel is aware that the
hardware is owned by a userspace driver, and it will make it clear to a user
app that it is allowed to control the device.

Thanks,
Adam
