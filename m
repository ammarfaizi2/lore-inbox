Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVAVTEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVAVTEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 14:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVAVTEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 14:04:52 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:37990 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262637AbVAVTEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 14:04:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oiN5VzSutmYCRz5WM94y7gDvvN0emPPqamDzWcM7fnanltMcw4pxMdS2EpW2NGIarQ1wUOoRnHooyW8KI6BHfWaxDOFeg8bFZjOYACjXTLyub05eMMgJM2Z63A6Gr5xTi4DnUsEVEundz3xlsJjO6TV1wlwEOEEdbjYC3bAJkxU=
Message-ID: <9e473391050122110463d62b5d@mail.gmail.com>
Date: Sat, 22 Jan 2005 14:04:36 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: Patch to control VGA bus routing and active VGA device.
Cc: "H.Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200501181306.03635.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <200501180946.47026.jbarnes@engr.sgi.com>
	 <csjok4$gn3$1@terminus.zytor.com>
	 <200501181306.03635.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 13:06:03 -0800, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> On Tuesday, January 18, 2005 11:38 am, H. Peter Anvin wrote:
> > > On Monday, January 17, 2005 7:43 pm, Jon Smirl wrote:
> > > > Attached is a patch to control VGA bus routing and the active VGA
> > > > device. It works by adding sysfs attributes to bridge and VGA devices.
> > > > The bridge attribute is read only and indicates if the bridge is
> > > > routing VGA. The attribute on the device has four values:
> > >
> > > How is it supposed to work?  Is VGA routing determined by the chipset?
> > > Is it separate from other legacy I/O and memory addresses?
> >
> > Yes, there are special control bits in any PCI bridge header for the
> > VGA ports.
> 
> Well, not all of them, which is why I asked.  Though obviously this patch will
> need some very platform specific bits at any rate.

What is a case of where the VGA forwarding bit isn't in the bridge
control? It's part of the PCI spec to have it.

There are two components to this, bus routing and card control. When
each VGA device is on it's own bus the card specific control code
isn't required. Instead you can control the active VGA by shutting
down the bus routing. It's only when you have multiple cards on the
same bus that you need the card specific control.

But the point of this code is to allow reset of secondary cards. After
resetting a secondary card it will be left as the active VGA device
instead of the boot one. This moves your console from screen to
screen. Instead I want to remember the active device, run reset, and
then restore the original console.

In my machine I have one PCI and one AGP card. Bus routing is
sufficient to choose between the two. Opteron systems with AGP cards
on local buses can also use this code.  Another example is where the
primary VGA device is on AGP and there are multiple PCI cards. You
just want all of the PCI VGA devices turned off.

We ultimately need both pieces of code, VGA bus routing, and card
specific VGA enabling code. Even without the card specific code the
routing code is still useful.

-- 
Jon Smirl
jonsmirl@gmail.com
