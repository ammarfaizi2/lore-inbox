Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTFPRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTFPRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:06:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39952 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264030AbTFPRGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:06:15 -0400
Date: Mon, 16 Jun 2003 18:20:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030616182003.D13312@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org> <20030616170825.GB24986@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030616170825.GB24986@kroah.com>; from greg@kroah.com on Mon, Jun 16, 2003 at 10:08:26AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 10:08:26AM -0700, Greg KH wrote:
> Then don't let your module unload until _all_ instances of your
> structures are gone.  You can tell if this is true or not, it's just up
> to the implementor :)

Greg, I believe Alan does have a valid concern.  Eg, how is the following
handled?

- PCI device driver module is loaded
- device driver gets handed a pci device
- device driver attaches a file to the struct device corresponding to the
  PCI device.
- userspace opens new file (this does not increment the device drivers
  use count.)
- device driver is rmmod'd
- device driver removes its references to the pci device
- device driver unloads
- user reads from opened file.

> Look at the new pcmcia code for just such an example.

In the pcmcia case, we effectively own the object (class device) we're
attaching the files to, so we can ensure that the module is not unloaded
until the class device files are closed and all references to the object
are gone.

IMO, if you don't own the object (and therefore don't know its lifetime),
you shouldn't be adding sysfs or device model attributes of any kind to
that object.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

