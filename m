Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSDMKXB>; Sat, 13 Apr 2002 06:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSDMKXA>; Sat, 13 Apr 2002 06:23:00 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:46990 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S312410AbSDMKW7>; Sat, 13 Apr 2002 06:22:59 -0400
To: linux-kernel@vger.kernel.org
From: public@dgmo.org
Subject: Very trace tcp issue on 2.2.19
Date: 13 Apr 2002 20:22:53 +1000
In-Reply-To: Steven Whitehouse's message of "Sun, 24 Mar 2002 20:16:38 +0000 (GMT)"
Message-ID: <m1sn5zq4n6.fsf@mo.optusnet.com.au>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got an app (backup program) writing large
quantities over data over a TCP connection from
one 2.2.19 kernel to another.

My problem is that after a while, the connection simply
hangs. The application on the local side is sleeping
in read(), netstat on the local side show an empty
receive Q.

Netstat on the remote site show a large send Q:

Proto Recv-Q Send-Q Local Address           Foreign Address         State       Timer
tcp        0  39308 remote:33149            remote:2989 ESTABLISHED on (51.97/11/0)


The remote side is continually re-sending the next packet
which the local machine utterly ignores.

Here's a tcp dump from the local machine:

19:50:01.857439 < remote.33149 > local.afm: P 120184:121632(1448) ack 35 win 32120
19:50:01.857561 < remote.33149 > local.afm: P 121632:123080(1448) ack 36 win 32120
19:50:01.857683 < remote.33149 > local.afm: P 123080:124528(1448) ack 36 win 32120
19:50:01.857808 < remote.33149 > local.afm: P 124528:125976(1448) ack 36 win 32120
19:50:01.857870 > local.afm > remote.33149: P 36:41(5) ack 120184 win 31856

#1. Why didn't it ack the 125976 instead of 120184? It clearly
received the 120184 packet and it was inside the window. Why didn't it
ack it? remember, this is tcpdump running on the _local_ machine. 

19:50:01.857930 < remote.33149 > local.afm: P 125976:127424(1448) ack 36 win 32120
19:50:01.857960 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858054 < remote.33149 > local.afm: P 127424:128872(1448) ack 36 win 32120
19:50:01.858090 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858226 < remote.33149 > local.afm: P 128872:130320(1448) ack 41 win 32120
19:50:01.858259 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858351 < remote.33149 > local.afm: P 130320:131768(1448) ack 41 win 32120
19:50:01.858379 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858473 < remote.33149 > local.afm: P 131768:133216(1448) ack 41 win 32120
19:50:01.858501 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858595 < remote.33149 > local.afm: P 133216:134664(1448) ack 41 win 32120
19:50:01.858623 > local.afm > remote.33149: . 41:41(0) ack 120184 win 31856
19:50:01.858721 < remote.33149 > local.afm: P 120184:121632(1448) ack 41 win 32120

We see the remote machine finally re-send 120184. Why did it
need to do that!?

19:50:01.858752 > local.afm > remote.33149: . 41:41(0) ack 121632 win 30408
19:50:01.858803 > local.afm > remote.33149: P 41:42(1) ack 121632 win 30408
19:50:01.858845 < remote.33149 > local.afm: P 134664:136112(1448) ack 41 win 32120
19:50:01.858871 > local.afm > remote.33149: . 42:42(0) ack 121632 win 30408
19:50:01.858963 < remote.33149 > local.afm: P 136112:137560(1448) ack 41 win 32120
19:50:01.858993 > local.afm > remote.33149: . 42:42(0) ack 121632 win 30408
19:50:01.859085 < remote.33149 > local.afm: P 121632:123080(1448) ack 41 win 32120
19:50:01.859112 > local.afm > remote.33149: . 42:42(0) ack 123080 win 28960
19:50:01.859211 < remote.33149 > local.afm: P 123080:124528(1448) ack 41 win 32120
19:50:01.859256 > local.afm > remote.33149: . 42:42(0) ack 137560 win 24616
19:50:01.859335 < remote.33149 > local.afm: P 137560:139008(1448) ack 41 win 32120
19:50:01.859459 < remote.33149 > local.afm: P 139008:140456(1448) ack 41 win 32120
19:50:01.859485 > local.afm > remote.33149: . 42:42(0) ack 140456 win 27512
19:50:01.859865 > local.afm > remote.33149: . 45:45(0) ack 144800 win 24616
19:50:01.860117 > local.afm > remote.33149: . 45:45(0) ack 144800 win 24616
19:50:01.860236 > local.afm > remote.33149: . 45:45(0) ack 144800 win 24616
19:50:01.860360 > local.afm > remote.33149: . 45:45(0) ack 144800 win 24616
19:50:01.860946 < remote.33149 > local.afm: P 144800:146248(1448) ack 45 win 32120
19:50:01.861437 < remote.33149 > local.afm: . 160728:162176(1448) ack 46 win 32120
19:50:01.861560 < remote.33149 > local.afm: P 162176:163624(1448) ack 49 win 32120
19:50:01.861847 > local.afm > remote.33149: . 49:49(0) ack 144800 win 26064
19:50:01.861941 < remote.33149 > local.afm: P 166520:167968(1448) ack 49 win 32120
19:50:01.862192 < remote.33149 > local.afm: P 157832:159280(1448) ack 49 win 32120
19:50:01.862313 < remote.33149 > local.afm: P 169416:170864(1448) ack 49 win 32120
19:50:02.060443 < remote.33149 > local.afm: P 144800:146248(1448) ack 49 win 32120
19:50:02.460445 < remote.33149 > local.afm: P 144800:146248(1448) ack 49 win 32120
19:50:02.460480 > local.afm > remote.33149: . 49:49(0) ack 169416 win 18824
19:50:02.460540 > local.afm > remote.33149: P 49:50(1) ack 169416 win 18824
19:50:02.460846 < remote.33149 > local.afm: P 169416:170864(1448) ack 49 win 32120
19:50:02.480221 < remote.33149 > local.afm: . 170864:170864(0) ack 50 win 32120
19:50:02.480271 > local.afm > remote.33149: P 50:58(8) ack 169416 win 31856

Again, it's already received 170864. Why didn't it ack that?

19:50:02.500217 < remote.33149 > local.afm: . 170864:170864(0) ack 58 win 32120
19:50:02.740450 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:03.300445 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:04.420448 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:06.660454 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:11.140494 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:20.100516 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:50:38.191149 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:51:14.031209 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:52:25.711371 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120
19:54:25.711600 < remote.33149 > local.afm: P 169416:170864(1448) ack 58 win 32120

Remote machine times out waiting for an ack which never comes. Local machine
continually ignores the packet it's supposed to be waiting for!

No firewall on local machine. /sbin/ipchains -F run just in case.
eepro100 ethernet card. 512Meg of ram, not close to running low.  (At
this point, the machine actually has 400Meg free, not cache/buffers
cos it was just rebooted). Netstat on local side size receive Q is
zero. Remote send has large send Q.

I keep feeling I'm missing something basic, but I just
can't see it!
