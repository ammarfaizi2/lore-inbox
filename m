Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUGYLOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUGYLOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 07:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUGYLOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 07:14:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51133 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263875AbUGYLOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 07:14:48 -0400
Date: Sun, 25 Jul 2004 13:14:46 +0200 (MEST)
Message-Id: <200407251114.i6PBEkfs007288@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-rc3 with gcc-3.4.0 compile error (even with the fix patch)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 20:03:10 +0000 (UTC), haiquy@yahoo.com wrote:
>The kernel has the gcc-3.4 fix patch
>
>make[3]: Entering directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
>gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=net2280  -DEXPORT_SYMTAB -c net2280.c
>net2280.c: In function `write_fifo':
>net2280.c:540: error: `typeof' applied to a bit-field
>net2280.c: In function `handle_ep_small':
>net2280.c:2194: error: `typeof' applied to a bit-field
>make[3]: *** [net2280.o] Error 1
>make[3]: Leaving directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
>make[2]: *** [first_rule] Error 2
>make[2]: Leaving directory `/home/linux-2.4.27-rc3/drivers/usb/gadget'
>make[1]: *** [_subdir_usb/gadget] Error 2
>make[1]: Leaving directory `/home/linux-2.4.27-rc3/drivers'
>make: *** [_dir_drivers] Error 2

Fetch and use the updated gcc-3.4 fix patch
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v3-2.4.27-rc3>
or apply the incremental patch below.

In the gcc-3.3 -> gcc-3.4 transition they changed gcc to
explicitly forbid using typeof on bitfields, see gcc
bugzilla #10333. This is not unreasonable, since typeof
and sizeof on bitfields can have strange semantics.

The fix for net2280.c (backported from the 2.6 kernel)
is to make the min calculation explicit in the code.

/Mikael

--- linux-2.4.27-rc3/drivers/usb/gadget/net2280.c.~1~	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.27-rc3/drivers/usb/gadget/net2280.c	2004-07-25 12:47:30.000000000 +0200
@@ -537,7 +537,10 @@
 	}
 
 	/* write just one packet at a time */
-	count = min (ep->ep.maxpacket, total);
+	count = ep->ep.maxpacket;
+	if (count > total)	/* min() cannot be used on a bitfield */
+		count = total;
+
 	VDEBUG (ep->dev, "write %s fifo (IN) %d bytes%s req %p\n",
 			ep->ep.name, count,
 			(count != ep->ep.maxpacket) ? " (short)" : "",
@@ -2191,7 +2194,8 @@
 		unsigned	len;
 
 		len = req->req.length - req->req.actual;
-		len = min (ep->ep.maxpacket, len);
+		if (len > ep->ep.maxpacket)
+			len = ep->ep.maxpacket;
 		req->req.actual += len;
 
 		/* if we wrote it all, we're usually done */
