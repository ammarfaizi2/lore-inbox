Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTD2QmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 12:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbTD2QmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 12:42:11 -0400
Received: from newman.cs.purdue.edu ([128.10.2.6]:44199 "EHLO
	newman.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S262038AbTD2QmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 12:42:10 -0400
Date: Tue, 29 Apr 2003 11:54:27 -0500
From: Jae-Young Kim <jaykim@cs.purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel timer accuracy
Message-ID: <20030429165427.GA5923@punch.cs.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, I'm developing a kernel module that enforces filtered packets to
get delayed for a given short time. I'm using netfilter for packet
filtering and using mod_timer() for packet delay.

The kernel module holds packet buffer (skb) in a linked list and
waits until the timer expires. If the timer expires, the module
releases the packets.

What I'm struggling is about the accuracy of timer function. Since
default Linux timer interrupt frequency is set to 100 HZ, I know
the smallest timer interval is 10 msec. and the one jiffy tick is
also 10 msec. However, it looks like that there's a small amount of
error between real-time clock and jiffy tick.

In my experiment, (I set the 50msec timer for each packet and I sent
one packet in every second), if I set 5 jiffies (= 50 msec) for my
packet delay, the timer correctly executes the callback function
after 5 jiffy ticks, however, the actual real-time measurment shows the
packet delay varies between 40msec and 50msec. Even worse, the actual
delay time variation has a trend. Please see the following data.

pkt no.       jiffy      actual delay
----------------------------------------
1               5            50.2msec
...            ...             ...
300             5            45.1msec
...            ...             ...
500             5            41.6msec
...            ...             ...
566             5            40.6msec
567             5            40.4msec
568             5            50.3msec
569             5            50.3msec
...            ...             ...

Here, the packet delay starts from around 50msec, but gradually decreased
to 40msec, and then abruptly adjusted to 50msec. The same decrese-and-abruptly-
adjusted trend was repeated.

Is there any person have experienced the same problem? 
It looks like that the accuray below 10msec is not guaranteed, but I'd like to
know why this kind of trend happens (I initially thought the error should be 
randomly distributed between 40msec to 60msec) and how the kernel adjust 
the timer when the error term becomes over 10msec.


- Jay
