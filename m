Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKITgv>; Thu, 9 Nov 2000 14:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQKITgm>; Thu, 9 Nov 2000 14:36:42 -0500
Received: from [62.254.209.2] ([62.254.209.2]:4085 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129251AbQKITgY>;
	Thu, 9 Nov 2000 14:36:24 -0500
Date: Thu, 9 Nov 2000 19:36:23 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: <linux-kernel@vger.kernel.org>
Subject: Missing ACKs with Linux 2.2/2.4?
Message-ID: <Pine.LNX.4.30.0011091902530.31452-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been experiencing some very strange network behaviour under various
versions of Linux, which can be provoked by just sending small amounts
of data to the echo port on a server.

The server is a Cobalt RAQ-3i (AMD-K6, kernel claims to be 2.2.12C3)
While I can only recreate the behaviour using this as a server, tcp
dumps of the network traffic seem to point the finger of blame at Linux
when it is a client.

The client machines are running 'cat text | nc cobalt-box 7'. "Text" is
a 8679 byte file.

The problem: several versions of the Linux kernel seem to be not sending
ACKs correctly to the server, causing a three second delay in reading
the text file back from the echo port. Other UNIX platforms get the data
back instantly (I've tried Solaris, FreeBSD, Digital UNIX and IRIX).
Linux 2.0.36 doesn't seem to show the problem. Linux 2.2.5, 2.2.13,
2.4.0-test10 do.

Heres a trace of the problem: the client here, hydra, is a Redhat 6 box,
with a 2.2.5 kernel. (tcpdump running on hydra)


10:10:15.842522 hydra.3700 > cobalt-box.echo: S 2004401205:2004401205(0) win 32120 <mss 1460,sackOK,timestamp 268081751[|tcp]> (DF)
10:10:15.842703 cobalt-box.echo > hydra.3700: S 605846935:605846935(0) ack 2004401206 win 32120 <mss 1460,sackOK,timestamp 15607468[|tcp]> (DF)
10:10:15.842744 hydra.3700 > cobalt-box.echo: . ack 1 win 32120 <nop,nop,timestamp 268081751 15607468> (DF)
10:10:15.843688 hydra.3700 > cobalt-box.echo: . 1:1449(1448) ack 1 win 32120 <nop,nop,timestamp 268081751 15607468> (DF)
10:10:15.844251 cobalt-box.echo > hydra.3700: . ack 1449 win 31856 <nop,nop,timestamp 15607468 268081751> (DF)
10:10:15.844299 hydra.3700 > cobalt-box.echo: . 1449:2897(1448) ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.844310 hydra.3700 > cobalt-box.echo: . 2897:4345(1448) ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845002 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 1449 win 31856 <nop,nop,timestamp 0 268081751> (DF)
10:10:15.845050 hydra.3700 > cobalt-box.echo: . ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845009 cobalt-box.echo > hydra.3700: . ack 4345 win 30408 <nop,nop,timestamp 15607468 268081752> (DF)
10:10:15.845076 hydra.3700 > cobalt-box.echo: . 4345:5793(1448) ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845090 hydra.3700 > cobalt-box.echo: . 5793:7241(1448) ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845101 hydra.3700 > cobalt-box.echo: FP 7241:8680(1439) ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845773 cobalt-box.echo > hydra.3700: P 1449:2897(1448) ack 4345 win 31856 <nop,nop,timestamp 0 268081752> (DF)
10:10:15.845820 hydra.3700 > cobalt-box.echo: . ack 1 win 32120 <nop,nop,timestamp 268081752 15607468> (DF)
10:10:15.845780 cobalt-box.echo > hydra.3700: . ack 7241 win 30408 <nop,nop,timestamp 15607468 268081752> (DF)
10:10:15.845869 cobalt-box.echo > hydra.3700: . ack 8681 win 30408 <nop,nop,timestamp 15607469 268081752> (DF)
10:10:18.836367 cobalt-box.echo > hydra.3700: P 1:1449(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268081752> (DF)
10:10:18.836421 hydra.3700 > cobalt-box.echo: . ack 1449 win 31856 <nop,nop,timestamp 268082051 15607768> (DF)
10:10:18.836961 cobalt-box.echo > hydra.3700: P 1449:2897(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268082051> (DF)
10:10:18.844490 hydra.3700 > cobalt-box.echo: . ack 2897 win 31856 <nop,nop,timestamp 268082052 15607768> (DF)
10:10:18.845024 cobalt-box.echo > hydra.3700: P 2897:4345(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268082052> (DF)
10:10:18.845148 cobalt-box.echo > hydra.3700: P 4345:5793(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268082052> (DF)
10:10:18.845202 hydra.3700 > cobalt-box.echo: . ack 5793 win 30408 <nop,nop,timestamp 268082052 15607768> (DF)
10:10:18.845280 cobalt-box.echo > hydra.3700: P 5793:7241(1448) ack 8681 win 31856 <nop,nop,timestamp 15607768 268082052> (DF)
10:10:18.845400 cobalt-box.echo > hydra.3700: FP 7241:8680(1439) ack 8681 win 31856 <nop,nop,timestamp 15607768 268082052> (DF)
10:10:18.845446 hydra.3700 > cobalt-box.echo: . ack 8681 win 28960 <nop,nop,timestamp 268082052 15607768> (DF)

27 packets received by filter
0 packets dropped by kernel


Note the three second delay! From my reading of this, hydra never ACKs
any of the data received from the server prior to the delay. Only when
the server re-sends the first 1448 bytes after a three second timeout,
does it decide to ACK it. hydra does however seem to send out two
identical 'ack 1' packets. Has the second one got the wrong number in
it?

Any ideas whats going on? I'm no expert at reading tcpdumps, if anyone
can shed some light on the problem, I'd be most greatful.


Cheers,
Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
