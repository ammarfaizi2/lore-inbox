Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbQKGFst>; Tue, 7 Nov 2000 00:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbQKGFsj>; Tue, 7 Nov 2000 00:48:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61569 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130214AbQKGFs1>;
	Tue, 7 Nov 2000 00:48:27 -0500
Date: Mon, 6 Nov 2000 21:33:25 -0800
Message-Id: <200011070533.VAA02179@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jordy@napster.com
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <3A079127.47B2B14C@napster.com> (message from Jordan Mendelson on
	Mon, 06 Nov 2000 21:20:39 -0800)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 06 Nov 2000 21:20:39 -0800
   From: Jordan Mendelson <jordy@napster.com>

   It looks to me like there is an artificial delay in 2.4.0 which is
   slowing down the traffic to unbearable levels. 

No, I think I see whats wrong, it's nothing more than packet drop.

The large gaps in time seem to be due to packets being dropped:

22:00:39.991515 64.124.41.179.8888 > 209.179.245.186.1092: P 1:21(20) ack 44 win 5840 (DF)
22:00:39.991660 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 44 win 5840 (DF)

3 seconds pass, retransmit time out.

22:00:42.991490 64.124.41.179.8888 > 209.179.245.186.1092: P 1:21(20) ack 44 win 5840 (DF)

Linux retransmits dropped data.

22:00:43.180946 209.179.245.186.1092 > 64.124.41.179.8888: P 44:56(12) ack 21 win 65260 (DF)

Windows95 responds, acknowledges up to byte 21.

22:00:43.180997 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 44 win 5840 (DF)
22:00:43.181025 64.124.41.179.8888 > 209.179.245.186.1092: P 557:1093(536) ack 56 win 5840 (DF)
22:00:45.685143 209.179.245.186.1092 > 64.124.41.179.8888: P 44:456(412) ack 21 win 65260 (DF)

Linux resends bytes 21:556 and sends new data from 557:1093.
Windows95 sends new data and ACKs only up to 21 (meaning presumably
that all bytes sent by Linux this time were dropped).

22:00:45.685204 64.124.41.179.8888 > 209.179.245.186.1092: . ack 456 win 6432 <nop,nop, sack 1 {44:56} > (DF)

Linux acknowledges data received from Windows95 machine.
A retransmit timeout occurs on the lost data.

22:00:49.171046 64.124.41.179.8888 > 209.179.245.186.1092: P 21:557(536) ack 456 win 6432 (DF)
22:00:49.470193 209.179.245.186.1092 > 64.124.41.179.8888: . ack 557 win 65280 (DF)

Linux resends 21:557, Windows95 (finally) acknowledges it.

Looking at the equivalent 220 traces, the only difference appears to
be that the packets are not getting dropped.

Alexey, do you have any other similar reports wrt. the new MSS
advertisement scheme in 2.4.x?

Jordan, you mentioned something about possibly being "bandwidth
limited"?  Please, elaborate...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
