Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbSLGNMf>; Sat, 7 Dec 2002 08:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbSLGNMf>; Sat, 7 Dec 2002 08:12:35 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:36369 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267653AbSLGNMe>; Sat, 7 Dec 2002 08:12:34 -0500
Date: Sat, 7 Dec 2002 14:20:00 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207132000.GM32065@louise.pinerecords.com>
References: <997222131F7@vcnet.vc.cvut.cz> <20021207074457.GE21070@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207074457.GE21070@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is invaluable during installation, when no lspci is installed yet.
> > I know that I need e100/eepro100 for 
> > 'Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM E', but I do not
> > have even slightest idea what device 8086:2449 is, whether USB or NIC or
> > VGA or some bridge.
> 
> at least, the file "modules.pcimap" tells you which modules support these
> devices, by vendor/model codes. I once developped a little installation script
> which loaded all the NICs it could by listing /proc/bus/pci/devices and
> modules.pcimap. I too agree that names in /proc/pci are *really* useful, but I
> often omit them when I need a very little image. Perhaps having a list of names
> only for devices supported by the kernel and modules at compile time would be
> an acceptable compromise?

I've been using the following script in my install images to find kernel
modules for various PCI devices (the mechanism's not perfect, though,
I know of at least one module that "doesn't put" its ids in modules.pcimap):

#!/bin/sh
PATH=/bin:/usr/bin:/sbin:/usr/sbin

PCIMAP=/lib/modules/$(uname -r)/modules.pcimap
ALLDEV=$(lspci -n| sed -e 's/^.*:[[:blank:]]\+\([^[:blank:]]\+\).*$/\1/')

if [ -n "$ALLDEV" -a -r $PCIMAP ]; then
  for i in $ALLDEV; do
    VENDOR="$(echo $i| cut -d':' -f1)"
    DEVICE="$(echo $i| cut -d':' -f2)"
    MODULE=$(grep "0x0000$VENDOR[[:blank:]]\+0x0000$DEVICE" $PCIMAP| \
      awk '{ print $1; }')
    echo -n "Vendor $VENDOR, dev $DEVICE: "
    if [ -n "$MODULE" ]; then
      echo $MODULE
    else
      echo "(no matching module)"
    fi
  done
fi

-- 
Tomas Szepe <szepe@pinerecords.com>
