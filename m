Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTEOBK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTEOBK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:10:57 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:22236 "HELO
	develer.com") by vger.kernel.org with SMTP id S263407AbTEOBKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:10:53 -0400
Message-ID: <3EC2EC02.7050608@develer.com>
Date: Thu, 15 May 2003 03:23:14 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: akpm@zip.com.au
CC: jgarzik@pobox.com, alan@redhat.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, aleph@develer.com
Subject: PATCH: fix bug in drivers/net/cs89x0.c:set_mac_address()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, Jeff and Alan,

the following patch fixes a bug in the CS89xx net device which
would set new MAC address through SIOCSIFHWADDR _only_ when
net_debug is set, which is obviously not what it was meant to do.
The original code bogusly interpreted the addr argument as a buffer
containing the MAC address instead of a struct sockaddr.

Applies as-is to 2.4.20 and with offset to 2.5.69. Please forward
it to Linus and Marcelo. This bug has been found and fixed by
Stefano Fedrigo <aleph@develer.com>.


--- linux-2.4.20.orig/drivers/net/cs89x0.c	2002-08-03 02:39:44.000000000 +0200
+++ linux-2.4.20/drivers/net/cs89x0.c	2003-01-18 19:00:37.000000000 +0100
@@ -1629,16 +1629,21 @@
 }
 
 
-static int set_mac_address(struct net_device *dev, void *addr)
+static int set_mac_address(struct net_device *dev, void *p)
 {
 	int i;
+	struct sockaddr *addr = p;
+
 
 	if (netif_running(dev))
 		return -EBUSY;
+
+	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+
 	if (net_debug) {
 		printk("%s: Setting MAC address to ", dev->name);
-		for (i = 0; i < 6; i++)
-			printk(" %2.2x", dev->dev_addr[i] = ((unsigned char *)addr)[i]);
+		for (i = 0; i < dev->addr_len; i++)
+			printk(" %2.2x", dev->dev_addr[i]);
 		printk(".\n");
 	}
 	/* set the Ethernet address */


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments.
See: http://www.gnu.org/philosophy/no-word-attachments.html

