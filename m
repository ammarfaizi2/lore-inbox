Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBKSFF>; Sun, 11 Feb 2001 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbRBKSEz>; Sun, 11 Feb 2001 13:04:55 -0500
Received: from mhp.lightlink.com ([205.232.34.247]:12037 "EHLO
	mhp.lightlink.com") by vger.kernel.org with ESMTP
	id <S129190AbRBKSEn>; Sun, 11 Feb 2001 13:04:43 -0500
Date: Sun, 11 Feb 2001 14:18:51 -0500 (EST)
From: Max Parke <mhp@lightlink.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.x: TCP lockups with tcp_timestamps
Message-ID: <Pine.LNX.4.10.10102111408530.11634-100000@mhp.lightlink.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TCP connections between two machines (both running Linux 2.2.x) are
freezing.  If /proc/sys/net/ipv4/tcp_timestamps is set to 0, the
problem disappears.

Machine (IP address 1.2.3.4) is running kernel 2.2.13 and dials in
over an annoyingly high-latency PPP link via ordinary modems.

Machine (IP address 5.6.7.8) connects via a cable modem and is running
RH6.2 and kernel 2.2.14.

The problem is reproducible.  I've pasted a tcpdump trace, taken
from the 1.2.3.4 machine, below.  Also have the trace of the other
end if needed.  The application in this case is vpnd, but the problem
also seems to appear when using ssh and www, etc.

Note that things get stuck at seq # 16528...  By adding some printk's was
able to determine that the following code in tcp_input.c is triggered, on
the 5.6.7.8 machine...
         * RFC1323: H1. Apply PAWS check first.
         */
        if (tcp_fast_parse_options(sk, th, tp)) {
                if (tp->saw_tstamp) {
                        if (tcp_paws_discard(tp, th, len)) {
----This gets hit --->>>        tcp_statistics.TcpInErrs++;
                   
Since there's an easy workaround, it apparently makes no difference to
me if it's ever fixed.  However, I'd be happy to supply information or
help in any way needed.

Max

[beginning part redacted, please notify if more info needed]
[also have trace of other end if needed]
20:29:34.730716 1.2.3.4.379 > 5.6.7.8.1053: P 16364:16468(104) ack 65097 win 31856 <nop,nop,timestamp 3397470 1679591> (DF)
20:29:35.115762 5.6.7.8.1053 > 1.2.3.4.379: . 65097:65097(0) ack 16468 win 32120 <nop,nop,timestamp 1679644 3397470> (DF)
20:29:35.155767 5.6.7.8.1053 > 1.2.3.4.379: P 65097:65157(60) ack 16468 win 32120 <nop,nop,timestamp 1679644 3397470> (DF)
20:29:35.155818 5.6.7.8.1053 > 1.2.3.4.379: P 65157:65211(54) ack 16468 win 32120 <nop,nop,timestamp 1679644 3397470> (DF)
20:29:35.175778 1.2.3.4.379 > 5.6.7.8.1053: . 16468:16468(0) ack 65211 win 31856 <nop,nop,timestamp 3397515 1679644> (DF)
20:29:35.179648 1.2.3.4.379 > 5.6.7.8.1053: P 16468:16528(60) ack 65211 win 31856 <nop,nop,timestamp 3397515 1679644> (DF)
20:29:35.535768 5.6.7.8.1053 > 1.2.3.4.379: P 65211:66288(1077) ack 16468 win 32120 <nop,nop,timestamp 1679644 3397470> (DF)
20:29:35.925800 1.2.3.4.379 > 5.6.7.8.1053: . 16528:16528(0) ack 66288 win 31856 <nop,nop,timestamp 3397590 1679644> (DF)
20:29:35.929720 1.2.3.4.379 > 5.6.7.8.1053: P 16528:16588(60) ack 66288 win 31856 <nop,nop,timestamp 3397590 1679644> (DF)
20:29:35.995781 5.6.7.8.1053 > 1.2.3.4.379: . 66288:66288(0) ack 16528 win 32120 <nop,nop,timestamp 1679687 3643345> (DF)
20:29:36.305771 5.6.7.8.1053 > 1.2.3.4.379: . 66288:66288(0) ack 16528 win 32120 <nop,nop,timestamp 1679760 3643345> (DF)
20:29:36.695769 5.6.7.8.1053 > 1.2.3.4.379: P 66288:67415(1127) ack 16528 win 32120 <nop,nop,timestamp 1679767 3643345> (DF)
20:29:36.702543 1.2.3.4.379 > 5.6.7.8.1053: P 16588:16648(60) ack 67415 win 31856 <nop,nop,timestamp 3397667 1679767> (DF)
20:29:36.923237 1.2.3.4.379 > 5.6.7.8.1053: P 16648:16752(104) ack 67415 win 31856 <nop,nop,timestamp 3397689 1679767> (DF)
20:29:37.215797 5.6.7.8.1053 > 1.2.3.4.379: . 67415:67415(0) ack 16528 win 32120 <nop,nop,timestamp 1679838 3643345> (DF)
20:29:37.225784 5.6.7.8.1053 > 1.2.3.4.379: . 67415:67415(0) ack 16528 win 32120 <nop,nop,timestamp 1679861 3643345> (DF)
20:29:37.225872 1.2.3.4.379 > 5.6.7.8.1053: P 16528:16648(120) ack 67415 win 31856 <nop,nop,timestamp 3397720 1679861> (DF)
20:29:37.830074 1.2.3.4.379 > 5.6.7.8.1053: P 16752:16856(104) ack 67415 win 31856 <nop,nop,timestamp 3397780 1679861> (DF)
20:29:37.835833 5.6.7.8.1053 > 1.2.3.4.379: . 67415:67415(0) ack 16528 win 32120 <nop,nop,timestamp 1679891 3643345> (DF)
20:29:38.105797 5.6.7.8.1053 > 1.2.3.4.379: . 67415:67415(0) ack 16528 win 32120 <nop,nop,timestamp 1679952 3643345> (DF)
20:29:38.635785 5.6.7.8.1053 > 1.2.3.4.379: P 66288:67415(1127) ack 16528 win 32120 <nop,nop,timestamp 1679972 3643345> (DF)
20:29:38.635869 1.2.3.4.379 > 5.6.7.8.1053: . 16856:16856(0) ack 67415 win 31856 <nop,nop,timestamp 3397861 1679972> (DF)
20:29:39.295770 5.6.7.8.1053 > 1.2.3.4.379: P 67415:68542(1127) ack 16528 win 32120 <nop,nop,timestamp 1680027 3643345> (DF)
20:29:39.302532 1.2.3.4.379 > 5.6.7.8.1053: P 16856:16916(60) ack 68542 win 31856 <nop,nop,timestamp 3397927 1680027> (DF)
20:29:39.515796 5.6.7.8.1053 > 1.2.3.4.379: . 68542:68542(0) ack 16528 win 32120 <nop,nop,timestamp 1680097 3643345> (DF)
20:29:39.650291 1.2.3.4.379 > 5.6.7.8.1053: P 16916:17020(104) ack 68542 win 31856 <nop,nop,timestamp 3397962 1680097> (DF)
20:29:40.325784 5.6.7.8.1053 > 1.2.3.4.379: . 68542:68542(0) ack 16528 win 32120 <nop,nop,timestamp 1680134 3643345> (DF)
20:29:41.545775 5.6.7.8.1053 > 1.2.3.4.379: P 67415:68542(1127) ack 16528 win 32120 <nop,nop,timestamp 1680266 3643345> (DF)
20:29:41.545865 1.2.3.4.379 > 5.6.7.8.1053: . 17020:17020(0) ack 68542 win 31856 <nop,nop,timestamp 3398152 1680266> (DF)
20:29:43.290905 1.2.3.4.379 > 5.6.7.8.1053: P 17020:17124(104) ack 68542 win 31856 <nop,nop,timestamp 3398326 1680266> (DF)
20:29:43.525801 5.6.7.8.1053 > 1.2.3.4.379: . 68542:68542(0) ack 16528 win 32120 <nop,nop,timestamp 1680498 3643345> (DF)
20:29:44.065769 5.6.7.8.1053 > 1.2.3.4.379: P 68542:69669(1127) ack 16528 win 32120 <nop,nop,timestamp 1680505 3643345> (DF)
20:29:44.072538 1.2.3.4.379 > 5.6.7.8.1053: P 17124:17184(60) ack 69669 win 31856 <nop,nop,timestamp 3398404 1680505> (DF)
20:29:44.285753 5.6.7.8.1053 > 1.2.3.4.379: . 69669:69669(0) ack 16528 win 32120 <nop,nop,timestamp 1680574 3643345> (DF)
20:29:46.005767 5.6.7.8.1053 > 1.2.3.4.379: P 68542:69669(1127) ack 16528 win 32120 <nop,nop,timestamp 1680715 3643345> (DF)
20:29:46.005851 1.2.3.4.379 > 5.6.7.8.1053: . 17184:17184(0) ack 69669 win 31856 <nop,nop,timestamp 3398598 1680715> (DF)
20:29:50.572142 1.2.3.4.379 > 5.6.7.8.1053: P 17184:17288(104) ack 69669 win 31856 <nop,nop,timestamp 3399054 1680715> (DF)
20:29:50.915801 5.6.7.8.1053 > 1.2.3.4.379: . 69669:69669(0) ack 16528 win 32120 <nop,nop,timestamp 1681235 3643345> (DF)
20:29:53.895781 5.6.7.8.1053 > 1.2.3.4.379: P 69669:70796(1127) ack 16528 win 32120 <nop,nop,timestamp 1681489 3643345> (DF)
20:29:53.902581 1.2.3.4.379 > 5.6.7.8.1053: P 17288:17348(60) ack 70796 win 31856 <nop,nop,timestamp 3399387 1681489> (DF)
20:29:54.155798 5.6.7.8.1053 > 1.2.3.4.379: . 70796:70796(0) ack 16528 win 32120 <nop,nop,timestamp 1681560 3643345> (DF)
20:29:55.825770 5.6.7.8.1053 > 1.2.3.4.379: P 69669:70796(1127) ack 16528 win 32120 <nop,nop,timestamp 1681679 3643345> (DF)
20:29:55.825857 1.2.3.4.379 > 5.6.7.8.1053: . 17348:17348(0) ack 70796 win 31856 <nop,nop,timestamp 3399580 1681679> (DF)
20:30:05.135307 1.2.3.4.379 > 5.6.7.8.1053: P 17348:17452(104) ack 70796 win 31856 <nop,nop,timestamp 3400510 1681679> (DF)
20:30:05.415830 5.6.7.8.1053 > 1.2.3.4.379: . 70796:70796(0) ack 16528 win 32120 <nop,nop,timestamp 1682683 3643345> (DF)
20:30:13.645759 5.6.7.8.1053 > 1.2.3.4.379: P 70796:71923(1127) ack 16528 win 32120 <nop,nop,timestamp 1683457 3643345> (DF)
20:30:13.653038 1.2.3.4.379 > 5.6.7.8.1053: P 17452:17512(60) ack 71923 win 31856 <nop,nop,timestamp 3401362 1683457> (DF)
20:30:14.015771 5.6.7.8.1053 > 1.2.3.4.379: . 71923:71923(0) ack 16528 win 32120 <nop,nop,timestamp 1683532 3643345> (DF)
20:30:15.385804 5.6.7.8.1053 > 1.2.3.4.379: P 70796:71923(1127) ack 16528 win 32120 <nop,nop,timestamp 1683650 3643345> (DF)
20:30:15.385890 1.2.3.4.379 > 5.6.7.8.1053: . 17512:17512(0) ack 71923 win 31856 <nop,nop,timestamp 3401536 1683650> (DF)
20:30:34.259550 1.2.3.4.379 > 5.6.7.8.1053: P 17512:17616(104) ack 71923 win 31856 <nop,nop,timestamp 3403423 1683650> (DF)
20:30:34.645803 5.6.7.8.1053 > 1.2.3.4.379: . 71923:71923(0) ack 16528 win 32120 <nop,nop,timestamp 1685593 3643345> (DF)
20:30:52.965776 5.6.7.8.1053 > 1.2.3.4.379: P 71923:73050(1127) ack 16528 win 32120 <nop,nop,timestamp 1687393 3643345> (DF)
20:30:52.972854 1.2.3.4.379 > 5.6.7.8.1053: P 17616:17676(60) ack 73050 win 31856 <nop,nop,timestamp 3405294 1687393> (DF)
20:30:53.215783 5.6.7.8.1053 > 1.2.3.4.379: . 73050:73050(0) ack 16528 win 32120 <nop,nop,timestamp 1687463 3643345> (DF)
20:30:54.595807 5.6.7.8.1053 > 1.2.3.4.379: P 71923:73050(1127) ack 16528 win 32120 <nop,nop,timestamp 1687572 3643345> (DF)
20:30:54.595900 1.2.3.4.379 > 5.6.7.8.1053: . 17676:17676(0) ack 73050 win 31856 <nop,nop,timestamp 3405457 1687572> (DF)
20:31:32.509104 1.2.3.4.379 > 5.6.7.8.1053: P 17676:17780(104) ack 73050 win 31856 <nop,nop,timestamp 3409248 1687572> (DF)
20:31:32.775765 5.6.7.8.1053 > 1.2.3.4.379: . 73050:73050(0) ack 16528 win 32120 <nop,nop,timestamp 1691417 3643345> (DF)
20:31:37.225814 1.2.3.4.379 > 5.6.7.8.1053: P 16528:16752(224) ack 73050 win 31856 <nop,nop,timestamp 3409720 1691417> (DF)
20:31:37.545800 5.6.7.8.1053 > 1.2.3.4.379: . 73050:73050(0) ack 16528 win 32120 <nop,nop,timestamp 1691897 3643345> (DF)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
