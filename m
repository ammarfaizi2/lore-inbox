Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbRFEDtI>; Mon, 4 Jun 2001 23:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbRFEDs6>; Mon, 4 Jun 2001 23:48:58 -0400
Received: from ns1.netbauds.net ([194.207.240.11]:21252 "EHLO ns1.netbauds.net")
	by vger.kernel.org with ESMTP id <S263159AbRFEDsm>;
	Mon, 4 Jun 2001 23:48:42 -0400
Message-ID: <3B1C5682.6BBD40BC@netbauds.net>
Date: Tue, 05 Jun 2001 04:48:18 +0100
From: Darryl Miles <darryl@netbauds.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TCP Connection lockup between 2.4.0 and 2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


10.0.0.218 = Linux 2.4.0 SMP (tcp_timestamps, tcp_window_scaling and
tcp_sack all turned off, this doesn't appear to be relevant, since the
problem is just the same when they are turned on).
10.0.0.219 = Linux 2.4.5 UP

It appears the .218 end stops ACKing, even though it is obviously seeing
the data come in, since the TCPDUMP is from the .218 host.  I've been
running 2.4.0 on 10.0.0.218 since 9th Jan and can't believe that this
problem is a bug in 2.4.0, since it was speaking with the .219 box all
this time until I recently updated the .219 end from 2.0.32 to 2.4.5
over last weekend.

These are the only two linux boxes on the LAN, so this is the first time
two 2.4.x boxes have been talking to each other at LAN speeds, both
boxes have had full access to the Internet at dialup speeds all though
this year (using a non NAT connection, the 10.x.x.x addrs aren't what
they really operate as).


I did get an inconsistant tcpdump when taken from the .219 end, in that
the entries marked with '*' (which I have added a blank line around
below) are actually reported like the following (note this is from a
DIFFERENT session, NOT the same one as the larger dump below):

02:38:37.162128 0:20:af:52:3d:17 0:50:da:8a:4c:80 0800 1514:
10.0.0.219.119 > 10.0.0.218.2226: P 3113:4313(1200) ack 46 win 5792
<nop,nop,timestamp 1008848 4586969> (DF)
02:38:37.172128 0:20:af:52:3d:17 0:50:da:8a:4c:80 0800 1514:
10.0.0.219.119 > 10.0.0.218.2226: P 3113:4313(1200) ack 46 win 5792
<nop,nop,timestamp 1008848 4586969> (DF)
02:38:37.172128 0:20:af:52:3d:17 0:50:da:8a:4c:80 0800 1266:
10.0.0.219.119 > 10.0.0.218.2226: P 3113:4313(1200) ack 46 win 5792
<nop,nop,timestamp 1008848 4586969> (DF)

Notice the difference in ethernet frame length and TCP segment length. 
>From the other end everything looks normal, as in the 1st packet is
"217:1665(1448)", 2nd packet is "1665:3113(1448)" and last is
"3113:4313(1200)". It is like tcpdump got a hold of the last packet and
repeated it 3 times, and somehow missed being able to sniff the first
two.  So what tcpdump reports from the .219 end isn't what .218 actually
sees on the wire.



This dump from the .218 end:

02:50:42.549261 10.0.0.218.2296 > 10.0.0.219.119: S
1468859836:1468859836(0) win 5840 <mss 1460> (DF)
02:50:42.551250 10.0.0.219.119 > 10.0.0.218.2296: S
1410961156:1410961156(0) ack 1468859837 win 5840 <mss 1460> (DF
02:50:42.551462 10.0.0.218.2296 > 10.0.0.219.119: . ack 1 win 5840 (DF)
02:50:42.741803 10.0.0.219.119 > 10.0.0.218.2296: P 1:108(107) ack 1 win
5840 (DF)
02:50:42.741925 10.0.0.218.2296 > 10.0.0.219.119: . ack 108 win 5840
(DF)
02:50:42.742347 10.0.0.218.2296 > 10.0.0.219.119: P 1:14(13) ack 108 win
5840 (DF)
02:50:42.744136 10.0.0.219.119 > 10.0.0.218.2296: . ack 14 win 5840 (DF)
02:50:42.761240 10.0.0.219.119 > 10.0.0.218.2296: P 108:117(9) ack 14
win 5840 (DF)
02:50:42.772263 10.0.0.218.2296 > 10.0.0.219.119: P 14:21(7) ack 117 win
5840 (DF)
02:50:42.779999 10.0.0.219.119 > 10.0.0.218.2296: P 117:160(43) ack 21
win 5840 (DF)
02:50:42.784379 10.0.0.218.2296 > 10.0.0.219.119: P 21:40(19) ack 160
win 5840 (DF)
02:50:42.795936 10.0.0.219.119 > 10.0.0.218.2296: P 160:217(57) ack 40
win 5840 (DF)
02:50:42.799369 10.0.0.218.2296 > 10.0.0.219.119: P 40:46(6) ack 217 win
5840 (DF)
02:50:42.832749 10.0.0.219.119 > 10.0.0.218.2296: . ack 46 win 5840 (DF)

* 02:50:42.846780 10.0.0.219.119 > 10.0.0.218.2296: . 217:1677(1460) ack
46 win 5840 (DF)

02:50:42.846975 10.0.0.218.2296 > 10.0.0.219.119: . ack 1677 win 8760
(DF)

* 02:50:42.849085 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460)
ack 46 win 5840 (DF)
* 02:50:42.851092 10.0.0.219.119 > 10.0.0.218.2296: P 3137:4313(1176)
ack 46 win 5840 (DF)

02:50:42.851279 10.0.0.218.2296 > 10.0.0.219.119: . ack 1677 win 8760
(DF)
02:50:42.858301 10.0.0.219.119 > 10.0.0.218.2296: . 4313:5773(1460) ack
46 win 5840 (DF)
02:50:42.859679 10.0.0.218.2296 > 10.0.0.219.119: . ack 1677 win 8760
(DF)
02:50:42.860612 10.0.0.219.119 > 10.0.0.218.2296: . 5773:7233(1460) ack
46 win 5840 (DF)
02:50:42.867351 10.0.0.219.119 > 10.0.0.218.2296: . 7233:8693(1460) ack
46 win 5840 (DF)
02:50:42.867523 10.0.0.218.2296 > 10.0.0.219.119: . ack 1677 win 8760
(DF)
02:50:42.871097 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)
02:50:43.074807 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)
02:50:43.494738 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)
02:50:44.334641 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)
02:50:46.014434 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)
02:50:49.374022 10.0.0.219.119 > 10.0.0.218.2296: . 1677:3137(1460) ack
46 win 5840 (DF)


-- 
Darryl Miles
