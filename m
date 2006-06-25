Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWFYEcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFYEcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 00:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFYEcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 00:32:23 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:39791 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751387AbWFYEcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 00:32:22 -0400
From: David Brownell <david-b@pacbell.net>
To: jg@laptop.org
Subject: Re: [linux-pm] [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Sat, 24 Jun 2006 21:32:18 -0700
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20060622202952.GA14135@kroah.com> <200606222034.44085.david-b@pacbell.net> <1151203377.15365.389.camel@localhost.localdomain>
In-Reply-To: <1151203377.15365.389.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606242132.19907.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 7:42 pm, Jim Gettys wrote:
> On Thu, 2006-06-22 at 20:34 -0700, David Brownell wrote:
> 
> > Under what scenario could it possibly be legitimate to suspend a
> > usb device -- or interface, or anything else -- with its children
> > remaining active?  The ability to guarantee that could _never_ happen
> > was one of the fundamental motivations for the driver model ...
> 
> I'm not sure this directly applies, but....

It's not a counterexample, but it may be an interesting example of
the sort of loosely coupled multiprocessor that gets more common.
The different processors use different power management schemes.
(I think an ACPI "embedded processor" has related issues.)


> The Marvell wireless chip we're using this generation in the OLPC
> machine is interfaced via USB.  Not ideal, but there's no other game in
> town to let us keep the mesh network up while the main machine is STR.

So presumably it's both "self" powered (so far as the parent hub is
concerned!) and also has some kind of cpu and firmware.  I'll assume
this chipset is used with discrete products too, not only for wiring to
motherboards.  (Despite the board layout advantages of using serial
interfaces:  fewer high speed signal lines, etc.)


> We intend to leave the Marvell chip on (it can forward packets in the
> mesh network, and/or wake up the CPU if there are inbound packets for
> the machine that matter), and turn off the USB interface it is attached
> to.

The normal way to do such things -- from the perspective of the firmware
inside a USB peripheral doing that routing etc -- recognizes that the
USB suspend state affects only the upstream link, and uses remote wakeup
signaling in the normal fashion.  (An SPI or I2C/SMBUS based coprocessor
probably needs an IRQ signal line.)

That is, from the perspective of the host CPU, it's suspended normally.
Just like any other USB device (like I sketched above).

But the peripheral's CPU can continue doing whatever it likes ... which
doesn't necessarily include stopping.  Bus powered USB peripherals would
probably try to suspend their CPUs though, since otherwise it may be hard
to meet the 500 microAmpere power budget.

- Dave
