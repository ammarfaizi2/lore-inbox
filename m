Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVBJQgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVBJQgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 11:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBJQgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 11:36:40 -0500
Received: from dobermann.cosy.sbg.ac.at ([141.201.2.56]:1174 "EHLO
	dobermann.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id S262171AbVBJQg1 (ORCPT <rfc822;linux-kernel@VGER.KERNEL.ORG>);
	Thu, 10 Feb 2005 11:36:27 -0500
Date: Thu, 10 Feb 2005 17:36:25 +0100 (MET)
From: Andreas Maier <andi@cosy.sbg.ac.at>
To: <linux-kernel@VGER.KERNEL.ORG>
Subject: [PATCH] sundance.c: high interrupt load [resent]
Message-ID: <Pine.GSO.4.33.0502101731400.16515-100000@lama.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In at least some versions of Kernel 2.6 (2.6.8.1, 2.6.11-rc2)
the driver drivers/net/sundance.c creates high interrupt load
(~ 100 interrupts per second) even in case of no network traffic
at all.

It seems that some sort of TX overflow handling is misplaced
and triggers interrupts very often even in case of no data to
send. The TX overflow handling has been moved to a more
appropriate place.

While there, an off by one error of reading the TX status has
also been corrected by moving the read after the break.

Thanks to Jeroen who tested the patch (also with high workload).
Interrupts are down to normal and there are no obvious side
effects.

The attached patch is against kernel 2.6.11-rc2. A copy has been
sent to Donald Becker but unfortunately no response arrived.
Comments are very much appreciated.

Best regards,
-andi


--- sundance.c.orig	2005-01-22 02:48:26.000000000 +0100
+++ sundance.c	2005-01-28 19:55:59.000000000 +0100
@@ -1210,9 +1210,11 @@
 				}
 				/* Yup, this is a documentation bug.  It cost me *hours*. */
 				iowrite16 (0, ioaddr + TxStatus);
-				tx_status = ioread16 (ioaddr + TxStatus);
-				if (tx_cnt < 0)
+				if (tx_cnt < 0) {
+					iowrite32(5000, ioaddr + DownCounter);
 					break;
+				}
+				tx_status = ioread16 (ioaddr + TxStatus);
 			}
 			hw_frame_id = (tx_status >> 8) & 0xff;
 		} else 	{
@@ -1278,7 +1280,6 @@
 	if (netif_msg_intr(np))
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, ioread16(ioaddr + IntrStatus));
-	iowrite32(5000, ioaddr + DownCounter);
 	return IRQ_RETVAL(handled);
 }


-- 
| Andreas Maier                     University of Salzburg               |
| (andi@cosy.sbg.ac.at)             Department of Computing Sciences     |
| Tel. +43/662/8044-6339            Jakob Haringerstr. 2                 |
| Fax. +43/662/8044-611             5020 Salzburg / Austria, Europe      |

