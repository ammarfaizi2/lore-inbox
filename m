Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUBTSfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUBTSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:35:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48911 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261266AbUBTSf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:35:26 -0500
Message-ID: <40365368.5020508@tmus.dk>
Date: Fri, 20 Feb 2004 19:35:20 +0100
From: Thomas Munck Steenholdt <tmus@tmus.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pcnet32 link detection patch proposal
Content-Type: multipart/mixed;
 boundary="------------090209090602030502010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209090602030502010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guys!

A lot of people have been experiencing problems with the pcnet32 nic 
driver that
always returns link down on some devices (including the VMware vlance 
adapter).

The patch makes sure that link is always reported as up (in contrast to 
always
being rported as down) if the device is not MII capable. Devices that 
ARE MII
capable will return whatever mii_link_ok() says.

Please let be know what you think and possible give me a hint as to how 
I can
make sure this fix gets included whereever such a patch should be included!

Thanks a lot!


Thomas

--------------090209090602030502010903
Content-Type: text/plain;
 name="pcnet32_link_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32_link_fix.patch"

diff -ur linux-2.6.2-1.87/drivers/net/pcnet32.c linux-2.6.2-1.87-tmus/drivers/net/pcnet32.c
--- linux-2.6.2-1.87/drivers/net/pcnet32.c	2004-02-19 00:27:36.033478624 +0100
+++ linux-2.6.2-1.87-tmus/drivers/net/pcnet32.c	2004-02-19 00:26:03.733510352 +0100
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.27b"
-#define DRV_RELDATE	"01.10.2002"
+#define DRV_VERSION	"1.27c"
+#define DRV_RELDATE	"02.19.2004"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -213,6 +213,8 @@
  *	   clean up and using new mii module
  * v1.27b  Sep 30 2002 Kent Yoder <yoder1@us.ibm.com>
  * 	   Added timer for cable connection state changes.
+ * v1.27c  Feb 19 2004 Thomas M Steenholdt <tmus@tmus.dk>
+ *         fixed link status on non-mii capable devices.
  */
 
 
@@ -1630,7 +1632,10 @@
 	/* get link status */
 	case ETHTOOL_GLINK: {
 		struct ethtool_value edata = {ETHTOOL_GLINK};
-		edata.data = mii_link_ok(&lp->mii_if);
+                /* read link status  */
+		if(lp->mii) edata.data = mii_link_ok(&lp->mii_if);
+                /* always return link ok for non-mii devices */
+                else edata.data = 1;
 		if (copy_to_user(useraddr, &edata, sizeof(edata)))
 			return -EFAULT;
 		return 0;

--------------090209090602030502010903--
