Return-Path: <linux-kernel-owner+willy=40w.ods.org-S278951AbUKBDvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S278951AbUKBDvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S318146AbUKBDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:51:50 -0500
Received: from atorelbas02.hp.com ([156.153.255.246]:42905 "EHLO
	palrel11.hp.com") by vger.kernel.org with ESMTP id S375422AbUKAW6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:58:25 -0500
Date: Mon, 1 Nov 2004 14:58:24 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [PATCH 2.6] Wireless Extension dropped patchlet
Message-ID: <20041101225823.GA16560@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	This tiny bit of the last WE-17 patch was lost between me and
you. I initially decided to wait to resubmit, but Chris Wedgwood
reported that the MadWifi driver needs it. Sorry for not having pushed
harder.
	I recreated this patch, and tested with 2.6.10-rc1, and Chris
tested it with MadWifi. Would you mind pushing that up to Linus ?
	Thanks in advance...

	Jean

Changelog :
	o remove unneeded const
	o spelling + comments
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
---------------------------------------------------------------

diff -u -p linux-2.6.10-rc1/include/linux/wireless.h linux-2.6.9/include/linux/wireless.h
--- linux-2.6.10-rc1/include/net/iw_handler.h	Mon Nov  1 11:14:46 2004
+++ linux-2.6.9/include/net/iw_handler.h	Mon Nov  1 11:14:50 2004
@@ -311,10 +311,10 @@ struct iw_handler_def
 {
 	/* Number of handlers defined (more precisely, index of the
 	 * last defined handler + 1) */
-	const __u16		num_standard;
-	const __u16		num_private;
+	__u16			num_standard;
+	__u16			num_private;
 	/* Number of private arg description */
-	const __u16		num_private_args;
+	__u16			num_private_args;
 
 	/* Array of handlers for standard ioctls
 	 * We will call dev->wireless_handlers->standard[ioctl - SIOCSIWNAME]
@@ -332,7 +332,7 @@ struct iw_handler_def
 	const struct iw_priv_args *	private_args;
 
 	/* This field will be *removed* in the next version of WE */
-	const long		spy_offset;	/* DO NOT USE */
+	long			spy_offset;	/* DO NOT USE */
 
 	/* New location of get_wireless_stats, to de-bloat struct net_device.
 	 * The old pointer in struct net_device will be gradually phased
diff -u -p linux-2.6.10-rc1/include/net/iw_handler.h linux-2.6.9/include/net/iw_handler.h
--- linux-2.6.10-rc1/net/core/wireless.c	Mon Nov  1 11:14:48 2004
+++ linux-2.6.9/net/core/wireless.c	Mon Nov  1 11:24:32 2004
@@ -52,7 +52,8 @@
  * v6 - 18.06.04 - Jean II
  *	o Change get_spydata() method for added safety
  *	o Remove spy #ifdef, they are always on -> cleaner code
- *	o Allow any size GET request is user specifies length > max
+ *	o Allow any size GET request if user specifies length > max
+ *		and if request has IW_DESCR_FLAG_NOMAX flag or is SIOCGIWPRIV
  *	o Start migrating get_wireless_stats to struct iw_handler_def
  *	o Add wmb() in iw_handler_set_spy() for non-coherent archs/cpus
  * Based on patch from Pavel Roskin <proski@gnu.org> :
@@ -690,6 +691,10 @@ static inline int ioctl_standard_call(st
 				 * we can support any size GET requests.
 				 * There is still a limit : -ENOMEM. */
 				extra_size = user_length * descr->token_size;
+				/* Note : user_length is originally a __u16,
+				 * and token_size is controlled by us,
+				 * so extra_size won't get negative and
+				 * won't overflow... */
 			}
 		}
 
@@ -1227,7 +1232,7 @@ int iw_handler_set_spy(struct net_device
 
 	/* We want to operate without locking, because wireless_spy_update()
 	 * most likely will happen in the interrupt handler, and therefore
-	 * have it own locking constraints and needs performance.
+	 * have its own locking constraints and needs performance.
 	 * The rtnl_lock() make sure we don't race with the other iw_handlers.
 	 * This make sure wireless_spy_update() "see" that the spy list
 	 * is temporarily disabled. */
