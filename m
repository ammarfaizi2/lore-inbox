Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAXUeY>; Wed, 24 Jan 2001 15:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130748AbRAXUeE>; Wed, 24 Jan 2001 15:34:04 -0500
Received: from colorfullife.com ([216.156.138.34]:23558 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130407AbRAXUeB>;
	Wed, 24 Jan 2001 15:34:01 -0500
Message-ID: <3A6F3C4A.27E148E9@colorfullife.com>
Date: Wed, 24 Jan 2001 21:34:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <200101242003.XAA21040@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, Linux is __very__ not right doing this. RFC requires to accept
> ACK, URG and RST on any segment adjacent to window, even if window
> is zero.
> 
Interesting: I checked the RFC 793 and came to the conclusion that Linux
is correct. ("special allowance should be made to accept valid ACKs" not
must be). Is there another RFC?

Note that either segment length is > 0 or SEG.SEQ != RCV.NXT

But I spotted a second problem, might be minor:

Could you check what happened in line 2066 of this tcpdump?

in line 2064 static (2.2.18-pre17) ack'ed 1583721.
in line 2066 dynamic (Solaris 7.0) sends data although the window is 0
in line 2067 static complains, but now ack is 1583720

2060  16:31:42.879337 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
. 67580:67580(0) ack 1582261 win 1460 (DF)
2061  16:31:42.907940 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583721:1583721(0) ack 67580 win 1460 (DF)
2062  16:31:42.908620 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
. 67580:67581(1) ack 1583721 win 0 (DF)
2063  16:31:43.098761 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583721:1583721(0) ack 67581 win 1460 (DF)
2064  16:31:43.100993 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
P 67581:68456(875) ack 1583721 win 0 (DF)
2065  16:31:43.101524 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
P 68456:69041(585) ack 1583721 win 0 (DF)
2066  16:31:43.108759 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583720:1583720(0) ack 69041 win 0 (DF)
2067  16:31:43.110623 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
P 69041:69628(587) ack 1583721 win 0 (DF)
2068  16:31:43.110679 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583721:1583721(0) ack 69041 win 0 (DF)

An off-by-one error somewhere in tcp_send_ack()?
A second packet with the off-by-one ack number is send a few packets
later, all other packets are correct.
--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
