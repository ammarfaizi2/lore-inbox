Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133112AbRAQLcw>; Wed, 17 Jan 2001 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135213AbRAQLcm>; Wed, 17 Jan 2001 06:32:42 -0500
Received: from nella-gw.infonet.cz ([212.71.152.17]:41221 "EHLO
	mite.infonet.cz") by vger.kernel.org with ESMTP id <S133112AbRAQLcd>;
	Wed, 17 Jan 2001 06:32:33 -0500
Message-ID: <3A6582BE.E453ED18@infonet.cz>
Date: Wed, 17 Jan 2001 12:32:14 +0100
From: Marian Jancar <marian.jancar@infonet.cz>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1-pre8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CBQ clases
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im trying to create bounded class with two bouded childs, each one
having more than half bandwidth of their parent, whoose bandwidth they
should share, which sadly doesnt happen, when I tcpspray through both
childs in the same time, each one uses its full bandwidth, what is of
course togeather more, than bandwidth of their parent. Any suggesstions
wellcome.

tc qdisc add dev eth0 root handle 1: cbq bandwidth 10Mbit allot 1514
cell 8 avpkt 1000

#*******trida 64Kbit**********
tc class add dev eth0 parent 1:0 classid 1:200 cbq bandwidth 10Mbit rate
64Kbit allot 1514 cell 8 avpkt 1000 maxburst 20 weight 6Kbit prio 5
bounded

#*******trida 48Kbit**********
tc class add dev eth0 parent 1:200 classid 1:210 cbq bandwidth 10Mbit
rate 48Kbit allot 1514 cell 8 avpkt 1000 maxburst 20 weight 5Kbit prio 5
bounded
#tc qdisc add dev eth0 parent 1:210 red bandwidth 48Kbit min 4500 max
9000 limit 18000 avpkt 1000 burst 5 probability 0.02

#*******trida 48Kbit*********
tc class add dev eth0 parent 1:200 classid 1:220 cbq bandwidth 10Mbit
rate 48Kbit allot 1514 cell 8 avpkt 1000 maxburst 20 weight 5Kbit prio 5
bounded
#tc qdisc add dev eth0 parent 1:220 red bandwidth 48Kbit min 4500 max
9000 limit 18000 avpkt 1000 burst 5 probability 0.02

#Filtry
tc filter add dev eth0 parent 1:0 prio 5 protocol ip u32
tc filter add dev eth0 parent 1:0 prio 5 u32 divisor 256

tc filter add dev eth0 parent 1:0 prio 5 u32 match ip dst 10.0.0.2
flowid 1:210
tc filter add dev eth0 parent 1:0 prio 5 u32 match ip dst 10.0.0.3
flowid 1:220
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
