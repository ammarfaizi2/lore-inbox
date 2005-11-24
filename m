Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVKXU1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVKXU1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVKXU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:27:13 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:38787 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751401AbVKXU1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:27:05 -0500
Message-ID: <43862215.9030007@rtr.ca>
Date: Thu, 24 Nov 2005 15:27:01 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.15-rc2] b44: missing netif_wake_queue() in b44_open()
References: <438617DE.5000700@rtr.ca> <Pine.LNX.4.64.0511241146560.13959@g5.osdl.org> <43861E6F.9090604@pobox.com>
In-Reply-To: <43861E6F.9090604@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------060207050001060704040005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207050001060704040005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Nope.   There's no need to wake the queue.
> 
> 1) Use netif_start_queue() rather than netif_wake_queue(), in b44_open()
> 
> 2) OTOH, netif_wake_queue() appears to be missing from the end of 
> b44_resume(), which has highly similar code.

Ah. Thanks, Jeff!
I guess the e100.c driver was a bad example to copy here.

Fixed, tested, still works fine.
Patch now updated.

>>> This patch fixes a problem plaguing Dell notebooks with
>>> built-in b44 ethernet:  The driver refuses to transmit packets
>>> of any kind until after the first 5-second tx_timeout occurs.
>>> This bug causes DHCP negotiation to fail (timeout) during
>>> installation of Ubuntu Linux.
>>>
>>> One-liner fix.  Please review (and apply if you like it).

Signed-off-by:  Mark Lord <lkml@rtr.ca>


--- linux-2.6.15-rc2/drivers/net/b44.c  2005-11-19 22:25:03.000000000 -0500
+++ linux/drivers/net/b44.c     2005-11-24 15:20:47.000000000 -0500
@@ -1417,6 +1417,7 @@
         add_timer(&bp->timer);

         b44_enable_ints(bp);
+       netif_start_queue(dev); /* prevent the initial tx_timeout() we otherwise see */
  out:
         return err;
  }
@@ -2113,6 +2114,7 @@
         add_timer(&bp->timer);

         b44_enable_ints(bp);
+       netif_wake_queue(dev);
         return 0;
  }

--------------060207050001060704040005
Content-Type: text/x-patch;
 name="b44_fix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b44_fix2.patch"

--- linux-2.6.15-rc2/drivers/net/b44.c	2005-11-19 22:25:03.000000000 -0500
+++ linux/drivers/net/b44.c	2005-11-24 15:20:47.000000000 -0500
@@ -1417,6 +1417,7 @@
 	add_timer(&bp->timer);
 
 	b44_enable_ints(bp);
+	netif_start_queue(dev);	/* prevent the initial tx_timeout() we otherwise see */
 out:
 	return err;
 }
@@ -2113,6 +2114,7 @@
 	add_timer(&bp->timer);
 
 	b44_enable_ints(bp);
+	netif_wake_queue(dev);
 	return 0;
 }
 

--------------060207050001060704040005--
