Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWEEUOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWEEUOD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWEEUOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:14:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:9819 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751529AbWEEUOB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:14:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oDRfgt3yDVzC4IkFxcY/bmyEg56+Mn+2isPEnCWQqaXbjJkzWY36X52TpxuBFM2XkM22+IRjeGLYRZtFbBIAq2FM8eTEyXUilGlMuTnn34tMoy5Y0QxSQ+JytAfbPtXQmb5RjRL68gBKpLQsf9d7wkptocjnHU/JIg9DuFShQGk=
Message-ID: <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
Date: Fri, 5 May 2006 16:14:00 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Ian Romanick" <idr@us.ibm.com>, "Greg KH" <greg@kroah.com>,
       "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445BA584.40309@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
	 <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Ian Romanick <idr@us.ibm.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Peter Jones wrote:
> > On Thu, 2006-05-04 at 17:38 -0400, Jon Smirl wrote:
> >
> >># cd /sys/bus/pci/devices/0000:01:00.0
> >># echo 1 >rom
> >># hexdump -C rom
> >>
> >>As far as I know this works on every platform, not just the PC one.
> >
> > Yep, you're right, this works.  So we don't necessarily need it for the
> > vbetool case.  X still could use it though, instead of their scary
> > poke-at-memory way.
>
> Dave Airlie recently changed X to use sysfs for reading ROMs.  I'm also
> working on some changes to eliminate nearly all of the PCI bus poking
> that X does.  Search for "PCI rework" or "libpciaccess" in the xorg list
> archives.

What's the story with PCI VGA routing?

DaveA I were chatting about an alternative to 'enable' attribute. You
would make a VGA driver that isn't bound to any PCI IDs. After the
kernel boots a user space program uses sysfs/vga/new_id to load it
with PCI IDs for all PCI class = VGA hardware. Anything that doesn't
have a driver loaded will then get bound to this VGA driver. In
conjunction with the driver udev would make a device node appear.
Opening the new device node would enable the device and control
ownership. If you want to load a device specific driver later, set
sysfs/vga/unbind=1, load the new device specific driver, set
sysfs/vga/bind=1.

This scheme all works within existing kernel mechanisms and does not
require adding an 'enable' attribute. It also addresses the problem of
who owns the state in the hardware; the state is owned by whoever has
the device node open. If another app wants to mess with the hardware
it won't be able to open the device node.

I would like to see other design alternatives considered on this
issue. The 'enable' attribute has a clear problem in that you can't
tell which user space program is trying to control the device.
Multiple programs accessing the video hardware with poor coordination
is already the source of many problems.

--
Jon Smirl
jonsmirl@gmail.com
