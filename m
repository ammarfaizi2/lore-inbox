Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSGSPGz>; Fri, 19 Jul 2002 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSGSPGz>; Fri, 19 Jul 2002 11:06:55 -0400
Received: from dclient217-162-176-181.hispeed.ch ([217.162.176.181]:20998 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S316683AbSGSPGy>; Fri, 19 Jul 2002 11:06:54 -0400
Date: Fri, 19 Jul 2002 17:09:40 +0200
From: Martin Brulisauer <bruli@uceb.org>
Message-Id: <200207191509.g6JF9ebQ011849@alder.intra.bruli.net>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [Patch 2.5.26] ewrk3.c - unaligend access
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here follows a very small patch to the Etherworks3 driver.
On alpha architecture all memory accesses must be done naturally
aligned. The element dev_addr of the struct net_device is of
type unsigned char*. So the cast to 32bit long int for a faster
compare will result in a unaligend trap on the alpha processor.
The current implementation will compare the destination address
of the incoming packet with two instructions. My patch uses
three instructions. The trap on alpha is much more expensive
then one additional integer instruction.

--- linux-2.5.26/drivers/net/ewrk3.c	Wed Jul 17 01:49:32 2002
+++ linux/drivers/net/ewrk3.c	Fri Jul 19 17:02:11 2002
@@ -133,6 +133,7 @@
    0.42    22-Apr-96      Fix alloc_device() bug <jari@markkus2.fimr.fi>
    0.43    16-Aug-96      Update alloc_device() to conform to de4x5.c
    0.44    08-Nov-01      use library crc32 functions <Matt_Domsch@dell.com>
+   0.45	   19-Jul-02	  fix unaligend access on alpha <martin@bruli.net>
 
    =========================================================================
  */
@@ -1008,12 +1009,13 @@
 						}
 						p = skb->data;	/* Look at the dest addr */
 						if (p[0] & 0x01) {	/* Multicast/Broadcast */
-							if ((*(s32 *) & p[0] == -1) && (*(s16 *) & p[4] == -1)) {
+							if ((*(s16 *) & p[0] == -1) && (*(s16 *) & p[2] == -1) && (*(s16 *) & p[4] == -1)) {
 								lp->pktStats.broadcast++;
 							} else {
 								lp->pktStats.multicast++;
 							}
-						} else if ((*(s32 *) & p[0] == *(s32 *) & dev->dev_addr[0]) &&
+						} else if ((*(s16 *) & p[0] == *(s16 *) & dev->dev_addr[0]) &&
+							   (*(s16 *) & p[2] == *(s16 *) & dev->dev_addr[2]) &&
 							   (*(s16 *) & p[4] == *(s16 *) & dev->dev_addr[4])) {
 							lp->pktStats.unicast++;
 						}
-
Greetings,
Martin
------------------------------------
Martin Brulisauer <martin@bruli.net>
http://www.bruli.net
------------------------------------
