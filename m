Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbQKJLtp>; Fri, 10 Nov 2000 06:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQKJLt0>; Fri, 10 Nov 2000 06:49:26 -0500
Received: from [62.254.209.2] ([62.254.209.2]:55545 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129392AbQKJLtQ>;
	Fri, 10 Nov 2000 06:49:16 -0500
Date: Fri, 10 Nov 2000 11:49:13 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <200011101012.CAA11999@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0011101116580.11412-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, heres more headache-inducing tcpdumps to look at :)
None of the error counters which you suggested to look at seem to
increase, on either end. I've found that everything works OK if the data
sent to the echo port fits into a single packet. Otherwise, we get the
apparently missing acks and the delays seen here.

To complicate (help?) matters, I've managed to get a trace from both
ends when it once mysteriously worked! I can't reproduce this, though.
Also, to keep stuff up to date, the traces below are running with a
2.4.0-test10 client, artemis.

First of all: the broken, delayed connection:

(client-side tcpdump)
11:05:32.540009 artemis.39061 > cobalt-box.echo: S 2264214878:2264214878(0) win 5840 <mss 1460,sackOK,timestamp 76152422[|tcp]> (DF)
11:05:32.540349 cobalt-box.echo > artemis.39061: S 2249548214:2249548214(0) ack 2264214879 win 32120 <mss 1460,sackOK,timestamp 24578676[|tcp]> (DF)
11:05:32.540417 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.543134 artemis.39061 > cobalt-box.echo: . 1:1449(1448) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.543155 artemis.39061 > cobalt-box.echo: P 1449:1601(152) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.543580 artemis.39061 > cobalt-box.echo: F 1601:1601(0) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.544908 cobalt-box.echo > artemis.39061: . ack 1449 win 31856 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.544969 cobalt-box.echo > artemis.39061: . ack 1602 win 31703 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.547518 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
11:05:32.547703 cobalt-box.echo > artemis.39061: FP 1449:1601(152) ack 1602 win 31856 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.557370 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152424 24578676> (DF)
11:05:32.557441 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152424 24578676,nop,nop,[|tcp]> (DF)
11:05:35.539956 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 24578976 76152424> (DF)
11:05:35.540076 artemis.39061 > cobalt-box.echo: . ack 1602 win 8688 <nop,nop,timestamp 76152722 24578976,nop,nop,[|tcp]> (DF)

(server-side)
11:05:32.431950 artemis.39061 > cobalt-box.echo: S 2264214878:2264214878(0) win 5840 <mss 1460,sackOK,timestamp 76152422[|tcp]> (DF)
11:05:32.431995 cobalt-box.echo > artemis.39061: S 2249548214:2249548214(0) ack 2264214879 win 32120 <mss 1460,sackOK,timestamp 24578676[|tcp]> (DF)
11:05:32.432345 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.436493 artemis.39061 > cobalt-box.echo: . 1:1449(1448) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.436559 cobalt-box.echo > artemis.39061: . ack 1449 win 31856 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.436509 artemis.39061 > cobalt-box.echo: P 1449:1601(152) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.436517 artemis.39061 > cobalt-box.echo: F 1601:1601(0) ack 1 win 5840 <nop,nop,timestamp 76152422 24578676> (DF)
11:05:32.436602 cobalt-box.echo > artemis.39061: . ack 1602 win 31703 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.437733 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
11:05:32.438918 cobalt-box.echo > artemis.39061: FP 1449:1601(152) ack 1602 win 31856 <nop,nop,timestamp 24578676 76152422> (DF)
11:05:32.449304 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152424 24578676> (DF)
11:05:32.449394 artemis.39061 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76152424 24578676,nop,nop,[|tcp]> (DF)
11:05:35.430026 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 24578976 76152424> (DF)
11:05:35.431885 artemis.39061 > cobalt-box.echo: . ack 1602 win 8688 <nop,nop,timestamp 76152722 24578976,nop,nop,[|tcp]> (DF)


And the working connection:

(client-side tcpdump)
11:05:22.483983 artemis.39059 > cobalt-box.echo: S 2257051654:2257051654(0) win 5840 <mss 1460,sackOK,timestamp 76151416[|tcp]> (DF)
11:05:22.484329 cobalt-box.echo > artemis.39059: S 2239718876:2239718876(0) ack 2257051655 win 32120 <mss 1460,sackOK,timestamp 24577670[|tcp]> (DF)
11:05:22.484391 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151416 24577670> (DF)
11:05:22.489099 artemis.39059 > cobalt-box.echo: . 1:1449(1448) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.489127 artemis.39059 > cobalt-box.echo: P 1449:1601(152) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.489476 artemis.39059 > cobalt-box.echo: F 1601:1601(0) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.490861 cobalt-box.echo > artemis.39059: . ack 1449 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.492599 cobalt-box.echo > artemis.39059: P 1:1449(1448) ack 1449 win 31856 <nop,nop,timestamp 0 76151417> (DF)
11:05:22.492660 cobalt-box.echo > artemis.39059: . ack 1602 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.492910 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151417 24577671> (DF)
11:05:22.493168 cobalt-box.echo > artemis.39059: FP 1449:1601(152) ack 1602 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.501147 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151418 24577671,nop,nop,[|tcp]> (DF)
11:05:22.502903 cobalt-box.echo > artemis.39059: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 24577672 76151418> (DF)
11:05:22.506750 artemis.39059 > cobalt-box.echo: . ack 1602 win 8688 <nop,nop,timestamp 76151419 24577672,nop,nop,[|tcp]> (DF)

(server-side)
11:05:22.376433 artemis.39059 > cobalt-box.echo: S 2257051654:2257051654(0) win 5840 <mss 1460,sackOK,timestamp 76151416[|tcp]> (DF)
11:05:22.376493 cobalt-box.echo > artemis.39059: S 2239718876:2239718876(0) ack 2257051655 win 32120 <mss 1460,sackOK,timestamp 24577670[|tcp]> (DF)
11:05:22.376838 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151416 24577670> (DF)
11:05:22.382971 artemis.39059 > cobalt-box.echo: . 1:1449(1448) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.383035 cobalt-box.echo > artemis.39059: . ack 1449 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.383329 cobalt-box.echo > artemis.39059: P 1:1449(1448) ack 1449 win 31856 <nop,nop,timestamp 0 76151417> (DF)
11:05:22.383426 artemis.39059 > cobalt-box.echo: P 1449:1601(152) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.383467 artemis.39059 > cobalt-box.echo: F 1601:1601(0) ack 1 win 5840 <nop,nop,timestamp 76151417 24577670> (DF)
11:05:22.383513 cobalt-box.echo > artemis.39059: . ack 1602 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.384631 cobalt-box.echo > artemis.39059: FP 1449:1601(152) ack 1602 win 31856 <nop,nop,timestamp 24577671 76151417> (DF)
11:05:22.385584 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151417 24577671> (DF)
11:05:22.393606 artemis.39059 > cobalt-box.echo: . ack 1 win 5840 <nop,nop,timestamp 76151418 24577671,nop,nop,[|tcp]> (DF)
11:05:22.393643 cobalt-box.echo > artemis.39059: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 24577672 76151418> (DF)
11:05:22.399212 artemis.39059 > cobalt-box.echo: . ack 1602 win 8688 <nop,nop,timestamp 76151419 24577672,nop,nop,[|tcp]> (DF)

No packets seem to be lost on either end.
I hope this is of some help! If theres any more information needed, let
me know...


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
