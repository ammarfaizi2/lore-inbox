Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVBDBR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVBDBR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVBDBR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:17:26 -0500
Received: from palrel10.hp.com ([156.153.255.245]:54968 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263011AbVBDAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:53:47 -0500
Date: Thu, 3 Feb 2005 16:53:46 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [PATCH 2.4] SIOCSIFNAME wildcard support
Message-ID: <20050204005346.GA7692@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

	This patch adds wildcard support for the SIOCSIFNAME ioctl,
like what was done in 2.6.1. SIOCSIFNAME allow a user space tool to
change network interface names (such as nameif, ifrename, or ip link),
this patch allow those tools to specify a pattern, such as "eth%d" or
"wlan%d", and the kernel use the lowest available slot.
	The reason I'm sending you this patch is that I've got some
2.4.X users who requested the feature...
	This patch was initially done for 2.4.23, and I rediffed and
retested with 2.4.29. It's somewhat different from the patch Stephen
and me added to 2.6.1, because the netdev init code is different and
also this patch is more conservative.

	Have fun...

	Jean

-------------------------------------------------------------

diff -u -p linux/net/core/dev.j1.c linux/net/core/dev.c
--- linux/net/core/dev.j1.c	Wed Dec  3 14:29:21 2003
+++ linux/net/core/dev.c	Wed Dec  3 18:55:27 2003
@@ -2179,10 +2179,26 @@ static int dev_ifsioc(struct ifreq *ifr,
 		case SIOCSIFNAME:
 			if (dev->flags&IFF_UP)
 				return -EBUSY;
-			if (__dev_get_by_name(ifr->ifr_newname))
-				return -EEXIST;
-			memcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
-			dev->name[IFNAMSIZ-1] = 0;
+			/* Check if name contains a wildcard */
+			if (strchr(ifr->ifr_newname, '%')) {
+				char format[IFNAMSIZ + 1];
+				int ret;
+				memcpy(format, ifr->ifr_newname, IFNAMSIZ);
+				format[IFNAMSIZ-1] = 0;
+				/* Find a free name based on format.
+				 * dev_alloc_name() replaces "%d" with at max
+				 * 2 digits, so no name overflow. - Jean II */
+				ret = dev_alloc_name(dev, format);
+				if (ret < 0)
+					return ret;
+				/* Copy the new name back to caller. */
+				strncpy(ifr->ifr_newname, dev->name, IFNAMSIZ);
+			} else {
+				if (__dev_get_by_name(ifr->ifr_newname))
+					return -EEXIST;
+				memcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
+				dev->name[IFNAMSIZ-1] = 0;
+			}
 			notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
 			return 0;
 
@@ -2315,6 +2331,7 @@ int dev_ioctl(unsigned int cmd, void *ar
 		 *	- return a value
 		 */
 		 
+		case SIOCSIFNAME:
 		case SIOCGMIIPHY:
 		case SIOCGMIIREG:
 			if (!capable(CAP_NET_ADMIN))
@@ -2350,7 +2367,6 @@ int dev_ioctl(unsigned int cmd, void *ar
 		case SIOCDELMULTI:
 		case SIOCSIFHWBROADCAST:
 		case SIOCSIFTXQLEN:
-		case SIOCSIFNAME:
 		case SIOCSMIIREG:
 		case SIOCBONDENSLAVE:
 		case SIOCBONDRELEASE:
