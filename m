Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKYUbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTKYUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:31:33 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:12490 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263024AbTKYUb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:31:26 -0500
Message-ID: <3FC3BB5A.9080000@pacbell.net>
Date: Tue, 25 Nov 2003 12:28:10 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.4 patch] fix USB Gadget Config.in
References: <20031118172807.GN326@fs.tum.de>
In-Reply-To: <20031118172807.GN326@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------080706020709000000000202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706020709000000000202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:

> .config contained the following:
> 
> ... (illegal but not disallowed) ...

> The main change is to remove the problematic
> 
>   define_tristate CONFIG_USB_GADGET_CONTROLLER n

That came from Al Borchers when he provided the "serial" gadget
driver. It helped clean up the preceding Config.in.  I don't know
precisely how he landed with that solution, likely something to
do with "undefined" dependencies interpreted (wrongly) as "true".

In what way was that problematic for you?

Agreed that some of the controller drivers might fit better as
"dep_tristate": net2280 and goku_udc depending on PCI; pxa2xx and
superh UDCs depending on those arch symbols.

On the other hand, see the updated Config.in below (more drivers
than 2.4.23-rc5):  it works with "menuconfig" and "config", on
x86 and ARM, and correctly prevents configuring both PCI-based
controllers; but I'd not say "better" because it breaks rudely
on "xconfig" (all those settings disabled).


> and solving it different, and allowing a statically CONFIG_USB_ETH only 
> when CONFIG_USB_ZERO isn't statically.

Seems incorrect; if ZERO is statically linked, ETH must not be linked
either statically or dynamically.  (And so on for the other drivers.)

There may be a nice solution to these problems within the Config.in
constraints, but I don't think we've found one yet.

- Dave



> cu
> Adrian
> 
> 

--------------080706020709000000000202
Content-Type: text/plain;
 name="Config.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Config.in"

#
# USB device-side configuration
# for 2.4 kbuild, drivers/usb/gadget/Config.in
#
# Long term, this likely doesn't all belong in one directory
# Plan to split it up eventually.
#
# CAREFUL!  Some versions of "xconfig" don't execute this correctly.
#
mainmenu_option next_comment
comment 'Support for USB gadgets'

bool 'Support for USB Gadgets' CONFIG_USB_GADGET
if [ "$CONFIG_USB_GADGET" = "y" ]; then
  
  #
  # really want _exactly one_ device controller driver at a time,
  # since they control compile options for gadget drivers.
  #
  comment 'USB Peripheral Controller Drivers'
  
  # assume all the dependencies may be undefined ("== true", yeech)
  define_tristate CONFIG_USB_GADGET_CONTROLLER n
  if [ "$CONFIG_PCI" = "" ] ; then
     define_bool CONFIG_PCI n
  fi
  if [ "$CONFIG_ARCH_PXA" = "" ] ; then
     define_bool CONFIG_ARCH_PXA n
  fi
  if [ "$CONFIG_ARCH_SUPERH" = "" ] ; then
     define_bool CONFIG_ARCH_SUPERH n
  fi
  
  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "n" ] ; then
    dep_tristate '  NetChip 2280 support' CONFIG_USB_NET2280 $CONFIG_PCI
    define_tristate CONFIG_USB_GADGET_CONTROLLER $CONFIG_USB_NET2280
  fi
  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "n" ] ; then
    dep_tristate '  PXA 2xx UDC support' CONFIG_USB_PXA2XX $CONFIG_ARCH_PXA
    define_tristate CONFIG_USB_GADGET_CONTROLLER $CONFIG_USB_PXA2XX
  fi
  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "n" ] ; then
    dep_tristate '  Toshiba TC86C001 (Goku-S) support' CONFIG_USB_GOKU $CONFIG_PCI
    define_tristate CONFIG_USB_GADGET_CONTROLLER $CONFIG_USB_GOKU
  fi
  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "n" ] ; then
    dep_tristate '  Renesas SH7705/7727 UDC support' CONFIG_USB_SUPERH $CONFIG_SUPERH
    define_tristate CONFIG_USB_GADGET_CONTROLLER $CONFIG_USB_SUPERH
  fi

  if [ "$CONFIG_USB_GADGET_CONTROLLER" = "y" -o "$CONFIG_USB_GADGET_CONTROLLER" = "m" ] ; then

  #
  # no reason not to enable more than one gadget driver module, but
  # for static linking that would make no sense since the usb model
  # has exactly one of these upstream connections and only one
  # lowest-level driver can control it.
  #
  # gadget drivers are compiled to work on specific hardware, since
  #
  # (a) gadget driver need hardware-specific configuration, like what
  #     endpoint names and numbers to use, maxpacket sizes, etc
  #
  # (b) specific hardware features like iso endpoints may be required
  #
  comment 'USB Gadget Drivers'

  dep_tristate '  Gadget Zero (DEVELOPMENT)' CONFIG_USB_ZERO $CONFIG_USB_GADGET_CONTROLLER
  if [ "$CONFIG_USB_ZERO" = "y" -o "$CONFIG_USB_ZERO" = "m" ]; then
      if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
  	define_bool CONFIG_USB_ZERO_NET2280 y
      else if [ "$CONFIG_USB_PXA2XX" = "y" -o "$CONFIG_USB_PXA2XX" = "m" ]; then
  	define_bool CONFIG_USB_ZERO_PXA2XX y
      else if [ "$CONFIG_USB_GOKU" = "y" -o "$CONFIG_USB_GOKU" = "m" ]; then
  	define_bool CONFIG_USB_ZERO_GOKU y
      else if [ "$CONFIG_USB_SUPERH" = "y" -o "$CONFIG_USB_SUPERH" = "m" ]; then
  	define_bool CONFIG_USB_ZERO_SUPERH y
      fi fi fi fi
      # ...
  fi
  
  dep_tristate '  Ethernet Gadget (EXPERIMENTAL)' CONFIG_USB_ETH $CONFIG_USB_GADGET_CONTROLLER $CONFIG_NET
  if [ "$CONFIG_USB_ETH" = "y" -o "$CONFIG_USB_ETH" = "m" ]; then
      if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
  	define_bool CONFIG_USB_ETH_NET2280 y
      else if [ "$CONFIG_USB_PXA2XX" = "y" -o "$CONFIG_USB_PXA2XX" = "m" ]; then
  	define_bool CONFIG_USB_ETH_PXA2XX y
      else if [ "$CONFIG_USB_GOKU" = "y" -o "$CONFIG_USB_GOKU" = "m" ]; then
  	define_bool CONFIG_USB_ETH_GOKU y
      else if [ "$CONFIG_USB_SUPERH" = "y" -o "$CONFIG_USB_SUPERH" = "m" ]; then
  	define_bool CONFIG_USB_ETH_SUPERH y
      fi fi fi fi
      # ...
  fi
  
  dep_tristate '  Gadget Filesystem API (EXPERIMENTAL)' CONFIG_USB_GADGETFS $CONFIG_USB_GADGET_CONTROLLER
  if [ "$CONFIG_USB_GADGETFS" = "y" -o "$CONFIG_USB_GADGETFS" = "m" ]; then
      if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
  	define_bool CONFIG_USB_GADGETFS_NET2280 y
      else if [ "$CONFIG_USB_PXA2XX" = "y" -o "$CONFIG_USB_PXA2XX" = "m" ]; then
  	define_bool CONFIG_USB_GADGETFS_PXA2XX y
      else if [ "$CONFIG_USB_GOKU" = "y" -o "$CONFIG_USB_GOKU" = "m" ]; then
  	define_bool CONFIG_USB_GADGETFS_GOKU y
      else if [ "$CONFIG_USB_SUPERH" = "y" -o "$CONFIG_USB_SUPERH" = "m" ]; then
  	define_bool CONFIG_USB_GADGETFS_SUPERH y
      fi fi fi fi
      # ...
  fi
  
  dep_tristate '  File-backed Storage Gadget (DEVELOPMENT)' CONFIG_USB_FILE_STORAGE $CONFIG_USB_GADGET_CONTROLLER
  if [ "$CONFIG_USB_FILE_STORAGE" = "y" -o "$CONFIG_USB_FILE_STORAGE" = "m" ]; then
      if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
  	define_bool CONFIG_USB_FILE_STORAGE_NET2280 y
      else if [ "$CONFIG_USB_PXA2XX" = "y" -o "$CONFIG_USB_PXA2XX" = "m" ]; then
  	define_bool CONFIG_USB_FILE_STORAGE_PXA2XX y
      else if [ "$CONFIG_USB_GOKU" = "y" -o "$CONFIG_USB_GOKU" = "m" ]; then
  	define_bool CONFIG_USB_FILE_STORAGE_GOKU y
      else if [ "$CONFIG_USB_SUPERH" = "y" -o "$CONFIG_USB_SUPERH" = "m" ]; then
  	define_bool CONFIG_USB_FILE_STORAGE_SUPERH y
      fi fi fi fi
      # ...
  fi
  
  dep_tristate '  Serial Gadget (EXPERIMENTAL)' CONFIG_USB_G_SERIAL $CONFIG_USB_GADGET_CONTROLLER
  if [ "$CONFIG_USB_G_SERIAL" = "y" -o "$CONFIG_USB_G_SERIAL" = "m" ]; then
      if [ "$CONFIG_USB_NET2280" = "y" -o "$CONFIG_USB_NET2280" = "m" ]; then
  	define_bool CONFIG_USB_G_SERIAL_NET2280 y
      else if [ "$CONFIG_USB_PXA2XX" = "y" -o "$CONFIG_USB_PXA2XX" = "m" ]; then
  	define_bool CONFIG_USB_G_SERIAL_PXA2XX y
      else if [ "$CONFIG_USB_GOKU" = "y" -o "$CONFIG_USB_GOKU" = "m" ]; then
  	define_bool CONFIG_USB_G_SERIAL_GOKU y
      else if [ "$CONFIG_USB_SUPERH" = "y" -o "$CONFIG_USB_SUPERH" = "m" ]; then
  	define_bool CONFIG_USB_G_SERIAL_SUPERH y
      fi fi fi fi
      # ...
  fi
  
  # ... or other gadget drivers:  printer class, hid, etc ...

  fi
fi
endmenu

--------------080706020709000000000202--

