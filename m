Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJQK57>; Wed, 17 Oct 2001 06:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275709AbRJQK5k>; Wed, 17 Oct 2001 06:57:40 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:30598 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S275680AbRJQK5e>;
	Wed, 17 Oct 2001 06:57:34 -0400
Posted-Date: Wed, 17 Oct 2001 12:58:06 +0200
Date: Wed, 17 Oct 2001 12:58:05 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: lkml <linux-kernel@vger.kernel.org>
Subject: NET_PROFILE results for 2.4.12 [was sentto is slow]
In-Reply-To: <3BCD56A2.B5362224@loewe-komp.de>
Message-ID: <Pine.LNX.4.10.10110171254590.321-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In my previous posts I was thinking why my PII/375
system can't handle more than 25000 packet/s. I repaired
kernel's NET_PROFILEr and got an answer.
So that for curious, first gprof output of program doing
send/poll/recv of 200 byte packets loop on the loopback 
interface using PF_PACKET (total running time was 20 sec):
 49.67      9.93     9.93   549384     0.02     0.02  sendto
 17.71     13.47     3.54   549384     0.01     0.01  recv
 12.01     15.87     2.40   553784     0.00     0.00  poll

Now we compare them with kernel profile stats:
af_packet_send:          7876 ms
  nested dev_queue_xmit: 3714 ms
net_rx_action:           1464 ms
af_packet_recv:          411  ms

For send gprof tells 9930 ms and kernel 7876 so 2 sec in difference
is generic socket and system call handling overhead (and measure error).
The recv gproffed is 3540 ms, kernel 1464+411 so there is again about
2 sec overhead.

>From this analysis I can finally say that there is not error in my
netflow simulator :) but the 2.4 on PII/375 can handle up to 30000 pps
in userspace loop.
Without userspace overhead and not bouncing packets (like in my test)
the router based on 2.4 could handle about 70000 pps without qos,routing
and filtering overhead ..
Someone tested in real world ?

best regards, devik


