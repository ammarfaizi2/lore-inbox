Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVDEV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVDEV3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDEV1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:27:21 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:28098 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262040AbVDEVMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:12:41 -0400
Date: Tue, 5 Apr 2005 17:12:27 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] Hotplug firmware loader for Keyspan usb-serial driver
Message-ID: <20050405211226.GA23470@delft.aura.cs.cmu.edu>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
References: <20050405193859.506836000@delft.aura.cs.cmu.edu> <1112733931.3267.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112733931.3267.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:45:30PM +0200, Kay Sievers wrote:
> On Tue, 2005-04-05 at 15:38 -0400, Jan Harkes wrote:
> > Here is another stab at making the keyspan firmware easily loadable with
> > hotplug. Differences from the previous version,
> > 
> > - keep the IHEX parser into a separate module.
> > - added a fw-y and fw-m install targets to kbuild which will install a
> >   driver's firmware files in /lib/modules/`uname -r`/firmware.
> > 
> > 01 - Add lib/ihex_parser.ko.
> 
> Oh, I just see now that it's a EZ-USB device. Did you try adapting the
> driver to use fxload(8)? to load the firmware. I have a USB-Modem that
> works perfect with loading ez-firmware that way.

Never heard of fxload before. I just tried it by moving the firmware
directory out of the way so that hotplug wouldn't try to initialize the
device behind my back.

    # fxload -v -t fx -D /proc/bus/usb/002/011 -I keyspan-usa19qi.fw 
    microcontroller type: fx
    single stage:  load on-chip memory
    open RAM hexfile image keyspan-usa19qi.fw
    stop CPU
    write on-chip, addr 0x0033 len    3 (0x0003)
    write on-chip, addr 0x001a len    4 (0x0004)
    write on-chip, addr 0x0003 len   23 (0x0017)
    write on-chip, addr 0x0023 len    3 (0x0003)
    write on-chip, addr 0x0046 len  192 (0x00c0)
    write on-chip, addr 0x0043 len    3 (0x0003)
    write on-chip, addr 0x0000 len    3 (0x0003)
    write on-chip, addr 0x0026 len   12 (0x000c)
    write on-chip, addr 0x0106 len  960 (0x03c0)
    write on-chip, addr 0x04c6 len  960 (0x03c0)
    write on-chip, addr 0x0886 len  960 (0x03c0)
    write on-chip, addr 0x0c46 len  905 (0x0389)
    ... WROTE: 4028 bytes, 12 segments, avg 335
    reset CPU

    # dmesg | tail
    keyspan 2-1:1.0: device disconnected
    usb 2-1: new full speed USB device using uhci_hcd and address 11
    keyspan 2-1:1.0: Keyspan - (without firmware) converter detected
    usb 2-1: Required firmware image (keyspan-usa19qi.fw) unavailable.
>>> fxload was used at this point
    usb 2-1: USB disconnect, address 11
    keyspan 2-1:1.0: device disconnected
    usb 2-1: new full speed USB device using uhci_hcd and address 12
    usb 2-1: configuration #1 chosen from 2 choices
    keyspan 2-1:1.0: Keyspan 1 port adapter converter detected
    usb 2-1: Keyspan 1 port adapter converter now attached to ttyUSB0

Looks like it works, so I guess the pre-numeration stuff in the driver
is really not necessary. We just need a bunch of hotplug rules to load
the correct firmware whenever an uninitialized device is plugged in and
some way to distribute the firmware images.

Jan

