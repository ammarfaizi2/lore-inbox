Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVBMQjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVBMQjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVBMQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:39:15 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:18950 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261237AbVBMQjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:39:06 -0500
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] linux-libc-headers-2.6.10.0: if_tunnel.h relies on
 byteorder.h having been included
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Sun, 13 Feb 2005 16:38:58 +0000
Message-ID: <87k6pch0t9.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In iproute2, ip/iptunnel.c says:

#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/ip.h>
#include <linux/if_tunnel.h>

Now the original Linux kernel includes byteorder.h as a side-effect of
including netdevice.h, which it does inside a __KERNEL__ ifdef when
if_arp.h is included.

I think it makes more sense to include it in those headers that actually
use the __constant_htons() macro, viz:

diff -durN 2.6.10.0-orig/include/linux/if_pppox.h 2.6.10.0/include/linux/if_pppox.h
--- 2.6.10.0-orig/include/linux/if_pppox.h	2004-10-31 19:55:51.000000000 +0000
+++ 2.6.10.0/include/linux/if_pppox.h	2005-02-13 16:28:58.000000000 +0000
@@ -21,6 +21,7 @@
 #include <asm/types.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <asm/byteorder.h>
 
 /* For user-space programs to pick up these definitions
  * which they wouldn't get otherwise without defining __KERNEL__
diff -durN 2.6.10.0-orig/include/linux/if_tunnel.h 2.6.10.0/include/linux/if_tunnel.h
--- 2.6.10.0-orig/include/linux/if_tunnel.h	2004-10-31 19:55:26.000000000 +0000
+++ 2.6.10.0/include/linux/if_tunnel.h	2005-02-13 16:28:35.000000000 +0000
@@ -4,6 +4,7 @@
 #include <linux/if.h>
 #include <linux/ip.h>
 #include <asm/types.h>
+#include <asm/byteorder.h>
 
 #define SIOCGETTUNNEL   (SIOCDEVPRIVATE + 0)
 #define SIOCADDTUNNEL   (SIOCDEVPRIVATE + 1)
diff -durN 2.6.10.0-orig/include/linux/sctp.h 2.6.10.0/include/linux/sctp.h
--- 2.6.10.0-orig/include/linux/sctp.h	2005-01-08 14:03:26.000000000 +0000
+++ 2.6.10.0/include/linux/sctp.h	2005-02-13 16:29:36.000000000 +0000
@@ -53,6 +53,7 @@
 
 #include <linux/in.h>		/* We need in_addr.  */
 #include <linux/in6.h>		/* We need in6_addr.  */
+#include <asm/byteorder.h>
 
 
 /* Section 3.1.  SCTP Common Header Format */


(With this patch, the header stands alone, and iproute2 compiles again.)

-- 
Synapsids unite! You have nothing to lose but your eggshells!
