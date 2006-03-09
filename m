Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752083AbWCIXs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbWCIXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWCIXs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:48:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34698
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752075AbWCIXs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:48:28 -0500
Date: Thu, 09 Mar 2006 15:48:19 -0800 (PST)
Message-Id: <20060309.154819.104282952.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, shemminger@osdl.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060308125311.GE17618@mellanox.co.il>
References: <adaacc1raz9.fsf@cisco.com>
	<20060307.172336.107863253.davem@davemloft.net>
	<20060308125311.GE17618@mellanox.co.il>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Wed, 8 Mar 2006 14:53:11 +0200

> What I was trying to figure out was, how can we re-enable the trick
> without hurting TSO? Could a solution be to simply look at the frame
> size, and call tcp_send_delayed_ack if the frame size is small?

The change is really not related to TSO.

By reverting it, you are reducing the number of ACKs on the wire, and
the number of context switches at the sender to push out new data.
That's why it can make things go faster, but it also leads to bursty
TCP sender behavior, which is bad for congestion on the internet.

When the receiver has a strong cpu and can keep up with the incoming
packet rate very well and we are in an environment with no congestion,
the old code helps a lot.  But if the receiver is cpu limited or we
have congestion of any kind, it does exactly the wrong thing.  It will
delay ACKs a very long time to the point where the pipe is depleted
and this kills performance in that case.  For congested environments,
due to the decreased ACK feedback, packet loss recovery will be
extremely poor.  This is the first reason behind my change.

The behavior is also specifically frowned upon in the TCP implementor
community.  It is specifically mentioned in the Known TCP
Implementation Problems RFC2525, in section 2.13 "Stretch ACK
violation".

The entry, quoted below for reference, is very clear on the reasons
why stretch ACKs are bad.  And although it may help performance for
your case, in congested environments and also with cpu limited
receivers it will have a negative impact on performance.  So, this was
the second reason why I made this change.

So reverting the change isn't really an option.

   Name of Problem
      Stretch ACK violation

   Classification
      Congestion Control/Performance

   Description
      To improve efficiency (both computer and network) a data receiver
      may refrain from sending an ACK for each incoming segment,
      according to [RFC1122].  However, an ACK should not be delayed an
      inordinate amount of time.  Specifically, ACKs SHOULD be sent for
      every second full-sized segment that arrives.  If a second full-
      sized segment does not arrive within a given timeout (of no more
      than 0.5 seconds), an ACK should be transmitted, according to
      [RFC1122].  A TCP receiver which does not generate an ACK for
      every second full-sized segment exhibits a "Stretch ACK
      Violation".

   Significance
      TCP receivers exhibiting this behavior will cause TCP senders to
      generate burstier traffic, which can degrade performance in
      congested environments.  In addition, generating fewer ACKs
      increases the amount of time needed by the slow start algorithm to
      open the congestion window to an appropriate point, which
      diminishes performance in environments with large bandwidth-delay
      products.  Finally, generating fewer ACKs may cause needless
      retransmission timeouts in lossy environments, as it increases the
      possibility that an entire window of ACKs is lost, forcing a
      retransmission timeout.

   Implications
      When not in loss recovery, every ACK received by a TCP sender
      triggers the transmission of new data segments.  The burst size is
      determined by the number of previously unacknowledged segments
      each ACK covers.  Therefore, a TCP receiver ack'ing more than 2
      segments at a time causes the sending TCP to generate a larger
      burst of traffic upon receipt of the ACK.  This large burst of
      traffic can overwhelm an intervening gateway, leading to higher
      drop rates for both the connection and other connections passing
      through the congested gateway.

      In addition, the TCP slow start algorithm increases the congestion
      window by 1 segment for each ACK received.  Therefore, increasing
      the ACK interval (thus decreasing the rate at which ACKs are
      transmitted) increases the amount of time it takes slow start to
      increase the congestion window to an appropriate operating point,
      and the connection consequently suffers from reduced performance.
      This is especially true for connections using large windows.

   Relevant RFCs
      RFC 1122 outlines delayed ACKs as a recommended mechanism.

   Trace file demonstrating it
      Trace file taken using tcpdump at host B, the data receiver (and
      ACK originator).  The advertised window (which never changed) and
      timestamp options have been omitted for clarity, except for the
      first packet sent by A:

   12:09:24.820187 A.1174 > B.3999: . 2049:3497(1448) ack 1
       win 33580 <nop,nop,timestamp 2249877 2249914> [tos 0x8]
   12:09:24.824147 A.1174 > B.3999: . 3497:4945(1448) ack 1
   12:09:24.832034 A.1174 > B.3999: . 4945:6393(1448) ack 1
   12:09:24.832222 B.3999 > A.1174: . ack 6393
   12:09:24.934837 A.1174 > B.3999: . 6393:7841(1448) ack 1
   12:09:24.942721 A.1174 > B.3999: . 7841:9289(1448) ack 1
   12:09:24.950605 A.1174 > B.3999: . 9289:10737(1448) ack 1
   12:09:24.950797 B.3999 > A.1174: . ack 10737
   12:09:24.958488 A.1174 > B.3999: . 10737:12185(1448) ack 1
   12:09:25.052330 A.1174 > B.3999: . 12185:13633(1448) ack 1
   12:09:25.060216 A.1174 > B.3999: . 13633:15081(1448) ack 1
   12:09:25.060405 B.3999 > A.1174: . ack 15081

      This portion of the trace clearly shows that the receiver (host B)
      sends an ACK for every third full sized packet received.  Further
      investigation of this implementation found that the cause of the
      increased ACK interval was the TCP options being used.  The
      implementation sent an ACK after it was holding 2*MSS worth of
      unacknowledged data.  In the above case, the MSS is 1460 bytes so
      the receiver transmits an ACK after it is holding at least 2920
      bytes of unacknowledged data.  However, the length of the TCP
      options being used [RFC1323] took 12 bytes away from the data
      portion of each packet.  This produced packets containing 1448
      bytes of data.  But the additional bytes used by the options in
      the header were not taken into account when determining when to
      trigger an ACK.  Therefore, it took 3 data segments before the
      data receiver was holding enough unacknowledged data (>= 2*MSS, or
      2920 bytes in the above example) to transmit an ACK.

   Trace file demonstrating correct behavior
      Trace file taken using tcpdump at host B, the data receiver (and
      ACK originator), again with window and timestamp information
      omitted except for the first packet:

   12:06:53.627320 A.1172 > B.3999: . 1449:2897(1448) ack 1
       win 33580 <nop,nop,timestamp 2249575 2249612> [tos 0x8]
   12:06:53.634773 A.1172 > B.3999: . 2897:4345(1448) ack 1
   12:06:53.634961 B.3999 > A.1172: . ack 4345
   12:06:53.737326 A.1172 > B.3999: . 4345:5793(1448) ack 1
   12:06:53.744401 A.1172 > B.3999: . 5793:7241(1448) ack 1
   12:06:53.744592 B.3999 > A.1172: . ack 7241
   12:06:53.752287 A.1172 > B.3999: . 7241:8689(1448) ack 1
   12:06:53.847332 A.1172 > B.3999: . 8689:10137(1448) ack 1
   12:06:53.847525 B.3999 > A.1172: . ack 10137

      This trace shows the TCP receiver (host B) ack'ing every second
      full-sized packet, according to [RFC1122].  This is the same
      implementation shown above, with slight modifications that allow
      the receiver to take the length of the options into account when
      deciding when to transmit an ACK.

   References
      This problem is documented in [Allman97] and [Paxson97].

   How to detect
      Stretch ACK violations show up immediately in receiver-side packet
      traces of bulk transfers, as shown above.  However, packet traces
      made on the sender side of the TCP connection may lead to
      ambiguities when diagnosing this problem due to the possibility of
      lost ACKs.
