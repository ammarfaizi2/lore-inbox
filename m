Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbVLGVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbVLGVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVLGVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:15:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38154 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751777AbVLGVP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:15:57 -0500
Date: Wed, 7 Dec 2005 21:15:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051207211551.GL6793@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <20051207155034.GB6793@flint.arm.linux.org.uk> <BAY103-F32F90C9849D407E9336826DF430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F32F90C9849D407E9336826DF430@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 01:59:43PM -0600, Jason Dravet wrote:
> >From: Russell King <rmk+lkml@arm.linux.org.uk>
> >To: Jason Dravet <dravet@hotmail.com>
> >CC: linux-kernel@vger.kernel.org
> >Subject: Re: wrong number of serial port detected
> >Date: Wed, 7 Dec 2005 15:50:34 +0000
> >
> >On Wed, Dec 07, 2005 at 09:44:29AM -0600, Jason Dravet wrote:
> >> So I ask this mailing list Can the kernel detect the proper number of
> >> serial ports or not?
> >
> >It does detect serial ports found in the machine.
> >
> >However, it _always_ offers the configured number of serial devices.
> >This is to allow folk whose ports are not autodetected to configure
> >them appropriately via the setserial command.  If they were not
> >available, they could not configure them.
> >
> Then may I ask how XP does it?  I have to dual boot between XP and Fedora.  
> When I go into XP's device manager I see all of the appropriate hardware 
> listed, no extra serial ports.  When I boot into Fedora and go into /dev, I 
> see the same hardware except I have 32 serial ports and 64 tty nodes (tty 
> is for virtual terminals right?).  How can 1 OS show the correct number and 
> another show the wrong number?  I ask so I can better understand what is 
> going on.

It seems you are comparing apples (XP's device manager) with oranges
(/dev directory).  They're two entirely different things.

The former lists devices which _are_ present in your system.

The latter provides the filesystem namespace for applications to access
devices which may or may not be present in your system.

I think you completely missed the second half of my point, and I'd like
to illustrate what would happen if we were to only provide serial devices
in /dev which actually existed:

1. We would only provide /dev/ttyS devices which actually existed,
   which may mean just /dev/ttyS0.

2. User adds a custom serial card in their system which adds 16
   additional serial ports, but is not PCI based, so is not known
   to BIOS.

3. Neither XP nor Linux will find this automatically without some
   help (eg, a vendor supplied driver for XP).

4. User tries the well documented "setserial /dev/ttyS2 port 0x220 irq 5"
   procedure, which has been supported since Linux 1.x

5. User finds that, because there is no ttyS2 device in /dev, they
   can't configure their card.

6. User files a bug.

As for your 64 VT tty device nodes - these "devices" are created
dynamically when the device node is opened.  The act of opening the
device node is defined to be the creation event.  If the device node
did not exist, there would be no way to create _any_ virtual terminals.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
