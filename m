Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSGMQXf>; Sat, 13 Jul 2002 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSGMQXe>; Sat, 13 Jul 2002 12:23:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53765 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315198AbSGMQXd>; Sat, 13 Jul 2002 12:23:33 -0400
Date: Sat, 13 Jul 2002 12:21:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG?] unwanted proxy arp in 2.4.19-pre10
Message-ID: <Pine.LNX.3.96.1020713121946.14953A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there's a bug, or at least unexpected behaviour in 2.4.19-pre10
regarding ARP replies. I am getting multiple arp-replies to a who-has
request, and there seems to be no check in arp.c to verify that the
interface used for an arp reply actually has that address or has proxy
set.

Details:


     node_A 192.168.230.1              router
                |       \               192.168.231.127
		|	 \		192.168.0.0/16 access
                |      bridge            /
                |           \           /
                |            \         /
          192.168.230.4      192.168.231.4
                       \      /
                        node_B


When node_A does an arp request, who-has 192.168.230.4, it gets a
correct answer from the NIC with that IP. It also gets a reply from the
NIC on the 192.168.231 IP, because the ARP broadcast was bridged to that
NIC and there's no check to see if that NIC actually has the IP in
question. Since the networks are bridged for the moment, the 2nd reply
also arrives, later, and winds up in the arp table on node_A, where it
results in all traffic going through the bridge to the wrong NIC.

In the absense of the proxy_arp flag, I would not expect that reply,
the IP is not on that NIC. Before I "fix" that, is this intended
behaviour for some reason? Will I break something if I add check logic?
Is there something in /proc/sys/net/ipv4 I missed which will avoid this
response?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

