Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUBJMgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUBJMgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:36:37 -0500
Received: from atlantis.knm.org.pl ([62.233.209.66]:49579 "EHLO
	atlantis.knm.org.pl") by vger.kernel.org with ESMTP id S265849AbUBJMgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:36:35 -0500
Date: Tue, 10 Feb 2004 13:36:32 +0100 (CET)
From: Dawid Kuroczko <qnex@atlantis.knm.org.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6: QoS scheduling not working with IP-over-IP
Message-ID: <Pine.LNX.4.44.0402101324350.810-100000@atlantis.knm.org.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

There seems to be a bug in QoS scheduling code related to IP-over-IP
tunnels (ipip.ko).  My setup is a bit unusual -- my default route
goes through tunl1, so I want it shaped.  It worked fine with 2.4,
but it doesn't with 2.6 (2.6.1 and 2.6.2, I made a transition quite
recently).

The simplest example is:

tc qdisc add dev tunl1 root prio

...executing this line will effect in no packet entering or leaving
device (as if device was down).  Just as soon as I do

tc qdisc del dev tunl1 root

...everything returns to normal.  And same problem applies to
HTB scheduler, though adding a qdisc doesn't result in such
packet freeze.  But as soon as some class is added, all packets
matching that class "freeze".  A simple example would be:

# everything is OK here
tc qdisc add dev tunl1 handle 1:  root htb default 9 r2q 1
# ...and so is here...
tc class add dev tunl1 parent 1:1 classid 1:9 htb rate 2mbit ceil 2mbit
# ...oops, packets are blocked, until you remove this class or qdisc.

If that is of any help, I set up the tunnel like this:

ip tunnel add tunl1 mode ipip local 192.168.4.55 remote 192.168.1.1
ip addr add 11.22.33.44/32 dev tunl1
ip link set tunl1 up
ip route add default src 11.22.33.44 dev tunl1

Also, SFQ and RED appear immune to this problem.

  Regards,
   Dawid

PS: 2.6.2 kernel on 2 x Pentium-III SMP system, unpatched, QoS
(prio, sfq, red) compiled as modules.

