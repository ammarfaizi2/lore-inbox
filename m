Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTELXnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTELXnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:43:07 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:19407 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262930AbTELXnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:43:05 -0400
Message-ID: <3EC03705.8040100@pacbell.net>
Date: Mon, 12 May 2003 17:06:29 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk7: multiple definition of `usb_gadget_get_string'
References: <20030512205848.GU1107@fs.tum.de> <20030512211159.GA29716@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020605000600000306000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605000600000306000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Mon, May 12, 2003 at 10:58:48PM +0200, Adrian Bunk wrote:
>>`usb_gadget_get_string':
>>: multiple definition of `usb_gadget_get_string'
>>drivers/usb/gadget/g_zero.o(.text+0x0): first defined here
>>make[2]: *** [drivers/usb/gadget/built-in.o] Error 1
> 
> 
> I don't think that g_zero and g_ether are allowed to be built into the
> kernel at the same time.  David, want to send a patch to fix the Kconfig
> file to prevent this?

Yes, just one: there's only one upstream USB connector,
it can only have one driver.  Patch attached.

Seems like the xconfig/menuconfig coredumps I previously
saw with tristate choice/endchoice are now gone ... or at
least they don't show up with this many choices!

- Dave



--------------020605000600000306000506
Content-Type: text/plain;
 name="kconf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kconf.patch"

--- 1.2/drivers/usb/gadget/Kconfig	Tue May  6 05:34:53 2003
+++ edited/drivers/usb/gadget/Kconfig	Mon May 12 16:56:45 2003
@@ -35,9 +35,8 @@
 #
 # USB Peripheral Controller Support
 #
-# FIXME convert to tristate choice when "choice" behaves as specified
-#
-comment "USB Peripheral Controller Support"
+choice
+	prompt "USB Peripheral Controller Support"
 	depends on USB_GADGET
 
 config USB_NET2280
@@ -55,19 +54,17 @@
 	   dynamically linked module called "net2280" and force all
 	   gadget drivers to also be dynamically linked.
 
+endchoice
+
 #
 # USB Gadget Drivers
 #
-# FIXME only one of these may be statically linked; choice/endchoice.
-#
-comment "USB Gadget Drivers"
+choice
+	prompt "USB Gadget Drivers"
 	depends on USB_GADGET
+	default USB_ETH
 
-# FIXME want better dependency/config approach for drivers.  with only
-# two knobs to tweak (driver y/m/n, and a hardware symbol) there's no
-# good excuse for Kconfig to cause such trouble here.  there are clear
-# bugs (coredumps, multiple choices enabled, and more) in its (boolean)
-# "choice" logic too ...
+# FIXME want a cleaner dependency/config approach for drivers.
 
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
@@ -149,5 +146,7 @@
 	bool
 	depends on USB_ETH && USB_SA1100
 	default y
+
+endchoice
 
 # endmenuconfig

--------------020605000600000306000506--

