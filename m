Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWITWAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWITWAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWITWAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:00:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:48547 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWITWAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:00:39 -0400
Date: Wed, 20 Sep 2006 15:00:40 -0700
From: Greg KH <greg@kroah.com>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Development List <linux-kernel@vger.kernel.org>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: USB: ftdi-elan: client driver for ELAN Uxxx adapters - 3rd attempt
Message-ID: <20060920220040.GB15138@kroah.com>
References: <1158143165.4328.11.camel@n04-207.elan.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158143165.4328.11.camel@n04-207.elan.private>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:26:04AM +0100, Tony Olech wrote:
> This "ftdi-elan" module is one half of the "driver" for
> ELAN's Uxxx series adapters which are USB to PCMCIA CardBus
> adapters. Currently only the U132 adapter is available and
> it's module is called "u132-hcd".
> 
> When the USB hot plug subsystem detects a Uxxx series adapter
> it should load this module.
> 
> Upon a successful device probe() the jtag device file interface
> is created and the status workqueue started up.
> 
> The jtag device file interface exists for the purpose of
> updating the firmware in the Uxxx series adapter, but as
> yet it had never been used.
> 
> The status workqueue initializes the Uxxx and then sits there
> polling the Uxxx until a supported PCMCIA CardBus device is
> detected it will start the command and respond workqueues
> and then load the module that handles the device. This will
> initially be only the u132-hcd module. The status workqueue
> then just polls the Uxxx looking for card ejects.
> 
> The command and respond workqueues implement a command
> sequencer for communicating with the firmware on the other
> side of the FTDI chip in the Uxxx. This "ftdi-elan" module
> exports some functions to interface with the sequencer.
> 
> Note that this module is a USB client driver.
> 
> Note that the "u132-hcd" module is a (cut-down OHCI)
> host controller.
> 
> Thus we have a topology with the parent of a host controller
> being a USB client! This really stresses the USB subsystem
> semaphore/mutex handling in the module removal.
> 
> Signed-off-by: Tony Olech <tony.olech@elandigitalsystems.com>

I've applied this and fixed the build issue (again with the
drivers/usb/Makefile file) and the Kconfig entries don't need to be
duplicated so many times :)

Also, I've fixed up the sparse warnings, but you are doing something
very wierd with the user buffer still, and I get these warnings:

drivers/usb/misc/ftdi-elan.c:1231:65: warning: dereference of noderef expression
drivers/usb/misc/ftdi-elan.c:1237:65: warning: dereference of noderef expression

with sparse still.  I think it's a bunch of debug code that is remaining
in that function, care to send me a follow-on patch that removes it?

thanks,

greg k-h
