Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTFXRIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTFXRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:08:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27091 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262170AbTFXRIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:08:53 -0400
Date: Tue, 24 Jun 2003 19:22:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.73: eth1394.c: ptask might be used uninitialized
Message-ID: <20030624172254.GQ3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.73, gcc complains as follows:

<--  snip  -->

...
  CC      drivers/ieee1394/eth1394.o
...
drivers/ieee1394/eth1394.c:1424: warning: `ptask' might be used 
uninitialized in this function
...

<--  snip  -->

It seems something like the patch below might be needed (I didn't check 
for 100% correctness, but it shows what might be needed to fix it).

cu
Adrian

--- linux-2.5.73-not-full/drivers/ieee1394/eth1394.c.old	2003-06-23 23:11:01.000000000 +0200
+++ linux-2.5.73-not-full/drivers/ieee1394/eth1394.c	2003-06-23 23:11:25.000000000 +0200
@@ -1427,7 +1427,7 @@
 	if (skb_is_nonlinear(skb)) {
 		ret = skb_linearize(skb, kmflags);
 		if(ret)
-			goto fail;
+			goto out;
 	}
 
 	ptask = kmem_cache_alloc(packet_task_cache, kmflags);
@@ -1555,6 +1555,7 @@
 		ether1394_free_packet(ptask->packet);
 	if(ptask)
 		kmem_cache_free(packet_task_cache, ptask);
+out:
 	if(skb != NULL) {
 		dev_kfree_skb(skb);
 	}
