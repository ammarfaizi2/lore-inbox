Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTKIE2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 23:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTKIE2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 23:28:24 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:39812 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S262174AbTKIE2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 23:28:22 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PATCH for 2.4.23-pre4 and up hang on one system
Date: Sat, 8 Nov 2003 18:27:28 -1000
User-Agent: KMail/1.5.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200311081341.38553.beau@beaucox.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

submitted Sat Nov  8 13:08:55 HST 2003 by Beau E. Cox <beau@beaucox.com>

[1.] One line summary of the problem:

Patch that fixes my problem:
Starting with 2.4.23-pre4 my system hangs during startup and/or is
generally unstable (see patch in [ X. ] below.)

[2.] Full description of the problem/report:

Origionally I had catagorized this problem with the startup sequence;
the system always seemed to hang when squid was started before
mysql, etc. Moving squid near the end of the startup process, I
thought the problem was in hand. However, the system (pre9) proved
unstable (would not stay up for longer than one day.)

The problem exhibits itself with a solid 'hang'; no oops, no dumps,
nada.

[ 3. ] - [ 7. ]

See previous posting; no hardware or configuration changes.

[X.] Other notes, patches, fixes, workarounds:

This patch to net/ipv4/netfilter/ip_nat_core.c fixed my problem
in all 2.4.23 versions pre4 - pre9:

--- linux-2.4.23-pre4/net/ipv4/netfilter/ip_nat_core.c	2003-11-08 
03:01:59.000000000 -1000
+++ linux-2.4.23-pre3/net/ipv4/netfilter/ip_nat_core.c	2003-11-08 
03:00:47.000000000 -1000
@@ -157,8 +157,8 @@
 				continue;
 		}
 
-		if (!(mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
-		    || proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
+		if ((mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
+		    && proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
 				       &mr->range[i].min, &mr->range[i].max))
 			return 1;
 	}

It is simply a rollback of changes to ip_nat_core.c made in
pre4.

Since my patch is to ip_nat_core.c, I should mention that I use
NAT via iptables. Here is an the relevant section if my iptables
startup script:

[...]
# setup nat
echo "  applying nat rules"
echo ""
$iptables -F FORWARD
$iptables -F -t nat
$iptables -P FORWARD DROP
$iptables -A FORWARD -i eth0 -j ACCEPT
$iptables -A INPUT -i eth0 -j ACCEPT
$iptables -A OUTPUT -o eth0 -j ACCEPT
$iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
$iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j SNAT --to-source 
x.x.x.x
[...]

All the information I can think of relating to this problem is at:

ftp://beaucox.com/pub/kernel/2.4.23-pre4-bug

Please see the README file.

---------------------------WARNING--------------------------
I am NOT a kernel programmer. The patch above was arrived at
by hit-or-miss. I REALLY don't know what I am doing (but
my system works now!)
---------------------------WARNING--------------------------

Aloha => Beau;

PS: Please let me know if you need more information.



