Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVGIVCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVGIVCX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVGIVCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:02:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:49643 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261720AbVGIVCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:02:21 -0400
Date: Sat, 9 Jul 2005 22:57:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050709205713.GA32483@electric-eye.fr.zoreil.com>
References: <19494147.1120915523280.JavaMail.www@wwinf1505>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <19494147.1120915523280.JavaMail.www@wwinf1505>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> I don't receive Lars's results, but here are my results.

Lars can apparently not reproduce it any more. I'll consider this
issue fixed until it returns. Thanks for checking.

[ping test removed]
> # cat /proc/net/pktgen/eth0
> Params: count 10000000  min_pkt_size: 60  max_pkt_size: 60
>      frags: 0  delay: 0  clone_skb: 1000000  ifname: eth0
>      flows: 0 flowlen: 0
>      dst_min: 10.169.21.1  dst_max:
>      src_min:   src_max:
>      src_mac: 00:11:2F:E9:42:70  dst_mac: 00:40:F4:A8:70:BC
>      udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9  udp_dst_max: 9
>      src_mac_count: 0  dst_mac_count: 0
>      Flags: IPDST_RND
> Current:
>      pkts-sofar: 8699475  errors: 0
>      started: 1120913419217947us  stopped: 1120913484497743us idle: 0us
>      seq_num: 8699485  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
>      cur_saddr: 0x1515a90a  cur_daddr: 0x115a90a
>      cur_udp_dst: 9  cur_udp_src: 9
>      flows: 0
> Result: OK: 65279796(c65279796+d0) usec, 8699475 (60byte,0frags)
>   133264pps 63Mb/sec (63966720bps) errors: 0

Not too bad: it trashes data fast enough :o)

Can you do the same test but send the traffic from the host which
embeds the r8169 ?

The sis190 should not be responsive during the flow. I expect that it
will happily return to a normal state once the traffic stops.

If it behaves correctly, I'll send a first version for inclusion.

> "ethtool -s eth0 ..." does not freeze the station anymore, but
> "autoneg off" does not work properly :
> 
> # ethtool -s eth0 speed 10 duplex half autoneg off
> # ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: 10Mb/s
>         Duplex: Half
>         Port: MII
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: on
>         Current message level: 0x00000037 (55)
>         Link detected: yes
> # ethtool eth0
> Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: on
>         Current message level: 0x00000037 (55)
>         Link detected: yes
> 
> The values written in StationControl are probaly wrong,

One should expect some messages to appear in the log after you forced
the link at 10Mb/s. Do you notice anything in dmesg ?

I would be interested to know if the attached patch makes a difference
(the patch applies on top of the current driver).

Can you issue a simple 'ethtool -s eth0 autoneg off' and report what
happens ?

[html]

Sorry, it was just a notice for Lars

--
Ueimor

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis190-030.patch"


Do not update StationControl after the link was forced.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/net/sis190.c~sis190-030 drivers/net/sis190.c
--- linux-2.6.13-rc1-gitXX/drivers/net/sis190.c~sis190-030	2005-07-09 22:11:02.381627199 +0200
+++ linux-2.6.13-rc1-gitXX-romieu/drivers/net/sis190.c	2005-07-09 22:25:37.537549276 +0200
@@ -855,7 +855,7 @@ static void sis190_phy_task(void * data)
 			if ((val & p->val) == p->val)
 				break;
 		}
-		if (p->ctl)
+		if (!tp->mii_if.force_media && p->ctl)
 			SIS_W16(StationControl, p->ctl);
 		net_link(tp, KERN_INFO "%s: link on %s mode.\n", dev->name,
 			 p->msg);

_

--opJtzjQTFsWo+cga--
