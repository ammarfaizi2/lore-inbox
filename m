Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUDOIFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 04:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDOIFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 04:05:31 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:29116 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261231AbUDOIFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 04:05:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Thu, 15 Apr 2004 10:05:22 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404141739.56829.baldrick@free.fr> <200404142239.08408.oliver@neukum.org>
In-Reply-To: <200404142239.08408.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404151005.22143.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 22:39, Oliver Neukum wrote:
> > > I would prefer a real WARN_ON() so that the imbedded people compiling
> > > for size are not affected.
> >
> > What do you mean?  How is a real WARN_ON() better?
>
> WARN_ON can be defined away to make a smaller kernel. Code that does
> not use it takes away that option.

Hi Oliver, I thought you meant that CONFIG_EMBEDDED made WARN_ON go away
(or something like that).  If you just mean that it is easy to redefine WARN_ON by
hand, then all I can say is: it is also easy to redefine warn by hand!  Anyway, I made
you the following patch:

--- gregkh-2.6/include/linux/usb.h.orig	2004-04-15 09:52:36.000000000 +0200
+++ gregkh-2.6/include/linux/usb.h	2004-04-15 09:56:30.000000000 +0200
@@ -1073,9 +1073,15 @@
 #define dbg(format, arg...) do {} while (0)
 #endif
 
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
+#if !defined(CONFIG_EMBEDDED) || defined(DEBUG)
 #define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+#else
+#define info(format, arg...) do {} while (0)
+#define warn(format, arg...) do {} while (0)
+#endif
+
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
 
 
 #endif  /* __KERNEL__ */
