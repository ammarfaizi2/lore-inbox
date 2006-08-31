Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWHaOmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWHaOmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHaOmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:42:18 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14629 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932150AbWHaOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:42:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=idYRpX2co8c+YQJ5SEey35O9mJbPDSlXwee0zkc7i0e/ejAWVTR/F7+YrtD4jnU0Ww3i5EBST45EHZTqVWbbEx7odvhVLkLeOMwaVobmqnl8ieKNDZa1nkek3gGhEJue3zcnSPrM8rJMdiU7mcf+MQqOIJxlDfbfIK9BhdR4Myc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Add netpoll/netconsole support to vlan devices
Date: Thu, 31 Aug 2006 16:41:44 +0200
User-Agent: KMail/1.9.4
Cc: netdev@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Ben Greear <greearb@candelatech.com>,
       "David S. Miller" <davem@redhat.com>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608311641.44824.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I recently tried running netconsole via a vlan interface without luck,
and decided to do something about it (see patch below).


My interfaces look like this:

eth0      Link encap:Ethernet  HWaddr 00:14:5E:28:3C:2E
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11763760878 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13800040335 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3453951528686 (3.1 TiB)  TX bytes:7086425530052 (6.4 TiB)
          Interrupt:169

eth0.20   Link encap:Ethernet  HWaddr 00:14:5E:28:3C:2E
          inet addr:vvv.xxx.yyy.zzz  Bcast:ggg.hhh.iii.jjj  Mask:255.255.252.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11759883828 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13800040452 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3194985806767 (2.9 TiB)  TX bytes:6975984645540 (6.3 TiB)


Trying to load netconsole fails miserably : 

[root@server root]# modprobe netconsole 
netconsole=@/eth0,10514@aaa.bbb.ccc.ddd/00:04:23:BF:D9:62
FATAL: Error inserting netconsole 
(/lib/modules/2.6.17.8/kernel/drivers/net/netconsole.ko): Invalid argument
[root@server root]# modprobe netconsole 
netconsole=@/eth0.20,10514@aaa.bbb.ccc.ddd/00:04:23:BF:D9:62
FATAL: Error inserting netconsole 
(/lib/modules/2.6.17.8/kernel/drivers/net/netconsole.ko): Invalid argument


And results in this in dmesg :

netconsole: interface eth0
netconsole: remote port 10514
netconsole: remote IP aaa.bbb.ccc.ddd
netconsole: remote ethernet address 00:04:23:bf:d9:62
netconsole: no IP address for eth0, aborting
netconsole: local port 6665
netconsole: interface eth0.20
netconsole: remote port 10514
netconsole: remote IP aaa.bbb.ccc.ddd
netconsole: remote ethernet address 00:04:23:bf:d9:62
netconsole: eth0.20 doesn't support polling, aborting.


The actual interface is a e1000 and supports polling just fine. 
The problem is simply that netpoll won't play with eth0 since it has
no IP and it won't play with eth0.20 either since it's a vlan 
interface and doesn't support polling even if the underlying device 
does.

This is a problem for me since it means that several of my servers 
that are configured like this won't be able to use netconsole.
So I set out to try and fix the problem by making the vlan device 
support polling if the underlying device supports polling.

I have met with a resonable success in that the patch below seems to 
work. With this patch I can now load netconsole for eth0.20 and log 
messages are send just fine and can be recieved on the remote host.

 netconsole: local port 6665
 netconsole: interface eth0.20
 netconsole: remote port 10514
 netconsole: remote IP aaa.bbb.ccc.ddd
 netconsole: remote ethernet address 00:04:23:bf:d9:62
 netconsole: local IP vvv.xxx.yyy.zzz
 netconsole: network logging started

Now, I would very much like to get this merged, but first I would 
appreciate some review of the patch. This part of the kernel is not 
one I know all too well, so I may have made a number of silly mistakes.
If people would kindly take a look at the patch and point out any 
problems with it so I can fix it up and arrive at a version that's 
mergable, I'd greatly appreciate it.


PS. If you reply to this on the netdev list, please keep me on Cc: 
since I'm only subscribed to linux-kernel.


Kind regards,
Jesper Juhl <jesper.juhl@gmail.com>



Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/8021q/vlan.c     |    5 +++++
 net/8021q/vlan_dev.c |   15 ++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff -upr linux-2.6.18-rc5-git2-orig/net/8021q/vlan.c 
linux-2.6.18-rc5-git2/net/8021q/vlan.c
--- linux-2.6.18-rc5-git2-orig/net/8021q/vlan.c	2006-08-31 10:07:08.000000000 
+0200
+++ linux-2.6.18-rc5-git2/net/8021q/vlan.c	2006-08-31 16:34:33.000000000 +0200
@@ -11,6 +11,7 @@
  *		Add HW acceleration hooks - David S. Miller <davem@redhat.com>;
  *		Correct all the locking - David S. Miller <davem@redhat.com>;
  *		Use hash table for VLAN groups - David S. Miller <davem@redhat.com>
+ *		Add NETPOLL support - Jesper Juhl
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -512,6 +513,10 @@ static struct net_device *register_vlan_
 	}
 	new_dev->hard_header_parse = real_dev->hard_header_parse;
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	new_dev->poll_controller = real_dev->poll_controller;
+#endif
+
 	VLAN_DEV_INFO(new_dev)->vlan_id = VLAN_ID; /* 1 through VLAN_VID_MASK */
 	VLAN_DEV_INFO(new_dev)->real_dev = real_dev;
 	VLAN_DEV_INFO(new_dev)->dent = NULL;
diff -upr linux-2.6.18-rc5-git2-orig/net/8021q/vlan_dev.c 
linux-2.6.18-rc5-git2/net/8021q/vlan_dev.c
--- linux-2.6.18-rc5-git2-orig/net/8021q/vlan_dev.c	2006-06-18 
03:49:35.000000000 +0200
+++ linux-2.6.18-rc5-git2/net/8021q/vlan_dev.c	2006-08-31 16:35:35.000000000 
+0200
@@ -12,7 +12,8 @@
  *              Oct 20, 2001:  Ard van Breeman:
  *                - Fix MC-list, finally.
  *                - Flush MC-list on VLAN destroy.
- *                
+ *		Aug 31, 2006: Jesper Juhl
+ *		  - Add NETPOLL support.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -489,6 +490,12 @@ int vlan_dev_hard_start_xmit(struct sk_b
 	stats->tx_bytes += skb->len;
 
 	skb->dev = VLAN_DEV_INFO(dev)->real_dev;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	if (irqs_disabled()) {
+		skb->dev->hard_start_xmit(skb, skb->dev);
+		return 0;
+	}
+#endif
 	dev_queue_xmit(skb);
 
 	return 0;
@@ -513,6 +520,12 @@ int vlan_dev_hwaccel_hard_start_xmit(str
 	stats->tx_bytes += skb->len;
 
 	skb->dev = VLAN_DEV_INFO(dev)->real_dev;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	if (irqs_disabled()) {
+		skb->dev->hard_start_xmit(skb, skb->dev);
+		return 0;
+	}
+#endif
 	dev_queue_xmit(skb);
 
 	return 0;




