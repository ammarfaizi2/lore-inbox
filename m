Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTBSRiB>; Wed, 19 Feb 2003 12:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTBSRiB>; Wed, 19 Feb 2003 12:38:01 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:10640 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S261451AbTBSRh6>;
	Wed, 19 Feb 2003 12:37:58 -0500
Date: Wed, 19 Feb 2003 09:47:57 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030219174757.GA5373@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

About a year ago I wrote a tool to test for Ethernet duplex mismatches
based on a theory I had of "ping -f" not working very well for this due
to it being mostly synchronous in nature.  My idea was to send a small
number of packets all at once, and then wait for all of the responses. 
This would increase the chances that the link or links between the sender
and receiver would be both transmitting and receiving at the same time,
exploiting the duplex mismatch, and causing packet loss.

The program, "duplextest", can be found here:

	http://blue.netnation.com/sim/projects/duplextest/

Over the year, this program has been very useful in finding mismatches. 
However, I have noticed occasionally that it appears to be showing packet
loss in cases where there should be no packet loss.

Investigating this issue, I found that even a "tcpdump -n icmp" running
on the host being duplextested also reports that itself is not replying
to all of the ICMP packets.  The tcpdump shows more requests are coming
in than responses going out, exactly matching what duplextest sees
remotely.

Baffled by this, I did a bunch of testing and tried to narrow down which
servers were experiencing this problem.  A sweep of some of our server
blocks showed that only SMP boxes were having the problem; however, not
all SMP boxes were affected.

I tried to narrow down whether specific SMP CPUs were responsible for the
problem, and found that it tended to happen on some ASUS P2B-DS boards,
but then also found it happening on Intel Xeon boards, Tyan boards, etc.,
with PIIs, PIIIs, and Xeon CPUs.  We have a few SMP Athlons, but I
haven't seen any problems with them.

After some playing around, I decided to try binding the receiving NIC's
IRQ to one CPU with /proc/irq/x/smp_affinity.  After I did this, the
packet loss vanished!  I bound the NIC's IRQ it to the other CPU, and
packet loss was still gone.  As soon as I echoed "3" (both CPUs) back
into smp_affinity, the loss returned.

All of the problems I've seen are on servers with Intel EtherExpress Pro
100+ cards, but most of our servers have these cards cards, so it's hard
to tell if this is a factor.  I can see exactly the problem with both the
eepro100 driver and the e100 driver.

Another strange thing about this problem is that it seems to come and go. 
About a month ago, a development box was also having the problem, but now
it appears to have stopped.  I assumed the kernel version was perhaps the
reason, but placing the exact kernel image from the working box on
another box experiencing the problem did not cure the problem on the
broken box.  2.4.20 is running on most of the boxes which are seeing the
problem, but this problem has been happening for at least one year (I
noticed it when I first wrote duplextest).

It is difficult to reproduce this problem, but I am releasing duplextest
here in hopes that others will see the same issue.  It is very easy to
tell apart true duplex mismatches from this problem by running "tcpdump
-n icmp" on the remote box and seeing if it does indeed show that it is
responding to all requests (if so, the problem is likely duplex or on the
link layer).

The interfaces show no errors or overruns after the problem:

# ip -s -s link ls eth0
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:e0:81:02:c0:cb brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    2624545296 179127520 0       0       0       0      
    RX errors: length  crc     frame   fifo    missed
               0        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    212425629  133630424 0       0       0       0      
    TX errors: aborted fifo    window  heartbeat
               0        0       0       0      

I don't see any other explanation.  Does anybody else see this problem or
have any ideas?  The fact that "tcpdump -n icmp" on the receiving box
shows that the box itself is not responding to all ICMP ECHO packets is
strange.  As far as I can tell there is no rate limiting, so I don't see
any explanation for this.

Thanks,

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
