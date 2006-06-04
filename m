Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932133AbWFDK2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWFDK2F (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFDK2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:28:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932133AbWFDK2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:28:04 -0400
Date: Sun, 4 Jun 2006 03:27:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Lortie <desrt@desrt.ca>
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, bcollins@ubuntu.com,
        Greg KH <greg@kroah.com>
Subject: Re: pci_restore_state
Message-Id: <20060604032746.a5b3e2dd.akpm@osdl.org>
In-Reply-To: <1149416010.30767.14.camel@moonpix.desrt.ca>
References: <1149416010.30767.14.camel@moonpix.desrt.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jun 2006 06:13:30 -0400
Ryan Lortie <desrt@desrt.ca> wrote:

> Currently pci_restore_state() (drivers/pci/pci.c) restores the PCI state
> by copying in the saved PCI configuration space, a dword at a time,
> starting from 0 up to 15.
> 
> This causes a crash when my Macbook resumes from sleep (specifically,
> when restoring the configuration space of the PCI bridge).
> 
> Reading the PCI specification, the register at dword 1 (ie: bytes 4-7)
> is split half and half between status and command words.  The command
> word effectively controls the way which the PCI device interacts with
> the system.  If it is 0, the device is logically disconnected from the
> bus (PCI Local Bus Specification Revision 2.2, 6.2.2 "Device
> Control").  
> 
> When a device first powers up, the command register value is normally
> zero (and is zero in my specific case).
> 
> The problem with the way that the PCI state is currently restored is
> that the write to the command register logically reconnects the device
> to the bus before the rest of the configuration space has been filled
> in.
> 
> My Macbook crashes on resume.
> 
> If I reverse the for loop to start from 15 and count down to 0, then the
> majority of the configuration space is filled in _before_ the command
> word is modified.  No crash.

We have a patch pending which will do that.

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci/pci-reverse-pci-config-space-restore-order.patch

The present plan will be to get this into 2.6.18.
