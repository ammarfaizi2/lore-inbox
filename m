Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVKXTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVKXTnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVKXTnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:43:32 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:31699 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932650AbVKXTna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:43:30 -0500
Message-ID: <438617DE.5000700@rtr.ca>
Date: Thu, 24 Nov 2005 14:43:26 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.15-rc2] b44: missing netif_wake_queue() in b44_open()
Content-Type: multipart/mixed;
 boundary="------------050706090601070608040205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050706090601070608040205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a problem plaguing Dell notebooks with
built-in b44 ethernet:  The driver refuses to transmit packets
of any kind until after the first 5-second tx_timeout occurs.
This bug causes DHCP negotiation to fail (timeout) during
installation of Ubuntu Linux.

One-liner fix.  Please review (and apply if you like it).

Signed-off-by:  Mark Lord <lkml@rtr.ca>

--- linux-2.6.15-rc2/drivers/net/b44.c  2005-11-19 22:25:03.000000000 -0500
+++ linux/drivers/net/b44.c     2005-11-24 14:28:47.000000000 -0500
@@ -1417,6 +1417,7 @@
         add_timer(&bp->timer);

         b44_enable_ints(bp);
+       netif_wake_queue(dev);  /* prevent the initial tx_timeout() we otherwise see */
  out:
         return err;
  }

--------------050706090601070608040205
Content-Type: text/x-patch;
 name="b44_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b44_fix.patch"

--- linux-2.6.15-rc2/drivers/net/b44.c	2005-11-19 22:25:03.000000000 -0500
+++ linux/drivers/net/b44.c	2005-11-24 14:28:47.000000000 -0500
@@ -1417,6 +1417,7 @@
 	add_timer(&bp->timer);
 
 	b44_enable_ints(bp);
+	netif_wake_queue(dev);	/* prevent the initial tx_timeout() we otherwise see */
 out:
 	return err;
 }

--------------050706090601070608040205--
