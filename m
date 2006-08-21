Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWHUWcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWHUWcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHUWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:32:22 -0400
Received: from mailfe02.tele2.fr ([212.247.154.44]:63195 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751264AbWHUWcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:32:21 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Tue, 22 Aug 2006 00:32:03 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Cc: dave@mielke.cc
Subject: [PATCH] vcsa attribute bits -> ioctl(VT_GETHIFONTMASK)
Message-ID: <20060821223203.GD5383@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
	dave@mielke.cc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When reading /dev/vcsa while a font with more than 256 characters is
loaded, one of the attribute bits records the 9th bit of the character.
But depending on the console driver (vgacon or fbcon for instance),
that's bit 3 or bit 0.  And there is no way for userland to know that,
thus no way for userland to safely grab the screen content.  So here is
a (tested) patch.  I know 2.6.18 is very close now, but since this is a
quite trivial patch, maybe it could find its way in as soon as now?


  Add a VT_GETHIFONTMASK ioctl for knowing which bit is the 9th bit for
  VC text (vc_hi_font_mask field of the vc_data structure).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- linux-2.6.17-orig/drivers/char/vt_ioctl.c	2006-03-20 06:53:29.000000000 +0100
+++ linux/drivers/char/vt_ioctl.c	2006-08-21 22:34:52.000000000 +0200
@@ -1012,6 +1012,8 @@
 		   return -EPERM;
 		vt_dont_switch = 0;
 		return 0;
+	case VT_GETHIFONTMASK:
+		return put_user(vc->vc_hi_font_mask, (unsigned short __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
--- linux-2.6.17-orig/include/linux/vt.h	2006-03-20 06:53:29.000000000 +0100
+++ linux/include/linux/vt.h	2006-08-21 22:35:49.000000000 +0200
@@ -50,5 +50,6 @@
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
 
 #endif /* _LINUX_VT_H */
--- linux-2.6.17-orig/include/linux/compat_ioctl.h	2006-06-18 19:22:39.000000000 +0200
+++ linux/include/linux/compat_ioctl.h	2006-08-21 22:34:17.000000000 +0200
@@ -216,6 +216,7 @@
 COMPATIBLE_IOCTL(VT_RESIZEX)
 COMPATIBLE_IOCTL(VT_LOCKSWITCH)
 COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
+COMPATIBLE_IOCTL(VT_GETHIFONTMASK)
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(RTC_AIE_ON)
 COMPATIBLE_IOCTL(RTC_AIE_OFF)
