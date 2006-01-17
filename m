Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWAQMUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWAQMUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWAQMUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:20:54 -0500
Received: from team.teamix.net ([194.150.191.72]:28875 "EHLO rproxy.teamix.net")
	by vger.kernel.org with ESMTP id S932447AbWAQMUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:20:53 -0500
Message-ID: <43CCE123.1010608@teamix.net>
Date: Tue, 17 Jan 2006 13:20:51 +0100
From: Richard Mueller <mueller@teamix.net>
Organization: Teamix GmbH
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange Problems with ARP and Linux
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy... (the same was posted to linux-net yesterday)

I experienced some strange behaviour with linux and the arp protocol.

1.) Kernel-Version: 2.6.11.7 plus grsec-patches

2.) Setup:

         +--------+
         | Router |
         +---+----+
             |
             |
      +------+-------+
      |              |
      |              | Transitnet for
      |              | Cluster/Router
 +----+-----+  +-----+------+
 | Primary  |  | Secondary  |
 +----+-----+  +-----+------+
      |              |
      |              | LAN
      +--------------+

Router:    C2600 router from ISP

Primary:   First(active) linux router
Secondary: Secondary(standby) linux router

Primary/Secondary are configured as a cluster
with the heartbeat package.

The cluster shares a IP-Alias in the transitnet and
many IPs in the LAN-segments. The IP-Alias is always
bound to one node at the same time.

Following IPs and MACs are used for this example:

transit-net:
Router:    10.0.0.1/24  | 00:10:F3:09:10:70
Primary:   10.0.0.10/24 | 00:10:F3:09:11:71
Secondary: 10.0.0.11/24 | 00:10:F3:09:12:72
IP-Alias:  10.0.0.20/24 | depends where it ist bound to

lan:
Primary:   10.1.0.10/24 | 00:10:F3:10:11:71
Secondary: 10.1.0.11/24 | 00:10:F3:10:12:72
IP-Alias:  10.1.0.20/24 | depends where it ist bound to

3.) The Problem

First everything works fine. If I fail the primary node,
the secondary does the take over. The ARP-Entrys are
changing to the MAC of the secondary, and everything is
fine.

Now if you want to ping/ssh/somewhat the shared IP-Alias
in the LAN from the networks behind the C2600 everthing begins:

I.  The C2600 is able to deliver the IP-packet to the node because
    it has a valid arp-entry.

II. The Linux-machine (secondary) does not have any arp-entrys
    (because it was inactive for a while) so it has to initiate
    ARP before it can deliver the answer IP-packet.

Then IT HAPPENS:

The Linux Box asks in the transit net:

0.000000 10.1.0.20 -> Broadcast    ARP Who has 10.0.0.1?  Tell 10.1.0.20

Why does Linux make ARP-requests with SRC-IPs from a different subnet?
This can't be the expected behaviour... :(

BTW:
The C2600 is so "smart" to put an entry with
"10.1.0.20 -> 00:10:F3:09:12:72"
in its ARP-Cache, based on this single ARP-Broadcast
from 10.1.0.20 and after a failback to the primary nobody can reach the
10.1.0.20... :-)


4.) Solution: Dirty Userspace Fix
  Ping the C2600 from the primary/secondary infinitely.
  The same does a ping-group in heartbeat.
  This can't be the real truth... ;-)

5.) Solution: Dirty Kernel-Patch
  With my skillful hands I wrote a dirty hack:
<patch>
--- arp.c       Fri Jan 13 16:44:06 2006
+++ arp.c.new   Fri Jan 13 16:43:52 2006
@@ -342,9 +342,9 @@
   switch (IN_DEV_ARP_ANNOUNCE(in_dev)) {
   default:
   case 0:              /* By default announce any local IP */
-       if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
+       /* if (skb && inet_addr_type(skb->nh.iph->saddr) == RTN_LOCAL)
         saddr = skb->nh.iph->saddr;
-       break;
+       break; */
   case 1:              /* Restrict announcements of saddr in same subnet */
        if (!skb)
         break;
</patch>

6.) Solution: Clean Kernel-Patch
  Can anybody improve this patch above to a clean one so that it finds
  it way to the vanilla kernel?


bye
richard

-- 
Richard Müller
Geschäftsführer Technik

team(ix) GmbH
Powering Enterprise Linux Networks
Südwestpark 35
90449 Nürnberg

fon:   +49 (911) 30999- 0
fax:   +49 (911) 30999-99
mail:  rm@teamix.de
web:   http://www.teamix.de
vcf:   http://www.teamix.de/vcf/rm.vcf
gpg:   296C 0BAF 8FC8 DCE2 99BD
       5777 FA73 ECDC F9F1 8FF7

