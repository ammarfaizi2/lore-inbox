Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263103AbTCWQOP>; Sun, 23 Mar 2003 11:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263104AbTCWQOP>; Sun, 23 Mar 2003 11:14:15 -0500
Received: from mail0.mx.voyager.net ([216.93.66.205]:65030 "EHLO
	mail0.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S263103AbTCWQOO>; Sun, 23 Mar 2003 11:14:14 -0500
Message-ID: <3E7DE01B.2B6985DF@megsinet.net>
Date: Sun, 23 Mar 2003 10:26:03 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mflt1@micrologica.com.hk
CC: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
Content-Type: multipart/mixed;
 boundary="------------87F3FD1308A259EA1E5EEA2E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------87F3FD1308A259EA1E5EEA2E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Hello.
> 
> Have some trouble with loading modules (see earlier message).
> Tried to compile a driver in.
> 
> dmesg:
> -------
> isapnp: Scanning for PnP cards...
> isapnp: Card Plug & Play Ethernet card
> isapnp: 1 Plug and Play card detected total
> ------
> 
> - no further references do isapnp in logs
> 
> - Same card works (with pnp disabled (jumper) and driver compiled
> as a module) by modprobing it with io=0x300
> 
> - Same card works with 2.4.21-pre5 driver as module both with pnp
> and modual probing
> 
>         Regards
>         Michael
> -

Michael,

NE2k ISAPNP broke around 2.5.64, again.  There are 2 parts to the attached
patch, one to move the NIC initialization earlier in the boot sequence
and the second is a HACK to get ne2k to work when compiled into the
kernel, I've never tried NE2k as a module...

1. The level of isapnp_init was moved to after apci.  Since it is now
   after net_dev_init, ISA PNP NICs fail to initialized at boot.

   This fix allows ISA PNP NIC cards to work during net_dev_init, and still
   leaves isapnp_init after apci_init.

2. The second piece kills off a now ?unnecessary? probe.

Works for me,
Martin
--------------87F3FD1308A259EA1E5EEA2E
Content-Type: text/plain; charset=us-ascii;
 name="65.2k.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="65.2k.diff"

--- ./drivers/net/ne.c	Tue Mar  4 22:44:58 2003
+++ ../linux-2.5.65/./drivers/net/ne.c	Tue Mar  4 22:41:36 2003
@@ -176,8 +176,10 @@
 		return -ENXIO;
 
 	/* Then look for any installed ISAPnP clones */
+/*  HACK to kill this probe, also done now by new isapnp code
 	if (isapnp_present() && (ne_probe_isapnp(dev) == 0))
 		return 0;
+*/
 
 #ifndef MODULE
 	/* Last resort. The semi-risky ISA auto-probe. */
--- ./drivers/pnp/isapnp/core.c	Tue Mar 18 05:43:40 2003
+++ ../linux-2.5.65/./drivers/pnp/isapnp/core.c	Tue Mar 18 05:43:14 2003
@@ -1173,7 +1173,7 @@
 	return 0;
 }
 
-device_initcall(isapnp_init);
+subsys_initcall(isapnp_init);
 
 /* format is: noisapnp */
 

--------------87F3FD1308A259EA1E5EEA2E--

