Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUGMAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUGMAal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGMA2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:28:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25799 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264542AbUGMA1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:27:25 -0400
Date: Tue, 13 Jul 2004 02:27:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: bcollins@debian.org
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] eth1394: remove an inline
Message-ID: <20040713002720.GD4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/ieee1394/eth1394.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following compile error:

<--  snip  -->

...
  CC      drivers/ieee1394/eth1394.o
drivers/ieee1394/eth1394.c: In function `eth1394_remove':
drivers/ieee1394/eth1394.c:189: sorry, unimplemented: inlining failed in 
call to 'purge_partial_datagram': function body not available
drivers/ieee1394/eth1394.c:403: sorry, unimplemented: called from here
make[2]: *** [drivers/ieee1394/eth1394.o] Error 1

<--  snip  -->


The patch below removes the purge_partial_datagram inline from eth1394.c .

An alternative approach to removing the inline would be to move the 
function above the first function calling it.


diffstat output:
 drivers/ieee1394/eth1394.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/ieee1394/eth1394.c.old	2004-07-13 02:21:05.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/ieee1394/eth1394.c	2004-07-13 02:23:35.000000000 +0200
@@ -186,7 +186,7 @@
 					  unsigned char * haddr);
 static int ether1394_mac_addr(struct net_device *dev, void *p);
 
-static inline void purge_partial_datagram(struct list_head *old);
+static void purge_partial_datagram(struct list_head *old);
 static int ether1394_tx(struct sk_buff *skb, struct net_device *dev);
 static void ether1394_iso(struct hpsb_iso *iso);
 
@@ -1081,7 +1081,7 @@
 	return 0;
 }
 
-static inline void purge_partial_datagram(struct list_head *old)
+static void purge_partial_datagram(struct list_head *old)
 {
 	struct partial_datagram *pd = list_entry(old, struct partial_datagram, list);
 	struct list_head *lh, *n;



