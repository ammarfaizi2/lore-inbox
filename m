Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272313AbRIONck>; Sat, 15 Sep 2001 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272314AbRIONcV>; Sat, 15 Sep 2001 09:32:21 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16875 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S272313AbRIONcR>; Sat, 15 Sep 2001 09:32:17 -0400
Date: Sat, 15 Sep 2001 22:32:16 +0900
Message-Id: <200109151332.WAA26034@asami.proc.flab.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
cc: naruse@flab.fujitsu.co.jp
Subject: [PATCH] Data is queued but not sent: tcp.c bug.
Reply-to: kumon@flab.fujitsu.co.jp
From: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We found a severe performance bug in the tcp layer of 2.2 series
kernel including latest 2.2.19.
 A patch is attached at the tail of this mail.

Details:
 When data is written to a connected TCP socket and if the written
size is between x1 and x1.5 of (MTU - 52), or x2 and x2.5, or x3 and
x3.5,,, the written data is not sent immediately, then ping-pong
latency with these size becomes several tens ms to several hundreds
ms.
 tcp_do_sendmsg() try to accumulate several iovec areas into one
packet and the logic has bug. simple write case is treated as iovec
with len=1.  If the total data size is more than (MTU-some_room), the
data is divided and the overflowed data is queued.  And finally, it is
*NOT* sent out and kept in a queue if the unsent size is less than
some threshold.

For example, MTU of the loopback in 2.2 seriese is 3924.
Using the following pseudo code:
	# this pseudo code omits residue data of read/write system calls.
	# sock1 and sock2 are connected by a TCP stream.
	Process A:
	for (;;) {
	    RECORD START_TIME
	    write(sock1, buf, dsize);
	    read(sock1, buf, dsize);
	    RECORD END_TIME
	    SHOW TIME_DIFF = END_TIME - START_TIME
	
	}
	Process B:
	for (;;) {
	    read(sock2, buf, dsize);
	    write(sock2, buf, dsize);
	}

If dsize <= 3872, TIME_DIFF is less than 170 us.
If 3872 < dsize < 5808, TIME_DIFF becomes 20 ms up to 1 s.  

The loopback device throughput downs to few KB/s, less than 1/1000 of
the normal.  Of course, this bug also hits normal ether-net devices.

If the dsize is less than the threshold, the data is sent immediately. 
This complicated our analysis.

2.4 kernel has been changed the tcp.c logic, so this bug exits only in
2.2.

Patch:
The following patch inhibits the last iovec area to be queued, and it
fixes the bug, but the structure of tcp.c is complicated and I feel it
as a collection of hacks, at least for the processing when and how the
fragmented packet is sent or not.  So, I have no convince this is a
right fix or not.

--- linux-2.2.19/net/ipv4/tcp.c.orig	Mon Mar 26 04:37:41 2001
+++ linux-2.2.19/net/ipv4/tcp.c	Sat Sep 15 12:45:53 2001
@@ -907,7 +907,7 @@
 			/* Determine how large of a buffer to allocate.  */
 			tmp = MAX_HEADER + sk->prot->max_header;
 			if (copy < min(mss_now, tp->max_window >> 1) &&
-			    !(flags & MSG_OOB)) {
+			    !(flags & MSG_OOB) && iovlen > 0) {
 				tmp += min(mss_now, tp->max_window);
 
 				/* What is happening here is that we want to


--
Software Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
