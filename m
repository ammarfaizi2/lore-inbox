Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWGDPs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWGDPs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGDPs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:48:58 -0400
Received: from tzmxr01.htp-tel.de ([81.14.243.17]:18105 "EHLO
	TZMXR01.htp-tel.de") by vger.kernel.org with ESMTP id S1751282AbWGDPs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:48:57 -0400
Message-ID: <65170.217.5.191.115.1152028122.squirrel@sesamstrasse.dyndns.tv>
Date: Tue, 4 Jul 2006 17:48:42 +0200 (CEST)
Subject: [BUG/PATCH/RFC] bridge: locally generated broadcast traffic may 
     block sender
From: "Bernd Kischnick" <kisch+linux@sesamstrasse.dyndns.tv>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: bridge@lists.osdl.org, linux-kernel@vger.kernel.org,
       "Wolfgang Denk" <wd@denx.de>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

I may have tracked down some unexpected behaviour from a common bridge
setup, and would like to incite expert oppinion on my observations.
The issue relates to both 2.6 and 2.4 kernel series bridging code,
and as far as I can see might have been present in all releases hitherto.

Consider this setup:
- two ethernet devices in a simple bridge configuration
- bridge-interface configured for IPv4
- local application multicasting heavy UDP traffic down the bridge
- one of the ethernet links goes down (=> disconnect cable).

I would expect that IP-multicast/Ethernet-broadcast traffic is simply sent
out of all the bridged interfaces still available and link-up.

Instead we observe that the result --- rather surprisingly --- depends on
WHICH of the ethernet links is down.

One of the two ports doesn't cause troubles: the traffic flows out from
that port which stays up, and the application doesn't mind.

But if you disconnect the OTHER link, then SOME traffic is still sent out of
the port that stays up, but then the sending application is blocked in the
sendto() call. Consequentially, the network traffic then ceases, even
though one of the interfaces is still up and available.
When the link comes up again, everything continues as normal.

You can create a testbed like this:

# build the bridge
ifconfig eth0 0.0.0.0 up
ifconfig eth1 0.0.0.0 up
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
# brctl stp br0 on/off doesn't matter

# configure bridge interface
ifconfig br0 10.20.30.40 up
route add -net 224.0.0.0 netmask 240.0.0.0 dev br0

# try to send a fixed amount of multicast UDP traffic
nbytes=`cat /proc/sys/net/wmem_max`
nbytes=$(( $nbytes * 2 ))
dd if=/dev/zero bs=$nbytes count=1 | nc -nuvw1 224.0.0.123 1234

# arguments to nc:
# -w1 "wait 1sec" causes nc to exit after sending the _complete_ amount
# -n no names, -v verbose, -u UDP to multicast 224.0.0.123 port 1234


If both links are connected, the dd|nc-test completes.
If eth1 link is disconnected, the dd|nc-test completes, too.
If eth0 link is disconnected: dd|nc will block.
If unicast UDP is used: no problems, regardless of link state.

Mind that it's the FIRST bridge interface that stands out.
If you /exchange/ the order of the interfaces when adding them to the
bridge, then eth1 will show the awkward behaviour ---
again the FIRST bridge interface.


Why does the application block?

ifconfig br0, ifconfig eth1, or a tcpdump on the other and of the eth1
link will show that an amount of roundabout sys.net.wmem_max has been
sent.

cat /proc/net/udp shows that an EQUAL amount of bytes as has already been
sent out is STILL queued on behalf of the socket openened by nc.
It will be sent as soon as the link goes up again, and the application
will promptly unblock and finish.

The tx_queue indication for the sending socket is the clue.
The packets (or rather sk_buffs) generated through the socket are accredited
to the socket's wmem_alloc memory quota. Because one link is down,
sk_buffs will be queued on the transmit queue of one interface.
While they are queued, they won't be freed, causing the socket to run out
of its wmem_alloc quota, because they are still associated to the socket.


Why the first bridge interface only?

Obviously the bridge has to copy outgoing packets to distribute them to
its ports. Regard the copy loop br_flood() in br_forward.c.
It has two modes of operation, selected by a "clone" flag.
For distributing locally generated traffic, br_flood() is called in the
mode "clone=0". This mode works like this:

/* deliver this: */
sk_buff* skb;

prev_port=NULL;
port=tail of bridge port list;
while (port) {
    if (prev_port != NULL) {
          deliver (prev_port, skb_clone (skb));
    }
    prev_port = port;
    port = next bridge port in list;
}
if (prev_port) {
    deliver (prev_port, skb);
    return;
}
kfree_skb (skb);


This results in clones of the original sk_buff being send through all
bridge ports except for the last in list traversal. This port
receives the original sk_buff which was generated through the application's
socket. The "last in list traversal" happens to be the first port added
to the bridge.

This means that the bridge port which shows link-down peculiarities is
also the one which receives the original sk_buff. All ports that receive
clones of the original sk_buff work as expected.

This observation is consistent with the way skb_clone() works:
the clones don't share the "sock" and "destructor" attributes of the
original. This means that the clones are not credited to the originating
socket, whereas the originals are.

When the original sk_buffs are to be delivered across a link that's down,
they will be queued on the transmit queue of physical device instead,
and not be freed. Therefore the originating socket runs out of wmem_alloc
quota and blocks the application.

It's perhaps not surprising that this behaviour has gone unnoticed so far,
because it only affects broadcast/multicast traffic, which only consists
of tiny amounts of transferred volume in the protocols usually found.
And additionally the wmem_alloc is available per socket, not per ether
device, so that different protocols don't run into a cumulative traffic
barrier.



Fix.

Should we agree that the observed behaviour should indeed be amended,
i propose the following fix:

in br_device.c, function br_dev_xmit() (or __br_dev_xmit() in 2.4):
skb_orphan() the sk_buff to be delivered before handing it to the clone
loop in br_flood_deliver(), calling br_flood().

skb_orphan() disassociates the sk_buff from its owning socket and runs
the "destructor" attached to the sk_buff, which restores the wmem_alloc
quota of the sending socket.

If the wmem_alloc is replenished, the application won't block and keep
sending the broadcast messages to all available bridge ports.
The transmit queue of the link-down port will eventually fill up,
but the same happens currently when the non-first port goes link-down,
without obvious hazards. The sk_buff will be freed as part of the
transmit queue run, just like it is currently.



I'd be glad to receive any feedback on this issue.
It would especially be nice if someone could try to reproduce the behaviour
using different ethernet hardware and drivers, because I'm working on a
embedded system just so slightly off the mainstream
(a PowerPC 8260 series module using the fcc_enet driver.
The hardware port is maintained by Wolfgang Denk -
that's why I'm CCing you, Mr. Denk)

happy hacking,
- Bernd Kischnick.



Patches.

for 2.4.32:
signed-off-by: Bernd Kischnick <kisch@gmx.li>

diff -urN a/CREDITS b/CREDITS
--- a/CREDITS   2005-01-19 15:09:22.000000000 +0100
+++ b/CREDITS   2006-07-04 16:36:47.000000000 +0200
@@ -1599,6 +1599,13 @@
 S: D-64295
 S: Germany

+N: Bernd Kischnick
+E: kisch@gmx.li
+D: the odd kernel fix
+S: Alemannstr 11
+S: 30165 Hannover
+S: Germany
+
 N: Andi Kleen
 E: ak@muc.de
 D: network hacker, syncookies
diff -urN a/net/bridge/br_device.c b/net/bridge/br_device.c
--- a/net/bridge/br_device.c    2002-02-25 20:38:14.000000000 +0100
+++ b/net/bridge/br_device.c    2006-07-04 17:11:20.000000000 +0200
@@ -57,6 +57,7 @@
        skb_pull(skb, ETH_HLEN);

        if (dest[0] & 1) {
+               skb_orphan(skb);
                br_flood_deliver(br, skb, 0);
                return 0;
        }
@@ -67,6 +68,7 @@
                return 0;
        }

+       skb_orphan(skb);
        br_flood_deliver(br, skb, 0);
        return 0;
 }





For 2.6.17.3:
signed-off-by: Bernd Kischnick <kisch@gmx.li>

diff -urN a/CREDITS b/CREDITS
--- a/CREDITS   2006-06-30 19:37:38.000000000 +0200
+++ b/CREDITS   2006-07-04 16:46:09.000000000 +0200
@@ -1725,6 +1725,13 @@
 S: D-64295
 S: Germany

+N: Bernd Kischnick
+E: kisch@gmx.li
+D: the odd kernel fix
+S: Alemannstr 11
+S: 30165 Hannover
+S: Germany
+
 N: Andi Kleen
 E: ak@muc.de
 D: network hacker, syncookies
diff -urN a/net/bridge/br_device.c b/net/bridge/br_device.c
--- a/net/bridge/br_device.c    2006-06-30 19:37:38.000000000 +0200
+++ b/net/bridge/br_device.c    2006-07-04 17:26:36.000000000 +0200
@@ -40,12 +40,16 @@
        skb->mac.raw = skb->data;
        skb_pull(skb, ETH_HLEN);

-       if (dest[0] & 1)
+
+       if (dest[0] & 1) {
+               skb_orphan(skb);
                br_flood_deliver(br, skb, 0);
-       else if ((dst = __br_fdb_get(br, dest)) != NULL)
+       } else if ((dst = __br_fdb_get(br, dest)) != NULL) {
                br_deliver(dst->dst, skb);
-       else
+       } else {
+               skb_orphan(skb);
                br_flood_deliver(br, skb, 0);
+       }

        return 0;
 }



