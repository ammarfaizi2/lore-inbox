Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUD0AcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUD0AcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUD0AcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:32:14 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:33291 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id S263609AbUD0AcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:32:10 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: odain2@mindspring.com
Subject: Strange packet capture benchmark results
Date: Mon, 26 Apr 2004 20:32:11 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org
Message-Id: <200404262032.12123.odain2@mindspring.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on a new packet capture technique and I was comparing it to 
existing techniques. I got some very strange results that I can't explain.  
Perhaps somebody on this list can help me out.

I wanted to determine how much time an application would have available to 
process packets at different capture rates if different capture techniques 
were used.  To test this I wrote a sender and a receiver application.  The 
sender application uses libnet and sends a packet (a TCP packet with a 4 byte 
payload for a total packet size of 58 bytes) and then goes into a busy-wait 
loop for a configurable amount of time.  When its done with the wait loop it 
sends the next packet and then enters the wait loop again.  Thus by changing 
the wait-loop length I can control the packet rate (a busy loop was used 
because usleep didn't provide enough granularity).

The receiver application uses libpcap.  When a packet is received it 
increments a counter and then goes into a wait loop.  When the wait loop is 
done it returns control to libpcap so another packet can be captured.  

To perform one experiment the sender application sends 500,000 packets with a 
fixed wait loop between sent packets so that packets are sent at a fairly 
fixed rate.  The receiver also uses a fixed wait loop time.  At the end of 
the experiment we look at the counter in the receiver application.  If all 
packets were received it should be 500,000.  However, if it is lower that 
indicates some packet loss.  By varying the receive wait loop time we can 
determine packet capture if a given amount of processing has to occur on each 
packet.  (I can provide source for both of these applications if anybody want 
to repeat the experiments).  The experiments were performed with the receiver 
running kernel 2.4.22 (Fedora core 1) on a Pentium III machine connected via 
crossover cable to the sending machine.  The receiver is using a Netgear 
GA622T gigabit ethernet card with the ns83820 driver.  No processes besides 
the receiver were running on the receiving machine.

So now on to the strange results:

With a send rate of 45,000 packets per second (21 Mbps) standard libcap 
captures 100% of the packets until the receive wait loop gets above 1,700 
iterations.  Above that the percent of packets captured drops steadily as 
expected.  However if we continue to increase the wait loop iterations above 
3,000 iterations performance begins to _improve_ and it keeps improving until 
we hit 6,000 iterations at which point it starts to decrease again.  Why 
would the percent of packets captured go _up_ as the amount of processing per 
packet increases?  This is very repeatable.  I rebooted the computer and 
tried this test 3 times and the result are the same.  Its possible that the 
issue is with libpcap, but I think the kernel is a more likely candidate.  
Here are the figures:

Receive Wait loop               Fraction of packets captured
1500                                  1
1600	                                 1
1700	                                 1
1800	                                 0.99
1900	                                 0.97
2000	                                 0.95
3000	                                 0.81
4000	                                 0.84
5000	                                 0.87
6000	                                 0.98
7000	                                 0.88
8000	                                 0.78
9000	                                 0.71
10000                                0.65

One more puzzle: I also compared standard packet capture to packet capture 
with Alexey's CONFIG_PACKET_MMAP kernel option and Phil Wood's modified 
libpcap which takes advantage of the ring buffer.  I used a buffer consisting 
of 256 rings (experiments with larger buffer sizes showed it didn't help to 
have larger buffers).  As expected the MMAP option allows you to do more work 
per packet without dropping any packets.  What's very strange is that once 
you start dropping some packets the CONFIG_PACKET_MMAP option can _hurt_ 
performance.  For example, when packets are sent at 167,000 packets per 
second (77 Mbps) standard libpcap starts dropping packets with any receive 
wait loop while the CONFIG_PACKET_MMAP option allows us to capture 100% of 
the packets until we get above 200 iterations.  However, when the receive 
wait loop is 1,400 iterations standard libcap captures 40% of the packets 
while the MMAP enabled libpcap only captures 30%.  Why would the MMAP option 
ever hurt performance?  This too is repeatable across many experiments with a 
reboot in between.  Here's the raw data:

Receive wait loop        libpap captured               MMAP_libpcap captured
5                               0.98                                1
10                             0.96                                1
50                             0.95                                1
100                           0.94                                1
200                           0.89                                1
300                           0.84                                0.97
400                           0.78                                0.97
500                           0.74                                0.91
600                           0.69                                0.77
700                           0.65                                0.66
800                           0.62                                0.63
900                           0.56                                0.5
1000                         0.52                                0.43
1100                         0.47                                0.38
1200                         0.44                                0.34
1300                         0.43                                0.32
1400                         0.4                                  0.3
1500                         0.4                                  0.29
1600                         0.39                                0.28
1700                         0.36                                0.26

To summarize I'm hoping somebody can help me explain 2 strange benchmark 
results:

1) Why does libpcap packet capture performance improve if the amount of 
processing per packet goes up?

2) Why does CONFIG_PACKET_MMAP sometimes hurt capture performance?

I'm not a subscriber to the kernel mailing list so please CC me on any 
response.

Thanks very much, 
Oliver Dain


 

