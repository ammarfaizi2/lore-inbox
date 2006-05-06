Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWEFAFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWEFAFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 20:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEFAFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 20:05:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:5719 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751241AbWEFAFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 20:05:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyJTB7ecIAs9h57T9znqme8lLCP5MmjqNEYVt5ewYTnRFj0/Tk4aaq1vTmaPEs+LsgP2HfD0OUT4pb0IdI9D4J8VeF/yixqUMZiCQRZTx5voFpU0mMz28WLvwLt+ocRbawgp7W2Dlyn/ND1fbYwnL7sMF7SrSt2DMysTGFoav1s=
Message-ID: <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
Date: Fri, 5 May 2006 20:05:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060505222738.GA8985@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com>
	 <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	 <20060505210614.GB7365@kroah.com>
	 <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	 <20060505222738.GA8985@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Greg KH <greg@kroah.com> wrote:
> On Fri, May 05, 2006 at 05:15:02PM -0400, Jon Smirl wrote:
> > On 5/5/06, Greg KH <greg@kroah.com> wrote:
> > >On Fri, May 05, 2006 at 04:35:17PM -0400, Jon Smirl wrote:
> > >> On 5/5/06, Greg KH <greg@kroah.com> wrote:
> > >> >On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> > >> >> I would like to see other design alternatives considered on this
> > >> >> issue. The 'enable' attribute has a clear problem in that you can't
> > >> >> tell which user space program is trying to control the device.
> > >> >> Multiple programs accessing the video hardware with poor coordination
> > >> >> is already the source of many problems.
> > >> >
> > >> >Who cares who "enabled" the device.  Remember, the majority of PCI
> > >> >devices in the system are not video ones.  Lots of other types of
> > >> >devices want this ability to enable PCI devices from userspace.  I've
> > >> >been talking with some people about how to properly write PCI drivers in
> > >> >userspace, and this attribute is a needed part of it.
> > >>
> > >> User space program enables the device.
> > >> Next I load a device driver
> > >> next I rmmod the device driver and it disables the device
> > >> user space program trys to use the device
> > >> No coordination and user space program faults
> > >
> > >Gun.  Foot.  Shoot.
> >
> > Why do we want to create problem like this when there is a simple
> > solution to preventing them. All it takes is a couple of rules:
> >
> > 1) To use a device it must have a device driver. It may be as simple
> > as a couple of lines of code. This driver will cause a device node to
> > be created.
> >
> > 2) If a user app want to use the device it opens the device node.
> >
> > This builds a system where everybody knows what is going on. The
> > driver knows that user space is using the device. Multiple user space
> > users are blocked from conflicting because of the open. There is no
> > way to shoot yourself in the foot.
>
> That sounds like a nice way to mediate userspace usages of PCI devices,
> yes.  Much like a dot lockfile is done for tty devices today, all in
> userspace (which hints that this too can be done in userspace with no
> kernel involvement...)
>
> But it still has nothing to do with this enable sysfs file :)

It has everything to do with the 'enable' file. The 'enable' file lets
you change the state of the hardware without an ownership mechanism. 
Other device users will not be notified of the state change. Since the
other users can't be sure of the state of the hardware when they are
activated, they will have to reload their state into the hardware on
every activation.

So as a result of this every interrupt service routine should now
include pci_enable(). If you don't include this and someone from user
space disables the hardware you're going to GPF. fbdev is already
forced to take defensive measures like this since X will randomly
disable it's hardware while it has an ISR active.

On the other hand, if you say you're only going to enable hardware and
not disable it, then we should simply get rid of the PCI
enable/disable functions and permanently enable everything at boot.

--
Jon Smirl
jonsmirl@gmail.com
